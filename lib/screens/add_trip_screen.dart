import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/trip.dart';
import '../state/trip_notifier.dart';

class AddTripScreen extends ConsumerStatefulWidget {
  const AddTripScreen({super.key});

  @override
  ConsumerState<AddTripScreen> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends ConsumerState<AddTripScreen> {
  final pickupCtrl = TextEditingController();
  final dropCtrl = TextEditingController();
  final fareCtrl = TextEditingController(text: '50');

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
              decoration: const InputDecoration(
                labelText: 'Pickup Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: dropCtrl,
              decoration: const InputDecoration(
                labelText: 'Drop Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: rideType,
              decoration: const InputDecoration(
                labelText: 'Ride Type',
                border: OutlineInputBorder(),
              ),
              items: ['Mini', 'Sedan', 'Auto', 'Bike']
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text(e)),
              )
                  .toList(),
              onChanged: (v) => setState(() => rideType = v!),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: fareCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Base Fare',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                if (pickupCtrl.text.isEmpty ||
                    dropCtrl.text.isEmpty ||
                    fareCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All fields are required')),
                  );
                  return;
                }

                ref.read(tripProvider.notifier).addTrip(
                  Trip(
                    id: const Uuid().v4(),
                    pickup: pickupCtrl.text,
                    drop: dropCtrl.text,
                    rideType: rideType,
                    fare: double.parse(fareCtrl.text),
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
