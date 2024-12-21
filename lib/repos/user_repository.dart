import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:erpvc/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final navigatorKeyHome = GlobalKey<NavigatorState>();

class UserRepository {
  UserModel? user;
  // List<String> permission = [];

  Future<UserModel?> getUser() async {
    var prefs = await SharedPreferences.getInstance();
    //await prefs.clear();
    if (/*user == null &&*/ prefs.containsKey('current_user')) {
      //  _user =User.fromJson( json.decode(await prefs.get('current_user'));
      // print();
      var userMap =
          jsonDecode(prefs.getString('current_user')!) as Map<String, dynamic>;
      user = UserModel.fromJson(userMap);
      print("getUseruser ${user!.toJson()}");
    } else {
      print("user null");
      return user;
    }
    return user;
  }

  Future<void> setCurrentUser(String jsonString) async {
    try {
      if (json.decode(jsonString) != null) {
        var prefs = await SharedPreferences.getInstance();
        // var user = User.fromJson(json.decode(jsonString)['result']);
        // await prefs.setString("apiKey", user.apiKey!);

        await prefs
            .setString('current_user', json.encode(json.decode(jsonString)))
            .then((value) {
          print('user saved ');
          updateUserInstance();
        });
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  void updateUserInstance() {
    user = null;
    getCurrentUser();
  }

  //
  void clearuserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {
      prefs.remove('current_user');

      // prefs.remove(AppConstants.VERSION_INFO);
    }
    prefs.remove('accessToken');
    prefs.remove('racksCreate');
    prefs.remove('data_entry_edit');
    // prefs.clear();
  }

  //
  Future<UserModel?> getCurrentUser() async {
    return user;
  }



/* Future<Response?> getPartyName({
    required Map<String, dynamic> data,
  }) async {

    //print('loginAPI_Enter ${data.toString()}');
    try {
      final url =
          '${GlobalConfiguration().getValue<String>('api_base_url')}party/list?warehouse_id=${data['warehouse_id']}';

      print('URL $url');


      final client = http.Client();
      final response = await client.get(Uri.parse(url),
        headers: {'Authorization': 'Bearer ${user!.data!.token}',
        },);

      print(response.body);
      print('code ${response.statusCode}');
      Response? responseData;
      if (response.statusCode == 200) {

          responseData = Response.fromJson(json.decode(response.body));

        return responseData;
      }
      return responseData!;
    } catch (e) {
      print('exception $e');
    }
  }*/
}
