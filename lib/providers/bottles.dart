import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Iconstants.dart';

import 'package:http/http.dart' as http;

class Bottles extends ChangeNotifier{
  int totalBottleCount = 0;
  String collectedBottles = '';
  List customerDetails = [];

  // getTotalBottlesCount() async{
  //   String url = IConstants.API_PATH + 'get-bottle-details';
  //   try{
  //     final response = await http.post(url, body: {'user_id': '1006'});
  //     final responseJson = json.decode(response.body);
  //     print('....get-bottle-details........response.........');
  //     print(responseJson);
  //     if (responseJson.toString() == "[]") {
  //     } else {
  //
  //     }
  //
  //   }catch(e){
  //     throw e;
  //   }
  //   notifyListeners();
  // }

  getCollectedBottles() async{
    String url = IConstants.API_PATH + 'get-bottle-details';

    SharedPreferences  prefs = await SharedPreferences.getInstance();
    try {
      final response = await http
          .post(url,
          body: {
            'customer_id': prefs.get("id")
          });
      print("Bottole Url....."+url.toString()+{
        'customer_id': prefs.get("id")
      }.toString());
      final responseJson = json.decode(response.body);
      if (responseJson.toString() == "[]") {} else {
        print('....get-bottle-details....response.........');
        print(responseJson.toString());
        collectedBottles = responseJson['collectedBottles'].toString();
        customerDetails =  responseJson['customer_details'];
        print('++++++++++++++++++++++++++++++++++++');
        print(collectedBottles);
        print(customerDetails);
      }
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }
}
