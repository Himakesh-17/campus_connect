class CampusLocation {
  final String name;
  final String category;
  final String description;
  final String distance;
  final String walkingTime;
  final String buildingCode;
  final int floorCount;
  final double latitude;
  final double longitude;
  final String icon;
  final bool isFavorite;

  const CampusLocation({
    required this.name,
    required this.category,
    this.description = '',
    this.distance = '500 m',
    this.walkingTime = '~6 min',
    this.buildingCode = '',
    this.floorCount = 1,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.icon = 'location_on',
    this.isFavorite = false,
  });

  CampusLocation copyWith({
    String? name,
    String? category,
    String? description,
    String? distance,
    String? walkingTime,
    String? buildingCode,
    int? floorCount,
    double? latitude,
    double? longitude,
    String? icon,
    bool? isFavorite,
  }) {
    return CampusLocation(
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      distance: distance ?? this.distance,
      walkingTime: walkingTime ?? this.walkingTime,
      buildingCode: buildingCode ?? this.buildingCode,
      floorCount: floorCount ?? this.floorCount,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      icon: icon ?? this.icon,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  static const List<CampusLocation> allLocations = [
    CampusLocation(
      name: 'Central Library',
      category: 'Library',
      description: 'Main campus library with 3 floors of reading rooms, digital resources center, and group study areas.',
      distance: '450 m',
      walkingTime: '~6 min',
      buildingCode: 'LIB-101',
      floorCount: 3,
      icon: 'local_library',
      latitude: 10.9025,
      longitude: 76.9015,
    ),
    CampusLocation(
      name: 'Computer Science Block',
      category: 'Academic Block',
      description: 'Houses CS and IT departments with 8 labs, faculty offices, and seminar halls.',
      distance: '1.1 km',
      walkingTime: '~14 min',
      buildingCode: 'CS-302',
      floorCount: 4,
      icon: 'computer',
      latitude: 10.903,
      longitude: 76.902,
    ),
    CampusLocation(
      name: 'Main Auditorium',
      category: 'Hall',
      description: 'Air-conditioned auditorium with 1200 seating capacity for events, seminars, and cultural programs.',
      distance: '800 m',
      walkingTime: '~10 min',
      buildingCode: 'AUD-01',
      floorCount: 2,
      icon: 'theater_comedy',
      latitude: 10.9015,
      longitude: 76.9005,
    ),
    CampusLocation(
      name: 'North Campus Canteen',
      category: 'Canteen',
      description: 'Popular food court with 6 stalls, fresh snacks, cold coffee, and affordable meals.',
      distance: '620 m',
      walkingTime: '~8 min',
      buildingCode: 'CNT-02',
      floorCount: 1,
      icon: 'restaurant',
      latitude: 10.904,
      longitude: 76.903,
    ),
    CampusLocation(
      name: 'Main Sports Complex',
      category: 'Sports Facility',
      description: 'Indoor sports complex with badminton, table tennis, gym, and basketball courts.',
      distance: '950 m',
      walkingTime: '~12 min',
      buildingCode: 'SPT-01',
      floorCount: 2,
      icon: 'sports_basketball',
      latitude: 10.9005,
      longitude: 76.899,
    ),
    CampusLocation(
      name: 'Boys Hostel 1',
      category: 'Hostel',
      description: 'Accommodation for 400 students with mess, recreation room, and laundry.',
      distance: '1.3 km',
      walkingTime: '~16 min',
      buildingCode: 'BH-01',
      floorCount: 4,
      icon: 'hotel',
      latitude: 10.905,
      longitude: 76.904,
    ),
    CampusLocation(
      name: 'Girls Hostel 1',
      category: 'Hostel',
      description: 'Accommodation for 350 students with mess, common room, and reading hall.',
      distance: '1.2 km',
      walkingTime: '~15 min',
      buildingCode: 'GH-01',
      floorCount: 4,
      icon: 'hotel',
      latitude: 10.906,
      longitude: 76.905,
    ),
    CampusLocation(
      name: 'Admin Block',
      category: 'Administrative',
      description: 'Central administrative office, accounts, exam section, and registrar.',
      distance: '350 m',
      walkingTime: '~4 min',
      buildingCode: 'ADM-01',
      floorCount: 2,
      icon: 'business',
      latitude: 10.901,
      longitude: 76.9,
    ),
    CampusLocation(
      name: 'State Bank ATM & Branch',
      category: 'ATM',
      description: '24/7 ATM and mini bank branch inside campus.',
      distance: '350 m',
      walkingTime: '~4 min',
      buildingCode: 'BNK-01',
      floorCount: 1,
      icon: 'atm',
      latitude: 10.9008,
      longitude: 76.8995,
    ),
    CampusLocation(
      name: 'Health Center',
      category: 'Medical',
      description: 'Campus medical facility with doctor, pharmacy, and first aid.',
      distance: '500 m',
      walkingTime: '~6 min',
      buildingCode: 'MED-01',
      floorCount: 1,
      icon: 'local_hospital',
      latitude: 10.902,
      longitude: 76.901,
    ),
    CampusLocation(
      name: 'Innovation Lab',
      category: 'Lab',
      description: 'Maker space with 3D printers, IoT kits, and robotics equipment.',
      distance: '700 m',
      walkingTime: '~9 min',
      buildingCode: 'INV-01',
      floorCount: 1,
      icon: 'science',
      latitude: 10.9035,
      longitude: 76.9025,
    ),
    CampusLocation(
      name: 'Parking Area A',
      category: 'Parking',
      description: 'Main parking lot near gate 1 with 200 car and 500 two-wheeler slots.',
      distance: '200 m',
      walkingTime: '~3 min',
      buildingCode: 'PRK-A',
      floorCount: 1,
      icon: 'local_parking',
      latitude: 10.8995,
      longitude: 76.898,
    ),
  ];

  static List<String> get categories {
    final cats = allLocations.map((l) => l.category).toSet().toList();
    cats.sort();
    return ['All', ...cats];
  }
}
