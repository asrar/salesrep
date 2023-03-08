class OrderRequestModel {
  String message;
  List<Data> data;

  OrderRequestModel({this.message, this.data});

  OrderRequestModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String serviceproviderId;
  String userId;
  String title;
  String detials;
  String dueDateTime;
  String notes;
  String estimatedBudget;
  String status;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.serviceproviderId,
        this.userId,
        this.title,
        this.detials,
        this.dueDateTime,
        this.notes,
        this.estimatedBudget,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceproviderId = json['serviceprovider_id'];
    userId = json['user_id'];
    title = json['title'];
    detials = json['detials'];
    dueDateTime = json['due_date_time'];
    notes = json['notes'];
    estimatedBudget = json['estimated_budget'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceprovider_id'] = this.serviceproviderId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['detials'] = this.detials;
    data['due_date_time'] = this.dueDateTime;
    data['notes'] = this.notes;
    data['estimated_budget'] = this.estimatedBudget;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
