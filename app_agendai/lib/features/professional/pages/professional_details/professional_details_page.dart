import 'package:app_agendai/core/widgets/app_base_page.dart';
import 'package:app_agendai/core/widgets/app_elevated_button.dart';
import 'package:app_agendai/features/professional/pages/professional_details/professional_details_page_cubit.dart';
import 'package:app_agendai/features/professional/pages/professional_details/widgets/professional_basic_details_widget.dart';
import 'package:app_agendai/features/professional/pages/professional_details/widgets/professional_details_recent_ratings/professional_details_recent_ratings.dart';
import 'package:app_agendai/features/professional/pages/professional_details/widgets/professional_details_services_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalDetailsPage extends StatefulWidget {
  const ProfessionalDetailsPage({super.key, required this.id});

  final String id;

  @override
  State<ProfessionalDetailsPage> createState() =>
      _ProfessionalDetailsPageState();
}

class _ProfessionalDetailsPageState extends State<ProfessionalDetailsPage> {
  final ProfessionalDetailsPageCubit cubit = ProfessionalDetailsPageCubit();

  @override
  void initState() {
    super.initState();

    cubit.getProfessional(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfessionalDetailsPageCubit,
        ProfessionalDetailsPageState>(
      bloc: cubit,
      builder: (context, state) {
        return AppBasePage(
          title: 'PROFISSIONAL',
          isLoading: state.isLoading,
          body: state.professional != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfessionalBasicDetailsWidget(
                        professional: state.professional!),
                    const SizedBox(height: 8),
                    ProfessionalDetailsServicesWidget(
                        professional: state.professional!),
                    const SizedBox(height: 16),
                    ProfessionalDetailsRecentRatings(professionalId: widget.id),
                  ],
                )
              : Container(),
          bottomAction: AppElevatedButton(
            id: 'agendar-serviço',
            label: 'Agendar serviço(s)',
            onPressed: () {},
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
