import 'dart:convert';

import 'package:erpvc/api_hleper/api_helper.dart';
import 'package:erpvc/repos/user_repository.dart';
import 'package:flutter/services.dart';

class InventoryRepo {
  final UserRepository? userRepository;

  InventoryRepo(this.userRepository);

  Future<dynamic> getInwatdNumber() async {
    const url = 'Inward/getinwardno';
    Map<String, String> headers = {
      "Authorization": userRepository!.user!.data!.accessToken.toString()
    };
    final response = await APIHelper().get(endpoint: url, headers: headers);
    print("responseData ${response.statusCode}");
    if (response.statusCode == 200) {
      return response;
    }
    return response;
  }

  Future<dynamic> getPartyList() async {
    const url = 'vendor/list';
    Map<String, String> headers = {
      "Authorization": userRepository!.user!.data!.accessToken.toString()
    };
    final response = await APIHelper().get(endpoint: url, headers: headers);
    if (response.statusCode == 200) {
      return response;
    }
    return response;
  }

  Future<dynamic> getProfileData() async {
    const url = 'user/profile';
    Map<String, String> headers = {
      "Authorization": userRepository!.user!.data!.accessToken.toString()
    };
    final response = await APIHelper().get(endpoint: url, headers: headers);
    if (response.statusCode == 200) {
      return response;
    }
    return response;
  }

  //barcode_no:49956775222
  // //keywords:cable
  Future<dynamic> searchProduct({
    required Map<String, dynamic> data,
  }) async {
    const url = 'product/list';
    Map<String, String> headers = {
      "Authorization": userRepository!.user!.data!.accessToken.toString()
    };
    final response =
    await APIHelper().post(endpoint: url, headers: headers, bodyData: data);
    if (response.statusCode == 200) {
      return response;
    }
    return response;
  }

  Future<dynamic> createInward({
    required Map<String, String> data,String? type,Map<String, String>? fileData,
  }) async {
    var url ;
    if(type=="Edit Entry"){
    url= 'inward/edit';
    }
    else{
    url = 'inward/add';
    }
    Map<String, String> headers = {
      "Authorization": userRepository!.user!.data!.accessToken.toString()
    };
    final response =
    await APIHelper().multiPartRequest(endpoint: url, headers: headers, bodyData: data,filesData: fileData);
    if (response.statusCode == 200) {
      return response;
    }
    return response;
  }

    Future<Map<dynamic,dynamic>> readJsonData({required String path}) async {

    // read json file
    final jsondata = await  rootBundle.loadString(path);

    // decode json data as list
    final list = json.decode(jsondata) as Map;

    // map json and initialize
    // using DataModel
    return list;
  }

  Future<dynamic> getInventoryProducts() async {
    const url = 'inventory/list';
    Map<String, String> headers = {
      "Authorization": userRepository!.user!.data!.accessToken.toString()
    };
    final response =
    await APIHelper().get(endpoint: url, headers: headers);
    if (response.statusCode == 200) {
      return response;
    }
    return response;
  }


}
