import 'package:equatable/equatable.dart';

class ModelLocal extends Equatable{
  String? id;
  String? name;
  ModelLocal({this.id, this.name});

  ModelLocal.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}