class ModelBanner {
  int? id;
  String? title;
  int? date;
  String? banner;
  //List<String>? position;
  int? featured;

  ModelBanner(
      {this.id,
        this.title,
        this.date,
        this.banner,
        //this.position,
        this.featured});

  ModelBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    banner = json['banner'];
   // position = json['position'].cast<String>();
    featured = json['featured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['banner'] = this.banner;
    //data['position'] = this.position;
    data['featured'] = this.featured;
    return data;
  }
}
