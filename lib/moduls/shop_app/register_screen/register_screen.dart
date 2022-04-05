import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/moduls/shop_app/register_screen/cubit/cubit.dart';
import 'package:mzx_k/moduls/shop_app/register_screen/cubit/states.dart';
import 'package:mzx_k/moduls/shop_app/shop_layout.dart';
import 'package:mzx_k/shared/network/local/cash_helper.dart';
import 'package:mzx_k/shared/shared.components/components.dart';

import '../../../shared/shared.components/constants.dart';

class registerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameControler = TextEditingController();
    var emilControler = TextEditingController();
    var passwordControler = TextEditingController();
    var phoneControler = TextEditingController();
    return BlocProvider(
      create: (context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,shopRegisterStates>(
        builder:(context,stata )
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFiled(
                            controller: nameControler,
                            type: TextInputType.name ,
                            Validate: (value)
                            {
                              if(value!.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                            },
                            label: 'User Name',
                            Prefix: Icons.person
                        ),
                        SizedBox(
                          height: 25.0,
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


                          },
                          type: TextInputType.visiblePassword ,
                          Validate: (value)
                          {
                            if(value!.isEmpty) {
                              return 'Password Is Too Short';
                            }
                          },
                          label: 'Password ',
                          iSPassword: ShopRegisterCubit.get(context).isPassword,
                          Prefix: Icons.lock,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed:(){
                            ShopRegisterCubit.get(context).changePasswordvisibility();
                          },
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        defaultFormFiled(
                            controller: phoneControler,
                            type: TextInputType.phone ,
                            Validate: (value)
                            {
                              if(value!.isEmpty) {
                                return 'Please Enter Your Phone number';
                              }
                            },
                            label: 'Phone',
                            Prefix: Icons.phone_iphone_sharp
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition:stata is! shopRegisterLoadinstate ,
                          builder: (context)=>defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).usersRegister(
                                  name: nameControler.text,
                                    phone: phoneControler.text,
                                    email: emilControler.text,
                                    password: passwordControler.text
                                );
                              }
                            },
                            text: 'Register',
                            isUpperCase: true,
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener:(context, state)
        {
          if(state is shopRegisterSucessstate)
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
        } ,

      ),
    );
  }
}
