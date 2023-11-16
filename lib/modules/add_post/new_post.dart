import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:path/path.dart';
import 'package:social_app/modules/shared/componants/componants.dart';
import 'package:social_app/modules/shared/cupit/app_cubit.dart';
import 'package:social_app/modules/shared/cupit/states.dart';

class AddPost_Screen extends StatelessWidget {
   AddPost_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<SocialAppCubit , SocialAppState>
      (
      listener: (context,state){},
      builder: (context,state){
        var cubit =  SocialAppCubit.get(context);
        var model = cubit.userModel;
        return Scaffold(
          appBar: defulteAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              TextButton(
                  onPressed:  (){
                final now = DateTime.now();
                if (cubit.postImage == null){
                   cubit.createPost(
                    text: postTextController.text,
                    time: now.toString(),
                  );
                }
                else {
                  cubit.uploadPostImage(
                    text: postTextController.text,
                    time: now.toString(),
                  );
                }
              }, child: const Text(
                'Post',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,

                  )
              )
              )

            ],
          ) ,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(

              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                Row(
                  children: [
                    CircleAvatar(
                      radius:25.0,
                      backgroundImage:NetworkImage(model?.image as String,),
                    ),
                    SizedBox(width: 6.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${model?.name}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            height: 1.4,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 2.0,),
                        Text(
                          'New Post',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(height: 1.5),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0,),
                Expanded(
                  child: TextFormField(
                    controller: postTextController,
                    decoration: InputDecoration(
                      hintText: 'What is in your mind...',
                      hintStyle:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),

                  ),
                ),
                if (cubit.postImage !=null)
                  Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0,),
                        image: DecorationImage(
                          image:FileImage(cubit.postImage!) ,
                          fit: BoxFit.contain,
                        ),

                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.removePostImage();
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        radius: 20.0,
                        child:Icon(
                          IconBroken.Close_Square,
                          size: 19.0,
                        ),

                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed:(){
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5.0,),
                              Text('Add Photo'),
                            ],
                          )
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed:(){},
                        child:
                        Text('#Tags'),
                      ),
                    ),
                  ],
                )


              ],
            ),
          ),

        );
      },
    );

  }
  var postTextController = TextEditingController();

}
