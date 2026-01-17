import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/trip.dart';
import '../state/trip_notifier.dart';

class AddTripScreen extends ConsumerWidget {
  final pickupCtrl = TextEditingController();
  final dropCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Ride')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: pickupCtrl, decoration: const InputDecoration(labelText: 'Pickup')),
            TextField(controller: dropCtrl, decoration: const InputDecoration(labelText: 'Drop')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final trip = Trip(
                  id: const Uuid().v4(),
                  pickup: pickupCtrl.text,
                  drop: dropCtrl.text,
                  rideType: 'Mini',
                  fare: 120,
                  status: 'Requested',
                  dateTime: DateTime.now(),
                );
                ref.read(tripProvider.notifier).addTrip(trip);
                Navigator.pop(context);
              },
              child: const Text('Confirm Ride'),
            )
          ],
        ),
      ),
    );
  }
}
