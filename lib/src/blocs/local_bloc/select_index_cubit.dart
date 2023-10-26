import 'package:flutter_bloc/flutter_bloc.dart';

class SelectIndexCubit extends Cubit<int>{
  SelectIndexCubit():super(0);

  change(int index){
    emit(index);
  }
}