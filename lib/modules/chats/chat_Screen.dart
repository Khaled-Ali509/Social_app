import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/Social_user_model.dart';
import 'package:social_app/modules/shared/componants/componants.dart';

import '../chat_detailes/chat_detailes_Screen.dart';
import '../shared/cupit/app_cubit.dart';
import '../shared/cupit/states.dart';

class Chats_Screen extends StatelessWidget {
  const Chats_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppState>(
        listener: (BuildContext context, SocialAppState state){  },
    builder: (BuildContext context, SocialAppState state) {
          var cubit = SocialAppCubit.get(context);
      return Scaffold(
       /* appBar: AppBar(
          title: Row(
            children: const [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('https://lh3.googleusercontent.com/-LNmVNtdn-yk/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucnDQRLeIMhQxUDJzQuJpMSRNZEzTw/photo.jpg?sz=46'),
              ),
              SizedBox(width: 15.0,),
              Text('Chat',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

              ),

            ],
          ),
          actions: [
            CircleAvatar(
              radius: 17.0,
              backgroundColor: Colors.deepPurple,
              child: IconButton( icon: const Icon(
                Icons.camera_alt,
                size: 16.0,
                color: Colors.white,
              ),
                onPressed: (){},),
            ),
            const SizedBox(width: 5.0,),
            CircleAvatar(
              radius: 17.0,
              backgroundColor: Colors.deepPurple,
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 16.0,
                  color: Colors.white,
                ),

                onPressed: (){},),
            )
          ],
        ),*/
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ConditionalBuilder(
              condition: cubit.users.isNotEmpty,
              builder: (context)=>SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black12,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: const [
                          Icon(Icons.search),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Search',

                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    //2.build list
                    /*SizedBox(
                  height: 90.0,
                  child: ListView.separated (
                    scrollDirection: Axis.horizontal,
                   //3.add item to list
                    itemBuilder: (context, index )=>buildStoryItem() ,
                    separatorBuilder: (context,index)=>const SizedBox( width: 15.0,) ,
                    itemCount: 15,
                  ),
                ),*/
                    ListView.separated(
                      physics:NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection:Axis.vertical,
                      itemBuilder:(context,index)=>buildChatItem(cubit.users[index], context),
                      separatorBuilder: (context,index)=>const SizedBox( height:15.0,),
                      itemCount: cubit.users.length,
                    ),
                  ],
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
    );
    }
// build Item
  Widget buildChatItem(SocialUserModel model , context)=>InkWell(
    onTap: (){
      navigateTo(context, Chat_Details_Screen(userModel: model,));
    },
    child: Row(
      children:[
        Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${model.image}'
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 4.0,
                  end: 3.0,
                ),
                child:
                CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.green,
                ),
              )
            ]
        ),
        const SizedBox(width: 10.0,),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                 Text(
                   model.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Hello my name is Khaled Ali HassanKhaled Ali HassanKhaled Ali HassanKhaled',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0
                      ),
                      child: Container(
                        width: 5.0,
                        height: 5.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Text
                      (
                      '02:00 pm',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ]
          ),
        )
      ]
),
  );
  Widget buildStoryItem()=>InkWell(
    onTap: (){},
    child: Container(
    width: 50.0,
    child: Column(
      children: [
        Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children:const [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('https://lh3.googleusercontent.com/-LNmVNtdn-yk/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucnDQRLeIMhQxUDJzQuJpMSRNZEzTw/photo.jpg?sz=46'),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 4.0,
                  end: 3.0,
                ),
                child:
                CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.green,
                ),
              )
            ]
        ),
        const SizedBox(height: 5.0,),
        const Text('Khaled Ali Hassan',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ],
    ),
),
  );
}
