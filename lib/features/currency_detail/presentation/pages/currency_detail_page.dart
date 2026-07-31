import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/design/design_tokens.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/trend_sparkline.dart';
import '../../domain/entities/historical_rate_series.dart';
import '../cubit/currency_detail_cubit.dart';
import '../cubit/currency_detail_state.dart';
import '../widgets/stats_card.dart';

class CurrencyDetailPage extends StatelessWidget {
  const CurrencyDetailPage({
    super.key,
    required this.baseCode,
    required this.quoteCode,
  });

  final String baseCode;
  final String quoteCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.colorBgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacingLg,
            vertical: DesignTokens.spacingXl,
          ),
          child: BlocBuilder<CurrencyDetailCubit, CurrencyDetailState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailHeader(baseCode: baseCode, quoteCode: quoteCode),
                  const SizedBox(height: DesignTokens.spacingLg),
                  Expanded(child: _DetailBody(state: state)),
                  const SizedBox(height: DesignTokens.spacingMd),
                  BottomNavBar(
                    activeDestination: BottomNavDestination.markets,
                    onDestinationSelected: (_) {},
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.baseCode, required this.quoteCode});

  final String baseCode;
  final String quoteCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: DesignTokens.colorBgSurfaceElevated,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 16,
              color: DesignTokens.colorTextPrimary,
            ),
          ),
        ),
        const SizedBox(width: DesignTokens.spacingSm),
        Text('$baseCode / $quoteCode', style: DesignTokens.textTitleSemiBold16),
      ],
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.state});

  final CurrencyDetailState state;

  @override
  Widget build(BuildContext context) {
    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (series) => _DetailContent(series: series),
      error: (failure) => _ErrorView(
        message: failure.message,
        onRetry: () => context.read<CurrencyDetailCubit>().refresh(),
      ),
      staleData: (series, lastFailure) => _DetailContent(series: series),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.series});

  final HistoricalRateSeries series;

  @override
  Widget build(BuildContext context) {
    final isPositive = series.isPositiveTrend;
    final accent = isPositive
        ? DesignTokens.colorAccentPositive
        : DesignTokens.colorAccentNegative;
    final sign = isPositive ? '+' : '';
    final percentLabel = '$sign${series.percentChange.toStringAsFixed(2)}%';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            series.points.last.rate.toStringAsFixed(4),
            style: DesignTokens.textDisplayHeroBold40,
          ),
          const SizedBox(height: DesignTokens.spacingXs),
          Text(
            '$percentLabel hoy',
            style: DesignTokens.textLabelSemiBold12.copyWith(
              color: accent,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          ClipRRect(
            borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: TrendSparkline(
                points: series.points.map((p) => p.rate).toList(),
                isPositive: isPositive,
              ),
            ),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          StatsCard(
            percentChangeLabel: percentLabel,
            minRateLabel: series.minRate.toStringAsFixed(4),
            maxRateLabel: series.maxRate.toStringAsFixed(4),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: DesignTokens.textBodyRegular14.copyWith(
              color: DesignTokens.colorTextSecondary,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          AppButton(label: 'Reintentar', onPressed: onRetry),
        ],
      ),
    );
  }
}
