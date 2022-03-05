import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_cab_driver/Model/Document.dart';
import 'package:my_cab_driver/Model/Order.dart';
import 'package:my_cab_driver/Model/Profile.dart';
import 'package:my_cab_driver/Model/SignUpData.dart';
import 'package:my_cab_driver/Model/Vehicle.dart';
import 'package:my_cab_driver/constance/constance.dart';

import 'Networking.dart';

class Access {
  static final login_url = ConstanceData.url + "login-driver";
  static final signup_url = ConstanceData.url + "register";
  static final document_url = ConstanceData.url + "document-upload";
  static final otp_vrification_url = ConstanceData.url + "otp-verification";

  static final get_profile_url = ConstanceData.url + "get-profile/";
  static final get_vehicle_url = ConstanceData.url + "get-vehicle";
  static final get_order_details_url = ConstanceData.url + "order-details";

  static final driver_rate_url = ConstanceData.url + "driver-rate";
  static final update_profile_url = ConstanceData.url + "update-profile";
  static final update_profile_pic_url = ConstanceData.url + "profile-picture";
  static final update_live_location_url = ConstanceData.url + "location-update";
  static final accept_url = ConstanceData.url + "accept";
  static final end_url = ConstanceData.url + "end";


  static final time_distance_url = "https://maps.googleapis.com/maps/api/distancematrix/json";
  static final login_otp_vrification_url =
      ConstanceData.url + "login-otp-verification";



  Future<dynamic> login(String number) async {
    NetworkHelper helper = NetworkHelper(login_url);
    var data = await helper.login(number);
    profile prof = profile.fromJson(data);
    return prof;
  }

  Future<dynamic> register(signupdata data) async {
    NetworkHelper helper = NetworkHelper(signup_url);

    var returndata = await helper.signup(data);

    print("Sign ${returndata}");
    profile prof = profile.fromJson(returndata);
    return prof;
  }

  Future<dynamic> getProfile() async {
    NetworkHelper helper =
        NetworkHelper(get_profile_url + ConstanceData.id.toString());

    var returndata = await helper.getProfile();
    print("the id ${ConstanceData.id}");
    profile prof = profile.fromJson(returndata);
    return prof;
  }

  Future<dynamic> uploadDocument(document doc) async {
    NetworkHelper helper = NetworkHelper(document_url);

    var data = await helper.UploadDocument(doc);

    return data;
  }

  Future<dynamic> getVehicles() async {
    NetworkHelper helper = NetworkHelper(get_vehicle_url);

    List<vehicleModel> data = await helper.getVehicles();
    return data;
  }
  Future<dynamic> getOrders(id) async {
    NetworkHelper helper = NetworkHelper(get_order_details_url);

    List<Order> data = await helper.getOrderDetails(id);
    return data;
  }

  Future<dynamic> setPrice(String price) async {
    NetworkHelper helper = NetworkHelper(driver_rate_url);

    var data = await helper.saveDriverPrice(price);

    return data;
  }

  Future<dynamic> saveVehicle(vehicleModel1 vehicle) async {
    NetworkHelper helper = NetworkHelper(update_profile_url);

    var data = await helper.saveVehicle(vehicle);

    return data;
  }

  Future<dynamic> uploadPicture(String path) async {
    NetworkHelper helper = NetworkHelper(update_profile_pic_url);

    var data = await helper.uploadPicture(path);

    return data;
  }
  Future<dynamic> uploadLocation(LatLng location) async {
    NetworkHelper helper = NetworkHelper(update_live_location_url);

    var data = await helper.updateLiveLocation(location);

    return data;
  }
  Future<dynamic> getTimeEstimate(Location start,Location end) async {
    NetworkHelper helper = NetworkHelper(time_distance_url);

    var data = await helper.getTimeEstimate(start,end);

    return data;
  }
  Future<dynamic> acceptOrder(String order_id,status,driver_id) async {
    NetworkHelper helper = NetworkHelper(accept_url);

    var data = await helper.acceptOrder(order_id,status,driver_id);

    return data;
  }
  Future<dynamic> endOrder(String order_id,status) async {
    NetworkHelper helper = NetworkHelper(end_url);

    var data = await helper.endOrder(order_id,status);

    return data;
  }
}
