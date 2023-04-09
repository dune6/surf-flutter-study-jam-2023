import 'package:surf_flutter_study_jam_2023/features/local_database/providers/sqlite_crud_provider.dart';
import 'package:surf_flutter_study_jam_2023/features/local_database/services/sqite_service.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/service/repository/ticket_srotage_repository.dart';

/// Singleton DI-container
class DIGlobalFactory {
  // singleton
  static final DIGlobalFactory _globalFactory = DIGlobalFactory._internal();

  factory DIGlobalFactory() => _globalFactory;

  DIGlobalFactory._internal();

  final SQLiteService _sqLiteService = SQLiteService();

  SQLiteCrudProvider _sqLiteCrudProvider() =>
      SQLiteCrudProvider(dbService: _sqLiteService);

  TicketStorageRepository ticketStorageRepository() =>
      TicketStorageRepository(_sqLiteCrudProvider());
}
