import 'package:flutter/material.dart';
import 'package:repair/Screens/main/videos/AllVideos.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/themes/theme_constants.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample video data
    final List<Map<String, String>> videoData = [
      {"title": "ByCycle", "thumbnail": AppIamges.repairbycycle},
      {"title": "Bike", "thumbnail": AppIamges.repairbike},
      {"title": "Car", "thumbnail": AppIamges.repaircar},
      {"title": "Other", "thumbnail": AppIamges.repairrother},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Videos"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(p),
        itemCount: videoData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to VideoListScreen and pass the category
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoListScreen(category: videoData[index]['title']!),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonradius),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(buttonradius),
                    child: Image.asset(
                      videoData[index]['thumbnail']!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 150, // Same as image height
                    decoration: BoxDecoration(
                      color:
                          blackColor.withOpacity(0.3), // Slight black overlay
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Positioned(
                    child: Text(
                      videoData[index]['title']!,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
