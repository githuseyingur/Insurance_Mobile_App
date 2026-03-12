class PolicyDetailModel {
  int? id;
  String? type;
  String? policyNumber;
  String? holderName;
  int? coverageAmount;
  int? premium;
  String? startDate;
  String? endDate;
  String? status;
  String? paymentMethod;
  String? riskLevel;
  List<String>? coverageDetails;
  Metadata? metadata;

  PolicyDetailModel(
      {this.id,
      this.type,
      this.policyNumber,
      this.holderName,
      this.coverageAmount,
      this.premium,
      this.startDate,
      this.endDate,
      this.status,
      this.paymentMethod,
      this.riskLevel,
      this.coverageDetails,
      this.metadata});

  PolicyDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    policyNumber = json['policyNumber'];
    holderName = json['holderName'];
    coverageAmount = json['coverageAmount'];
    premium = json['premium'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    paymentMethod = json['paymentMethod'];
    riskLevel = json['riskLevel'];
    coverageDetails = json['coverageDetails'].cast<String>();
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['policyNumber'] = policyNumber;
    data['holderName'] = holderName;
    data['coverageAmount'] = coverageAmount;
    data['premium'] = premium;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['status'] = status;
    data['paymentMethod'] = paymentMethod;
    data['riskLevel'] = riskLevel;
    data['coverageDetails'] = coverageDetails;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

class Metadata {
  String? targetObject;
  String? location;
  String? agentCode;

  Metadata({this.targetObject, this.location, this.agentCode});

  Metadata.fromJson(Map<String, dynamic> json) {
    targetObject = json['targetObject'];
    location = json['location'];
    agentCode = json['agentCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['targetObject'] = targetObject;
    data['location'] = location;
    data['agentCode'] = agentCode;
    return data;
  }
}
