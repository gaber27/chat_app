
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/models/Shop_app/categories_model.dart';
import 'package:mzx_k/models/Shop_app/home_model.dart';
import 'package:mzx_k/moduls/shop_app/cubit/cubit.dart';
import 'package:mzx_k/moduls/shop_app/cubit/states.dart';
import 'package:mzx_k/moduls/shop_app/products/details_screnn.dart';
import 'package:mzx_k/shared/shared.components/components.dart';

class productsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit,shopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccesChangeFavState)
        {
          if(!state.model.status!)
          {
            ShowToast(text: state.model.message, state: ToastStates.ERROR);
          }

        }

      },
      builder: (context, state)
      {
        return ConditionalBuilder(
            condition: shopCubit.get(context).homeModel != null && shopCubit.get(context).categoriesModel != null ,
            builder: (context)=>HomeBuilder(shopCubit.get(context).homeModel,shopCubit.get(context).categoriesModel,context),
            fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget HomeBuilder(HomeModel? model ,CategoriesModel? categoriesModel,context)=> SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model?.data!.banners.map((e) => Image(

            image:NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,

          ),).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3,),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.elasticOut,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Categories ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
               height: 100.0,
               child: ListView.separated(
                 physics: BouncingScrollPhysics(),
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (context, index) =>BulidCategoriesItem(categoriesModel!.data!.data[index]) ,
                 separatorBuilder:(context,index)=>
                     SizedBox(
                       width: 10.0,
                     ) ,
                 itemCount:categoriesModel!.data!.data.length ,

  ),
       ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Products',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),

        Container(
          color: Colors.grey[300],
          child: GridView.count
            (
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.6,
            children: List.generate(
                model!.data!.products.length,

                    //List.generate(modelHome.data!.products.length, (index) => GestureDetector
                    (index) => GestureDetector(child: buildGridProduct(shopCubit.get(context).homeModel!.data!.products[index],context,shopCubit.get(context).categoriesModel!)
                    ,onTap: ()
                      {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetails(
                            model.data!.products[index].id ?? null ))
                            //shopCubit.get(context).productdetailsmodel!.data.id
                             );
                      },
                    )


            ),
          ),
        )
      ],
    ),
  );

    Widget buildGridProduct(productModel? model,context,CategoriesModel) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
  children: [
     Stack(
       alignment: AlignmentDirectional.bottomStart,
       children: [
         Image(
            image: NetworkImage(model!.image),
          width: double.infinity,
          height: 200.0,
          // fit: BoxFit.cover,

  ),
         if(model.discount != 0)
         Container(
             color: Colors.red,
             padding: EdgeInsets.symmetric(horizontal: 5.0),
             child:
           Text
             (
               'DISCOUNT',
             style: TextStyle
               (
               fontSize: 8.0,
               color: Colors.white,
             ),
           )
         ),
       ],
     ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle
                (
                fontSize: 14.0,
                height: 1.2,
                color: Colors.black
              ),
            ),
            Row(
              children: [
                Text(
                  "${model.price.round()}"+'  EGP  ',
                  style: TextStyle
                    (
                    fontSize: 13.0,
                    height: 1.3,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                if(model.discount != 0)
                Text(
                  "${model.old_price.round()}",
                  style: TextStyle
                    (
                    fontSize: 10.0,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed:()
                  {
                     shopCubit.get(context).ChangeFav(model.id);
                     print(model.id);
                    },
                    icon:CircleAvatar(
                      backgroundColor:(shopCubit.get(context).favourites[model.id]==true)? Colors.red:Colors.grey,
                      radius: 15.0,
                      child: Icon(
                          Icons.favorite_border,
                        size: 18,
                        color: Colors.white,

                      ),
                    ),

                )
              ],
            ),
          ],
        ),
      ),
  ],
  ),
    );
    Widget BulidCategoriesItem(DataModel model)=> Stack(
      alignment:AlignmentDirectional.bottomCenter ,
      children: [
        Image(
          image: NetworkImage(
            model.image,
          ),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
            width: 100,
            color: Colors.grey,
            child:
            Text(
              model.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style:
              TextStyle(
                color: Colors.white,

              ),
            )
        ),

      ],
    );

}
