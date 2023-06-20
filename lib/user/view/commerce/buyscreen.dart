import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focused_menu_custom/focused_menu.dart';
import 'package:focused_menu_custom/modals.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:user_firebase/user/controller/fire_controller.dart';
import 'package:user_firebase/user/model/home_model.dart';
import 'package:user_firebase/utils/fb_helper.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key? key}) : super(key: key);

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  var _razorpay = Razorpay();
  Product_Controller contoller = Get.put(Product_Controller());
  int? i;

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Success Payment  ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Error Payment  ${response.code}", timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.edit,
                color: Colors.grey,
              ),
            ),
          ],
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "BUY",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: FireBaseHelper.fireBaseHelper.BuyShowitem(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(("${snapshot.error}"));
            } else if (snapshot.hasData) {
              QuerySnapshot? q = snapshot.data;
              contoller.DataList.clear();
              for (var x in q!.docs) {
                Map data = x.data() as Map;
                String? name = data['p_name'];
                String? notes = data['p_notes'];
                String? date = data['p_date'];
                String? time = data['p_time'];
                String? price = data['p_price'];
                String? image = data['p_image'];
                var key = x.id;
                Product_Model product_model = Product_Model(
                  p_name: name,
                  p_notes: notes,
                  p_date: date,
                  p_price: price,
                  p_image: image,
                  p_time: time,
                  key: x.id,
                );
                contoller.DataList.add(product_model);
              }
              return ListView.builder(
                itemCount: contoller.DataList.length,
                itemBuilder: (context, index) {
                  return FocusedMenuHolder(
                    menuItems: [
                      FocusedMenuItem(
                          title: Text(
                            "Delete",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          trailingIcon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            FireBaseHelper.fireBaseHelper
                                .BuyDelete(key: contoller.DataList[index].key);
                          }),
                    ],
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 109,
                                  width: 109,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      "${contoller.DataList[index].p_image}",
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  child: Text(
                                    "${contoller.DataList[index].p_name}",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "₹${contoller.DataList[index].p_price}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                var options = {
                                  'key': "rzp_test_M1tycy9bOK9R3Q",
                                  'amount': 45000,
                                  'name': 'Treding',
                                  'order_id': 'order_EMBFqjDHEEn80l',
                                  'description': 'Finnifty 19000 CE',
                                  'timeout': 60,
                                  'prefill': {
                                    'email': 'gaurav.kumar@example.com'
                                  }
                                };
                                _razorpay.open(options);
                              },
                              child: Container(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
