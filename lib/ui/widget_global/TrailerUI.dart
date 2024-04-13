// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class trailerwatch extends StatefulWidget {
  var trailerytid;
  trailerwatch({this.trailerytid});

  @override
  State<trailerwatch> createState() => _trailerwatchState();
}

class _trailerwatchState extends State<trailerwatch> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoid = YoutubePlayer.convertUrlToId(widget.trailerytid);
    _controller = YoutubePlayerController(
      initialVideoId: videoid.toString(),
      flags: YoutubePlayerFlags(
        enableCaption: true,
        autoPlay: false,
        mute: false,
        // controlsVisibleAtStart: true,
        forceHD: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: YoutubePlayer(
        thumbnail: Image.network(
          "https://img.youtube.com/vi/" + widget.trailerytid + "/hqdefault.jpg",
          fit: BoxFit.cover,
        ),
        controlsTimeOut: Duration(milliseconds: 1500),
        aspectRatio: 16 / 9,
        controller: _controller,
        showVideoProgressIndicator: true,
        bufferIndicator: const Center(
          child: Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
          )),
        ),
        progressIndicatorColor: Colors.amber,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
              isExpanded: true,
              colors: ProgressBarColors(
                playedColor: Colors.white,
                handleColor: Colors.amber,
              )),
          RemainingDuration(),
          FullScreenButton(),
        ],
      ),
    );
  }
}
