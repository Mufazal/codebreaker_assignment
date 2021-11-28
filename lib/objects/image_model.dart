class ImagesListObject {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  ImagesListObject(
      {this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  ImagesListObject.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  static List<ImagesListObject> getImagesList(List<dynamic> json) {
    List<ImagesListObject> list = [];

    for (var s in json) {
      list.add(ImagesListObject.fromJson(s));
    }
    return list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
