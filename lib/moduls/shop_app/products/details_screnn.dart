import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mzx_k/models/Shop_app/products_details.dart';
import 'package:mzx_k/moduls/shop_app/cubit/cubit.dart';
import 'package:mzx_k/moduls/shop_app/cubit/states.dart';
import '../../../models/Shop_app/products_details.dart';

class ProductDetails extends StatelessWidget {
  final id;
  ProductDetails(this.id);

  @override
  Widget build(BuildContext context) {
        return  BlocProvider.value(
        value: BlocProvider.of<shopCubit>(context)..getDetailsModel(id.toString()),
        child: BlocConsumer<shopCubit,shopStates>(
            builder: (context, state) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                    color: Colors.blue
                ),
              ),
              body: state is ShopLoadingGetDetailsState
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child:
                  LinearProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              )
                  : bodyBuild(
                  context,
                  shopCubit.get(context).productdetailsmodel
                  ,id
              ),
            ),
            listener: (context, state) {
            }
              )
    );
  }
}

Widget bodyBuild(context, ProductDetailsModel? model,id) {
  List<Widget> images = [];
  model!.data.images.forEach((element) {
    images.add(Container(
      child: Image.network(element, fit: BoxFit.fill),
    ));
  });
  return shopCubit.get(context).productdetailsmodel == null
      ? Center(child: CircularProgressIndicator())
      : Container(
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(
        children: [
          Text(
            model.data.name,
            style: TextStyle(fontSize: 25),
          ),
          CarouselSlider(
              items: images,
              options: CarouselOptions(
                  height: 300,
                  onPageChanged: (x, reason) {}
                  )
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Text("${model.data.price.toString()} EGP",style: TextStyle(fontSize: 20,color: Colors.blue),),
            ],

          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Divider(height: 2,color: Colors.blue,endIndent: 10,indent: 10,),
          ),
          SizedBox(height: 15,),
          Text("Description",style: TextStyle(fontSize: 24,letterSpacing: 2),),
          SizedBox(height: 15,),
          Text(model.data.description)
        ],
      ),
    ),
  );
}


