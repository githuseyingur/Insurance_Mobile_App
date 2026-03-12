class PolicyModel {
  int? id;
  String? type;
  String? policyNumber;
  int? coverageAmount;
  int? premium;
  String? startDate;
  String? endDate;
  String? status;

  PolicyModel(
      {this.id,
      this.type,
      this.policyNumber,
      this.coverageAmount,
      this.premium,
      this.startDate,
      this.endDate,
      this.status});

  PolicyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    policyNumber = json['policyNumber'];
    coverageAmount = json['coverageAmount'];
    premium = json['premium'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['policyNumber'] = policyNumber;
    data['coverageAmount'] = coverageAmount;
    data['premium'] = premium;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['status'] = status;
    return data;
  }
}
