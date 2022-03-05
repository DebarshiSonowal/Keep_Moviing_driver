import 'package:flutter/material.dart';
import 'package:my_cab_driver/Language/LanguageData.dart';
import 'package:my_cab_driver/Model/MockOrder.dart';
import 'package:my_cab_driver/Model/Order.dart';
import 'package:my_cab_driver/Model/Profile.dart';
import 'package:my_cab_driver/Model/Vehicle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConstanceData {
  static final splashBackground = "assets/images/building_image.webp";
  static final acceptjob = "assets/images/acceptjob.webp";
  static final location = "assets/images/location.webp";
  static final wallet = "assets/images/wallet.webp";
  static final enableLocation = "assets/images/enableLocation.webp";
  static final appicon = "assets/images/app_icon.webp";
  static final userImage = "assets/images/user.webp";
  static final mylocation = "assets/images/mylocation.webp";
  static final mylocation1 = "assets/images/mylocation1.webp";
  static final mylocation2 = "assets/images/mylocation2.webp";
  static final mylocation3 = "assets/images/mylocation3.webp";
  static final user1 = "assets/images/1.webp";
  static final user2 = "assets/images/2.webp";
  static final user3 = "assets/images/3.webp";
  static final user4 = "assets/images/4.webp";
  static final user5 = "assets/images/5.webp";
  static final user6 = "assets/images/6.webp";
  static final user7 = "assets/images/7.webp";
  static final user8 = "assets/images/8.webp";
  static final user9 = "assets/images/9.webp";

  static final Color secoundryFontColor = Colors.white;
  static final Color DrawerFontColor = Color(0xff0b0b0b);

  static final url = "https://reinventmyskills.com/keep/public/api/driver/";
  static final app_key = "jXIIci1Uxirg7MU33cu9qu1PL4kgUIi74Q7yGiFE";

  static String image_url="https://reinventmyskills.com/keep/public/";

  static String id;
  static profile prof;

  static bool serviceEnabled=false;

  static setBool() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    serviceEnabled = !serviceEnabled;
    await prefs.setBool('enabled',serviceEnabled);
  }
  static getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    serviceEnabled = prefs.getBool('enabled');
    return serviceEnabled;
  }

  static setProfile( profile data) {
    prof = data;
  }

  static saveId(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', data);
    id = data;
    print("Saved ${id}id");
  }
  static clear() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    print("init ${id}");
    return id;
  }

  static List<vehicleModel> vehicletype;

  static List<Order> orders;
  static addOrders(List<Order> list) async {

    orders = list;

    print('asdaqr ${list.length}');

  }

  static List<mockOrder> mockOrders =
  [
    mockOrder('Esther Berry','79 Swift Village','115 William St, Chicago, US',25.00,2.2,[
      'Cash',
      'Card'
    ]),
    mockOrder('Subhankar ','Kolkata','Delhi',225.00,22.2,[
      'Cash',
      'Card'
    ]),
    mockOrder('Debarshi','Guwahati','Shillong',55.00,15.2,[
      'Cash',
      'Card'
    ]),
  ];

  static setVehicleType(List<vehicleModel> list){
    vehicletype = list;
    print("Vehicle ");
  }

  // static final vehicleType = [
  //   '4.5 Ton',
  //   'E-Rickshaw',
  //   'Large Pickup',
  //   'Loader Rickshaw',
  //   'Mini Truck',
  //   'Small Pickup'
  // ];
  //
  // static final vehicleWeight = [
  //   ['7 Ton'],
  //   ['50 KG'],
  //   ['100 Ton'],
  //   ['50 KG'],
  //   ['1 Ton'],
  //   ['50 KG']
  // ];

  List<String> colors = [
    '#EB1165',
    '#32a852',
    '#e6230e',
    '#760ee6',
    '#db0ee6',
    '#db164e'
  ];
}

// Locale locale;
String locale = "en";

int colorsIndex = 0;

AllTextData allTextData;

var primaryColorString = '#2E3192';
var secondaryColorString = '#FFCB08';

