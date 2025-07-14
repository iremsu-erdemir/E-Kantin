import 'package:flutter/material.dart';

class EKBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final BuildContext? parentContext;

  const EKBottomNavBar({Key? key, this.currentIndex = 0, this.parentContext})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctx = parentContext ?? context;
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIcon(ctx, 0, Icons.home_outlined),
              _buildIcon(ctx, 1, Icons.favorite_border),
              _buildIcon(ctx, 2, Icons.receipt_long),
              _buildIcon(ctx, 3, Icons.inventory_2_outlined),
              _buildIcon(ctx, 4, Icons.person_outline),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              5,
              (i) => AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 32,
                height: 6,
                decoration: BoxDecoration(
                  color: currentIndex == i ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext ctx, int index, IconData icon) {
    Color color = currentIndex == index ? Color(0xFFFF3D3D) : Colors.grey;
    return IconButton(
      icon: Icon(icon, color: color, size: 32),
      onPressed: () {
        if (index == 0) {
          Navigator.pushReplacementNamed(
            ctx,
            '/homepage',
          ); // HomePage'e yönlendir
        } else if (index == 1) {
          Navigator.pushReplacementNamed(ctx, '/favorilerim');
        } else if (index == 2) {
          Navigator.pushReplacementNamed(ctx, '/siparisler');
        } else if (index == 3) {
          Navigator.pushReplacementNamed(ctx, '/sepetim');
        } else if (index == 4) {
          Navigator.pushReplacementNamed(ctx, '/profil');
        }
      },
    );
  }
}
