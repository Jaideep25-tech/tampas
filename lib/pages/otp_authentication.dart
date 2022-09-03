import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tampas/pages/view.dart';
import 'package:tampas/utils/size_config.dart';

class otpVerification extends StatefulWidget {
  final String number;
  final String name;
  final String address;
  final String email;
  const otpVerification(this.number, this.address, this.name,this.email);
  @override
  _otpVerificationState createState() => _otpVerificationState();
}

String? userID;

class _otpVerificationState extends State<otpVerification> {
  final TextEditingController controller = TextEditingController();

  bool _isResendAgain = true;
  String _code = '';
  String? _verificationCode;

  Timer? _timer;
  int _start = 60;

  void resend() {
    if (mounted) {
      setState(() {
        _isResendAgain = true;
      });
    }

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (mounted) {
        setState(() {
          if (_start == 0) {
            _start = 60;
            _isResendAgain = false;
            timer.cancel();
          } else {
            _start--;
          }
        });
      }
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUserData(String number, String uid) async {
    await FirebaseFirestore.instance.collection('tampa').doc(uid).set({
      'number': number,
      'created time': DateTime.now(),
      'name': widget.name,
      'address': widget.address,
      'user ID': uid,
      'email': widget.email, 
    });
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (c) => View()));
  }

  @override
  void initState() {
    super.initState();
    resend();
    verifyPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.only(top: getProportionateScreenHeight(15)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PinCodeTextField(
                length: 6,
                textStyle: TextStyle(
                  fontSize: getProportionateScreenHeight(20),
                  color: Colors.black,
                ),
                keyboardType: TextInputType.number,
                onCompleted: (value) {
                  setState(() {
                    _code = value;
                  });
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: getProportionateScreenHeight(42),
                  fieldWidth: getProportionateScreenWidth(42),
                  activeFillColor: Colors.black,
                  inactiveColor: Colors.black,
                ),
                cursorColor: Colors.black,
                onChanged: (String value) {
                  _code = value;
                },
                appContext: context,
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Text(
                'Enter the 6-digit code we sent to your number',
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                    color: Colors.black),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: (_code.length == 6)
                      ? SizedBox(
                          width: getProportionateScreenWidth(150),
                          child: MaterialButton(
                              onPressed: () async {
                                try {
                                  final UserCredential authResult =
                                      await _auth.signInWithCredential(
                                          PhoneAuthProvider.credential(
                                              verificationId:
                                                  _verificationCode.toString(),
                                              smsCode: _code));
                                  User? user = authResult.user;
                                  userID = user!.uid;
                                  if (authResult
                                      .additionalUserInfo!.isNewUser) {
                                    // ignore: use_build_context_synchronously
                                    createUserData(
                                        widget.number, userID.toString());
                                  } else {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (c) => View()),
                                    );
                                  }
                                } catch (e) {
                                  FocusScope.of(context).unfocus();
                                  const CupertinoAlertDialog(
                                    title: Text('Invalid OTP'),
                                    content: Text(
                                        "OTP entered by you is invalid. Try again with correct otp or check the Phone Number entered"),
                                  );
                                }
                              },
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenHeight(15),
                                  horizontal: getProportionateScreenWidth(25)),
                              child: Text('Buy now',
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(15),
                                      color: Colors.black))),
                        )
                      : SizedBox(
                          height: getProportionateScreenHeight(55),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: getProportionateScreenHeight(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (_isResendAgain) return;
                                    resend();
                                    verifyPhoneNumber();
                                  },
                                  child: Text('Resend OTP',
                                      style: TextStyle(
                                          color: _isResendAgain
                                              ? Colors.white
                                              : Colors.blue,
                                          decoration:
                                              TextDecoration.underline)),
                                ),
                                Text(
                                  _isResendAgain
                                      // ignore: prefer_interpolation_to_compose_strings
                                      ? "Try again in " + _start.toString()
                                      : "",
                                  style: TextStyle(
                                      color: _isResendAgain
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: (_code.length == 6) ? 18 : 20,
              )
            ]),
      ),
    );
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential authResult =
              await _auth.signInWithCredential(credential);
          User? user = authResult.user;
          userID = user?.uid;
          if (authResult.additionalUserInfo!.isNewUser) {
            createUserData(widget.number, userID.toString());
          } else {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (c) => View()));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          CupertinoAlertDialog(
            title: const Text('ERROR'),
            content: Text(e.message.toString()),
          );
        },
        codeSent: (String vID, int? resendToken) {
          setState(() {
            _verificationCode = vID;
          });
        },
        codeAutoRetrievalTimeout: (String vID) {
          setState(() {
            _verificationCode = vID;
          });
        },
        timeout: const Duration(seconds: 60));
  }
}