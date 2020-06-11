class ChatModel {
  final String imageUrl;
  final String name;
  final String message;

  ChatModel({this.imageUrl, this.name, this.message});

  factory ChatModel.decode(Map json) {
    return ChatModel(
        imageUrl: json['imageUrl'],
        name: json['nanme'],
        message: json['message']);
  }
}
