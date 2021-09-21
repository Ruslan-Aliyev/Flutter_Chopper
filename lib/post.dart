class Post {
  final String title;
  final String body;

  Post({
    this.title,
    this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      body: json['body'],
    );
  }
}