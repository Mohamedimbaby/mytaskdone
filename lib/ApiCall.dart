import 'dart:convert';

import 'package:flutterapp/Constants.dart';
import 'package:flutterapp/models/apiModel.dart';
import 'package:http/http.dart' as http;
class ApiCall {
 static  Future <apiModel>getApiResponse ()async{
    var response = await http.get(Constants.baseUrl);
    var jsonDecoded = jsonDecode(response.body);
    print(jsonDecoded);
    var model = apiModel.fromJson(jsonDecoded);
    model.img=List();
    jsonDecoded['img'].forEach((v){
      model.img.add(v);
    });

    return model;
  }
}