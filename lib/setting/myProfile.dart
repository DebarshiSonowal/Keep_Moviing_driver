import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/setting/editProfile.dart';
import '../main.dart';
import 'package:my_cab_driver/constance/constance.dart' as constance;

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool selectFirstColor = false;
  bool selectSecondColor = false;
  bool selectThirdColor = false;
  bool selectFourthColor = false;
  bool selectFifthColor = false;
  bool selectSixthColor = false;
  final ImagePicker _picker = ImagePicker();
  Position position;
  XFile pic;
  String place;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text('Profile Photo'),
                                    content: StatefulBuilder(
                                        builder: (cont, stateSet) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              radius: MediaQuery.of(context)
                                                          .size
                                                          .width <=
                                                      320
                                                  ? 36
                                                  : 46,
                                              child: ClipRRect(
                                                borderRadius: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width <=
                                                        320
                                                    ? BorderRadius.circular(40)
                                                    : BorderRadius.circular(60),
                                                child: pic != null
                                                    ? Image.file(
                                                        File(pic.path),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        ConstanceData.user3,
                                                      ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                var path =
                                                    await _picker.pickImage(
                                                  source: ImageSource.gallery,
                                                  imageQuality: 50,
                                                );
                                                stateSet(() {
                                                  pic = path;
                                                });
                                              },
                                              child: Text('Select Image'),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          pic = null;
                                        },
                                        child: Text('Go Back'),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text('Save'),
                                      )
                                    ],
                                  ));
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width <= 320
                              ? 36
                              : 46,
                          child: ClipRRect(
                            borderRadius:
                                MediaQuery.of(context).size.width <= 320
                                    ? BorderRadius.circular(40)
                                    : BorderRadius.circular(60),
                            child: Image.asset(
                              ConstanceData.user3,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${ConstanceData.prof.name}',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                      ),
                      Text(
                        'Gold Member',
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 14, left: 14, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Text(
                  AppLocalizations.of('THEME'),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).disabledColor,
                      ),
                ),
              ],
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              openShowPopup();
            },
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 14, top: 8, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of('Theme Mode'),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).disabledColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 14, left: 14, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Text(
                  AppLocalizations.of('LANGUAGE'),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).disabledColor,
                      ),
                ),
              ],
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              openShowPopupLanguage();
            },
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 14, top: 8, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of('Select your Language'),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).disabledColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 14, left: 14, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Text(
                  AppLocalizations.of('INFORMATION'),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).disabledColor,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView(
              children: <Widget>[
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Username'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '${ConstanceData.prof.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Phone number'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '${ConstanceData.prof.phone}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Email'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '${ConstanceData.prof.email}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('City'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              AppLocalizations.of(
                                  '${ConstanceData.prof.city == null ? place : ConstanceData.prof.city}'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('GST'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              AppLocalizations.of(
                                  '${ConstanceData.prof.GST == null ? 'Not Available' : ConstanceData.prof.GST}'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Vehicle'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              AppLocalizations.of(
                                  '${getName(ConstanceData.prof.vehicle_id.toString())}'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Type'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '${ConstanceData.prof.vehicle_type}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Capacity'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              AppLocalizations.of(
                                  '${ConstanceData.prof.load_capacity}'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Document'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color,
                                  ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              AppLocalizations.of(
                                  '${ConstanceData.prof.driving_license == null ? "NOT UPLOADED" : getStatus(ConstanceData.prof.status)}'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).disabledColor,
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  openShowPopupLanguage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                AppLocalizations.of('Select Language'),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline6.color,
                      fontSize: 18,
                    ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('en');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'English',
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('fr');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('French'),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('ar');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('Arabic'),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('ja');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('Japanese'),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  selectLanguage(String languageCode) {
    constance.locale = languageCode;
    MyApp.setCustomeLanguage(context, languageCode);
  }

  openShowPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                AppLocalizations.of('Select theme mode'),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline6.color,
                      fontSize: 18,
                    ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        changeColor(light);
                      },
                      child: CircleAvatar(
                        radius: 34,
                        backgroundColor:
                            Theme.of(context).textTheme.headline6.color,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 32,
                          child: Text(
                            AppLocalizations.of('Light'),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        changeColor(dark);
                      },
                      child: CircleAvatar(
                        radius: 34,
                        backgroundColor:
                            Theme.of(context).textTheme.headline6.color,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 32,
                          child: Text(
                            AppLocalizations.of('Dark'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectfirstColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFEB1165),
                        child: !selectFirstColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectsecondColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFF32a852),
                        child: selectSecondColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectthirdColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFe6230e),
                        child: selectThirdColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectfourthColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFF760ee6),
                        child: selectFourthColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectfifthColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFdb0ee6),
                        child: selectFifthColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectsixthColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFdb164e),
                        child: selectSixthColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  selectfirstColor() {
    if (selectFirstColor) {
      setState(() {
        selectFirstColor = false;
        selectSecondColor = false;
        selectThirdColor = false;
        selectFourthColor = false;
        selectFifthColor = false;
        selectSixthColor = false;
      });
      MyApp.setCustomeTheme(context, 0);
    }
  }

  selectsecondColor() {
    if (!selectSecondColor) {
      setState(() {
        selectFirstColor = true;
        selectSecondColor = true;
        selectThirdColor = false;
        selectFourthColor = false;
        selectFifthColor = false;
        selectSixthColor = false;
      });
      MyApp.setCustomeTheme(context, 1);
    }
  }

  selectthirdColor() {
    if (!selectThirdColor) {
      setState(() {
        selectFirstColor = true;
        selectSecondColor = false;
        selectThirdColor = true;
        selectFourthColor = false;
        selectFifthColor = false;
        selectSixthColor = false;
      });
    }
    MyApp.setCustomeTheme(context, 2);
  }

  selectfourthColor() {
    if (!selectFourthColor) {
      setState(() {
        selectFirstColor = true;
        selectSecondColor = false;
        selectThirdColor = false;
        selectFourthColor = true;
        selectFifthColor = false;
        selectSixthColor = false;
      });
    }
    MyApp.setCustomeTheme(context, 3);
  }

  selectfifthColor() {
    if (!selectFifthColor) {
      setState(() {
        selectFirstColor = true;
        selectSecondColor = false;
        selectThirdColor = false;
        selectFourthColor = false;
        selectFifthColor = true;
        selectSixthColor = false;
      });
    }
    MyApp.setCustomeTheme(context, 4);
  }

  selectsixthColor() {
    if (!selectSixthColor) {
      setState(() {
        selectFirstColor = true;
        selectSecondColor = false;
        selectThirdColor = false;
        selectFourthColor = false;
        selectFifthColor = false;
        selectSixthColor = true;
      });
    }
    MyApp.setCustomeTheme(context, 5);
  }

  int light = 1;
  int dark = 2;

  changeColor(int color) {
    if (color == light) {
      MyApp.setCustomeTheme(context, 6);
    } else {
      MyApp.setCustomeTheme(context, 7);
    }
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.headline6.color,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => edit_profile(),
                ),
              );
            },
            child: Text(
              AppLocalizations.of('Edit'),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String getName(vehicle_id) {
    for (var i in ConstanceData.vehicletype) {
      if (vehicle_id == i.vehicle_id.toString()) {
        return i.vehicle;
      }
    }
  }

  void getLocation() async {
    position = await _determinePosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (mounted) {
      setState(() {
        place = placemarks[0].name.toString();
        print(place);
      });
    } else {
      place = placemarks[0].name.toString();
      print(place);
    }
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

  getStatus(String id) {
    if (id == '2') {
      return "Verified";
    } else {
      return 'Not verified';
    }
  }

  void getPic() async {}
}
