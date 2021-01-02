import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petdop/notif.dart';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:petdop/user/profile.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  int selectIndex=0;
  File _image;

_imgFromCamera() async {
  File image = await ImagePicker.pickImage(
    source: ImageSource.camera, imageQuality: 50
  );

  setState(() {
    _image = image;
  });
}

_imgFromGallery() async {
  File image = await  ImagePicker.pickImage(
      source: ImageSource.gallery, imageQuality: 50
  );

  setState(() {
    _image = image;
  });
}
          
  void _showPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Gallery'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
}

TextEditingController namaController = TextEditingController();
TextEditingController kategoriController = TextEditingController();
TextEditingController jkController = TextEditingController();
TextEditingController alamatController = TextEditingController();
TextEditingController umurController = TextEditingController();
TextEditingController beratController = TextEditingController();
TextEditingController keteranganController = TextEditingController();

save() async{
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text("Processing"),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                height: 4,
              ),
              Text("Loading...")
            ],
          ),
        ),
      );
    }
  );

try{

  var stream = http.ByteStream(DelegatingStream.typed(_image.openRead()));
  var length = await _image.length();
  var url = Uri.parse("https://petdop.000webhostapp.com/tambah.php");

  var request=http.MultipartRequest("POST", url);
  var multiPartFile=http.MultipartFile("image", stream, length, filename:path.basename(_image.path));

   request.fields['nama']= namaController.text;
   request.fields['kategori'] = kategoriController.text;
   request.fields ['jenisKelamin'] = jkController.text;
   request.fields ['alamat'] = alamatController.text;
   request.fields ['umur'] = umurController.text;
   request.fields ['berat'] = beratController.text;
   request.fields ['keterangan'] = keteranganController.text;
   request.files.add(multiPartFile);

   var response = await request.send();
   response.stream.transform(utf8.decoder).listen((value){
     print(value);
     final data = jsonDecode(value);
     int valueGet = data['value'];
     String message = data['value'];

     if (valueGet==1) {
       Navigator.pop(context);
       print(message);
     } else {
       Navigator.pop(context);
       print(message);
     }
   });
  if (response.statusCode>2){
    Navigator.pop(context);
  }

}

catch(e){
debugPrint("Error $e");
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
        title: Text('POST A PET'),
        actions: [],
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
                    setState(() {  
                      selectIndex=0;            
                    });
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

     body: Form(

        child: ListView(
          padding: EdgeInsets.all(16.0),
          children:<Widget>[

           Text("Identias Hewan:",
              style: TextStyle(
              color: Colors.grey[600],
              fontSize: 20,
              fontWeight: FontWeight.bold,
              ),
              ),
               SizedBox(height: 15.0,),

            TextFormField(
              controller: namaController,
            decoration: InputDecoration(
              hintText: 'Nama Hewan',
              suffixIcon: Icon(Icons.create),
              border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),

              SizedBox(height: 20.0,),
            TextFormField(
              controller: kategoriController,
            decoration: InputDecoration(
              hintText: 'Kategori (Kucing/Anjing/Lainnya)',
              suffixIcon: Icon(Icons.add_chart),
              border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),
          SizedBox(height: 20.0,),
          
          TextFormField(
              controller: jkController,
            decoration: InputDecoration(
              hintText: 'Jenis Kelamin (Betina/Jantan)',
              suffixIcon: Icon(Icons.create),
              
              border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),

          SizedBox(height: 30.0,),
          Text("Keterangan Tambahan:",
              style: TextStyle(
              color: Colors.grey[600],
              fontSize: 20,
              fontWeight: FontWeight.bold,
              ),
              ),
               SizedBox(height: 15.0,),

          TextFormField(
            controller: umurController,
            decoration: InputDecoration(
              hintText: 'Umur Hewan dalam bulan',
              suffixIcon: Icon(Icons.date_range_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),
          
           SizedBox(height: 20.0,),

            TextFormField(
            controller: beratController,
            decoration: InputDecoration(
              hintText: 'Berat dalam Kg',
              suffixIcon: Icon(Icons.line_weight_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),
          
           SizedBox(height: 20.0,),
            TextFormField(
              controller: alamatController,
            decoration: InputDecoration(
              hintText: 'Alamat',
              suffixIcon: Icon(Icons.add_location),
              border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),
          
          SizedBox(height: 30.0,),
          Text("Deskripsi:",
              style: TextStyle(
              color: Colors.grey[600],
              fontSize: 20,
              fontWeight: FontWeight.bold,
              ),
              ),
               SizedBox(height: 15.0,),
               
          TextFormField(
            controller: keteranganController,
            decoration: InputDecoration(
              hintText: 'Deskripsi',
              suffixIcon: Icon(Icons.create),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              )
            ),
          ),

          SizedBox(height: 30.0,),
          Text("Foto Terbaru Hewan:",
              style: TextStyle(
              color: Colors.grey[600],
              fontSize: 20,
              fontWeight: FontWeight.bold,
              ),
              ),
               SizedBox(height: 15.0,),

          InkWell(
          onTap: () {
              _showPicker(context);
            },
          child: _image == null? Image.asset('assets/images/basic.png',
          fit: BoxFit.cover): Image.file(_image, fit:BoxFit.cover,)),

          Container(
            margin: const EdgeInsets.only(top: 6.0),
           child : new RaisedButton(
              onPressed: (){
                  save(); 
                  Navigator.pop(context);
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
                  child: Text("Post",
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