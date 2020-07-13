class New{
  String title;
  String content;
  String imageUrl;

  New({this.title, this.content, this.imageUrl});

  factory New.fromJson(Map<String, dynamic> json) {
    return New(
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}