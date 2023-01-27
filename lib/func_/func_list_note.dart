import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';



class ListCloud {
  String id_note, tanggal, judul, deskripsi ;
  ListCloud(
      {required this.id_note,
      required this.tanggal,
      required this.judul,
      required this.deskripsi,
      });
}

Future<List<ListCloud>> read(query) async {
  List<ListCloud> dataList = <ListCloud>[];
  ListCloud tmpData;
  final response = await Dio().get("http://tifrp20a.my.id/9/listnews.php",
  queryParameters: {
    "key" : query.toString(),
  });

  log("test query: $query}");
  log("test read data: ${response.data[0]}");

  var data = response.data;
  log("test decode: ${data[0]}");

  if (data.length == 0) {
    return dataList;
  } else {
    data.forEach((item) {
      tmpData = ListCloud(
          id_note: item["id_note"]!,
          tanggal: item["tanggal"]!,
          judul: item["judul"]!,
          deskripsi: item["deskripsi"]!);
      dataList.add(tmpData);
    });
    return dataList;
  }
}

