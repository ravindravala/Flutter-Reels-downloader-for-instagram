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
  ImageVersions2? imageVersions2;

  Items({this.videoVersions, this.imageVersions2});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['video_versions'] != null) {
      videoVersions = <VideoVersions>[];
      json['video_versions'].forEach((v) {
        videoVersions!.add(new VideoVersions.fromJson(v));
      });
    }

    imageVersions2 = json["image_versions2"] == null
        ? null
        : ImageVersions2.fromJson(json["image_versions2"]);
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

class ImageVersions2 {
  final List<Candidate>? candidates;

  ImageVersions2({
    this.candidates,
  });

  factory ImageVersions2.fromJson(Map<String, dynamic> json) => ImageVersions2(
        candidates: json["candidates"] == null
            ? []
            : List<Candidate>.from(
                json["candidates"]!.map((x) => Candidate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "candidates": candidates == null
            ? []
            : List<dynamic>.from(candidates!.map((x) => x.toJson())),
      };
}

class Candidate {
  final int? width;
  final int? height;
  final String? url;

  Candidate({
    this.width,
    this.height,
    this.url,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        width: json["width"],
        height: json["height"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "url": url,
      };
}
