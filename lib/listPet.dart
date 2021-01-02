import 'package:flutter/material.dart';
import 'package:petdop/detail.dart';
import 'package:petdop/post.dart';
import 'dart:convert';
import 'package:petdop/model/petModel.dart';
import 'package:petdop/network/network.dart';
import 'package:http/http.dart' as http;

class Listpet extends StatefulWidget {

  @override
  _ListpetState createState() => _ListpetState();
}

class _ListpetState extends State<Listpet > {
   var loading = false;
double _crossAxisSpacing = 8, _mainAxisSpacing = 12, _aspectRatio = 2;
int _crossAxisCount = 2;
   
  List<PetModel> list = [];
  getPet() async {
    setState(() {
      loading = true;
    });
    list.clear();
    final response = await http.get(Network.getPet());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      setState(() {
        for (Map i in data) {
          list.add(PetModel.fromJson(i));
        }
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> onRefresh() async {
    getPet();
  }

  @override
  void initState() {
    super.initState();
    getPet();
  }
  int selectIndex=0;

  
  

  @override
  Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;
  var height = width / _aspectRatio;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.green,
        elevation: 0,
        leading: Icon(
          Icons.sort,
          color: Colors.grey[800],
        ),
        actions: [
           IconButton(
            icon: Icon(
              Icons.lock_open,
              color: Colors.black,
            ),
            onPressed: () {

            },
          ),
      
          SizedBox(
            width: 15,
          )
 
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color:Colors.green,
        child: Container(
          height:50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
                InkWell(
                  onTap: (){
                  },
                   child: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                ),
              InkWell(
                  onTap: (){
                    setState(() {
                    selectIndex= 1; 
                    print(selectIndex);              
                    });
                  },
                   child: Icon(
                  Icons.chat_rounded,
                  color: Colors.white,
                ),
                ),
               
              InkWell(
                  onTap: (){
                    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Post()),
              );
                  },
                   child: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                  
                ),
                
                ),
             InkWell(
                  onTap: (){
                    setState(() {
                    selectIndex= 0;             
                    });
                  },
                   child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                ),
            ],
          ),
        ),
      ),

       body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: onRefresh,
                child: GridView.builder(
                  itemCount: list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.82,
                    
                  ),
                  itemBuilder: (context, i) {
                    final a = list[i];
                    return InkWell(
                      onTap: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detail(a)));
                      },
                      child: Container(
                       height: 0,                      
                        decoration: BoxDecoration(
                          color: Colors.white,
                          
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          border: Border.all(
                            color: Colors.grey[200],
                            width: 3,
                          ),
                        ),
                        margin: EdgeInsets.only(right: 12, left: 12, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              child: Stack(
                                children: [                 
                                  Hero(
                                    tag: NetworkImage("https://petdop.000webhostapp.com/image/${a.image}"),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:NetworkImage("https://petdop.000webhostapp.com/image/${a.image}"),
                                          fit: BoxFit.cover,
                                        ),
                                        
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:Colors.red[400],
                                        ),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 16,
                                          color:Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),                            
                                ],
                              ),
                            ),
                              SizedBox(
                                    height: 4,
                                  ),
                              Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      color:Colors.blue[100],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    child: Text(
                                      "${a.kategori}",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 1,
                                  ),

                                  Text(
                                    "${a.nama}",
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 8,
                                  ),

                                  Text(
                                        "${a.jenisKelamin} (${a.umur} bulan)",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
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
                                        size: 18,
                                      ),

                                      SizedBox(
                                        width: 4,
                                      ),

                                      Text(
                                        "${a.alamat}",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),

                                      SizedBox(
                                        width: 4,
                                      ), 
                                    ],
                                  ),
                                ],
                              ),
                            ),                                     
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            );
          }
        }