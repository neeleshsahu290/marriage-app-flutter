import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class LanguageBottomSheetField extends StatefulWidget {
  final String label;
  final ValueChanged<List<String>>? onSelected;
  final List<String>? initalValue;

  const LanguageBottomSheetField({
    super.key,
    required this.label,
    required this.onSelected,
    this.initalValue,
  });

  @override
  State<LanguageBottomSheetField> createState() =>
      _LanguageBottomSheetFieldState();
}

class _LanguageBottomSheetFieldState extends State<LanguageBottomSheetField> {
  List<String> selectedLanguages = [];
  List<String> _allLanguages = [];
  List<String> _filteredLanguages = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadLanguages();
  }

  /// 🔹 LOAD LANGUAGES (ASYNC)
  Future<void> loadLanguages() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/files/language_name.json',
      );

      final List<dynamic> data = json.decode(response);

      /// Extract NAME only from JSON
      final list = data.map<String>((e) => e as String).toList();

      if (widget.initalValue != null && widget.initalValue!.isNotEmpty) {
        selectedLanguages = List.from(widget.initalValue!);
      }

      setState(() {
        _allLanguages = list;
        _filteredLanguages = list;
        _isLoading = false;
      });
    } catch (e) {
      log("Error loading languages: $e");
    }
  }

  void _openSheet(BuildContext context) {
    List<String> tempSelected = List.from(selectedLanguages);
    List<String> filtered = List.from(_filteredLanguages);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            if (_isLoading) {
              return const SizedBox(
                height: 300,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  /// Drag Handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(text: context.tr.languages),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedLanguages = tempSelected;
                            });

                            widget.onSelected?.call(selectedLanguages);

                            Navigator.pop(context);
                          },
                          child: Text(context.tr.done),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Search
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: context.tr.searchLanguage,
                        prefixIcon: const Icon(Icons.search),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        setModalState(() {
                          filtered = _allLanguages
                              .where(
                                (lang) => lang.toLowerCase().contains(
                                  value.toLowerCase(),
                                ),
                              )
                              .toList();
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Language List
                  Expanded(
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final lang = filtered[index];

                        final isSelected = tempSelected.contains(lang);

                        return ListTile(
                          title: MyText(
                            text: lang,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color.fromRGBO(255, 31, 87, 0.7),
                                  size: 25,
                                )
                              : const Icon(
                                  Icons.circle_outlined,
                                  color: AppColors.border,
                                  size: 25,
                                ),
                          onTap: () {
                            setModalState(() {
                              if (isSelected) {
                                tempSelected.remove(lang);
                              } else {
                                tempSelected.add(lang);
                              }
                            });
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
        Text(widget.label),
        const SizedBox(height: 6),

        GestureDetector(
          onTap: () => _openSheet(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
            ),
            child: Row(
              children: [
                Expanded(
                  child: MyText(
                    text: selectedLanguages.isEmpty
                        ? context.tr.selectLanguages
                        : selectedLanguages.join(', '),
                    color: selectedLanguages.isEmpty
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_up),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
