
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/Social_user_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/modules/chats/chat_Screen.dart';
import 'package:social_app/modules/feeds/feeds_Screen.dart';
import 'package:social_app/modules/profile/profile_Screen.dart';
import 'package:social_app/modules/shared/cupit/states.dart';
import 'package:social_app/modules/shared/styles/colors.dart';
import 'package:social_app/modules/users/users_Screen.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage ;

import '../../../models/post_model.dart';
import '../../add_post/new_post.dart';

class SocialAppCubit extends Cubit<SocialAppState>
{
  SocialAppCubit() : super(SocialAppInitialState());

  static SocialAppCubit get(context)=>BlocProvider.of(context);

   SocialUserModel? userModel;

   void getUserData (){
    emit(SocialAppLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .get()
        .then((value) {
          print(value.data());
          userModel= SocialUserModel.fromJson(value.data()!);
          emit(SocialAppSuccessState());
       })
        .catchError((error)
    {
      print(error.toString());
      emit(SocialAppErrorState(error.toString()));

     } );
  }

  int currentIndex= 0;
   List<Widget>screens=
       [
        Feeds_Screen(),
        Chats_Screen(),
        AddPost_Screen(),
        Users_Screen(),
        Profile_Screen(),
       ];

  List<String> titles=
  [
    'Fake Book',
    'Chats',
    'Create Post',
    'Users',
    'Profile',
  ];


  void ChangBottonNav(int index) {
        if (index ==1 ){
          getUsers();
        }
        if (index ==4 ){
          getMyPosts();
        }
        currentIndex = index;
        emit(SocialChangBottomNavState());

  }


//Get Images From User
  File? profileImage ;
  var picker = ImagePicker();
  void getProfileImage() async
  {
    var image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null)
      {
        profileImage= File(image.path);
        emit(SocialAppPickImageSuccessState());
      }else
        {
          print('No Image Selected');
          emit(SocialAppPickImageErrorState());
        }
  }

  File? coverImage;
  void getCoverImage() async
  {
    var image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null)
    {
      coverImage= File(image.path);
      emit(SocialAppCoverImageSuccessState());
    }else
    {
      print('No Image Selected');
      emit(SocialAppCoverImageErrorState());
    }
  }

//Up loading Images TO Firebase
 void upLoadProfImage(
  {
    required phone,
    required name,
    required bio,
})

  {
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value){
          value.ref.getDownloadURL()
              .then((value){
                upDateUser(
                    phone: phone,
                    name: name,
                    bio: bio,
                   image: value
                );
            emit(SocialAppUpLoadProfileImageSuccessState());
          }).catchError((error){
                emit(SocialAppUpLoadProfileImageErrorState());
          });
    }).catchError((error){
      emit(SocialAppUpLoadProfileImageErrorState());
    });

  }

  void upLoadCoverImage(
  {
    required phone,
    required name,
    required bio,

})
  {
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
         value.ref.getDownloadURL()
          .then((value){
            emit(SocialAppUpLoadCoverImageSuccessState());
           upDateUser(
               phone: phone,
               name: name,
               bio: bio,
             cover: value,
           );
          }).catchError((error){
        emit(SocialAppUpLoadCoverImageErrorState());
      });
    }).catchError((error){
      emit(SocialAppUpLoadCoverImageErrorState());
    });

  }


//'https://i.pinimg.com/736x/c0/27/be/c027bec07c2dc08b9df60921dfd539bd.jpg'
//
// 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjt0Y_7jxcmPt4rzuRg5feMrvvPuVUY9T9oZcIYJ12yA6kFvaPAqZjUtHVm8V-ayg-fLs&usqp=CAU'


void upDateUser({
  required phone,
  required name,
  required bio,
  String? cover,
  String? image,
})
{
  SocialUserModel model = SocialUserModel(
    phone: phone,
    name: name,
    email: userModel!.email,
    uID: userModel!.uID,
    isEmailVir:FirebaseAuth.instance.currentUser!.emailVerified,
    image:image?? userModel?.image,
    cover:cover?? userModel?.cover,
    bio: bio,
  );
  FirebaseFirestore.instance
      .collection('users')
      .doc(userModel?.uID)
      .update(model.toMap())
      .then((value) {
    emit( SocialAppUpLoadProfileDataSuccessState());
    getUserData();
  })
      .catchError((error)
  {

  } );
}


//Create Post
    File? postImage;
  void getPostImage() async
  {
    var image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null)
    {
      postImage= File(image.path);
      emit(SocialPostImagePickedSuccessState());
    }else
    {
      print('No Image Selected');
      emit(SocialPostImagePickedErrorState());
    }
  }


  void uploadPostImage(
      {
        required text,
        required time,
      })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage
        .instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
            createPost(
                text: text,
                time: time,
                postImage: value,
            );
      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });

  }



  void createPost({
    required text,
    required time,
    String? postImage,
  })
  {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uID: userModel!.uID,
      image:userModel!.image,
      text: text,
      time: time,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
    })
        .catchError((error)
    {
      emit(SocialCreatePostErrorState());
    } );
  }

  void removePostImage(){
    postImage = null ;
    emit(SocialRemovePostImageState());
  }


  List<PostModel> posts = [];
  List<String> postId = [];
  List<int>likes =[];
  void getPosts()
  {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value)
    {
      value.docs.forEach((element) {
        element.reference.
            collection('likes')
        .get()
        .then((value){
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error){

        });

      });
      emit(SocialGetPostsSuccessState());
    }
    ).catchError((error)
    {
      SocialGetPostsErrorState(error.toString());
    });
  }


  void likePosts(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uID)
        .set({'like':true,})
    .then((value){
      emit(SocialPostsLikeSuccessState());
    })
    .catchError((error){
      emit(SocialPostsLikeErrorState());
    });
  }

  List<SocialUserModel>users=[];

  void getUsers()
  {
    users = [];
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            if (element.id != userModel?.uID)
              users.add(SocialUserModel.fromJson(element.data()));
          });
          emit(SocialGetAllUsersSuccessState());
    }).catchError((error)
    {
      SocialGetAllUsersErrorState(error.toString());
    });
  }

//Chat Functions

void sendMessage ({
    String? senderId,
   required String receiverId,
   required String dateTime,
   required String text,
}){
    MessageModel model = MessageModel(
        senderId: userModel!.uID,
        receiverId: receiverId,
        dateTime: dateTime,
        text:text,
    );
    //Set Sender Chat
    FirebaseFirestore.instance
    .collection('users')
    .doc(userModel?.uID)
    .collection('chat')
    .doc(receiverId)
    .collection('message')
    .add(model.toMap())
    .then((value){
      emit(SocialSendMessageSuccessState());
    }).catchError((error)
    {
      emit(SocialSendMessageErrorState());
    }
    );

    //Set Receiver Chat

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(userModel?.uID)
        .collection('message')
        .add(model.toMap())
        .then((value){
      emit(SocialReceiveMessageSuccessState());
    }).catchError((error)
    {
      emit(SocialReceiveMessageErrorState());
    }
    );
    getMessage(receiverId: receiverId);
}

List<MessageModel> message = [];
  void getMessage ({
    required String receiverId,
  })
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uID)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          message=[];
          event.docs.forEach((element) {
            message.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetMessageErrorState());
    });
  }



List<PostModel> MyPosts = [];

void getMyPosts(

    )
{
  emit(SocialGetMyPostsLoadingState());
  FirebaseFirestore.instance
      .collection('posts')
      .get()
      .then((value)
  {
    value.docs.forEach((element) {
      if (element.data().values.elementAt(1) == userModel?.uID){
          MyPosts.add(PostModel.fromJson(element.data()));
    }
    });
    emit(SocialGetMyPostsSuccessState());
  }
  ).catchError((error)
  {
    SocialGetMyPostsErrorState();
  });
}

}



