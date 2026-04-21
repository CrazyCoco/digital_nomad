import 'package:flutter/material.dart';

/// 缺省页组件
/// 用于在列表或页面没有数据时显示
class EmptyStateView extends StatelessWidget {
  final String? message;
  final IconData icon;
  final double iconSize;
  final double iconColorOpacity;
  final double messageFontSize;
  final VoidCallback? onRetry;
  final String? retryButtonText;

  const EmptyStateView({
    super.key,
    this.message,
    this.icon = Icons.laptop,
    this.iconSize = 64,
    this.iconColorOpacity = 0.3,
    this.messageFontSize = 16,
    this.onRetry,
    this.retryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: const Color(0xFF42A5F5).withOpacity(iconColorOpacity),
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'No data available',
            style: TextStyle(
              fontSize: messageFontSize,
              color: const Color(0xFF42A5F5).withOpacity(0.6),
            ),
          ),
          if (onRetry != null && retryButtonText != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF42A5F5),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(retryButtonText!),
            ),
          ],
        ],
      ),
    );
  }
}
