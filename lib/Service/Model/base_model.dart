abstract class BaseModel{}
class Message{

   int message;

  Message(this.message);

  factory Message.fromJson(dynamic json){
    return Message(
        json['message'] as int,

    );
  }
}