import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import 'package:efood_multivendor_driver/data/model/response/error_response.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;

  String token;
  Map<String, String> _mainHeaders;

  ApiClient({@required this.appBaseUrl, @required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN);
    debugPrint('Token: $token');
    updateHeader(token, sharedPreferences.getString(AppConstants.LANGUAGE_CODE));
  }

  void updateHeader(String token, String languageCode) {
    print("user token in update header ${AppConstants.TOKEN}");
    AppConstants.userTokenFromLocalDB = token;
    _mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      AppConstants.LOCALIZATION_KEY: languageCode ?? AppConstants.languages[0].languageCode
    };
  }

  Future<Response> getData(String uri, {Map<String, dynamic> query, Map<String, String> headers}) async {
    print("base url in flutter ${appBaseUrl.toString()}");
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
      }
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl+uri),
        headers: {
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjc4NjgwYzQ2OTc1MWEyZjQ0ZjZmZWJmZmZiODNlMmYzMjkxM2NiMjA1NDJiYjllMzUyOGFkZjUwN2JiMDE1YjEwNjZiMTA5YzZlMDRmODUiLCJpYXQiOjE2NzQyMjI0MzcuMjc5MDYyLCJuYmYiOjE2NzQyMjI0MzcuMjc5MDY3LCJleHAiOjE3MDU3NTg0MzcuMjc2NDc1LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.dpFpfD-gWqwi_RkkuXPk5muYSkUMbTpYf4o4bPwXGJccmy3pV8ygDmVWw86UHp9gyLEBc_qtbmD2cTVljg7HZyXMDsjpdtOutO1jex-EL5p3y1NjpZugzpBQX8Cl9MiDD8fZWEOSMIXpMj0acWqk4er45WM0B56PwHGdC9KJpC00Ul5CezoBSAyCdvWs-Gp14duzdsl7QBAbjUylVqF_2drINg82dSuLY-75GQf69LBExlfFrBk9G7taq3uh-Xyei2qLP_2zryv3ryJIayqcCdTkWttMckAqiGB8rRfM5yJUQcxCPEu9AXTCAxTY2NUFlij1nlj5d_kTCQxUsBOv_zsM_Zj_dN5PUhUB657el9CocF__5toY-sNp__0zf2o2gynUqkUHIyQnljT3whcbtHjy_6a-GykArOB7PVib5Sv05nv0F_yzfr95QZ3NK6yjlNe6hyriLJK_1IGvMb96hULuVCC_3gZkDGmGkgMlU_0jQQibnv-p3OWNue-bxp5fGbJLec0FgU0KkUZNALQ_D9Cd3-YWb_MRF5oL3AT8j8jJG0TssYGWry8A1sn7nZiqRdCCsCpAJG9KiOrHnqZPDD6UnhQRE3hiK3o_ew0ozsuXOS2B0NHITa5Py8d4UuExwmbmfbQIMno_AV7-s36--BypiWZQQBp-Nv-jWJH32GU',
        },
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String> headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }


  Future<Response> postMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody, {Map<String, String> headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
        print('====> API Body: $body');
      }
      Http.MultipartRequest _request = Http.MultipartRequest('POST', Uri.parse(appBaseUrl+uri));
      _request.headers.addAll(headers ?? _mainHeaders);
      for(MultipartBody multipart in multipartBody) {
        if(multipart.file != null) {
          if(Foundation.kIsWeb) {
            Uint8List _list = await multipart.file.readAsBytes();
            Http.MultipartFile _part = Http.MultipartFile(
              multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
              filename: basename(multipart.file.path), contentType: MediaType('image', 'jpg'),
            );
            _request.files.add(_part);
          }else {
            File _file = File(multipart.file.path);
            _request.files.add(Http.MultipartFile(
              multipart.key, _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last,
            ));
          }
        }
      }
      _request.fields.addAll(body);
      Http.Response _response = await Http.Response.fromStream(await _request.send());
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, String> headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String> headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
      }
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    }catch(e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(), headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    return _response;
  }
}

class MultipartBody {
  String key;
  PickedFile file;

  MultipartBody(this.key, this.file);
}