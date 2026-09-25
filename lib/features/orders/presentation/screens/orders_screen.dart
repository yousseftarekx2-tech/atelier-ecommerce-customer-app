import 'package:atelier_customer/core/routing/routes.dart';
import 'package:atelier_customer/features/orders/domain/entities/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubit/oeder_cubit.dart';
import '../../cubit/order_state.dart';
import '../../domain/entities/order.dart';
import '../../../cart/cubit/cart_cubit.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      context.read<OrdersCubit>().loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 76,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'ATELIER',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.5,
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<CartCubit, dynamic>(
            builder: (context, state) {
              final itemCount = context.read<CartCubit>().state.itemCount;

              return IconButton(
                onPressed: () => context.push('/cart'),
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_bag_outlined, size: 22),
                    if (itemCount > 0)
                      Positioned(
                        top: -5,
                        right: -6,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: Color(0xFF151515),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$itemCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is OrdersError && state.orders.isEmpty) {
              return _OrdersErrorView(
                message: state.message,
                onRetry: () {
                  context.read<OrdersCubit>().loadOrders();
                },
              );
            }

            final orders = state.orders;

            if (orders.isEmpty) {
              return const _EmptyOrdersView();
            }

            return RefreshIndicator(
              onRefresh: context.read<OrdersCubit>().loadOrders,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 672),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _OrdersHeader(),
                        const SizedBox(height: 24),
                        if (state is OrdersError)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _InlineErrorMessage(message: state.message),
                          ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orders.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return _OrderCard(order: orders[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OrdersHeader extends StatelessWidget {
  const _OrdersHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MY ORDERS',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: Color(0xFF8E8E8E),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Your purchases.',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            color: Color(0xFF151515),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Track your orders and revisit what you’ve bought.',
          style: TextStyle(fontSize: 12, color: Color(0xFF737373)),
        ),
      ],
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(Routes.orderDetailsPath(order.id));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE6E4E0)),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            _OrderHeader(order: order),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: Color(0xFFEEECE8)),
            ),
            _OrderProducts(order: order),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: Color(0xFFEEECE8)),
            ),
            _OrderFooter(order: order),
          ],
        ),
      ),
    );
  }
}

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ORDER ${order.orderNumber}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: Color(0xFF151515),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDate(order.createdAt),
                style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 1,
                  color: Color(0xFF8E8E8E),
                ),
              ),
            ],
          ),
        ),
        _StatusBadge(status: order.status),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F2),
        border: Border.all(color: const Color(0xFFE6E4E0)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.3,
          color: Color(0xFF151515),
        ),
      ),
    );
  }
}

class _OrderProducts extends StatelessWidget {
  const _OrderProducts({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final visibleItems = order.items.take(3).toList();

    return Row(
      children: [
        ...visibleItems.map(
          (item) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _ProductThumbnail(image: item.image),
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${order.items.length} ITEMS',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                    color: Color(0xFF151515),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _productNames(order.items),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF737373),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductThumbnail extends StatelessWidget {
  const _ProductThumbnail({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F2),
        border: Border.all(color: const Color(0xFFEEECE8)),
        borderRadius: BorderRadius.circular(9),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        image,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) {
          return const Icon(Icons.image_outlined, color: Color(0xFFAAAAAA));
        },
      ),
    );
  }
}

class _OrderFooter extends StatelessWidget {
  const _OrderFooter({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final canTrack = _canTrack(order.status);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TOTAL',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.1,
                  color: Color(0xFF8E8E8E),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'EGP ${order.total}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                  color: Color(0xFF151515),
                ),
              ),
            ],
          ),
        ),
        if (canTrack)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: OutlinedButton(
              onPressed: () {
                context.push(Routes.orderDetailsPath(order.id));
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 40),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                side: const BorderSide(color: Color(0xFFE6E4E0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'TRACK ORDER',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: Color(0xFF151515),
                ),
              ),
            ),
          ),
        TextButton(
          onPressed: () {
            context.push(Routes.orderDetailsPath(order.id));
          },
          style: TextButton.styleFrom(
            minimumSize: const Size(0, 40),
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'VIEW ORDER',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: Color(0xFF151515),
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 16, color: Color(0xFF151515)),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyOrdersView extends StatelessWidget {
  const _EmptyOrdersView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 48,
              color: Color(0xFF8E8E8E),
            ),
            const SizedBox(height: 20),
            const Text(
              'No orders yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your purchases will appear here once you place your first order.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF737373),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/shop');
                },
                child: const Text('Start Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrdersErrorView extends StatelessWidget {
  const _OrdersErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 48,
              color: Color(0xFF8E8E8E),
            ),
            const SizedBox(height: 20),
            const Text(
              'Couldn’t load your orders',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF737373),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: onRetry,
                child: const Text('Try Again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InlineErrorMessage extends StatelessWidget {
  const _InlineErrorMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F2),
        border: Border.all(color: const Color(0xFFE6E4E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 12, color: Color(0xFF737373)),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  const months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];

  return '${months[date.month - 1]} '
      '${date.day.toString().padLeft(2, '0')}, '
      '${date.year}';
}

String _productNames(List<OrderItem> items) {
  return items.map((item) => item.productName).join(', ');
}

bool _canTrack(String status) {
  return status == 'Confirmed' ||
      status == 'Shipped' ||
      status == 'Out for Delivery';
}
