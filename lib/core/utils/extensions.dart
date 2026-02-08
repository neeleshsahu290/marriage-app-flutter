import 'package:flutter/material.dart';
import 'package:swan_match/l10n/app_localizations.dart';

extension TranslateExtension on BuildContext {
  /// Direct localization access
  AppLocalizations get tr => AppLocalizations.of(this)!;

  /// Translate dynamic key safely (for JSON driven UI)
  String t(String key) {
    final Map<String, String> map = {
      // -------- COMMON --------

      // -------- ONBOARDING PAGES --------
      'basicInfoTitle': tr.basicInfoTitle,
      'basicInfoDesc': tr.basicInfoDesc,

      'valuesTitle': tr.valuesTitle,
      'valuesDesc': tr.valuesDesc,

      'bioFamilyTitle': tr.bioFamilyTitle,
      'bioFamilyDesc': tr.bioFamilyDesc,

      'lifestyleTitle': tr.lifestyleTitle,
      'lifestyleDesc': tr.lifestyleDesc,

      'personalityTitle': tr.personalityTitle,
      'personalityDesc': tr.personalityDesc,

      'hobbiesTitle': tr.hobbiesTitle,
      'hobbiesDesc': tr.hobbiesDesc,

      'photosTitle': tr.photosTitle,
      'photosDesc': tr.photosDesc,

      'preferencesTitle': tr.preferencesTitle,
      'preferencesDesc': tr.preferencesDesc,

      // -------- FIELDS --------
      'fullNameLabel': tr.fullNameLabel,
      'fullNameHint': tr.fullNameHint,
      'fullNameError': tr.fullNameError,

      'dobLabel': tr.dobLabel,
      'dobHint': tr.dobHint,
      'dobError': tr.dobError,

      'genderLabel': tr.genderLabel,
      'genderHint': tr.genderHint,
      'genderError': tr.genderError,

      'heightLabel': tr.heightLabel,
      'heightHint': tr.heightHint,
      'heightError': tr.heightError,

      'religionLabel': tr.religionLabel,
      'religionHint': tr.religionHint,
      'religionError': tr.religionError,

      'faithLabel': tr.faithLabel,

      'languagesLabel': tr.languagesLabel,
      'languagesError': tr.languagesError,

      'bioLabel': tr.bioLabel,
      'bioHint': tr.bioHint,
      'bioError': tr.bioError,

      'maritalStatusLabel': tr.maritalStatusLabel,
      'maritalStatusError': tr.maritalStatusError,

      'childrenLabel': tr.childrenLabel,
      'childrenError': tr.childrenError,

      'familyTypeLabel': tr.familyTypeLabel,
      'familyTypeError': tr.familyTypeError,

      'educationLabel': tr.educationLabel,
      'educationError': tr.educationError,

      'professionLabel': tr.professionLabel,
      'professionError': tr.professionError,

      'habitsLabel': tr.habitsLabel,

      'personalityLabel': tr.personalityLabel,
      'personalityHint': tr.personalityHint,
      'personalityError': tr.personalityError,

      'hobbiesLabel': tr.hobbiesLabel,
      'hobbiesHint': tr.hobbiesHint,

      'photosLabel': tr.photosLabel,
      'photosHint': tr.photosHint,
      'photosError': tr.photosError,

      'ageRangeLabel': tr.ageRangeLabel,
      'ageRangeHint': tr.ageRangeHint,
      'ageRangeError': tr.ageRangeError,

      'distanceLabel': tr.distanceLabel,
      'distanceHint': tr.distanceHint,
      'distanceError': tr.distanceError,

      'selectHint': tr.selectHint,
      'preferredDistanceLabel': tr.preferredDistanceLabel,
      'preferredDistanceHint': tr.preferredDistanceHint,
      'preferredDistanceError': tr.preferredDistanceError,

      'preferredMinEducationLabel': tr.preferredMinEducationLabel,
      'preferredMinEducationHint': tr.preferredMinEducationHint,
      'preferredMinEducationError': tr.preferredMinEducationError,

      'parentsStatusLabel': tr.parentsStatusLabel,
      'parentsStatusError': tr.parentsStatusError,

      // -------- GENDER --------
      'MALE': tr.male,
      'FEMALE': tr.female,

      // -------- MARRIAGE PRIORITY --------
      'WITHIN_6_MONTHS': tr.within6Months,
      'SIX_TO_TWELVE_MONTHS': tr.sixToTwelveMonths,
      'ONE_TO_TWO_YEARS': tr.oneToTwoYears,
      'TWO_PLUS_YEARS': tr.twoPlusYears,

      // -------- RELIGION --------
      'ISLAM': tr.islam,
      'CHRISTIANITY': tr.christianity,
      'HINDUISM': tr.hinduism,
      'SIKHISM': tr.sikhism,
      'BUDDHISM': tr.buddhism,
      'JAINISM': tr.jainism,
      'JUDAISM': tr.judaism,
      'BAHAI': tr.bahai,
      'ZOROASTRIANISM': tr.zoroastrianism,
      'OTHER': tr.other,

      // -------- FAITH --------
      'STRICT': tr.strict,
      'MODERATE': tr.moderate,
      'FLEXIBLE': tr.flexible,

      // -------- LANGUAGES --------
      'ENGLISH': tr.english,
      'HINDI': tr.hindi,
      'URDU': tr.urdu,
      'ARABIC': tr.arabic,
      'PUNJABI': tr.punjabi,
      'GUJARATI': tr.gujarati,
      'MARATHI': tr.marathi,
      'TAMIL': tr.tamil,
      'TELUGU': tr.telugu,
      'MALAYALAM': tr.malayalam,
      'KANNADA': tr.kannada,
      'BENGALI': tr.bengali,

      // -------- MARITAL STATUS --------
      'NEVER_MARRIED': tr.neverMarried,
      'SEPARATED': tr.separated,
      'DIVORCED': tr.divorced,
      'WIDOWED': tr.widowed,

      // -------- CHILDREN --------
      'YES': tr.yes,
      'NO': tr.no,

      // -------- FAMILY TYPE --------
      'NUCLEAR': tr.nuclear,
      'JOINT': tr.joint,
      'EXTENDED': tr.extended,

      // -------- PARENTS STATUS --------
      'LIVING_TOGETHER': tr.livingTogether,
      'FATHER_PASSED': tr.fatherPassed,
      'BOTH_PASSED': tr.bothPassed,

      // -------- EDUCATION --------
      'SECONDARY': tr.secondary,
      'HIGH_SCHOOL': tr.highSchool,
      'NON_DEGREE': tr.nonDegree,
      'BACHELORS': tr.bachelors,
      'MASTERS': tr.masters,
      'DOCTORATE': tr.doctorate,

      // -------- PROFESSION --------
      'IT': tr.it,
      'HEALTHCARE': tr.healthcare,
      'EDUCATION': tr.education,
      'BUSINESS': tr.business,
      'FINANCE': tr.finance,
      'GOVERNMENT': tr.government,
      'LEGAL': tr.legal,
      'ENGINEERING': tr.engineering,
      'SALES': tr.sales,
      'DESIGN': tr.design,
      'MEDIA': tr.media,
      'ARCHITECTURE': tr.architecture,
      'MANUFACTURING': tr.manufacturing,
      'HOSPITALITY': tr.hospitality,
      'AVIATION': tr.aviation,
      'AGRICULTURE': tr.agriculture,
      'SELF_EMPLOYED': tr.selfEmployed,
      'HOMEMAKER': tr.homemaker,
      'STUDENT': tr.student,
      'RETIRED': tr.retired,

      // -------- HABITS --------
      'EAT_HALAL': tr.eatHalal,
      'NON_SMOKER': tr.nonSmoker,
      'NO_DRINKING': tr.noDrinking,
      'PRAYS_5X': tr.praysFiveTimes,
      'FAMILY_FIRST': tr.familyFirst,
      'COOKS_FOOD': tr.cooksFood,
      'CAREER_DRIVEN': tr.careerDriven,
      'HEALTHY_LIFESTYLE': tr.healthyLifestyle,

      // -------- PERSONALITY --------
      'ADVENTUROUS': tr.adventurous,
      'ACTIVE_FIT': tr.activeFit,
      'GOOD_LISTENER': tr.goodListener,
      'EMOTIONALLY_INTELLIGENT': tr.emotionallyIntelligent,
      'POSITIVE_THINKER': tr.positiveThinker,
      'COMMUNICATIVE': tr.communicative,
      'SUPPORTIVE': tr.supportive,
      'OPEN_MINDED': tr.openMinded,
      'GOAL_ORIENTED': tr.goalOriented,
      'PASSIONATE': tr.passionate,
      'CURIOUS': tr.curious,
      'CALM': tr.calm,
      'CARING': tr.caring,
      'PROBLEM_SOLVER': tr.problemSolver,

      // -------- HOBBIES --------
      'ART': tr.art,
      'PHOTOGRAPHY': tr.photography,
      'MOVIES': tr.movies,
      'MUSIC': tr.music,
      'SINGING': tr.singing,
      'INSTRUMENTS': tr.instruments,
      'PAINTING': tr.painting,
      'WRITING': tr.writing,
      'FITNESS': tr.fitness,
      'GYM': tr.gym,
      'YOGA': tr.yoga,
      'CYCLING': tr.cycling,
      'SWIMMING': tr.swimming,
      'HEALTHY_LIVING': tr.healthyLiving,
      'SPORTS': tr.sports,
      'CRICKET': tr.cricket,
      'FOOTBALL': tr.football,
      'BASKETBALL': tr.basketball,
      'BADMINTON': tr.badminton,
      'GAMING': tr.gaming,
      'CHESS': tr.chess,
      'TRAVEL': tr.travel,
      'CAMPING': tr.camping,
      'EXPLORING': tr.exploring,
      'READING': tr.reading,
      'CAFE': tr.cafe,
      'COOKING': tr.cooking,
      'BAKING': tr.baking,
      'CUISINES': tr.cuisines,
      'COFFEE': tr.coffee,
      'DESSERTS': tr.desserts,
      'CODING': tr.coding,
      'APP_DEV': tr.appDev,
      'STOCK_MARKET': tr.stockMarket,
      'PUZZLES': tr.puzzles,
      'ONLINE_LEARNING': tr.onlineLearning,
      'SOCIALIZING': tr.socializing,
      'PUBLIC_SPEAKING': tr.publicSpeaking,
      'VOLUNTEERING': tr.volunteering,
      'MINDFULNESS': tr.mindfulness,
      'GARDENING': tr.gardening,

      // -------- FILTER --------
      'ANY_EDUCATION': tr.anyEducation,
    };

    return map[key] ?? key; // fallback to key if missing
  }
}
