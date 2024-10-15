import 'package:app_agendai/core/widgets/app_base_page.dart';
import 'package:app_agendai/core/widgets/app_loading_indicator.dart';
import 'package:app_agendai/features/professional/pages/professional_ratings/professional_ratings_page_cubit.dart';
import 'package:app_agendai/features/professional/widgets/professional_rating_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalRatingsPage extends StatefulWidget {
  const ProfessionalRatingsPage({super.key, required this.id});

  final String id;

  @override
  State<ProfessionalRatingsPage> createState() =>
      _ProfessionalRatingsPageState();
}

class _ProfessionalRatingsPageState extends State<ProfessionalRatingsPage> {
  late final ProfessionalRatingsPageCubit cubit =
      ProfessionalRatingsPageCubit(professionalId: widget.id);

  @override
  void initState() {
    super.initState();

    cubit.loadRatings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfessionalRatingsPageCubit,
        ProfessionalRatingsPageState>(
      bloc: cubit,
      builder: (context, state) {
        return AppBasePage(
          title: 'AVALIAÇÕES',
          isLoading: state.isLoading,
          type: AppBasePageType.fixed,
          body: state.ratings != null
              ? ListView.separated(
                  padding: MediaQuery.paddingOf(context).add(
                    const EdgeInsets.fromLTRB(24, 80, 24, 24),
                  ),
                  itemBuilder: (_, i) {
                    if (i < state.ratings!.length) {
                      final rating = state.ratings![i];
                      return ProfessionalRatingListItem(rating: rating);
                    } else {
                      cubit.loadRatings();
                      return const Center(
                        child: AppLoadingIndicator(),
                      );
                    }
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 18,
                  ),
                  itemCount:
                      state.ratings!.length + (state.finishedLoading ? 0 : 1),
                )
              : Container(),
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
