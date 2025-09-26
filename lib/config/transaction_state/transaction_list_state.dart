
import 'package:car/models/transaction.dart';
import 'package:equatable/equatable.dart';

enum TransactionListStatus { initial, loading, success, failure }

class TransactionListState extends Equatable {
  final TransactionListStatus status;
  final List<Transaction> transactions;
  final bool hasReachedMax; 
  final int currentPage;
  final int? parkingStatus; 
  final String? plateNumber; 
  final String? errorMessage;

  const TransactionListState({
    this.status = TransactionListStatus.initial,
    this.transactions = const <Transaction>[],
    this.hasReachedMax = false,
    this.currentPage = 0,
    this.parkingStatus = 1, 
    this.plateNumber,
    this.errorMessage,
  });

  TransactionListState copyWith({
    TransactionListStatus? status,
    List<Transaction>? transactions,
    bool? hasReachedMax,
    int? currentPage,
    int? parkingStatus,
    String? plateNumber,
    String? errorMessage,
  }) {
    return TransactionListState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      parkingStatus: parkingStatus ?? this.parkingStatus,
      plateNumber: plateNumber ?? this.plateNumber,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, transactions, hasReachedMax, currentPage, parkingStatus, plateNumber, errorMessage];
}