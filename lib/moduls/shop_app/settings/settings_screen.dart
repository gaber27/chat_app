
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/moduls/shop_app/cubit/cubit.dart';
import 'package:mzx_k/moduls/shop_app/cubit/states.dart';
import 'package:mzx_k/shared/shared.components/components.dart';
import 'package:mzx_k/shared/shared.components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  InputDecoration decoration = InputDecoration();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit,shopStates>(
      listener:(context,state)
      {
      },
      builder: (context,state ){
        var model = shopCubit.get(context).profilemodel;
        nameController.text = model!.data.name;
        emailController.text = model.data.email;
        phoneController.text =  model.data.phone;
        return
        ConditionalBuilder(
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserDataState )
                        LinearProgressIndicator(),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultFormFiled(
                        controller: nameController,
                        type: TextInputType.name,
                        Validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Name must not be empty';
                          }
                          return null;
                        },
                        label: 'Name' ,
                        Prefix: Icons.person,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      defaultFormFiled(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        Validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        label: 'Email' ,
                        Prefix: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      defaultFormFiled(
                        controller: phoneController,
                        type: TextInputType.phone,
                        Validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Phone must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone' ,
                        Prefix: Icons.phone_iphone_outlined,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      defaultButton(function: (){
                        if(formKey.currentState!.validate())
                        {
                          shopCubit().UdateUserData
                            (
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                          shopCubit.get(context).UdateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text
                          );
                        }
                      },
                        text: 'update'
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(function: (){
                        signOut(context);
                      }, text: 'LogOut'
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          condition:shopCubit.get(context).profilemodel!=null ,
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      }

    );
  }
}
