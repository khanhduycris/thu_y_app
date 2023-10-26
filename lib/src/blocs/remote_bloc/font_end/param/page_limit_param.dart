class PageLimitParam {
  int page;
  int limit;

  PageLimitParam({
    required this.page,
    required this.limit,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': this.page,
      'limit': this.limit,
    };
  }

  factory PageLimitParam.fromMap(Map<String, dynamic> map) {
    return PageLimitParam(
      page: map['page'] as int,
      limit: map['limit'] as int,
    );
  }
}
