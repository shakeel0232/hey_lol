import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hey_lol/screens/feed_screen.dart';
import 'package:hey_lol/vid/video_from_json.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _localPath, url;
  bool _permissionReady;
  @override
  void initState() {
    super.initState();
    _permissionReady = false;
    reqPermis();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Splash',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
  Future<bool> _checkPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        setState(() {
          _permissionReady=true;
        });
        return true;
      }
    } else {
      return true;
    }

    return false;
  }

  reqPermis() async{
    _permissionReady = await _checkPermission();
    if(_permissionReady){
      downloadVideos("5");
      Timer(
          Duration(seconds: 5),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => FeedScreen())));
    }
  }
  void downloadVideos(String noOfVideos) async {
    url = 'https://us-central1-heylol-c9d36.cloudfunctions.net/getAllData?no_of_videos=$noOfVideos';
    // to select a specific category
    // url = 'https://us-central1-heylol-c9d36.cloudfunctions.net/getAllData?no_of_videos=$noOfVideos&category='animal';
    _localPath = (await getExternalStorageDirectory()).path +
        Platform.pathSeparator +
        'DownloadedVideos';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    print(url);
    print(_localPath);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var v = jsonDecode(response.body) as List;
      List video_url = v
          .map((tagJson) => VideoFromJson.fromJson(tagJson).video_url)
          .toList();
      print(video_url.length);
      for (int i = 0; i < video_url.length; i++) {
        _localPath = (await getExternalStorageDirectory()).path +
            Platform.pathSeparator +
            'DownloadedVideos';
        await FlutterDownloader.enqueue(
            url: video_url[i],
            headers: {"auth": "sql_encoding"},
            fileName: 'heylol-' + (i + 1).toString() + '.mp4',
            savedDir: _localPath,
            showNotification: false,
            openFileFromNotification: false);
      }
    } else {
      print('data001Error ${response.statusCode}.');
    }
  }
}
