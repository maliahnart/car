
import 'package:car/models/parking_lot.dart';
import 'package:equatable/equatable.dart';

class ParkingLotState extends Equatable {
  final ParkingLot? selectedParkingLot;

  const ParkingLotState({this.selectedParkingLot});

  @override
  List<Object?> get props => [selectedParkingLot];
}