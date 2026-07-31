import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/design/design_tokens.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/currency_row.dart';
import '../../domain/usecases/get_currency_rates.dart';
import '../cubit/currency_list_cubit.dart';
import '../cubit/currency_list_state.dart';
import '../widgets/currency_list_header.dart';

class CurrencyListPage extends StatelessWidget {
  const CurrencyListPage({super.key});

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
          child: BlocBuilder<CurrencyListCubit, CurrencyListState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrencyListHeader(
                    title: 'FX Monitor',
                    subtitle: 'Moneda base: ${_baseCodeOf(state)}',
                  ),
                  const SizedBox(height: DesignTokens.spacingLg),
                  const Text(
                    'Monedas',
                    style: DesignTokens.textLabelSemiBold12,
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  Expanded(child: _CurrencyListBody(state: state)),
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

  String _baseCodeOf(CurrencyListState state) {
    return state.mapOrNull(
          loaded: (s) => s.baseCode,
          staleData: (s) => s.baseCode,
        ) ??
        '—';
  }
}

class _CurrencyListBody extends StatelessWidget {
  const _CurrencyListBody({required this.state});

  final CurrencyListState state;

  @override
  Widget build(BuildContext context) {
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (rows, baseCode, searchQuery) => _CurrencyRowList(rows: rows),
      error: (failure) => _ErrorView(
        message: failure.message,
        onRetry: () => context.read<CurrencyListCubit>().refresh(),
      ),
      staleData: (rows, baseCode, searchQuery, lastFailure) =>
          _CurrencyRowList(rows: rows),
    );
  }
}

class _CurrencyRowList extends StatelessWidget {
  const _CurrencyRowList({required this.rows});

  final List<CurrencyRowData> rows;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: rows.length,
      separatorBuilder: (_, _) =>
          const SizedBox(height: DesignTokens.spacingXs),
      itemBuilder: (context, index) {
        final row = rows[index];
        return CurrencyRow(
          code: row.code,
          name: row.name,
          rate: row.rate,
          onTap: () {},
        );
      },
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
