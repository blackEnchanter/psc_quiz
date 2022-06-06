import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  static void configureConnectivityStream() {
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.wifi:
            try {
              if (Get.context != null) {
                Get.until(
                    (Route<dynamic> route) => !(Get.isDialogOpen ?? false));
              }
            } catch (e) {
              debugPrint("GetUntilMethodOnWifiConnectionError: $e");
            }
            // debugPrint("ConnectivityResult: Internet Connection With Wifi.");
            break;
          case ConnectivityResult.mobile:
            try {
              if (Get.context != null) {
                Get.until(
                    (Route<dynamic> route) => !(Get.isDialogOpen ?? false));
              }
            } catch (e) {
              debugPrint("GetUntilMethodOnMobileConnectionError: $e");
            }
            // debugPrint("ConnectivityResult: Internet Connection With Mobile.");
            break;
          case ConnectivityResult.ethernet:
            try {
              if (Get.context != null) {
                Get.until(
                    (Route<dynamic> route) => !(Get.isDialogOpen ?? false));
              }
            } catch (e) {
              debugPrint("GetUntilMethodOnEthernetConnectionError: $e");
            }
            // debugPrint(
            //     "ConnectivityResult: Internet Connection With Ethernet.");
            break;
          case ConnectivityResult.bluetooth:
            try {
              if (Get.context != null) {
                Get.until(
                    (Route<dynamic> route) => !(Get.isDialogOpen ?? false));
              }
            } catch (e) {
              debugPrint("GetUntilMethodOnBluetoothConnectionError: $e");
            }
            // debugPrint(
            //     "ConnectivityResult: Internet Connection With Bluetooth.");
            break;
          case ConnectivityResult.none:
            // debugPrint("ConnectivityResult: No Internet Connection.");
            try {
              if (Get.context != null) {
                Get.dialog(
                  Platform.isIOS || Platform.isMacOS
                      ? WillPopScope(
                          onWillPop: () async => false,
                          child: CupertinoAlertDialog(
                            title: Text('no_internet_connection_found'.tr),
                            content: Text('connection_out'.tr),
                          ),
                        )
                      : WillPopScope(
                          onWillPop: () async => false,
                          child: AlertDialog(
                            title: Text('no_internet_connection_found'.tr),
                            content: Text('connection_out'.tr),
                          ),
                        ),
                  barrierDismissible: false,
                );
              }
            } catch (e) {
              debugPrint("ShowNoInternetConnectionDialogError: $e");
            }
            break;
        }
      },
    );
  }
}
