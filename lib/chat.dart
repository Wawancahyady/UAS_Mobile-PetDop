import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:petdop/post.dart';
import 'package:petdop/user/profile.dart';
import 'package:petdop/notif.dart';


class Chat extends StatefulWidget {
  
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.green,
          title: new Text("Chat Pemilik"),
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
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Prin()),
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
        body: new Column(children: <Widget>[
          new Flexible(
              child: new ListView(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
          )),
          new Divider(height: 1.0),
          new Container(
            decoration:
                new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ]));
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          
          child: new Row(children: <Widget>[
            Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child:  IconButton(
                        icon: new Icon(Icons.camera_alt),
                        color: Colors.green,
                        onPressed: (){

                        }

                      )
                      
                      
                      ),
            new Flexible(
              child: new TextField(
                onChanged: (String text) {
                  setState(() {
                   
                  });
                },

                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(

                child:  IconButton(
                        icon: new Icon(Icons.send),
                        color: Colors.green,
                        onPressed: (){

                        }

                      )
                      
                      
                      ),

            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child:  IconButton(
                        icon: new Icon(Icons.mic),
                        color: Colors.green,
                        onPressed: (){
                        }

                      ) 
                      ),
          ]
          ),
          decoration: BoxDecoration(
            border:
              new Border(top: new BorderSide(color: Colors.green)))
      ),
    );
  }
}