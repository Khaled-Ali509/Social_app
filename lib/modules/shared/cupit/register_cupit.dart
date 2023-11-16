import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/shared/cupit/states.dart';

import '../../../models/Social_user_model.dart';

class SocialAppRegisterCubit extends Cubit<SocialAppRegisterState>
{
  SocialAppRegisterCubit() : super(SocialAppRegisterInitialState());
  static SocialAppRegisterCubit get(context) => BlocProvider.of(context);




  void userRegister(
  {
    required String name,
    required String email,
    required String password,
    required String phone,
})
{

  emit(SocialAppRegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
  ).then((value)
      {
        emit(SocialAppRegisterSuccessState());
        userCreate(
            name: name,
            email: email,
            uId: value.user!.uid,
            phone: phone,);
      }
  ).catchError((error){
    emit(SocialAppRegisterErrorState(error.toString()));
  });
}



void userCreate({
  required String name,
  required String email,
  required String uId,
  required String phone,
})
{
  SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      email: email,
      uID: uId,
      isEmailVir:FirebaseAuth.instance.currentUser!.emailVerified,
      image: 'https://i.pinimg.com/736x/c0/27/be/c027bec07c2dc08b9df60921dfd539bd.jpg',
      cover: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjt0Y_7jxcmPt4rzuRg5feMrvvPuVUY9T9oZcIYJ12yA6kFvaPAqZjUtHVm8V-ayg-fLs&usqp=CAU',
      bio: 'Write your bio...',


  );
  FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .set(model.toMap())
      .then((value){
      emit(SocialAppCreateSuccessState());
      }).catchError((error){
        emit(SocialAppCreateErrorState(error.toString()));
        print(error.toString());
  });
}

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changPasswordVisibility()
  {
    isPassword =!isPassword;
    suffix = isPassword ? Icons.visibility_off :Icons.visibility_outlined;
    emit(SocialAppChangRPasswordVisibilityState());
  }


}