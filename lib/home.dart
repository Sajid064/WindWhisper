import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File? _image;
  final picker = ImagePicker();
  String resultText = "Fetching Response...";

  Future<Map<String, dynamic>> queryImageCaption(File image) async {
    const String apiURL =
        "https://api-inference.huggingface.co/models/chriamue/bird-species-classifier";
    const String apiToken = "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";

    Uri uri = Uri.parse(apiURL);
    Map<String, String> headers = {"Authorization": "Bearer $apiToken"};

    try {
      List<int> data = await image.readAsBytes();
      var response = await http.post(uri, headers: headers, body: data);

      if (response.statusCode == 200) {
        // Parse the response body as JSON
        dynamic jsonResponse = json.decode(response.body);

        // Check if the response is a list
        if (jsonResponse is List<dynamic>) {
          // Handle list response accordingly, for example, return the first item
          String x = json.encode(jsonResponse[0]);
          String y = "";
          for (int i = 19; i < x.length - 2; i++) {
            y += x[i];
          }
          return {'caption': jsonResponse.isNotEmpty ? y : 'No caption'};
        } else if (jsonResponse is Map<String, dynamic>) {
          // Handle map response
          return jsonResponse;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return {'error': 'Failed to load data'};
    }
  }

  // pickImage() async {
  //   var image = await picker.pickImage(source: ImageSource.camera);
  //   if (image == null) {
  //     return null;
  //   }
  //   setState(() {
  //     _image = File(image.path);
  //     _loading = false;
  //   });
  // }
  Future<void> pickImage(ImageSource source) async {
    var pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _image = File(pickedImage.path);
      _loading = false;
    });

    // Query image caption when image is selected
    Map<String, dynamic> output = await queryImageCaption(_image!);

    setState(() {
      resultText = output['error'] != null
          ? 'Error: ${output['error']}'
          : 'Name: ${output['caption']}';
    });
  }

  Future<void> pickgalleryImage(ImageSource source) async {
    var pickedImage = await picker.pickImage(source: source);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _image = File(pickedImage.path);
      _loading = false;
    });

    // Query image caption when image is selected
    Map<String, dynamic> output = await queryImageCaption(_image!);

    setState(() {
      resultText = output['error'] != null
          ? 'Error: ${output['error']}'
          : 'Name: ${output['caption']}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.004, 1],
            colors: [Color(0x11232526), Color(0xFF232526)],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Wind',
                    style: TextStyle(
                      color: Color.fromRGBO(104, 202, 203, 1),
                      fontSize: 35,
                    ),
                  ),
                  const Text(
                    'Whisper',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              const Text(
                'Image to Bird Species Classifier',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 250,
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  color: const Color(0xFFFFFFFA),
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: _loading
                          ? SizedBox(
                              width: 500,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('images/hummingbird.gif'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Wind",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      104, 202, 203, 1),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Whisper",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: const Column(
                                      children: [
                                        // GestureDetector(
                                        //   onTap: () {},
                                        //   child: Container(
                                        //     // width: MediaQuery.of(context).size.width -
                                        //     //     300,
                                        //
                                        //     alignment: Alignment.center,
                                        //     padding: EdgeInsets.symmetric(
                                        //         horizontal: 24, vertical: 17),
                                        //     decoration: BoxDecoration(
                                        //       color: Color(0xFF093A3E),
                                        //       borderRadius:
                                        //           BorderRadius.circular(6),
                                        //     ),
                                        //     child: Text(
                                        //       'Live Camera',
                                        //       style: TextStyle(
                                        //         color: Colors.white,
                                        //         fontSize: 18,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await pickgalleryImage(
                                                ImageSource.gallery);
                                          },
                                          child: Container(
                                            // width: MediaQuery.of(context).size.width -
                                            //     300,

                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 17),

                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  104, 202, 203, 1),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: const Text(
                                              'From Gallery',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await pickgalleryImage(
                                                ImageSource.camera);
                                          },
                                          child: Container(
                                            // width: MediaQuery.of(context).size.width -
                                            //     300,

                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 17),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF202A25),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: const Text(
                                              'Take Photo',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    height: 200,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _loading = true;
                                                resultText =
                                                    "Fetching response...";
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              205,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              _image!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: Text(
                                      resultText,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
