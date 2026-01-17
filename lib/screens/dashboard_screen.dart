import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/dashboard_provider.dart';
import '../state/trip_notifier.dart';
import 'add_trip_screen.dart';
import '../widgets/status_badge.dart';
import '../widgets/trip_type_chart.dart';


class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(dashboardProvider);
    final trips = ref.watch(tripProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Ride Dashboard'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTripScreen()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _animatedSummaryCard(
                  title: 'Trips',
                  value: dashboard.totalTrips,
                  icon: Icons.directions_car,
                  color: Colors.blue,
                ),
                const SizedBox(width: 12),
                _animatedSummaryCard(
                  title: 'Spent',
                  value: dashboard.totalSpent,
                  icon: Icons.currency_rupee,
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Trips by Ride Type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TripTypeChart(
              data: Map<String, int>.from(dashboard.tripsByType),
            ),

            const SizedBox(height: 16),
            const Text(
              'Recent Trips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: trips.isEmpty
                  ? const Center(child: Text('No trips yet'))
                  : ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips.reversed.toList()[index];
                  return Expanded(
                    child: trips.isEmpty
                        ? const Center(child: Text('No trips yet'))
                        : ListView.builder(
                      itemCount: trips.length,
                      itemBuilder: (context, index) {
                        final trip = trips.reversed.toList()[index];

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${trip.pickup} → ${trip.drop}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      StatusBadge(status: trip.status),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(trip.rideType),
                                      Text(
                                        '₹${trip.fare}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedSummaryCard({
    required String title,
    required num value,
    required IconData icon,
    Color? color,
  }) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 12),
              Text(title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: value.toDouble()),
                duration: const Duration(milliseconds: 700),
                builder: (context, val, _) {
                  return Text(
                    val.toStringAsFixed(0),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
