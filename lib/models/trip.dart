import 'package:hive/hive.dart';

part 'trip.g.dart';

@HiveType(typeId: 1)
class Trip extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String pickup;

  @HiveField(2)
  String drop;

  @HiveField(3)
  String rideType;

  @HiveField(4)
  double fare;

  @HiveField(5)
  String status;

  @HiveField(6)
  DateTime dateTime;

  Trip({
    required this.id,
    required this.pickup,
    required this.drop,
    required this.rideType,
    required this.fare,
    required this.status,
    required this.dateTime,
  });
}
