import 'package:bloc/bloc.dart';
import 'package:car/config/state/parking_lot_event.dart';
import 'package:car/config/state/parking_lot_state.dart';
import 'package:equatable/equatable.dart';


class ParkingLotBloc extends Bloc<ParkingLotEvent, ParkingLotState> {
  ParkingLotBloc() : super(const ParkingLotState()) {
    on<ParkingLotSelected>((event, emit) {
      emit(ParkingLotState(selectedParkingLot: event.parkingLot));
    });
  }
}