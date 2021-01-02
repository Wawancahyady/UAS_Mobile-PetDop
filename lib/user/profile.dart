import 'package:flutter/material.dart';
import 'package:petdop/notif.dart';
import 'package:petdop/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';


class Profile extends StatefulWidget {
  

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  String username = "", nama ="";

  geted()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
        username = preferences.getString("username");
        nama = preferences.getString("nama");
      });
  }

  @override
  void initState(){
    geted();
  }

  @override
  Widget build(BuildContext context) {
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
              Icons.supervised_user_circle,
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
                // Navigator.push(
                // context,
                // MaterialPageRoute(builder: (context) => Prin()),
              // );
                  },
                  child: Icon(
                  Icons.home,
                  color: Colors.white,
                   ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Notif()),
                    );
                  },
                  child: Icon(
                  Icons.notifications_active,
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
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
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
      
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              SizedBox(height: 60),
              CircleAvatar(
                backgroundColor: Colors.white,
                minRadius: 50,
                maxRadius: 75,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),

              Text(
                '$nama',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),

              Text(
                '-------------------------------',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SourceSansPro',
                  color: Colors.teal.shade100,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),

              SizedBox(
                height: 20.0,
                width: 150,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),

              InkWell(
                child: Card(
                  color: Colors.blue[50],
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal,
                    ),
                    title: Text(
                      '$username',
                      style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 17,
                          color: Colors.teal.shade900),
                    ),
                  ),
                ),
                
                onTap: (){
                 
                }
              ),

              InkWell(
                child: Card(
                   color: Colors.blue[50],
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.shield,
                      color: Colors.teal,
                    ),
                    title:Text(
                      'Ubah Password',
                      style: TextStyle(
    
                          fontSize: 20,
                          color: Colors.teal.shade900),
                    ),
                  ),
                ),
                onTap: (){
                  
                },
              ),

              InkWell(
                child: Card(
                  color: Colors.blue[50],
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.history,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Riwayat',
                      style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 20,
                          color: Colors.teal.shade900),
                    ),
                  ),
                ),
                onTap: (){
                }
              ),
            ],
          ),
        ),
    );
  }
}

