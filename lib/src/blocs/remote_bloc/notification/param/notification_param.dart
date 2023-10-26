class NotificationParam{
  int page;
  int limit;
  int type;

  NotificationParam({
    required this.page,
    required this.limit,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': this.page,
      'limit': this.limit,
      'type': this.type,
    };
  }

}