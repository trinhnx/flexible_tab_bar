import 'package:flutter/material.dart';
import 'package:flexible_tab_bar/flexible_tab_bar.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlexibleTabBar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _selectedIndex2 = 0;
  int _selectedIndex3 = 0;

  final List<Coin> _coins = const [
    Coin('BTC', Icons.currency_bitcoin, Colors.amber),
    Coin('ETH', Icons.currency_bitcoin, Colors.blue),
    Coin('SOL', Icons.currency_bitcoin, Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text('FlexibleTabBar Demo'),
        backgroundColor: const Color(0xFF0A0A0A),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Section 1: Basic usage with icons + labels ---
          const Text(
            'Basic (count badges)',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 8),
          FlexibleTabBar(
            tabs: const [
              FlexibleTab(label: 'Crypto', icon: Icon(Icons.currency_bitcoin), count: 3),
              FlexibleTab(label: 'Commodity', icon: Icon(Icons.emoji_events), count: 1),
              FlexibleTab(label: 'Stocks', icon: Icon(Icons.candlestick_chart), count: 7),
            ],
            selectedIndex: _selectedIndex,
            onTabChanged: (i) => setState(() => _selectedIndex = i),
            activeColor: Colors.orange,
            inactiveColor: Colors.grey,
          ),
          const SizedBox(height: 24),

          // --- Section 2: Minimal (no badges, no dividers) ---
          const Text(
            'Minimal (no dividers, no badges)',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 8),
          FlexibleTabBar(
            tabs: const [
              FlexibleTab(label: 'Day', icon: Icon(Icons.wb_sunny_outlined)),
              FlexibleTab(label: 'Week', icon: Icon(Icons.date_range)),
              FlexibleTab(label: 'Month', icon: Icon(Icons.calendar_month_outlined)),
              FlexibleTab(label: 'Year', icon: Icon(Icons.event)),
            ],
            selectedIndex: _selectedIndex2,
            onTabChanged: (i) => setState(() => _selectedIndex2 = i),
            activeColor: Colors.teal,
            showDivider: false,
          ),
          const SizedBox(height: 24),

          // --- Section 3: Always show labels, custom styling ---
          const Text(
            'Always show labels + custom style',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 8),
          FlexibleTabBar(
            tabs: const [
              FlexibleTab(label: 'Bitcoin', icon: Icon(Icons.currency_bitcoin)),
              FlexibleTab(label: 'Ethereum', icon: Icon(Icons.currency_bitcoin)),
              FlexibleTab(label: 'Solana', icon: Icon(Icons.currency_bitcoin)),
            ],
            selectedIndex: _selectedIndex3,
            onTabChanged: (i) => setState(() => _selectedIndex3 = i),
            activeColor: Colors.deepPurple,
            alwaysShowLabel: true,
            animationDuration: const Duration(milliseconds: 500),
            borderRadius: BorderRadius.circular(20),
          ),
          const SizedBox(height: 32),

          // --- Selected tab content ---
          Text(
            'Selected: ${_coinLabel(_selectedIndex)}',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 16),
          _buildCoinCards(),
        ],
      ),
    );
  }

  String _coinLabel(int index) {
    switch (index) {
      case 0:
        return 'Crypto — BTC \$67,432';
      case 1:
        return 'Commodity — Gold \$2,341';
      case 2:
        return 'Stocks — AAPL \$178';
      default:
        return '';
    }
  }

  Widget _buildCoinCards() {
    return Column(
      children: _coins.map((coin) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(coin.icon, color: coin.color, size: 32),
              const SizedBox(width: 12),
              Text(
                coin.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '\$${(coin.name.hashCode % 100000).toString()}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class Coin {
  final String name;
  final IconData icon;
  final Color color;
  const Coin(this.name, this.icon, this.color);
}
