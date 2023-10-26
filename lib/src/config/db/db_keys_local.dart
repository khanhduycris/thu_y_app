import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';

class DbKeysLocal {
  static const String carts = '/carts';
  static const String viewed = '/viewed';
  static const String accessToken = '/accessToken';
  static const String isLogin = '/isLogin';
  static const String user = '/user';
  static const String userId = '/user-id';
  static const String store = '/store';
  static const String address = '/address';
  static const String provinceData = '/provinceData';
  static const String uid = '/uid';
  static const String voucher = '/voucher';
  static const String addressLocal = '/addressLocal';
  static const String typePost = '/typePost';

  static remover() async {
    await removeKey(carts);
    await removeKey(viewed);
    await removeKey(accessToken);
    await removeKey(isLogin);
    await removeKey(user);
    await removeKey(store);
    await removeKey(address);
    await removeKey(provinceData);
    await removeKey(uid);
    await removeKey(voucher);
    await removeKey(addressLocal);
    await removeKey(typePost);
  }
}
