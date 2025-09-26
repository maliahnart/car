import 'package:car/models/parking_lot.dart';
import 'package:flutter/material.dart';
class ParkingLotCard extends StatelessWidget {
  final ParkingLot lot;
  final VoidCallback? onTap;
  const ParkingLotCard({super.key, required this.lot,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        color: Colors.white,
        child: Column(
          children: [
            // Image.network( 
            //   lot.imageUrl,
            //   height: 150,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            //   loadingBuilder: (context, child, loadingProgress) {
            //     if (loadingProgress == null) return child;
            //     return const SizedBox(
            //       height: 150,
            //       child: Center(child: CircularProgressIndicator()),
            //     );
            //   },
            //   errorBuilder: (context, error, stackTrace) => 
            //     const SizedBox(height: 150, child: Icon(Icons.error)),
            // ),
            Image.asset('assets/images/baidoxe.jpg'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(lot.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.grey.shade600, size: 18),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            lot.addrDetail,
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}