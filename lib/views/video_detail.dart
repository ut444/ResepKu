import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../model/resep.dart';

class VideoDetail extends StatefulWidget {
  final Resep resep;
  VideoDetail({required this.resep});

  @override
  State<VideoDetail> createState() => _VideoDetailState(resep);
}

class _VideoDetailState extends State<VideoDetail> {
  final Resep resep;
  _VideoDetailState(this.resep);

  late YoutubePlayerController playerController;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId("${resep.videoUrl}");

    playerController = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false
      )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ondemand_video_rounded,size: 35,),                        
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10,100,10,0),
              child: YoutubePlayer(
                controller: playerController,
                showVideoProgressIndicator: true,
                onReady: () => debugPrint('Ready'),
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(
                    isExpanded: true,
                    colors: const ProgressBarColors(
                      playedColor: Colors.red,
                      handleColor: Colors.redAccent
                    ),
                  ),
                  const PlaybackSpeedButton()
                ],
                ),
            ),
          )
        ],
      ),
    );
  }
}