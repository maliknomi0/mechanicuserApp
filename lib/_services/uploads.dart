import 'dart:io';

import 'package:dio/dio.dart';

import 'app_services.dart';

final AppService appServices = AppService();

// ✅ Upload Image and Get URL
Future<String?> doUploadImage(File file) async {
  try {
    String fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${file.path.split("/").last}';

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    var response = await appServices.uploadImage(formData);

    if (response != null && response['success'] == true) {
      return response['data']['fileUrl']; // ✅ Return Image URL
    } else {
      print(
          '❌ Image upload failed: ${response?['message'] ?? "Unknown error"}');
      return null;
    }
  } catch (e) {
    print('❌ Error uploading image: $e');
    return null;
  }
}
