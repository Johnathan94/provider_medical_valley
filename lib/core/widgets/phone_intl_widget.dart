import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider_medical_valley/core/app_colors.dart';
import 'package:provider_medical_valley/core/widgets/countries.dart';

class PhoneIntlWidgetField extends StatelessWidget {
  final TextEditingController phoneController;
  final Function(Country country) onCountryChanged;
  final Color? fillColor;
  final Color? borderColor;
  final bool? enabled;
  final String? countryCode;
  const PhoneIntlWidgetField(
      this.phoneController, this.enabled, this.onCountryChanged,
      {this.fillColor, this.countryCode, this.borderColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
        initialValue: "",
        disableLengthCheck: true,
        controller: phoneController,
        cursorColor: primaryColor,
        enabled: enabled ?? true,
        dropdownIconPosition: IconPosition.trailing,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (PhoneNumber? phoneNumber) {
          if (phoneNumber!.number.length == 10 ||
              phoneNumber.number.length == 9) {
            return null;
          } else {
            return AppLocalizations.of(context)!.invalid_phone;
          }
        },
        dropdownIcon: const Icon(
          Icons.arrow_drop_down,
          color: greyWith80Percentage,
        ),
        flagsButtonPadding: const EdgeInsetsDirectional.only(start: 12),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? whiteRed100,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        initialCountryCode: countryCode ?? "SA",
        onChanged: (phone) {
          phone.completeNumber;
        },
        onCountryChanged: (c) {
          onCountryChanged(c);
        });
  }
}

List<String> seperatePhoneAndDialCode(String phoneWithDialCode) {
  Map<String, String> foundedCountry = {};
  for (var country in Countries.allCountries) {
    String dialCode = country["dial_code"].toString();
    if (phoneWithDialCode.contains(dialCode)) {
      foundedCountry = country;
    }
  }

  if (foundedCountry.isNotEmpty) {
    var newPhoneNumber = phoneWithDialCode.substring(
      foundedCountry["dial_code"]!.length,
    );
    return [foundedCountry["code"]!, newPhoneNumber];
  } else {
    return [];
  }
}
