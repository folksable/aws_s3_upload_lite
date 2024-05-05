import 'dart:io';

import 'package:flutter/material.dart';
import 'package:aws_s3_upload_lite/aws_s3_upload_lite.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S3 Upload Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'S3 Upload Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String response = "select an image to upload";

  void _incrementCounter() async {
    // pick a file from gallery
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    // upload the file to s3
    if (file != null) {
      String resp = await AwsS3.uploadFile(
          accessKey: "AKxxxxxxxxxxxxx",
          secretKey: "xxxxxxxxxxxxxxxxxxxxxxxxxx",
          file: File("path_to_file"),
          bucket: "bucket_name",
          region: "us-east-2",
          destDir:
              "", // The path to upload the file to (e.g. "uploads/public"). Defaults to the root "directory"
          filename: "x.png", //The filename to upload as
          metadata: {"test": "test"} // optional
          );
      setState(() {
        response = resp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              response,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
