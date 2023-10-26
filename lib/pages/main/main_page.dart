import 'package:flutter/material.dart';

import '../../drawer/main_page_drawer.dart';
import '../image_to_text/image_to_text.dart';

class Main extends StatefulWidget {
  final String? userEmail;
  const Main({super.key, this.userEmail});

  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<Main> {
  List<DropdownMenuItem> dropDownMenuItems = [];
  String selectVal = "Blog Section";

  List templates = [
    "Blog Section",
    "Image To Text",
    "Blog Ideas",
    "Tiktok Video Script",
    "Website About Us",
    "Social Media Post",
    "Blog Title",
    "Song Lyrisc"
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget dropDownButtonAction() {
    return DropdownButton(
      isExpanded: true,
      items: templates.map((template) {
        return DropdownMenuItem(value: template, child: Text(template));
      }).toList(),
      value: selectVal,
      onChanged: (dynamic newValue) {
        setState(() {
          selectVal = newValue;
        });
      },
      icon: const Image(
          image: AssetImage("assets/template.png"), width: 25.0, height: 25.0),
    );
  }

  cardWidget(String? text,
      {required String imagePath,
      required String title,
      required String numberOfCreations}) {
    return TextButton(
        onPressed: () {
          if (title == "Blog Section") {
            setState(() {
              selectVal = "Blog Section";
            });
          } else if (title == "Image To Text") {
            setState(() {
              selectVal = "Image To Text";
            });
          } else if (title == "Blog Ideas") {
            setState(() {
              selectVal = "Blog Ideas";
            });
          } else if (title == "TikTok Video Script") {
            setState(() {
              selectVal = "TikTok Video Script";
            });
          } else if (title == "Website About Us") {
            setState(() {
              selectVal = "Website About Us";
            });
          } else if (title == "Social Media Post") {
            setState(() {
              selectVal = "Social Media Post";
            });
          } else if (title == "Blog Title") {
            setState(() {
              selectVal = "Blog Title";
            });
          } else if (title == "Song Lyrisc") {
            setState(() {
              selectVal = "Song Lyrisc";
            });
          }
        },
        child: Card(
          elevation: 7,
          shadowColor: Colors.black,
          color: Colors.white,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                      width: 35.0,
                      height: 35.0,
                      image: AssetImage(imagePath)), //CircleAvatar
                  const SizedBox(
                    height: 15,
                  ), //SizedBox
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 15,
                  ), //SizedBox
                  text != null
                      ? Text(
                          text,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ), //Textstyle
                        )
                      : const SizedBox(
                          height: 20.0,
                        ), //Text
                  const SizedBox(
                    height: 20,
                  ), //SizedBox
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${numberOfCreations}k Words Generated",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ), //Textstyle
                      ),
                      const Image(
                          width: 17.0,
                          height: 17.0,
                          image: AssetImage("assets/null_heart.png"))
                    ],
                  )
                ],
              ), //Column
            ), //Padding
          ), //SizedBox
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            children: [
              const Text(
                "We Help You",
                style: TextStyle(fontSize: 21.0, color: Colors.black87),
              ),
              const SizedBox(height: 4.0),
              Text(
                "To Write Better Contents Faster",
                style: TextStyle(
                    fontSize: 21.0,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
                      ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
              )
            ],
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 90.2,
          toolbarOpacity: 0.8,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 5.00,
          backgroundColor: Colors.white // Colors.greenAccent[400],
          ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                margin: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 16.0,
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "All Templates",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: <Color>[
                                Color(0xffDA44bb),
                                Color(0xff8921aa)
                              ],
                            ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                    )),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: const Text(
                    "* Click on the template you want to select, then click the button below.", style: TextStyle(color: Colors.red),),
              ),
              const SizedBox(height:12.0),
              cardWidget(
                  "Write a blog section with the key points of your article",
                  imagePath: "assets/blog.png",
                  numberOfCreations: "740.843",
                  title: "Blog Section"),
              const SizedBox(height: 10.0),
              cardWidget(null,
                  imagePath: "assets/image_to_text.png",
                  numberOfCreations: "672.418",
                  title: "Image To Text"),
              const SizedBox(height: 10.0),
              cardWidget("Generate blog ideas for your next post",
                  imagePath: "assets/blog_ideas.png",
                  numberOfCreations: "46.631",
                  title: "Blog Ideas"),
              const SizedBox(height: 10.0),
              cardWidget(null,
                  imagePath: "assets/media_player.png",
                  numberOfCreations: "39.296",
                  title: "TikTok Video Script"),
              const SizedBox(height: 10.0),
              cardWidget(null,
                  imagePath: "assets/about_us.png",
                  numberOfCreations: "29.74",
                  title: "Website About Us"),
              const SizedBox(height: 10.0),
              cardWidget(null,
                  imagePath: "assets/like.png",
                  numberOfCreations: "25.669",
                  title: "Social Media Post"),
              const SizedBox(height: 10.0),
              cardWidget("Generate blog title for your next post",
                  imagePath: "assets/title.png",
                  numberOfCreations: "25.552",
                  title: "Blog Title"),
              const SizedBox(height: 10.0),
              cardWidget("Generate blog title for your next post",
                  imagePath: "assets/song.png",
                  numberOfCreations: "18.361",
                  title: "Song Lyrisc"),
              const SizedBox(height: 30.0),
              const Divider(),
              Container(
                margin: const EdgeInsets.only(left: 19.0, right: 27.0),
                child: dropDownButtonAction(),
              ),
              const SizedBox(height: 30.0),
              Container(
                margin: const EdgeInsets.only(bottom: 13.0),
                child: TextButton(
                    onPressed: () {
                      if (selectVal != "") {
                        redirectToRelevantPage(selectVal);
                      } else {
                        Widget cancelButton = TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              elevation: 2,
                              backgroundColor: Colors.blue),
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );

                        AlertDialog alert = AlertDialog(
                          title: const Text("Warning"),
                          content: const Text(
                              "You have to choose one of the templates."),
                          actions: [
                            cancelButton,
                          ],
                        );

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        elevation: 2,
                        backgroundColor: Colors.blue),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: "Start Creating Now ",
                              style: TextStyle(fontSize: 16.0)),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(IconData(0xe09b,
                                fontFamily: 'MaterialIcons',
                                matchTextDirection: true)),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
      drawer: MainPageDrawer(
        userEmail: widget.userEmail,
      ),
    );
  }

  redirectToRelevantPage(String selectedValue) {
    if (selectedValue == "Blog Section") {
      print("Tamamdır blog_section");
    } else if (selectedValue == "Image To Text") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ImageToText()),
      );
    } else if (selectedValue == "Blog Ideas") {
      print("Tamamdır blog_ideas");
    } else if (selectedValue == "Tiktok Video Script") {
      print("Tamamdır tiktok_video_script");
    } else if (selectedValue == "Website About Us") {
      print("Tamamdır website_about_us");
    } else if (selectedValue == "Social Media Post") {
      print("Tamamdır social_media_post");
    } else if (selectedValue == "Blog Title") {
      print("Tamamdır blog_title");
    } else if (selectedValue == "Blog Title") {
      print("Tamamdır song_lyrisc");
    }
  }
}
