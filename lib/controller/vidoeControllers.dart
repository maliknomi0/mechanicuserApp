// import 'package:repair/_services/app_services.dart';

// class VideoController {
//   final AppService _appService = AppService();

//   Future<List<String>> fetchVideoUrls(String category) async {
//     try {
//       final response = await _appService.gervideosbycatagory(category);

//       if (response.statusCode == 200 && response.data["success"] == true) {
//         List<dynamic> videos = response.data["data"];

//         // Extract URLs
//         return videos.map((video) => video["url"].toString()).toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print("Error fetching videos: $e");
//       return [];
//     }
//   }
// }

import 'package:repair/_services/app_services.dart';

class VideoController {
  final AppService _appService = AppService();

  Future<List<String>> fetchVideoUrls(String category) async {
    try {
      // Assuming _appService.gervideosbycatagory returns a Map<String, dynamic>
      final Map<String, dynamic> response =
          await _appService.gervideosbycatagory(category);

      // Check if the response contains the expected data
      if (response["success"] == true) {
        List<dynamic> videos = response["data"];

        // Extract URLs
        return videos.map((video) => video["url"].toString()).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching videos: $e");
      return [];
    }
  }
}
