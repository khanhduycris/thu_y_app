class SignParam  {
  String email_or_phone;
  String? register_by;
  String name;
  String password;

  SignParam({
    required this.name,
    required this.email_or_phone,
    required this.password,
     this.register_by,
  });

  Map<String, dynamic> toMap() {
    return {
      'email_or_phone': this.email_or_phone,
      'register_by': this.register_by,
      'name': this.name,
      'password': this.password,
    };
  }

  factory SignParam.fromMap(Map<String, dynamic> map) {
    return SignParam(
      email_or_phone: map['email_or_phone'] as String,
      register_by: map['register_by'] as String,
      name: map['name'] as String,
      password: map['password'] as String,
    );
  }
}