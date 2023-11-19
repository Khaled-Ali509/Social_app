
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/home_screen/home_screen.dart';
import 'package:social_app/modules/shared/componants/componants.dart';
import 'package:social_app/network/remot/cash_helper.dart';
import 'firebase_options.dart';
import 'modules/login_screen/login_screen.dart';
import 'modules/shared/componants/bloc_observe.dart';
import 'modules/shared/cupit/app_cubit.dart';
import 'modules/shared/cupit/states.dart';
import 'modules/shared/styles/const.dart';
import 'modules/shared/styles/themes.dart';



Future<void>onBackgroundMessage(RemoteMessage message)async
{
  print('on Background Message ');
  print(message.data.toString());
  showToast(msg: 'on Background Message' , state: ToastState.success);
}
Future<void> main()  async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  //test notifications////////////
  FirebaseMessaging.onMessage.listen((event) {
    showToast(msg: 'on Message' , state: ToastState.success);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    showToast(msg: 'on Message append' , state: ToastState.success);
  });
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

  Bloc.observer=MyBlocObserver();
  await CacheHelper.init();
  uID = CacheHelper.getData(key: 'uId');

  Widget widget;
  if (uID != null){
    widget=HomeScreen();
  }else {
    widget = Login_Screen();
  }
   bool? isDark;
  CacheHelper.getData(key: 'isDark') == null? isDark=false :isDark = CacheHelper.getData(key: 'isDark');
  runApp( MyApp(
      widget,
      isDark!,
  ));

}


class MyApp extends StatelessWidget {
 final Widget startWidget;
 final bool isDark;
 MyApp(
     this.startWidget,
     this.isDark
     );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(BuildContext context)=>SocialAppCubit()
          ..getUserData()
          ..getPosts()
          ..changeMode(fromShared:isDark),
        child: BlocConsumer<SocialAppCubit,SocialAppState>
        (
          listener: (BuildContext context, SocialAppState state) {  },
          builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThem,
            darkTheme: darkThem,
            themeMode:SocialAppCubit.get(context).isDark?ThemeMode.dark :ThemeMode.light ,
            home: Builder(
              builder: (context)
              {
                return startWidget;
              },
            ),
          );
        },
      ),
    );
  }
}