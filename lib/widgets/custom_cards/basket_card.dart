import 'package:minimart/utils/colors.dart';
import 'package:flutter/material.dart';

class BasketCard extends StatefulWidget {
  const BasketCard(
      {super.key,
      required this.product,
      required this.onMinus,
      required this.onPlus});
  final Map<String, dynamic> product;
  final VoidCallback onPlus;
  final VoidCallback onMinus;

  @override
  State<BasketCard> createState() => _BasketCardState();
}

class _BasketCardState extends State<BasketCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 84,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: primaryColor.withOpacity(0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          Container(
            margin: const EdgeInsets.all(8),
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(widget.product["imgPath"], fit: BoxFit.contain),
          ),
          const SizedBox(width: 4),
          // Info
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product["name"],
                  style: TextStyle(
                      fontSize: 13,
                      color: textColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.product["details"] ?? '',
                  style: TextStyle(fontSize: 10, color: subTextColor),
                ),
                const SizedBox(height: 3),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: widget.product["totalPrice"].toString(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  TextSpan(
                    text: " IQD",
                    style: TextStyle(fontSize: 10, color: subTextColor),
                  )
                ])),
              ],
            ),
          ),
          // Quantity controls
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                _QtyButton(
                  icon: Icons.remove,
                  onTap: widget.onMinus,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.product["quantity"].toString(),
                    style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _QtyButton(
                  icon: Icons.add,
                  onTap: widget.onPlus,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          gradient: primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.35),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black, size: 16),
      ),
    );
  }
}








