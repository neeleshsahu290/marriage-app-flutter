import 'package:flutter/material.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/utils/extensions.dart';

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

List<WelcomeIntentModel> getWelcomeIntentList(BuildContext context) {
  return [
    WelcomeIntentModel(
      title: context.tr.welcomeValueRelationshipTitle,
      description: context.tr.welcomeValueRelationshipDesc,
      icon: AssetConstants.relationshipIcon,
    ),
    WelcomeIntentModel(
      title: context.tr.welcomeValuePrivacyTitle,
      description: context.tr.welcomeValuePrivacyDesc,
      icon: AssetConstants.privacyIcon,
    ),
    WelcomeIntentModel(
      title: context.tr.welcomeValueFamilyTitle,
      description: context.tr.welcomeValueFamilyDesc,
      icon: AssetConstants.familyIcon,
    ),
  ];
}
