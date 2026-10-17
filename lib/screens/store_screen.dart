
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final controller = TextEditingController();

  final List<Product> produtos = [
    Product(nome: 'Arroz', preco: 5.00),
    Product(nome: 'Feijão', preco: 7.50),
    Product(nome: 'Macarrão', preco: 4.25),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Abrir carrinho',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => const CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Nome do produto personalizado',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final nome = controller.text.trim();

                if (nome.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Digite o nome do produto.'),
                    ),
                  );
                  return;
                }

                context.read<CartProvider>().addProduct(
                  Product(nome: nome, preco: 0.0),
                );

                controller.clear();
              },
              child: const Text('Adicionar produto personalizado'),
            ),
            const Divider(height: 30),
            const Text(
              'Produtos disponíveis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  final produto = produtos[index];

                  return ListTile(
                    title: Text(produto.nome),
                    subtitle: Text(
                      'R\$ ${produto.preco.toStringAsFixed(2)}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      tooltip: 'Adicionar ao carrinho',
                      onPressed: () {
                        context
                            .read<CartProvider>()
                            .addProduct(produto);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${produto.nome} adicionado ao carrinho!',
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              'Itens no carrinho: ${cart.totalItems}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const CartScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Ver carrinho'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
