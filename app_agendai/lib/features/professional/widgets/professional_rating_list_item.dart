import 'package:app_agendai/features/professional/models/rating.dart';
import 'package:flutter/material.dart';

import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/core/widgets/base/app_stateless.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfessionalRatingListItem extends AppStateless {
  const ProfessionalRatingListItem({super.key, required this.rating});

  final Rating rating;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rating.username,
          style: theme.body16Bold,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            for (int i = 0; i < 5; i++)
              SvgPicture.asset(
                'assets/icons/star.svg',
                colorFilter: ColorFilter.mode(
                  i < rating.stars ? theme.secondary : theme.gray,
                  BlendMode.srcIn,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          rating.comments,
          style: theme.body13,
        )
      ],
    );
  }
}
