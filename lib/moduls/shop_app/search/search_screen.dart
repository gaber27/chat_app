
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/moduls/shop_app/search/cubit/cubit.dart';
import 'package:mzx_k/moduls/shop_app/search/cubit/states.dart';
import 'package:mzx_k/shared/shared.components/components.dart';

class searchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder:(context,state){
          return
            Scaffold(
            appBar:AppBar(),
            body: Form(
              key:formKey ,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultFormFiled(
                        controller: searchController,
                        type: TextInputType.text,
                        Validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Enter text to search';
                          }
                          return null ;
                        },
                        label: 'Search',
                        Prefix: Icons.search,

                      onSubmitted: (String? text)
                      {
                        SearchCubit.get(context).Search(text!);
                      },
                    ),
                    SizedBox
                      (
                      height: 10,
                    ),
                    if(state is SearchLoadingstate)
                    LinearProgressIndicator(),
                    if(state is SearchSuccesstate)
                    Expanded(
                      child: ListView.separated
                        (
                          physics: BouncingScrollPhysics( ),
                          itemBuilder: (context,index)=>
                          buildListproduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false),
                          separatorBuilder: (context,index)=>myDivider(),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length
                      ),
                    ),

                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
