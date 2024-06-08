import 'package:flutter/material.dart';
import 'package:tour_del_norte_app/utils/utils.dart';

class OptionsLanguage extends StatefulWidget {
  const OptionsLanguage({
    super.key,
  });

  @override
  State<OptionsLanguage> createState() => _OptionsLanguageState();
}

class _OptionsLanguageState extends State<OptionsLanguage> {
  final _languages = ['Español', 'Inglés'];
  String _selectedLanguage = 'Español';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.defaultPadding),
      child: DropdownButtonFormField(
        value: _selectedLanguage,
        items: _languages.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedLanguage = newValue!;
          });
        },
        icon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.darkColor,
        ),
        decoration: InputDecoration(
          labelText: 'Lenguaje',
          labelStyle: AppStyles.h3(
            color: AppColors.darkColor,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
