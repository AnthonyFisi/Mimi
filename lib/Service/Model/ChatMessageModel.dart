class ChatMessageModel{

  final String content;
  final String sender;

  ChatMessageModel(
  {this.content, this.sender});


  factory ChatMessageModel.fromJson(Map<String, dynamic> json){
    return ChatMessageModel(
      content: json['content'] as String,
      sender: json['sender'] as  String,

    );
  }
}