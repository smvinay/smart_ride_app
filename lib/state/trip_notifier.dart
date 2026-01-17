import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/trip.dart';

final tripProvider =
StateNotifierProvider<TripNotifier, List<Trip>>(
        (ref) => TripNotifier());

class TripNotifier extends StateNotifier<List<Trip>> {
  final box = Hive.box<Trip>('trips');

  TripNotifier() : super([]) {
    loadTrips();
  }

  void loadTrips() {
    state = box.values.toList();
  }

  void addTrip(Trip trip) {
    box.put(trip.id, trip);
    state = [...state, trip];
    _simulateRide(trip);
  }

  void updateStatus(String id, String status) {
    final trip = box.get(id);
    if (trip != null) {
      trip.status = status;
      trip.save();
      state = [...state];
    }
  }

  void _simulateRide(Trip trip) {
    // Step 1: Driver assigned
    Timer(const Duration(seconds: 3), () {
      updateStatus(trip.id, 'Driver Assigned');
    });

    // Step 2: Ride started
    Timer(const Duration(seconds: 6), () {
      updateStatus(trip.id, 'Ride Started');
      _startFareUpdates(trip);
    });

    // Step 3: Ride completed
    Timer(const Duration(seconds: 14), () {
      updateStatus(trip.id, 'Completed');
    });
  }

  void _startFareUpdates(Trip trip) {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      final currentTrip = box.get(trip.id);

      if (currentTrip == null || currentTrip.status == 'Completed') {
        timer.cancel();
        return;
      }

      currentTrip.fare += 10; // simple fare increase
      currentTrip.save();

      state = [...state]; // notify UI
    });
  }

  void deleteTrip(String id) {
    box.delete(id);
    state = state.where((t) => t.id != id).toList();
  }



}
