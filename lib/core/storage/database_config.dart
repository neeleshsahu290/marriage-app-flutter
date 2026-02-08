class DatabaseConfig {
  static const String databaseName = "swan_match_app.db";
  static const int databaseVersion = 2;

  static const String recommendedMatchesTable = 'recommended_matches';
  static const createTableQueries = [createTableRecommendMatches];

  static const String createTableRecommendMatches = '''
CREATE TABLE recommended_matches (
  match_id TEXT PRIMARY KEY,

  status TEXT NOT NULL,
  user_id TEXT NOT NULL,

  is_sent_by_me INTEGER,
  request_type TEXT,

  full_name TEXT,
  location TEXT,

  dob TEXT,
  gender TEXT,
  height_cm TEXT,

  religion TEXT,
  religious_faith TEXT,

  languages_known TEXT,

  bio TEXT,
  marital_status TEXT,

  has_children INTEGER,

  family_type TEXT,
  parents_status TEXT,
  education_level TEXT,
  profession TEXT,

  personality_traits TEXT,
  hobbies TEXT,
  profile_photos TEXT,
  habits TEXT,
  images TEXT,

  marriage_priority TEXT,

  phone TEXT,
  email TEXT,

  latitude REAL,
  longitude REAL,

  phone_verified INTEGER,
  email_verified INTEGER,

  is_active INTEGER,

  show_online_status INTEGER,
  show_email INTEGER,
  show_phone INTEGER,

  photo_visibility TEXT,

  created_at TEXT,
  updated_at TEXT
);
''';

  static const String getProfilesByStatusByUser = '''
SELECT * 
FROM recommended_matches
WHERE status = ? AND is_sent_by_me = ?;
''';

  static const String getProfilesByStatus = '''
SELECT * 
FROM recommended_matches
WHERE status = ?;
''';

  static const String changeMatchStatus = '''
UPDATE recommended_matches
SET status = ?
WHERE match_id = ?;
''';
}
