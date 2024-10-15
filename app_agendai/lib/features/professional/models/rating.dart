class Rating {

  final String id;
  final String comments;
  final int stars;
  final String username;

  const Rating({
    required this.id,
    required this.comments,
    required this.stars,
    required this.username,
  });


  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      id: map['id'] as String,
      comments: map['comments'] as String,
      stars: map['stars'] as int,
      username: map['userName'] as String,
    );
  }

}