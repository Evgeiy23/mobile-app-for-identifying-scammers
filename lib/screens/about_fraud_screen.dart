import 'package:flutter/material.dart';

/// Виджет для отображения информации в виде карточки с заголовком и списком пунктов
class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;
  final Color? backgroundColor;
  final Color? iconColor;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.items,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor ?? Theme.of(context).primaryColor, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...List.generate(
              items.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: iconColor ?? Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        items[index],
                        style: const TextStyle(fontSize: 17, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutFraudScreen extends StatefulWidget {
  const AboutFraudScreen({super.key});

  @override
  State<AboutFraudScreen> createState() => _AboutFraudScreenState();
}

class _AboutFraudScreenState extends State<AboutFraudScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    
    // Добавляем слушатель для обновления UI при изменении вкладки
    _tabController.addListener(() {
      // Вызываем setState для обновления UI при изменении индекса
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  // Метод для создания карточки категории
  Widget _buildCategoryCard(int index, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
      },
      child: Container(
        width: 110,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: _tabController.index == index ? color : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: _tabController.index == index ? Colors.white : color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: _tabController.index == index ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'ikonka.jpeg',
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 8),
            const Text('Anti-Fraud AI'),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Красивые категории в виде карточек
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryCard(0, 'Защита', Icons.security, Colors.blue.shade700),
                _buildCategoryCard(1, 'Типы', Icons.warning_amber_rounded, Colors.orange.shade700),
                _buildCategoryCard(2, 'Риски', Icons.dangerous, Colors.red.shade700),
                _buildCategoryCard(3, 'Выявление', Icons.search, Colors.green.shade700),
                _buildCategoryCard(4, 'Противостояние', Icons.gavel, Colors.purple.shade700),
              ],
            ),
          ),
          // Содержимое выбранной категории
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                _buildProtectionSection(),
                _buildFraudTypesSection(),
                _buildRisksSection(),
                _buildRecognitionSection(),
                _buildActionsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProtectionSection() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            _InfoCard(
              title: 'Защита от мошенничества',
              icon: Icons.security,
              backgroundColor: Color.fromARGB(255, 133, 173, 202),
              iconColor: Color.fromARGB(255, 24, 120, 216),
              items: [
                'Будьте бдительны и сомневайтесь в слишком выгодных предложениях',
                'Не разглашайте личную и финансовую информацию посторонним лицам',
                'Регулярно обновляйте программное обеспечение и антивирусы для защиты устройств',
                'Используйте надежные пароли и двухфакторную аутентификацию',
                'Проверяйте источники информации и контактные данные перед совершением транзакций',
                'Изучайте отзывы и рекомендации о компаниях и онлайн-сервисах',
                'Избегайте кликов по подозрительным ссылкам в сообщениях и письмах',
                'Сообщайте о подозрительной активности в соответствующие службы и правоохранительные органы',
                'Ознакомьтесь с последними методами мошенничества для своевременного реагирования',
                'Пользуйтесь безопасными способами оплаты и зашифрованными соединениями',
              ],
            ),
          ],
        ),
      );

  Widget _buildFraudTypesSection() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            _InfoCard(
              title: 'Типы мошенничества',
              icon: Icons.warning_amber_rounded,
              items: [
                'Фишинг – мошенники рассылают поддельные письма или SMS, выдавая себя за надёжные организации, чтобы выманить личные данные',
                'Интернет-мошенничество – обман через поддельные интернет-магазины, аукционы или объявления с целью получения денежных средств',
                'Инвестиционные мошенничества – схемы, обещающие высокую прибыль, такие как финансовые пирамиды и фальшивые инвестиционные проекты',
                'Телефонное мошенничество – звонки, где злоумышленники используют угрозы или манипуляции, чтобы заставить вас перевести деньги или предоставить информацию',
                'Лотерейные мошенничества – уведомления о якобы выигранных призах, при этом требующие предварительную оплату сборов или налогов',
                'Мошенничество с кредитными картами – кража или подделка данных карты для несанкционированных транзакций',
                'Мошенничество с недвижимостью – обман при аренде или покупке недвижимости, часто с использованием поддельных документов',
                'Мошенничество в социальных сетях – романтические аферы или фальшивые профили, цель которых — выманить деньги или конфиденциальную информацию',
                'Мошенничество с благотворительностью – сбор средств на фальшивые благотворительные проекты, часто после крупных катастроф или кризисов',
                'Мошенничество с поддельными документами – изготовление фальшивых удостоверений, лицензий или сертификатов для получения выгоды',
              ],
            ),
          ],
        ),
      );

  Widget _buildRisksSection() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            _InfoCard(
              title: 'Риски мошенничества',
              icon: Icons.dangerous,
              items: [
                'Финансовые потери – утрата денежных средств, сбережений и инвестиций',
                'Кража личных данных – утечка конфиденциальной информации, которая может быть использована для дальнейших мошеннических схем',
                'Репутационные риски – снижение доверия со стороны клиентов, партнеров и общественности',
                'Юридические последствия – возможное привлечение к ответственности и наложение штрафов',
                'Эмоциональный стресс – психологическое давление, тревога и снижение качества жизни',
                'Нарушение безопасности – компрометация устройств и систем, потеря контроля над данными',
                'Повреждение кредитной истории – ухудшение финансового положения и снижение кредитного рейтинга',
                'Расходы на восстановление – затраты на ликвидацию последствий мошеннических действий',
                'Социальные последствия – изоляция, потеря доверия в социуме и негативное влияние на отношения',
                'Прочие риски – непредвиденные последствия, влияющие на личное и профессиональное благополучие',
              ],
            ),
          ],
        ),
      );

  Widget _buildRecognitionSection() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            _InfoCard(
              title: 'Как распознать мошенников',
              icon: Icons.search,
              items: [
                'Непрошенные обращения, когда вас связывают без явной причины или запроса',
                'Давление и требование немедленных действий, создающее искусственную срочность',
                'Слишком выгодные предложения, которые кажутся нереальными или обещают гарантированный доход',
                'Ошибки в тексте сообщений, включая грамматические и орфографические ошибки',
                'Отсутствие или неправильное указание контактных данных и информации о компании',
                'Запрос конфиденциальной или финансовой информации без достаточных оснований',
                'Отсутствие официальных документов или прозрачных условий сделки',
                'Наличие подозрительных ссылок, вложений или программ, которые могут содержать вирусы',
                'Противоречивая или неясная информация о предлагаемых услугах или товарах',
                'Убеждение, что информация должна оставаться конфиденциальной и не подлежит проверке',
              ],
            ),
          ],
        ),
      );

  Widget _buildActionsSection() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            _InfoCard(
              title: 'Действия против мошенничества',
              icon: Icons.gavel,
              items: [
                'Сохраните все доказательства мошенничества – документы, переписки и скриншоты',
                'Сообщите о факте мошенничества в правоохранительные органы',
                'Обратитесь в банк или платежную систему для блокировки операций и защиты счетов',
                'Уведомите онлайн-платформы или сервисы о мошеннических действиях',
                'Измените пароли и настройте двухфакторную аутентификацию для защиты аккаунтов',
                'Проверьте и обновите антивирусное ПО и систему безопасности устройств',
                'Обратитесь за консультацией к юристу для защиты своих прав',
                'Заблокируйте компрометированные счета, карты или аккаунты',
                'Распространяйте информацию о мошенниках, предупреждая знакомых и коллег',
                'Следите за новостями в сфере информационной безопасности для своевременного реагирования',
              ],
            ),
          ],
        ),
      );
}
