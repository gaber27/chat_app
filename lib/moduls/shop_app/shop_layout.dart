import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/moduls/shop_app/cubit/cubit.dart';
import 'package:mzx_k/moduls/shop_app/cubit/states.dart';
import 'package:mzx_k/moduls/shop_app/search/search_screen.dart';
import 'package:mzx_k/shared/shared.components/components.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit,shopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cuibt = shopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                navigateto(context, searchScreen());
              }, icon: Icon(Icons.search))
            ],
            title: Text
              ('Salla'),
          ),
           body: cuibt.bottomScreens[cuibt.currentIndex] ,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: AnimatedBottomNavigationBar(
            activeIndex: shopCubit.get(context).currentIndex,
            onTap:(index)
            {
              cuibt.changeBottom(index);
            },
            icons: [
              Icons.home,
              Icons.category_outlined,
              Icons.favorite_border,
              Icons.settings,
            ],
            activeColor:Colors.blue,
            notchSmoothness: NotchSmoothness.softEdge,
            gapLocation: GapLocation.none,
            leftCornerRadius: 35,
            rightCornerRadius: 35,
          ),


        );
      },
    );
  }
}
