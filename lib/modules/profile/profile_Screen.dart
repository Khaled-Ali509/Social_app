import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/modules/shared/componants/componants.dart';
import 'package:social_app/modules/shared/cupit/app_cubit.dart';
import 'package:social_app/modules/shared/cupit/states.dart';
import 'package:social_app/modules/shared/styles/colors.dart';

import '../../models/post_model.dart';

class Profile_Screen extends StatelessWidget {
   Profile_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppState>(
      listener: (context , state){},
      builder: (context , state){
        var cupit = SocialAppCubit.get(context);
        var model = SocialAppCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
             //cover& profile Image...........
                Container(
                  height: 205.0,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children:[
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            width: double.infinity,
                            height: 170.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft:Radius.circular(4.0,),
                                topRight: Radius.circular(4.0,),

                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  model!.cover as String,
                                ),
                                fit: BoxFit.cover,
                              ),

                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 64.0,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius:60.0,
                            backgroundImage: NetworkImage(
                              model.image as String,
                            ),
                          ),
                        ),
                      ]
                  ),
                ),

                Align(
                  alignment:AlignmentDirectional.bottomEnd ,
                  child: Text(
                    model.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                ),
                SizedBox(height: 7.0,),
                Text(
                  model.bio,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '20',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18.0),
                              ),
                              Text(
                                'Post',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),

                      ),

                      Expanded(
                        child:
                        InkWell(
                          child: Column(
                            children: [
                              Text(
                                '1398',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18.0),
                              ),
                              Text(
                                'Follower',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),

                      ),
                      Expanded(
                        child:
                        InkWell(
                          child: Column(
                            children: [
                              Text(
                                '50',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18.0),
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),

                      ),


                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child:ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(8.0),
                          backgroundColor: defultColore.withOpacity(.5),
                          minimumSize: Size(double.infinity, 35.0),
                        ),
                        onPressed: () {
                          navigateFinish(context, Login_Screen());
                          uID= null;
                          },
                        child: Text(
                          'Log Out',
                          style:TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    OutlinedButton(
                      onPressed: (){
                        navigateTo(context, EditProfile_Screen());
                      },
                      child: Icon(IconBroken.Edit),
                    ),

                  ],
                ),
                SizedBox(height: 7.0,),
                if (cupit.MyPosts.isNotEmpty)
                  ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context , index)=>buildMyPostItem(cupit.MyPosts[index] , context , index ),
                  separatorBuilder:(context , index)=>const SizedBox(height: 5.0,),
                  itemCount: cupit.posts.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
   Widget buildMyPostItem(PostModel model ,context,index )=>Card(
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
                           style: Theme.of(context).textTheme.titleLarge?.copyWith(
                             height: 1.4,
                           ),
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
               height: 1.0,
               color: Colors.grey[300],
             ),
           ),
           Text(
             '${model.text}',
             style: Theme.of(context).textTheme.titleMedium?.copyWith(),
           ),
           /*Container(
            width: double.infinity,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [

                Container(
                  height: 27.0,
                  child: MaterialButton(
                    onPressed: (){},
                    minWidth: 1.0,
                    padding: EdgeInsets.zero,
                    child: Text(
                      '#Free_palastine',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: defultColore,
                      ),
                    ),

                  ),
                ),
                Container(
                  height: 27.0,
                  child: MaterialButton(
                    onPressed: (){},
                    minWidth: 1.0,
                    padding: EdgeInsets.zero,
                    child: Text(
                      '#Free_palastine',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: defultColore,
                      ),
                    ),

                  ),
                ),

              ],
            ),
          ),*/
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
               height: 1.0,
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
