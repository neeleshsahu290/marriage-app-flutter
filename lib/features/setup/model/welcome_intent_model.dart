import 'package:swan_match/core/constants/asset_constants.dart';

class WelcomeIntentModel {
  final String title;
  final String description;
  final String icon;
  WelcomeIntentModel({
    required this.title,
    required this.description,
    required this.icon,
  });
}

final List<WelcomeIntentModel> welcomeIntentList = [
  WelcomeIntentModel(
    title: 'Relationship Building',
    description: 'Meaningful relationships with serious intentions',
    icon: AssetConstants.relationshipIcon,
  ),
  WelcomeIntentModel(
    title: 'Privacy Focused',
    description: 'Your data and personal identity are securely protected',
    icon: AssetConstants.privacyIcon,
  ),
  WelcomeIntentModel(
    title: 'Family Oriented',
    description: 'Building strong families based on shared values',
    icon: AssetConstants.familyIcon,
  ),
];
