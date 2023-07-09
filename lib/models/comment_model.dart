class CommentModel
{
  String? name;
  String? postId;
  String? image;
  String? dateTime;
  String? textComment;
  String? imageComment;
  CommentModel({
    this.name,
    this.postId,
    this.image,
    this.dateTime,
    this.textComment,
    this.imageComment,
  });
  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postId = json['postId'];
    image = json['image'];
    dateTime = json['dateTime'];
    textComment = json['textComment'];
    imageComment = json['imageComment'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postId': postId,
      'image': image,
      'dateTime': dateTime,
      'textComment': textComment,
      'imageComment': imageComment,
    };
  }
}