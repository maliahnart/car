import 'package:bloc/bloc.dart';
import 'package:car/config/transaction_state/transaction_list_event.dart';
import 'package:car/config/transaction_state/transaction_list_state.dart';
import 'package:car/models/transaction_page.dart';
import 'package:car/services/transaction_service.dart';
import 'package:car/config/token_storage.dart';
import 'package:equatable/equatable.dart';

const _pageSize = 10;

class TransactionListBloc extends Bloc<TransactionListEvent, TransactionListState> {
  final TransactionService _transactionService;
  final int lotId;

  TransactionListBloc({
    required TransactionService transactionService,
    required this.lotId,
  })  : _transactionService = transactionService,
        super(const TransactionListState()) {
    on<TransactionsFetched>(_onTransactionsFetched);
    on<TransactionsRefreshed>(_onTransactionsRefreshed);
  }

  Future<void> _onTransactionsFetched(
    TransactionsFetched event,
    Emitter<TransactionListState> emit,
  ) async {
     print("--- BLoC NHẬN event TransactionsFetched. hasReachedMax hiện tại là: ${state.hasReachedMax} ---");
    if (state.hasReachedMax) return;

    try {
      final token = await TokenStorage.getToken();
      if (token == null) throw Exception("Token không hợp lệ");

      final transactionPage = await _transactionService.searchTransactions(
        lotId: lotId,
        parkingStatus: state.parkingStatus, 
        plateNumber: state.plateNumber,
        page: state.currentPage,
        size: _pageSize,
        token: token,
      );
        print("--- API Fetched Page: ${state.currentPage}, Items: ${transactionPage.transactions.length}, Total: ${transactionPage.totalCount} ---");

     final bool reachedMax = transactionPage.transactions.isEmpty ||
        transactionPage.transactions.length < _pageSize;
      emit(
        state.copyWith(
          status: TransactionListStatus.success,
          transactions: List.of(state.transactions)..addAll(transactionPage.transactions),
          currentPage: state.currentPage + 1,
          // hasReachedMax: (state.transactions.length + transactionPage.transactions.length) >= transactionPage.totalCount,
          totalCount: transactionPage.totalCount,
          hasReachedMax: reachedMax
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: TransactionListStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

Future<void> _onTransactionsRefreshed(
  TransactionsRefreshed event,
  Emitter<TransactionListState> emit,
) async {
  print("--- BLoC NHẬN event TransactionsRefreshed với parkingStatus: ${event.parkingStatus} ---");

  try {
    emit(TransactionListState(
      status: TransactionListStatus.loading,
      parkingStatus: event.parkingStatus, 
      plateNumber: event.plateNumber,
      transactionStatus: event.transactionStatus, 
      expiredParking: event.expiredParking, 
    
    ));

 
    final loadingState = state;
    print("--- BLoC ĐÃ EMIT state loading với parkingStatus: ${loadingState.parkingStatus} ---");
      print("--- BLoC EMIT LOADING STATE: ${loadingState.toString()}"); // << THÊM PRINT


    final token = await TokenStorage.getToken();
    if (token == null) throw Exception("Token không hợp lệ");

    final currentState = state;

    final transactionPage = await _transactionService.searchTransactions(
      lotId: lotId,
      parkingStatus: currentState.parkingStatus,
      plateNumber: currentState.plateNumber,
      transactionStatus: currentState.transactionStatus, 
      expiredParking: currentState.expiredParking, 
      page: 0,
      size: _pageSize,
      token: token,
    );
     print("--- API Refreshed, Items: ${transactionPage.transactions.length}, Total: ${transactionPage.totalCount} ---");

    emit(
      currentState.copyWith(
        status: TransactionListStatus.success,
        transactions: transactionPage.transactions,
        currentPage: 1,
        hasReachedMax: transactionPage.transactions.length >= transactionPage.totalCount,
          totalCount: transactionPage.totalCount,
      ),
    );
    print("--- BLoC EMIT SUCCESS STATE: ${currentState.toString()}"); // << THÊM PRINT
  } catch (e) {
    emit(state.copyWith(
      status: TransactionListStatus.failure,
      errorMessage: e.toString(),
    ));
  }
}
}