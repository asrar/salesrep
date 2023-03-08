import 'package:efood_multivendor_driver/controller/splash_controller.dart';
import 'package:efood_multivendor_driver/data/api/api_checker.dart';
import 'package:efood_multivendor_driver/data/model/body/record_location_body.dart';
import 'package:efood_multivendor_driver/data/model/body/update_status_body.dart';
import 'package:efood_multivendor_driver/data/model/response/ignore_model.dart';
import 'package:efood_multivendor_driver/data/model/response/order_details_model.dart';
import 'package:efood_multivendor_driver/data/model/response/order_model.dart';
import 'package:efood_multivendor_driver/data/repository/order_repo.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../data/model/response/order_detail_model.dart';
import '../data/model/response/order_request_model.dart';
import '../view/screens/order/widget/order_details.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({@required this.orderRepo});

  String getCurrentOrderID = '';
  String getCurrentRequestOrderID = '';
  List<OrderModel> _allOrderList;
  List<NewOrderDetailModel> _newOrderDetailModel= [];
  List<NewOrderDetailModel> get newOrderDetailModel =>_newOrderDetailModel;
  List<OrderModel> _currentOrderList;
  List<OrderModel> _deliveredOrderList;
  List<OrderModel> _completedOrderList;
  List<OrderModel> _latestOrderList;
  List<OrderDetailsModel> _orderDetailsModel;
  List<NewOrderDetailModel> _orderNewModel;
  List<IgnoreModel> _ignoredRequests = [];
  bool _isLoading = false;
  Position _position = Position(longitude: 0, latitude: 0, timestamp: null, accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
  Placemark _placeMark = Placemark(name: 'Unknown', subAdministrativeArea: 'Location', isoCountryCode: 'Found');
  String _otp = '';
  bool _paginate = false;
  int _pageSize;
  List<int> _offsetList = [];
  int _offset = 1;
  List<NewOrderDetailModel> get orderNewModelDetails=>_orderNewModel;

  List<OrderModel> get allOrderList => _allOrderList;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get deliveredOrderList => _deliveredOrderList;
  List<OrderModel> get completedOrderList => _completedOrderList;
  List<OrderModel> get latestOrderList => _latestOrderList;
  List<OrderDetailsModel> get orderDetailsModel => _orderDetailsModel;
  bool get isLoading => _isLoading;
  Position get position => _position;
  Placemark get placeMark => _placeMark;
  String get address => '${_placeMark.name} ${_placeMark.subAdministrativeArea} ${_placeMark.isoCountryCode}';
  String get otp => _otp;
  bool get paginate => _paginate;
  int get pageSize => _pageSize;
  int get offset => _offset;
  OrderRequestModel _orderRequestModel;
  OrderRequestModel get orderRequestModel=> _orderRequestModel;

  Future<void> sendOffer() async{
    Response response = await orderRepo.sendOffer(bodyMap: {});
    if(response.statusCode == 200){
      print("offer send ");
    }else{
      print("offer not send ");
      print("this is response ${response}");
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getOrder() async {
    print("get order req ftom order id ${getCurrentOrderID}");
    Response response = await orderRepo.getOrder(currentOrderId: getCurrentOrderID);
    print("this is status code getorder  ${response.statusCode}");
    print("getOder Response ${response.body}");
    if(response.statusCode == 200) {
      _newOrderDetailModel = [];
      response.body.forEach((details) {
        _newOrderDetailModel.add(NewOrderDetailModel.fromJson(details));
      });
      getCurrentRequestOrderID = _newOrderDetailModel[0].requestDetialsId.toString();
      print("order req id ${_newOrderDetailModel[0].requestDetialsId.toString()}");
      getOrderRequest();
    }else {
      ApiChecker.checkApi(response);

    }
    update();
  }

  Future<OrderRequestModel> getOrderRequest() async {
    print("getCurrentRequestOrderID inside get order req ${getCurrentRequestOrderID}");
    Response response = await orderRepo.getOrderRequest(currentOrderID: getCurrentRequestOrderID);
    print("this is status code  ${response.statusCode}");
    print("getOrderRequest Response ${response.body}");
    if (response.statusCode == 200) {
      print("data is here hshhsd ${response.body['user_id']}");
      _orderRequestModel=OrderRequestModel.fromJson(response.body);
      print("${_orderRequestModel.data[0].notes}");
      Get.to(()=>NewOrderDetailsScreen());
      update();
      // _responseModel = ResponseModel(true, 'successful');
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _orderRequestModel;
  }

  Future<void> getAllOrders() async {
    Response response = await orderRepo.getAllOrders();
    if(response.statusCode == 200) {
      _allOrderList = [];
      response.body.forEach((order) => _allOrderList.add(OrderModel.fromJson(order)));
      _deliveredOrderList = [];
      _allOrderList.forEach((order) {
        if(order.orderStatus == 'delivered'){
          _deliveredOrderList.add(order);
        }
      });
    }else {
      ApiChecker.checkApi(response);
    }
    update();
  }




  Future<void> getCompletedOrders(int offset) async {
    if(offset == 1) {
      _offsetList = [];
      _offset = 1;
      _completedOrderList = null;
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      Response response = await orderRepo.getCompletedOrderList(offset);
      if (response.statusCode == 200) {
        if (offset == 1) {
          _completedOrderList = [];
        }
        _completedOrderList.addAll(PaginatedOrderModel.fromJson(response.body).orders);
        _pageSize = PaginatedOrderModel.fromJson(response.body).totalSize;
        _paginate = false;
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if(_paginate) {
        _paginate = false;
        update();
      }
    }
  }

  void showBottomLoader() {
    _paginate = true;
    update();
  }

  void setOffset(int offset) {
    _offset = offset;
  }

  Future<void> getCurrentOrders() async {
    Response response = await orderRepo.getCurrentOrders();
    if(response.statusCode == 200) {
      _currentOrderList = [];
      response.body.forEach((order) => _currentOrderList.add(OrderModel.fromJson(order)));
      getCurrentOrderID = _currentOrderList[0].id.toString();
      // getOrder();
      // getOrderRequest();
      print("*********************************************");
      print(_currentOrderList[0].orderAmount);
    }else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getLatestOrders() async {
    Response response = await orderRepo.getLatestOrders();
    if(response.statusCode == 200) {
      _latestOrderList = [];
      List<int> _ignoredIdList = [];
      _ignoredRequests.forEach((ignore) {
        _ignoredIdList.add(ignore.id);
      });
      response.body.forEach((order) {
        if(!_ignoredIdList.contains(OrderModel.fromJson(order).id)) {
          _latestOrderList.add(OrderModel.fromJson(order));
        }
      });
    }else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> recordLocation(RecordLocationBody recordLocationBody) async {
    Response response = await orderRepo.recordLocation(recordLocationBody);
    if(response.statusCode == 200) {

    }else {
      ApiChecker.checkApi(response);
    }
  }

  Future<bool> updateOrderStatus({String orderID,String orderUserID ,String status, bool back = false}) async {

    _isLoading = true;
    update();
    Response response = await orderRepo.updateOrderStatus(
      map: {
        'order_status': status.toString(),
      },
      orderId: orderID,
      orderUserID: orderUserID,
    );
    Get.back();
    bool _isSuccess;
    if(response.statusCode == 200) {
      print("this is response message ${response.body['Message']}");
      if(back) {
        Get.back();
      }
      showCustomSnackBar(response.body['Message'], isError: false);
      _isSuccess = true;
    }else {
      ApiChecker.checkApi(response);
      _isSuccess = false;
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  Future<void> updatePaymentStatus(int index, String status) async {
    _isLoading = true;
    update();
    UpdateStatusBody _updateStatusBody = UpdateStatusBody(orderId: _currentOrderList[index].id, status: status);
    Response response = await orderRepo.updatePaymentStatus(_updateStatusBody);
    if(response.statusCode == 200) {
      _currentOrderList[index].paymentStatus = status;
      showCustomSnackBar(response.body['message'], isError: false);
    }else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> getOrderDetails(int orderID) async {
    _orderDetailsModel = null;
    Response response = await orderRepo.getOrderDetails(orderID);
    if(response.statusCode == 200) {
      _orderDetailsModel = [];
      response.body.forEach((orderDetails) => _orderDetailsModel.add(OrderDetailsModel.fromJson(orderDetails)));
    }else {
      ApiChecker.checkApi(response);
    }
    update();
  }






  Future<bool> acceptOrder(int orderID, int index, OrderModel orderModel) async {
    _isLoading = true;
    update();
    Response response = await orderRepo.acceptOrder(orderID);
    Get.back();
    bool _isSuccess;
    if(response.statusCode == 200) {
      _latestOrderList.removeAt(index);
      _currentOrderList.add(orderModel);
      _isSuccess = true;
    }else {
      ApiChecker.checkApi(response);
      _isSuccess = false;
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  void getIgnoreList() {
    _ignoredRequests = [];
    _ignoredRequests.addAll(orderRepo.getIgnoreList());
  }

  void ignoreOrder(int index) {
    _ignoredRequests.add(IgnoreModel(id: _latestOrderList[index].id, time: DateTime.now()));
    _latestOrderList.removeAt(index);
    orderRepo.setIgnoreList(_ignoredRequests);
    update();
  }

  void removeFromIgnoreList() {
    List<IgnoreModel> _tempList = [];
    _tempList.addAll(_ignoredRequests);
    for(int index=0; index<_tempList.length; index++) {
      if(Get.find<SplashController>().currentTime.difference(_tempList[index].time).inMinutes > 10) {
        _tempList.removeAt(index);
      }
    }
    _ignoredRequests = [];
    _ignoredRequests.addAll(_tempList);
    orderRepo.setIgnoreList(_ignoredRequests);
  }
  
  Future<void> getCurrentLocation() async {
    Position _currentPosition = await Geolocator.getCurrentPosition();
    if(!GetPlatform.isWeb) {
      try {
        List<Placemark> _placeMarks = await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
        _placeMark = _placeMarks.first;
      }catch(e) {}
    }
    _position = _currentPosition;
    update();
  }

  void setOtp(String otp) {
    _otp = otp;
    if(otp != '') {
      update();
    }
  }

}