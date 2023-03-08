import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/controller/localization_controller.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/controller/splash_controller.dart';
import 'package:efood_multivendor_driver/data/model/response/order_model.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/confirmation_dialog.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/base/custom_button.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/verify_delivery_sheet.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/info_card.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/slider_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:slide_action/slide_action.dart';

import '../../../../data/model/response/order_detail_model.dart';

class NewOrderDetailsScreen extends StatefulWidget {
  final NewOrderDetailModel orderModel;
  final int orderIndex;
  final bool isRunningOrder;

  NewOrderDetailsScreen({
    this.isRunningOrder,
    this.orderIndex,
    this.orderModel,
  });

  @override
  State<NewOrderDetailsScreen> createState() => _NewOrderDetailsScreenState();
}

class _NewOrderDetailsScreenState extends State<NewOrderDetailsScreen> {
  final getCOntroler = Get.find<OrderController>();
  bool _restConfModel;
  bool _showBottomView;
  bool _showSlider;
  bool _cancelPermission;
  bool _selfDelivery;
  TextEditingController sendController = TextEditingController();
  @override
  void initState() {
    // print("this is build method in resposse ${widget.orderModel.id}");
    _cancelPermission =
        Get
            .find<SplashController>()
            .configModel
            .canceledByDeliveryman;
    _selfDelivery = Get
        .find<AuthController>()
        .profileModel
        .type != 'zone_wise';
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
      Get.find<OrderController>().getCurrentOrders();
      String _type = message.data['type'];
      if (widget.isRunningOrder && _type == 'order_status') {
        Get.back();
      }
    });

    _restConfModel =
        Get
            .find<SplashController>()
            .configModel
            .orderConfirmationModel !=
            'deliveryman';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2E4D4C),
      appBar: CustomAppBar(title: 'order_details'.tr),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: GetBuilder<OrderController>(
          // init: OrderController().getOrderData(),
            builder: (orderController) {
              // orderController.getOrderRequest();
              // orderController.getOrder();
              return orderController.newOrderDetailModel.length == 0
                  ? SizedBox()
                  : Column(children: [
                Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(
                                '${'order_id'.tr}:',
                                style: robotoRegular,
                              ),
                              SizedBox(
                                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              // Text(orderModel.id.toString(), style: robotoMedium),
                              SizedBox(
                                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Expanded(child: SizedBox()),
                              Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green)),
                              SizedBox(
                                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Text(
                                '${orderController.newOrderDetailModel[0].id}',
                                style: robotoRegular,
                              ),
                            ]),
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                            InfoCard(
                              title: 'Customer Contact Details'.tr,
                              address:
                              '${orderController.newOrderDetailModel[0].phone}',
                              image:
                              '${Get
                                  .find<SplashController>()
                                  .configModel
                                  .baseUrls
                                  .restaurantImageUrl}/${'kdfj'}',
                              name:
                              '${orderController.newOrderDetailModel[0].fName}',
                              phone:
                              '${orderController.newOrderDetailModel[0].phone}',
                              latitude: 'orderModel.restaurantLat',
                              longitude: 'orderModel.restaurantLng',
                              showButton: 'orderModel.orderStatus' !=
                                  'delivered',
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                            orderController.orderRequestModel == null
                                ? SizedBox()
                                : GetBuilder<OrderController>(
                                builder: (newOrderController) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Title : ",style: TextStyle(fontWeight: FontWeight.bold,),),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.47,
                                            child: Text(
                                              orderController.orderRequestModel
                                                  .data[0].title
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orangeAccent),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("Service Note : ",style: TextStyle(fontWeight: FontWeight.bold,),),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.47,
                                            child: Text(
                                              orderController.orderRequestModel
                                                  .data[0].notes
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orangeAccent),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("Service Details : ",overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,),),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.47,
                                            child: Text(
                                              orderController.orderRequestModel
                                                  .data[0].detials
                                                  .toString(), overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orangeAccent),
                                            ),
                                          )
                                        ],
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Schedule Date & Time : ",style: TextStyle(fontWeight: FontWeight.bold,),),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*0.47,
                                                    // color: Colors.red,
                                                    child: Text(
                                                      orderController
                                                          .orderRequestModel
                                                          .data[0]
                                                          .dueDateTime,
                                                      maxLines: null,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.orangeAccent),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Text(
                                            "Price : ",
                                            style: TextStyle(fontWeight: FontWeight.bold,),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.47,
                                            child: Text(
                                              orderController.orderRequestModel
                                                  .data[0].estimatedBudget
                                                  .toString(),
                                              style:
                                              TextStyle(fontWeight: FontWeight.bold,color: Colors.orangeAccent),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                }),
                          ]),
                    )),
                GetBuilder<OrderController>(builder: (getController) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle
                          ),
                          // height: 50,
                          // width: MediaQuery.of(context).size.width*0.8,
                          child: TextFormField(
                            controller: sendController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: "Type message for offer...",
                              hintStyle: TextStyle(color: Colors.black),
                              suffixIcon: Icon(Icons.send,color: Colors.black,),

                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SlideAction(
                          trackBuilder: (context, state) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  // Show loading if async operation is being performed
                                  state.isPerformingAction
                                  // confirmed,canceled,picked_up,delivered
                                      ? "Loading."
                                      : getController.newOrderDetailModel[0]
                                      .orderStatus ==
                                      'pending'
                                      ? "Confirm Order"
                                      : getController.newOrderDetailModel[0]
                                      .orderStatus ==
                                      'confirmed'
                                      ? "Going For Service"
                                      : getController
                                      .newOrderDetailModel[0]
                                      .orderStatus ==
                                      'picked_up'
                                      ? "Delivered Order"
                                      : "",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          },
                          thumbBuilder: (context, state) {
                            return Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                // Show loading indicator if async operation is being performed
                                child: state.isPerformingAction
                                    ? const CupertinoActivityIndicator(
                                  color: Colors.black,
                                )
                                    : const Icon(
                                  Icons.chevron_right,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                          action: () async {
                            if (getController.newOrderDetailModel[0].orderStatus == 'pending') {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Alert'),
                                    content: Text('Do you want to Confirm Order'),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          new TextButton(
                                            onPressed: () {
                                              orderController.updateOrderStatus(
                                                  orderUserID: getController.newOrderDetailModel[0].userId.toString(),
                                                  orderID: getController.newOrderDetailModel[0].id.toString(),
                                                  status: 'canceled',
                                                  back: true
                                              );
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              orderController.updateOrderStatus(
                                                  orderUserID: getController.newOrderDetailModel[0].userId.toString(),
                                                  orderID: getController.newOrderDetailModel[0].id.toString(),
                                                  status: 'confirmed',
                                                  back: true
                                              );
                                            },
                                            child: Text('Confirm'),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (getController.newOrderDetailModel[0].orderStatus == 'confirmed') {
                              orderController.updateOrderStatus(
                                  orderUserID: getController.newOrderDetailModel[0].userId.toString(),
                                  orderID: getController.newOrderDetailModel[0].id.toString(),
                                  status: 'picked_up',
                                  back: true
                              );
                            }else if(getController.newOrderDetailModel[0].orderStatus == 'picked_up'){
                              orderController.updateOrderStatus(
                                  orderUserID: getController.newOrderDetailModel[0].userId.toString(),
                                  orderID: getController.newOrderDetailModel[0].id.toString(),
                                  status: 'delivered',
                                  back: true
                              );
                            }
                            // Async operation
                            await Future.delayed(const Duration(seconds: 4), () {
                              // Get.snackbar(
                              //   '','',
                              //   titleText: Text("Successfully",style: TextStyle(color: Colors.white),),
                              // messageText: Text("Status Updated",style: TextStyle(color: Colors.white)),
                              // snackPosition: SnackPosition.BOTTOM,
                              // backgroundColor: Colors.redAccent
                              // ) ;
                              // Get.back();
                            });
                          },
                        ),
                      ),
                    ],
                  );
                })
              ]);
            }),
      ),
    );
  }
}
