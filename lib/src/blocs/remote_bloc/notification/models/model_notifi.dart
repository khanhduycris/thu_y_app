class ModelNotifi {
  int? id;
  String? title;
  String? content;
  String? short_content;
  int? type;
  int? objectId;
  String? createdAt;
  String? updatedAt;

  ModelNotifi(
      {this.id,
        this.title,
        this.content,
        this.type,
        this.objectId,
        this.createdAt,
        this.short_content,
        this.updatedAt});

  ModelNotifi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    type = json['type'];
    objectId = json['object_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    short_content = json['short_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['type'] = this.type;
    data['object_id'] = this.objectId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['short_content'] = this.short_content;
    return data;
  }
}
