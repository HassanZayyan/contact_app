class Kontak {
  int? id;
  String name;
  String mobileNo;
  String email;
  String? company;

  Kontak({
    this.id,
    required this.name,
    required this.mobileNo,
    required this.email,
    this.company,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobileNo': mobileNo,
      'email': email,
      'company': company,
    };
  }

  factory Kontak.fromMap(Map<String, dynamic> map) {
    return Kontak(
      id: map['id'],
      name: map['name'],
      mobileNo: map['mobileNo'],
      email: map['email'],
      company: map['company'],
    );
  }
}