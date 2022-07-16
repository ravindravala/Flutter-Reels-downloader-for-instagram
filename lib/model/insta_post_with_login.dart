class InstaPostWithLogin {
  List<Items>? items;

  InstaPostWithLogin({this.items});

  InstaPostWithLogin.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  List<VideoVersions>? videoVersions;

  Items({this.videoVersions});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['video_versions'] != null) {
      videoVersions = <VideoVersions>[];
      json['video_versions'].forEach((v) {
        videoVersions!.add(new VideoVersions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videoVersions != null) {
      data['video_versions'] =
          this.videoVersions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoVersions {
  int? type;
  int? width;
  int? height;
  String? url;
  String? id;

  VideoVersions({this.type, this.width, this.height, this.url, this.id});

  VideoVersions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['id'] = this.id;
    return data;
  }
}
