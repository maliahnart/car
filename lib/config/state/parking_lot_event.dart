
import 'package:car/models/parking_lot.dart';
import 'package:equatable/equatable.dart';
abstract class ParkingLotEvent extends Equatable {
  const ParkingLotEvent();
  @override
  List<Object> get props => [];
}

class ParkingLotSelected extends ParkingLotEvent {
  final ParkingLot parkingLot;

  const ParkingLotSelected(this.parkingLot);

  @override
  List<Object> get props => [parkingLot];
}