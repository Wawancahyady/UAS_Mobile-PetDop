class NotifModel {
  final String avatarUrl;
  final String name;
  final String datetime;
  final String message;

  NotifModel({this.avatarUrl, this.name, this.datetime, this.message});

  static final List<NotifModel> dummyData = [
    NotifModel(
      avatarUrl: "assets/images/logo.png",
      name: "Petdop",
      datetime: "19:22",
      message: "Terima kasih sudah mengadopsi",
    ),
    NotifModel(
      avatarUrl: "assets/images//vets/vet_0.jpeg",
      name: "Arya Budi",
      datetime: "14:34",
      message: "Jangan lupa untuk memberikan nilai dan komentar untuk PetDop, agar kami dapat terus berkembang dan lebih baik!",
    ),
    NotifModel(
      avatarUrl: "assets/images//vets/vet_1.jpeg",
      name: "Wawan Cahyadi",
      datetime: "11:05",
      message: "Baik kak",
    ),
    NotifModel(
      avatarUrl: "assets/images//vets/vet_2.jpeg",
      name: "Dina Yuniar",
      datetime: "09:46",
      message: "Nana tidak sabar mau bermain di rumah barunya",
    ),
    NotifModel(
      avatarUrl: "assets/images/logo.png",
      name: "PetDop",
      datetime: "10:18",
      message: "Nantikan fitur baru dan pengoptimalan sistem kami!",
    ),
  ];
}