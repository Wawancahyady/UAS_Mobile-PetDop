import 'package:flutter/material.dart';
import 'package:petdop/data.dart';
import 'package:petdop/listPet.dart';
import 'package:petdop/post.dart';
import 'package:petdop/detail.dart';
import 'package:petdop/notif.dart';
import 'dart:convert';
import 'package:petdop/model/petModel.dart';
import 'package:petdop/user/profile.dart';
import 'package:petdop/network/network.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final VoidCallback logout;
  Home(this.logout);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectIndex=0;
  double _crossAxisSpacing = 8, _aspectRatio = 2;
  int _crossAxisCount = 2;
   
  List<PetModel> list = [];
  getPet() async {
    setState(() {
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
      });
    } else {
      setState(() {
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

  logout(){
    setState(() {
      widget.logout();
    });
  }


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
              logout();
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


      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Berbagi Kebahagiaan",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Dengan Lingkungan Sekitar",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 24,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 0, 
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.only(right: 30,),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 16.0, left: 24.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "Pet List",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildPetList(Category.Animal, "", Colors.blue[200]),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Newest Pet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),

                       

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          height: MediaQuery.of(context).size.height * 0.35,
          child:GridView.builder(
            itemCount: list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.82, 
            ),

          scrollDirection: Axis.horizontal,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
     );},),),

            Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),

                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),

            Container(
              height: 130,
              margin: EdgeInsets.only(bottom: 16),
              child: PageView(
                physics: BouncingScrollPhysics(),
                children: [
                  contact("assets/images/vets/vet_0.jpeg", "I Kadek Arya Budi Artana", "0896-9724-9721"),
                  contact("assets/images/vets/vet_1.jpeg", "Kadek Wawan Cahyadi", "0812-4644-1335"),
                  contact("assets/images/vets/vet_2.jpeg", "Fachradina Yuniar", "0878-6094-6225"),
                  contact("assets/images/vets/vet_3.png", "PetDop Medical Center", "(0362) 4456-214-443"),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget buildPetList(Category category, String total, Color color){
    return Expanded(
      child: GestureDetector(
        onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Listpet()),
        );
        },
        child: Container(
          height: 80,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[200],
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.5),
                ),
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      "assets/images/" + (category == Category.Animal ? "animal": "logo") + ".png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 12,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text( category == Category.Animal? "Anjing dan Kucing" : "Unknown",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
 

  Widget contact(String imageUrl, String name, String phone){
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 4),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        border: Border.all(
          width: 1,
          color: Colors.grey[300],
        ),
      ),
      child: Row(
        children: [

          Container(
            height: 98,
            width: 98,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(
            width: 16,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                name,
                style: TextStyle(
                  color: Colors.grey[800],
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
                    Icons.phone,
                    color: Colors.grey[800],
                    size: 18,
                  ),

                  SizedBox(
                    width: 8,
                  ),

                  Text(
                    phone,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),

              SizedBox(
                height: 8,
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  "OPEN - 24/7",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}