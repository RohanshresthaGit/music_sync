import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ne.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
    Locale('ne'),
  ];

  /// Greeting word
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// Expression of gratitude
  ///
  /// In en, this message translates to:
  /// **'Thank you'**
  String get thankYou;

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

  /// No description provided for @please.
  ///
  /// In en, this message translates to:
  /// **'Please'**
  String get please;

  /// No description provided for @sorry.
  ///
  /// In en, this message translates to:
  /// **'Sorry'**
  String get sorry;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get house;

  /// No description provided for @friend.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get friend;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @school.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get school;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'welcome Back!'**
  String get welcome_back;

  /// No description provided for @login_message.
  ///
  /// In en, this message translates to:
  /// **'Continue your journey as a guardian of of the grove.'**
  String get login_message;

  /// No description provided for @email_or_mobile.
  ///
  /// In en, this message translates to:
  /// **'EMAIL OR MOBILE'**
  String get email_or_mobile;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD'**
  String get password;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @or_continue_with.
  ///
  /// In en, this message translates to:
  /// **'OR CONTINUE WITH'**
  String get or_continue_with;

  /// No description provided for @new_to_vanashree.
  ///
  /// In en, this message translates to:
  /// **'New to Vanashree? '**
  String get new_to_vanashree;

  /// No description provided for @sign_up_for_an_account.
  ///
  /// In en, this message translates to:
  /// **'Sign Up For An Account'**
  String get sign_up_for_an_account;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @select_language.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get select_language;

  /// No description provided for @please_enter_your_email_or_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email or mobile number'**
  String get please_enter_your_email_or_mobile_number;

  /// No description provided for @please_enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get please_enter_your_password;

  /// No description provided for @password_must_be_at_least_6_charecters_long.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get password_must_be_at_least_6_charecters_long;

  /// No description provided for @sign_up1_title.
  ///
  /// In en, this message translates to:
  /// **'Begin your\nbotanical journey.'**
  String get sign_up1_title;

  /// No description provided for @sign_up1_description.
  ///
  /// In en, this message translates to:
  /// **'Create an account to join our living\narchive of native seedlings and\nconservation efforts.'**
  String get sign_up1_description;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get full_name;

  /// No description provided for @email_address.
  ///
  /// In en, this message translates to:
  /// **'EMAIL ADDRESS'**
  String get email_address;

  /// No description provided for @mobile_number.
  ///
  /// In en, this message translates to:
  /// **'MOBILE NUMBER'**
  String get mobile_number;

  /// No description provided for @security_and_trust.
  ///
  /// In en, this message translates to:
  /// **'Security & Trust'**
  String get security_and_trust;

  /// No description provided for @security_and_trust_description.
  ///
  /// In en, this message translates to:
  /// **'We protect your data like we protect our forests.'**
  String get security_and_trust_description;

  /// No description provided for @next_step.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get next_step;

  /// No description provided for @sign_up2_title.
  ///
  /// In en, this message translates to:
  /// **'Where are you\ngrowing?'**
  String get sign_up2_title;

  /// No description provided for @sign_up2_description.
  ///
  /// In en, this message translates to:
  /// **'Help us tailor your reforestation journey by sharing your local ecosystem.'**
  String get sign_up2_description;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @sign_up3_title.
  ///
  /// In en, this message translates to:
  /// **'Tell us your story.'**
  String get sign_up3_title;

  /// No description provided for @sign_up3_description.
  ///
  /// In en, this message translates to:
  /// **'Your journey with native flora matters. Share\nyour vision and help us map the future of our\nlocal ecosystems.'**
  String get sign_up3_description;

  /// No description provided for @your_bio.
  ///
  /// In en, this message translates to:
  /// **'Your Bio'**
  String get your_bio;

  /// No description provided for @complete_onboarding.
  ///
  /// In en, this message translates to:
  /// **'COMPLETE ONBOARDING'**
  String get complete_onboarding;

  /// No description provided for @please_enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get please_enter_your_name;

  /// No description provided for @please_enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get please_enter_your_email;

  /// No description provided for @please_enter_your_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter your mobile number'**
  String get please_enter_your_mobile_number;

  /// No description provided for @please_select_a_country.
  ///
  /// In en, this message translates to:
  /// **'Please select a country'**
  String get please_select_a_country;

  /// No description provided for @please_select_a_state.
  ///
  /// In en, this message translates to:
  /// **'Please select a state'**
  String get please_select_a_state;

  /// No description provided for @please_select_a_city.
  ///
  /// In en, this message translates to:
  /// **'Please select a city'**
  String get please_select_a_city;

  /// No description provided for @please_enter_your_bio.
  ///
  /// In en, this message translates to:
  /// **'Please enter your bio'**
  String get please_enter_your_bio;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'mr', 'ne'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'mr':
      return AppLocalizationsMr();
    case 'ne':
      return AppLocalizationsNe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
