import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mime/mime.dart';
import 'package:my_cab_driver/Model/Document.dart';
import 'package:my_cab_driver/Model/Order.dart';
import 'package:my_cab_driver/Model/SignUpData.dart';
import 'package:my_cab_driver/Model/TimeDistance.dart';
import 'package:my_cab_driver/Model/Turn.dart';
import 'package:my_cab_driver/Model/Vehicle.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Dio dio;

  BaseOptions option =
      BaseOptions(connectTimeout: 10000, receiveTimeout: 10000, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'APP-KEY': ConstanceData.app_key
  });

//++++++++++++++++++++++++++++++++++++++++++
  //AUTH
  Future login(String number) async {
    dio = Dio(option);
    print(url);
    try {
      Response response = await dio.post(url, data: {
        'phone': number,
        'country_code': '+91',
      });
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "${response.data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("${response.data['message']}");
        return response.data['data'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  Future signup(signupdata data) async {
    dio = Dio(option);
    try {
      Response response = await dio.post(url, data: {
        'phone': data.phone,
        'email': data.email,
        'name': data.name,
        'country_code': '+91',
        'designation': 'Truck Driver',
        // 'vehicle_name': data.type,
        'vehicle_type': data.category,
        // 'capacity': data.weight,
        'vehicle_id': data.vehicle_id,
        'model_id': data.model_id,
      });
      if (response.statusCode == 200) {
        print("${response.data['message']}");
        Fluttertoast.showToast(
            msg: "${response.data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return response.data['data'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  //+++++++++++++++++++++++++++++++++++
  //Get
  Future getProfile() async {
    dio = Dio(option);

    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "${response.data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // ConstanceData.image_url = response.data['image_url'];
        print('idasd ${response.data['data']['user_id']}');
        return response.data['data'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  Future getOrderDetails(id) async {
    dio = Dio(option);

    try {
      Response response = await dio.post(url, data: {
        'id': id,
      });
      if (response.statusCode == 200) {
        print(response.data['data']);
        var data = response.data['data'] as List;
        List<Order> list = data.map((e) => Order.fromJson(e)).toList();
        return list;
      } else {
        List<Order> list = new List<Order>();
        return list;
      }
    } on DioError catch (e) {
      print(e.message);
      List<Order> list = new List<Order>();
      return list;
    }
  }
  Future getVehicles() async {
    dio = Dio(option);

    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "${response.data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // ConstanceData.image_url = response.data['image_url'];
        print(ConstanceData.image_url);
        var data = response.data['vehicle'] as List;
        List<vehicleModel> list =
        data.map((e) => vehicleModel.fromJson(e)).toList();

        return list;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++
  //Updating
  Future uploadPicture(String path) async {
    final mimedatatype =
        lookupMimeType(path, headerBytes: [0xFF, 0xD8]).split('/');

    http.MultipartFile file = await http.MultipartFile.fromPath(
        'profile_img', path,
        filename: 'profile_img0',
        contentType: new MediaType(mimedatatype[0], mimedatatype[1]));
    final imageUpload = http.MultipartRequest('POST', Uri.parse(url));

    imageUpload.files.add(file);
    imageUpload.fields['id'] = await ConstanceData.id.toString();
    imageUpload.headers['APP-KEY'] = ConstanceData.app_key;
    imageUpload.headers['Content-Type'] = "multipart/form-data";
    try {
      final streamResp = await imageUpload.send();
      print(streamResp.stream);
      final response = await http.Response.fromStream(streamResp);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("${responseData}");
        return responseData['message'];
      } else {
        print("${response.statusCode} ${response}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future UploadDocument(document doc) async {
    final mimedatatype =
        lookupMimeType(doc.rc, headerBytes: [0xFF, 0xD8]).split('/');

    http.MultipartFile rc = await http.MultipartFile.fromPath(
        'registration[]', doc.rc,
        filename: 'registration0',
        contentType: new MediaType(mimedatatype[0], mimedatatype[1]));

    final mimedatatype1 =
        lookupMimeType(doc.insurance, headerBytes: [0xFF, 0xD8]).split('/');
    http.MultipartFile insurance = await http.MultipartFile.fromPath(
        'insurance_c[]', doc.insurance,
        filename: 'insurance0',
        contentType: new MediaType(mimedatatype1[0], mimedatatype1[1]));

    final mimedatatype2 =
        lookupMimeType(doc.puc, headerBytes: [0xFF, 0xD8]).split('/');

    http.MultipartFile puc = await http.MultipartFile.fromPath(
        'puc_c[]', doc.puc,
        filename: 'puc0',
        contentType: new MediaType(mimedatatype2[0], mimedatatype2[1]));

    final mimedatatype3 =
        lookupMimeType(doc.tax, headerBytes: [0xFF, 0xD8]).split('/');

    http.MultipartFile tax = await http.MultipartFile.fromPath(
        'tax_c[]', doc.tax,
        filename: 'tax0',
        contentType: new MediaType(mimedatatype3[0], mimedatatype3[1]));

    final mimedatatype4 =
        lookupMimeType(doc.fitness, headerBytes: [0xFF, 0xD8]).split('/');
    http.MultipartFile fitness = await http.MultipartFile.fromPath(
        'fitness_c[]', doc.fitness,
        filename: 'fitness0',
        contentType: new MediaType(mimedatatype4[0], mimedatatype4[1]));

    final mimedatatype5 =
        lookupMimeType(doc.permit, headerBytes: [0xFF, 0xD8]).split('/');

    http.MultipartFile permit = await http.MultipartFile.fromPath(
        'permit_c[]', doc.permit,
        filename: 'permit0',
        contentType: new MediaType(mimedatatype5[0], mimedatatype5[1]));

    final mimedatatype6 =
        lookupMimeType(doc.driving, headerBytes: [0xFF, 0xD8]).split('/');

    http.MultipartFile driving = await http.MultipartFile.fromPath(
        'driving_license[]', doc.driving,
        filename: 'driving0',
        contentType: new MediaType(mimedatatype6[0], mimedatatype6[1]));

    final imageUpload = http.MultipartRequest('POST', Uri.parse(url));

    imageUpload.files.add(rc);
    imageUpload.files.add(insurance);
    imageUpload.files.add(puc);
    imageUpload.files.add(tax);
    imageUpload.files.add(fitness);
    imageUpload.files.add(permit);
    imageUpload.files.add(driving);
    imageUpload.fields['id'] = await ConstanceData.id.toString();
    imageUpload.headers['APP-KEY'] = ConstanceData.app_key;
    imageUpload.headers['Content-Type'] = "multipart/form-data";
    try {
      final streamResp = await imageUpload.send();
      print(streamResp.stream);
      final response = await http.Response.fromStream(streamResp);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("${responseData}");
        return responseData['message'];
      } else {
        print("${response.statusCode} ${response}");
      }
    } catch (e) {
      print(e);
    }
  }



  Future saveDriverPrice(String price) async {
    dio = Dio(option);

    try {
      Response response = await dio.post(url, queryParameters: {
        'user_id': ConstanceData.id.toString(),
        'driver_rate': price,
      });
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "${response.data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  Future saveVehicle(vehicleModel1 vehicle) async {
    dio = Dio(option);

    try {
      Response response = await dio.post(url, queryParameters: {
        'id': ConstanceData.id.toString(),
        'vehicle_id': vehicle.vehicle_id,
        'loadcapacity': vehicle.loadcapacity,
        'vehicle_type': vehicle.vehicle_type,
        'model_id': vehicle.model_id,
      });
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "${response.data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  Future updateLiveLocation(LatLng location) async {
    dio = Dio(option);

    try {
      Response response = await dio.post(url, queryParameters: {
        'id': ConstanceData.id.toString(),
        'latitude': location.latitude,
        'longitude': location.longitude,
      });
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "${ConstanceData.id.toString()} ${response.data['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  Future getTimeEstimate(Location start,Location end) async {
    dio = Dio(option);

    try {
      Response response = await dio.post(url, queryParameters: {
        'units': 'metric',
        'origins': '${start.latitude},${start.longitude}',
        'destinations': '${end.latitude},${end.longitude}',
        'key': 'AIzaSyB8ifq-XuxU1OIKxEwVohxAcE7cywSajMk',
      });
      if (response.statusCode == 200) {
        timeDistance data = timeDistance.fromJson(response.data['rows'][0]['elements'][0]);

        print('response ${response.data}');

        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }
  Future getTurnByTurnDirections(Location start,Location end) async {
    dio = Dio(option);

    try {
      Response response = await dio.post(url, queryParameters: {
        'units': 'metric',
        'origin': '${start.latitude},${start.longitude}',
        'destination': '${end.latitude},${end.longitude}',
        'key': 'AIzaSyB8ifq-XuxU1OIKxEwVohxAcE7cywSajMk',
      });
      if (response.statusCode == 200) {
        turn data = turn.fromJson(response.data['routes'][0]['elements'][0]);

        print('response ${response.data}');

        return data;
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }
  Future acceptOrder(String order_id,status,driver_id) async {
    dio = Dio(option);

    try {
      Response response = await dio.post(url, queryParameters: {
        'order_id': order_id,
        'status': status,
        'driver_id': driver_id,
      });
      if (response.statusCode == 200) {


        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }
  Future endOrder(String order_id, status) async {
    dio = Dio(option);

    try {
      Response response = await dio.post(url, queryParameters: {
        'order_id': order_id,
        'status': status,
      });
      if (response.statusCode == 200) {


        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  Future start_trip(String user_id) async {
    dio = Dio(option);
    print(user_id);
    try {
      Response response = await dio.post(url, queryParameters: {
        'user_id': user_id,
      });
      if (response.statusCode == 200) {

        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }
  Future verify_trip(String user_id, otp) async {
    dio = Dio(option);

    try {
      Response response = await dio.post(url, queryParameters: {
        'user_id': user_id,
        'otp': otp,
      });
      if (response.statusCode == 200) {
        print(response.data['message']);
        return response.data['message'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }


}




//+++++++++++++++++++++++++++++++++++++++++++++++++
