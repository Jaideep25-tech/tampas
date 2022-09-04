import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tampas/pages/homepage.dart';
import 'package:tampas/pages/order.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tampas/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:path/path.dart' as Path;

class View extends StatefulWidget {
  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  late String size;
  int price = 100;
  int a = 0;
  bool selected = true;
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  final _offerController1 = PageController();
  File? image;
  final picker = ImagePicker();

  openurl() async {
    if (await canLaunch('https://flutter.dev')) {
      await launch('https://flutter.dev');
    } else {
      print('could not launch');
    }
  }

  _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(8),
                onPressed: (() async {
                  Navigator.of(context).pop();
                  final file =
                      await picker.pickImage(source: ImageSource.camera);
                  if (file != null) {
                    setState(() {
                      image = File(file.path);
                    });
                  } else {
                    // showSnackBar(context, "Take A Images");
                  }
                }),
                child: const Text("Take a Photo"),
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(8),
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                child: const Text("Cancel"),
              ),
            ],
          );
        });
  }

  var res;
  var _total = 100;
  var current = 4;
  Future<dynamic> sendForm(
      Map<String, dynamic> data, Map<String, File> files) async {
    try {
      Map<String, MultipartFile> fileMap = {};
      for (MapEntry fileEntry in files.entries) {
        File file = fileEntry.value;
        String fileName = Path.basename(file.path);
        fileMap[fileEntry.key] = MultipartFile(
          file.openRead(),
          await file.length(),
          filename: fileName,
        );
      }
      data.addAll(fileMap);
      var formData = FormData.fromMap(data);
      Dio dio = Dio();
      var response = await dio.post('https://aws143.arnavgoyal4.repl.co/upload',
          data: formData, onSendProgress: (int sent, int total) {
        log('$sent $total');
        _total = total;
        current = sent;
      }, options: Options(contentType: 'multipart/form-data'));

      res = response.data;
    } catch (e) {
      log(e.toString());
    }
    log(res.toString());
    return res;
  }

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _selectImage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => const homePage()));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 400,
                    width: 368,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: PageView(
                          controller: _offerController1,
                          children: [
                            Image.asset(
                              'assets/images/tshirt.png',
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'assets/images/tshirt.png',
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'assets/images/tshirt.png',
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              'assets/images/tshirt.png',
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //dot indicator
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SmoothPageIndicator(
                    controller: _offerController1,
                    count: 4,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.blue,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
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
                          Text(
                            'Chill Hai',
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(30),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rs. $price',
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                selected = true;
                                selected1 = false;
                                selected2 = false;
                                selected3 = false;
                                selected4 = false;
                                print(selected1);
                              });
                            },
                            height: 33,
                            minWidth: 33,
                            elevation: 0,
                            color: selected ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: const BorderSide(
                                color: Color.fromRGBO(195, 195, 195, 0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'XS',
                                style: TextStyle(
                                  color:
                                      !selected ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                selected1 = true;
                                selected = false;
                                selected2 = false;
                                selected3 = false;
                                selected4 = false;
                                print(selected1);
                              });
                            },
                            height: 33,
                            minWidth: 33,
                            elevation: 0,
                            color: selected1 ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: const BorderSide(
                                color: Color.fromRGBO(195, 195, 195, 0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'S',
                                style: TextStyle(
                                  color:
                                      !selected1 ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                selected = false;
                                selected1 = false;
                                selected2 = true;
                                selected3 = false;
                                selected4 = false;
                                print(selected1);
                              });
                            },
                            height: 33,
                            minWidth: 33,
                            elevation: 0,
                            color: selected2 ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: const BorderSide(
                                color: Color.fromRGBO(195, 195, 195, 0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'M',
                                style: TextStyle(
                                  color:
                                      !selected2 ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                selected = false;
                                selected1 = false;
                                selected3 = true;
                                selected2 = false;
                                selected4 = false;
                                print(selected1);
                              });
                            },
                            height: 33,
                            minWidth: 33,
                            elevation: 0,
                            color: selected3 ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: const BorderSide(
                                color: Color.fromRGBO(195, 195, 195, 0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'L',
                                style: TextStyle(
                                  color:
                                      !selected3 ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                selected = false;
                                selected1 = false;
                                selected4 = true;
                                selected3 = false;
                                selected2 = false;
                                print(selected1);
                              });
                            },
                            height: 33,
                            minWidth: 33,
                            elevation: 0,
                            color: selected4 ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: const BorderSide(
                                color: Color.fromRGBO(195, 195, 195, 0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'XL',
                                style: TextStyle(
                                  color:
                                      !selected4 ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        minWidth: getProportionateScreenWidth(130),
                        onPressed: () {
                          sendForm({}, {'files[]': image!});
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.black)),
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(15),
                            horizontal: getProportionateScreenWidth(25)),
                        child: Text('Try On',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                color: Colors.black))),
                    MaterialButton(
                        minWidth: getProportionateScreenWidth(30),
                        onPressed: () {
                          openurl();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.black)),
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(15),
                            horizontal: getProportionateScreenWidth(25)),
                        child: SvgPicture.asset('assets/images/icon.svg')),
                    MaterialButton(
                        minWidth: getProportionateScreenWidth(130),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.black)),
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(15),
                            horizontal: getProportionateScreenWidth(25)),
                        child: Text('View AR',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                color: Colors.black))),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Text('Specifications',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(11),
                        color: Colors.black)),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('Type',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(6),
                                color: Colors.grey)),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text('Round Neck',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(9),
                                color: Colors.black)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Toe Shape',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(6),
                                color: Colors.grey)),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text('Round Neck',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(9),
                                color: Colors.black)),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('Pattern',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(6),
                                color: Colors.grey)),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text('Illusttration',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(9),
                                color: Colors.black)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Fastening',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(6),
                                color: Colors.grey)),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text('Sneaker',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(9),
                                color: Colors.black)),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('Chest Width',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(6),
                                color: Colors.grey)),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text('Regular',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(9),
                                color: Colors.black)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Shoulder height',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(6),
                                color: Colors.grey)),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text('Sneaker',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(9),
                                color: Colors.black)),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('Insole',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(6),
                                color: Colors.grey)),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text('Support Inside',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(9),
                                color: Colors.black)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Sole Material',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(6),
                                color: Colors.grey)),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text('Rubber',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(9),
                                color: Colors.black)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Center(
                  child: MaterialButton(
                      minWidth: getProportionateScreenWidth(180),
                      onPressed: () {
                        selected
                            ? size = 'XS'
                            : selected1
                                ? size = 'S'
                                : selected2
                                    ? size = 'M'
                                    : selected3
                                        ? size = 'L'
                                        : size = 'XL';
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => Order(size, price)));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.black)),
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(15),
                          horizontal: getProportionateScreenWidth(25)),
                      child: Text('Buy now',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              color: Colors.black))),
                )
              ]),
            ),
          ),
        ));
  }
}
