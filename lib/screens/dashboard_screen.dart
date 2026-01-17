import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/dashboard_provider.dart';
import '../state/trip_notifier.dart';
import 'add_trip_screen.dart';
import '../widgets/status_badge.dart';
import '../widgets/trip_type_chart.dart';
import '../widgets/spending_limit_card.dart';
import '../widgets/driver_tracker.dart';
import '../widgets/trip_status_timeline.dart';


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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🟢 HEADER / GREETING
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: const [
                    Text(
                      '👋 Welcome Back',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Track your rides and spending in real time',
                      style: TextStyle(color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// SUMMARY CARDS
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

              const SizedBox(height: 24),

              /// TRIP TYPE CHART
              const Text(
                'Trips by Ride Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TripTypeChart(data: dashboard.tripsByType),

              const SizedBox(height: 24),

              /// SPENDING LIMITS
              const Text(
                'Monthly Spending Limits',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Column(
                children: dashboard.spentByType.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SpendingLimitCard(
                      rideType: entry.key,
                      spent: entry.value,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              /// RECENT TRIPS
              const Text(
                'Recent Trips',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              /// LIST WITHOUT INTERNAL SCROLL
              trips.isEmpty
                  ? const Center(child: Text('No trips yet'))
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips.reversed.toList()[index];

                  return Dismissible(
                      key: ValueKey(trip.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                  ref.read(tripProvider.notifier).deleteTrip(trip.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                  content: const Text('Trip deleted'),
                  action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                  ref.read(tripProvider.notifier).addTrip(trip);
                  },
                  ),
                  ),
                  );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// TITLE + STATUS
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${trip.pickup} → ${trip.drop}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              StatusBadge(status: trip.status),
                            ],
                          ),

                          const SizedBox(height: 8),

                          /// TYPE + FARE
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trip.rideType,
                                style:
                                const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                '₹${trip.fare.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),

                          /// DRIVER TRACKING
                          if (trip.status == 'Driver Assigned' ||
                              trip.status == 'Ride Started') ...[
                            const SizedBox(height: 12),
                            DriverTracker(isActive: true),
                          ],

                          const SizedBox(height: 12),
                          TripStatusTimeline(status: trip.status),

                        ],
                      ),
                    ),
                    ),
                  );
                },
              ),
            ],
          ),
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
