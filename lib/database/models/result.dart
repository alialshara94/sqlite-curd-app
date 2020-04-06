import 'package:sqlite_curd_app/database/models/database_model.dart';

class Result implements DatabaseModel {
  int rId;
  String rResult;
  int sId;
  Result({
    this.rId,
    this.rResult,
    this.sId,
  });

  Result.fromMap(Map<String,dynamic> map){
    this.rId = map['id'];
    this.rResult = map['r_result'];
    this.sId = map['s_id'];
  }

  @override
  String table() {
    return 'results';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id' : this.rId,
      'r_result' : this.rResult,
      's_id' : this.sId,
    };
  }

  @override
  String database() {
    return 'results_db';
  }

  @override
  int getId() {
    return this.rId;
  }
}
