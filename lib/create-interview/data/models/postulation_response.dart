class PostulationResponse {
  String id;
  String date;

  PostulationResponse({required this.id,required this.date});

  factory PostulationResponse.fromJson(Map<String, dynamic> data) {
    return PostulationResponse(id: data['id'], date: data['date']);
  }
}