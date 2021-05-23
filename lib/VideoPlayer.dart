import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final String path;
  VideoPlayer(this.path);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late BetterPlayerController _betterPlayerController;

  var betterPlayerConfiguration = BetterPlayerConfiguration(
      autoPlay: true,
      looping: true,
      fit: BoxFit.fitHeight,
      autoDispose: true,
      aspectRatio: 1 / 5,
      overlay: Container());

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.file, widget.path);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration,
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              child: BetterPlayer(
                controller: _betterPlayerController,
              ),
            ),
            
            Positioned(
              top: 10,left: 10,
              child: ClipOval(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                    )),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
