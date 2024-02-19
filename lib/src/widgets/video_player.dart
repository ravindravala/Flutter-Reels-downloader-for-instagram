import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:uri_to_file/uri_to_file.dart';

class VideoPlayer extends StatefulWidget {
  final String path;
  VideoPlayer(this.path);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late CachedVideoPlayerController videoPlayerController;
  CustomVideoPlayerController? _customVideoPlayerController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _setupPlayer();
  }

  void _setupPlayer() async {
    File file = await toFile(widget.path);
    videoPlayerController = CachedVideoPlayerController.file(file)
      ..initialize().then((value) {
        _customVideoPlayerController = CustomVideoPlayerController(
          context: context,
          videoPlayerController: videoPlayerController,
        );
        setState(() {});
        videoPlayerController.play();
      });
  }

  @override
  void dispose() {
    _customVideoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: _customVideoPlayerController == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomVideoPlayer(
                      customVideoPlayerController:
                          _customVideoPlayerController!),
            ),
            Positioned(
                top: 10,
                left: 10,
                child: ClipOval(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
