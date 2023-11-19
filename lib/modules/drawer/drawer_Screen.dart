import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cupit/app_cubit.dart';
import '../shared/cupit/states.dart';

class Drawer_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialAppCubit,SocialAppState>(
      builder: ( context, state) {
        var cubit = SocialAppCubit.get(context);
        var model = cubit.userModel;
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  accountName:Text(model!.name) ,
                  accountEmail:Text(model.email) ,
                  currentAccountPicture:CircleAvatar(
                    backgroundImage: NetworkImage(
                      model.image as String,
                    ),
                  ),
                  currentAccountPictureSize: Size.square(80.0),
              ),
              Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.brightness_4_outlined,
                    color:cubit.isDark? Colors.white70:Colors.black45,
                    ),
                    title: Text('Dark Mood',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onTap: ()
                    {
                      cubit.changeMode();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_outlined,
                      color:cubit.isDark? Colors.white70:Colors.black45,
                    ),
                    title: Text('Logout',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onTap: ()
                    {
                      cubit.signOut(context);
                    },
                  ),

                ],
              ),

            ],
          ),
        );
      },

    );
  }
}
