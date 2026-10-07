import re

content = open('lib/models/campus_location.dart', encoding='utf-8').read()

# Locations clustered around Amrita Ettimadai: 10.9022, 76.9011
locations = [
    ('Central Library', 10.9025, 76.9015),
    ('Computer Science Block', 10.9030, 76.9020),
    ('Main Auditorium', 10.9015, 76.9005),
    ('North Campus Canteen', 10.9040, 76.9030),
    ('Main Sports Complex', 10.9005, 76.8990),
    ('Boys Hostel 1', 10.9050, 76.9040),
    ('Girls Hostel 1', 10.9060, 76.9050),
    ('Admin Block', 10.9010, 76.9000),
    ('State Bank ATM & Branch', 10.9008, 76.8995),
    ('Health Center', 10.9020, 76.9010),
    ('Innovation Lab', 10.9035, 76.9025),
    ('Parking Area A', 10.8995, 76.8980),
]

for name, lat, lng in locations:
    # Match the existing latitude and longitude lines for each location
    pattern = r"(name:\s*'" + name + r"'[\s\S]*?)latitude:\s*[0-9.]+,\s*longitude:\s*[0-9.]+,"
    repl = r"\g<1>latitude: " + str(lat) + r",\n      longitude: " + str(lng) + r","
    content = re.sub(pattern, repl, content)

open('lib/models/campus_location.dart', 'w', encoding='utf-8').write(content)
