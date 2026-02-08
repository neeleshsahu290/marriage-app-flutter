import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';

import 'package:swan_match/features/matches/presentation/widgets/profile_card.dart';
import 'package:swan_match/features/matches/provider/matches_cubit.dart';
import 'package:swan_match/features/matches/provider/matches_state.dart';
import 'package:swan_match/match_status.dart';
import 'package:swan_match/shared/models/user.dart';
import 'package:swan_match/shared/widgets/common/empty_state_widget.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    context.read<MatchesCubit>().loadAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            const SizedBox(height: 20),

            _buildTabs(),

            const SizedBox(height: 4),

            Expanded(
              child: BlocBuilder<MatchesCubit, MatchesState>(
                builder: (context, state) {
                  return IndexedStack(
                    index: selectedTab,
                    children: [
                      _buildSwipeView(
                        state.received,
                        CardType.recieved,
                        state.receivedStatus,
                      ),
                      _buildSwipeView(
                        state.accepted,
                        CardType.accepted,
                        state.acceptedStatus,
                      ),
                      _buildSwipeView(
                        state.sent,
                        CardType.sent,
                        state.sentStatus,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- TABS ----------------

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<MatchesCubit, MatchesState>(
        builder: (context, state) {
          return Row(
            children: [
              _tabButton(
                label: context.tr.matchesReceived,
                isSelected: selectedTab == 0,
                count: state.received.length,
                onTap: () => setState(() => selectedTab = 0),
              ),
              _tabButton(
                label: context.tr.matchesAccepted,
                isSelected: selectedTab == 1,
                count: state.accepted.length,
                onTap: () => setState(() => selectedTab = 1),
              ),
              _tabButton(
                label: context.tr.matchesSent,
                isSelected: selectedTab == 2,
                count: state.sent.length,
                onTap: () => setState(() => selectedTab = 2),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _tabButton({
    required String label,
    required bool isSelected,
    required int count,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondary : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1.2,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
          child: Center(child: MyText(text: "$label ($count)", fontSize: 14)),
        ),
      ),
    );
  }

  // ---------------- SWIPE VIEW ----------------

  Widget _buildSwipeView(
    List<User> users,
    CardType type,
    MatchesLoadStatus status,
  ) {
    if (status == MatchesLoadStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == MatchesLoadStatus.empty) {
      return _emptyByType(type);
    }

    if (status == MatchesLoadStatus.error) {
      return Center(
        child: MyText(text: context.tr.genericError, color: Colors.red),
      );
    }

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ProfileCard(user: users[index], cardType: type);
      },
    );
  }

  // ---------------- EMPTY STATES ----------------

  Widget _emptyByType(CardType type) {
    switch (type) {
      case CardType.recieved:
        return EmptyStateWidget(
          title: context.tr.emptyReceivedTitle,
          subtitle: context.tr.emptyReceivedSubtitle,
        );

      case CardType.accepted:
        return EmptyStateWidget(
          title: context.tr.emptyAcceptedTitle,
          subtitle: context.tr.emptyAcceptedSubtitle,
        );

      case CardType.sent:
        return EmptyStateWidget(
          title: context.tr.emptySentTitle,
          subtitle: context.tr.emptySentSubtitle,
        );

      case CardType.recommend:
        return EmptyStateWidget(
          title: context.tr.noProfilesFoundTitle,
          subtitle: context.tr.findingBetterMatches,
        );
    }
  }
}
