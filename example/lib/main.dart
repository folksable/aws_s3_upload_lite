import 'dart:io';

import 'package:aws_s3_upload_lite/enum/acl.dart';
import 'package:example/env/env.dart';
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

  void uploadImage() async {
    // pick a file from gallery
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    // upload the file to s3
    if (file != null) {
      String resp = await AwsS3.uploadFile(
          accessKey: Env.awsAccessKeyId,
          secretKey: Env.awsSecretAccessKey,
          file: File(file.path),
          bucket: Env.awsBucketName,
          region: Env.awsRegion,
          destDir:
              "", // The path to upload the file to (e.g. "uploads/public"). Defaults to the root "directory"
          filename: "dio_test_img.png", //The filename to upload as
          acl: ACL.private,
          contentType: 'image/png',
          headers: {
            "Content-Disposition": "inline"
          },
          useSSL: true,
          );
      setState(() {
        response = 'Status code: $resp';
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
              'Upload Progress',
            ),
            Text(
              response,
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: uploadImage,
        tooltip: 'Upload',
        child: const Icon(Icons.upload),
      ),
    );
  }
}