import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:gharelu/groupPurchase/groupPurchaseItems.dart';
import 'package:gharelu/screen/viewMore.dart';

class ListForOffers extends StatefulWidget {
  @override
  _ListForOffersState createState() => _ListForOffersState();
}

class _ListForOffersState extends State<ListForOffers> {
  String username, email, uid, number, latitude2, longitude2, shopName, code;

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;

    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        username = ds.data()['Full name'];
        email = ds.data()['email'];
        uid = ds.data()['uid'];
        number = ds.data()['number'];
        latitude2 = ds.data()['latitude'];
        longitude2 = ds.data()['longitude'];
        shopName = ds.data()['shop name'];
        code = ds.data()['code'] != null ? ds.data()['code'] : " ";
        // units = ds.data()['units'];

        print(username);
        print(email);
        print(uid);
        print(number);
        print(latitude2);
        print(longitude2);
        print(shopName);
        print(code);
        //print(units);
      }).catchError((e) {
        print(e);
      });

    //print("CATEGORY---- " + Category1);
    //print("SUBCATEGORY---- " + SubCategory1);

    //_getMinMaxLongLattoConsiderasperDistinact(latitude1, latitude2, 2);

    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("Selling details")
        //.where('Category', isEqualTo: Category1)
        //.where('SubCategory', isEqualTo: SubCategory1)
        //.where('radius', isLessThan: value)
        //.where(value, isLessThan: "10")
        //.where(_minLat,isLessThanOrEqualTo: latitude2)
        //.where(_maxLat,isGreaterThanOrEqualTo: latitude2)
        //.where(_minLong,isLessThanOrEqualTo: longitude2)
        //.where(_maxLong,isGreaterThanOrEqualTo: longitude2)
        .orderBy("Price")
        .get();
    return qn.docs;
  }

  // final CollectionReference listRef = FirebaseFirestore.instance.collection('Purchase');
  //final CollectionReference listRef1 = FirebaseFirestore.instance.collection('Group purchase');
  String gpPurchaseId = Uuid().v4();

  TextEditingController minPriceController = new TextEditingController();
  TextEditingController maxPriceController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();

  final vegetables = {
    "1": "Raw Banana/ ????????????????????? ",
    "2": "Bottle Gourd/ ?????????????????? ",
    "3": "Potato/ ????????????????????? ",
    "4": "Goose Berry/ ???????????????????????? ",
    "5": "Red Chilli/ ???????????? ?????????????????????",
    "6": "Bitter Gourd/ ???????????? ?????????",
    "7": "Coriander/ ??????????????????????????? ",
    "8": "Curry Leaves/ ??????????????????????????? ",
    "9": "Suran/ ????????????????????? ",
    "10": "Cauliflower/ ???????????? ??????????????????",
    "11": "Cabbage/ ???????????????????????? ",
    "12": "Coconut/ ?????????????????????????????? ",
    "13": "Kenaf/ ?????????????????? ",
    "14": "Cluster beans/ ???????????? ????????????",
    "15": "Broad Beans/ ???????????????????????? ?????????",
    "16": "Taro Root/ ????????????????????? ",
    "17": "Red sorrel/ ???????????????????????? ",
    "18": "Tomato/ ???????????? ",
    "19": "Amaranthus/ ?????????????????? ",
    "20": "Tindoora/ ????????????????????? ",
    "21": "Cucumber/ ?????????????????? ",
    "22": "Green Chilli/ ??????????????? ?????????????????????",
    "23": "Jack Fruit/ ?????????????????? ",
    "24": "Sorrel/ ?????????????????? ",
    "25": "Mushroom/ ??????????????????????????????????????? ",
    "26": "Mint Leaves/ ??????????????? ",
    "27": "Snake Gourd/ ???????????????????????? ",
    "28": "Green Peas/ ??????????????? ",
    "29": "Betroot/ ???????????? ????????????",
    "30": "Spinach/ ?????????????????? ?????????",
    "31": "Potato/ ?????????????????? ????????????",
    "32": "Ridge Gourd/ ?????????????????? ",
    "33": "Ash Gourd/ ?????????????????? ??????????????????????????????",
    "34": "Capsicum/ ??????????????????????????? ??????????????????",
    "35": "Lady's Finger / ????????????????????? ",
    "36": "Raw Mango/ ?????????????????? ?????????",
    "37": "Drumstick/ ???????????????????????? ????????????????????????",
    "38": "Radish/ ???????????????????????? ",
    "39": "Fenugreek leaves/ ??????????????? ?????????",
    "40": "Corn/ ??????????????? ???????????????",
    "41": "Sweet Potato/ ???????????? ????????????",
    "42": "Brinjal/ ??????????????? ",
    "43": "Garlic/ ?????????????????????????????? ",
    "44": "hill glory bower/ ????????????????????? ?????????",
    "45": "Bottle Gourd/ ?????????????????? ",
  };

  final fruits = {
    "1": "Muskmelon/ ??????????????????",
    "2": "Banana/ ???????????? ????????????",
    "3": "pineapple/ ????????????",
    "4": "jackfruit/ ????????? ????????????",
    "5": "papaya/ ?????????????????????",
    "6": "pomegranate/ ?????????????????????",
    "7": "Dates/ ?????????????????????",
    "8": "berry/ ??????????????????",
    "9": "Custard Apple/ ?????????????????????",
    "10": "watermelon/ ??????????????? ?????????",
    "11": "Sapodilla/ ???????????????",
    "12": "plum/ ????????????",
    "13": "guava/ ?????????",
    "14": "grapes/ ?????????????????????",
    "15": "mango/ ??????????????????",
    "16": "mosambi/ ??????????????????",
    "17": "orange/ ??????????????????",
    "18": "Sweet Orange/ ????????? ?????????",
    "19": "apple/ ????????????",
    "20": "strawberry/ ????????????",
  };

  final tiffins = {
    "1": "idly/ ???????????????",
    "2": "vada/ ????????????",
    "3": "mysore bonda/ ?????????????????? ???????????????",
    "4": "upma/ ???????????????",
    "5": "poori/ ????????????",
    "6": "Uthappam/ ??????????????????",
    "7": "Semiya Upma/ ?????????????????? ???????????????",
    "8": "Puttu/ ??????????????????",
    "9": "Rava Dosa/ ?????? ?????????",
    "10": "Punugulu/ ????????????????????????",
    "11": "Chapathi/ ???????????????",
    "12": "Pongal/ ??????????????????",
    "13": "Aloo Bonda/ ????????? ???????????????",
    "14": "Tomato Baath/ ?????????????????? ????????????",
    "15": "Bisi Bele Baath/ ???????????? ???????????? ????????????",
    "16": "Pulihora/ ????????????????????????",
    "17": "Daddojanam/ ???????????????????????????",
    "18": "Appam/ ???????????????",
    "19": "Pesarattu/ ???????????????????????????",
    "20": "Dosa/ ?????????",
  };

  List<DropdownMenuItem<String>> menuItems1 = List();

  final GlobalKey<FormFieldState> _vegetablekey = GlobalKey();
  String value = " ";
  String value1 = "";
  String valueSelected = " ";
  bool disableDropDown = true;

  void populateVegetables() {
    for (String key in vegetables.keys) {
      menuItems1.add(DropdownMenuItem<String>(
        value: vegetables[key],
        child: Text(vegetables[key]),
      ));
    }
  }

  void populateFruits() {
    for (String key in fruits.keys) {
      menuItems1.add(DropdownMenuItem<String>(
        value: fruits[key],
        child: Text(fruits[key]),
      ));
    }
  }

  void populateTiffins() {
    for (String key in tiffins.keys) {
      menuItems1.add(DropdownMenuItem<String>(
        value: tiffins[key],
        child: Text(tiffins[key]),
      ));
    }
  }

  void valueChanged1(_value1) {
    _vegetablekey.currentState.reset();
    if (_value1 == "vegetables") {
      menuItems1 = List();
      populateVegetables();
    } else if (_value1 == "fruits") {
      menuItems1 = List();
      populateFruits();
    } else if (_value1 == "tiffins") {
      menuItems1 = List();
      populateTiffins();
    }
    setState(() {
      value = _value1;
      valueSelected = value;
      disableDropDown = false;
    });
  }

  void thirdValueChanged(_value1) {
    setState(() {
      value1 = _value1;
    });
  }

  String EndDate;
  var units;

  String postId = Uuid().v4();

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    _fetch();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add items'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            FutureBuilder(
                future: _fetch(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Text('Loading... please wait');
                  return Column(children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    /*Text(
                      "Purchase code: ${code}",
                      style: TextStyle(fontSize: 21),
                    ),*/
                    Container(
                      padding: EdgeInsets.only(left: 30.0),
                      width: 350,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Field cannot be empty';
                          } else
                            return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: codeController,
                        //onSaved: (val) => email = val,
                        decoration: InputDecoration(  
                            border: OutlineInputBorder(),
                            labelText: "Purchase Code : ${code}",
                            labelStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                          //hintText: "Must be at least 3 characters",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ]);
                }),
            Text(
              'Create Offer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              /*leading: Icon(
                                  Icons.food_bank,
                                  color: Colors.green,
                                  size: 35.0,
                                ),*/
              title: Container(
                padding: EdgeInsets.only(left: 30.0),
                width: 350,
                child: DropdownButtonFormField<String>(
                  items: [
                    DropdownMenuItem<String>(
                        value: 'vegetables',
                        child: Text(
                          'vegetables/ ????????????????????????',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                          ),
                        )),
                    DropdownMenuItem<String>(
                        value: 'fruits',
                        child: Text(
                          'fruits/ ??????????????????',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                          ),
                        )),
                    DropdownMenuItem<String>(
                        value: 'tiffins',
                        child: Text(
                          'tiffins/ ????????????????????????',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                          ),
                        ))
                  ],
                  onChanged: (_value1) => valueChanged1(_value1),
                  validator: (value) => value == null ? 'Field required' : null,
                  hint: Text(
                    "Select Category",
                    style: TextStyle(fontFamily: 'Helvetica'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            ListTile(
              title: Container(
                padding: EdgeInsets.only(left: 30.0),
                width: 350,
                child: DropdownButtonFormField<String>(
                  key: _vegetablekey,
                  items: menuItems1,
                  onChanged: disableDropDown
                      ? null
                      : (_value1) => thirdValueChanged(_value1),
                  validator: (value) => value == null ? 'Field required' : null,
                  hint: Text("Select subcategory"),
                  disabledHint: Text(
                    "Please select subcategory",
                    style: TextStyle(fontFamily: 'Helvetica'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              child: DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'End Date',
                timeLabelText: "Hour",
                /*selectableDayPredicate: (date) {
                              // Disable weekend days to select from the calendar
                              if (date.weekday == 6 || date.weekday == 7) {
                                return false;
                              }
                              return true;
                            },*/
                // onChanged: (val) => print("val" + val),
                onChanged: (val) {
                  setState(() {
                    EndDate = val;
                    print("End date:  " + val);
                  });
                },
                validator: (val) {
                  print(" val1" + val);
                  return null;
                },
                onSaved: (val) => print(val),
                /*onSaved: (val) {
                              setState(() {
                                EndDate = val;
                                print("End date:  "+ val);
                              });
                            }*/
              ),
            ),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              width: 350,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Field cannot be empty';
                  } else
                    return null;
                },
                keyboardType: TextInputType.number,
                controller: weightController,
                //onSaved: (val) => email = val,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Weight",
                  labelStyle: TextStyle(fontSize: 15.0),
                    /*suffixIcon: DropdownButton<String>(
                      isDense: true,
                      value: units,
                      onChanged: (String newValue) {
                        setState(() {
                          units = newValue;
                        });
                      },
                      hint: Text(
                        'select units',
                        style: TextStyle(color: Colors.black),
                      ),
                      items: <String>[
                        ' Number',
                        ' Litre',
                        ' KiloGram'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    )*/
                  //hintText: "Must be at least 3 characters",
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              width: 350,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Field cannot be empty';
                  } else
                    return null;
                },
                keyboardType: TextInputType.number,
                controller: minPriceController,
                //onSaved: (val) => email = val,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Minimum Price",
                  labelStyle: TextStyle(fontSize: 15.0),
                  hintText: "Must be at least 1 characters",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.0),
              width: 350,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Field cannot be empty';
                  } else
                    return null;
                },
                keyboardType: TextInputType.number,
                controller: maxPriceController,
                //onSaved: (val) => email = val,
                decoration: InputDecoration( 
                  border: OutlineInputBorder(),
                  labelText: "Enter Maximum Price",
                  labelStyle: TextStyle(fontSize: 15.0),
                  hintText: "Must be at least 1 characters",
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              onPressed: () {
                print('clicked');
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ListForOffers() ));
                _firestore.collection('Group Purchase').doc(codeController.text.isEmpty != true ? codeController.text : code).collection('Purchase').doc(postId).set({
                  "Purchase Code":codeController.text.isEmpty != true ? codeController.text : code,
                  "uid":uid,
                  "Category":valueSelected,
                  "SubCategory":value1,
                  "End Date":EndDate,
                  "Weight":weightController.text,
                  "Minimum Price":minPriceController.text,
                  "Maximum Price":maxPriceController.text,
                  "postId":postId,
                  "Person":username,
                  //"Units":units,
                });
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupPurchaseItems(
                            int.parse(minPriceController.text),
                            int.parse(maxPriceController.text),
                            valueSelected,
                            value1,
                            int.parse(weightController.text),
                        )));*/
              },
              child: Text('Save to my list'),
            )
          ],
        )),
      ),
    );
  }
}
