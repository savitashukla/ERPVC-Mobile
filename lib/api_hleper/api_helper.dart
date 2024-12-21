import 'dart:convert';

import 'package:erpvc/helper/app_constant.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIHelper {
  static final APIHelper _apiHelper = APIHelper.instance();

  factory APIHelper() {
    return _apiHelper;
  }

  APIHelper.instance();

  final client = http.Client();

  Future<http.Response> get(
      {String? endpoint, Map<String, String>? headers}) async {
    var url = Uri.parse("${AppConstant.BASE_URL}$endpoint");
    var response = await client.get(url!, headers: headers ?? {});
    return response;
  }

  Future<http.StreamedResponse> multiPartRequest(
      {String? endpoint,
      Map<String, String>? headers,
        Map<String,String>? filesData,
      Map<String,String>? bodyData}) async {
    var url = Uri.parse("${AppConstant.BASE_URL}$endpoint");
    debugPrint("url $url");
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll(bodyData!);
    request.headers.addAll(headers!);
    print("files Data $filesData");
    filesData!.forEach((key, value) async{

        request.files.add(await http.MultipartFile.fromPath(value, key));


    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
     return response;
  }

  Future<http.Response> post(
      {String? endpoint,
        Map<String, String>? headers,
        Object? bodyData}) async {
    var url = Uri.parse("${AppConstant.BASE_URL}$endpoint");
    debugPrint("url $url");
    var response =
    await client.post(url, headers: headers ?? {}, body: bodyData);
    debugPrint("response ${response.statusCode} ${response.body}");
    return response;
  }

  Future<Map<String, dynamic>?> passwordForget(String email) async {


    Map <String,dynamic> pasrse={"email":"$email"};

    print(pasrse.toString());
    try {
      var URL = '${AppConstant.BASE_URL}user/forgot_password';
      final response = await http.post(Uri.parse(URL), body: pasrse);

      debugPrint("$URL passwordForget");
      debugPrint(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic>? valUes = json.decode(response.body.toString());
        Fluttertoast.showToast(msg: "${valUes!["message"]}");
        return valUes!;
      } else if (response.statusCode == 403 || response.statusCode == 401) {
      } else {
        Fluttertoast.showToast(msg: "something went wrong");
        return null;
      }
    } catch (E) {
      print("error call hear");
      print(E);
    }
    //net connectivity check
  }

  // inward list Api call

  Future<Map<String, dynamic>?> getInwardList(Map<String, dynamic> map) async {
    var prefs = await SharedPreferences.getInstance();
    print("map data ${map}");
    String? accessTokenData = prefs.getString("accessToken");
    //net connectivity check
    print("call here data ${accessTokenData}");
    var URL = '${AppConstant.BASE_URL}Inward/list_inward';
    print("url $URL");
    final response = await http.post(Uri.parse(URL),
        headers: {
          "Accept": "application/json",
          // "Content-Type": "application/json",
          'Authorization': '$accessTokenData',
        },
        body: map);

    debugPrint("inword res");
    debugPrint("${response.statusCode}");
    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {
      AuthenticationRepository createStoriesCubit =
          navigatorKey.currentState!.context.read<AuthenticationRepository>();

      createStoriesCubit.logOut();
      Map<String, dynamic> mapData = json.decode(response.body.toString());
      Fluttertoast.showToast(msg: "${mapData["message"]}");
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getInwardDetails(String listId) async {
    var prefs = await SharedPreferences.getInstance();
    String? accessTokenData = prefs.getString("accessToken");
    //net connectivity check
    print("inward url ${AppConstant.BASE_URL}inward/inward_deatils/$listId");
    var URL = '${AppConstant.BASE_URL}inward/inward_deatils/$listId';
    print("url $URL");
    final response = await http.get(
      Uri.parse(URL),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': '$accessTokenData',
      },
    );

    debugPrint("getInwardDetails res");
    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {
    } else {
      return null;
    }
  }




  Future<Map<String, dynamic>?> getProfileData() async {
    var prefs = await SharedPreferences.getInstance();
    String? accessTokenData = prefs.getString("accessToken");
    //net connectivity check
    print("call here data ${accessTokenData}");
    var URL = '${AppConstant.BASE_URL}user/profile/';
    final response = await http.get(
      Uri.parse(URL),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': '$accessTokenData',
      },
    );

    debugPrint("inword res");
    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    }
    else if (response.statusCode == 403 || response.statusCode == 401) {
    }
    else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getInventoryList(
      Map<String, dynamic>? params) async {
    var prefs = await SharedPreferences.getInstance();
    String? accessTokenData = prefs.getString("accessToken");
    //net connectivity check
    print("call here data $accessTokenData");
    var URL = '${AppConstant.BASE_URL}inventory/list';
    final response = await http.post(
      Uri.parse(URL),
      body: params,
      headers: {
        "Accept": "application/json",
        // "Content-Type": "application/json",
        'Authorization': '$accessTokenData',
      },
    );

    debugPrint("inword res");
    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    }
    else if (response.statusCode == 403 || response.statusCode == 401) {
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getAddItems(Map<String, String> listId) async {
    var prefs = await SharedPreferences.getInstance();
    String? accessTokenData = prefs.getString("accessToken");

    try {
      var URL = '${AppConstant.BASE_URL}rack/additems';
      final response = await http.post(Uri.parse(URL),
          headers: {
            'Authorization': '$accessTokenData',
          },
          body: listId);

      debugPrint("inword res");
      debugPrint(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic>? valUes = json.decode(response.body.toString());
        Fluttertoast.showToast(msg: "${valUes!["message"]}");
        return valUes!;
      } else if (response.statusCode == 403 || response.statusCode == 401) {
      } else {
        Fluttertoast.showToast(msg: "something went wrong");
        return null;
      }
    } catch (E) {
      print("error call hear");
      print(E);
    }
    //net connectivity check
  }

  Future<Map<String, dynamic>?> getRackList() async {
    var prefs = await SharedPreferences.getInstance();
    String? accessTokenData = prefs.getString("accessToken");
    //net connectivity check
    print("call here data ${accessTokenData}");
    var URL = '${AppConstant.BASE_URL}rack/list';
    final response = await http.post(
      Uri.parse(URL),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': '$accessTokenData',
      },
    );

    debugPrint("inword res");
    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {
    } else {
      return null;
    }
  }



  Future<Map<String, dynamic>?> getTransporterList({var data}) async {
    var prefs = await SharedPreferences.getInstance();
    String? accessTokenData = prefs.getString("accessToken");
    //net connectivity check

    var URL = '${AppConstant.BASE_URL}transporter/list';
    print("transporter list Url $URL");
    final response = await http.post(
      Uri.parse(URL),
      headers: {
        "Accept": "application/json",
        'Authorization': '$accessTokenData',
      },
      body: data
    );

    debugPrint("inword res");
    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> addTransporter(Map<String, dynamic>? data) async {
    var prefs = await SharedPreferences.getInstance();
    String? accessTokenData = prefs.getString("accessToken");
    var URL = '${AppConstant.BASE_URL}transporter/add';
    print("add transporter Url $URL");
    final response = await http.post(
      Uri.parse(URL),
      headers: {
        "Accept": "application/json",
        'Authorization': '$accessTokenData',
      },
      body: data
    );

    debugPrint("inword res");
    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getPackageTypeList() async {
    var prefs = await SharedPreferences.getInstance();
    String? accessTokenData = prefs.getString("accessToken");
    //net connectivity check

    var URL = '${AppConstant.BASE_URL}inward/list_package';
    print("transporter list Url $URL");
    final response = await http.get(
        Uri.parse(URL),
        headers: {
          "Accept": "application/json",
          'Authorization': '$accessTokenData',
        },
    );

    debugPrint("inword res");
    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> addPackageType(Map<String, dynamic>? data) async {
    var prefs = await SharedPreferences.getInstance();
    String? accessTokenData = prefs.getString("accessToken");
    var URL = '${AppConstant.BASE_URL}inward/addpackage';
    print("add package type Url $URL");
    final response = await http.post(
        Uri.parse(URL),
        headers: {
          "Accept": "application/json",
          'Authorization': '$accessTokenData',
        },
        body: data
    );

    debugPrint("inword res");
    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (response != null) {
        return json.decode(response.body.toString());
      } else {
        return null;
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getPartyList() async {
    var prefs = await SharedPreferences.getInstance();
    String? accessTokenData = prefs.getString("accessToken");
    const url = '${AppConstant.BASE_URL}vendor/list';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': '$accessTokenData',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body.toString());
    }
    return null;
  }
}
