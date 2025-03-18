// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:repair/controller/vidoeControllers.dart';

// class VideoListScreen extends StatefulWidget {
//   final String category;

//   const VideoListScreen({super.key, required this.category});

//   @override
//   _VideoListScreenState createState() => _VideoListScreenState();
// }

// class _VideoListScreenState extends State<VideoListScreen> {
//   final VideoController _videoController = VideoController();
//   final Dio _dio = Dio();
//   final TextEditingController _searchController = TextEditingController();

//   List<String> videoUrls = [];
//   List<String> filteredVideos = [];
//   Map<String, String> videoTitles = {};

//   // **Fetch videos from API**
//   void fetchVideos() async {
//     List<String> urls = await _videoController.fetchVideoUrls(widget.category);

//     setState(() {
//       videoUrls = urls;
//       filteredVideos = List.from(urls);
//     });

//     for (String url in urls) {
//       fetchVideoTitle(url).then((title) {
//         setState(() {
//           videoTitles[url] = title;
//         });
//       });
//     }
//   }

//   // **Extract YouTube Video ID from URL**
//   String extractVideoId(String url) {
//     Uri uri = Uri.parse(url);
//     if (uri.host.contains("youtu.be")) {
//       return uri.pathSegments.first;
//     } else if (uri.host.contains("youtube.com") &&
//         uri.queryParameters.containsKey("v")) {
//       return uri.queryParameters["v"]!;
//     }
//     return "";
//   }

//   // **Generate YouTube Thumbnail URL**
//   String getThumbnail(String url) {
//     String videoId = extractVideoId(url);
//     return "https://img.youtube.com/vi/$videoId/0.jpg";
//   }

//   // **Fetch Video Title using Dio**
//   Future<String> fetchVideoTitle(String url) async {
//     try {
//       Response response = await _dio.get(url);
//       if (response.statusCode == 200) {
//         String html = response.data;
//         RegExp regex = RegExp(r'<title>(.*?)</title>');
//         Match? match = regex.firstMatch(html);
//         if (match != null) {
//           return match.group(1)!.replaceAll(" - YouTube", "").trim();
//         }
//       }
//     } catch (e) {
//       print("Error fetching title: $e");
//     }
//     return "Unknown Title";
//   }

//   // **Search Function**
//   void _searchVideos(String query) {
//     setState(() {
//       filteredVideos = videoUrls
//           .where((url) =>
//               videoTitles[url]?.toLowerCase().contains(query.toLowerCase()) ??
//               false)
//           .toList();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchVideos();
//   }

//   // **Open YouTube Video**
//   Future<void> _launchURL(String url) async {
//     // Uncomment this if you have url launcher setup
//     // if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
//     //   throw "Could not launch $url";
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${widget.category} Videos"),
//       ),
//       body: Column(
//         children: [
//           // **Search Bar**
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: "Search videos",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: _searchVideos,
//             ),
//           ),
//           // **Video List**
//           Expanded(
//             child: filteredVideos.isEmpty
//                 ? Center(
//                     child: Text("No videos available for ${widget.category}"),
//                   )
//                 : ListView.builder(
//                     itemCount: filteredVideos.length,
//                     itemBuilder: (context, index) {
//                       String videoUrl = filteredVideos[index];
//                       String thumbnailUrl = getThumbnail(videoUrl);
//                       String title = videoTitles[videoUrl] ?? "Loading...";

//                       return Card(
//                         margin: const EdgeInsets.all(8),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: ListTile(
//                           leading: Image.network(
//                             thumbnailUrl,
//                             width: 100,
//                             fit: BoxFit.cover,
//                           ),
//                           title: Text(title),
//                           subtitle: Text(videoUrl),
//                           onTap: () {
//                             _launchURL(videoUrl);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:repair/Screens/main/videos/YouTubePlayerscreen.dart';
import 'package:repair/controller/vidoeControllers.dart';

class VideoListScreen extends StatefulWidget {
  final String category;

  const VideoListScreen({super.key, required this.category});

  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final VideoController _videoController = VideoController();
  final Dio _dio = Dio();
  final TextEditingController _searchController = TextEditingController();

  List<String> videoUrls = [];
  List<String> filteredVideos = [];
  Map<String, String> videoTitles = {};

  // **Fetch videos from API**
  void fetchVideos() async {
    try {
      List<String> urls =
          await _videoController.fetchVideoUrls(widget.category);

      setState(() {
        videoUrls = urls;
        filteredVideos = List.from(urls);
      });

      for (String url in urls) {
        fetchVideoTitle(url).then((title) {
          setState(() {
            videoTitles[url] = title;
          });
        });
      }
    } catch (e) {
      print("Error fetching videos: $e");
    }
  }

  // **Extract YouTube Video ID from URL**
  String extractVideoId(String url) {
    Uri uri = Uri.parse(url);
    if (uri.host.contains("youtu.be")) {
      return uri.pathSegments.first;
    } else if (uri.host.contains("youtube.com") &&
        uri.queryParameters.containsKey("v")) {
      return uri.queryParameters["v"]!;
    }
    return "";
  }

  // **Generate YouTube Thumbnail URL**
  String getThumbnail(String url) {
    String videoId = extractVideoId(url);
    return "https://img.youtube.com/vi/$videoId/0.jpg";
  }

  // **Fetch Video Title using Dio**
  Future<String> fetchVideoTitle(String url) async {
    try {
      Response response = await _dio.get(url,
          options: Options(responseType: ResponseType.plain));
      if (response.statusCode == 200) {
        String html = response.data.toString();
        RegExp regex = RegExp(r'<title>(.*?)</title>');
        Match? match = regex.firstMatch(html);
        if (match != null) {
          return match.group(1)!.replaceAll(" - YouTube", "").trim();
        }
      }
    } catch (e) {
      print("Error fetching title: $e");
    }
    return "Unknown Title";
  }

  // **Search Function**
  void _searchVideos(String query) {
    setState(() {
      filteredVideos = videoUrls
          .where((url) =>
              videoTitles[url]?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  // **Open YouTube Video**
  Future<void> _launchURL(String url, String title) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YouTubePlayerPage(title: title, videoUrl: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category} Videos"),
      ),
      body: Column(
        children: [
          // **Search Bar**
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search videos",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchVideos,
            ),
          ),
          // **Video List**
          Expanded(
            child: filteredVideos.isEmpty
                ? Center(
                    child: Text("No videos available for ${widget.category}"),
                  )
                : ListView.builder(
                    itemCount: filteredVideos.length,
                    itemBuilder: (context, index) {
                      String videoUrl = filteredVideos[index];
                      String thumbnailUrl = getThumbnail(videoUrl);
                      String title = videoTitles[videoUrl] ?? "Loading...";

                      return Card(
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: Image.network(
                            thumbnailUrl,
                            width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error);
                            },
                          ),
                          title: Text(title),
                          subtitle: Text(videoUrl),
                          onTap: () {
                            _launchURL(videoUrl, title);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
