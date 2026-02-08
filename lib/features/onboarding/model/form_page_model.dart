import 'package:swan_match/features/onboarding/model/form_feild_model.dart';

class FormPageModel {
  final String pageTitle;
  final String pageDesc;
  final List<FormFieldModel> fields;

  FormPageModel({
    required this.pageTitle,
    required this.pageDesc,
    required this.fields,
  });

  factory FormPageModel.fromJson(Map<String, dynamic> json) {
    return FormPageModel(
      pageTitle: json['page_tile'] ?? '',
      pageDesc: json['page_desc'] ?? '',
      fields: (json['feilds'] as List<dynamic>? ?? [])
          .map((e) => FormFieldModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page_tile': pageTitle,
      'page_desc': pageDesc,
      'feilds': fields.map((e) => e.toJson()).toList(),
    };
  }
}

List<Map<String, dynamic>> formFeilds = [
  {
    "page_tile": "basicInfoTitle",
    "page_desc": "basicInfoDesc",
    "feilds": [
      {
        "key": "full_name",
        "label": "fullNameLabel",
        "hint": "fullNameHint",
        "type": "text_field",
        "properties": {"input_type": "text"},
        "is_required": true,
        "error_text": "fullNameError",
      },
      {
        "key": "dob",
        "label": "dobLabel",
        "hint": "dobHint",
        "type": "text_field",
        "properties": {"input_type": "date"},
        "is_required": true,
        "error_text": "dobError",
      },
      {
        "key": "gender",
        "label": "genderLabel",
        "hint": "genderHint",
        "type": "drop_down",
        "properties": {"input_type": "gender"},
        "is_required": true,
        "error_text": "genderError",
      },
      {
        "key": "height_cm",
        "label": "heightLabel",
        "hint": "heightHint",
        "type": "drop_down",
        "properties": {"input_type": "height"},
        "is_required": true,
        "error_text": "heightError",
      },
    ],
  },

  {
    "page_tile": "valuesTitle",
    "page_desc": "valuesDesc",
    "feilds": [
      {
        "key": "religion",
        "label": "religionLabel",
        "hint": "religionHint",
        "type": "drop_down",
        "properties": {"input_type": "religion"},
        "is_required": true,
        "error_text": "religionError",
      },
      {
        "key": "religious_faith",
        "label": "faithLabel",
        "hint": "selectHint",
        "type": "drop_down",
        "properties": {"input_type": "faith"},
        "is_required": false,
        "error_text": "",
      },
      {
        "key": "languages_known",
        "label": "languagesLabel",
        "hint": "selectHint",
        "type": "multi_drop_down",
        "properties": {"max": 5},
        "is_required": true,
        "error_text": "languagesError",
      },
    ],
  },

  {
    "page_tile": "bioFamilyTitle",
    "page_desc": "bioFamilyDesc",
    "feilds": [
      {
        "key": "bio",
        "label": "bioLabel",
        "hint": "bioHint",
        "type": "text_area",
        "properties": {"max_length": 300},
        "is_required": true,
        "error_text": "bioError",
      },
      {
        "key": "marital_status",
        "label": "maritalStatusLabel",
        "hint": "selectHint",
        "type": "drop_down",
        "properties": {"input_type": "marital_status"},
        "is_required": true,
        "error_text": "maritalStatusError",
      },
      {
        "key": "has_children",
        "label": "childrenLabel",
        "hint": "selectHint",
        "type": "drop_down",
        "properties": {"input_type": "yes_no"},
        "is_required": true,
        "error_text": "childrenError",
      },
      {
        "key": "family_type",
        "label": "familyTypeLabel",
        "hint": "selectHint",
        "type": "drop_down",
        "properties": {"input_type": "family_type"},
        "is_required": true,
        "error_text": "familyTypeError",
      },
      {
        "key": "parents_status",
        "label": "parentsStatusLabel",
        "hint": "selectHint",
        "type": "drop_down",
        "properties": {"input_type": "parents_status"},
        "is_required": false,
        "error_text": "parentsStatusError",
      },
    ],
  },

  {
    "page_tile": "lifestyleTitle",
    "page_desc": "lifestyleDesc",
    "feilds": [
      {
        "key": "education_level",
        "label": "educationLabel",
        "hint": "selectHint",
        "type": "drop_down",
        "properties": {"input_type": "education"},
        "is_required": true,
        "error_text": "educationError",
      },
      {
        "key": "profession",
        "label": "professionLabel",
        "hint": "selectHint",
        "type": "drop_down",
        "properties": {"input_type": "profession"},
        "is_required": true,
        "error_text": "professionError",
      },
      {
        "key": "habits",
        "label": "habitsLabel",
        "hint": "habitsHint",
        "type": "multi_select",
        "is_required": false,
        "error_text": "",
      },
    ],
  },

  {
    "page_tile": "personalityTitle",
    "page_desc": "personalityDesc",
    "feilds": [
      {
        "key": "personality_traits",
        "label": "personalityLabel",
        "hint": "personalityHint",
        "type": "multi_select",
        "properties": {"max": 5},
        "is_required": true,
        "error_text": "personalityError",
      },
    ],
  },

  {
    "page_tile": "hobbiesTitle",
    "page_desc": "hobbiesDesc",
    "feilds": [
      {
        "key": "hobbies",
        "label": "hobbiesLabel",
        "hint": "hobbiesHint",
        "type": "multi_select",
        "properties": {"max": 15},
        "is_required": false,
        "error_text": "",
      },
    ],
  },

  {
    "page_tile": "photosTitle",
    "page_desc": "photosDesc",
    "feilds": [
      {
        "key": "profile_photos",
        "label": "photosLabel",
        "hint": "photosHint",
        "type": "image_picker",
        "properties": {"min": 3, "max": 6},
        "is_required": true,
        "error_text": "photosError",
      },
    ],
  },

  {
    "page_tile": "preferencesTitle",
    "page_desc": "preferencesDesc",
    "feilds": [
      {
        "key": "preferred_age_range",
        "label": "ageRangeLabel",
        "hint": "ageRangeHint",
        "type": "range_slider",
        "properties": {
          "min": 18,
          "max": 60,
          "default_min": 18,
          "default_max": 50,
        },
        "is_required": false,
        "error_text": "ageRangeError",
      },
      {
        "key": "preferred_distance",
        "label": "distanceLabel",
        "hint": "distanceHint",
        "type": "single_slider",
        "properties": {"min": 0, "max": 1000, "default": 200, "unit": "km"},
        "is_required": false,
        "error_text": "distanceError",
      },

      {
        "key": "preferred_min_education",
        "label": "preferredMinEducationLabel",
        "hint": "preferredMinEducationHint",
        "type": "drop_down",
        "properties": {"input_type": "education"},
        "is_required": false,
        "error_text": "preferredMinEducationError",
      },
    ],
  },
];

// List<Map<String, dynamic>> formFeilds = [
//   /// ------------------ BASIC INFORMATION ------------------
//   {
//     "page_tile": "Basic Information",
//     "page_desc": "Tell us about yourself",
//     "feilds": [
//       {
//         "key": "full_name",
//         "label": "Full Name",
//         "label_icon": "",
//         "hint": "Enter your name",
//         "type": "text_field",
//         "properties": {"input_type": "text"},
//         "is_required": true,
//         "error_text": "Name is required",
//       },
//       {
//         "key": "dob",
//         "label": "Date of Birth",
//         "label_icon": "",
//         "hint": "Select Date",
//         "type": "text_field",
//         "properties": {"input_type": "date"},
//         "is_required": true,
//         "error_text": "Date of birth is required",
//       },
//       {
//         "key": "gender",
//         "label": "Gender",
//         "label_icon": "",
//         "hint": "Select Gender",
//         "type": "drop_down",
//         "properties": {"input_type": "gender"},
//         "is_required": true,
//         "error_text": "Gender is required",
//       },
//       {
//         "key": "height_cm",
//         "label": "Height",
//         "label_icon": "",
//         "hint": "Select Height",
//         "type": "drop_down",
//         "properties": {"input_type": "height"},
//         "is_required": true,
//         "error_text": "Height is required",
//       },
//       // {
//       //   "key": "location",
//       //   "label": "Location",
//       //   "label_icon": "",
//       //   "hint": "Select City",
//       //   "type": "drop_down",
//       //   "properties": {"input_type": "city"},
//       //   "is_required": true,
//       //   "error_text": "Location is required",
//       // },
//     ],
//   },

//   /// ------------------ VALUES & BELIEFS ------------------
//   {
//     "page_tile": "Values & Beliefs",
//     "page_desc": "Share your religious background",
//     "feilds": [
//       {
//         "key": "religion",
//         "label": "Religion",
//         "label_icon": "",
//         "hint": "Select your religion",
//         "type": "drop_down",
//         "properties": {"input_type": "religion"},
//         "is_required": true,
//         "error_text": "Religion is required",
//       },
//       // {
//       //   "key": "community",
//       //   "label": "Community",
//       //   "label_icon": "",
//       //   "hint": "Select community",
//       //   "type": "drop_down",
//       //   "properties": {"input_type": "community"},
//       //   "is_required": false,
//       //   "error_text": "",
//       // },
//       {
//         "key": "religious_faith",
//         "label": "Religious Faith",
//         "label_icon": "",
//         "hint": "Select",
//         "type": "drop_down",
//         "properties": {"input_type": "faith"},
//         "is_required": false,
//         "error_text": "",
//       },
//       {
//         "key": "languages_known",
//         "label": "Languages Known",
//         "label_icon": "",
//         "hint": "Select",
//         "type": "multi_drop_down",
//         "properties": {"max": 5},
//         "is_required": true,
//         "error_text": "Select at least one language",
//       },
//     ],
//   },

//   /// ------------------ BIO & FAMILY ------------------
//   {
//     "page_tile": "Bio & Family",
//     "page_desc": "Tell us about your family",
//     "feilds": [
//       {
//         "key": "bio",
//         "label": "Bio",
//         "label_icon": "",
//         "hint": "Tell us about yourself",
//         "type": "text_area",
//         "properties": {"max_length": 300},
//         "is_required": true,
//         "error_text": "Bio is required",
//       },
//       {
//         "key": "marital_status",
//         "label": "Marital Status",
//         "label_icon": "",
//         "hint": "Select",
//         "type": "drop_down",
//         "properties": {"input_type": "marital_status"},
//         "is_required": true,
//         "error_text": "Marital status is required",
//       },
//       {
//         "key": "has_children",
//         "label": "Do you have children?",
//         "label_icon": "",
//         "hint": "Select",
//         "type": "drop_down",
//         "properties": {"input_type": "yes_no"},
//         "is_required": true,
//         "error_text": "Please select an option",
//       },
//       {
//         "key": "family_type",
//         "label": "Family Type",
//         "label_icon": "",
//         "hint": "Select",
//         "type": "drop_down",
//         "properties": {"input_type": "family_type"},
//         "is_required": true,
//         "error_text": "Family type is required",
//       },
//       {
//         "key": "parents_status",
//         "label": "Parents Status",
//         "label_icon": "",
//         "hint": "Select",
//         "type": "drop_down",
//         "properties": {"input_type": "parents_status"},
//         "is_required": false,
//         "error_text": "",
//       },
//     ],
//   },

//   /// ------------------ LIFESTYLE ------------------
//   {
//     "page_tile": "Lifestyle",
//     "page_desc": "Profession and education",
//     "feilds": [
//       {
//         "key": "education_level",
//         "label": "Education Level",
//         "label_icon": "",
//         "hint": "Select",
//         "type": "drop_down",
//         "properties": {"input_type": "education"},
//         "is_required": true,
//         "error_text": "Education is required",
//       },
//       {
//         "key": "profession",
//         "label": "Profession",
//         "label_icon": "",
//         "hint": "Select",
//         "type": "drop_down",
//         "properties": {"input_type": "profession"},
//         "is_required": true,
//         "error_text": "Profession is required",
//       },
//       {
//         "key": "habits",
//         "label": "Habits",
//         "label_icon": "",
//         "hint": "Select your habits",
//         "type": "multi_select",
//         "is_required": false,
//         "error_text": "",
//       },
//     ],
//   },

//   /// ------------------ PERSONALITY ------------------
//   {
//     "page_tile": "Personality",
//     "page_desc": "Select up to 5 traits to show off your personality",
//     "feilds": [
//       {
//         "key": "personality_traits",
//         "label": "Personality Traits",
//         "label_icon": "",
//         "hint": "Select up to 5",
//         "type": "multi_select",
//         "properties": {"max": 5},
//         "is_required": true,
//         "error_text": "Select at least one trait",
//       },
//     ],
//   },

//   /// ------------------ HOBBIES ------------------
//   {
//     "page_tile": "Hobbies",
//     "page_desc": "Select up to 15 interests to make your profile stand out",
//     "feilds": [
//       {
//         "key": "hobbies",
//         "label": "Hobbies & Interests",
//         "label_icon": "",
//         "hint": "Select up to 15",
//         "type": "multi_select",
//         "properties": {"max": 15},
//         "is_required": false,
//         "error_text": "",
//       },
//     ],
//   },

//   /// ------------------ PROFILE PHOTOS ------------------
//   {
//     "page_tile": "Profile Photos",
//     "page_desc": "You need to upload at least 3 photos",
//     "feilds": [
//       {
//         "key": "profile_photos",
//         "label": "Upload Photos",
//         "label_icon": "",
//         "hint": "photos are required",
//         "type": "image_picker",
//         "properties": {"min": 3, "max": 6},
//         "is_required": true,
//         "error_text": "Minimum 3 photos required",
//       },
//     ],
//   },

//   /// ------------------ PREFERENCES ------------------
//   {
//     "page_tile": "Preferences",
//     "page_desc": "Set your match preferences",
//     "feilds": [
//       {
//         "key": "preferred_age_range",
//         "label": "Age Range",
//         "label_icon": "",
//         "hint": "Select age range",
//         "type": "range_slider",
//         "properties": {
//           "min": 18,
//           "max": 60,
//           "default_min": 18,
//           "default_max": 50,
//         },
//         "is_required": false,
//         "error_text": "Please select age range",
//       },
//       {
//         "key": "preferred_distance",
//         "label": "Distance",
//         "label_icon": "",
//         "hint": "Select max distance",
//         "type": "single_slider",
//         "properties": {"min": 0, "max": 1000, "default": 200, "unit": "km"},
//         "is_required": false,
//         "error_text": "Please select distance",
//       },
//       {
//         "key": "preferred_min_education",
//         "label": "Minimum Education Level",
//         "label_icon": "",
//         "hint": "Select minimum education",
//         "type": "drop_down",
//         "properties": {"input_type": "education"},
//         "is_required": false,
//         "error_text": "",
//       },
//     ],
//   },
// ];

// final List<Map<String, dynamic>> fieldsData = [
//   /// ------------------ BASIC IDENTITY ------------------
//   {
//     "key": "gender",
//     "items": ["Male", "Female"],
//   },
//   {
//     "key": "marriage_priority",
//     "items": ["Within 6 Months", "6–12 Months", "1–2 Years", "2+ Years"],
//   },

//   /// ------------------ VALUES & BELIEFS ------------------
//   {
//     "key": "religion",
//     "items": [
//       "Islam",
//       "Christianity",
//       "Hinduism",
//       "Sikhism",
//       "Buddhism",
//       "Jainism",
//       "Judaism",
//       "Baháʼí",
//       "Zoroastrianism (Parsi)",
//       "Other",
//     ],
//   },
//   {
//     "key": "religious_faith",
//     "items": ["Strict", "Moderate", "Flexible"],
//   },
//   {
//     "key": "languages",
//     "items": [
//       "English",
//       "Hindi",
//       "Urdu",
//       "Arabic",
//       "Punjabi",
//       "Gujarati",
//       "Marathi",
//       "Tamil",
//       "Telugu",
//       "Malayalam",
//       "Kannada",
//       "Bengali",
//       "Other",
//     ],
//   },

//   /// ------------------ FAMILY & BIO ------------------
//   {
//     "key": "marital_status",
//     "items": ["Never Married", "Separated", "Divorced", "Widowed"],
//   },
//   {
//     "key": "has_children",
//     "items": ["Yes", "No"],
//   },
//   {
//     "key": "family_type",
//     "items": ["Nuclear Family", "Joint Family", "Extended Family"],
//   },
//   {
//     "key": "parents_status",
//     "items": [
//       "Living Together",
//       "Separated",
//       "Father Passed Away",
//       "Both Passed Away",
//     ],
//   },

//   /// ------------------ LIFESTYLE & VALUES ------------------
//   {
//     "key": "education_level",
//     "items": [
//       "Secondary School",
//       "High School",
//       "Non-degree Qualification",
//       "Bachelor’s Degree",
//       "Master’s Degree",
//       "Doctorate",
//       "Other Education Level",
//     ],
//   },
//   {
//     "key": "profession",
//     "items": [
//       "IT / Software",
//       "Healthcare",
//       "Education",
//       "Business / Entrepreneur",
//       "Finance",
//       "Government Service",
//       "Legal",
//       "Engineering",
//       "Sales / Marketing",
//       "Design / Creative",
//       "Media & Communication",
//       "Architecture / Construction",
//       "Manufacturing / Industrial",
//       "Hospitality / Travel",
//       "Aviation / Maritime",
//       "Agriculture",
//       "Self-Employed",
//       "Homemaker",
//       "Student",
//       "Retired",
//       "Other",
//     ],
//   },
//   {
//     "key": "habits",
//     "items": [
//       "Eat Halal",
//       "Non Smoker",
//       "Doesn’t Drink",
//       "Prays 5x",
//       "Family First",
//       "Cooks Food",
//       "Career-Driven",
//       "Healthy Lifestyle",
//     ],
//   },

//   /// ------------------ PERSONALITY ------------------
//   {
//     "key": "personality_traits",
//     "items": [
//       "🎒 Adventurous",
//       "🏃 Active & Fit",
//       "🎧 Good Listener",
//       "🧠 Emotionally Intelligent",
//       "😊 Positive Thinker",
//       "💬 Communicative",
//       "🤝 Supportive",
//       "🌍 Open-Minded",
//       "🎯 Goal-Oriented",
//       "🔥 Passionate",
//       "💡 Curious",
//       "🕊️ Calm Under Pressure",
//       "❤️ Caring & Empathetic",
//       "🧩 Problem Solver",
//     ],
//   },

//   /// ------------------ INTERESTS & HOBBIES ------------------
//   {
//     "key": "hobbies",
//     "items": [
//       "🎨 Art & Creativity",
//       "📸 Photography",
//       "🎬 Movies & Cinema",
//       "🎧 Listening to Music",
//       "🎶 Singing",
//       "🎸 Playing Musical Instruments",
//       "🖌️ Painting & Sketching",
//       "✍️ Writing & Blogging",
//       "🏃‍♂️ Fitness & Wellness",
//       "🏋️ Gym & Weight Training",
//       "🧘 Yoga & Meditation",
//       "🚴 Cycling",
//       "🏊 Swimming",
//       "🥗 Healthy Living",
//       "⚽ Sports & Games",
//       "🏏 Cricket",
//       "⚽ Football",
//       "🏀 Basketball",
//       "🏸 Badminton",
//       "🎮 Video Gaming",
//       "♟️ Chess",
//       "🌍 Travel & Lifestyle",
//       "✈️ Traveling",
//       "🏕️ Camping",
//       "🗺️ Exploring New Places",
//       "📖 Reading Books",
//       "☕ Café Hopping",
//       "🍳 Cooking",
//       "🥘 Baking",
//       "🍜 Trying New Cuisines",
//       "☕ Coffee Lover",
//       "🍰 Dessert Making",
//       "💻 Coding & Programming",
//       "📱 App Development",
//       "📊 Stock Market",
//       "🧩 Puzzle Solving",
//       "🎓 Online Learning",
//       "🎉 Socializing",
//       "🗣️ Public Speaking",
//       "💬 Volunteering",
//       "🕯️ Mindfulness",
//       "🌿 Gardening",
//     ],
//   },

//   {
//     "key": "preferred_min_education",
//     "items": [
//       "Any education level",
//       "Secondary School",
//       "High School",
//       "Non-degree Qualification",
//       "Bachelor’s Degree",
//       "Master’s Degree",
//       "Doctorate",
//     ],
//   },
// ];
final List<Map<String, dynamic>> fieldsData = [
  {
    "key": "gender",
    "items": ["MALE", "FEMALE"],
  },

  {
    "key": "marriage_priority",
    "items": [
      "WITHIN_6_MONTHS",
      "SIX_TO_TWELVE_MONTHS",
      "ONE_TO_TWO_YEARS",
      "TWO_PLUS_YEARS",
    ],
  },

  {
    "key": "religion",
    "items": [
      "ISLAM",
      "CHRISTIANITY",
      "HINDUISM",
      "SIKHISM",
      "BUDDHISM",
      "JAINISM",
      "JUDAISM",
      "BAHAI",
      "ZOROASTRIANISM",
      "OTHER",
    ],
  },

  {
    "key": "religious_faith",
    "items": ["STRICT", "MODERATE", "FLEXIBLE"],
  },

  {
    "key": "languages",
    "items": [
      "ENGLISH",
      "HINDI",
      "URDU",
      "ARABIC",
      "PUNJABI",
      "GUJARATI",
      "MARATHI",
      "TAMIL",
      "TELUGU",
      "MALAYALAM",
      "KANNADA",
      "BENGALI",
      "OTHER",
    ],
  },

  {
    "key": "marital_status",
    "items": ["NEVER_MARRIED", "SEPARATED", "DIVORCED", "WIDOWED"],
  },

  {
    "key": "has_children",
    "items": ["YES", "NO"],
  },

  {
    "key": "family_type",
    "items": ["NUCLEAR", "JOINT", "EXTENDED"],
  },

  {
    "key": "parents_status",
    "items": ["LIVING_TOGETHER", "SEPARATED", "FATHER_PASSED", "BOTH_PASSED"],
  },

  {
    "key": "education_level",
    "items": [
      "SECONDARY",
      "HIGH_SCHOOL",
      "NON_DEGREE",
      "BACHELORS",
      "MASTERS",
      "DOCTORATE",
      "OTHER",
    ],
  },

  {
    "key": "profession",
    "items": [
      "IT",
      "HEALTHCARE",
      "EDUCATION",
      "BUSINESS",
      "FINANCE",
      "GOVERNMENT",
      "LEGAL",
      "ENGINEERING",
      "SALES",
      "DESIGN",
      "MEDIA",
      "ARCHITECTURE",
      "MANUFACTURING",
      "HOSPITALITY",
      "AVIATION",
      "AGRICULTURE",
      "SELF_EMPLOYED",
      "HOMEMAKER",
      "STUDENT",
      "RETIRED",
      "OTHER",
    ],
  },

  {
    "key": "habits",
    "items": [
      "EAT_HALAL",
      "NON_SMOKER",
      "NO_DRINKING",
      "PRAYS_5X",
      "FAMILY_FIRST",
      "COOKS_FOOD",
      "CAREER_DRIVEN",
      "HEALTHY_LIFESTYLE",
    ],
  },

  {
    "key": "personality_traits",
    "items": [
      "ADVENTUROUS",
      "ACTIVE_FIT",
      "GOOD_LISTENER",
      "EMOTIONALLY_INTELLIGENT",
      "POSITIVE_THINKER",
      "COMMUNICATIVE",
      "SUPPORTIVE",
      "OPEN_MINDED",
      "GOAL_ORIENTED",
      "PASSIONATE",
      "CURIOUS",
      "CALM",
      "CARING",
      "PROBLEM_SOLVER",
    ],
  },

  {
    "key": "hobbies",
    "items": [
      "ART",
      "PHOTOGRAPHY",
      "MOVIES",
      "MUSIC",
      "SINGING",
      "INSTRUMENTS",
      "PAINTING",
      "WRITING",
      "FITNESS",
      "GYM",
      "YOGA",
      "CYCLING",
      "SWIMMING",
      "HEALTHY_LIVING",
      "SPORTS",
      "CRICKET",
      "FOOTBALL",
      "BASKETBALL",
      "BADMINTON",
      "GAMING",
      "CHESS",
      "TRAVEL",
      "CAMPING",
      "EXPLORING",
      "READING",
      "CAFE",
      "COOKING",
      "BAKING",
      "CUISINES",
      "COFFEE",
      "DESSERTS",
      "CODING",
      "APP_DEV",
      "STOCK_MARKET",
      "PUZZLES",
      "ONLINE_LEARNING",
      "SOCIALIZING",
      "PUBLIC_SPEAKING",
      "VOLUNTEERING",
      "MINDFULNESS",
      "GARDENING",
    ],
  },

  {
    "key": "preferred_min_education",
    "items": [
      "ANY_EDUCATION",
      "SECONDARY",
      "HIGH_SCHOOL",
      "NON_DEGREE",
      "BACHELORS",
      "MASTERS",
      "DOCTORATE",
    ],
  },
];
