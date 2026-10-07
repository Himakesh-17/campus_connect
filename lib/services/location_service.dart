import '../models/campus_location.dart';
import '../utils/constants.dart';

class LocationService {
  Future<List<CampusLocation>> getLocations() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return campusLocations;
  }

  List<CampusLocation> filterLocations({
    required List<CampusLocation> locations,
    required String query,
    required String category,
  }) {
    return locations.where((loc) {
      final matchesQuery = loc.name.toLowerCase().contains(query.toLowerCase()) || 
                           loc.category.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = category == 'All' || loc.category == category;
      return matchesQuery && matchesCategory;
    }).toList();
  }
}
