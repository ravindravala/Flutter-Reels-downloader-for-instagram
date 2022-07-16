class InstaPostWithoutLogin {
  Graphql? graphql;

  InstaPostWithoutLogin({this.graphql});

  InstaPostWithoutLogin.fromJson(Map<String, dynamic> json) {
    graphql =
        json['graphql'] != null ? new Graphql.fromJson(json['graphql']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.graphql != null) {
      data['graphql'] = this.graphql!.toJson();
    }
    return data;
  }
}

class Graphql {
  ShortcodeMedia? shortcodeMedia;

  Graphql({this.shortcodeMedia});

  Graphql.fromJson(Map<String, dynamic> json) {
    shortcodeMedia = json['shortcode_media'] != null
        ? new ShortcodeMedia.fromJson(json['shortcode_media'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shortcodeMedia != null) {
      data['shortcode_media'] = this.shortcodeMedia!.toJson();
    }
    return data;
  }
}

class ShortcodeMedia {
  bool? hasAudio;
  String? videoUrl;
  bool? isVideo;

  ShortcodeMedia({this.hasAudio, this.videoUrl, this.isVideo});

  ShortcodeMedia.fromJson(Map<String, dynamic> json) {
    hasAudio = json['has_audio'];
    videoUrl = json['video_url'];
    isVideo = json['is_video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_audio'] = this.hasAudio;
    data['video_url'] = this.videoUrl;
    data['is_video'] = this.isVideo;
    return data;
  }
}
