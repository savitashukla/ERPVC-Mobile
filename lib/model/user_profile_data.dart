import 'package:erpvc/api_hleper/api_helper.dart';
import 'package:erpvc/helper/helper.dart';

class UserProfileData {
  bool? status;
  String? message;
  Data? data;

  UserProfileData({this.status, this.message, this.data});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? staffid;
  String? email;
  String? firstname;
  String? lastname;
  String? facebook;
  String? linkedin;
  String? phonenumber;
  String? skype;
  String? password;
  String? datecreated;
  Null? profileImage;
  String? lastIp;
  String? lastLogin;
  String? lastActivity;
  Null? lastPasswordChange;
  String? newPassKey;
  String? newPassKeyRequested;
  String? admin;
  String? role;
  String? active;
  String? defaultLanguage;
  String? direction;
  String? mediaPathSlug;
  String? isNotStaff;
  String? hourlyRate;
  bool? warehouse = false;
  bool? dataEntryCreate = false;
  bool? dataEntryView = false;
  bool? dataEntryEdit = false;
  bool? racksCreatePer = false;
  String? twoFactorAuthEnabled;
  Null? twoFactorAuthCode;
  Null? twoFactorAuthCodeRequested;
  String? emailSignature;
  String? warehousesAccess;
  Null? googleAuthSecret;
  String? fullName;
  List<Permissions>? permissions;

  Data(
      {this.staffid,
      this.email,
      this.firstname,
      this.lastname,
      this.facebook,
      this.linkedin,
      this.phonenumber,
      this.skype,
      this.warehouse,
      this.password,
      this.datecreated,
      this.profileImage,
      this.lastIp,
      this.lastLogin,
      this.lastActivity,
      this.lastPasswordChange,
      this.newPassKey,
      this.newPassKeyRequested,
      this.admin,
      this.role,
      this.active,
      this.defaultLanguage,
      this.direction,
      this.mediaPathSlug,
      this.isNotStaff,
      this.hourlyRate,
      this.twoFactorAuthEnabled,
      this.twoFactorAuthCode,
      this.twoFactorAuthCodeRequested,
      this.emailSignature,
      this.warehousesAccess,
      this.googleAuthSecret,
      this.fullName,
      this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    staffid = json['staffid'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    facebook = json['facebook'];
    linkedin = json['linkedin'];
    phonenumber = json['phonenumber'];
    skype = json['skype'];
    password = json['password'];
    datecreated = json['datecreated'];
    profileImage = json['profile_image'];
    lastIp = json['last_ip'];
    lastLogin = json['last_login'];
    lastActivity = json['last_activity'];
    lastPasswordChange = json['last_password_change'];
    newPassKey = json['new_pass_key'];
    newPassKeyRequested = json['new_pass_key_requested'];
    admin = json['admin'];
    role = json['role'];
    active = json['active'];
    defaultLanguage = json['default_language'];
    direction = json['direction'];
    mediaPathSlug = json['media_path_slug'];
    isNotStaff = json['is_not_staff'];
    hourlyRate = json['hourly_rate'];
    twoFactorAuthEnabled = json['two_factor_auth_enabled'];
    twoFactorAuthCode = json['two_factor_auth_code'];
    twoFactorAuthCodeRequested = json['two_factor_auth_code_requested'];
    emailSignature = json['email_signature'];
    warehousesAccess = json['warehouses_access'];
    googleAuthSecret = json['google_auth_secret'];
    fullName = json['full_name'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));

        if (v["feature"] == "warehouse") {
          warehouse = true;
          Helper().setStoreKeeperPermission(true);
        } else if (v["feature"] == "data_entry") {
          if (v["capability"] == "create") {
            dataEntryCreate = true;
            Helper().setGateKeeperPermission(true);
          } else if (v["capability"] == "view") {
            dataEntryView = true;
          } else if (v["capability"] == "edit") {
            dataEntryEdit = true;

            Helper().storeDataEntryEditDPer(true);
          }
        } else if (v["feature"] == "racks") {
          if (v["capability"] == "create") {
            racksCreatePer=true;
            Helper().storeDataRacksCreatePer(true);

            //    dataEntryCreate = true;
          }
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffid'] = this.staffid;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['facebook'] = this.facebook;
    data['linkedin'] = this.linkedin;
    data['phonenumber'] = this.phonenumber;
    data['skype'] = this.skype;
    data['password'] = this.password;
    data['datecreated'] = this.datecreated;
    data['profile_image'] = this.profileImage;
    data['last_ip'] = this.lastIp;
    data['last_login'] = this.lastLogin;
    data['last_activity'] = this.lastActivity;
    data['last_password_change'] = this.lastPasswordChange;
    data['new_pass_key'] = this.newPassKey;
    data['new_pass_key_requested'] = this.newPassKeyRequested;
    data['admin'] = this.admin;
    data['role'] = this.role;
    data['active'] = this.active;
    data['default_language'] = this.defaultLanguage;
    data['direction'] = this.direction;
    data['media_path_slug'] = this.mediaPathSlug;
    data['is_not_staff'] = this.isNotStaff;
    data['hourly_rate'] = this.hourlyRate;
    data['two_factor_auth_enabled'] = this.twoFactorAuthEnabled;
    data['two_factor_auth_code'] = this.twoFactorAuthCode;
    data['two_factor_auth_code_requested'] = this.twoFactorAuthCodeRequested;
    data['email_signature'] = this.emailSignature;
    data['warehouses_access'] = this.warehousesAccess;
    data['google_auth_secret'] = this.googleAuthSecret;
    data['full_name'] = this.fullName;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
      for (int a = 0; a < data['permissions'].lenght; a++) {
        if (data['permissions'][a]["feature"] == "warehouse") {
          warehouse = true;
        } else if (data['permissions'][a]["feature"] == "data_entry") {
          if (data['permissions'][a]["capability"] == "create") {
            dataEntryCreate = true;
          } else if (data['permissions'][a]["capability"] == "view") {
            dataEntryView = true;
          } else if (data['permissions'][a]["capability"] == "edit") {
            dataEntryEdit = true;
          }
        }
      }
    }
    return data;
  }
}

class Permissions {
  String? staffId;
  String? feature;
  String? capability;

  Permissions({this.staffId, this.feature, this.capability});

  Permissions.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    feature = json['feature'];
    capability = json['capability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['feature'] = this.feature;
    data['capability'] = this.capability;
    return data;
  }
}
