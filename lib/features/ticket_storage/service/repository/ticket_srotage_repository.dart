import 'package:surf_flutter_study_jam_2023/features/local_database/providers/sqlite_crud_provider.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/ticket.dart';

/// Repository interface for working with tickets.
abstract class ITicketStorageRepository {
  /// Return user ticket.
  Future<List<Ticket>> getTickets();

  Future<void> addTicket(Ticket ticket);
}

/// Repository for working with a user profile by using [SQLiteCrudProvider].
class TicketStorageRepository implements ITicketStorageRepository {
  final SQLiteCrudProvider _dbProvider;

  TicketStorageRepository(this._dbProvider);

  @override
  Future<List<Ticket>> getTickets() async {
    final tickets = await _dbProvider.getTickets();
    return tickets.map((e) => Ticket.fromMap(e)).toList();
  }

  @override
  Future<void> addTicket(Ticket ticket) async {
    return _dbProvider.addTicket(ticket.toMap());
  }
}
