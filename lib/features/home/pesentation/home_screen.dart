import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/features/home/cubit/home_cubit.dart';
import 'package:swan_match/features/home/cubit/home_state.dart';
import 'package:swan_match/features/matches/presentation/widgets/profile_card.dart';
import 'package:swan_match/match_status.dart';
import 'package:swan_match/shared/widgets/common/empty_state_widget.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;

  late List<String> tabs;

  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().loadHomeMatches("RECOMMENDED");
  }

  @override
  Widget build(BuildContext context) {
    // localized tabs
    tabs = [
      context.tr.homeTabToday,

      //context.tr.homeTabAll
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            const SizedBox(height: 20),

            _buildTabs(),

            const SizedBox(height: 4),

            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: [
                  _buildSwipeView(CardType.recommend),
                  // _buildSwipeView(CardType.recommend),
                ],
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
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = index),
              child: _tabButton(
                label: tabs[index],
                isSelected: selectedTab == index,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabButton({required String label, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.secondary : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1.2,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
      ),
      child: Center(child: MyText(text: label, fontSize: 14)),
    );
  }

  // ---------------- SWIPE VIEW ----------------

  Widget _buildSwipeView(CardType type) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == HomeStatus.empty) {
          return Center(child: Text(context.tr.noProfilesFound));
        }

        if (state.status == HomeStatus.error) {
          return EmptyStateWidget(
            title: context.tr.noProfilesFoundTitle,
            subtitle: context.tr.findingBetterMatches,
          );
        }

        if (state.status == HomeStatus.success) {
          final users = state.matches;

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ProfileCard(user: users[index], cardType: type);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
