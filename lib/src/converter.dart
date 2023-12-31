import 'dart:io';
import 'package:image/image.dart';

String convertImage(FileSystemEntity selecetdFile, String formate) {
  final rawImage = (selecetdFile as File).readAsBytesSync();
  final Image? image = decodeImage(rawImage);
  var newImage;
  switch (formate) {
    case 'jpg':
      newImage = encodeJpg(image!);
    case 'png':
      newImage = encodePng(image!);
    default:
      stdout.writeln("Unsupported file type");
  }
  String newPathAfterConverting = replaceExtension(selecetdFile.path, formate);
  File(newPathAfterConverting).writeAsBytesSync(newImage);
  return newPathAfterConverting;
}

String replaceExtension(String path, String newExtension) {
  return path.replaceAll(RegExp(r'\.(png|jpg|jpeg)'), newExtension);
}
