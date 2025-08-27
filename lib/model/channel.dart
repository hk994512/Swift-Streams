class Channel {
  final String title;
  final String image;
  final String videoUrl;
  Channel({required this.title, required this.image, required this.videoUrl});
  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      title: json['title'] as String,
      image: json['image'] as String,
      videoUrl: json['videoUrl'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'title': title, 'image': image, 'videoUrl': videoUrl};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Channel && other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}
