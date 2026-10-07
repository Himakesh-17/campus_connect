import re

content = open('lib/models/campus_location.dart').read()

locations = [
    ('Central Library', 28.545, 77.192),
    ('Computer Science Block', 28.546, 77.193),
    ('Main Auditorium', 28.544, 77.191),
    ('North Campus Canteen', 28.547, 77.194),
    ('Main Sports Complex', 28.543, 77.190),
    ('Boys Hostel 1', 28.548, 77.195),
    ('Girls Hostel 1', 28.549, 77.196),
    ('Admin Block', 28.542, 77.189),
    ('State Bank ATM & Branch', 28.541, 77.188),
    ('Health Center', 28.545, 77.190),
    ('Innovation Lab', 28.546, 77.191),
    ('Parking Area A', 28.540, 77.187),
]

for name, lat, lng in locations:
    pattern = r"(name:\s*'" + name + r"'[\s\S]*?icon:\s*'[^']+',)"
    repl = r"\g<1>\n      latitude: " + str(lat) + r",\n      longitude: " + str(lng) + r","
    content = re.sub(pattern, repl, content)

open('lib/models/campus_location.dart', 'w').write(content)
