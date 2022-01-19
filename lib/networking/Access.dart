

import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/constance/constance.dart';

import 'Networking.dart';

class Access {

  static final login_url = ConstanceData.url+"login";
  static final signup_url = ConstanceData.url+"register";
  static final document_url = ConstanceData.url+"document-upload";
  static final otp_vrification_url = ConstanceData.url+"otp-verification";
  static final login_otp_vrification_url = ConstanceData.url+"login-otp-verification";

  Future<dynamic> login() async{

    NetworkHelper helper = NetworkHelper(login_url);
    var data = await helper.login("");

  }

}