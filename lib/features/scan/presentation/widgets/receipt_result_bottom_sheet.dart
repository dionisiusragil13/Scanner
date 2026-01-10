import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scanner/core/di/injection_container.dart';
import 'package:scanner/features/expenses/domain/usecase/add_expense_use_case.dart';
import 'package:scanner/features/scan/domain/entities/scan_result_entity.dart';

class ReceiptResultBottomSheet extends StatelessWidget {
  final ScanResultEntity scanResult;

  const ReceiptResultBottomSheet({
    super.key,
    required this.scanResult,
  });

  @override
  Widget build(BuildContext context) {
    // 🔥 AMBIL DARI GET IT
    final addExpenseUseCase = sl<AddExpenseUseCase>();

    Future<void> _onSave() async {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await addExpenseUseCase(
        userId: userId,
        total: scanResult.total,
        date: scanResult.date,
        merchant: scanResult.merchant,
        imageUrl: scanResult.imageUrl,
      );

      Navigator.pop(context);
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hasil Scan",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            Text("Merchant: ${scanResult.merchant}"),
            Text("Total: ${scanResult.total}"),
            Text("Tanggal: ${scanResult.date.toLocal()}"),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _onSave,
              child: const Text("Simpan Pengeluaran"),
            ),
          ],
        ),
      ),
    );
  }
}
