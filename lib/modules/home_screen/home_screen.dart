import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/modules/add_post/new_post.dart';
import 'package:social_app/modules/notifecations/notifecations_screen.dart';
import 'package:social_app/modules/search/notifecations_screen.dart';
import 'package:social_app/modules/shared/componants/componants.dart';
import 'package:social_app/modules/shared/cupit/app_cubit.dart';
import 'package:social_app/modules/shared/cupit/states.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialAppCubit,SocialAppState>(
      listener:(context,state){
      } ,
        builder: (context,state)
        {
          var  home=SocialAppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                home.titles[home.currentIndex],
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context,Notifecations_Screen());
                  },
                  icon:Icon(IconBroken.Notification,),
                ),

                IconButton(
                  onPressed: (){
                    navigateTo(context, Search_Screen());
                  },
                  icon: Icon(
                    IconBroken.Search,
                  ),
                ),

              ],
            ),
            body:home.screens[home.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: home.currentIndex,
              onTap: (index){
                index== 2? navigateTo(context, AddPost_Screen()):home.ChangBottonNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon:Icon(IconBroken.Home,),
                  label: 'Home',
                ),
                BottomNavigationBarItem (
                  icon:Icon(IconBroken.Chat,),
                  label: 'Chat',
                ),
                BottomNavigationBarItem (
                  icon:Icon(IconBroken.Plus,),
                  label: 'New Post',
                ),
                BottomNavigationBarItem(
                  icon:Icon(IconBroken.User,),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Profile),
                  label: 'Profile',

                ),
              ],

            ),
          );

        },
    );
  }
}



/*ConditionalBuilder(
              condition:home.model !=null ,
              builder: (BuildContext context) {
                //var model = home.model;
                return Column(
                  children: [
                    if (!FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal:20.0,
                      ),
                      color: Colors.amber,
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                          ),
                          SizedBox(width: 5.0,),
                          Expanded(
                            child: Text(
                              'Please verify your Email.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width:15.0),

                          TextButton(

                            onPressed:() {
                              FirebaseAuth.instance.currentUser
                                  ?.sendEmailVerification()
                                  .then((value) {
                                showToast(
                                        msg: 'Check Your mail',
                                        state: ToastState.success);
                              })
                                  .catchError((error){
                                    print(error.toString());
                                    showToast(
                                        msg: 'Error',
                                        state: ToastState.error);
                              });
                            },
                            child:Text(
                              'Send',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0
                              ),

                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                );
              }, fallback: ( context)=>Center(child: CircularProgressIndicator()),
            ),*/