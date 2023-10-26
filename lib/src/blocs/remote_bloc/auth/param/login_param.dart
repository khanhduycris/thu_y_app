class LoginParam {
  String phone;
  String pass;
  String? token_device;

  LoginParam({
    required this.phone,
    required this.pass,
    this.token_device,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': this.phone,
      'password': this.pass,
      'token_device': this.token_device,
    };
  }

  factory LoginParam.fromMap(Map<String, dynamic> map) {
    return LoginParam(
      phone: map['phone'] as String,
      pass: map['pass'] as String,
      token_device: map['token_device'] as String,
    );
  }
}
