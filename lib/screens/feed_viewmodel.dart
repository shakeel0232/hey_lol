import 'package:flutter/services.dart';
import 'package:hey_lol/vid/videos_firebase.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class FeedViewModel extends BaseViewModel {
  VideoPlayerController controller;
  VideosAPI videoSource;

  int prevVideo = 0;

  int actualScreen = 0;

  FeedViewModel() {
    videoSource = VideosAPI();
  }

  changeVideo(index) async {
    if (videoSource.listVideos[index].controller == null) {
      await videoSource.listVideos[index].loadController(index,await   videoSource.listVideos[index].video_url);
    }
    videoSource.listVideos[index].controller.play();
    prevVideo = index;
    notifyListeners();
    print(index);
  }

  void loadVideo(int index) async {
    await videoSource.listVideos[index].loadController(index,await videoSource.listVideos[index].video_url);
    notifyListeners();
  }

  void setActualScreen(index) {
    actualScreen = index;
    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
