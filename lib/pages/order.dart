import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tampas/pages/homepage.dart';
import 'package:tampas/pages/view.dart';
import 'package:tampas/utils/size_config.dart';

class Order extends StatefulWidget {
  String size;
  int price;
  Order(this.size, this.price);
  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late Razorpay _razorpay;
  late String paymentId;
  late int fprice;
  String name="user";
  String address="address";
  String number="0000000000";
  late StreamSubscription<QuerySnapshot> subscription;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getDetails();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
  }

  void getDetails() async {
    final User? user = _firebaseAuth.currentUser;
    String uid = user!.uid;
   await FirebaseFirestore.instance.collection("tampa").doc(uid).get().then((value) {
      setState(() {
        name=value['name'];
        address=value['address'];
        number=value['number'];
        
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Future<void> updateList() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    await FirebaseFirestore.instance.collection('tampa').doc(uid).update(
        {'size': widget.size, 'payment Id': paymentId, 'price': fprice / 100});
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    await Fluttertoast.showToast(
      msg: 'SUCCESS: ${response.paymentId} + ${response.orderId}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void handlePaymentError(PaymentFailureResponse response) async {
    await Fluttertoast.showToast(
      msg: 'FAILURE: ${response.code.toString()} - ${response.message}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void externalWallet(ExternalWalletResponse response) async {
    await Fluttertoast.showToast(
      msg: 'External Wallet: ${response.walletName}',
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  Future<void> generate_ODID(int? amt) async {
    var orderOptions = {
      'amount': amt, // amount in the smallest currency unit
      'currency': "INR",
      'receipt': "order_rcptid_11"
    };
    final client = HttpClient();
    final request =
        await client.postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('${'rzp_live_xlfQfSGlO230bx'}:${'BHcGUp0Z8kVdfSuOsAKN2r4s'}'))}';
    request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
    request.add(utf8.encode(json.encode(orderOptions)));
    final response = await request.close();
    response.transform(utf8.decoder).listen((contents) {
      String orderId = contents.split(',')[0].split(":")[1];
      orderId = orderId.substring(1, orderId.length - 1);
      Map<String, dynamic> checkoutOptions = {
        'key': 'rzp_live_xlfQfSGlO230bx',
        'amount': amt,
        "currency": "INR",
        'name': 'E Drives',
        'description': 'E Bike',
        'order_id': orderId, // Generate order_id using Orders API
        'timeout': 300,
      };
      try {
        paymentId = orderId;
        _razorpay.open(checkoutOptions);
        updateList();
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => View()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deliver To',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(25),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(25),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                address,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(15),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                number,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(15),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                      minWidth: getProportionateScreenWidth(180),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (c) => const homePage()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.black)),
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(15),
                          horizontal: getProportionateScreenWidth(25)),
                      child: Text('Edit details',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black))),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        'Chill hai',
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(30),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        'RS 4',
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        'Size: $widget.size',
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(10),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: getProportionateScreenHeight(80),
                        // width: getProportionateScreenWidth(450),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          'assets/images/tshirt.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      MaterialButton(
                          minWidth: getProportionateScreenWidth(20),
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.black)),
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(15),
                              horizontal: getProportionateScreenWidth(25)),
                          child: Text('QTY: 1',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  color: Colors.black))),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Text(
                'Price details',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(25),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        'Delivery Charges',
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Rs. ${widget.price}',
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        'RS. 4',
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        'Free',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: getProportionateScreenHeight(15),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Text(
                        'Rs. ${widget.price - 4}',
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Center(
                child: MaterialButton(
                    minWidth: getProportionateScreenWidth(180),
                    onPressed: () {
                      fprice = (widget.price - 4) * 100;
                      generate_ODID(100);
                      // generate_ODID(fprice);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.black)),
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(15),
                        horizontal: getProportionateScreenWidth(25)),
                    child: Text('Place Order',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: Colors.black))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}