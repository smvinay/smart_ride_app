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
    Timer(const Duration(seconds: 3),
            () => updateStatus(trip.id, 'Driver Assigned'));
    Timer(const Duration(seconds: 6),
            () => updateStatus(trip.id, 'Ride Started'));
    Timer(const Duration(seconds: 10),
            () => updateStatus(trip.id, 'Completed'));
  }
}
