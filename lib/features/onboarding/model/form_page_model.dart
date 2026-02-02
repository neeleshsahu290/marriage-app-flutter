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
  /// ------------------ BASIC INFORMATION ------------------
  {
    "page_tile": "Basic Information",
    "page_desc": "Tell us about yourself",
    "feilds": [
      {
        "key": "full_name",
        "label": "Full Name",
        "label_icon": "",
        "hint": "Enter your name",
        "type": "text_field",
        "properties": {"input_type": "text"},
        "is_required": true,
        "error_text": "Name is required",
      },
      {
        "key": "dob",
        "label": "Date of Birth",
        "label_icon": "",
        "hint": "Select Date",
        "type": "text_field",
        "properties": {"input_type": "date"},
        "is_required": true,
        "error_text": "Date of birth is required",
      },
      {
        "key": "gender",
        "label": "Gender",
        "label_icon": "",
        "hint": "Select Gender",
        "type": "drop_down",
        "properties": {"input_type": "gender"},
        "is_required": true,
        "error_text": "Gender is required",
      },
      {
        "key": "height_cm",
        "label": "Height",
        "label_icon": "",
        "hint": "Select Height",
        "type": "drop_down",
        "properties": {"input_type": "height"},
        "is_required": true,
        "error_text": "Height is required",
      },
      // {
      //   "key": "location",
      //   "label": "Location",
      //   "label_icon": "",
      //   "hint": "Select City",
      //   "type": "drop_down",
      //   "properties": {"input_type": "city"},
      //   "is_required": true,
      //   "error_text": "Location is required",
      // },
    ],
  },

  /// ------------------ VALUES & BELIEFS ------------------
  {
    "page_tile": "Values & Beliefs",
    "page_desc": "Share your religious background",
    "feilds": [
      {
        "key": "religion",
        "label": "Religion",
        "label_icon": "",
        "hint": "Select your religion",
        "type": "drop_down",
        "properties": {"input_type": "religion"},
        "is_required": true,
        "error_text": "Religion is required",
      },
      // {
      //   "key": "community",
      //   "label": "Community",
      //   "label_icon": "",
      //   "hint": "Select community",
      //   "type": "drop_down",
      //   "properties": {"input_type": "community"},
      //   "is_required": false,
      //   "error_text": "",
      // },
      {
        "key": "religious_faith",
        "label": "Religious Faith",
        "label_icon": "",
        "hint": "Select",
        "type": "drop_down",
        "properties": {"input_type": "faith"},
        "is_required": false,
        "error_text": "",
      },
      {
        "key": "languages_known",
        "label": "Languages Known",
        "label_icon": "",
        "hint": "Select",
        "type": "multi_drop_down",
        "properties": {"max": 5},
        "is_required": true,
        "error_text": "Select at least one language",
      },
    ],
  },

  /// ------------------ BIO & FAMILY ------------------
  {
    "page_tile": "Bio & Family",
    "page_desc": "Tell us about your family",
    "feilds": [
      {
        "key": "bio",
        "label": "Bio",
        "label_icon": "",
        "hint": "Tell us about yourself",
        "type": "text_area",
        "properties": {"max_length": 300},
        "is_required": true,
        "error_text": "Bio is required",
      },
      {
        "key": "marital_status",
        "label": "Marital Status",
        "label_icon": "",
        "hint": "Select",
        "type": "drop_down",
        "properties": {"input_type": "marital_status"},
        "is_required": true,
        "error_text": "Marital status is required",
      },
      {
        "key": "has_children",
        "label": "Do you have children?",
        "label_icon": "",
        "hint": "Select",
        "type": "drop_down",
        "properties": {"input_type": "yes_no"},
        "is_required": true,
        "error_text": "Please select an option",
      },
      {
        "key": "family_type",
        "label": "Family Type",
        "label_icon": "",
        "hint": "Select",
        "type": "drop_down",
        "properties": {"input_type": "family_type"},
        "is_required": true,
        "error_text": "Family type is required",
      },
      {
        "key": "parents_status",
        "label": "Parents Status",
        "label_icon": "",
        "hint": "Select",
        "type": "drop_down",
        "properties": {"input_type": "parents_status"},
        "is_required": false,
        "error_text": "",
      },
    ],
  },

  /// ------------------ LIFESTYLE ------------------
  {
    "page_tile": "Lifestyle",
    "page_desc": "Profession and education",
    "feilds": [
      {
        "key": "education_level",
        "label": "Education Level",
        "label_icon": "",
        "hint": "Select",
        "type": "drop_down",
        "properties": {"input_type": "education"},
        "is_required": true,
        "error_text": "Education is required",
      },
      {
        "key": "profession",
        "label": "Profession",
        "label_icon": "",
        "hint": "Select",
        "type": "drop_down",
        "properties": {"input_type": "profession"},
        "is_required": true,
        "error_text": "Profession is required",
      },
      {
        "key": "habits",
        "label": "Habits",
        "label_icon": "",
        "hint": "Select your habits",
        "type": "multi_select",
        "is_required": false,
        "error_text": "",
      },
    ],
  },

  /// ------------------ PERSONALITY ------------------
  {
    "page_tile": "Personality",
    "page_desc": "Select up to 5 traits to show off your personality",
    "feilds": [
      {
        "key": "personality_traits",
        "label": "Personality Traits",
        "label_icon": "",
        "hint": "Select up to 5",
        "type": "multi_select",
        "properties": {"max": 5},
        "is_required": true,
        "error_text": "Select at least one trait",
      },
    ],
  },

  /// ------------------ HOBBIES ------------------
  {
    "page_tile": "Hobbies",
    "page_desc": "Select up to 15 interests to make your profile stand out",
    "feilds": [
      {
        "key": "hobbies",
        "label": "Hobbies & Interests",
        "label_icon": "",
        "hint": "Select up to 15",
        "type": "multi_select",
        "properties": {"max": 15},
        "is_required": false,
        "error_text": "",
      },
    ],
  },

  /// ------------------ PROFILE PHOTOS ------------------
  {
    "page_tile": "Profile Photos",
    "page_desc": "You need to upload at least 3 photos",
    "feilds": [
      {
        "key": "profile_photos",
        "label": "Upload Photos",
        "label_icon": "",
        "hint": "photos are required",
        "type": "image_picker",
        "properties": {"min": 3, "max": 6},
        "is_required": true,
        "error_text": "Minimum 3 photos required",
      },
    ],
  },
];

final List<Map<String, dynamic>> fieldsData = [
  /// ------------------ BASIC IDENTITY ------------------
  {
    "key": "gender",
    "items": ["Male", "Female"],
  },
  {
    "key": "marriage_priority",
    "items": ["Within 6 Months", "6–12 Months", "1–2 Years", "2+ Years"],
  },

  /// ------------------ VALUES & BELIEFS ------------------
  {
    "key": "religion",
    "items": [
      "Islam",
      "Christianity",
      "Hinduism",
      "Sikhism",
      "Buddhism",
      "Jainism",
      "Judaism",
      "Baháʼí",
      "Zoroastrianism (Parsi)",
      "Other",
    ],
  },
  {
    "key": "religious_faith",
    "items": ["Strict", "Moderate", "Flexible"],
  },
  {
    "key": "languages",
    "items": [
      "English",
      "Hindi",
      "Urdu",
      "Arabic",
      "Punjabi",
      "Gujarati",
      "Marathi",
      "Tamil",
      "Telugu",
      "Malayalam",
      "Kannada",
      "Bengali",
      "Other",
    ],
  },

  /// ------------------ FAMILY & BIO ------------------
  {
    "key": "marital_status",
    "items": ["Never Married", "Separated", "Divorced", "Widowed"],
  },
  {
    "key": "has_children",
    "items": ["Yes", "No"],
  },
  {
    "key": "family_type",
    "items": ["Nuclear Family", "Joint Family", "Extended Family"],
  },
  {
    "key": "parents_status",
    "items": [
      "Living Together",
      "Separated",
      "Father Passed Away",
      "Both Passed Away",
    ],
  },

  /// ------------------ LIFESTYLE & VALUES ------------------
  {
    "key": "education_level",
    "items": [
      "Secondary School",
      "High School",
      "Non-degree Qualification",
      "Bachelor’s Degree",
      "Master’s Degree",
      "Doctorate",
      "Other Education Level",
    ],
  },
  {
    "key": "profession",
    "items": [
      "IT / Software",
      "Healthcare",
      "Education",
      "Business / Entrepreneur",
      "Finance",
      "Government Service",
      "Legal",
      "Engineering",
      "Sales / Marketing",
      "Design / Creative",
      "Media & Communication",
      "Architecture / Construction",
      "Manufacturing / Industrial",
      "Hospitality / Travel",
      "Aviation / Maritime",
      "Agriculture",
      "Self-Employed",
      "Homemaker",
      "Student",
      "Retired",
      "Other",
    ],
  },
  {
    "key": "habits",
    "items": [
      "Eat Halal",
      "Non Smoker",
      "Doesn’t Drink",
      "Prays 5x",
      "Family First",
      "Cooks Food",
      "Career-Driven",
      "Healthy Lifestyle",
    ],
  },

  /// ------------------ PERSONALITY ------------------
  {
    "key": "personality_traits",
    "items": [
      "🎒 Adventurous",
      "🏃 Active & Fit",
      "🎧 Good Listener",
      "🧠 Emotionally Intelligent",
      "😊 Positive Thinker",
      "💬 Communicative",
      "🤝 Supportive",
      "🌍 Open-Minded",
      "🎯 Goal-Oriented",
      "🔥 Passionate",
      "💡 Curious",
      "🕊️ Calm Under Pressure",
      "❤️ Caring & Empathetic",
      "🧩 Problem Solver",
    ],
  },

  /// ------------------ INTERESTS & HOBBIES ------------------
  {
    "key": "hobbies",
    "items": [
      "🎨 Art & Creativity",
      "📸 Photography",
      "🎬 Movies & Cinema",
      "🎧 Listening to Music",
      "🎶 Singing",
      "🎸 Playing Musical Instruments",
      "🖌️ Painting & Sketching",
      "✍️ Writing & Blogging",
      "🏃‍♂️ Fitness & Wellness",
      "🏋️ Gym & Weight Training",
      "🧘 Yoga & Meditation",
      "🚴 Cycling",
      "🏊 Swimming",
      "🥗 Healthy Living",
      "⚽ Sports & Games",
      "🏏 Cricket",
      "⚽ Football",
      "🏀 Basketball",
      "🏸 Badminton",
      "🎮 Video Gaming",
      "♟️ Chess",
      "🌍 Travel & Lifestyle",
      "✈️ Traveling",
      "🏕️ Camping",
      "🗺️ Exploring New Places",
      "📖 Reading Books",
      "☕ Café Hopping",
      "🍳 Cooking",
      "🥘 Baking",
      "🍜 Trying New Cuisines",
      "☕ Coffee Lover",
      "🍰 Dessert Making",
      "💻 Coding & Programming",
      "📱 App Development",
      "📊 Stock Market",
      "🧩 Puzzle Solving",
      "🎓 Online Learning",
      "🎉 Socializing",
      "🗣️ Public Speaking",
      "💬 Volunteering",
      "🕯️ Mindfulness",
      "🌿 Gardening",
    ],
  },
];
