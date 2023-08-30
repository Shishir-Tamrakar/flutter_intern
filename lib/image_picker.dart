import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  const ImagePick({super.key});

  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File? profileImage;
  File? coverImage;
  _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  _getFromGalleryCover() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        coverImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Upload Profile Image",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 209, 207, 207)),
            ),
            SizedBox(
              width: 20.0,
            ),
            MaterialButton(
                color: Color.fromARGB(255, 209, 207, 207),
                onPressed: () {
                  _getFromGallery();
                },
                child: Text('Choose file'))
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        profileImage == null
            ? Text(
                "Please Enter Profile Image",
                style: TextStyle(color: Color.fromARGB(255, 209, 207, 207)),
              )
            : Image.file(profileImage!),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            Text(
              "Upload Cover Image",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 209, 207, 207)),
            ),
            SizedBox(
              width: 20.0,
            ),
            MaterialButton(
                color: Color.fromARGB(255, 209, 207, 207),
                onPressed: () {
                  _getFromGalleryCover();
                },
                child: Text('Choose file'))
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        coverImage == null
            ? Text(
                "Please Enter Cover Image",
                style: TextStyle(color: Color.fromARGB(255, 209, 207, 207)),
              )
            : Image.file(coverImage!),
      ],
    );
  }
}
