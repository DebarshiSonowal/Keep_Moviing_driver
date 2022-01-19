import 'package:animator/animator.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';

import '../main.dart';
import 'loginOTP.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Country _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('IN');
  String countryCode = "+91";
  var controller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), (){
          if(auth.currentUser!=null){
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.HOME, (Route<dynamic> route) => false);
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 220,
              color: Theme.of(context).primaryColor,
              child: Animator(
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
                    fit: BoxFit.fill,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            Container(
              padding:EdgeInsets.only(right: 14, left: 14,),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 18, right: 18),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      AppLocalizations.of('Login'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .color,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      AppLocalizations.of(' With Your'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .color,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of('phone number'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(padding: EdgeInsets.only(left: 10),
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      color: Theme.of(context).dividerColor),
                                  color: Theme.of(context).backgroundColor,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: TextFormField(
                                          autofocus: false,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .color,
                                              ),
                                          controller: controller,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'Mobile Number',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  if (controller.text.isNotEmpty&&controller.text.length==10) {
                                    sendOtp();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please enter a valid number",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of('NEXT'),
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
                              SizedBox(
                                height: 20,
                              ),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex:3,
                          child:SizedBox()
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
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

  // void _openCountryPickerDialog() => showDialog(
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

  void sendOtp() async {
    await auth.verifyPhoneNumber(
        phoneNumber: '+91' + controller.text,
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential).then((value) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.HOME, (Route<dynamic> route) => false);
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => login_otp(controller.text,verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (xc) {});
  }
}
