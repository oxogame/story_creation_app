import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter/services.dart';
import '../../api/fetch_generated_api.dart';
import '../text_to_story/text_to_story.dart';

class ImageToText extends StatefulWidget {
  const ImageToText({super.key});

  @override
  State<StatefulWidget> createState() {
    return ImageToTextState();
  }
}

class ImageToTextState extends State<ImageToText>
    with SingleTickerProviderStateMixin {
  File? pingImageResult;
  String imageUrl = "";
  File? image;
  bool _isValid = false;

  String? imageToTextApiResponse;
  String? storyApiResponseFromText;

  late TabController tabController;
  TextEditingController imageUrlController = TextEditingController();

  @override
  void initState() {
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    super.initState();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final File imageTemp = File(image.path);
      setState(() => pingImageResult = imageTemp);
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: 'Failed to pick image: $e',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  circularProgressIndicator() {
    return Container(
      margin: const EdgeInsets.only(top: 60.0),
      child: const CircularProgressIndicator(),
    );
  }

  snapShotHasError(snapshot) {
    Center(
        child: Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        margin: null,
        child: Column(
          children: [
            const Text(
              'Error',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10.0),
            Text(
              '${snapshot.error}',
              style: const TextStyle(fontSize: 20.0, color: Colors.white),
            )
          ],
        ),
      ),
    ));
  }

  apiResponseNull() {
    Fluttertoast.showToast(
        msg: "There were no results.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  seeTheResult(snapshot) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 60.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shadowColor: Colors.blueAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
              minimumSize: const Size(70, 70), //////// HERE
            ),
            onPressed: () {
              setState(() {
                imageUrl = "";
                imageUrlController.clear();

                pingImageResult = null;
                imageUrl = "";
                image = null;
                _isValid = false;

                MaterialPageRoute pageWay =
                    MaterialPageRoute(builder: (BuildContext context) {
                  return TextToStory(response: snapshot.data!);
                });

                Navigator.push(context, pageWay);
              });
            },
            child: const Text("See the Result",
                style: TextStyle(fontSize: 20.0, color: Colors.white))),
      ),
    );
  }

  dataNotFound() {
    return const Text(
      'Data Not Found',
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );
  }

  reset(String type) {
    if (type == "image_url") {
      imageUrlController.clear();

      setState(() {
        imageUrl = "";
      });
    } else if (type == "picture_in_gallery_reset") {
      setState(() {
        pingImageResult = null;
      });
    }
  }

  elevatedButton(String actionType, MaterialColor elevatedButtonColor,
      String action, String? image) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: elevatedButtonColor,
        shadowColor: Colors.black87,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        minimumSize: actionType == "cancel"
            ? const Size(140, 50)
            : actionType == "reset" || actionType == "picture_in_gallery_reset"
                ? const Size(50, 50)
                : const Size(100, 50), //////// HERE
      ),
      onPressed: () async {
        if (actionType == "cancel") {
          imageUrlController.clear();

          setState(() {
            imageUrl = "";
          });
        } else if (actionType == "image_to_text") {
          if (imageUrlController.text == "") {
            Fluttertoast.showToast(
                msg: "Image Url Field is Required.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            try {
              var response =
                  await http.head(Uri.parse(imageUrlController.text));
              setState(() {
                _isValid = response.statusCode == 200;
              });

              if (_isValid == true) {
                setState(() {
                  imageUrl = imageUrlController.text;
                });
              }
            } catch (e) {
              setState(() {
                _isValid = false;
              });

              if (_isValid == false) {
                Fluttertoast.showToast(
                    msg: "Enter Valid Image Url",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          }
        } else if (actionType == "reset") {
          reset("image_url");
        } else if (actionType == "picture_in_gallery_reset") {
          reset("picture_in_gallery_reset");
        } else {
          Fluttertoast.showToast(
              msg: "Error",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: actionType == "reset" && image != null ||
              actionType == "picture_in_gallery_reset" && image != null
          ? Image(image: AssetImage(image), width: 30.0, height: 30.0)
          : Text(
              action,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17.0,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Scaffold(
            appBar: AppBar(
                title: Column(
                  children: [
                    const SizedBox(height: 4.0),
                    Text(
                      "Image To Text",
                      style: TextStyle(
                          fontSize: 25.0,
                          letterSpacing: 0.5,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: <Color>[
                                Color(0xffDA44bb),
                                Color(0xff8921aa)
                              ],
                            ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
                    )
                  ],
                ),
                bottom: TabBar(
                  controller: tabController,
                  indicatorColor: Colors.black87,
                  labelColor: Colors.black87,
                  tabs: const <Widget>[
                    Tab(
                      child: Text(
                        "Image Url",
                        style: TextStyle(fontSize: 19.0),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Picture in Gallery",
                        style: TextStyle(fontSize: 19.0),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 30.0),
                    child: const Image(
                        width: 38.0,
                        height: 38.0,
                        image: AssetImage("assets/image_to_text.png")),
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
            body: TabBarView(
              controller: tabController,
              children: [
                Center(
                  child: firstTab(),
                ),
                Center(child: secondTab())
              ],
            )),
        onRefresh: () async {
          pingImageResult = null;
          imageUrl = "";
          image = null;
          _isValid = false;
        });
  }

  // Tabs
  Widget firstTab() {
    return Container(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: imageUrlController,
                style: const TextStyle(fontSize: 20.0),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(
                      top: 24.0, right: 12.0, bottom: 24.0, left: 12.0),
                  //fillColor: Color.fromARGB(255, 209, 205, 205),
                  filled: true,
                  labelText: "Image Url",
                  border: OutlineInputBorder(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    elevatedButton("cancel", Colors.red, "Cancel", null),
                    elevatedButton(
                        "reset", Colors.blue, "reset", "assets/reset.png"),
                    elevatedButton(
                        "image_to_text", Colors.green, "Image To Text", null),
                  ],
                ),
              ),
              imageUrl != ""
                  ? FutureBuilder<String>(
                      future:
                          FetchGenerated.fetchGeneratedTextWithUrl(imageUrl),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return circularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return snapShotHasError(snapshot);
                        } else {
                          String promptForChatGPT = "";

                          imageToTextApiResponse = snapshot.data;
                          if (imageToTextApiResponse == null) {
                            apiResponseNull();
                          } else {
                            promptForChatGPT = imageToTextApiResponse!;
                          }

                          return imageToTextApiResponse != null
                              ? FutureBuilder(
                                  future: FetchGenerated.generateStory(
                                      promptForChatGPT),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return circularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return snapShotHasError(snapshot);
                                    } else {
                                      storyApiResponseFromText = snapshot.data;
                                      if (storyApiResponseFromText == null) {
                                        apiResponseNull();
                                        return const Text(
                                          "There were no results.",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black),
                                        );
                                      } else {
                                        return seeTheResult(snapshot);
                                      }
                                    }
                                  },
                                )
                              : dataNotFound();
                        }
                      },
                    )
                  : const SizedBox()
            ],
          ),
        ));
  }

  Widget secondTab() {
    return Container(
      margin: const EdgeInsets.only(
          top: 32.0, right: 16.0, bottom: 32.0, left: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shadowColor: Colors.black87,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minimumSize: const Size(220, 75), //////// HERE
              ),
              onPressed: () {
                pickImage();
              },
              child: const Text(
                'Pink Image',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17.0,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            elevatedButton("picture_in_gallery_reset", Colors.blue,
                "Image To Text", "assets/reset.png"),
            const SizedBox(
              height: 40.0,
            ),
            pingImageResult != null
                ? FutureBuilder<String>(
                    future: FetchGenerated.fetchGeneratedTextWithGallery(
                        pingImageResult),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return circularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return snapShotHasError(snapshot);
                      } else {
                        String promptForChatGPT = "";

                        storyApiResponseFromText = snapshot.data;
                        if (storyApiResponseFromText == null) {
                          apiResponseNull();
                        } else {
                          promptForChatGPT = storyApiResponseFromText!;
                        }

                        return storyApiResponseFromText != null
                            ? FutureBuilder(
                                future: FetchGenerated.generateStory(
                                    promptForChatGPT),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return circularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return snapShotHasError(snapshot);
                                  } else {
                                    storyApiResponseFromText = snapshot.data;
                                    if (storyApiResponseFromText == null) {
                                      apiResponseNull();
                                      return const Text(
                                        "There were no results.",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      );
                                    } else {
                                      return seeTheResult(snapshot);
                                    }
                                  }
                                },
                              )
                            : dataNotFound();
                      }
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
