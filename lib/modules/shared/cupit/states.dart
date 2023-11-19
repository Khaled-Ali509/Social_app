
abstract class SocialAppState{}

class SocialAppInitialState extends SocialAppState{}
class SocialAppLoadingState extends SocialAppState{}
class SocialAppSuccessState extends SocialAppState{}
class SocialAppErrorState extends SocialAppState{
  final String error;
  SocialAppErrorState(this.error);
}

class SocialChangBottomNavState extends SocialAppState{}
class SocialAddPostState extends SocialAppState{}

class SocialAppPickImageSuccessState extends SocialAppState{}
class SocialAppPickImageErrorState extends SocialAppState{
}

class SocialAppCoverImageSuccessState extends SocialAppState{}
class SocialAppCoverImageErrorState extends SocialAppState{
}


class SocialAppUpLoadProfileImageErrorState extends SocialAppState{
}
class SocialAppUpLoadProfileImageSuccessState extends SocialAppState{
}

class SocialAppUpLoadCoverImageErrorState extends SocialAppState{
}
class SocialAppUpLoadCoverImageSuccessState extends SocialAppState{
}
class SocialAppUpLoadProfileDataSuccessState extends SocialAppState {
}

//Create Post
class SocialCreatePostLoadingState extends SocialAppState{}
class SocialCreatePostSuccessState extends SocialAppState{}
class SocialCreatePostErrorState extends SocialAppState{
}


class SocialPostImagePickedSuccessState extends SocialAppState{}
class SocialPostImagePickedErrorState extends SocialAppState{
}


class SocialRemovePostImageState extends SocialAppState{}

//get posts
class SocialGetPostsLoadingState extends SocialAppState{}
class SocialGetPostsSuccessState extends SocialAppState{}
class SocialGetPostsErrorState extends SocialAppState{
  final String error;
  SocialGetPostsErrorState(this.error);
}
class SocialGetMyPostsLoadingState extends SocialAppState{}
class SocialGetMyPostsSuccessState extends SocialAppState{}
class SocialGetMyPostsErrorState extends SocialAppState{}


//get users
class SocialGetAllUsersLoadingState extends SocialAppState{}
class SocialGetAllUsersSuccessState extends SocialAppState{}
class SocialGetAllUsersErrorState extends SocialAppState{
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

//posts like
class SocialPostsLikeSuccessState extends SocialAppState{}
class SocialPostsLikeErrorState extends SocialAppState {
}

//Chat States

class SocialSendMessageSuccessState extends SocialAppState{}
class SocialSendMessageErrorState extends SocialAppState {
}
class SocialReceiveMessageSuccessState extends SocialAppState{}
class SocialReceiveMessageErrorState extends SocialAppState {
}
class SocialGetMessageErrorState extends SocialAppState {}

// Them Mood
class SocialAppCurrentMode extends SocialAppState{}
class SocialAppChangMode extends SocialAppState{}


//LoginStates

abstract class SocialAppLoginState{}
class SocialAppChangPasswordVisibilityState extends SocialAppLoginState{}
class SocialAppLoginInitialState extends SocialAppLoginState{}
class SocialAppLoginLoadingState extends SocialAppLoginState{}
class SocialAppLoginSuccessState extends SocialAppLoginState{
   final String uId;
  SocialAppLoginSuccessState(this.uId);
}
class SocialAppLoginErrorState extends SocialAppLoginState{

  final String error;
  SocialAppLoginErrorState(this.error);
}



////RegisterStates

abstract class SocialAppRegisterState{}
class SocialAppChangRPasswordVisibilityState extends SocialAppRegisterState{}
class SocialAppRegisterInitialState extends SocialAppRegisterState{}
class SocialAppRegisterLoadingState extends SocialAppRegisterState{}
class SocialAppRegisterSuccessState extends SocialAppRegisterState{}
class SocialAppRegisterErrorState extends SocialAppRegisterState{

  final String error;
  SocialAppRegisterErrorState(this.error);
}



class SocialAppCreateSuccessState extends SocialAppRegisterState{}
class SocialAppCreateErrorState extends SocialAppRegisterState{

  final String error;
  SocialAppCreateErrorState(this.error);
}

