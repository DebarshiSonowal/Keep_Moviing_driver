import 'package:animator/animator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/Model/SignUpData.dart';
import 'package:my_cab_driver/auth/phoneAuthScreen.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/networking/Access.dart';

import '../main.dart';
import 'loginScreen.dart';

enum truckType { open, closed }

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var appBarheight = 0.0;
  var selectedVehicle = ConstanceData.vehicleType[0];
  var selectedWeight = ConstanceData.vehicleWeight[0][0];
  var selectedVehicleIndex = 0;
  var selectedWeightIndex = 0;
  truckType current = truckType.open;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  Position position;
  AlertDialog alert;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    auth = null;
    super.dispose();
  }

  @override
  void initState() {
    getCurrentPosition();
    super.initState();
  } // Country _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('IN');

  @override
  Widget build(BuildContext context) {
    appBarheight =
        AppBar().preferredSize.height + MediaQuery.of(context).padding.top - 50;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 14, left: 14),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: appBarheight,
                    ),
                    Card(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: <Widget>[
                                Animator(
                                  tween: Tween<Offset>(
                                    begin: Offset(0, 0.4),
                                    end: Offset(0, 0),
                                  ),
                                  duration: Duration(seconds: 1),
                                  cycles: 1,
                                  builder: (co, anim, sd) => SlideTransition(
                                    position: anim.animation,
                                    child: Image.asset(
                                      ConstanceData.splashBackground,
                                      fit: BoxFit.cover,
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 18, right: 18),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              AppLocalizations.of('Sign Up'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                    color: ConstanceData
                                                        .secoundryFontColor,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              AppLocalizations.of(' With'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                    color: ConstanceData
                                                        .secoundryFontColor,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(
                                                'email and phone'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                  color: ConstanceData
                                                      .secoundryFontColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of('number'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                  color: ConstanceData
                                                      .secoundryFontColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor),
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: TextFormField(
                                    autofocus: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .color,
                                        ),
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Full name',
                                      prefixIcon: Icon(
                                        Icons.people,
                                        size: 20,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            .color,
                                      ),
                                      hintStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor),
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: TextFormField(
                                    autofocus: false,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    keyboardType: TextInputType.text,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      hintText: 'name@example.com',
                                      prefixIcon: Icon(
                                        Icons.email,
                                        size: 20,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                      ),
                                      hintStyle:
                                          Theme.of(context).textTheme.bodyText2,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor),
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 50,
                                        child: SizedBox(
                                          width: 80,
                                          height: 60,
                                          child: Icon(
                                            Icons.phone,
                                            color: Color(0xff0b0b0b),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .color,
                                              ),
                                          keyboardType: TextInputType.number,
                                          controller: phoneController,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(bottom: 8),
                                            hintText: AppLocalizations.of(
                                                'Mobile Number'),
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor),
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Icon(
                                          Icons.car_rental,
                                          color: Color(0xff0b0b0b),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: DropdownButton(
                                          isExpanded: true,
                                          value: selectedVehicle,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          items: ConstanceData.vehicleType
                                              .map((items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (String value) {
                                            setState(() {
                                              selectedVehicle = value;
                                              selectedVehicleIndex =
                                                  ConstanceData.vehicleType
                                                      .indexOf(value);
                                              selectedWeightIndex =
                                                  selectedVehicleIndex;
                                              print(
                                                  'The value is ${value} and index ${selectedWeightIndex} and weight ${ConstanceData.vehicleWeight[selectedWeightIndex]}');
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: Theme.of(context).dividerColor),
                                    color: Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.7),
                                  ),
                                  // child: DropdownButton(
                                  //   isExpanded: true,
                                  //   value: selectedWeight,
                                  //   icon: Icon(Icons.keyboard_arrow_down),
                                  //   items: ConstanceData
                                  //       .vehicleWeight[selectedWeightIndex]
                                  //       .map((items) {
                                  //     return DropdownMenuItem(
                                  //       value: items,
                                  //       child: Text(items),
                                  //     );
                                  //   }).toList(),
                                  //   onChanged: (String value) {
                                  //     setState(() {
                                  //       selectedWeight = value;
                                  //       print(
                                  //           'selected weight changed ${value} AND ${ConstanceData.vehicleWeight[selectedWeightIndex].indexOf(value)}');
                                  //       selectedWeightIndex = ConstanceData
                                  //           .vehicleWeight[selectedWeightIndex]
                                  //           .indexOf(value);
                                  //     });
                                  //   },
                                  // ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Icon(
                                          FontAwesomeIcons.weight,
                                          color: Color(0xff0b0b0b),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(ConstanceData
                                            .vehicleWeight[selectedWeightIndex]
                                                [0]
                                            .toString()),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Radio(
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  current = value;
                                                });
                                              },
                                              value: truckType.open,
                                              groupValue: current,
                                            ),
                                            Image.asset(
                                              'assets/images/truck_1.webp',
                                              width: 50,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text('OPEN'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Radio(
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  current = value;
                                                });
                                              },
                                              value: truckType.closed,
                                              groupValue: current,
                                            ),
                                            Image.asset(
                                              'assets/images/truck_2.webp',
                                              width: 50,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text('CLOSED'),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    showLoaderDialog(context);
                                    if (emailController.text != null &&
                                        phoneController.text.isNotEmpty &&
                                        nameController.text.isNotEmpty) {
                                      if (isEmail(emailController.text)) {
                                        if (_isNumeric(phoneController.text) &&
                                            phoneController.text.length == 10) {
                                          sendOtp();
                                        } else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Enter a valid mobile number",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      } else {
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                            msg: "Enter a valid email",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    } else {
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: "Enter all the fields",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of('SIGN UP'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of('Already have an account?'),
                          style: Theme.of(context).textTheme.button.copyWith(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                              ),
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(' Sign In'),
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _selectedCountry(Country country) => Center(
  //       child: Padding(
  //         padding: const EdgeInsets.only(bottom: 16),
  //         child: Row(
  //           children: <Widget>[
  //             SizedBox(
  //               child: CountryPickerUtils.getDefaultFlagImage(country),
  //               height: 20,
  //               width: 24,
  //             ),
  //             SizedBox(
  //               width: 6,
  //             ),
  //             Icon(
  //               Icons.keyboard_arrow_down,
  //               color: Colors.black,
  //             )
  //           ],
  //         ),
  //       ),
  //     );

  // _openCountryPickerDialog() => showDialog(
  //       context: context,
  //       builder: (context) => CountryPickerDialog(
  //           searchCursorColor: Theme.of(context).primaryColor,
  //           searchInputDecoration: InputDecoration(hintText: 'Search...'),
  //           isSearchable: true,
  //           title: Text(
  //             'Select your phone code',
  //             style: Theme.of(context).textTheme.bodyText2.copyWith(
  //                   color: Theme.of(context).textTheme.headline6.color,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //           ),
  //           onValuePicked: (Country country) => setState(
  //                 () => _selectedDialogCountry = country,
  //               ),
  //           itemBuilder: _buildDialogItem),
  //     );

  // Widget _buildDialogItem(Country country) => Row(
  //       children: <Widget>[
  //         CountryPickerUtils.getDefaultFlagImage(country),
  //         SizedBox(width: 8.0),
  //         Expanded(
  //           child: Text(
  //             getCountryString(country.name),
  //           ),
  //         ),
  //         Container(
  //           child: Text(
  //             "+${country.phoneCode}",
  //             textAlign: TextAlign.end,
  //           ),
  //         ),
  //       ],
  //     );
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  String getCountryString(String str) {
    var newString = '';
    var isFirstdot = false;
    for (var i = 0; i < str.length; i++) {
      if (isFirstdot == false) {
        if (str[i] != ',') {
          newString = newString + str[i];
        } else {
          isFirstdot = true;
        }
      }
    }
    return newString;
  }

  String getCateg() {
    if (current == truckType.open) {
      return "OPEN";
    } else {
      return "CLOSED";
    }
  }

  showLoaderDialog(BuildContext context) {
    alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void sendOtp() async {
    await auth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneController.text,
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential).then((value) {

            Access()
                .register(signupdata(
                    nameController.text,
                    emailController.text,
                    phoneController.text,
                    ConstanceData.vehicleType[selectedVehicleIndex].toString(),
                    getCateg(),
                    ConstanceData.vehicleWeight[selectedWeightIndex][0]
                        .toString(),
                    '',
                    vehicleId()))
                .then((value) => {
                      ConstanceData.prof = null,
                      ConstanceData.clear(),
                      // ConstanceData.prof = value,
                      // ConstanceData.saveId(value.user_id.toString()),
                      // print("Here ${value.user_id}"),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      )
                    });
          });
        },
        timeout: const Duration(seconds: 60),
        verificationFailed: (error) {
          Fluttertoast.showToast(
              msg: "$error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        },
        codeSent: (String verificationId, int resendToken) async {
          print(verificationId);
          print(resendToken);
          // Create a PhoneAuthCredential with the code
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhoneVerification(signupdata(
                  nameController.text,
                  emailController.text,
                  phoneController.text,
                  ConstanceData.vehicleType[selectedVehicleIndex].toString(),
                  getCateg(),
                  ConstanceData.vehicleWeight[selectedWeightIndex][0]
                      .toString(),
                  verificationId,
                  vehicleId())),
            ),
          );
        },
        codeAutoRetrievalTimeout: (xc) {});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentPosition() async {
    position = await _determinePosition();
  }

  int vehicleId() {
    for (var a in ConstanceData.vehicletype) {
      if (a.vehicle ==
          ConstanceData.vehicleType[selectedVehicleIndex].toString()) {
        return a.vehicle_id;
      }
    }
  }
  String getName(vehicle_id) {
    for (var i in ConstanceData.vehicletype) {
      if (vehicle_id == i.vehicle_id.toString()) {
        return i.vehicle;
      }
    }
  }
}
