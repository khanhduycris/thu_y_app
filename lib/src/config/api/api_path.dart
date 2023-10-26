class ApiPath {
  static const String domain = 'http://thuocthucung.nanoweb.vn';
  static const String domainWeb = '$domain/';
  static const String domainImage = '$domain/public/';

  static String banner = "/api/v2/flash-deals";
  static String bestSeller = "/api/v2/products/best-seller";

    static String category = "/api/v2/categories";

  static String coupon = "/api/v2/coupons";
  static String prdFlashSale = "/api/v2/flash-deal-products/3";
  static String timeFlashSale = "/api/v2/flash-deals";
  static String prdWholesale = "/api/v2/products/wholesale";
  static String flashBestSell = "/api/v2/products/flash-best-sell";
  static String detailPrd = "/api/v2/products/";

  static String searchPrd = "/api/v2/products/search";

  static String brands = "/api/v2/brands";
  static String getNews = "/api/v2/blogs";
  static String getNotifi = "/api/v2/info";
  static String getQuestion = "/api/v2/question";


  // cart
  static String addCart = "/api/v2/carts/add";
  static String listCart = "/api/v2/carts";
  static String changeQuantity = "/api/v2/carts/change-quantity";
  static String deteleItemCart = "/api/v2/carts/";
  static String addVoucherPay = "/api/v2/coupon-apply";
  static String getAllCart = "/api/v2/cart-summary";
  static String createOrder = "/api/v2/order/store";
  static String applyAddress = "/api/v2/update-address-in-cart";
  static String updateAddress = "/api/v2/user/shipping/update";

  //address
  static String listAddress = "/api/v2/user/shipping/address";
  static String provinces = "/api/v2/provinces";
  static String districts = "/api/v2/districts-by-province/";
  static String wards = "/api/v2/wards-by-district/";
  static String createAddress = "/api/v2/user/shipping/create";
  static String makeDefault = "/api/v2/user/shipping/make_default";
  static String deleteAddress = "/api/v2/user/shipping/delete/";

  //auth
  static String login = "/api/v2/auth/login";
  static String signup = "/api/v2/auth/signup";
  static String getProfile =  "/api/v2/get-user-by-access_token";
  static String chagePass = "/api/v2/auth/password/confirm_reset";
  static String updateUser = "/api/v2/user/info/update";
  static String changePassIsLogin = "/api/v2/auth/change-password";
  static String getOrder = "/api/v2/orders";
  static const removeUser = "/api/v2/auth/user/destroy";

  //Whishlist
  static String addWhish = "/api/v2/wishlists-add-product";
  static String removeWhish = "/api/v2/wishlists-remove-product";
  static String checkWhish = "/api/v2/wishlists-check-product?product_id=";
  static String listWhish = "/api/v2/wishlists";
}
