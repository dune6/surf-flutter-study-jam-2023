
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/ticket.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/service/repository/ticket_srotage_repository.dart';
import 'package:surf_logger/surf_logger.dart';

part 'ticket_storage_event.dart';

part 'ticket_storage_state.dart';

class TicketStorageBloc extends Bloc<TicketStorageEvent, TicketStorageState> {
  final TicketStorageRepository repository;

  TicketStorageBloc({required this.repository})
      : super(TicketStorageInitial()) {
    on<AddTicketEvent>((event, emit) => _addTicket(event, emit));
    on<GetTicketsEvent>((event, emit) => _getTickets(emit));
  }

  void _addTicket(AddTicketEvent event, Emitter emit) async {
    try {
      await repository.addTicket(event.ticket);
    } catch (e) {
      Logger.e('_getTickets error');
    }
  }

  void _getTickets(Emitter emit) async {
    var tickets = await repository.getTickets();
    emit(UploadTickets(tickets: tickets));
  }
}
