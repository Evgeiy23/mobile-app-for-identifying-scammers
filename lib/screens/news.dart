import 'package:flutter/material.dart';
import 'package:antifraud_ai/menu.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyMenu(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Меню',
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Новости', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade100,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNewsCard(
            'Фишинг и социальная инженерия',
            'Мошенники рассылают поддельные электронные письма, SMS или сообщения в мессенджерах, выдавая себя за представителей банков, государственных учреждений или популярных сервисов. Такие сообщения часто содержат предупреждения о якобы возникших проблемах с аккаунтом или подозрительной активности.',
          ),
          _buildNewsCard(
            'Телефонное мошенничество',
            'Мошенники звонят жертвам, представляясь сотрудниками банков, налоговых органов или других официальных учреждений, требуя перевода средств или предоставления конфиденциальной информации.',
          ),
          _buildNewsCard(
            'Онлайн-магазины и мошеннические площадки',
            'Создаются фальшивые интернет-магазины, которые на первый взгляд выглядят как надежные и профессиональные торговые площадки. После оплаты заказа товар либо не доставляется, либо оказывается поддельным.',
          ),
          _buildNewsCard(
            'Мошенничество с использованием deepfake и ИИ',
            'Технологии deepfake позволяют создавать поддельные видеоролики и аудиозаписи, в которых, например, голос или образ известного человека используется для обмана.',
          ),
          _buildNewsCard(
            'Мошенничество с криптовалютами',
            'Появление и популяризация криптовалют привели к возникновению множества схем, обещающих высокую прибыль за короткий срок. Мошенники создают поддельные ICO (Initial Coin Offerings) и криптобиржи, привлекая неопытных инвесторов.',
          ),
          _buildNewsCard(
            'Мошенничество в социальных сетях',
            'Злоумышленники создают фейковые аккаунты известных личностей, инфлюенсеров или даже официальных страниц компаний. Они активно используют доверие аудитории для продвижения сомнительных предложений, розыгрышей или акций.',
          ),
          _buildNewsCard(
            'Инвестиционные схемы за пределами криптовалют',
            'Мошенники предлагают вложения в «перспективные» проекты — от недвижимости до стартапов или сельскохозяйственных предприятий, обещая завышенные доходы за короткий период.',
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        backgroundColor: Colors.blue.shade50,
        collapsedBackgroundColor: Colors.white,
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              content,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
