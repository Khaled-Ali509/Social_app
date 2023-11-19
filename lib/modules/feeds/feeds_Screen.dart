
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/models/Social_user_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/shared/cupit/app_cubit.dart';
import 'package:social_app/modules/shared/cupit/states.dart';
import 'package:social_app/modules/shared/styles/const.dart';

import '../../adaptive/adaptive_indicator.dart';

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
          condition: cupit.posts.isNotEmpty && model != null,
          builder: (context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
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
          fallback: (context)=>  Center(child: Adaptive_Indicator(os: getOs())),
        );
      },


    );

  }
   Widget buildPostItem(PostModel model ,context,index )=>Card(
     //clipBehavior: Clip.antiAliasWithSaveLayer,
     elevation: 7.0,
     child: Padding(
       padding: const EdgeInsets.all(5.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             children: [
               CircleAvatar(
                 radius:30.0,
                 backgroundImage: NetworkImage(
                     '${model.image}'
                 ),
               ),
               SizedBox(width: 10.0,),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       children: [
                         Text(
                           '${model.name}',
                           style: Theme.of(context).textTheme.titleLarge?.copyWith( height: 1.4),
                           overflow: TextOverflow.ellipsis,
                           maxLines: 1,
                         ),
                         SizedBox(width: 2.0,),
                         Icon(
                           Icons.check_circle,
                           color: Colors.blue,
                           size: 15.0,
                         ),
                       ],
                     ),
                     Text(
                       '${model.time}',
                       style: Theme.of(context).textTheme.titleSmall?.copyWith(height: 1.5),
                     ),
                   ],
                 ),
               ),
               IconButton(
                 icon: Icon(Icons.more_horiz),
                 onPressed: (){},
               ),
             ],
           ),
           Padding(
             padding: const EdgeInsets.symmetric(
                 vertical: 11.0
             ),
             child: Container(

               width: double.infinity,
               height: .5,
               color: Colors.grey[300],
             ),
           ),
           Text(
             '${model.text}',
             style: Theme.of(context).textTheme.titleMedium?.copyWith(),
           ),

           if (model.postImage != '')
             Padding(
               padding: const EdgeInsets.only(
                 top: 10.0,
               ),
               child: Container(
                 height: 300.0,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(
                     4.0,
                   ),
                   image:DecorationImage(
                     fit: BoxFit.contain,
                     image: NetworkImage(
                         '${model.postImage}'
                     ),
                   ),
                 ),
               ),
             ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 InkWell(
                   child: Row(
                     children: [
                       Icon(
                         IconBroken.Chat,
                         color:Colors.grey ,
                         size: 20.0,
                       ),
                       SizedBox(width: 5.0,),
                       Text(
                         '94 Comment',
                         style: Theme.of(context).textTheme.titleSmall,
                       ),

                     ],
                   ),
                   onTap: (){},
                 ),
                 Spacer(),
                 InkWell(
                   child: Row(
                     children: [
                       Text(
                         '${SocialAppCubit.get(context).likes[index]}',
                         style: Theme.of(context).textTheme.titleSmall,
                       ),
                       SizedBox(width: 5.0,),
                       Icon(
                         IconBroken.Heart,
                         color:Colors.grey ,
                         size: 20.0,
                       ),
                     ],
                   ),
                   onTap: (){
                   },
                 ),
               ],
             ),

           ),
           Padding(
             padding: const EdgeInsets.only(
               bottom: 5.0,
             ),
             child: Container(

               width: double.infinity,
               height: .5,
               color: Colors.grey[300],
             ),
           ),
           Row(
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: InkWell(
                   child: Row(
                     children: [
                       CircleAvatar(
                         radius:20.0,
                         backgroundImage: NetworkImage(
                             '${SocialAppCubit.get(context).userModel?.image}'
                         ),
                       ),
                       SizedBox(width: 8.0,),
                       Text(
                         'Write a comment...',
                         style: Theme.of(context).textTheme.titleSmall,
                       ),

                     ],
                   ),
                   onTap: (){},
                 ),
               ),
               Spacer(),
               Padding(
                 padding: const EdgeInsets.only(
                   right: 25.0,
                 ),
                 child: InkWell(
                   child: Column(
                     children: [
                       Icon(
                         IconBroken.Heart,
                         color:Colors.grey ,
                         size: 25.0,
                       ),
                     ],
                   ),
                   onTap: (){
                     var cubit = SocialAppCubit.get(context);
                     cubit.likePosts(cubit.postId[index]);
                   },
                 ),
               ),
             ],
           ),


         ],
       ),
     ),

   );

}
