import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import '../home_screen/home_screen.dart';
import '../shared/componants/componants.dart';
import '../shared/cupit/register_cupit.dart';
import '../shared/cupit/states.dart';
import '../shared/styles/colors.dart';



class RegisterScreen extends StatelessWidget {
  //const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAppRegisterCubit(),
      child: BlocConsumer<SocialAppRegisterCubit, SocialAppRegisterState>(
          listener: (context, state) {
            if (state is SocialAppCreateSuccessState){
              navigateFinish(context, Login_Screen());
            }
          },
        builder: (context, state) {
          var cubit = SocialAppRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Social_App'),
            ),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40.0,),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              print(passwordController.text);
                              print(emailController.text);
                            }
                          },
                          validate: (value) {
                            if (value == null || value
                                .trim()
                                .isEmpty) {
                              return ('User Name can\'t be empty');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0,),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email',
                          prefix: Icons.email,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              print(passwordController.text);
                              print(emailController.text);
                            }
                          },
                          validate: (value) {
                            if (value == null || value
                                .trim()
                                .isEmpty) {
                              return ('Email Address can\'t be empty');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0,),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: cubit.isPassword,
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: cubit.suffix,
                          suffixPressed: () {
                            cubit.changPasswordVisibility();
                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return ('Password can\'t be empty');
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              print(passwordController.text);
                              print(emailController.text);
                            }
                          },
                        ),
                        SizedBox(height: 10.0,),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.number,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return ('Phone can\'t be empty');
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                            }
                          },
                        ),
                        SizedBox(height: 10.0,),
                        ConditionalBuilder(
                          condition: state is! SocialAppRegisterLoadingState,
                          builder:(context)=> ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(8.0),
                              backgroundColor: defultColore,
                              minimumSize: Size(double.infinity, 50.0),
                            ),
                              onPressed: (){
                              if (formKey.currentState!.validate()) {
                                    cubit.userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }},
                              child: Text('Register',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 19.0,color: Colors.white)
                              ),
                               ),
                         fallback: (context)=>const Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 10.0,),
                      ],
                    ),
                  ),


                ),
              ),
            ),
          );
        },
      ),
    );
  }

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

}