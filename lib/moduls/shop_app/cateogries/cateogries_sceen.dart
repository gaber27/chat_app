
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/models/Shop_app/categories_model.dart';
import 'package:mzx_k/moduls/shop_app/cubit/cubit.dart';
import 'package:mzx_k/moduls/shop_app/cubit/states.dart';
import 'package:mzx_k/shared/shared.components/components.dart';

class CateogriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit,shopStates>(
      listener: (context, state) {},
      builder: (context,state)
      {
        return  ListView.separated(
          itemBuilder:(context,index)=>buildCatItem(shopCubit.get(context).categoriesModel!.data!.data[index]) ,
          separatorBuilder:(context,index)=>myDivider(),
          itemCount:shopCubit.get(context).categoriesModel!.data!.data.length ,
        );
      },
    );
  }
  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.black12,
          backgroundImage: NetworkImage(
            model.image,),
          // child: Image(
          //   image: NetworkImage(
          //     'https://student.valuxapps.com/storage/uploads/banners/1619472351ITAM5.3bb51c97376281.5ec3ca8c1e8c5.jpg',
          //   ),
          //   height:80.0,
          //   width: 80.0,
          //   fit: BoxFit.cover,
          // ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          model.name,
          style:
          TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}


//ecoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                           border: Border.all(
//                           color: Color(0xffD50000),
//                           width: 3,
