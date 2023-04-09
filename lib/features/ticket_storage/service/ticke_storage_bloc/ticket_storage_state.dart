part of 'ticket_storage_bloc.dart';

@immutable
abstract class TicketStorageState {}

class TicketStorageInitial extends TicketStorageState {}

class UploadTickets extends TicketStorageState {
  List<Ticket> tickets;

  UploadTickets({required this.tickets});
}
