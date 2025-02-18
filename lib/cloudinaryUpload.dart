import 'dart:convert';

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:cloudinary_url_gen/transformation/effect/effect.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';

var cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://${dotenv.env["CLOUDINARY_API_KEY"]}:${dotenv.env["CLOUDINARY_API_SECRET"]}@${dotenv.env["CLOUDINARY_USER_NAME"]}');

Future uploadCloud(image) async {
  cloudinary.config.urlConfig.secure = true;

  var base64Img = await image.readAsBytes();
  var type = image.mimeType!.split("/").last;
  var url = "data:image/${type};base64,${base64Encode(base64Img)}";

  var response = await cloudinary.uploader().upload(url);

  var image_url = response?.data?.secureUrl;
  return image_url;
}
