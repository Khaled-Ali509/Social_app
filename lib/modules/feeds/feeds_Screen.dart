
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/models/Social_user_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/shared/cupit/app_cubit.dart';
import 'package:social_app/modules/shared/cupit/states.dart';
import 'package:social_app/modules/shared/styles/colors.dart';

import '../shared/componants/componants.dart';

class Feeds_Screen extends StatelessWidget {
   Feeds_Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialAppCubit,SocialAppState>(
      listener: (BuildContext context, SocialAppState state){  },
      builder: (BuildContext context, SocialAppState state) {
        var cupit = SocialAppCubit.get(context);
        var model = cupit.userModel;
        return ConditionalBuilder(
          condition: cupit.posts.isNotEmpty && cupit.userModel != null,
          builder: (context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    margin: EdgeInsets.all(8.0),
                    child:Stack(
                      children:[
                        Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/close-up-portrait-nice-cute-adorable-smiling-charming-cheerful-girl-pointing-with-her-index-finger_176532-7923.jpg?w=740&t=st=1698060345~exp=1698060945~hmac=33a4dc15e5f1d91c0ec6bb2a752b63497462b0e164e490646f1d1ced1d76ef7c'
                          ),
                          width: double.infinity,
                          fit: BoxFit.fill,
                          height: 200.0,

                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Communicat with friends',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                              )
                          ),
                        ),
                      ],
                    ) ,
                  ),

                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context , index)=>buildPostItem(cupit.posts[index] , context , index),
                    separatorBuilder:(context , index)=>const SizedBox(height: 5.0,),
                    itemCount: cupit.posts.length,
                  ),


                ],
              ),
            );
          },
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },


    );

  }

}
