import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:spark/business_logic/blocs/authenticate/phone/phone_bloc.dart';
import 'package:spark/business_logic/blocs/authenticate/phone/phone_state.dart';
import 'package:spark/utils/constants/colors.dart';

class CustomPhoneNumberPicker extends StatelessWidget {
  const CustomPhoneNumberPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneBloc, PhoneState>(
      builder: (context, state) {
        return IntlPhoneField(
          initialCountryCode: 'IN',
          initialValue: '',
          cursorColor: AppColors.blackColor,
          style: Theme.of(context).textTheme.bodyLarge,
          dropdownIcon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.blackColor,
          ),
          pickerDialogStyle: PickerDialogStyle(
              countryCodeStyle: Theme.of(context).textTheme.bodySmall,
              countryNameStyle: Theme.of(context).textTheme.bodySmall,
              searchFieldInputDecoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodySmall,
                hintText: 'Search Country',
              )),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                  color: Colors.grey, width: 1.0), // Border styling
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 10.0), // Padding
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            filled: true,
          ),
          autofocus: true,
          onChanged: (phone) {
            state.phoneNumber = phone;
          },
          // onSubmitted: (phone) {
          //   state.phoneNumber = phone;
            
          // },
        );
      },
    );
  }
}
