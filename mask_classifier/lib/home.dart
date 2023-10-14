import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  late File _image;
  final imagepicker = ImagePicker();
  List _predictions = [];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  detect_image(File image) async {
    var prediction = await Tflite.runModeOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _predictions = prediction;
    });
  }

  _loadimage_gallery() async {
    var image = await imagepicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detect_image(_image);
  }

  _loadimage_camera() async {
    var image = await imagepicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detect_image(_image);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Mask Detection App',
        ),
      ),
      body: Container(
        height: h,
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/mask.jpeg'),
            ),
            Container(
              child: Text(
                'Mask Detection ',
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 70,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  _loadimage_camera();
                },
                child: Text("Camera"),
              ),
            ),
            Container(
              width: double.infinity,
              height: 70,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  _loadimage_gallery();
                },
                child: Text("Gallery"),
              ),
            ),
            _loading == false
                ? Container(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          child: Image.file(_image),
                        ),
                        Text(_predictions[0]['label'].toString().substring(2)),
                        Text('Confidence:' +
                            _predictions[0]['confidence'].toString())
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
