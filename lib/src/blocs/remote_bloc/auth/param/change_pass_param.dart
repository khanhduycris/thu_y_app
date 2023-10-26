class ChangePassParam {
  String? phone;
  String? pass;
  String? old_pass;

  ChangePassParam({
    this.phone,
    this.pass,
    this.old_pass,
  });

  Map<String, dynamic> toMap() {
    if (phone != null) {
      return {
        'email_or_phone': this.phone,
        'password': this.pass,
      };
    }
    return {
      'new_password': this.pass,
      'old_password': this.old_pass,
    };
  }
}
