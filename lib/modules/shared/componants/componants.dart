
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/models/Social_user_model.dart';

import '../../../models/post_model.dart';
import '../cupit/app_cubit.dart';
import '../styles/colors.dart';


//////////////////////////////////////////////////////////////////////////////////
void navigateTo(context , widget)=>Navigator.push(context, MaterialPageRoute(
  builder: (context)=>widget,),);
void navigateFinish(context , widget)=>Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(
      builder: (context)=>widget,
    ),
        (route) => false
);

/////////////////////////////////////////////////////////////////////////////////
Widget defaultFormField(
{
  required TextEditingController controller,
  required TextInputType type,
  required String label ,
  bool isPassword= false,
  Function? onSubmit,
  Function? onChang,
  Function? onTap,
  Function? validate,
  Function? suffixPressed,
  required IconData prefix,
  IconData? suffix,

})=>TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText:isPassword ,
  onFieldSubmitted: (s){
    onSubmit!(s);
  },
  validator: (s){
    return validate!(s);
  },
  decoration: InputDecoration(
    labelText:  label,
    prefixIcon:Icon(prefix),
    suffixIcon: suffix !=null ? IconButton(onPressed: (){suffixPressed!();}, icon: Icon(suffix),) : null,
    border: OutlineInputBorder(),

  ),


);


////////////////////////////////////////////////////////////////////////////////






void showToast({
   required String msg,
  required ToastState state,
})=>Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);


enum ToastState{ success , error , warning}
Color chooseColor(ToastState state){
  Color color;
  switch(state)
  {
    case ToastState.success:
      color= Colors.green;
      break;
    case ToastState.error:
      color= Colors.red;
      break;
    case ToastState.warning:
      color= Colors.amber;
      break;
  }
  return color;
}

//////////////////////////////////////////////////////////////////

Widget defultBotomn (
{
  required Function onPressed,
  required String text,
  double height=50.0,
}
){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.all(8.0),
      backgroundColor: defultColore,
      minimumSize: Size(double.infinity, height),
    ),
    onPressed: (){onPressed;},
    child: Text(
      text,
      style:TextStyle(
          fontSize: 19.0,
          color: Colors.white
      ),

    ),
  );
}


///////////////////////////////////////////////////////////////

PreferredSizeWidget defulteAppBar({
  required BuildContext context,
  String? title,
List<Widget>? actions,
})=>AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(IconBroken.Arrow___Left_2),
  ),
  titleSpacing: 0.0,
  title: Text(title!),
  actions: actions,
);



///////////////////////////////////////////////
Widget defaultTextButton({
  required String text,
  required Function onPressed,
  Color color = defultColore,
}
)=>TextButton(
    onPressed:(){ onPressed;},
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: color,

      ),
    ),
);
//// Post Item ///////////////

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
