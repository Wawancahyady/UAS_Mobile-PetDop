import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(

    home: Login(),
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}


enum LoginStatus{
  notSignIn,
  signIn
}

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String username,password;
  final _key = new GlobalKey<FormState>();
  bool _secure = true;

  showHide(){
    setState(() {
      _secure = !_secure;
    });
  }

  check(){
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
    login();
    }
  }

  login() async{
    final response = await http.post("https://petdop.000webhostapp.com/login.php", 
    body: {
      "username": username,
      "password": password
    });
    
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String usernameAPI = data['username'];
    String namaAPI = data['nama'];
    if (value==1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        saved(value, usernameAPI, namaAPI);
      });
      print(pesan);
    } else {
      print(pesan);
    }
  }

  saved(int value, String username, String nama)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("nama", nama);
      preferences.setString("username", username);
      preferences.commit();
    });
  }

  var value;
  geted()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  logout() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });

  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geted();
  }

  @override
  Widget build(BuildContext context) {

    switch (_loginStatus) {
      case LoginStatus.notSignIn:
         return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: Icon(
          Icons.local_library,
          color: Colors.white,
        ),
        title: Text('LOGIN FORM'),
        actions: [],
      ),

      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children:<Widget>[
            Image.asset('assets/images/logo.png'),
            TextFormField(
               validator: (nama){
                 if (nama.isEmpty) {
                  return "Mohon Masukan Email";
                 }

                 else if (!nama.contains('@')) {

                 return 'Email tidak valid';
                 }

                 return null;
                 },
                
            onSaved: (nama)=>username = nama,
            decoration: InputDecoration(
              hintText: 'Email',
              suffixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),

          SizedBox(height: 20.0,),
          TextFormField(
            validator: (pw){
                 if (pw.isEmpty) {
                  return "Mohon Masukan Password";
                 }
                
                 return null;
                },
            obscureText: _secure,
            onSaved: (pw)=>password = pw,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: showHide,
                icon: Icon( _secure ? Icons.visibility_off: Icons.visibility),
              ),

              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),

          SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Register()
                    ));
                  },
                  child: Text("Register Here"),
                ),
                RaisedButton(
                  child: Text('Login'),
                  color: Colors.green,
                  onPressed: (){
                    check();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
    break;
    
  case LoginStatus.signIn:
    return Home(logout);
    break;
}}}



//class register
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username, password, nama;
  final _key = new GlobalKey<FormState>();
   bool _secure = true;

  showHide(){
    setState(() {
      _secure = !_secure;
    });
  }
  check(){
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }

  }
  save() async{
    final response = await http.post("https://petdop.000webhostapp.com/register3.php", 
    body:{
      "nama": nama,
      "username": username,
      "password": password,
    }
    );

    final data =  jsonDecode(response.body);
    int value = data['value'];
    String pesan= data['message'];

    if (value==1) {
      setState(() {
        Navigator.pop(context);
      });
    } 
    else {
      print(pesan);
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: Icon(
          Icons.local_library,
          color: Colors.white,
        ),
        title: Text('REGISTER FORM'),
        actions: [],
      ),

     body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children:<Widget>[
            Image.asset('assets/images/logo.png'),
            TextFormField(
               validator: (e){
                 if (e.isEmpty) {
                  return "Mohon Masukan Nama";
                 }
                
                 return null;
                },
            onSaved: (e)=>nama = e,
            decoration: InputDecoration(
              hintText: 'Nama',
              suffixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),

            SizedBox(height: 20.0,),
            TextFormField(
               validator: (e){
                 if (e.isEmpty) {
                  return "Mohon Masukan Email";
                 }

                 else if (!e.contains('@')) {

                 return 'Email tidak valid';
                 }

                 return null;
                 },
                
            onSaved: (e)=>username = e,
            decoration: InputDecoration(
              hintText: 'Email',
              suffixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),

          SizedBox(height: 20.0,),
          TextFormField(
            validator: (e){
                 if (e.isEmpty) {
                  return "Mohon Masukan Password";
                 }
                
                 return null;
                },
            obscureText: _secure,
            onSaved: (e)=>password = e,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: showHide,
                icon: Icon( _secure ? Icons.visibility_off: Icons.visibility),
              ),

              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),

          SizedBox(height: 20.0,),
          Container(
            margin: const EdgeInsets.only(top: 6.0),
           child : new RaisedButton(
              onPressed: (){

                check();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)
              ),
              elevation: 0.0,
                padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.greenAccent,Colors.green]
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  
                  constraints: BoxConstraints(minWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text("Register",
                  style: TextStyle(color: Colors.black, fontSize: 26.0, fontWeight:FontWeight.w300),
                  ),
                ),
              )
            ),
          ),
          ]
        ),
        ),
    );
  }
}


