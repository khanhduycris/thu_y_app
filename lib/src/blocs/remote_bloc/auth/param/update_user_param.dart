class UpdateUserParam  {
  String? name;
  String? email;
  String? gender;
  String? birthday;

  UpdateUserParam({
     this.name,
     this.email,
     this.gender,
     this.birthday,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'gender': this.gender,
      'birthday': this.birthday,
    };
  }

  factory UpdateUserParam.fromMap(Map<String, dynamic> map) {
    return UpdateUserParam(
      name: map['name'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      birthday: map['birthday'] as String,
    );
  }
}
