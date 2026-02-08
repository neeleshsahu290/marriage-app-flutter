import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class ContactSectionWidget extends StatelessWidget {
  final String? phone;
  final String? email;

  final bool? showPhone;
  final bool? showEmail;

  const ContactSectionWidget({
    super.key,
    this.phone,
    this.email,
    this.showPhone,
    this.showEmail,
  });

  @override
  Widget build(BuildContext context) {
    if (phone == null && email == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(text: "Contact", fontSize: 18, fontWeight: FontWeight.w600),
        const SizedBox(height: 10),

        if (phone != null)
          _infoRow(
            AssetConstants.phoneIcon,
            showPhone == true ? phone! : _maskPhone(phone!),
          ),

        if (email != null)
          _infoRow(
            AssetConstants.mail2Icon,
            showEmail == true ? email! : _maskEmail(email!),
          ),
      ],
    );
  }

  Widget _infoRow(String icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(icon, height: 20, width: 20),
              const SizedBox(width: 10),
              Expanded(
                child: MyText(
                  text: value,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  // =========================
  //  Mask helpers
  // =========================

  String _maskPhone(String phone) {
    if (phone.length <= 4) return "****";

    final start = phone.substring(0, 2);
    final end = phone.substring(phone.length - 2);

    return "$start******$end";
  }

  String _maskEmail(String email) {
    final parts = email.split("@");

    if (parts.length != 2) return "****";

    final name = parts[0];
    final domain = parts[1];

    if (name.length <= 2) {
      return "**@$domain";
    }

    final visible = name.substring(0, 2);
    return "$visible****@$domain";
  }
}
