import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_example_pages/core/constants.dart';
import 'package:flutter_example_pages/view/widget/chewie_player.dart';
import 'package:flutter/material.dart';

Widget buildImage(String imageUrl, [double width = 350]) {
  // return Image(image: NetworkImage(imageUrl), width: width);
  return CachedNetworkImage(
    imageUrl: (imageUrl.startsWith("https://")) ? imageUrl : "${AppUrl.imagePrefix}/$imageUrl",
    progressIndicatorBuilder: (context, url, downloadProgress) {
      return CircularProgressIndicator(value: downloadProgress.progress);
    },
    errorWidget: (context, url, error) => const Icon(Icons.error),
    width: width,
  );
}

Widget buildAudio(String audioUrl) {

  return MomentChewiePlayer(
    videoUrl: "${AppUrl.audioPrefix}/$audioUrl",
  );
}

Widget buildVideo(String videoUrl) {
  return MomentChewiePlayer(
    videoUrl: "${AppUrl.videoPrefix}/$videoUrl",
  );
}
