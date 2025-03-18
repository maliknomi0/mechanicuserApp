import 'package:flutter/material.dart';
import 'package:repair/themes/theme_constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerPage extends StatefulWidget {
  final String videoUrl;
  final String title;

  const YouTubePlayerPage(
      {super.key, required this.videoUrl, required this.title});

  @override
  _YouTubePlayerPageState createState() => _YouTubePlayerPageState();
}

class _YouTubePlayerPageState extends State<YouTubePlayerPage> {
  late YoutubePlayerController _controller;
  bool _isLoading = true; // Track loading state
  bool _isError = false; // Track error state

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      // Convert YouTube URL to video ID
      String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

      if (videoId != null) {
        // Initialize the YoutubePlayerController with the extracted video ID
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            isLive: false,
            controlsVisibleAtStart: true,
            hideThumbnail: true,
            forceHD: true,
            disableDragSeek: true,
          ),
        );
      } else {
        throw Exception("Invalid YouTube URL provided: ${widget.videoUrl}");
      }

      setState(() {
        _isLoading = false; // Player is ready
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isError = true; // Error occurred
      });
    }
  }

  @override
  void dispose() {
    if (!_isError) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' ${widget.title} Video ',
        ),
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(), // Show loading spinner
              )
            : _isError
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Please contact our time video not found \nThanks 😊",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: primaryColor,
                        progressColors: ProgressBarColors(
                          playedColor: primaryColor,
                          handleColor: primaryColor,
                        ),
                        onReady: () {
                          print("Player is ready.");
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
