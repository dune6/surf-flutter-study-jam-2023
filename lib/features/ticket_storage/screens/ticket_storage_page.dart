import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surf_flutter_study_jam_2023/assets/strings/ticket_storage_strings.dart';
import 'package:surf_flutter_study_jam_2023/features/app/di/DIGlobalFactory.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/ticket.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/service/ticke_storage_bloc/ticket_storage_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/widgets/ticket_widget.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Экран “Хранения билетов”.
class TicketStoragePage extends StatefulWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  static Widget create() {
    return BlocProvider(
      create: (_) => TicketStorageBloc(
          repository: DIGlobalFactory().ticketStorageRepository()),
      lazy: false,
      child: const TicketStoragePage(),
    );
  }

  @override
  State<TicketStoragePage> createState() => _TicketStoragePageState();
}

class _TicketStoragePageState extends State<TicketStoragePage> {
  String _url = '';
  late final TextEditingController _controller =
      TextEditingController(text: '');
  List<Ticket> tickets = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(TicketStorageStrings.appBarTitle),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            // Берём возможную скопированную ссылку
            ClipboardData? cdata =
                await Clipboard.getData(Clipboard.kTextPlain);
            _url = cdata?.text ?? '';
            if (validation(_url)) {
              snackBar(context, _url);
            } else {
              snackBar(context, '');
            }
          },
          label: const Text(TicketStorageStrings.floatingActionButtonTitle),
        ),
        body: BlocListener<TicketStorageBloc, TicketStorageState>(
          listener: (context, state) {
            if (state is UploadTickets) {
              tickets = state.tickets;
              setState(() {});
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.separated(
                      itemCount: tickets.length,
                      separatorBuilder: (_, index) => const Divider(
                        height: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return TicketWidget(
                          ticket: tickets[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  /// функция про проверки валидации
  bool validation(String copyText) {
    if (copyText == '') return false;
    const urlPattern =
        r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    if (RegExp(urlPattern, caseSensitive: false).hasMatch(copyText) &&
        copyText.endsWith('.pdf')) {
      _controller.text = copyText;
      return true;
    } else {
      Logger.e('Validation error');
      return false;
    }
  }

  void snackBar(BuildContext context, String copyText) {
    // проверка валидности ссылки

    if (copyText == '') {
    } else {
      validation(copyText);
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            height: 200.0,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: TicketStorageStrings.inputUrl,
                        filled: true,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        errorText: TicketStorageStrings.errorTypedUrl,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var isValid = validation(_controller.text);
                      if (isValid) {
                        try {
                          BlocProvider.of<TicketStorageBloc>(context).add(
                              AddTicketEvent(Ticket(
                                  name:
                                      '${tickets.last.name} ${_controller.text.hashCode.toString().substring(1, 3)}',
                                  pdfFileName: _controller.text,
                                  isLoaded: false)));
                        } catch (e) {
                          Logger.e(e.toString());
                        }
                      } else {
                        Logger.e(_controller.text);
                      }
                      _controller.clear();
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepPurpleAccent)),
                    child: const Text(
                      TicketStorageStrings.floatingActionButtonTitle,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
