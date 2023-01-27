import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//handle (menampilkan toast) dinamis. pesan yang ditampilkan disesuaikan dengan pesan yang diterima
//pesan yang diterima ditampung pada variable message
handle(message){
    var handleNull = Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
    );
    return handleNull;
}