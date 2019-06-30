import 'package:flutter_gridview_app/model/database_helpers.dart';

class Photo {
  var id;
  String title;
  String description;
  String image;
  String dateajout;

  Photo({this.id, this.title, this.description, this.image, this.dateajout});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        id: json['id'],
        title: json['title'] as String,
        description: json['description'] as String,
        image: json['image'] as String,
        dateajout: json['dateajout'] as String);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnDescription: description,
      columnDateajout: dateajout,
      columnImage: image
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    description = map[columnDescription];
    title = map[columnTitle];
    dateajout = map[columnDateajout];
    image = map[columnImage];
  }
}
