class DbInserformmodal{
  final String? name;
  final String? email;
  final String? mobilenumber;

  DbInserformmodal({required this.name,  required this.email, required this.mobilenumber});

  DbInserformmodal.fromMap(Map<String , dynamic> res):
        name = res['name'],
        email = res['email'],
        mobilenumber = res['mobilenumber'];
  Map<String , Object?> toMap(){

    return {
      'name':name,
      'email':email,
      'mobilenumber':mobilenumber

    };
  }
}