import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mzx_k/models/Shop_app/search_model.dart';
import 'package:mzx_k/moduls/shop_app/search/cubit/states.dart';
import 'package:mzx_k/shared/network/dio_helper.dart';
import 'package:mzx_k/shared/network/end-points.dart';
import 'package:mzx_k/shared/shared.components/constants.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super(SearchInitialstate());
  static SearchCubit get(context)=> BlocProvider.of(context);
  SearchModel ? model;
  void Search(String text)
  {
    emit(SearchLoadingstate());
    DioHelper.postDate(
      url: SEARCH,
      token: token,
      data:
    {
      "text":text,
    },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccesstate());
    }).catchError((error){
      print(error.toString());
      emit(SearchErorrstate());
    });
  }
}