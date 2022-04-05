import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mzx_k/moduls/shop_app/cubit/cubit.dart';
Widget defaultButton({
  double ? width = double.infinity ,
   Color ? background = Colors.blue,
    bool isUpperCase = true,
  double radius = 0.0,
  required void Function()? function , //  خلي بالك من دي
  required String  text ,
 })=>Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  width: width,
  // height: 40.0,
  child:
  MaterialButton(
    onPressed: function,
    child:
    Text(
       isUpperCase? text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);
  Widget defaultFormFiled({
    bool isClicable = true,
   void Function() ?onTap,
  required TextEditingController controller,
  required TextInputType type ,
  required String? Function(String?)? Validate,
    required String? label,
    required IconData ? Prefix,
     IconData ?suffix ,
   // void  Function()? onSubmitted,
  String? Function(String?) ?onSubmitted,
   String? Function(String?)?onChange,
   bool iSPassword =  false,
     void Function () ?suffixPressed,
    Decoration = InputDecoration,
})=>  TextFormField(
    enabled:isClicable ,
    onTap: onTap,
    controller: controller,
    keyboardType: type ,
    obscureText: iSPassword,
    //onFieldSubmitted==> من خلالها اقدر احصل علي القيمه مرة اخري
    onFieldSubmitted: onSubmitted,
    onChanged: onChange,
    validator: Validate,
    //focusedBorder: OutlineInputBorder(
    // borderRadius: BorderRadius.all(Radius.circular(5.0)),
    // borderSide: BorderSide(color: Colors.blue))
    decoration: InputDecoration(
      labelStyle: TextStyle(color: Colors.blue),
      focusedBorder: OutlineInputBorder
        (
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Colors.blue
        )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Colors.white,
          )
        ),
         filled: true,
         fillColor: Colors.grey[200],
      labelText:label,
      suffixIcon: suffix!= null? IconButton(
        onPressed: suffixPressed,
        icon: Icon(
            suffix
        ),
      ) : null,
      prefixIcon:
      Icon(
          Prefix,
      ),
      border: OutlineInputBorder(),
      // hintText: 'Email Address'  ,   بيروح لما تبدا كتابه
    ),
  );
  Widget bulidTaskItem(Map model, context)=>
      Dismissible(
        key: Key(model['id'].toString()),
        child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text(
                '${model['time']}'
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
            '${model['title']}',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                    '${model['date']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),

                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.0,
          ),

        ],
    ),
  ),
        onDismissed: (direction){
        },
      );
  Widget tasksBulider({
  required List<Map> tasks,
})=> ConditionalBuilder(
    condition:tasks.length>0 ,
    builder:(context)=>ListView.separated(itemBuilder:(context,index) => bulidTaskItem(tasks[index], context),
      separatorBuilder:(context,index)=>
      myDivider() ,
      itemCount:tasks.length,
    ),
    fallback:(context)=>Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet, Please Add Some Tasks',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),

          ),
        ],
      ),
    ) ,
  );
  Widget buildArticalItem(article,context)=> InkWell(
    onTap: (){
      // navigateto(context, webViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                    '${article['urlToImage']}'
                  ),
                  fit: BoxFit.cover,
                )
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );

  Widget myDivider()=>  Container(
    width: double.infinity,
    color: Colors.grey[300],
    height: 1.0,
  ) ;

  Widget articalBulider(list,context,{isSearch=false}) => ConditionalBuilder(
condition: list.length>0,
builder: (context)=> ListView.separated(
physics: BouncingScrollPhysics( ),
itemBuilder: (context,index)=>buildArticalItem(list[index],context),
separatorBuilder: (context,index)=>  myDivider() ,
itemCount:7,),
fallback: (context) => isSearch? Container(): Center(child: CircularProgressIndicator())
);

  void navigateto(context,Widget)=> Navigator.push(
context,
MaterialPageRoute(
builder: (context)=>
Widget,
),
);

  void navigateAndFinish(context,Widget)=>
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(
        builder: (context)=>
        Widget,
      ),
              (Route<dynamic>route) => false
      );
  Widget defaultTextButton({
    required  void Function()? function,
  required String text})
  => TextButton(onPressed: function, child: Text(text.toUpperCase()),);


void ShowToast({
  required String text,
  required ToastStates state
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

// enum if u have many choose
enum ToastStates {SUCCESS, ERROR, WARNING}
Color chooseToastColor(ToastStates state)
{
  late Color color ;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green ;
      break;
    case ToastStates.ERROR:
      color =  Colors.red ;
      break;
    case ToastStates.WARNING:
      color = Colors.amber ;
      break;
  }
  return color ;
}
Widget buildListproduct( model,context, {bool isOldPrice = true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120.0,
              height: 120.0,
              // fit: BoxFit.cover,

            ),
            if(model.discount != 0 && isOldPrice)
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
        SizedBox(
          width: 20.0,
        ),
        Expanded(
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
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString()+'  EGP  ',
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
                  if(model.discount!= 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
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
                    },
                    icon:CircleAvatar(
                      backgroundColor:(shopCubit.get(context).favourites[model.id]==true) ? Colors.red:Colors.grey,
                      radius: 15.0,
                      child: Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.white,

                      ),
                    ),


                    //ShopCubit.get(context).changeFavourites(
                    //                                     //         id: cubit.homeModel!.data!
                    //                                     //             .products[index].id);

                    // print(model.id);


                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);


