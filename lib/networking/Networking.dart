import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mime/mime.dart';
import 'package:my_cab_driver/Model/Document.dart';
import 'package:my_cab_driver/Model/SignUpData.dart';
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
        'vehicle_name': data.type,
        'vehicle_type': data.category,
        'capacity': data.weight,
        'vehicle_id':data.vehicle_id
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
        return response.data['data'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

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
        return response.data['data'];
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.message);
      return 'Failed';
    }
  }

  Future UploadDocument(document doc) async {
    final mimedatatype =
        lookupMimeType(doc.rc[0], headerBytes: [0xFF, 0xD8]).split('/');

    List<http.MultipartFile> rc = new List<http.MultipartFile>();

    rc.add(await http.MultipartFile.fromPath('registration[]', doc.rc[0],
        filename: 'registration0',
        contentType: new MediaType(mimedatatype[0], mimedatatype[1])));
    rc.add(await http.MultipartFile.fromPath('registration[]', doc.rc[1],
        filename: 'registration1',
        contentType: new MediaType(mimedatatype[0], mimedatatype[1])));

    final mimedatatype1 =
        lookupMimeType(doc.insurance[0], headerBytes: [0xFF, 0xD8]).split('/');
    List<http.MultipartFile> insurance = new List<http.MultipartFile>();

    insurance.add(await http.MultipartFile.fromPath(
        'insurance_c[]', doc.insurance[0],
        filename: 'insurance0',
        contentType: new MediaType(mimedatatype1[0], mimedatatype1[1])));
    insurance.add(await http.MultipartFile.fromPath(
        'insurance_c[]', doc.insurance[1],
        filename: 'insurance1',
        contentType: new MediaType(mimedatatype1[0], mimedatatype1[1])));

    final mimedatatype2 =
        lookupMimeType(doc.puc[0], headerBytes: [0xFF, 0xD8]).split('/');

    List<http.MultipartFile> puc = new List<http.MultipartFile>();

    puc.add(await http.MultipartFile.fromPath('puc_c[]', doc.puc[0],
        filename: 'puc0',
        contentType: new MediaType(mimedatatype2[0], mimedatatype2[1])));
    puc.add(await http.MultipartFile.fromPath('puc_c[]', doc.puc[1],
        filename: 'puc1',
        contentType: new MediaType(mimedatatype2[0], mimedatatype2[1])));

    final mimedatatype3 =
        lookupMimeType(doc.tax[0], headerBytes: [0xFF, 0xD8]).split('/');

    List<http.MultipartFile> tax = new List<http.MultipartFile>();

    tax.add(await http.MultipartFile.fromPath('tax_c[]', doc.tax[0],
        filename: 'tax0',
        contentType: new MediaType(mimedatatype3[0], mimedatatype3[1])));
    tax.add(await http.MultipartFile.fromPath('tax_c[]', doc.tax[1],
        filename: 'tax1',
        contentType: new MediaType(mimedatatype3[0], mimedatatype3[1])));

    final mimedatatype4 =
        lookupMimeType(doc.fitness[0], headerBytes: [0xFF, 0xD8]).split('/');
    List<http.MultipartFile> fitness = new List<http.MultipartFile>();

    fitness.add(await http.MultipartFile.fromPath('fitness_c[]', doc.fitness[0],
        filename: 'fitness0',
        contentType: new MediaType(mimedatatype4[0], mimedatatype4[1])));
    fitness.add(await http.MultipartFile.fromPath('fitness_c[]', doc.fitness[1],
        filename: 'fitness1',
        contentType: new MediaType(mimedatatype4[0], mimedatatype4[1])));

    final mimedatatype5 =
        lookupMimeType(doc.permit[0], headerBytes: [0xFF, 0xD8]).split('/');

    List<http.MultipartFile> permit = new List<http.MultipartFile>();

    permit.add(await http.MultipartFile.fromPath('permit_c[]', doc.permit[0],
        filename: 'permit0',
        contentType: new MediaType(mimedatatype5[0], mimedatatype5[1])));
    permit.add(await http.MultipartFile.fromPath('permit_c[]', doc.permit[1],
        filename: 'permit1',
        contentType: new MediaType(mimedatatype5[0], mimedatatype5[1])));

    final mimedatatype6 =
        lookupMimeType(doc.driving[0], headerBytes: [0xFF, 0xD8]).split('/');

    List<http.MultipartFile> driving = new List<http.MultipartFile>();

    driving.add(await http.MultipartFile.fromPath(
        'driving_license[]', doc.driving[0],
        filename: 'driving0',
        contentType: new MediaType(mimedatatype6[0], mimedatatype6[1])));
    driving.add(await http.MultipartFile.fromPath(
        'driving_license[]', doc.driving[1],
        filename: 'driving1',
        contentType: new MediaType(mimedatatype6[0], mimedatatype6[1])));

    final imageUpload = http.MultipartRequest('POST', Uri.parse(url));

    imageUpload.files.addAll(rc);
    imageUpload.files.addAll(insurance);
    imageUpload.files.addAll(puc);
    imageUpload.files.addAll(tax);
    imageUpload.files.addAll(fitness);
    imageUpload.files.addAll(permit);
    imageUpload.files.addAll(driving);
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

        var data = response.data['data'] as List;

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

  Future saveVehicle(vehicleModel1 vehicle) async{
    dio = Dio(option);

    try {
      Response response = await dio.post(url, queryParameters: {
        'id': ConstanceData.id.toString(),
        'vehicle_id': vehicle.vehicle_id,
        'loadcapacity':vehicle.loadcapacity,
        'vehicle_type':vehicle.vehicle_type,
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

}
