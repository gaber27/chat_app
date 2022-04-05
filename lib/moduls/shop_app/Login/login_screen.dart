import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/moduls/shop_app/Login/cubit/cubit.dart';
import 'package:mzx_k/moduls/shop_app/Login/cubit/states.dart';
import 'package:mzx_k/moduls/shop_app/register_screen/register_screen.dart';
import 'package:mzx_k/moduls/shop_app/shop_layout.dart';
import 'package:mzx_k/shared/network/local/cash_helper.dart';
import 'package:mzx_k/shared/shared.components/components.dart';
import 'package:mzx_k/shared/shared.components/constants.dart';

class shopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emilControler = TextEditingController();
    var passwordControler = TextEditingController();
    return BlocProvider(
      create: (context)=>ShoploginCubit(),
      child: BlocConsumer<ShoploginCubit,shopLoginStates>(
        listener:((context, state)
        {
          if(state is shopLoginSucessstate)
          {
            if(state.loginModel.status)
            {
              cachHelper.savedData(key: 'token' ,value: state.loginModel.data!.token).then((value)
              {
                token= state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else
              ShowToast(
                  text: state.loginModel.message,
                  state: ToastStates.ERROR
              );

          }
        }
        ) ,
        builder:((context,state)
        {
          return Scaffold(
            // appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(image: AssetImage(
                          'assets/images/login.jpg',
                        )
                        ),
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFiled(
                            controller: emilControler,
                            type: TextInputType.emailAddress ,
                            Validate: (value)
                            {
                              if(value!.isEmpty) {
                                return 'Please Enter Your Email Address';
                              }
                            },
                            label: 'Email Address',
                            Prefix: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultFormFiled(
                          controller: passwordControler,

                          onSubmitted:(value) {
                            if (formKey.currentState!.validate()) {
                              ShoploginCubit.get(context).usersLogin(
                                  email: emilControler.text,
                                  password: passwordControler.text
                              );
                            };

                          },
                          type: TextInputType.visiblePassword ,
                          Validate: (value)
                          {
                            if(value!.isEmpty) {
                              return 'Password Is Too Short';
                            }
                          },
                          label: 'Password ',
                          iSPassword: ShoploginCubit.get(context).isPassword,
                          Prefix: Icons.lock,
                          suffix: ShoploginCubit.get(context).suffix,
                          suffixPressed:(){
                            ShoploginCubit.get(context).changePasswordvisibility();
                          },
                        ), SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition:state is!shopLoginLoadinstate ,
                          builder: (context)=>defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                                {
                                  ShoploginCubit.get(context).usersLogin(
                                      email: emilControler.text,
                                      password: passwordControler.text
                                  );
                                }
                            },
                            text: 'Login',
                            isUpperCase: true,
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(function: (){
                              navigateto(context,
                                  registerScreen());
                            }, text: 'Register')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        ),
      ),
    );
  }
}
