import 'package:calendar_event/func_/func_handleNull.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'func_isLoading.dart';

addData(context, jdl, description ) async {
  //handle data kosong
  if (jdl == null || description == null  ) {
    handle("Semua data harus diisi!");
  } else {
    //jika data tidak kosong, loading lalu pushnamed ke fungsi read
    isLoading(context);
    FormData sendData = FormData.fromMap({
      "judul":jdl.toString(),
      "deskripsi":description.toString(),
    });
    final response = await Dio().post("http://tifrp20a.my.id/9/addnews.php", data : sendData);
    log("test send data :" + jdl.toString());
    

    return Navigator.of(context)
        .pushNamedAndRemoveUntil('/event_calendar', (Route<dynamic> route) => false);
        
  }
}