class ModelNew {
  int? id;
  String? title;
  String? shortDescription;
  String? description;
  String? banner;
  String? createdAt;
  String? link;

  ModelNew(
      {this.id,
        this.title,
        this.shortDescription,
        this.description,
        this.banner,
        this.link,
        this.createdAt});

  ModelNew.fromJson(Map<String, dynamic> json) {
    id = json['ìd'];
    title = json['title'];
    link = json['link'];
    shortDescription = json['short_description'];
    description = json['description'];
    banner = json['banner'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ìd'] = this.id;
    data['title'] = this.title;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['banner'] = this.banner;
    data['created_at'] = this.createdAt;
    data['link'] = this.link;
    return data;
  }
}
