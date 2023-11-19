
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/modules/shared/componants/componants.dart';
import 'package:social_app/modules/shared/cupit/app_cubit.dart';
import 'package:social_app/modules/shared/cupit/states.dart';

import '../shared/styles/const.dart';

class EditProfile_Screen extends StatelessWidget {
   EditProfile_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppState>(
      listener:(context , state){},
        builder: ( context , state)
        {
          var cubit =  SocialAppCubit.get(context);
          var model = cubit.userModel;
          var profImage = cubit.profileImage;
          var covImage = cubit.coverImage;
          userNameController.text= model!.name;
          bioController.text= model.bio;
          phoneController.text = model.phone;

          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Text(
                  'Edit'
                ),
                actions: [
                  TextButton(
                      onPressed: (){
                        if (cubit.coverImage !=null)
                          cubit.upLoadCoverImage(
                            phone: phoneController.text,
                            name: userNameController.text,
                            bio: bioController.text,
                          ); else if (cubit.profileImage !=null)
                            cubit.upLoadProfImage(
                            phone: phoneController.text,
                            name: userNameController.text,
                            bio: bioController.text,
                          );else
                            SocialAppCubit.get(context).upDateUser(
                            phone: phoneController.text,
                            name: userNameController.text,
                            bio: bioController.text,
                        );
                      },
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: defultColore,
                        ),
                      )
                  ),
                  SizedBox(width: 8.0,)
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                   vertical: 0.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is SocialAppUpLoadProfileDataSuccessState)
                        const LinearProgressIndicator(),
                      const SizedBox(height: 5.0,),
                      Container(
                        height: 205.0,
                        child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children:[
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Container(
                                    width: double.infinity,
                                    height: 170.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft:Radius.circular(4.0,),
                                        topRight: Radius.circular(4.0,),

                                      ),
                                      image: DecorationImage(
                                        image:covImage == null ? NetworkImage(model.cover as String,) : FileImage(covImage) as ImageProvider ,

                                        fit: BoxFit.cover,
                                      ),

                                    ),
                                  ),
                                    IconButton(
                                      onPressed: () {
                                        SocialAppCubit.get(context).getCoverImage();
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: Colors.grey[100],
                                        radius: 20.0,
                                        child:Icon(
                                          IconBroken.Camera,
                                          size: 19.0,
                                        ),

                                        ),
                                    ),
                          ],
                                ),
                              ),
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[100],
                                      radius: 19.0,
                                      child: IconButton(
                                        icon: Icon(IconBroken.Camera,
                                        size: 20.0,
                                        ),
                                        onPressed: () {
                                          SocialAppCubit.get(context).getProfileImage();
                                        }
                                      ),
                                    ),
                                  ),
                                  radius:60.0,
                                  backgroundImage: profImage == null ?NetworkImage(model.image as String,):FileImage(profImage) as ImageProvider,
                                ),
                              ),
                            ]
                        ),
                      ),
                      SizedBox(height: 13.0,),
                      defaultFormField(

                          controller: userNameController,
                          type:TextInputType.text ,
                          label: 'User Name',
                          prefix: IconBroken.User,
                        validate: (value){
                          if (value == null || value.isEmpty) {
                            return ('User Name can\'t be empty');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8.0,),
                      defaultFormField(
                        controller: bioController,
                        type:TextInputType.text ,
                        label: 'Bio',
                        prefix: IconBroken.Info_Circle,
                      ),
                      SizedBox(height: 8.0,),
                      defaultFormField(
                        controller: phoneController,
                        type:TextInputType.number ,
                        label: 'Phone Number',
                        prefix: IconBroken.Call,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },

    );
  }
  var userNameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
}
