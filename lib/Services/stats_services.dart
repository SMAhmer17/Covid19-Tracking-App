
import 'dart:convert';
import 'dart:developer';

import 'package:covidtrackingapp/Model/World_States_Model.dart';
import 'package:covidtrackingapp/Services/Utilities/app_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class StatesServices{

      // Fetching World Details

  Future<WorldStatesModel> fetchWorldStatesRecord() async{
    final response = await http.get(Uri.parse(AppUrl.WorldStatesApi));
  

if(response.statusCode == 200){
  var data = jsonDecode(response.body.toString());
  return WorldStatesModel.fromJson(data);
 
} else{
    throw Exception('K'); 
  }
}


    // Fetching Country Details

  Future<List<dynamic>> fetchCountriesListApi() async{
    
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesListApi));
  

if(response.statusCode == 200){
  data = jsonDecode(response.body);
  return data;
}else{
  throw Exception('error');
}
  
  }





}