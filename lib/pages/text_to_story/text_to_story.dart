import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../api/fetch_generated_api.dart';

class TextToStory extends StatefulWidget {
  final String response;
  const TextToStory({super.key, required this.response});

  @override
  State<StatefulWidget> createState() {
    return TextToStoryState();
  }
}

class TextToStoryState extends State<TextToStory> {
  final audioPlayer = AudioPlayer();

  elevatedButton(String actionType, String image) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shadowColor: Colors.black87,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          minimumSize: const Size(70, 50),
        ),
        onPressed: () async {
          if (actionType == "read_aloud") {
            try {
              Uint8List bytes =
                  await FetchGenerated.storyToSound(widget.response);
              await audioPlayer.play(BytesSource(bytes));
            } catch (e) {
              Fluttertoast.showToast(
                  msg: e.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else if (actionType == "pause") {
            await audioPlayer.pause();
          } else if (actionType == "resume") {
            await audioPlayer.resume();
          } else if (actionType == "copy") {
            Clipboard.setData(ClipboardData(text: widget.response)).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Story Copied to Your Clipboard')));
            });
          } else {
            Fluttertoast.showToast(
                msg: "Error",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: actionType == "read_aloud"
            ? Image(
                image: AssetImage(
                  image,
                ),
                width: 40.0,
                height: 40.0)
            : actionType == "pause"
                ? Image(
                    image: AssetImage(
                      image,
                    ),
                    width: 40.0,
                    height: 40.0)
                : actionType == "copy"
                    ? Image(
                        image: AssetImage(
                          image,
                        ),
                        width: 40.0,
                        height: 40.0)
                    : Image(
                        image: AssetImage(
                          image,
                        ),
                        width: 40.0,
                        height: 40.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            children: [
              const SizedBox(height: 4.0),
              Text(
                "Text To Story",
                style: TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 0.5,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
                      ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
              )
            ],
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 30.0),
              child: const Image(
                  width: 55.0,
                  height: 55.0,
                  image: AssetImage("assets/text_to_story.jpg")),
            )
          ],
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 72.0,
          toolbarOpacity: 0.8,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 5.00,
          backgroundColor: Colors.white // Colors.greenAccent[400],
          ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  elevatedButton("read_aloud", "assets/read_aloud.png"),
                  elevatedButton("pause", "assets/pause.png"),
                  elevatedButton("resume", "assets/resume.png"),
                  elevatedButton("copy", "assets/copy.png")
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                widget.response,
                style: const TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
