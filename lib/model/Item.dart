class Photo {
  final int id;
  final String title;
  final String description;
  final String image;
  final String dateajout;

  Photo({this.id, this.title, this.description, this.image,this.dateajout});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      dateajout: json['dateajout'] as String
    );
  }
}