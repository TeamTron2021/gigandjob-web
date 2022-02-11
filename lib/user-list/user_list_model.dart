class UserModel {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final DateTime birthdate;
  String status;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstname,
      required this.lastname,
      required this.birthdate,
      required this.status});

  factory UserModel.empty() => UserModel(
      id: "",
      firstname: "",
      lastname: "",
      birthdate: DateTime.now().subtract(const Duration(days: 1)),
      email: "",
      status: "");

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserModel(
      id: json['ID'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      birthdate: DateTime.parse(json['birthday']),
      email: json['email'],
      status: json['status'],
    );
  }
}
