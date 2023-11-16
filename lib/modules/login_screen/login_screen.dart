import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/shared/cupit/login_cupit.dart';
import 'package:social_app/modules/shared/cupit/states.dart';
import 'package:social_app/network/remot/cash_helper.dart';
import '../home_screen/home_screen.dart';
import '../register_screen/register_screen.dart';
import '../shared/componants/componants.dart';
import '../shared/styles/colors.dart';


class Login_Screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialAppLoginCubit(),
      child: BlocConsumer<SocialAppLoginCubit,SocialAppLoginState>(
          listener: (context,state){
            if (state is  SocialAppLoginErrorState)
            {

              showToast(
                  msg: state.error,
                  state: ToastState.error
              );
            }
            else if (state is SocialAppLoginSuccessState)
            {
              CacheHelper.saveData(
                  key: 'uId',
                  value:state.uId,
              ).then((value) {
                navigateFinish(context, HomeScreen());
              });
            }
          },
          builder:(context, state)
          {
            var cubit =SocialAppLoginCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text('Social_App'),
              ),
              body: Padding(
                padding:  EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 40.0,),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            prefix: Icons.email,
                            onSubmit: (value){
                              if (formKey.currentState!.validate())
                              {
                                print (passwordController.text);
                                print(emailController.text);

                              }
                            },
                            validate: (value){
                              if (value==null||value.trim().isEmpty){
                                return ('Email Address can\'t be empty');
                              }
                              return null ;
                            },
                          ),
                          SizedBox(height: 20.0,),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            isPassword: cubit.isPassword,
                            label: 'Password',
                            prefix: Icons.lock,
                            suffixPressed: (){
                              cubit.changPasswordVisibility();
                            },
                            suffix: cubit.suffix,
                            validate:  (value){
                              if (value==null||value.isEmpty){
                                return ('Password can\'t be empty');
                              }
                              return null ;
                            },
                            onSubmit:  (value){
                              if (formKey.currentState!.validate())
                              {
                                print (passwordController.text);
                                print(emailController.text);

                              }
                            },
                          ),
                          SizedBox(height: 10.0,),
                          ConditionalBuilder(
                            condition: state is! SocialAppLoginLoadingState,
                            builder:(context)=> ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(8.0),
                                backgroundColor: defultColore,
                                minimumSize: Size(double.infinity, 50.0),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: Text(
                                'Login',
                              ),
                            ),
                            fallback: (context)=>const Center(child: CircularProgressIndicator()),
                          ),
                          /*Container(
                            height: 50.0,
                            width: double.infinity,
                            color: defultColore,
                            child: MaterialButton(
                              onPressed:(){
                                if (formKey.currentState!.validate())
                                {
                                  print (passwordController.text);
                                  print(emailController.text);

                                }
                              },
                              child:  Text(
                                'Login',
                                style:
                                TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),*/
                          SizedBox(height: 10.0,),
                          Row(
                            children: [
                              Text('Forget Password?'),
                              TextButton(
                                onPressed:() {
                                  print ('reset');
                                },
                                child:Text('Reset now'),
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              Text('Don\'t have an account?'),
                              TextButton(
                                onPressed:() {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>RegisterScreen()
                                  )
                                  );
                                },
                                child:Text('Register Now'),
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),


                  ),
                ),
              ),
            );
          } ,

      ),
    );
  }
var emailController =TextEditingController();
var passwordController = TextEditingController();
var formKey = GlobalKey<FormState>();
}