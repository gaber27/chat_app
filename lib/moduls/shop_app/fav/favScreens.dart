import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/moduls/shop_app/cubit/cubit.dart';
import 'package:mzx_k/moduls/shop_app/cubit/states.dart';
import 'package:mzx_k/shared/shared.components/components.dart';

class FavScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit,shopStates>(
        builder:(context,state)=>
      ConditionalBuilder(
        condition: state is! ShopLoadingGetFavState,
        fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        builder:(context)=> ListView.separated(itemBuilder: (context,index)=>buildListproduct(shopCubit.get(context).favsModel!.data!.data![index].product!,context),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: shopCubit.get(context).favsModel!.data!.data!.length),
      ) ,
    listener: (context,state){},
    );
  }
}
