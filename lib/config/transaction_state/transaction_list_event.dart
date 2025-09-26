import 'package:equatable/equatable.dart';

abstract class TransactionListEvent extends Equatable {
  const TransactionListEvent();
  @override
  List<Object> get props => [];
}

class TransactionsFetched extends TransactionListEvent {}

class TransactionsRefreshed extends TransactionListEvent {
    final int? parkingStatus; 
    final String? plateNumber; 

    const TransactionsRefreshed({required this.parkingStatus, this.plateNumber});
}