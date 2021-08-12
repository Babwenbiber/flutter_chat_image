library chat_image;

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ChatImage extends StatefulWidget {
  final String url;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, String errorMsg) errorBuilder;
  final Widget Function(BuildContext context, Image image) imageBuilder;

  const ChatImage(
      {Key? key,
      required this.url,
      this.loadingBuilder,
      required this.errorBuilder,
      required this.imageBuilder})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _ChatImageState();
}

class _ChatImageState extends State<ChatImage> {
  File? file;
  String? errorMsg;
  @override
  void initState() {
    _loadImage();
    super.initState();
  }

  _loadImage() async {
    await _save();
    String? createdFile = await _getPath();
    if (createdFile != null) {
      setState(() {
        file = File(createdFile);
      });
    }
  }

  Future<Directory?> _getDir() {
    if (Platform.isAndroid) {
      return getExternalStorageDirectory();
    } else {
      return getApplicationDocumentsDirectory();
    }
  }

  String _getImageName() {
    final List<int> bytes = utf8.encode(widget.url);
    final Digest digest = sha1.convert(bytes);
    final String name = base64Encode(digest.bytes);
    return name;
  }

  Future<String?> _getPath() async {
    String name = _getImageName();
    Directory? appDocDir = await _getDir();
    if (appDocDir == null) {
      setState(() {
        errorMsg = "Appdirectory could not be accessed";
      });
      return null;
    }
    return appDocDir.path + "/" + name + ".jpg";
  }

  Future<void> _save() async {
    String? savePath = await _getPath();
    if (savePath == null) {
      setState(() {
        errorMsg = "Appdirectory could not be accessed";
      });
      return;
    }
    await Dio().download(widget.url, savePath);
    final result = await ImageGallerySaver.saveFile(savePath);

    print("saved imaged: $result");
  }

  @override
  Widget build(BuildContext context) {
    if (errorMsg != null) {
      return widget.errorBuilder(context, errorMsg!);
    }
    if (file == null) {
      if (widget.loadingBuilder != null) {
        return widget.loadingBuilder!(context);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }
    return widget.imageBuilder(context, Image.file(file!));
  }
}
