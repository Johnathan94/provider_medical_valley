class BranchesResponseModel {
  int? id;
  int? providerId;
  String? location;
  double? latitude;
  double? longitude;

  BranchesResponseModel(
      {this.id, this.providerId, this.location, this.latitude, this.longitude});

  BranchesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['providerId'];
    location = json['branchName'];
    latitude = double.parse(json['latitude']);
    longitude = double.parse(json['longitude']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['providerId'] = providerId;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
