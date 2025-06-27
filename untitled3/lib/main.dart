import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:airwallex_payment_flutter/airwallex.dart';
import 'package:airwallex_payment_flutter/types/environment.dart';
import 'package:airwallex_payment_flutter/types/payment_result.dart';
import 'package:airwallex_payment_flutter/types/payment_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
import 'package:untitled3/api/ApiService.dart' show ApiService;
import 'package:untitled3/util/airwallex_manager.dart';
import 'package:untitled3/util/log_service.dart';

import 'IntentListPage.dart';
import 'api/api_client.dart';
import 'api/payment_repository.dart';
import 'ui/credentials_dialog.dart';
import 'util/card_creator.dart';
import 'util/session_creator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airwallex Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final airwallex = Airwallex();
  late PaymentRepository paymentRepository;
  late List<String> environmentOptions;

  Environment environment = Environment.demo;
  bool saveCard = false;
  bool isLoading = false;
  String selectedOption = 'one off';
  //for demo or staging environment, you can set your own api key and client id,
  // if you don't, We will use the default value
  String apiKey = 'bc735183b7eeb714a1b679507d7b0016c74563077dc40e6a71d4aa4125925fabe86fb77b1eb8f1502568f633652cc77a';
  String clientId = '_kxXlEflRVCG61JUqZpnDw';
  String? customerId = "cus_hkdmrlhs5h8k2wigq0b";
  // String apiKey = '';
  // String clientId = '';
  // String? customerId;

  @override
  void initState() {
    Get.put(LogService());
    super.initState();
    AirwallexManager.instance.airwallex;
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message, style: const TextStyle(fontSize: 20)),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airwallex Example'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue!;
                      if (selectedOption == "one off") {
                        AirwallexManager.instance.billingMode = BillingMode.oneOff;
                      } else if (selectedOption == "recurring") {
                        AirwallexManager.instance.billingMode = BillingMode.recurring;
                      } else {
                        AirwallexManager.instance.billingMode = BillingMode.recurringAndPayment;
                      }
                    });
                  },
                  items: <String>['one off', 'recurring', 'recurring and payment']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await AirwallexManager.instance.startPayment(
                        AirwallexManager.instance.billingMode.index, PaymentMethod.entire,
                        customerId: customerId);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: const Text('presentEntirePaymentFlow'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await AirwallexManager.instance.startPayment(
                        AirwallexManager.instance.billingMode.index, PaymentMethod.card,
                        customerId: customerId);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: const Text('presentCardPaymentFlow'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await AirwallexManager.instance.startPayment(
                            AirwallexManager.instance.billingMode.index, PaymentMethod.cardDetails,
                            customerId: customerId);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text('payWithCardDetails'),
                    ),
                    if (selectedOption == 'one off') ...[
                      const SizedBox(width: 5),
                      // SizedBox(
                      //     height: 24.0,
                      //     width: 24.0,
                      //     child: Checkbox(
                      //       value: saveCard,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           saveCard = value!;
                      //         });
                      //       },
                      //     )),
                      // const Text('save'),
                    ]
                  ],
                ),
                const SizedBox(height: 20),
                if (selectedOption == 'one off' && customerId != null) ...[
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await AirwallexManager.instance.payWithConsent(customerId ?? "");
                      setState(() {
                        isLoading = false;
                      });
                    },
                    // onPressed: () => _handleSubmit(() async => _payWithConsent()),
                    child: const Text('payWithConsent'),
                  ),
                ],
                ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> map = await AirwallexManager.instance.airwallexLogin();
                    if (map.isNotEmpty) {
                      EasyLoading.showToast("登录成功");
                    } else {
                      EasyLoading.showToast("登录失败");
                    }
                  },
                  child: const Text('login'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => IntentListPage()));
                  },
                  child: const Text('购买记录'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await AirwallexManager.instance.createARefund("int_hkdmlzvbnh8osbcix9d");
                  },
                  child: const Text('create a refund'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await AirwallexManager.instance.retrieveARefund("rfd_hkdmlzvbnh8ogtc413d_ooogeq");
                  },
                  child: const Text('retrieve a refund'),
                ),
              ],
            ),
          ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
