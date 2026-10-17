
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho (${cart.totalItems})'),
      ),

      body: Column(
        children: [
          Expanded(
            child: cart.products.isEmpty
                ? const Center(
                    child: Text(
                      'Seu carrinho está vazio.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.products.length,
                    itemBuilder: (context, index) {
                      final produto = cart.products[index];

                      return ListTile(
                        title: Text(produto.nome),

                        subtitle: Text(
                          'R\$ ${produto.preco.toStringAsFixed(2)}',
                        ),

                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          tooltip: 'Remover produto',
                          onPressed: () {
                            context
                                .read<CartProvider>()
                                .removeProduct(index);
                          },
                        ),
                      );
                    },
                  ),
          ),

          const Divider(height: 1),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Total: R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cart.products.isEmpty
                        ? null
                        : () {
                            context
                                .read<CartProvider>()
                                .clearCart();
                          },
                    child: const Text('Limpar carrinho'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
