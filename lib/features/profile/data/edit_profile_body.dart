class EditProfileBody {
  int? id;
  String? fullName;
  String? email;
  String? mobile;
  String? licenseImage;
  String? commercialRecordImage;
  List<ProviderBranches>? providerBranches;

  EditProfileBody(
      {this.id,
        this.fullName,
        this.email,
        this.mobile,
        this.licenseImage,
        this.commercialRecordImage,
        this.providerBranches});

  EditProfileBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    mobile = json['mobile'];
    licenseImage = json['licenseImage'];
    commercialRecordImage = json['commercialRecordImage'];
    if (json['providerBranches'] != null) {
      providerBranches = <ProviderBranches>[];
      json['providerBranches'].forEach((v) {
        providerBranches!.add( ProviderBranches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['licenseImage'] = licenseImage;
    data['commercialRecordImage'] = commercialRecordImage;
    if (providerBranches != null) {
      data['providerBranches'] =
          providerBranches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProviderBranches {
  int? branchId;

  ProviderBranches({this.branchId});

  ProviderBranches.fromJson(Map<String, dynamic> json) {
    branchId = json['branchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['branchId'] = branchId;
    return data;
  }
}
