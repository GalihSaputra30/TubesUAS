import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart' show CalendarFormat, TableCalendar, isSameDay;
import 'package:intl/intl.dart';
import 'package:calendar_event/func_/func_add.dart';
import 'package:calendar_event/func_/func_list_note.dart';

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({Key? key}) : super(key: key);
  
  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  Map<String, List> mySelectedEvents = {};
  List<ListCloud> data = <ListCloud>[];
  final titleController = TextEditingController();
  final descpController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
    ListCloud(id_note: toString(), tanggal: toString(), judul: toString(), deskripsi: toString());

    loadPreviousEvents();
  }

  loadPreviousEvents() {
    ListCloud(id_note: toString(), tanggal: toString(), judul: toString(), deskripsi: toString());
    mySelectedEvents = {
      "2023-01-22": [
        {"eventDescp": "Libur", "eventTitle": "Tahun Baru Imlek"},
      ],
      "2023-01-23": [
        {"eventDescp": "Libur Juga Dong", "eventTitle": "Lunar New Year"}
      ],
      "2023-01-24": [
        {"eventTitle": "UAS", "eventDescp": "Ujian Bhs.Indonesia"}
      ]
    };
  }

  

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }
  

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Tambahkan Acara',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Judul',
              ),
            ),
            TextField(
              controller: descpController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            child: const Text('Tambahkan'),
            onPressed: () {
                if (titleController.text.isEmpty &&
                  descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required title and description'),
                    duration: Duration(seconds: 2),
                  ),
                );
                //Navigator.pop(context);
                return;
              } else {
                print(titleController.text);
                print(descpController.text);

                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      "eventTitle": titleController.text,
                      "eventDescp": descpController.text,
                    });
                  } else {
                    mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        "eventTitle": titleController.text,
                        "eventDescp": descpController.text,
                      }
                    ];
                  }
                });

                print(
                    "New Event for backend developer ${json.encode(mySelectedEvents)}");
                titleController.clear();
                descpController.clear();
                Navigator.pop(context);
                return;
              }
              },
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('KALENDER'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2023),
            lastDay: DateTime(2024),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
            eventLoader: _listOfDayEvents,
          ),
          ..._listOfDayEvents(_selectedDate!).map(
            (myEvents) => ListTile(
              leading: const Icon(
                Icons.done,
                color: Colors.teal,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Judul:   ${myEvents['eventTitle']}'),
              ),
              subtitle: Text('Deskripsi:   ${myEvents['eventDescp']}'),
            ),
            
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Tambahkan'),
        icon: Icon(Icons.edit),
      ),
    );
  }
}
