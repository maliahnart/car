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
    final int? transactionStatus; 
    final String? expiredParking; 

    const TransactionsRefreshed({required this.parkingStatus, this.plateNumber,this.transactionStatus,
    this.expiredParking,});
}