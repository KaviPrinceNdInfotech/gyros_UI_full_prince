import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:gyros_app/models/newProductModel.dart';
import 'package:gyros_app/models/product_detail_new_model.dart';
import 'package:http/http.dart' as http;
import '../models/view_review_ratting/view_ratting_reviewww.dart';
import '../services/api_provider.dart';
import '../view/model_cart_practice/widgets/item_details_pageee/item_details_catagary.dart';
import '../view/model_cart_practice/widgets/item_details_pageee/new_detail_page.dart';
import '../widgets/circular_loader.dart';

class NewController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt selectedimg = 0.obs;
  RxInt selectedPrice = 0.obs;
  RxInt selectedsingleimg = 0.obs;
  String productid = '';
  ProductDetailsModel? newModelid;
  GetProductReview? getProductreview;


  RxInt qty = 1.obs;
  addQty() {
    qty = qty + 1;
  }

  removeQty() {
    if (qty.value > 1) {
      qty = qty - 1;
    } else {
      Get.snackbar("Failed", "Qunatity is already Minimum");
    }
  }

  void callAddtoCartApi(var productId, var pkt, var qty, var count, var price,
      var finalamnt) async {
    http.Response r = await ApiProvider.addtoCart(
        productId, pkt, qty, count, price, finalamnt);
    if (r.statusCode == 200) {
      CallLoader.hideLoader();
      Get.snackbar("Added", "Add to cart Successfully");
    } else {

      CallLoader.hideLoader();


      Get.snackbar("Failed", "${r.body}");
    }
  }

  void newproductbyIdApi() async {
    isLoading(false);

    newModelid = await ApiProvider.newproductdetails(productid.toString());
    if (newModelid != null) {
      isLoading(false);
      ///from here product id 13 april 2023 ...prince...
      var prefs = GetStorage();
      //saved id..........
      //prefs.write("Id".toString(), json.decode(r.body)['Id']);
      productid = prefs.read("Id").toString();
      print('&&&&&&&&&&&&&&&&&&&&&&:${productid}');
      ///
      Get.to(
            () => ItemDetailsss(productId: productid,), //next page class
        duration: Duration(
            milliseconds: 300), //duration of transitions, default 1 sec
        transition:
        // Transition.leftToRight //transition effect
        // Transition.fadeIn
        //Transition.size
        Transition.zoom,
      );
    }
  }



  ///............................view rating review..................


  void getreviewdetailApi() async {
    isLoading(true);
    getProductreview = await ApiProvider.viewreviewApi();
    if (getProductreview != null) {
      //Get.to(() => ItemDetailss());
      isLoading(false);

    }
  }
  @override
  void onInit() {
    newproductbyIdApi();
    getreviewdetailApi();
    //getreviewdetailApi();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
