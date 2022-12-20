class MemeModel {
  String? id, name, url;
  int? width, height, boxCount;
  
  MemeModel({
    this.id,
    this.name,
    this.url,
    this.width,
    this.height,
    this.boxCount,
  });

  MemeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
    boxCount = json['box_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    data['box_count'] = this.boxCount;
    return data;
  }
}