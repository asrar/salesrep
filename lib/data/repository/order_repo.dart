import 'dart:convert';

import 'package:efood_multivendor_driver/data/api/api_client.dart';
import 'package:efood_multivendor_driver/data/model/body/record_location_body.dart';
import 'package:efood_multivendor_driver/data/model/body/update_status_body.dart';
import 'package:efood_multivendor_driver/data/model/response/ignore_model.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  OrderRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getAllOrders() {
    return apiClient.getData(AppConstants.ALL_ORDERS_URI + getUserToken());
  }

  Future<Response> getCompletedOrderList(int offset) async {
    return await apiClient.getData('${AppConstants.ALL_ORDERS_URI}?token=${getUserToken()}&offset=$offset&limit=10');
  }

  Future<Response> getCurrentOrders() {
    return apiClient.getData(AppConstants.CURRENT_ORDERS_URI + getUserToken());
  }

  Future<Response> getLatestOrders() {
    return apiClient.getData(AppConstants.LATEST_ORDERS_URI + getUserToken());
  }

  Future<Response> recordLocation(RecordLocationBody recordLocationBody) {
    recordLocationBody.token = getUserToken();
    return apiClient.postData(AppConstants.RECORD_LOCATION_URI, recordLocationBody.toJson());
  }

  Future<Response> updateOrderStatus({String orderUserID , String orderId,Map<String , dynamic> map}) {
    // updateStatusBody.token = getUserToken();
    print("this is map in side update order status ${map}");
    return apiClient.postData("${AppConstants.UPDATE_ORDER_STATUS_URI}${orderId}/${orderUserID}", map);
  }

  Future<Response> updatePaymentStatus(UpdateStatusBody updateStatusBody) {
    updateStatusBody.token = getUserToken();
    return apiClient.postData(AppConstants.UPDATE_PAYMENT_STATUS_URI, updateStatusBody.toJson());
  }

  Future<Response> getOrderDetails(int orderID) {
    return apiClient.getData('${AppConstants.ORDER_DETAILS_URI}${getUserToken()}&order_id=$orderID');
  }
  Future<Response> sendOffer({Map<String, dynamic> bodyMap}){
    return apiClient.postData("${AppConstants.SEND_OFFER}",bodyMap);
  }
  Future<Response> getOrder({String currentOrderId}){
    return apiClient.getData('${AppConstants.ORDER_URI}${currentOrderId}');
  }

  Future<Response> getOrderRequest({String currentOrderID}) async {
    return await apiClient.getData('${AppConstants.ORDER_REQUEST_GET_URI}${currentOrderID}');
  }
  Future<Response> acceptOrder(int orderID) {
    return apiClient.postData(AppConstants.ACCEPT_ORDER_URI, {"_method": "put", 'token': getUserToken(), 'order_id': orderID});
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  void setIgnoreList(List<IgnoreModel> ignoreList) {
    List<String> _stringList = [];
    ignoreList.forEach((ignore) {
      _stringList.add(jsonEncode(ignore.toJson()));
    });
    sharedPreferences.setStringList(AppConstants.IGNORE_LIST, _stringList);
  }

  List<IgnoreModel> getIgnoreList() {
    List<IgnoreModel> _ignoreList = [];
    List<String> _stringList = sharedPreferences.getStringList(AppConstants.IGNORE_LIST) ?? [];
    _stringList.forEach((ignore) {
      _ignoreList.add(IgnoreModel.fromJson(jsonDecode(ignore)));
    });
    return _ignoreList;
  }

}