import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubit/oeder_cubit.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../../../core/routing/routes.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Future<Order?> _orderFuture;

  @override
  void initState() {
    super.initState();
    _orderFuture = context.read<OrdersCubit>().getOrderById(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Order?>(
      future: _orderFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const _OrderNotFoundView();
        }

        final order = snapshot.data;

        if (order == null) {
          return const _OrderNotFoundView();
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            title: const Text('ATELIER'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => context.push(Routes.cart),
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 48),
              children: [
                _OrderHeader(order: order),
                const SizedBox(height: 24),

                _OrderStatusCard(order: order),
                const SizedBox(height: 24),

                _SectionTitle(
                  title: 'ITEMS IN THIS ORDER',
                  trailing: '${order.items.length}',
                ),
                const SizedBox(height: 10),
                _OrderItemsCard(items: order.items),
                const SizedBox(height: 24),

                const _SectionTitle(title: 'DELIVERY & ADDRESS'),
                const SizedBox(height: 10),
                _DeliveryCard(order: order),
                const SizedBox(height: 24),

                const _SectionTitle(title: 'PAYMENT'),
                const SizedBox(height: 10),
                _PaymentCard(order: order),
                const SizedBox(height: 24),

                const _SectionTitle(title: 'ORDER SUMMARY'),
                const SizedBox(height: 10),
                _OrderSummary(order: order),
                const SizedBox(height: 28),

                OutlinedButton(
                  onPressed: () => context.go(Routes.home),
                  child: const Text('CONTINUE SHOPPING'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'ORDER DETAILS',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            _StatusBadge(status: order.status),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Order ${order.orderNumber}',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Placed on ${_formatDate(order.createdAt)} · '
          '${order.items.length} ${order.items.length == 1 ? 'item' : 'items'}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _OrderStatusCard extends StatelessWidget {
  const _OrderStatusCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final currentStep = _statusStep(order.status);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.status.toUpperCase(),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _statusDescription(order.status),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(_statusIcon(order.status), size: 17),
                ),
              ],
            ),
            const SizedBox(height: 22),
            _StatusTimeline(currentStep: currentStep),
          ],
        ),
      ),
    );
  }
}

class _StatusTimeline extends StatelessWidget {
  const _StatusTimeline({required this.currentStep});

  final int currentStep;

  static const _steps = [
    'Placed',
    'Confirmed',
    'Shipped',
    'Out for Delivery',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(_steps.length, (index) {
            final isCompleted = index <= currentStep;
            final isCurrent = index == currentStep;

            return Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (index < _steps.length - 1)
                    Positioned(
                      left: 10,
                      right: 0,
                      top: 10,
                      child: Container(
                        height: 2,
                        color: index < currentStep
                            ? colorScheme.onSurface
                            : colorScheme.outlineVariant,
                      ),
                    ),
                  Column(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? colorScheme.onSurface
                              : colorScheme.surface,
                          border: Border.all(
                            color: isCompleted
                                ? colorScheme.onSurface
                                : colorScheme.outlineVariant,
                            width: 1.5,
                          ),
                          boxShadow: isCurrent
                              ? [
                                  BoxShadow(
                                    color: colorScheme.onSurface.withValues(
                                      alpha: 0.12,
                                    ),
                                    blurRadius: 0,
                                    spreadRadius: 4,
                                  ),
                                ]
                              : null,
                        ),
                        child: isCompleted
                            ? Icon(
                                Icons.check_rounded,
                                size: 12,
                                color: colorScheme.surface,
                              )
                            : null,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        _steps[index],
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: isCurrent
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isCompleted
                              ? colorScheme.onSurface
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class _OrderItemsCard extends StatelessWidget {
  const _OrderItemsCard({required this.items});

  final List<OrderItem> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _OrderItemTile(item: items[index]),
            if (index != items.length - 1)
              const Divider(height: 1, indent: 16, endIndent: 16),
          ],
        ],
      ),
    );
  }
}

class _OrderItemTile extends StatelessWidget {
  const _OrderItemTile({required this.item});

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 64,
              height: 80,
              child: Image.network(
                item.image,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return ColoredBox(
                    color: colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.image_not_supported_outlined),
                  );
                },
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  }

                  return ColoredBox(
                    color: colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 1.5),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _itemVariant(item),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Qty: ${item.quantity}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Text(
                      _formatPrice(item.totalPrice),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final address = order.shippingAddress;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoLabel(label: 'SHIPPING METHOD'),
            const SizedBox(height: 7),
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.shippingMethod,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  _formatPrice(order.shippingCost),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 14),
            _InfoLabel(label: 'DELIVERY ADDRESS'),
            const SizedBox(height: 7),
            Text(
              address.fullName,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              [
                address.street,
                address.city,
                address.phone,
              ].where((value) => value.trim().isNotEmpty).join('\n'),
              style: theme.textTheme.bodySmall?.copyWith(
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                size: 17,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.paymentMethod,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _paymentDescription(order.paymentMethod),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (_isCompletedPayment(order.status)) const _PaymentStatusBadge(),
          ],
        ),
      ),
    );
  }
}

class _PaymentStatusBadge extends StatelessWidget {
  const _PaymentStatusBadge();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'COMPLETED',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SummaryRow(label: 'Subtotal', value: _formatPrice(order.subtotal)),
            const SizedBox(height: 10),
            _SummaryRow(
              label: 'Shipping',
              value: _formatPrice(order.shippingCost),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Total',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  _formatPrice(order.total),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                'Payment: ${order.paymentMethod}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}

class _InfoLabel extends StatelessWidget {
  const _InfoLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.9,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _OrderNotFoundView extends StatelessWidget {
  const _OrderNotFoundView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ATELIER'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.receipt_long_outlined, size: 42),
              const SizedBox(height: 16),
              Text(
                'Order not found.',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'This order may no longer be available.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int _statusStep(String status) {
  switch (status.toLowerCase()) {
    case 'confirmed':
      return 1;
    case 'shipped':
      return 2;
    case 'out for delivery':
      return 3;
    case 'delivered':
      return 4;
    case 'cancelled':
      return 0;
    case 'placed':
    default:
      return 0;
  }
}

String _statusDescription(String status) {
  switch (status.toLowerCase()) {
    case 'confirmed':
      return 'Your order has been confirmed and is being prepared.';
    case 'shipped':
      return 'Your order has been handed over for delivery.';
    case 'out for delivery':
      return 'Your order is on its way to you.';
    case 'delivered':
      return 'Your order was delivered successfully.';
    case 'cancelled':
      return 'This order has been cancelled.';
    case 'placed':
    default:
      return 'Your order has been placed successfully.';
  }
}

IconData _statusIcon(String status) {
  switch (status.toLowerCase()) {
    case 'confirmed':
      return Icons.inventory_2_outlined;
    case 'shipped':
      return Icons.local_shipping_outlined;
    case 'out for delivery':
      return Icons.delivery_dining_outlined;
    case 'delivered':
      return Icons.check_rounded;
    case 'cancelled':
      return Icons.close_rounded;
    case 'placed':
    default:
      return Icons.receipt_long_outlined;
  }
}

String _itemVariant(OrderItem item) {
  final variants = <String>[
    if (item.color.trim().isNotEmpty) item.color,
    if (item.size.trim().isNotEmpty) 'Size ${item.size}',
  ];

  return variants.join(' · ');
}

bool _isCompletedPayment(String status) {
  return status.toLowerCase() == 'delivered';
}

String _paymentDescription(String paymentMethod) {
  if (paymentMethod.toLowerCase().contains('cash')) {
    return 'Paid upon doorstep delivery';
  }

  return 'Payment method used for this order';
}

String _formatPrice(int value) {
  return 'EGP ${_formatNumber(value)}';
}

String _formatNumber(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write(',');
    }

    buffer.write(digits[i]);
  }

  return buffer.toString();
}

String _formatDate(DateTime date) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}
