import 'package:sqlite_curd_app/database/models/database_model.dart';

class Student implements DatabaseModel {
  int sId;
  String sName;
  int sAge;
  String sDepartment;
  Student({
    this.sId,
    this.sName,
    this.sAge,
    this.sDepartment,
  });

  Student.fromMap(Map<String,dynamic> map){
    this.sId = map['id'];
    this.sName = map['s_name'];
    this.sAge = map['s_age'];
    this.sDepartment = map['s_department'];
  }

  @override
  String table() {
    return 'students';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id' : this.sId,
      's_name' : this.sName,
      's_age' : this.sAge,
      's_department' : this.sDepartment,
    };
  }

  @override
  String database() {
    return 'students_db';
  }

  @override
  int getId() {
    return this.sId;
  }
}
