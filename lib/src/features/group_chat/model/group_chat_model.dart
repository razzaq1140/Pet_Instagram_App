class GroupChatModel {
  final String image;
  final String name;
  final String member;
  String btTxt;
  final String status;
  final String? message;
  bool isFavourite;  
  bool isPin; 

  GroupChatModel({
    required this.image,
    required this.name,
    required this.member,
    required this.btTxt,
    required this.status,
    this.message,
    this.isFavourite = false,  
    this.isPin = false,  
  });
}
