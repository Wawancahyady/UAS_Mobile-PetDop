

class PetModel {
  final String id;
  final String nama;
  final String kategori;
  final String jenisKelamin;
  final String alamat;
  final String umur;
  final String berat;
  final String keterangan;
  final String image;
  final String waktu;
  final String status;

  PetModel({this.id, this.nama, this.kategori, this.jenisKelamin, this.alamat, this.umur,this.berat, this.keterangan, this.image, this.waktu, this.status});
  factory PetModel.fromJson(Map<String, dynamic> json){
    return PetModel(
      id: json['id'],
      nama: json['nama'],
      kategori: json['kategori'],
      jenisKelamin: json['jenisKelamin'],
      alamat: json['alamat'],
      umur: json['umur'],
      berat: json['berat'],
      keterangan: json['keterangan'],
      image: json['image'],
      waktu: json['waktu'],
      status: json['status'],

    );
  }

}