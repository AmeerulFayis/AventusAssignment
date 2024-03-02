
import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class TodoModel{
  @HiveField(0)
   int? id;

  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;

  @HiveField(3)
  final String date;

  TodoModel({required this.title,required this.description, required this.date,this.id
  });
}