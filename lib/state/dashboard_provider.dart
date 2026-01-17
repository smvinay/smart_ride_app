import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trip.dart';
import 'trip_notifier.dart';

final dashboardProvider = Provider((ref) {
  final trips = ref.watch(tripProvider);

  final completed = trips.where((t) => t.status == 'Completed');

  return {
    'totalTrips': completed.length,
    'totalSpent': completed.fold<double>(
        0, (sum, t) => sum + t.fare),
    'byType': {
      'Mini': completed.where((t) => t.rideType == 'Mini').length,
      'Sedan': completed.where((t) => t.rideType == 'Sedan').length,
      'Auto': completed.where((t) => t.rideType == 'Auto').length,
      'Bike': completed.where((t) => t.rideType == 'Bike').length,
    }
  };
});
