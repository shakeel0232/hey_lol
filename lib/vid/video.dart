import 'package:video_player/video_player.dart';
import 'dart:async';

class Video {
  String id;
  String video_title;
  String video_url;
  String category;
  String likes;
  String thumbnail_url;

  VideoPlayerController controller;

  Video(
      {this.id,
      this.video_title,
      this.video_url,
      this.category,
      this.likes,
      this.thumbnail_url});

  Video.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    video_title = json['video_title'];
    video_url = json['video_url'];
    category = json['category'];
    likes = json['likes'];
    thumbnail_url = json['thumbnail_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_title'] = this.video_title;
    data['video_url'] = this.video_url;
    data['category'] = this.category;
    data['likes'] = this.likes;
    data['thumbnail_url'] = this.thumbnail_url;
    return data;
  }

  Future<Null> loadController(int index, var url) async {
    print('url003' + url);
    controller = VideoPlayerController.network('file://' + url);
    await controller.initialize();
    controller.setLooping(true);
  }
}
