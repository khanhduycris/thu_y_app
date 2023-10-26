import 'package:flutter_bloc/flutter_bloc.dart';

class BlocNavHome extends Cubit<int> {
  BlocNavHome() : super(0);

  changeTab(int value) {
    emit(value);
  }
}
