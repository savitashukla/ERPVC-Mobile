import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erpvc/model/inward_deatils_model_data.dart';

part 'inward_item_sub_state.dart';

class InwardItemSubCubit extends Cubit<InwardItemSubState> {
  InwardItemSubCubit({this.itemslist}) : super(InwardItemSubState(itemslist: itemslist));
  Itemslist? itemslist;
}
