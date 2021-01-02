import 'package:flutter/material.dart';
import 'package:petdop/chat.dart';
import 'package:petdop/alert/alert.dart';
import 'package:petdop/logo.dart';
import 'package:petdop/model/petModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  final PetModel model;
  Detail(this.model);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text ("${widget.model.nama}"),
        brightness: Brightness.dark,
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.more_horiz,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      
      body: Column(              
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Hero(
                 tag: NetworkImage("https://petdop.000webhostapp.com/image/${widget.model.image}"),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:NetworkImage("https://petdop.000webhostapp.com/image/${widget.model.image}"),
                        fit: BoxFit.cover,
                      ),

                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           "${widget.model.nama}",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),

                          SizedBox(
                            height: 8,
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey[600],
                                size: 20,
                              ),

                              SizedBox(
                                width: 4,
                              ),

                              Text(
                                 "${widget.model.alamat}",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),

                              SizedBox(
                                width: 4,
                              ),
                            ],
                          ),
                        ],
                      ),

                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:Colors.green[400],
                        ),
                        child:  IconButton(
                          icon: Icon(
                            Icons.chat_bubble_rounded,
                            color: Colors.white,
                          ),

                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Chat()),
                            );
                          },
                        ),             
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [

                      buildPetFeature("${widget.model.jenisKelamin}", "Kelamin"),
                      buildPetFeature("${widget.model.umur} Bulan", "Umur"),
                      buildPetFeature("${widget.model.berat} Kg", "Berat"),

                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Keterangan",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),

                SizedBox(
                  height: 16,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                   "${widget.model.keterangan}",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),

                SizedBox(
                  height: 16,
                ),

                Padding(
                  padding: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Logo(),
                          SizedBox(
                            width: 12,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Posted date",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(
                                height: 4,
                              ),

                              Text(
                                "${widget.model.waktu}",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Container(                        
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        child : new RaisedButton(
                          onPressed: (){
                            showDialog(context: context,
                              builder: (BuildContext context){
                              return CustomDialogBox(
                                title: "Terima Kasih!!",
                                descriptions: "Mohon tunggu sampai kami mengirimkan anda notifikasi \n \n LET'S MAKE AND SHARE HAPPINES :)",
                                text: "Okay",
                              );
                              }
                            );
                          },
                          
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)
                        ),
                        elevation: 0.0,
                          padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: BoxConstraints(minWidth: 30.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text("Adoption",
                            style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight:FontWeight.bold),
                            ),
                          ),
                        )
                      ),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                          ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue[300].withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 0),
                          ),
                        ],
                        color: Colors.green[300],
                        ),                    
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildPetFeature(String value, String feature){
    return Expanded(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200],
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [

            Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 4,
            ),

            Text(
              feature,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),

          ],
        ),
      ),
    );
  }
    
  }