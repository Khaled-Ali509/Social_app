
class PostModel{

  late String name;
  late String uID;
  String? image;
  late String text;
  late String time;
  late String postImage;

  PostModel({
    required this.name,
    required this.uID,
    required this.image,
    required this.text,
    required this.time,
    required this.postImage,
  });

  PostModel.fromJson(Map<String , dynamic> json)
  {

    name=json['name'];
    uID=json['uID'];
    image=json['image'];
    text=json['text'];
    time=json['time'];
    postImage=json['postImage'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'name':name,
        'uID':uID,
        'image':image,
        'text':text,
        'time':time,
        'postImage':postImage,
      };
  }

}