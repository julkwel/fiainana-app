class Photo {
  final int id;
  final String title;
  final String description;
  final String image;

  Photo({this.id, this.title, this.description, this.image});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }
}