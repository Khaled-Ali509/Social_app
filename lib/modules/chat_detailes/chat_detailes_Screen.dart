import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/Social_user_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/modules/shared/cupit/app_cubit.dart';
import 'package:social_app/modules/shared/cupit/states.dart';
import 'package:social_app/modules/shared/styles/colors.dart';

class Chat_Details_Screen extends StatelessWidget {
  SocialUserModel userModel;
   Chat_Details_Screen({required this.userModel,});

  @override
  Widget build(BuildContext context) {
    return Builder(

     builder: (BuildContext context) {
       var cubit = SocialAppCubit.get(context);

       cubit.getMessage(
           receiverId: userModel.uID
       );
       return BlocConsumer<SocialAppCubit,SocialAppState>(
         listener: (context ,state) {},
         builder: (context ,state)
         {
           return Scaffold(
             appBar: AppBar(
               title: Row(
                 children: [
                   CircleAvatar(
                     radius: 20.0,
                     backgroundImage: NetworkImage(
                         '${userModel.image}'
                     ),
                   ),
                   SizedBox(width: 7.0,),
                   Text(
                     '${userModel.name}',
                     style: const TextStyle(
                       fontSize: 16.0,
                       fontWeight: FontWeight.bold,
                     ),
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                   ),
                 ],
               ),
               titleSpacing: 0.0,
             ),
             body: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
                 children: [
                   Expanded(
                     child: ConditionalBuilder(
                       condition: cubit.message.isNotEmpty,
                       builder: (BuildContext context) {
                         return ListView.separated(
                           itemBuilder: (context , index){
                             var message = cubit.message[index];
                             if (cubit.userModel?.uID ==message.senderId )
                               return buildMyMessage(context,message);
                             return buildMessage(context,message);
                           },
                           separatorBuilder: (context , index){
                             var message = cubit.message[index];
                             if (cubit.userModel?.uID !=message.senderId )
                               return SizedBox(height: 25.0,);
                             return SizedBox(height: 1.0,);
                           },
                           itemCount: cubit.message.length,
                         );
                       },
                       fallback: (BuildContext context)=>const Center(child: CircularProgressIndicator()),
                     ),
                   ),

                   Container(
                     clipBehavior: Clip.antiAliasWithSaveLayer,
                     decoration: BoxDecoration(
                       border: Border.all(
                           color: Colors.grey.shade300,
                           width: 1.0
                       ),
                       borderRadius: BorderRadius.circular(15.0),
                     ),
                     child: Row(
                       children: [
                         Expanded(
                           child: Padding(
                             padding: const EdgeInsets.symmetric(
                                 horizontal: 15.0),
                             child: TextFormField(
                               controller:messageController,
                               decoration: InputDecoration(
                                 hintText: 'type your message here....',
                                 border: InputBorder.none,
                               ),
                             ),
                           ),
                         ),
                         Container(
                           height: 50.0,
                           decoration: BoxDecoration(
                               color: defultColore.withOpacity(.1),
                               borderRadius:BorderRadiusDirectional.only(
                                 topEnd:Radius.circular(5.0),
                                 bottomEnd:Radius.circular(5.0),
                               )
                           ),

                           child: IconButton(

                             onPressed: (){
                               cubit.sendMessage(
                                 receiverId: userModel.uID,
                                 dateTime: DateTime.now().toString(),
                                 text: messageController.text,
                               );
                               messageController.clear();
                             },
                             icon:Icon(Icons.send,
                               color: defultColore,
                               size: 25.0,
                             ),
                           ),
                         ),
                       ],
                     ),
                   )

                 ],
               ),
             ),
           );
         },
       );
     },

    );
  }
  var messageController = TextEditingController();
  Widget buildMessage(context , MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topStart:Radius.circular(10.0) ,
            topEnd:Radius.circular(10.0) ,
            bottomEnd:Radius.circular(10.0) ,
          )
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 15.0,
      ),
      child: Text( model.text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ),
  );
  Widget buildMyMessage(context, MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: defultColore.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.only(
            topStart:Radius.circular(10.0) ,
            topEnd:Radius.circular(10.0) ,
            bottomStart:Radius.circular(10.0) ,
          )
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 15.0,
      ),
      child: Text(
        model.text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ),
  );
}
