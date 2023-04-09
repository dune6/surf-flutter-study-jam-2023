part of 'ticket_storage_bloc.dart';

@immutable
abstract class TicketStorageEvent {}

class AddTicketEvent extends TicketStorageEvent {
  final Ticket ticket;

  AddTicketEvent(this.ticket);
}

class GetTicketsEvent extends TicketStorageEvent {}
