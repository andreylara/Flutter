import 'package:app_agendai/core/theme/app_theme.dart';
import 'package:app_agendai/core/widgets/app_card.dart';
import 'package:app_agendai/core/widgets/base/app_stateless.dart';
import 'package:app_agendai/features/professional/models/professional_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfessionalBasicDetailsWidget extends AppStateless {
  const ProfessionalBasicDetailsWidget({super.key, required this.professional});

  final ProfessionalDetails professional;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: theme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  image: professional.picture != null
                      ? DecorationImage(
                          image: NetworkImage(
                            professional.picture!,
                          ),
                        )
                      : null,
                ),
                child: professional.picture != null
                    ? null
                    : Icon(
                        Icons.person_outline,
                        color: theme.primary,
                      ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      professional.name,
                      style: theme.body16Bold,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: SvgPicture.asset('assets/icons/star.svg'),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${professional.rating.toStringAsFixed(1)} (${professional.ratingCount})',
                            style: theme.label11Bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'CRM: ${professional.crm}',
                      style: theme.label11,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Especialidades',
            style: theme.body13Bold,
          ),
          const SizedBox(height: 10),
          Text(
            professional.specialties.map((e) => e.name).join(' | '),
            style: theme.body16,
          ),
          const SizedBox(height: 20),
          Text(
            'Convênios',
            style: theme.body13Bold,
          ),
          const SizedBox(height: 10),
          Text(
            professional.insurances.map((e) => e.name).join(' | '),
            style: theme.body16,
          )
        ],
      ),
    );
  }
}
