import '../models/campus_location.dart';
import '../models/checkpoint.dart';

class PathFinding {
  /// Generate realistic turn-by-turn checkpoints for navigation between origin and destination.
  static List<Checkpoint> getMultiStopRoute({
    required String startLocation,
    required CampusLocation destination,
    List<String> stops = const [],
  }) {
    return getRoute(origin: startLocation, destination: destination, stops: stops);
  }

  static List<Checkpoint> getRoute({
    required String origin,
    required CampusLocation destination,
    List<String> stops = const [],
  }) {
    final checkpoints = <Checkpoint>[];
    int step = 1;

    // Find origin location
    CampusLocation? originLoc;
    try {
      originLoc = CampusLocation.allLocations.firstWhere((l) => l.name.toLowerCase() == origin.toLowerCase());
    } catch (_) {}
    
    // Default to a location far from center if not found
    final startLat = originLoc?.latitude ?? 10.9022;
    final startLng = originLoc?.longitude ?? 76.9011;

    checkpoints.add(Checkpoint(
      label: '${step++}',
      title: 'Start at $origin',
      instruction: 'Begin walking towards the main road.',
      latitude: startLat,
      longitude: startLng,
      dx: (startLng - 76.9011) / 0.005,
      dy: (startLat - 10.9022) / -0.005,
    ));

    if (stops.isNotEmpty) {
      for (final stop in stops) {
        CampusLocation? stopLoc;
        try {
          stopLoc = CampusLocation.allLocations.firstWhere((l) => l.name.toLowerCase() == stop.toLowerCase());
        } catch (_) {}
        checkpoints.add(Checkpoint(
          label: '${step++}',
          title: 'Stop: $stop',
          instruction: 'Pass through $stop area.',
          isStop: true,
          latitude: stopLoc?.latitude ?? (startLat + destination.latitude) / 2,
          longitude: stopLoc?.longitude ?? (startLng + destination.longitude) / 2,
          dx: ((stopLoc?.longitude ?? (startLng + destination.longitude) / 2) - 76.9011) / 0.005,
          dy: ((stopLoc?.latitude ?? (startLat + destination.latitude) / 2) - 10.9022) / -0.005,
        ));
      }
    }

    // Generate intermediate steps based on destination category
    final midLat = (startLat + destination.latitude) / 2;
    final midLng = (startLng + destination.longitude) / 2;

    switch (destination.category.toLowerCase()) {
      case 'library':
        checkpoints.add(Checkpoint(
          label: '${step++}',
          title: 'Cross Main Road',
          instruction: 'Use the zebra crossing near the admin block.',
          latitude: midLat + 0.001, longitude: midLng - 0.001,
          dx: (midLng - 0.001 - 76.9011) / 0.005, dy: (midLat + 0.001 - 10.9022) / -0.005,
        ));
        break;
      case 'academic block':
        checkpoints.add(Checkpoint(
          label: '${step++}',
          title: 'Turn Right at Gate 2',
          instruction: 'Follow the covered walkway.',
          latitude: midLat, longitude: midLng,
          dx: (midLng - 76.9011) / 0.005, dy: (midLat - 10.9022) / -0.005,
        ));
        break;
      case 'canteen':
        checkpoints.add(Checkpoint(
          label: '${step++}',
          title: 'Walk Past Library',
          instruction: 'Keep the library on your left.',
          latitude: midLat, longitude: midLng,
          dx: (midLng - 76.9011) / 0.005, dy: (midLat - 10.9022) / -0.005,
        ));
        break;
      case 'hostel':
        checkpoints.add(Checkpoint(
          label: '${step++}',
          title: 'Exit Academic Area',
          instruction: 'Head towards the residential zone.',
          latitude: midLat, longitude: midLng,
          dx: (midLng - 76.9011) / 0.005, dy: (midLat - 10.9022) / -0.005,
        ));
        break;
      case 'sports facility':
        checkpoints.add(Checkpoint(
          label: '${step++}',
          title: 'Head South',
          instruction: 'Walk towards the open ground area.',
          latitude: midLat, longitude: midLng,
          dx: (midLng - 76.9011) / 0.005, dy: (midLat - 10.9022) / -0.005,
        ));
        break;
      default:
        checkpoints.add(Checkpoint(
          label: '${step++}',
          title: 'Follow Signboards',
          instruction: 'Walk along the marked campus path.',
          latitude: midLat, longitude: midLng,
          dx: (midLng - 76.9011) / 0.005, dy: (midLat - 10.9022) / -0.005,
        ));
        break;
    }

    checkpoints.add(Checkpoint(
      label: '✓',
      title: 'Arrive at ${destination.name}',
      instruction: 'You have reached your destination. Building: ${destination.buildingCode}',
      latitude: destination.latitude,
      longitude: destination.longitude,
      dx: (destination.longitude - 76.9011) / 0.005,
      dy: (destination.latitude - 10.9022) / -0.005,
    ));

    return checkpoints;
  }
}
