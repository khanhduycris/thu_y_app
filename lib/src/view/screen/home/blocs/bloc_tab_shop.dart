import 'package:flutter_bloc/flutter_bloc.dart';

class BlocTabShop extends Cubit<int> {
  BlocTabShop() : super(0);

  changeTab(int value) {
    emit(value);
  }
}
