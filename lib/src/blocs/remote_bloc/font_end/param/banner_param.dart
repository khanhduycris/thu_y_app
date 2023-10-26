class BannerParam  {
  int? position;
  int? featured;

  BannerParam({
    this.position,
    this.featured,
  });

  Map<String, dynamic> toMap() {
    return {
      'position': this.position,
      'featured': this.featured,
    };
  }

  factory BannerParam.fromMap(Map<String, dynamic> map) {
    return BannerParam(
      position: map['position'] as int,
      featured: map['featured'] as int,
    );
  }
}