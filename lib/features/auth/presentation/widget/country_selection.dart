import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/features/auth/model/countries_model.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class CountrySelection extends StatefulWidget {
  final ValueChanged<String?>? onSelected;

  const CountrySelection({super.key, this.onSelected});

  @override
  State<CountrySelection> createState() => _CountrySelectionState();
}

class _CountrySelectionState extends State<CountrySelection> {
  Country? selectedCountry;
  late Future<List<Country>> countriesFuture;

  List<Country> _allCountries = [];
  List<Country> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    countriesFuture = loadCountries();
  }

  Future<List<Country>> loadCountries() async {
    final String response = await rootBundle.loadString(
      'assets/files/countries.json',
    );

    final List<dynamic> data = json.decode(response);
    final list = data.map((e) => Country.fromJson(e)).toList();

    selectedCountry = list.first;
    _allCountries = list;
    _filteredCountries = list;
    setState(() {});
    return list;
  }

  void _openCountrySheet(BuildContext context) async {
    await countriesFuture;
    _filteredCountries = _allCountries;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // Search Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search country',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        setModalState(() {
                          _filteredCountries = _allCountries.where((country) {
                            return country.name.toLowerCase().contains(
                                  value.toLowerCase(),
                                ) ||
                                country.dialCode.contains(value);
                          }).toList();
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Country List
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = _filteredCountries[index];
                        final isSelected =
                            selectedCountry?.code == country.code;

                        return ListTile(
                          leading: Text(
                            country.flag,
                            style: const TextStyle(fontSize: 22),
                          ),
                          title: Text(country.name),
                          trailing: Text(country.dialCode),
                          selected: isSelected,
                          onTap: () {
                            setState(() {
                              selectedCountry = country;
                            });
                            widget.onSelected?.call(country.dialCode);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(text: 'Country'),
        const SizedBox(height: 6),

        GestureDetector(
          onTap: () => _openCountrySheet(context),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.cardBackground,
            ),
            child: Row(
              children: [
                if (selectedCountry != null) ...[
                  Text(
                    selectedCountry!.flag,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MyText(
                      text:
                          "${selectedCountry!.name} (${selectedCountry!.dialCode})",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ] else
                  Expanded(child: const Text("Select country")),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
