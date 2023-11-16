
class SocialUserModel{

      late String name;
      late String email;
      late String phone;
      late String uID;
       String? image;
       String? cover;
      late String bio;
      late bool isEmailVir;

      SocialUserModel({
        required this.phone,
        required this.name,
        required this.email,
        required this.uID,
        required this.image,
        required this.cover,
        required this.bio,
        required this.isEmailVir,
});

      SocialUserModel.fromJson(Map<String , dynamic> json)
      {
        email=json['email'];
        name=json['name'];
        phone=json['phone'];
        uID=json['uID'];
        image=json['image'];
        cover=json['cover'];
        cover=json['cover'];
        bio=json['bio'];
        isEmailVir= json['isEmailVir'];
      }

      Map<String,dynamic> toMap()
      {
        return
          {
            'name':name,
            'email':email,
            'phone':phone,
            'uID':uID,
            'image':image,
            'cover':cover,
            'bio':bio,
            'isEmailVir':isEmailVir,
          };
      }

}