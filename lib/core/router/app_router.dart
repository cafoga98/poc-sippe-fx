import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../di/injection.dart';
import '../../features/currency_detail/presentation/cubit/currency_detail_cubit.dart';
import '../../features/currency_detail/presentation/pages/currency_detail_page.dart';
import '../../features/currency_list/presentation/cubit/currency_list_cubit.dart';
import '../../features/currency_list/presentation/pages/currency_list_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/list',
  routes: [
    GoRoute(
      path: '/list',
      builder: (context, state) {
        return BlocProvider<CurrencyListCubit>(
          create: (_) => getIt<CurrencyListCubit>()..load(),
          child: const CurrencyListPage(),
        );
      },
    ),
    GoRoute(
      path: '/detail/:baseCode/:quoteCode',
      builder: (context, state) {
        final baseCode = state.pathParameters['baseCode']!;
        final quoteCode = state.pathParameters['quoteCode']!;
        return BlocProvider<CurrencyDetailCubit>(
          create: (_) =>
              getIt<CurrencyDetailCubit>()
                ..load(baseCode: baseCode, quoteCode: quoteCode),
          child: CurrencyDetailPage(baseCode: baseCode, quoteCode: quoteCode),
        );
      },
    ),
  ],
);
