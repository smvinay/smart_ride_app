import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/dashboard_provider.dart';
import '../state/trip_notifier.dart';
import 'add_trip_screen.dart';

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
            _summaryCard(
              title: 'Total Trips',
              value: dashboard['totalTrips'].toString(),
              icon: Icons.directions_car,
            ),
            _summaryCard(
              title: 'Total Spent',
              value: '₹${dashboard['totalSpent']}',
              icon: Icons.currency_rupee,
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
                  return ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text('${trip.pickup} → ${trip.drop}'),
                    subtitle: Text(trip.status),
                    trailing: Text('₹${trip.fare}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
