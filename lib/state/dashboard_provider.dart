import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/trip_notifier.dart';

class DashboardData {
  final int totalTrips;
  final double totalSpent;
  final Map<String, int> tripsByType;

  DashboardData({
    required this.totalTrips,
    required this.totalSpent,
    required this.tripsByType,
  });
}

final dashboardProvider = Provider<DashboardData>((ref) {
  final trips = ref.watch(tripProvider);

  final completed = trips.where((t) => t.status == 'Completed');

  return DashboardData(
    totalTrips: completed.length,
    totalSpent:
    completed.fold<double>(0, (sum, t) => sum + t.fare),
    tripsByType: {
      'Mini': completed.where((t) => t.rideType == 'Mini').length,
      'Sedan': completed.where((t) => t.rideType == 'Sedan').length,
      'Auto': completed.where((t) => t.rideType == 'Auto').length,
      'Bike': completed.where((t) => t.rideType == 'Bike').length,
    },
  );
});
