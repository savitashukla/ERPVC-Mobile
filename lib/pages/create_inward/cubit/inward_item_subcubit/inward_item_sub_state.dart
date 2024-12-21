part of 'inward_item_sub_cubit.dart';

class InwardItemSubState extends Equatable {
  const InwardItemSubState({this.itemslist});
final Itemslist? itemslist;
  InwardItemSubState copyWith({
    Itemslist? itemslist
}) {
    return InwardItemSubState(
        itemslist:itemslist ?? this.itemslist
    );
  }

  @override
  List<Object?> get props => [itemslist];
}
