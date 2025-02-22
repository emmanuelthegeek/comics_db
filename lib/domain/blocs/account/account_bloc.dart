// Package imports:
// import 'package:bloc_concurrency/bloc_concurrency.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
//
// // Project imports:
// import 'package:comics_db_app/domain/blocs/account/account_container.dart';
// import 'package:comics_db_app/domain/blocs/auth/auth_bloc.dart';
// import 'package:comics_db_app/domain/data_providers/session_data_provider.dart';
// import 'package:comics_db_app/domain/entity/account_details.dart';
//
// part 'account_state.dart';
//
// part 'account_event.dart';
//
// part 'account_bloc.freezed.dart';
//
// class AccountDetailsBloc extends Bloc<AccountDetailsEvent, AccountDetailsState> {
//   // final _personalApiClient = MovieAndTvApiClient();
//   final _sessionDataProvider = SessionDataProvider();
//
//   // String sessionId;
//
//   AccountDetailsBloc(AccountDetailsState initialState) : super(initialState) {
//     on<AccountDetailsEvent>(((event, emit) async {
//       if (event is AccountDetailsEventLoadDetails) {
//         // await onAccountDetailsEventLoadDetails(event, emit);
//       } else if (event is AccountDetailsEventLoadReset) {
//         await onAccountDetailsEventLoadReset(event, emit);
//       }
//     }), transformer: sequential());
//   }
//
//   // Future<void> onAccountDetailsEventLoadDetails(
//   //     AccountDetailsEvent event, Emitter<AccountDetailsState> emit) async {
//   //   try {
//   // final sessionId = await _sessionDataProvider.getSessionId();
//   // final details = await _personalApiClient.accountDetails(sessionId!);
//   // } catch (e) {}
//   // final sessionId = await _authApiClient.auth(username: event.login, password: event.password);
//   // final sessionId = await _sessionDataProvider.getAccountId();
//   // final result = await _personalApiClient.accountDetails(sessionId, Configuration.apiKey);
//   // final details = List<AccountDetails>.from(state.accountDetailsContainer.accountDetails)..addAll(result.accountDetails);
//   // final container = state.accountDetailsContainer.copyWith(
//   //   accountDetails: details,
//   // );
//   // final newState = state.copyWith(accountDetailsContainer: container);
//   // emit(newState);
//   // }
//
//   Future<void> onAccountDetailsEventLoadReset(AccountDetailsEvent event, Emitter<AccountDetailsState> emit) async {
//     emit(const AccountDetailsState.initial());
//   }
//
//   Future<void> onAccountLogoutEvent(AuthLogOutEvent event, Emitter<AuthState> emit) async {
//     try {
//       await _sessionDataProvider.deleteSessionId();
//       await _sessionDataProvider.deleteAccountId();
//     } catch (e) {
//       emit(AuthFailureState(e));
//     }
//   }
// }
