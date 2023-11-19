import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/shared/cupit/states.dart';
import 'package:social_app/network/remot/cash_helper.dart';

class SocialAppLoginCubit extends Cubit<SocialAppLoginState>
{
  SocialAppLoginCubit() : super(SocialAppLoginInitialState());
static SocialAppLoginCubit get(context) => BlocProvider.of(context);



  void userLogin(
      {
        required String email,
        required String password,
      })
  {

    emit(SocialAppLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value)
    {
      emit(SocialAppLoginSuccessState(value.user!.uid ));
    }
    ).catchError((error){
      print(error.toString());
      emit(SocialAppLoginErrorState(error.toString()));
    });
  }



IconData suffix = Icons.visibility_off_outlined;
bool isPassword = true;

void changPasswordVisibility()
{
  isPassword =!isPassword;
  suffix = isPassword ? Icons.visibility_off :Icons.visibility_outlined;
  emit(SocialAppChangPasswordVisibilityState());
}


}