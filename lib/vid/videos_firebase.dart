import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hey_lol/vid/video.dart';

import 'demo_data.dart';

class VideosAPI {
  List<Video> listVideos = List<Video>();

  VideosAPI() {
    load();
  }

  void load() async {
    listVideos = await getSqfliteData();
  }
  Future<List<Video>> getSqfliteData() async {
    // List<String> list;
    final tasks = await FlutterDownloader.loadTasksWithRawQuery(query: 'select * from task where status =3');
    tasks.toList().forEach((element) {
      Video video= new Video();
      video.id=element.taskId;
      video.video_title=element.filename;
      video.video_url=element.savedDir+'/'+element.filename;
      video.category=element.savedDir+'/'+element.filename;
      video.likes=element.savedDir+'/'+element.filename;
      video.thumbnail_url=element.savedDir+'/'+element.filename;
      listVideos.add(video);
    });

    print('listVideosSize'+listVideos.length.toString());
    return listVideos;
  }
  Future<List<Video>> getVideoList() async {
    var data = await FirebaseFirestore.instance.collection("Videos").get();

    var videoList = <Video>[];
    var videos;

    if (data.docs.length == 0) {
      await addDemoData();
      videos = (await FirebaseFirestore.instance.collection("Videos").get());
    } else {
      videos = data;
    }

    videos.docs.forEach((element) {
      Video video = Video.fromJson(element.data());
      videoList.add(video);
    });

    return videoList;
  }

  Future<Null> addDemoData() async {
    for (var video in data) {
      await FirebaseFirestore.instance.collection("Videos").add(video);
    }
  }
}
