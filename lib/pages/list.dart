import 'package:flutter/material.dart';
import 'package:tampas/utils/size_config.dart';

class entrance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: getProportionateScreenWidth(10),
              mainAxisSpacing: getProportionateScreenHeight(10),
              crossAxisCount: 2,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/tshirt2.jpg',
                        fit: BoxFit.fill,
                      ),
                      Text('Teamspirit',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(10),
                              color: Colors.black)),
                      Text('Unisex Tshirt',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(7),
                              color: Colors.grey)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('250',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.black)),
                          Text('500',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.grey)),
                          Text('50% off',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/tshirt2.jpg',
                        fit: BoxFit.fill,
                      ),
                      Text('Teamspirit',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(10),
                              color: Colors.black)),
                      Text('Unisex Tshirt',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(7),
                              color: Colors.grey)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('250',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.black)),
                          Text('500',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.grey)),
                          Text('50% off',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/tshirt2.jpg',
                        fit: BoxFit.fill,
                      ),
                      Text('Teamspirit',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(10),
                              color: Colors.black)),
                      Text('Unisex Tshirt',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(7),
                              color: Colors.grey)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('250',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.black)),
                          Text('500',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.grey)),
                          Text('50% off',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/tshirt2.jpg',
                        fit: BoxFit.fill,
                      ),
                      Text('Teamspirit',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(10),
                              color: Colors.black)),
                      Text('Unisex Tshirt',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(7),
                              color: Colors.grey)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('250',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.black)),
                          Text('500',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.grey)),
                          Text('50% off',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/tshirt2.jpg',
                        fit: BoxFit.fill,
                      ),
                      Text('Teamspirit',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(10),
                              color: Colors.black)),
                      Text('Unisex Tshirt',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(7),
                              color: Colors.grey)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('250',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.black)),
                          Text('500',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.grey)),
                          Text('50% off',
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(10),
                                  color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
