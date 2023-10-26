import 'package:flutter_bloc/flutter_bloc.dart';

class BoolCubit extends Cubit<bool>{
  BoolCubit():super(false);

  change(bool data){
    emit(data);
  }
}