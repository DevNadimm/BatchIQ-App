import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:batchiq_app/core/utils/ui/icons_name.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/count_members_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/widgets/members_and_admin_container.dart';
import 'package:batchiq_app/features/admin_dashboard/widgets/admin_content_grid.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final memberCountController = MemberCountController.instance;

  @override
  initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await memberCountController.countMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Admin Dashboard",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(backArrow),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            height: 1.5,
          ),
        ),
      ),
      body: GetBuilder<MemberCountController>(builder: (controller) {
        return Visibility(
          visible: !controller.isLoading,
          replacement: const ProgressIndicatorWidget(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MembersAndAdminContainer(
                  students: controller.studentCount,
                  admins: controller.adminCount,
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Features",
                    style: Theme.of(context).textTheme.headlineSmall!,
                  ),
                ),
                const SizedBox(height: 16),
                const AdminContentGrid(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}
