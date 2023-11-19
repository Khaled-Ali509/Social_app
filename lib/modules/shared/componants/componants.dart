
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/models/Social_user_model.dart';

import '../../../models/post_model.dart';
import '../cupit/app_cubit.dart';
import '../styles/const.dart';


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
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white38)
    ),
    labelText:  label,
    hintStyle: TextStyle(color: Colors.white),
    prefixIcon:Icon(prefix,
    ),
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

