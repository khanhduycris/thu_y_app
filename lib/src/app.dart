import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:thu_y_app/src/blocs/local_bloc/user_local_bloc.dart';
import 'package:thu_y_app/src/config/db/db_keys_local.dart';
import 'package:thu_y_app/src/view/screen/home/blocs/bloc_nav_home.dart';
import '/src/view/screen/home/screen_home.dart';
import 'blocs/remote_bloc/cart/list_cart_bloc.dart';
import 'blocs/remote_bloc/font_end/bloc_category.dart';
import 'view/screen/home/blocs/bloc_tab_shop.dart';
import 'view/screen/screen_first.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BlocNavHome()),
        BlocProvider(create: (context) => BlocTabShop()),
        BlocProvider(create: (context) => BlocListCart()..getList()),
        BlocProvider(create: (context) =>  BlocCategory()..getList()),
        BlocProvider(create: (context) => UserLocalBloc()..getUserRemote()),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country
          Locale('vi', ''), // English, no country
        ],
        locale: const Locale("vi"),
        builder: (context, child) {
          final scale = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
          return MediaQuery(data: scale, child: child ?? Container());
        },
        debugShowCheckedModeBanner: false,
        title: 'Thú Y',
        home: getBoolAsync(DbKeysLocal.isLogin) ? ScreenHome() : ScreenFirst(),
        // home: ScreenHome(),
      ),
    );
  }
}
