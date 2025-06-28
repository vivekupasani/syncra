import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
// import 'dart:html' as html;

import 'package:file_downloader_flutter/file_downloader_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:permission_handler/permission_handler.dart';

Future<String?> getDownloadPath() async {
  if (Platform.isAndroid) {
    Directory? directory = Directory('/storage/emulated/0/Download');
    if (await directory.exists()) {
      return directory.path;
    }
  }
  // For iOS or fallback, use documents directory
  Directory directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<void> requestStoragePermission() async {
  await Permission.storage.request();
}

Future<void> downloadFile({
  required Uint8List url,
  required String fileName,
}) async {
  try {
    // For Flutter Web only

    if (kIsWeb) {
      String mimeType = 'image/png';
      final base64Str = base64Encode(url);
      final dataUrl = 'data:$mimeType;base64,$base64Str';

      // final anchor = html.AnchorElement(href: dataUrl)
      //   ..download = fileName
      //   ..target = 'blank';
      // html.document.body!.append(anchor);
      // anchor.click();
      // anchor.remove();
    } else {
      // String mimeType = 'image/png';
      // final base64Str = base64Encode(url);
      // final dataUrl = 'data:$mimeType;base64,$base64Str';

      // FileDownloaderFlutter().urlFileSaver(
      //   url: dataUrl,
      //   fileName: " wallpaper by pixster",
      // );

      // print("downloaded");

      final result = await ImageGallerySaver.saveImage(url);
      print(result);
    }
  } catch (e) {
    print('Unexpected error: $e');
  }
}
