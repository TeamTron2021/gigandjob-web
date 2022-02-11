class CreateUserModel {
  String firstname;
  String lastname;
  DateTime birthdate;
  String email;
  String password;

  CreateUserModel(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.birthdate,
      required this.password});

  factory CreateUserModel.empty() => CreateUserModel(
      email: "",
      firstname: "",
      lastname: "",
      birthdate: DateTime.now().subtract(const Duration(days: 1)),
      password: "");
}
