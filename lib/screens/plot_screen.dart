import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/vehicle.dart';
import '../controllers/gas_record_controller.dart';
import '../widgets/mileage_plot.dart';
import '../widgets/odometer_plot.dart';
import '../widgets/gallons_plot.dart';
import '../widgets/cost_plot.dart';
import '../widgets/price_plot.dart';

class PlotScreen extends StatefulWidget {
  final Vehicle vehicle;

  const PlotScreen({super.key, required this.vehicle});

  @override
  State<PlotScreen> createState() => _PlotScreenState();
}

class _PlotScreenState extends State<PlotScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late GasRecordController _controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _controller = Get.put(GasRecordController());
    final id = widget.vehicle.id;
    if (id != null) _controller.loadRecords(id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.plot),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: l10n.mileagePlot),
            Tab(text: l10n.odometerPlot),
            Tab(text: l10n.gallonsPlot),
            Tab(text: l10n.costPlot),
            Tab(text: l10n.pricePlot),
          ],
        ),
      ),
      body: Obx(() {
        if (_controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.records.isEmpty) {
          return Center(
            child: Text(
              l10n.noRecords,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        return TabBarView(
          controller: _tabController,
          children: [
            MileagePlotWidget(records: _controller.records, unit: _controller.selectedUnit),
            OdometerPlotWidget(records: _controller.records),
            GallonsPlotWidget(records: _controller.records),
            CostPlotWidget(records: _controller.records),
            PricePlotWidget(records: _controller.records),
          ],
        );
      }),
    );
  }
}
