import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/trip_notifier.dart';

class DashboardData {
  final int totalTrips;
  final double totalSpent;
  final Map<String, int> tripsByType;
  final Map<String, double> spentByType;

  DashboardData({
    required this.totalTrips,
    required this.totalSpent,
    required this.tripsByType,
    required this.spentByType,
  });
}

final dashboardProvider = Provider<DashboardData>((ref) {
  final trips = ref.watch(tripProvider);

  final completed = trips.where((t) => t.status == 'Completed');

  // 1️⃣ Count trips by type
  final tripsByType = {
    'Mini': completed.where((t) => t.rideType == 'Mini').length,
    'Sedan': completed.where((t) => t.rideType == 'Sedan').length,
    'Auto': completed.where((t) => t.rideType == 'Auto').length,
    'Bike': completed.where((t) => t.rideType == 'Bike').length,
  };

  // 2️⃣ Calculate spent amount by type
  Map<String, double> spentByType = {
    'Mini': 0,
    'Sedan': 0,
    'Auto': 0,
    'Bike': 0,
  };

  for (var trip in completed) {
    spentByType[trip.rideType] =
        (spentByType[trip.rideType] ?? 0) + trip.fare;
  }

  // 3️⃣ Return dashboard data
  return DashboardData(
    totalTrips: completed.length,
    totalSpent:
    completed.fold<double>(0, (sum, t) => sum + t.fare),
    tripsByType: tripsByType,
    spentByType: spentByType,
  );
});
