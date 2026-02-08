import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Swan Match'**
  String get appName;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Find your Life Partner with dignity'**
  String get splashTagline;

  /// No description provided for @selectLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguageTitle;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone'**
  String get emailOrPhone;

  /// No description provided for @enterEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter email or phone number'**
  String get enterEmailOrPhone;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @errorEmailPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Email or phone is required'**
  String get errorEmailPhoneRequired;

  /// No description provided for @errorPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get errorPasswordRequired;

  /// No description provided for @errorPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get errorPasswordLength;

  /// No description provided for @errorConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm password is required'**
  String get errorConfirmPasswordRequired;

  /// No description provided for @errorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errorPasswordMismatch;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signInLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInLink;

  /// No description provided for @phoneVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Phone Verification'**
  String get phoneVerificationTitle;

  /// No description provided for @phoneVerificationDesc.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a code to verify your number'**
  String get phoneVerificationDesc;

  /// No description provided for @emailVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerificationTitle;

  /// No description provided for @emailVerificationDesc.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a code to verify your email'**
  String get emailVerificationDesc;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get enterEmail;

  /// No description provided for @errorEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get errorEmailRequired;

  /// No description provided for @errorEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get errorEmailInvalid;

  /// No description provided for @countryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get countryLabel;

  /// No description provided for @searchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search country'**
  String get searchCountry;

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get selectCountry;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @errorPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get errorPhoneRequired;

  /// No description provided for @errorPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid mobile number'**
  String get errorPhoneInvalid;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// No description provided for @verificationCodeDesc.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a code to verify your number'**
  String get verificationCodeDesc;

  /// No description provided for @emailOtpDesc.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a code to verify your Email'**
  String get emailOtpDesc;

  /// No description provided for @errorPinRequired.
  ///
  /// In en, this message translates to:
  /// **'PIN is required'**
  String get errorPinRequired;

  /// No description provided for @errorPinInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 6-digit PIN'**
  String get errorPinInvalid;

  /// No description provided for @createPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Your Password'**
  String get createPasswordTitle;

  /// No description provided for @createPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Pick a strong password you’ll remember.'**
  String get createPasswordDesc;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome & Values'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Our core values'**
  String get welcomeSubtitle;

  /// No description provided for @welcomeValueRelationshipTitle.
  ///
  /// In en, this message translates to:
  /// **'Relationship Building'**
  String get welcomeValueRelationshipTitle;

  /// No description provided for @welcomeValueRelationshipDesc.
  ///
  /// In en, this message translates to:
  /// **'Meaningful relationships with serious intentions'**
  String get welcomeValueRelationshipDesc;

  /// No description provided for @welcomeValuePrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Focused'**
  String get welcomeValuePrivacyTitle;

  /// No description provided for @welcomeValuePrivacyDesc.
  ///
  /// In en, this message translates to:
  /// **'Your data and personal identity are securely protected'**
  String get welcomeValuePrivacyDesc;

  /// No description provided for @welcomeValueFamilyTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Oriented'**
  String get welcomeValueFamilyTitle;

  /// No description provided for @welcomeValueFamilyDesc.
  ///
  /// In en, this message translates to:
  /// **'Building strong families based on shared values'**
  String get welcomeValueFamilyDesc;

  /// No description provided for @intentTitle.
  ///
  /// In en, this message translates to:
  /// **'Serious Intent Required'**
  String get intentTitle;

  /// No description provided for @intentDesc.
  ///
  /// In en, this message translates to:
  /// **'This platform is for meaningful, long-term relationships only.'**
  String get intentDesc;

  /// No description provided for @intentQuestionSerious.
  ///
  /// In en, this message translates to:
  /// **'Looking for something serious?'**
  String get intentQuestionSerious;

  /// No description provided for @intentQuestionSettle.
  ///
  /// In en, this message translates to:
  /// **'When are you looking to settle down?'**
  String get intentQuestionSettle;

  /// No description provided for @intentSeriousBox.
  ///
  /// In en, this message translates to:
  /// **'Yes, I am serious about relationship'**
  String get intentSeriousBox;

  /// No description provided for @communityGuidelinesTitle.
  ///
  /// In en, this message translates to:
  /// **'Community Guidelines'**
  String get communityGuidelinesTitle;

  /// No description provided for @intentAcceptText.
  ///
  /// In en, this message translates to:
  /// **'I accept the community guidelines and agree to use this platform for marriage purpose only'**
  String get intentAcceptText;

  /// No description provided for @ruleRespect.
  ///
  /// In en, this message translates to:
  /// **'Respectful communication only'**
  String get ruleRespect;

  /// No description provided for @ruleNoContent.
  ///
  /// In en, this message translates to:
  /// **'No inappropriate content'**
  String get ruleNoContent;

  /// No description provided for @ruleHonest.
  ///
  /// In en, this message translates to:
  /// **'Honest and accurate profiles'**
  String get ruleHonest;

  /// No description provided for @ruleReport.
  ///
  /// In en, this message translates to:
  /// **'Report suspicious behavior'**
  String get ruleReport;

  /// No description provided for @submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submitting;

  /// No description provided for @errorFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all the fields'**
  String get errorFillAllFields;

  /// No description provided for @noProfileFound.
  ///
  /// In en, this message translates to:
  /// **'No profile data found'**
  String get noProfileFound;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutMe;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @myHabits.
  ///
  /// In en, this message translates to:
  /// **'My Habits'**
  String get myHabits;

  /// No description provided for @editProfileDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile Details'**
  String get editProfileDetails;

  /// No description provided for @labelPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get labelPhone;

  /// No description provided for @labelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelEmail;

  /// No description provided for @labelGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get labelGender;

  /// No description provided for @labelDob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get labelDob;

  /// No description provided for @labelHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get labelHeight;

  /// No description provided for @labelReligion.
  ///
  /// In en, this message translates to:
  /// **'Religion'**
  String get labelReligion;

  /// No description provided for @labelFaithLevel.
  ///
  /// In en, this message translates to:
  /// **'Faith Level'**
  String get labelFaithLevel;

  /// No description provided for @labelMaritalStatus.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get labelMaritalStatus;

  /// No description provided for @labelHasChildren.
  ///
  /// In en, this message translates to:
  /// **'Has Children'**
  String get labelHasChildren;

  /// No description provided for @labelFamilyType.
  ///
  /// In en, this message translates to:
  /// **'Family Type'**
  String get labelFamilyType;

  /// No description provided for @labelParentsStatus.
  ///
  /// In en, this message translates to:
  /// **'Parents Status'**
  String get labelParentsStatus;

  /// No description provided for @labelEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get labelEducation;

  /// No description provided for @labelProfession.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get labelProfession;

  /// No description provided for @labelLanguages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get labelLanguages;

  /// No description provided for @labelPersonality.
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get labelPersonality;

  /// No description provided for @labelHobbies.
  ///
  /// In en, this message translates to:
  /// **'Hobbies'**
  String get labelHobbies;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @editPrivacyVisibility.
  ///
  /// In en, this message translates to:
  /// **'Edit Privacy & Visibility'**
  String get editPrivacyVisibility;

  /// No description provided for @matchPreferences.
  ///
  /// In en, this message translates to:
  /// **'Match Preferences'**
  String get matchPreferences;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @privacySummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Visibility Summary'**
  String get privacySummaryTitle;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountTitle;

  /// No description provided for @summaryOnlineStatus.
  ///
  /// In en, this message translates to:
  /// **'Online Status'**
  String get summaryOnlineStatus;

  /// No description provided for @summaryEmailVisibility.
  ///
  /// In en, this message translates to:
  /// **'Email Visibility'**
  String get summaryEmailVisibility;

  /// No description provided for @summaryMobileVisibility.
  ///
  /// In en, this message translates to:
  /// **'Mobile Visibility'**
  String get summaryMobileVisibility;

  /// No description provided for @summaryPhotoVisibility.
  ///
  /// In en, this message translates to:
  /// **'Photo Visibility'**
  String get summaryPhotoVisibility;

  /// No description provided for @statusVisible.
  ///
  /// In en, this message translates to:
  /// **'Visible'**
  String get statusVisible;

  /// No description provided for @statusHidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get statusHidden;

  /// No description provided for @statusHiddenAfterMatch.
  ///
  /// In en, this message translates to:
  /// **'Hidden (Only after match)'**
  String get statusHiddenAfterMatch;

  /// No description provided for @editSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Settings'**
  String get editSettingsTitle;

  /// No description provided for @photosSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos Settings'**
  String get photosSettingsTitle;

  /// No description provided for @privacySafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Safety'**
  String get privacySafetyTitle;

  /// No description provided for @photoVisibilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Photo Visibility'**
  String get photoVisibilityLabel;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @photoHiddenAfterMatch.
  ///
  /// In en, this message translates to:
  /// **'Hidden (Only after match)'**
  String get photoHiddenAfterMatch;

  /// No description provided for @photoBlurredPreview.
  ///
  /// In en, this message translates to:
  /// **'Blurred Preview'**
  String get photoBlurredPreview;

  /// No description provided for @photoVisibleToMatches.
  ///
  /// In en, this message translates to:
  /// **'Visible to Matches'**
  String get photoVisibleToMatches;

  /// No description provided for @showOnlineStatus.
  ///
  /// In en, this message translates to:
  /// **'Show Online Status'**
  String get showOnlineStatus;

  /// No description provided for @showOnlineDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow others to see when you\'re online'**
  String get showOnlineDesc;

  /// No description provided for @emailVisibilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Visibility'**
  String get emailVisibilityTitle;

  /// No description provided for @emailVisibilityDesc.
  ///
  /// In en, this message translates to:
  /// **'Let matches see your email'**
  String get emailVisibilityDesc;

  /// No description provided for @mobileVisibilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Mobile No. Visibility'**
  String get mobileVisibilityTitle;

  /// No description provided for @mobileVisibilityDesc.
  ///
  /// In en, this message translates to:
  /// **'Let matches see your mobile number'**
  String get mobileVisibilityDesc;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @settingsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Settings updated successfully'**
  String get settingsUpdated;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @homeTabToday.
  ///
  /// In en, this message translates to:
  /// **'Today’s'**
  String get homeTabToday;

  /// No description provided for @homeTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get homeTabAll;

  /// No description provided for @noProfilesFound.
  ///
  /// In en, this message translates to:
  /// **'No profiles found'**
  String get noProfilesFound;

  /// No description provided for @noProfilesFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'No Profiles Found'**
  String get noProfilesFoundTitle;

  /// No description provided for @findingBetterMatches.
  ///
  /// In en, this message translates to:
  /// **'We’re finding better matches for you'**
  String get findingBetterMatches;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get navExplore;

  /// No description provided for @navChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get navChat;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @matchesReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get matchesReceived;

  /// No description provided for @matchesAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get matchesAccepted;

  /// No description provided for @matchesSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get matchesSent;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get genericError;

  /// No description provided for @emptyReceivedTitle.
  ///
  /// In en, this message translates to:
  /// **'No Requests Yet'**
  String get emptyReceivedTitle;

  /// No description provided for @emptyReceivedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'When someone sends you a request, it will appear here'**
  String get emptyReceivedSubtitle;

  /// No description provided for @emptyAcceptedTitle.
  ///
  /// In en, this message translates to:
  /// **'No Matches Yet'**
  String get emptyAcceptedTitle;

  /// No description provided for @emptyAcceptedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start connecting with people you like'**
  String get emptyAcceptedSubtitle;

  /// No description provided for @emptySentTitle.
  ///
  /// In en, this message translates to:
  /// **'No Sent Requests'**
  String get emptySentTitle;

  /// No description provided for @emptySentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send a request to start a conversation'**
  String get emptySentSubtitle;

  /// No description provided for @whyThisMatch.
  ///
  /// In en, this message translates to:
  /// **'Why this match?'**
  String get whyThisMatch;

  /// No description provided for @pass.
  ///
  /// In en, this message translates to:
  /// **'Pass'**
  String get pass;

  /// No description provided for @interested.
  ///
  /// In en, this message translates to:
  /// **'Interested'**
  String get interested;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @acceptAndChat.
  ///
  /// In en, this message translates to:
  /// **'Accept and Chat Now'**
  String get acceptAndChat;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @chatNow.
  ///
  /// In en, this message translates to:
  /// **'Chat Now'**
  String get chatNow;

  /// No description provided for @revokeRequest.
  ///
  /// In en, this message translates to:
  /// **'Revoke request from sent'**
  String get revokeRequest;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @selectHeight.
  ///
  /// In en, this message translates to:
  /// **'Select height'**
  String get selectHeight;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @searchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Search language'**
  String get searchLanguage;

  /// No description provided for @selectLanguages.
  ///
  /// In en, this message translates to:
  /// **'Select languages'**
  String get selectLanguages;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @emailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email verified successfully'**
  String get emailVerified;

  /// No description provided for @phoneVerified.
  ///
  /// In en, this message translates to:
  /// **'Phone verified successfully'**
  String get phoneVerified;

  /// No description provided for @profileCreatedReady.
  ///
  /// In en, this message translates to:
  /// **'Profile created. You’re all set!'**
  String get profileCreatedReady;

  /// No description provided for @habitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get habitsTitle;

  /// No description provided for @highlightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get highlightsTitle;

  /// No description provided for @him.
  ///
  /// In en, this message translates to:
  /// **'him'**
  String get him;

  /// No description provided for @her.
  ///
  /// In en, this message translates to:
  /// **'her'**
  String get her;

  /// No description provided for @youAndPartner.
  ///
  /// In en, this message translates to:
  /// **'You and {partner}'**
  String youAndPartner(Object partner);

  /// No description provided for @basicInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInfoTitle;

  /// No description provided for @basicInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get basicInfoDesc;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get fullNameHint;

  /// No description provided for @fullNameError.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get fullNameError;

  /// No description provided for @dobLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dobLabel;

  /// No description provided for @dobHint.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get dobHint;

  /// No description provided for @dobError.
  ///
  /// In en, this message translates to:
  /// **'Date of birth is required'**
  String get dobError;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

  /// No description provided for @genderHint.
  ///
  /// In en, this message translates to:
  /// **'Select gender'**
  String get genderHint;

  /// No description provided for @genderError.
  ///
  /// In en, this message translates to:
  /// **'Gender is required'**
  String get genderError;

  /// No description provided for @heightLabel.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get heightLabel;

  /// No description provided for @heightHint.
  ///
  /// In en, this message translates to:
  /// **'Select height'**
  String get heightHint;

  /// No description provided for @heightError.
  ///
  /// In en, this message translates to:
  /// **'Height is required'**
  String get heightError;

  /// No description provided for @valuesTitle.
  ///
  /// In en, this message translates to:
  /// **'Values & Beliefs'**
  String get valuesTitle;

  /// No description provided for @valuesDesc.
  ///
  /// In en, this message translates to:
  /// **'Share your religious background'**
  String get valuesDesc;

  /// No description provided for @religionLabel.
  ///
  /// In en, this message translates to:
  /// **'Religion'**
  String get religionLabel;

  /// No description provided for @religionHint.
  ///
  /// In en, this message translates to:
  /// **'Select your religion'**
  String get religionHint;

  /// No description provided for @religionError.
  ///
  /// In en, this message translates to:
  /// **'Religion is required'**
  String get religionError;

  /// No description provided for @faithLabel.
  ///
  /// In en, this message translates to:
  /// **'Religious Faith'**
  String get faithLabel;

  /// No description provided for @languagesLabel.
  ///
  /// In en, this message translates to:
  /// **'Languages Known'**
  String get languagesLabel;

  /// No description provided for @languagesError.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one language'**
  String get languagesError;

  /// No description provided for @bioFamilyTitle.
  ///
  /// In en, this message translates to:
  /// **'Bio & Family'**
  String get bioFamilyTitle;

  /// No description provided for @bioFamilyDesc.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your family'**
  String get bioFamilyDesc;

  /// No description provided for @bioLabel.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bioLabel;

  /// No description provided for @bioHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get bioHint;

  /// No description provided for @bioError.
  ///
  /// In en, this message translates to:
  /// **'Bio is required'**
  String get bioError;

  /// No description provided for @maritalStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get maritalStatusLabel;

  /// No description provided for @maritalStatusError.
  ///
  /// In en, this message translates to:
  /// **'Marital status is required'**
  String get maritalStatusError;

  /// No description provided for @childrenLabel.
  ///
  /// In en, this message translates to:
  /// **'Do you have children?'**
  String get childrenLabel;

  /// No description provided for @childrenError.
  ///
  /// In en, this message translates to:
  /// **'Please select an option'**
  String get childrenError;

  /// No description provided for @familyTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Family Type'**
  String get familyTypeLabel;

  /// No description provided for @familyTypeError.
  ///
  /// In en, this message translates to:
  /// **'Family type is required'**
  String get familyTypeError;

  /// No description provided for @lifestyleTitle.
  ///
  /// In en, this message translates to:
  /// **'Lifestyle'**
  String get lifestyleTitle;

  /// No description provided for @lifestyleDesc.
  ///
  /// In en, this message translates to:
  /// **'Profession and education'**
  String get lifestyleDesc;

  /// No description provided for @educationLabel.
  ///
  /// In en, this message translates to:
  /// **'Education Level'**
  String get educationLabel;

  /// No description provided for @educationError.
  ///
  /// In en, this message translates to:
  /// **'Education is required'**
  String get educationError;

  /// No description provided for @professionLabel.
  ///
  /// In en, this message translates to:
  /// **'Profession'**
  String get professionLabel;

  /// No description provided for @professionError.
  ///
  /// In en, this message translates to:
  /// **'Profession is required'**
  String get professionError;

  /// No description provided for @habitsLabel.
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get habitsLabel;

  /// No description provided for @habitsHint.
  ///
  /// In en, this message translates to:
  /// **'Select your habits'**
  String get habitsHint;

  /// No description provided for @personalityTitle.
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get personalityTitle;

  /// No description provided for @personalityDesc.
  ///
  /// In en, this message translates to:
  /// **'Select up to 5 traits to show your personality'**
  String get personalityDesc;

  /// No description provided for @personalityLabel.
  ///
  /// In en, this message translates to:
  /// **'Personality Traits'**
  String get personalityLabel;

  /// No description provided for @personalityHint.
  ///
  /// In en, this message translates to:
  /// **'Select up to 5'**
  String get personalityHint;

  /// No description provided for @personalityError.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one trait'**
  String get personalityError;

  /// No description provided for @hobbiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Hobbies'**
  String get hobbiesTitle;

  /// No description provided for @hobbiesDesc.
  ///
  /// In en, this message translates to:
  /// **'Select up to 15 interests'**
  String get hobbiesDesc;

  /// No description provided for @hobbiesLabel.
  ///
  /// In en, this message translates to:
  /// **'Hobbies & Interests'**
  String get hobbiesLabel;

  /// No description provided for @hobbiesHint.
  ///
  /// In en, this message translates to:
  /// **'Select up to 15'**
  String get hobbiesHint;

  /// No description provided for @photosTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Photos'**
  String get photosTitle;

  /// No description provided for @photosDesc.
  ///
  /// In en, this message translates to:
  /// **'You need to upload at least 3 photos'**
  String get photosDesc;

  /// No description provided for @photosLabel.
  ///
  /// In en, this message translates to:
  /// **'Upload Photos'**
  String get photosLabel;

  /// No description provided for @photosHint.
  ///
  /// In en, this message translates to:
  /// **'Photos are required'**
  String get photosHint;

  /// No description provided for @photosError.
  ///
  /// In en, this message translates to:
  /// **'Photos are required'**
  String get photosError;

  /// No description provided for @preferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferencesTitle;

  /// No description provided for @preferencesDesc.
  ///
  /// In en, this message translates to:
  /// **'Set your match preferences'**
  String get preferencesDesc;

  /// No description provided for @ageRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Age Range'**
  String get ageRangeLabel;

  /// No description provided for @ageRangeHint.
  ///
  /// In en, this message translates to:
  /// **'Select age range'**
  String get ageRangeHint;

  /// No description provided for @ageRangeError.
  ///
  /// In en, this message translates to:
  /// **'Please select age range'**
  String get ageRangeError;

  /// No description provided for @distanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distanceLabel;

  /// No description provided for @distanceHint.
  ///
  /// In en, this message translates to:
  /// **'Select maximum distance'**
  String get distanceHint;

  /// No description provided for @distanceError.
  ///
  /// In en, this message translates to:
  /// **'Please select distance'**
  String get distanceError;

  /// No description provided for @selectHint.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectHint;

  /// No description provided for @parentsStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Parents Status'**
  String get parentsStatusLabel;

  /// No description provided for @parentsStatusError.
  ///
  /// In en, this message translates to:
  /// **'Parents status is required'**
  String get parentsStatusError;

  /// No description provided for @preferredDistanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Preferred Distance'**
  String get preferredDistanceLabel;

  /// No description provided for @preferredDistanceHint.
  ///
  /// In en, this message translates to:
  /// **'Select maximum distance'**
  String get preferredDistanceHint;

  /// No description provided for @preferredDistanceError.
  ///
  /// In en, this message translates to:
  /// **'Please select a valid distance'**
  String get preferredDistanceError;

  /// No description provided for @preferredMinEducationLabel.
  ///
  /// In en, this message translates to:
  /// **'Minimum Education Level'**
  String get preferredMinEducationLabel;

  /// No description provided for @preferredMinEducationHint.
  ///
  /// In en, this message translates to:
  /// **'Select minimum education level'**
  String get preferredMinEducationHint;

  /// No description provided for @preferredMinEducationError.
  ///
  /// In en, this message translates to:
  /// **'Please select minimum education level'**
  String get preferredMinEducationError;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @within6Months.
  ///
  /// In en, this message translates to:
  /// **'Within 6 Months'**
  String get within6Months;

  /// No description provided for @sixToTwelveMonths.
  ///
  /// In en, this message translates to:
  /// **'6–12 Months'**
  String get sixToTwelveMonths;

  /// No description provided for @oneToTwoYears.
  ///
  /// In en, this message translates to:
  /// **'1–2 Years'**
  String get oneToTwoYears;

  /// No description provided for @twoPlusYears.
  ///
  /// In en, this message translates to:
  /// **'2+ Years'**
  String get twoPlusYears;

  /// No description provided for @islam.
  ///
  /// In en, this message translates to:
  /// **'Islam'**
  String get islam;

  /// No description provided for @christianity.
  ///
  /// In en, this message translates to:
  /// **'Christianity'**
  String get christianity;

  /// No description provided for @hinduism.
  ///
  /// In en, this message translates to:
  /// **'Hinduism'**
  String get hinduism;

  /// No description provided for @sikhism.
  ///
  /// In en, this message translates to:
  /// **'Sikhism'**
  String get sikhism;

  /// No description provided for @buddhism.
  ///
  /// In en, this message translates to:
  /// **'Buddhism'**
  String get buddhism;

  /// No description provided for @jainism.
  ///
  /// In en, this message translates to:
  /// **'Jainism'**
  String get jainism;

  /// No description provided for @judaism.
  ///
  /// In en, this message translates to:
  /// **'Judaism'**
  String get judaism;

  /// No description provided for @bahai.
  ///
  /// In en, this message translates to:
  /// **'Baháʼí'**
  String get bahai;

  /// No description provided for @zoroastrianism.
  ///
  /// In en, this message translates to:
  /// **'Zoroastrianism (Parsi)'**
  String get zoroastrianism;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @strict.
  ///
  /// In en, this message translates to:
  /// **'Strict'**
  String get strict;

  /// No description provided for @moderate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// No description provided for @flexible.
  ///
  /// In en, this message translates to:
  /// **'Flexible'**
  String get flexible;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @urdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get urdu;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @punjabi.
  ///
  /// In en, this message translates to:
  /// **'Punjabi'**
  String get punjabi;

  /// No description provided for @gujarati.
  ///
  /// In en, this message translates to:
  /// **'Gujarati'**
  String get gujarati;

  /// No description provided for @marathi.
  ///
  /// In en, this message translates to:
  /// **'Marathi'**
  String get marathi;

  /// No description provided for @tamil.
  ///
  /// In en, this message translates to:
  /// **'Tamil'**
  String get tamil;

  /// No description provided for @telugu.
  ///
  /// In en, this message translates to:
  /// **'Telugu'**
  String get telugu;

  /// No description provided for @malayalam.
  ///
  /// In en, this message translates to:
  /// **'Malayalam'**
  String get malayalam;

  /// No description provided for @kannada.
  ///
  /// In en, this message translates to:
  /// **'Kannada'**
  String get kannada;

  /// No description provided for @bengali.
  ///
  /// In en, this message translates to:
  /// **'Bengali'**
  String get bengali;

  /// No description provided for @neverMarried.
  ///
  /// In en, this message translates to:
  /// **'Never Married'**
  String get neverMarried;

  /// No description provided for @separated.
  ///
  /// In en, this message translates to:
  /// **'Separated'**
  String get separated;

  /// No description provided for @divorced.
  ///
  /// In en, this message translates to:
  /// **'Divorced'**
  String get divorced;

  /// No description provided for @widowed.
  ///
  /// In en, this message translates to:
  /// **'Widowed'**
  String get widowed;

  /// No description provided for @nuclear.
  ///
  /// In en, this message translates to:
  /// **'Nuclear Family'**
  String get nuclear;

  /// No description provided for @joint.
  ///
  /// In en, this message translates to:
  /// **'Joint Family'**
  String get joint;

  /// No description provided for @extended.
  ///
  /// In en, this message translates to:
  /// **'Extended Family'**
  String get extended;

  /// No description provided for @livingTogether.
  ///
  /// In en, this message translates to:
  /// **'Living Together'**
  String get livingTogether;

  /// No description provided for @fatherPassed.
  ///
  /// In en, this message translates to:
  /// **'Father Passed Away'**
  String get fatherPassed;

  /// No description provided for @bothPassed.
  ///
  /// In en, this message translates to:
  /// **'Both Passed Away'**
  String get bothPassed;

  /// No description provided for @secondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary School'**
  String get secondary;

  /// No description provided for @highSchool.
  ///
  /// In en, this message translates to:
  /// **'High School'**
  String get highSchool;

  /// No description provided for @nonDegree.
  ///
  /// In en, this message translates to:
  /// **'Non-degree Qualification'**
  String get nonDegree;

  /// No description provided for @bachelors.
  ///
  /// In en, this message translates to:
  /// **'Bachelor’s Degree'**
  String get bachelors;

  /// No description provided for @masters.
  ///
  /// In en, this message translates to:
  /// **'Master’s Degree'**
  String get masters;

  /// No description provided for @doctorate.
  ///
  /// In en, this message translates to:
  /// **'Doctorate'**
  String get doctorate;

  /// No description provided for @it.
  ///
  /// In en, this message translates to:
  /// **'IT / Software'**
  String get it;

  /// No description provided for @healthcare.
  ///
  /// In en, this message translates to:
  /// **'Healthcare'**
  String get healthcare;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business / Entrepreneur'**
  String get business;

  /// No description provided for @finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// No description provided for @government.
  ///
  /// In en, this message translates to:
  /// **'Government Service'**
  String get government;

  /// No description provided for @legal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legal;

  /// No description provided for @engineering.
  ///
  /// In en, this message translates to:
  /// **'Engineering'**
  String get engineering;

  /// No description provided for @sales.
  ///
  /// In en, this message translates to:
  /// **'Sales / Marketing'**
  String get sales;

  /// No description provided for @design.
  ///
  /// In en, this message translates to:
  /// **'Design / Creative'**
  String get design;

  /// No description provided for @media.
  ///
  /// In en, this message translates to:
  /// **'Media & Communication'**
  String get media;

  /// No description provided for @architecture.
  ///
  /// In en, this message translates to:
  /// **'Architecture / Construction'**
  String get architecture;

  /// No description provided for @manufacturing.
  ///
  /// In en, this message translates to:
  /// **'Manufacturing / Industrial'**
  String get manufacturing;

  /// No description provided for @hospitality.
  ///
  /// In en, this message translates to:
  /// **'Hospitality / Travel'**
  String get hospitality;

  /// No description provided for @aviation.
  ///
  /// In en, this message translates to:
  /// **'Aviation / Maritime'**
  String get aviation;

  /// No description provided for @agriculture.
  ///
  /// In en, this message translates to:
  /// **'Agriculture'**
  String get agriculture;

  /// No description provided for @selfEmployed.
  ///
  /// In en, this message translates to:
  /// **'Self-Employed'**
  String get selfEmployed;

  /// No description provided for @homemaker.
  ///
  /// In en, this message translates to:
  /// **'Homemaker'**
  String get homemaker;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @retired.
  ///
  /// In en, this message translates to:
  /// **'Retired'**
  String get retired;

  /// No description provided for @eatHalal.
  ///
  /// In en, this message translates to:
  /// **'Eat Halal'**
  String get eatHalal;

  /// No description provided for @nonSmoker.
  ///
  /// In en, this message translates to:
  /// **'Non Smoker'**
  String get nonSmoker;

  /// No description provided for @noDrinking.
  ///
  /// In en, this message translates to:
  /// **'Doesn’t Drink'**
  String get noDrinking;

  /// No description provided for @praysFiveTimes.
  ///
  /// In en, this message translates to:
  /// **'Prays 5x'**
  String get praysFiveTimes;

  /// No description provided for @familyFirst.
  ///
  /// In en, this message translates to:
  /// **'Family First'**
  String get familyFirst;

  /// No description provided for @cooksFood.
  ///
  /// In en, this message translates to:
  /// **'Cooks Food'**
  String get cooksFood;

  /// No description provided for @careerDriven.
  ///
  /// In en, this message translates to:
  /// **'Career-Driven'**
  String get careerDriven;

  /// No description provided for @healthyLifestyle.
  ///
  /// In en, this message translates to:
  /// **'Healthy Lifestyle'**
  String get healthyLifestyle;

  /// No description provided for @adventurous.
  ///
  /// In en, this message translates to:
  /// **'🎒 Adventurous'**
  String get adventurous;

  /// No description provided for @activeFit.
  ///
  /// In en, this message translates to:
  /// **'🏃 Active & Fit'**
  String get activeFit;

  /// No description provided for @goodListener.
  ///
  /// In en, this message translates to:
  /// **'🎧 Good Listener'**
  String get goodListener;

  /// No description provided for @emotionallyIntelligent.
  ///
  /// In en, this message translates to:
  /// **'🧠 Emotionally Intelligent'**
  String get emotionallyIntelligent;

  /// No description provided for @positiveThinker.
  ///
  /// In en, this message translates to:
  /// **'😊 Positive Thinker'**
  String get positiveThinker;

  /// No description provided for @communicative.
  ///
  /// In en, this message translates to:
  /// **'💬 Communicative'**
  String get communicative;

  /// No description provided for @supportive.
  ///
  /// In en, this message translates to:
  /// **'🤝 Supportive'**
  String get supportive;

  /// No description provided for @openMinded.
  ///
  /// In en, this message translates to:
  /// **'🌍 Open-Minded'**
  String get openMinded;

  /// No description provided for @goalOriented.
  ///
  /// In en, this message translates to:
  /// **'🎯 Goal-Oriented'**
  String get goalOriented;

  /// No description provided for @passionate.
  ///
  /// In en, this message translates to:
  /// **'🔥 Passionate'**
  String get passionate;

  /// No description provided for @curious.
  ///
  /// In en, this message translates to:
  /// **'💡 Curious'**
  String get curious;

  /// No description provided for @calm.
  ///
  /// In en, this message translates to:
  /// **'🕊️ Calm Under Pressure'**
  String get calm;

  /// No description provided for @caring.
  ///
  /// In en, this message translates to:
  /// **'❤️ Caring & Empathetic'**
  String get caring;

  /// No description provided for @problemSolver.
  ///
  /// In en, this message translates to:
  /// **'🧩 Problem Solver'**
  String get problemSolver;

  /// No description provided for @art.
  ///
  /// In en, this message translates to:
  /// **'🎨 Art & Creativity'**
  String get art;

  /// No description provided for @photography.
  ///
  /// In en, this message translates to:
  /// **'📸 Photography'**
  String get photography;

  /// No description provided for @movies.
  ///
  /// In en, this message translates to:
  /// **'🎬 Movies & Cinema'**
  String get movies;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'🎧 Listening to Music'**
  String get music;

  /// No description provided for @singing.
  ///
  /// In en, this message translates to:
  /// **'🎶 Singing'**
  String get singing;

  /// No description provided for @instruments.
  ///
  /// In en, this message translates to:
  /// **'🎸 Playing Musical Instruments'**
  String get instruments;

  /// No description provided for @painting.
  ///
  /// In en, this message translates to:
  /// **'🖌️ Painting & Sketching'**
  String get painting;

  /// No description provided for @writing.
  ///
  /// In en, this message translates to:
  /// **'✍️ Writing & Blogging'**
  String get writing;

  /// No description provided for @fitness.
  ///
  /// In en, this message translates to:
  /// **'🏃‍♂️ Fitness & Wellness'**
  String get fitness;

  /// No description provided for @gym.
  ///
  /// In en, this message translates to:
  /// **'🏋️ Gym & Weight Training'**
  String get gym;

  /// No description provided for @yoga.
  ///
  /// In en, this message translates to:
  /// **'🧘 Yoga & Meditation'**
  String get yoga;

  /// No description provided for @cycling.
  ///
  /// In en, this message translates to:
  /// **'🚴 Cycling'**
  String get cycling;

  /// No description provided for @swimming.
  ///
  /// In en, this message translates to:
  /// **'🏊 Swimming'**
  String get swimming;

  /// No description provided for @healthyLiving.
  ///
  /// In en, this message translates to:
  /// **'🥗 Healthy Living'**
  String get healthyLiving;

  /// No description provided for @sports.
  ///
  /// In en, this message translates to:
  /// **'⚽ Sports & Games'**
  String get sports;

  /// No description provided for @cricket.
  ///
  /// In en, this message translates to:
  /// **'🏏 Cricket'**
  String get cricket;

  /// No description provided for @football.
  ///
  /// In en, this message translates to:
  /// **'⚽ Football'**
  String get football;

  /// No description provided for @basketball.
  ///
  /// In en, this message translates to:
  /// **'🏀 Basketball'**
  String get basketball;

  /// No description provided for @badminton.
  ///
  /// In en, this message translates to:
  /// **'🏸 Badminton'**
  String get badminton;

  /// No description provided for @gaming.
  ///
  /// In en, this message translates to:
  /// **'🎮 Video Gaming'**
  String get gaming;

  /// No description provided for @chess.
  ///
  /// In en, this message translates to:
  /// **'♟️ Chess'**
  String get chess;

  /// No description provided for @travel.
  ///
  /// In en, this message translates to:
  /// **'✈️ Traveling'**
  String get travel;

  /// No description provided for @camping.
  ///
  /// In en, this message translates to:
  /// **'🏕️ Camping'**
  String get camping;

  /// No description provided for @exploring.
  ///
  /// In en, this message translates to:
  /// **'🗺️ Exploring New Places'**
  String get exploring;

  /// No description provided for @reading.
  ///
  /// In en, this message translates to:
  /// **'📖 Reading Books'**
  String get reading;

  /// No description provided for @cafe.
  ///
  /// In en, this message translates to:
  /// **'☕ Café Hopping'**
  String get cafe;

  /// No description provided for @cooking.
  ///
  /// In en, this message translates to:
  /// **'🍳 Cooking'**
  String get cooking;

  /// No description provided for @baking.
  ///
  /// In en, this message translates to:
  /// **'🥘 Baking'**
  String get baking;

  /// No description provided for @cuisines.
  ///
  /// In en, this message translates to:
  /// **'🍜 Trying New Cuisines'**
  String get cuisines;

  /// No description provided for @coffee.
  ///
  /// In en, this message translates to:
  /// **'☕ Coffee Lover'**
  String get coffee;

  /// No description provided for @desserts.
  ///
  /// In en, this message translates to:
  /// **'🍰 Dessert Making'**
  String get desserts;

  /// No description provided for @coding.
  ///
  /// In en, this message translates to:
  /// **'💻 Coding & Programming'**
  String get coding;

  /// No description provided for @appDev.
  ///
  /// In en, this message translates to:
  /// **'📱 App Development'**
  String get appDev;

  /// No description provided for @stockMarket.
  ///
  /// In en, this message translates to:
  /// **'📊 Stock Market'**
  String get stockMarket;

  /// No description provided for @puzzles.
  ///
  /// In en, this message translates to:
  /// **'🧩 Puzzle Solving'**
  String get puzzles;

  /// No description provided for @onlineLearning.
  ///
  /// In en, this message translates to:
  /// **'🎓 Online Learning'**
  String get onlineLearning;

  /// No description provided for @socializing.
  ///
  /// In en, this message translates to:
  /// **'🎉 Socializing'**
  String get socializing;

  /// No description provided for @publicSpeaking.
  ///
  /// In en, this message translates to:
  /// **'🗣️ Public Speaking'**
  String get publicSpeaking;

  /// No description provided for @volunteering.
  ///
  /// In en, this message translates to:
  /// **'💬 Volunteering'**
  String get volunteering;

  /// No description provided for @mindfulness.
  ///
  /// In en, this message translates to:
  /// **'🕯️ Mindfulness'**
  String get mindfulness;

  /// No description provided for @gardening.
  ///
  /// In en, this message translates to:
  /// **'🌿 Gardening'**
  String get gardening;

  /// No description provided for @anyEducation.
  ///
  /// In en, this message translates to:
  /// **'Any education level'**
  String get anyEducation;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
