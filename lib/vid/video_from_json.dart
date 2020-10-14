class VideoFromJson {
  final String video_url;
  final String category;
  final String thumbnail_url;
  final String video_title;
  final String Video;
  final String id;
  final String likes;

  VideoFromJson({this.video_url, this.category, this.thumbnail_url,this.video_title, this.Video, this.id, this.likes});

  factory VideoFromJson.fromJson(Map<String, dynamic> json) {
    return VideoFromJson(
      video_url: json['video_url'],
      category: json['category'],
      thumbnail_url: json['thumbnail_url'],
      video_title: json['video_title'],
      Video: json['Video'],
      id: json['id'],
      likes: json['likes'],
    );
  }
}