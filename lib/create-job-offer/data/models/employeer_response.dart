class EmployeerResponse {
  String id;
  String companyName;

  EmployeerResponse({required this.id,required this.companyName});

  factory EmployeerResponse.fromJson(Map<String, dynamic> data) {
    return EmployeerResponse(id: data['id'], companyName: data['companyName']);
  }
}