import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tampas/pages/otp_authentication.dart';
import 'package:tampas/utils/size_config.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool _validate = false;
  bool _validate1 = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              TextField(
                controller: nameController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Name',
                  hintText: 'What should we call you?',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  errorText: _validate ? 'Name Can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              TextField(
                controller: numberController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Phone Number',
                  hintText: 'Enter your mobile number',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  errorText: _validate1 ? 'number Can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              TextField(
                controller: addressController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Address',
                  hintText: 'Enter your Address',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  errorText: _validate1 ? 'address Can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              TextField(
                controller: emailController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: 'Email Address',
                  hintText: 'abc@xyz.com',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  errorText: _validate1 ? 'email Can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              MaterialButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0))),
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(20),
                                  right: getProportionateScreenWidth(20),
                                  left: getProportionateScreenWidth(20),
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: otpVerification(
                                  "+91${numberController.text}",
                                  addressController.text,
                                  nameController.text,
                                  emailController.text),
                            ));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.black)),
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(15),
                      horizontal: getProportionateScreenWidth(25)),
                  child: Text('continue',
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }
}