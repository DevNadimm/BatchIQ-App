import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/helper/helper_functions.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/my_calendar_event_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/my_calendar_event_model.dart';
import 'package:batchiq_app/shared/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class TimelineEventCard extends StatelessWidget {
  final MyCalendarEventModel event;
  final bool isAdmin;

  const TimelineEventCard(
      {super.key, required this.event, required this.isAdmin});

  Widget _buildFormattedDate(String date) {
    final dateParts = date.split(' ');
    if (dateParts.length < 3) {
      return Text(date);
    }
    String month = dateParts[0];
    String day = dateParts[1].replaceAll(',', '');
    String year = dateParts[2];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$month $day',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          year,
          style: TextStyle(
            fontSize: 13,
            color: secondaryFontColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormattedDate(event.date),
            const SizedBox(width: 16),
            Expanded(
              child: Card(
                margin: EdgeInsets.zero,
                color: HelperFunctions.getEventTypeColor(event.eventType, event.date).withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: HelperFunctions.getEventTypeColor(event.eventType, event.date),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              HelperFunctions.getEventStatus(event.date).toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          if (isAdmin)
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DeleteDialog(
                                    onTap: () {
                                      deleteAssignment();
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                              icon: const Icon(
                                HugeIcons.strokeRoundedDelete02,
                                color: Colors.red,
                                size: 18,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteAssignment() async {
    final controller = MyCalendarEventController.instance;
    final isDelete = await controller.deleteEvent(event.id);
    if (isDelete) {
      SnackBarMessage.successMessage("Your event has been deleted successfully!");
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }
}
