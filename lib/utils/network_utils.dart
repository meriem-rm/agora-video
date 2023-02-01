 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

 
 dynamic createChannel(String channelName) async {
 
    var requestPayload = {};

    requestPayload["channelName"] = channelName.toString();
     requestPayload["expirationTimeInSeconds"] = 3600;
    requestPayload["role"] = 1;
    
    var uri = "http://localhost:8080/createChannel";
    Map<String, String> headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
     
   
    try{
     final response = await http.post(Uri.parse(uri), headers: headers,body: json.encode(requestPayload));
          // check the status code for the result
          // int statusCode = response.statusCode;
          print("Login calling $response");
          print(response.body);
    
          if (response.statusCode == 200){

           return json.decode(response.body);
    
          }else{
            // return null;
            //return UserModel();
            print("----------------bug");
            throw Exception("Error in login");
          }
    
        } catch (e) {
                                print("----------------bug0000");
return null;
       

          throw Exception(e);
        }
  }
