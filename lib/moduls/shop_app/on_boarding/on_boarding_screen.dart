import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mzx_k/moduls/shop_app/Login/login_screen.dart';
import 'package:mzx_k/shared/network/local/cash_helper.dart';
import 'package:mzx_k/shared/shared.components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/styles/colors.dart';

 class BoardingModel
 {
   final String image;
   final String title;
   final String body;
    BoardingModel({
      required this.title,
      required this.image,
      required this.body,
    });
 }
class onBoardinScreen extends StatefulWidget {

  @override
  State<onBoardinScreen> createState() => _onBoardinScreenState();
}

class _onBoardinScreenState extends State<onBoardinScreen> {
   var boardController = PageController();

   List<BoardingModel> boarding=[
       BoardingModel(
         image: 'assets/images/image1.jpg',
         title: 'Welcome to salla',
         body: 'Now you can shop online'
       ) ,
       BoardingModel(
         image: 'assets/images/secondImage.jpg',
         title: 'Faster App Shopping',
         body: 'Choose Whatever the Product you wish for with the easiest way possible using ShopMart'
       ) ,
       BoardingModel(
         image: 'assets/images/thirdImage.jpg',
         title: 'Make the Payment',
         body: 'Pay with the safest way possible either by cash or credit cards'
       ) ,
   ];

   bool isLast =false;

   void Function() ? submit()
   {
     cachHelper.savedData(key: 'onBoarding', value: true).then((value){
       if(value)
       {
         navigateAndFinish(context, shopLoginScreen());
       }
     });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(function:
          ()
          {
            submit();
          },
            // submit(),
          text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index)
                {
                  if(index == boarding.length -1)
                    {
                      setState(() {
                        isLast = true;
                      });
                      // print('Last');
                    }else
                    {
                      // print('Not Last');
                      setState(() {
                        isLast = false;
                      });
                    }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator
                  (
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 4.0,
                      dotWidth: 8.0,
                      spacing: 5.0,
                    ),

                  ),
                Spacer(),
                FloatingActionButton(onPressed: ()
                {
                  if(isLast)
                  {
                    submit();
                    // submit();
                  }else{
                    boardController.nextPage(duration: Duration(
                      milliseconds: 750,
                    ),
                        curve: Curves.easeInQuart
                    );
                  }
                },
                child: Icon(Icons.arrow_forward_ios_outlined),)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>
  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Expanded(
  child: Image(
  image: AssetImage('${model.image}')
  ),
  ),
  Text(
  '${model.title}',
  style: TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  ),
  ),
  SizedBox(
  height: 15,
  ),
  Text(
  '${model.body}',
  style: TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  ),
  ),
    SizedBox(
      height: 15,
    ),
  ],
  );
}
