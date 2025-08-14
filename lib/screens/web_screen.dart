import 'package:flutter/material.dart';
import 'package:customer_loyalty/utils/colors.dart';
import 'package:customer_loyalty/widgets/text_widget.dart';
import 'package:customer_loyalty/widgets/button_widget.dart';
import 'package:customer_loyalty/widgets/touchable_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  WebScreenState createState() => WebScreenState();
}

class WebScreenState extends State<WebScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late final ScrollController _scrollController;
  bool _showBackToTop = false;

  // Section keys for smooth scroll navigation
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _platformKey = GlobalKey();
  final GlobalKey _benefitsKey = GlobalKey();
  final GlobalKey _loyaltyPointsKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _appKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _statsKey = GlobalKey();
  final GlobalKey _ctaKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final show = _scrollController.offset > 400;
        if (show != _showBackToTop) {
          setState(() => _showBackToTop = show);
        }
      });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cloudWhite,
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut);
              },
              backgroundColor: bayanihanBlue,
              child: const Icon(Icons.arrow_upward, color: plainWhite),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeader(),
            _buildHeroSection(),
            _buildPlatformOverview(),
            _buildBenefitsSection(),
            _buildLoyaltyPointsSection(),
            _buildFeaturesSection(context),
            _buildHowItWorksSection(context),
            _buildAppDownloadSection(),
            _buildTestimonialsSection(context),
            _buildStatisticsSection(),
            _buildCTASection(),
            _buildContactSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Material(
      elevation: 2,
      color: plainWhite,
      child: LayoutBuilder(builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 40,
            vertical: isMobile ? 10 : 14,
          ),
          child: Row(
            children: [
              // Logo + Brand
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/avlogo.png',
                    height: isMobile ? 28 : 36,
                  ),
                  const SizedBox(width: 10),
                  TextWidget(
                    text: 'LoyalLoop',
                    fontSize: isMobile ? 18 : 22,
                    fontFamily: 'Bold',
                    color: textBlack,
                  ),
                ],
              ),
              const Spacer(),
              // Nav
              Wrap(
                spacing: isMobile ? 6 : 12,
                children: [
                  _navButton('Features', _featuresKey, isMobile),
                  _navButton('How it works', _howItWorksKey, isMobile),
                  _navButton('Apps', _appKey, isMobile),
                  _navButton('Testimonials', _testimonialsKey, isMobile),
                  _navButton('Contact', _contactKey, isMobile),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _navButton(String label, GlobalKey key, bool isMobile) {
    return TextButton(
      onPressed: () => _scrollTo(key),
      style: TextButton.styleFrom(
        foregroundColor: bayanihanBlue,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 14,
          vertical: isMobile ? 8 : 10,
        ),
      ),
      child: TextWidget(
        text: label,
        fontSize: isMobile ? 12 : 14,
        fontFamily: 'Medium',
        color: bayanihanBlue,
      ),
    );
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  Widget _buildHeroSection() {
    return KeyedSubtree(
      key: _heroKey,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 700;
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 40,
                  vertical: isMobile ? 40 : 100,
                ),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Grow Your Business, Delight Your Customers',
                            fontSize: isMobile ? 28 : 52,
                            fontFamily: 'Bold',
                            color: textBlack,
                            maxLines: 4,
                          ),
                          const SizedBox(height: 16),
                          TextWidget(
                            text:
                                'Merchants: Retain customers and boost revenue with an easy-to-use loyalty platform. Customers: Enjoy instant rewards and personalized offers effortlessly.',
                            fontSize: isMobile ? 14 : 20,
                            fontFamily: 'Regular',
                            color: charcoalGray,
                            maxLines: 6,
                          ),
                          const SizedBox(height: 32),
                          Center(
                            child: Container(
                              height: isMobile ? 200 : 550,
                              width: isMobile ? 400 : null,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    bayanihanBlue.withOpacity(0.1),
                                    plainWhite
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.loyalty,
                                  size: isMobile ? 100 : 250,
                                  color: bayanihanBlue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text:
                                      'Grow Your Business, Delight Your Customers',
                                  fontSize: 52,
                                  fontFamily: 'Bold',
                                  color: textBlack,
                                  maxLines: 5,
                                ),
                                const SizedBox(height: 24),
                                TextWidget(
                                  text:
                                      'Merchants: Retain customers and boost revenue with an easy-to-use loyalty platform. Customers: Enjoy instant rewards and personalized offers effortlessly.',
                                  fontSize: 20,
                                  fontFamily: 'Regular',
                                  color: charcoalGray,
                                  maxLines: 5,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 550,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    bayanihanBlue.withOpacity(0.1),
                                    plainWhite
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.loyalty,
                                  size: 250,
                                  color: bayanihanBlue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPlatformOverview() {
    return KeyedSubtree(
        key: _platformKey,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 700;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 40,
                    vertical: isMobile ? 40 : 100,
                  ),
                  color: plainWhite,
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'Why LoyalLoop Stands Out',
                        fontSize: isMobile ? 28 : 44,
                        fontFamily: 'Bold',
                        color: textBlack,
                        align: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextWidget(
                        text:
                            'Merchants save time and boost profits with our scalable loyalty tools. Customers love the effortless reward system.',
                        fontSize: isMobile ? 14 : 20,
                        fontFamily: 'Regular',
                        color: charcoalGray,
                        align: TextAlign.center,
                        maxLines: 5,
                      ),
                      SizedBox(height: isMobile ? 40 : 80),
                      Wrap(
                        spacing: isMobile ? 16 : 30,
                        runSpacing: isMobile ? 16 : 30,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildOverviewCard(
                            icon: Icons.trending_up,
                            number: '300%',
                            title: 'Increase in Merchant Revenue',
                            color: palmGreen,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                          _buildOverviewCard(
                            icon: Icons.people,
                            number: '50K+',
                            title: 'Merchants Onboarded',
                            color: bayanihanBlue,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                          _buildOverviewCard(
                            icon: Icons.star,
                            number: '4.9/5',
                            title: 'Customer Satisfaction',
                            color: sunshineYellow,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget _buildOverviewCard({
    required IconData icon,
    required String number,
    required String title,
    required Color color,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: plainWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          TextWidget(
            text: number,
            fontSize: 36,
            fontFamily: 'Bold',
            color: textBlack,
          ),
          const SizedBox(height: 12),
          TextWidget(
            text: title,
            fontSize: 16,
            fontFamily: 'Medium',
            color: charcoalGray,
            align: TextAlign.center,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return KeyedSubtree(
        key: _benefitsKey,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 700;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 40,
                    vertical: isMobile ? 40 : 100,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [plainWhite, cloudWhite],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'Why Choose LoyalLoop?',
                        fontSize: isMobile ? 28 : 44,
                        fontFamily: 'Bold',
                        color: textBlack,
                        align: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextWidget(
                        text:
                            'The complete loyalty solution that benefits both merchants and customers.',
                        fontSize: isMobile ? 14 : 20,
                        fontFamily: 'Regular',
                        color: charcoalGray,
                        align: TextAlign.center,
                        maxLines: 5,
                      ),
                      SizedBox(height: isMobile ? 40 : 80),
                      Wrap(
                        spacing: isMobile ? 16 : 40,
                        runSpacing: isMobile ? 16 : 40,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildBenefitCard(
                            icon: Icons.trending_up,
                            title: 'Boost Revenue',
                            description:
                                'Merchants see 200% growth through increased customer retention and repeat purchases.',
                            color: palmGreen,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                          _buildBenefitCard(
                            icon: Icons.schedule,
                            title: 'Save Time',
                            description:
                                'Automated loyalty management saves merchants 10 hours weekly on program administration.',
                            color: bayanihanBlue,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                          _buildBenefitCard(
                            icon: Icons.analytics,
                            title: 'Data Insights',
                            description:
                                'Advanced analytics help merchants understand customer behavior and optimize campaigns.',
                            color: sunshineYellow,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                          _buildBenefitCard(
                            icon: Icons.security,
                            title: 'Secure & Reliable',
                            description:
                                'Bank-level security ensures customer data protection and GDPR compliance.',
                            color: festiveRed,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                          _buildBenefitCard(
                            icon: Icons.mobile_friendly,
                            title: 'Mobile-First',
                            description:
                                'Seamless mobile experience for both merchants and customers on any device.',
                            color: accentOrange,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                          _buildBenefitCard(
                            icon: Icons.support_agent,
                            title: '24/7 Support',
                            description:
                                'Round-the-clock expert support to help merchants succeed and customers thrive.',
                            color: charcoalGray,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: plainWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          TextWidget(
            text: title,
            fontSize: 22,
            fontFamily: 'Bold',
            color: textBlack,
            align: TextAlign.center,
          ),
          const SizedBox(height: 12),
          TextWidget(
            text: description,
            fontSize: 14,
            fontFamily: 'Regular',
            color: charcoalGray,
            align: TextAlign.center,
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildLoyaltyPointsSection() {
    return KeyedSubtree(
        key: _loyaltyPointsKey,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 700;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 40,
                    vertical: isMobile ? 40 : 100,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [bayanihanBlue.withOpacity(0.05), plainWhite],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'Loyalty Points Mechanics',
                        fontSize: isMobile ? 28 : 44,
                        fontFamily: 'Bold',
                        color: textBlack,
                        align: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextWidget(
                        text:
                            'Every purchase earns customers points based on spending. Merchants set custom rates, and customers redeem points for rewards seamlessly.',
                        fontSize: isMobile ? 14 : 20,
                        fontFamily: 'Regular',
                        color: charcoalGray,
                        align: TextAlign.center,
                        maxLines: 5,
                      ),
                      SizedBox(height: isMobile ? 40 : 80),
                      Wrap(
                        spacing: isMobile ? 16 : 40,
                        runSpacing: isMobile ? 16 : 40,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildPointsCard(
                            icon: Icons.shopping_cart,
                            title: 'Earn Points',
                            description:
                                'Customers earn points per purchase, automatically calculated based on spend.',
                            color: palmGreen,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                          _buildPointsCard(
                            icon: Icons.point_of_sale,
                            title: 'Custom Point Rates',
                            description:
                                'Merchants set rates like 1 point per ₱10 spent for flexible rewards.',
                            color: bayanihanBlue,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                          _buildPointsCard(
                            icon: Icons.card_giftcard,
                            title: 'Redeem Rewards',
                            description:
                                'Customers use points for products, goods, or discounts from merchants.',
                            color: sunshineYellow,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                          _buildPointsCard(
                            icon: Icons.qr_code_scanner,
                            title: 'Seamless Redemption',
                            description:
                                'Quick redemption via QR code or app at checkout.',
                            color: festiveRed,
                            width: isMobile ? constraints.maxWidth * 0.95 : 350,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget _buildPointsCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: plainWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          TextWidget(
            text: title,
            fontSize: 22,
            fontFamily: 'Bold',
            color: textBlack,
            align: TextAlign.center,
          ),
          const SizedBox(height: 12),
          TextWidget(
            text: description,
            fontSize: 14,
            fontFamily: 'Regular',
            color: charcoalGray,
            align: TextAlign.center,
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    final features = [
      _buildFeatureCard(
        icon: Icons.qr_code,
        title: 'Smart QR Code System',
        description:
            'Merchants: Streamline reward distribution with QR codes. Customers: Scan and redeem rewards instantly.',
        color: bayanihanBlue,
      ),
      _buildFeatureCard(
        icon: Icons.analytics,
        title: 'Advanced Analytics',
        description:
            'Merchants: Gain deep insights to optimize campaigns. Customers: Enjoy tailored offers.',
        color: sunshineYellow,
      ),
      _buildFeatureCard(
        icon: Icons.person,
        title: 'Personalized Rewards',
        description:
            'Merchants: Build loyalty with custom offers. Customers: Get rewards you love.',
        color: palmGreen,
      ),
      _buildFeatureCard(
        icon: Icons.security,
        title: 'Enterprise Security',
        description:
            'Merchants: Protect customer data with top-tier security. Customers: Shop with confidence.',
        color: festiveRed,
      ),
      _buildFeatureCard(
        icon: Icons.mobile_friendly,
        title: 'Mobile-First Design',
        description:
            'Merchants: Manage programs on the go. Customers: Access rewards anytime, anywhere.',
        color: accentOrange,
      ),
      _buildFeatureCard(
        icon: Icons.support_agent,
        title: '24/7 Support',
        description:
            'Merchants: Get expert help anytime. Customers: Resolve issues quickly.',
        color: charcoalGray,
      ),
    ];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 700;
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 40,
                vertical: isMobile ? 40 : 100,
              ),
              child: Column(
                children: [
                  TextWidget(
                    text: 'Powerful Tools for Merchants & Customers',
                    fontSize: isMobile ? 28 : 44,
                    fontFamily: 'Bold',
                    color: textBlack,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextWidget(
                    text:
                        'Merchants grow smarter, and customers enjoy a rewarding experience.',
                    fontSize: isMobile ? 14 : 20,
                    fontFamily: 'Regular',
                    color: charcoalGray,
                    align: TextAlign.center,
                    maxLines: 3,
                  ),
                  SizedBox(height: isMobile ? 40 : 80),
                  Wrap(
                    spacing: isMobile ? 16 : 30,
                    runSpacing: isMobile ? 16 : 30,
                    alignment: WrapAlignment.center,
                    children: features.asMap().entries.map((entry) {
                      final index = entry.key;
                      final feature = entry.value;
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          final delay = index * 0.1;
                          final animation =
                              Tween<double>(begin: 0, end: 1).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(delay, delay + 0.5,
                                  curve: Curves.easeOut),
                            ),
                          );
                          return Opacity(
                            opacity: animation.value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - animation.value) * 50),
                              child: SizedBox(
                                width: isMobile
                                    ? constraints.maxWidth * 0.95
                                    : 380,
                                child: feature,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        return Container(
          padding: EdgeInsets.all(isMobile ? 20 : 35),
          decoration: BoxDecoration(
            color: plainWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: isMobile ? 60 : 80,
                height: isMobile ? 60 : 80,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  size: isMobile ? 32 : 40,
                  color: color,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              TextWidget(
                text: title,
                fontSize: isMobile ? 20 : 24,
                fontFamily: 'Bold',
                color: textBlack,
                align: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 10 : 12),
              TextWidget(
                text: description,
                fontSize: isMobile ? 12 : 14,
                fontFamily: 'Regular',
                color: charcoalGray,
                align: TextAlign.center,
                maxLines: 5,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHowItWorksSection(BuildContext context) {
    final steps = [
      _buildStepCard(
        number: '1',
        title: 'Merchant Contacts Us',
        description:
            'Merchants reach out to our team to implement a loyalty program.',
        icon: Icons.contact_phone,
      ),
      _buildStepCard(
        number: '2',
        title: 'Application Processing',
        description:
            'We process the merchant’s application and prepare a customized solution.',
        icon: Icons.assignment,
      ),
      _buildStepCard(
        number: '3',
        title: 'Account Setup & Materials',
        description:
            'Merchants receive account details and physical loyalty materials.',
        icon: Icons.card_giftcard,
      ),
      _buildStepCard(
        number: '4',
        title: 'Merchant App Access',
        description: 'Merchants manage their program via our dedicated app.',
        icon: Icons.store,
      ),
      _buildStepCard(
        number: '5',
        title: 'Customer App Download',
        description: 'Customers download the app to access points and rewards.',
        icon: Icons.download,
      ),
      _buildStepCard(
        number: '6',
        title: 'Full System Operation',
        description:
            'Merchants and customers enjoy seamless loyalty management and rewards.',
        icon: Icons.rocket_launch,
      ),
    ];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 700;
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 40,
                vertical: isMobile ? 40 : 100,
              ),
              color: plainWhite,
              child: Column(
                children: [
                  TextWidget(
                    text: 'How LoyalLoop Operates',
                    fontSize: isMobile ? 28 : 44,
                    fontFamily: 'Bold',
                    color: textBlack,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextWidget(
                    text:
                        'From contact to full operation, a seamless process for all.',
                    fontSize: isMobile ? 14 : 20,
                    fontFamily: 'Regular',
                    color: charcoalGray,
                    align: TextAlign.center,
                    maxLines: 3,
                  ),
                  SizedBox(height: isMobile ? 40 : 80),
                  Wrap(
                    spacing: isMobile ? 16 : 40,
                    runSpacing: isMobile ? 16 : 40,
                    alignment: WrapAlignment.center,
                    children: steps.asMap().entries.map((entry) {
                      final index = entry.key;
                      final step = entry.value;
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          final delay = index * 0.1;
                          final animation =
                              Tween<double>(begin: 0, end: 1).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(delay, delay + 0.5,
                                  curve: Curves.easeOut),
                            ),
                          );
                          return Opacity(
                            opacity: animation.value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - animation.value) * 50),
                              child: SizedBox(
                                width: isMobile
                                    ? constraints.maxWidth * 0.95
                                    : 350,
                                child: step,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStepCard({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        return Container(
          padding: EdgeInsets.all(isMobile ? 20 : 40),
          decoration: BoxDecoration(
            color: cloudWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: isMobile ? 80 : 100,
                height: isMobile ? 80 : 100,
                decoration: BoxDecoration(
                  color: sunshineYellow,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: TextWidget(
                    text: number,
                    fontSize: isMobile ? 28 : 36,
                    fontFamily: 'Bold',
                    color: textBlack,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Icon(
                icon,
                size: isMobile ? 40 : 50,
                color: bayanihanBlue,
              ),
              SizedBox(height: isMobile ? 12 : 20),
              TextWidget(
                text: title,
                fontSize: isMobile ? 20 : 26,
                fontFamily: 'Bold',
                color: textBlack,
                align: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 10 : 16),
              TextWidget(
                text: description,
                fontSize: isMobile ? 12 : 14,
                fontFamily: 'Regular',
                color: charcoalGray,
                align: TextAlign.center,
                maxLines: 5,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppDownloadSection() {
    return KeyedSubtree(
        key: _appKey,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 700;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 40,
                    vertical: isMobile ? 40 : 100,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [bayanihanBlue.withOpacity(0.1), plainWhite],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'Access LoyalLoop Anywhere',
                        fontSize: isMobile ? 28 : 44,
                        fontFamily: 'Bold',
                        color: textBlack,
                        align: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextWidget(
                        text:
                            'Merchants: Manage programs effortlessly. Customers: Track rewards on the go.',
                        fontSize: isMobile ? 14 : 20,
                        fontFamily: 'Regular',
                        color: charcoalGray,
                        align: TextAlign.center,
                        maxLines: 3,
                      ),
                      SizedBox(height: isMobile ? 40 : 80),
                      Wrap(
                        spacing: isMobile ? 16 : 30,
                        runSpacing: isMobile ? 16 : 30,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildAppCard(
                            title: 'Merchant App',
                            description:
                                'Manage your loyalty program, track analytics, and engage customers with ease.',
                            icon: Icons.store,
                            color: bayanihanBlue,
                            width: isMobile ? constraints.maxWidth * 0.95 : 450,
                          ),
                          _buildAppCard(
                            title: 'Customer App',
                            description:
                                'Scan QR codes, earn rewards, and track your loyalty points effortlessly.',
                            icon: Icons.person,
                            color: palmGreen,
                            width: isMobile ? constraints.maxWidth * 0.95 : 450,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget _buildAppCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required double width,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        return Container(
          width: width,
          padding: EdgeInsets.all(isMobile ? 20 : 40),
          decoration: BoxDecoration(
            color: plainWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: isMobile ? 80 : 100,
                height: isMobile ? 80 : 100,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  size: isMobile ? 40 : 50,
                  color: color,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              TextWidget(
                text: title,
                fontSize: isMobile ? 24 : 28,
                fontFamily: 'Bold',
                color: textBlack,
                align: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 10 : 12),
              TextWidget(
                text: description,
                fontSize: isMobile ? 12 : 14,
                fontFamily: 'Regular',
                color: charcoalGray,
                align: TextAlign.center,
                maxLines: 5,
              ),
              SizedBox(height: isMobile ? 20 : 32),
              Wrap(
                spacing: isMobile ? 12 : 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildDownloadButton(
                    'Google Play',
                    Icons.android,
                    bayanihanBlue,
                    isMobile,
                  ),
                  _buildDownloadButton(
                    'App Store',
                    Icons.apple,
                    textBlack,
                    isMobile,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDownloadButton(
      String text, IconData icon, Color color, bool isMobile) {
    return TouchableWidget(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 24,
          vertical: isMobile ? 10 : 14,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: plainWhite, size: isMobile ? 18 : 22),
            const SizedBox(width: 8),
            TextWidget(
              text: text,
              fontSize: isMobile ? 14 : 16,
              fontFamily: 'Medium',
              color: plainWhite,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestimonialsSection(BuildContext context) {
    final testimonials = [
      _buildTestimonialCard(
        name: 'Sarah Johnson',
        company: 'Coffee Corner',
        testimonial:
            'LoyalLoop tripled our repeat customers, saving us time and boosting profits!',
        rating: 5,
        avatar: '👩‍💼',
      ),
      _buildTestimonialCard(
        name: 'Mike Chen',
        company: 'Tech Gadgets',
        testimonial:
            'The analytics helped us target offers, increasing sales by 200% in months.',
        rating: 5,
        avatar: '👨‍💼',
      ),
      _buildTestimonialCard(
        name: 'Emily Rodriguez',
        company: 'Boutique Fashion',
        testimonial:
            'Our customers love the QR code rewards, making loyalty fun and engaging.',
        rating: 5,
        avatar: '👩‍🎨',
      ),
    ];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 700;
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 40,
                vertical: isMobile ? 40 : 100,
              ),
              child: Column(
                children: [
                  TextWidget(
                    text: 'Trusted by Merchants Worldwide',
                    fontSize: isMobile ? 28 : 44,
                    fontFamily: 'Bold',
                    color: textBlack,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextWidget(
                    text:
                        'Hear how LoyalLoop empowers businesses and delights customers.',
                    fontSize: isMobile ? 14 : 20,
                    fontFamily: 'Regular',
                    color: charcoalGray,
                    align: TextAlign.center,
                    maxLines: 3,
                  ),
                  SizedBox(height: isMobile ? 40 : 80),
                  Wrap(
                    spacing: isMobile ? 16 : 30,
                    runSpacing: isMobile ? 16 : 30,
                    alignment: WrapAlignment.center,
                    children: testimonials.asMap().entries.map((entry) {
                      final index = entry.key;
                      final testimonial = entry.value;
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          final delay = index * 0.1;
                          final animation =
                              Tween<double>(begin: 0, end: 1).animate(
                            CurvedAnimation(
                              parent: _controller,
                              curve: Interval(delay, delay + 0.5,
                                  curve: Curves.easeOut),
                            ),
                          );
                          return Opacity(
                            opacity: animation.value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - animation.value) * 50),
                              child: SizedBox(
                                width: isMobile
                                    ? constraints.maxWidth * 0.95
                                    : 380,
                                child: testimonial,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String company,
    required String testimonial,
    required int rating,
    required String avatar,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;
        return Container(
          padding: EdgeInsets.all(isMobile ? 20 : 35),
          decoration: BoxDecoration(
            color: plainWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    color: index < rating ? sunshineYellow : ashGray,
                    size: isMobile ? 20 : 24,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              TextWidget(
                text: testimonial,
                fontSize: isMobile ? 12 : 14,
                fontFamily: 'Regular',
                color: charcoalGray,
                maxLines: 6,
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Row(
                children: [
                  Text(
                    avatar,
                    style: TextStyle(fontSize: isMobile ? 32 : 40),
                  ),
                  SizedBox(width: isMobile ? 12 : 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: name,
                        fontSize: isMobile ? 16 : 18,
                        fontFamily: 'Bold',
                        color: textBlack,
                      ),
                      TextWidget(
                        text: company,
                        fontSize: isMobile ? 12 : 14,
                        fontFamily: 'Medium',
                        color: bayanihanBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatisticsSection() {
    return KeyedSubtree(
        key: _statsKey,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 700;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 40,
                    vertical: isMobile ? 40 : 100,
                  ),
                  color: bayanihanBlue,
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'Proven Results for Merchants & Customers',
                        fontSize: isMobile ? 28 : 44,
                        fontFamily: 'Bold',
                        color: plainWhite,
                        align: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 40 : 80),
                      Wrap(
                        spacing: isMobile ? 16 : 40,
                        runSpacing: isMobile ? 16 : 40,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildStatCard(
                            '2M+',
                            'Active Customers',
                            plainWhite,
                            isMobile ? constraints.maxWidth * 0.45 : 200,
                          ),
                          _buildStatCard(
                            '50K+',
                            'Merchants',
                            plainWhite,
                            isMobile ? constraints.maxWidth * 0.45 : 200,
                          ),
                          _buildStatCard(
                            '200%',
                            'Revenue Growth',
                            plainWhite,
                            isMobile ? constraints.maxWidth * 0.45 : 200,
                          ),
                          _buildStatCard(
                            '99.9%',
                            'User Satisfaction',
                            plainWhite,
                            isMobile ? constraints.maxWidth * 0.45 : 200,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget _buildStatCard(
      String number, String label, Color color, double width) {
    return Container(
      width: width,
      child: Column(
        children: [
          TextWidget(
            text: number,
            fontSize: width < 200 ? 36 : 48,
            fontFamily: 'Bold',
            color: color,
          ),
          const SizedBox(height: 12),
          TextWidget(
            text: label,
            fontSize: width < 200 ? 14 : 16,
            fontFamily: 'Medium',
            color: color.withOpacity(0.9),
            align: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection() {
    return KeyedSubtree(
        key: _ctaKey,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 700;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 40,
                    vertical: isMobile ? 40 : 100,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [bayanihanBlue, bayanihanBlue.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      TextWidget(
                        text: 'Transform Your Business Today',
                        fontSize: isMobile ? 28 : 44,
                        fontFamily: 'Bold',
                        color: plainWhite,
                        align: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextWidget(
                        text:
                            'Join hundreds of merchants and thousands of customers who are making loyalty rewarding and effortless.',
                        fontSize: isMobile ? 14 : 20,
                        fontFamily: 'Regular',
                        color: plainWhite,
                        align: TextAlign.center,
                        maxLines: 5,
                      ),
                      SizedBox(height: isMobile ? 24 : 50),
                      Wrap(
                        spacing: isMobile ? 12 : 30,
                        runSpacing: isMobile ? 12 : 20,
                        alignment: WrapAlignment.center,
                        children: [
                          TouchableWidget(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 75,
                                vertical: isMobile ? 12 : 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: plainWhite, width: 2),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: TextWidget(
                                text: 'Explore Demo',
                                fontSize: isMobile ? 16 : 18,
                                fontFamily: 'Medium',
                                color: plainWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget _buildContactSection() {
    return KeyedSubtree(
        key: _contactKey,
        child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
                position: _slideAnimation,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 700;
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 40,
                        vertical: isMobile ? 40 : 80,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [bayanihanBlue.withOpacity(0.1), plainWhite],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 1200),
                          child: Column(
                            children: [
                              TextWidget(
                                text: 'Get in Touch',
                                fontSize: isMobile ? 30 : 44,
                                fontFamily: 'Bold',
                                color: textBlack,
                                align: TextAlign.center,
                              ),
                              SizedBox(height: isMobile ? 12 : 16),
                              TextWidget(
                                text:
                                    'We’re here to help merchants grow and customers enjoy seamless rewards!',
                                fontSize: isMobile ? 14 : 18,
                                fontFamily: 'Regular',
                                color: charcoalGray,
                                align: TextAlign.center,
                                maxLines: 3,
                              ),
                              SizedBox(height: isMobile ? 24 : 40),
                              Flex(
                                direction:
                                    isMobile ? Axis.vertical : Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: isMobile
                                    ? CrossAxisAlignment.stretch
                                    : CrossAxisAlignment.start,
                                children: [
                                  // Contact Info
                                  if (isMobile)
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            plainWhite,
                                            bayanihanBlue.withValues(
                                                alpha: 0.05)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.06),
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: 'Contact Us',
                                            fontSize: 26,
                                            fontFamily: 'Bold',
                                            color: textBlack,
                                          ),
                                          SizedBox(height: 12),
                                          ...[
                                            _buildContactDetailRow(
                                              Icons.group,
                                              'Team Name',
                                              'Algo Vision',
                                              color: bayanihanBlue,
                                              isMobile: isMobile,
                                            ),
                                            SizedBox(height: 10),
                                            _buildContactDetailRow(
                                              Icons.phone,
                                              'Contact Number',
                                              '+639639520422',
                                              color: palmGreen,
                                              isMobile: isMobile,
                                            ),
                                            SizedBox(height: 10),
                                            _buildContactDetailRow(
                                              Icons.email,
                                              'Email',
                                              'algovision123@gmail.com',
                                              color: sunshineYellow,
                                              isLink: true,
                                              linkPrefix: 'mailto:',
                                              isMobile: isMobile,
                                            ),
                                            SizedBox(height: 10),
                                            _buildContactDetailRow(
                                              Icons.facebook,
                                              'Facebook',
                                              'facebook.com/algovision',
                                              color: bayanihanBlue,
                                              isLink: true,
                                              linkPrefix: 'https://',
                                              isMobile: isMobile,
                                            ),
                                            SizedBox(height: 10),
                                            _buildContactDetailRow(
                                              Icons.location_on,
                                              'Location',
                                              'Cagayan De Oro City, Misamis Oriental',
                                              color: accentOrange,
                                              isMobile: isMobile,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  if (!isMobile)
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: isMobile ? 8 : 0),
                                        padding:
                                            EdgeInsets.all(isMobile ? 16 : 24),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              plainWhite,
                                              bayanihanBlue.withOpacity(0.05)
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.06),
                                              blurRadius: 10,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              text: 'Contact Us',
                                              fontSize: 34,
                                              fontFamily: 'Bold',
                                              color: textBlack,
                                            ),
                                            SizedBox(height: 20),
                                            ...[
                                              _buildContactDetailRow(
                                                Icons.group,
                                                'Team Name',
                                                'Algo Vision',
                                                color: bayanihanBlue,
                                                isMobile: isMobile,
                                              ),
                                              SizedBox(height: 16),
                                              _buildContactDetailRow(
                                                Icons.phone,
                                                'Contact Number',
                                                '+639639520422',
                                                color: palmGreen,
                                                isMobile: isMobile,
                                              ),
                                              SizedBox(height: 16),
                                              _buildContactDetailRow(
                                                Icons.email,
                                                'Email',
                                                'algovision123@gmail.com',
                                                color: sunshineYellow,
                                                isLink: true,
                                                linkPrefix: 'mailto:',
                                                isMobile: isMobile,
                                              ),
                                              SizedBox(height: 16),
                                              _buildContactDetailRow(
                                                Icons.facebook,
                                                'Facebook',
                                                'facebook.com/algovision',
                                                color: bayanihanBlue,
                                                isLink: true,
                                                linkPrefix: 'https://',
                                                isMobile: isMobile,
                                              ),
                                              SizedBox(height: 16),
                                              _buildContactDetailRow(
                                                Icons.location_on,
                                                'Location',
                                                'Cagayan De Oro City, Misamis Oriental',
                                                color: accentOrange,
                                                isMobile: isMobile,
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                      width: isMobile ? 0 : 32,
                                      height: isMobile ? 24 : 0),
                                  // Let's Connect
                                  if (isMobile)
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: plainWhite,
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                            color:
                                                bayanihanBlue.withOpacity(0.2)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.08),
                                            blurRadius: 12,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.connect_without_contact,
                                            color: bayanihanBlue,
                                            size: 48,
                                          ),
                                          SizedBox(height: 12),
                                          TextWidget(
                                            text: 'Let’s Connect!',
                                            fontSize: 24,
                                            fontFamily: 'Bold',
                                            color: textBlack,
                                            align: TextAlign.center,
                                          ),
                                          SizedBox(height: 10),
                                          TextWidget(
                                            text:
                                                'Reach out to start building loyalty with LoyalLoop or to learn more about our platform.',
                                            fontSize: 14,
                                            fontFamily: 'Regular',
                                            color: charcoalGray,
                                            align: TextAlign.center,
                                            maxLines: 3,
                                          ),
                                          SizedBox(height: 16),
                                          ButtonWidget(
                                            label: 'Contact Us',
                                            onPressed: () async {
                                              final uri = Uri.parse(
                                                  'mailto:algovision123@gmail.com');
                                              if (await canLaunchUrl(uri)) {
                                                await launchUrl(uri);
                                              }
                                            },
                                            width: double.infinity,
                                            height: 50,
                                            fontSize: 16,
                                            color: bayanihanBlue,
                                            textColor: plainWhite,
                                            radius: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (!isMobile)
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(isMobile ? 20 : 32),
                                        decoration: BoxDecoration(
                                          color: plainWhite,
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          border: Border.all(
                                              color: bayanihanBlue
                                                  .withOpacity(0.2)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.08),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.connect_without_contact,
                                              color: bayanihanBlue,
                                              size: 64,
                                            ),
                                            SizedBox(height: 16),
                                            TextWidget(
                                              text: 'Let’s Connect!',
                                              fontSize: 32,
                                              fontFamily: 'Bold',
                                              color: textBlack,
                                              align: TextAlign.center,
                                            ),
                                            SizedBox(height: 16),
                                            TextWidget(
                                              text:
                                                  'Reach out to start building loyalty with LoyalLoop or to learn more about our platform.',
                                              fontSize: 18,
                                              fontFamily: 'Regular',
                                              color: charcoalGray,
                                              align: TextAlign.center,
                                              maxLines: 3,
                                            ),
                                            SizedBox(height: 24),
                                            ButtonWidget(
                                              label: 'Contact Us',
                                              onPressed: () async {
                                                final uri = Uri.parse(
                                                    'mailto:algovision123@gmail.com');
                                                if (await canLaunchUrl(uri)) {
                                                  await launchUrl(uri);
                                                }
                                              },
                                              width: 200,
                                              height: 60,
                                              fontSize: 18,
                                              color: bayanihanBlue,
                                              textColor: plainWhite,
                                              radius: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: isMobile ? 24 : 40),
                              Divider(
                                  color: ashGray.withOpacity(0.3),
                                  thickness: 1),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ))));
  }

  Widget _buildContactDetailRow(
    IconData icon,
    String label,
    String value, {
    Color? color,
    bool isLink = false,
    String linkPrefix = '',
    required bool isMobile,
  }) {
    return TouchableWidget(
      onTap: isLink
          ? () async {
              final uri = Uri.parse('$linkPrefix$value');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            }
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 8 : 12,
          horizontal: isMobile ? 12 : 16,
        ),
        decoration: BoxDecoration(
          color: plainWhite.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: (color ?? bayanihanBlue).withOpacity(0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: isMobile ? 32 : 40,
              height: isMobile ? 32 : 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color ?? bayanihanBlue,
                  width: 1.5,
                ),
              ),
              child: Icon(
                icon,
                color: color ?? bayanihanBlue,
                size: isMobile ? 18 : 22,
              ),
            ),
            SizedBox(width: isMobile ? 10 : 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: label,
                    fontSize: isMobile ? 12 : 14,
                    fontFamily: 'Medium',
                    color: charcoalGray,
                  ),
                  SizedBox(height: isMobile ? 2 : 4),
                  TextWidget(
                    text: value,
                    fontSize: isMobile ? 14 : 16,
                    fontFamily: 'Bold',
                    color: isLink ? (color ?? bayanihanBlue) : textBlack,
                    align: TextAlign.left,
                    decoration: isLink ? TextDecoration.underline : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 700;
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 40,
                vertical: isMobile ? 40 : 60,
              ),
              color: textBlack,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(
                    text: 'LoyalLoop by Algo Vision',
                    fontSize: isMobile ? 18 : 22,
                    fontFamily: 'Bold',
                    color: plainWhite,
                    align: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 8 : 12),
                  TextWidget(
                    text:
                        'Empowering businesses and customers with seamless, rewarding loyalty experiences.',
                    fontSize: isMobile ? 12 : 15,
                    fontFamily: 'Regular',
                    color: ashGray,
                    align: TextAlign.center,
                    maxLines: 5,
                  ),
                  SizedBox(height: isMobile ? 16 : 24),
                  Wrap(
                    spacing: isMobile ? 12 : 18,
                    alignment: WrapAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.facebook,
                          color: plainWhite,
                          size: isMobile ? 22 : 26,
                        ),
                        onPressed: () async {
                          final uri =
                              Uri.parse('https://facebook.com/algovision');
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.email,
                          color: plainWhite,
                          size: isMobile ? 22 : 26,
                        ),
                        onPressed: () async {
                          final uri =
                              Uri.parse('mailto:algovision123@gmail.com');
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 16 : 24),
                  Divider(color: ashGray.withOpacity(0.3), thickness: 1),
                  SizedBox(height: isMobile ? 12 : 16),
                  TextWidget(
                    text: '© 2025 Algo Vision. All rights reserved.',
                    fontSize: isMobile ? 11 : 13,
                    fontFamily: 'Regular',
                    color: ashGray,
                    align: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
