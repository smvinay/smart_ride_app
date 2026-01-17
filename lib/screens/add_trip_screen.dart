import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/trip.dart';
import '../state/trip_notifier.dart';

class AddTripScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends ConsumerState<AddTripScreen> {
  final pickupCtrl = TextEditingController();
  final dropCtrl = TextEditingController();
  String rideType = 'Mini';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Ride')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: pickupCtrl,
              decoration: const InputDecoration(labelText: 'Pickup Location'),
            ),
            TextField(
              controller: dropCtrl,
              decoration: const InputDecoration(labelText: 'Drop Location'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: rideType,
              items: ['Mini', 'Sedan', 'Auto', 'Bike']
                  .map(
                    (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
                  .toList(),
              onChanged: (val) => setState(() => rideType = val!),
              decoration: const InputDecoration(labelText: 'Ride Type'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (pickupCtrl.text.isEmpty ||
                    dropCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All fields required')),
                  );
                  return;
                }

                ref.read(tripProvider.notifier).addTrip(
                  Trip(
                    id: const Uuid().v4(),
                    pickup: pickupCtrl.text,
                    drop: dropCtrl.text,
                    rideType: rideType,
                    fare: 100,
                    status: 'Requested',
                    dateTime: DateTime.now(),
                  ),
                );

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

