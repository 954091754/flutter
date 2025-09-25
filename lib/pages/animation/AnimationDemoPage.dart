import 'package:flutter/material.dart';

class AnimationDemoPage extends StatefulWidget {
  final String type;
  const AnimationDemoPage({super.key, required this.type});

  @override
  State<AnimationDemoPage> createState() => _AnimationDemoPageState();
}

class _AnimationDemoPageState extends State<AnimationDemoPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (widget.type) {
      case 'Fade':
        child = FadeTransition(
          opacity: _controller.drive(Tween(begin: 0.0, end: 1.0)),
          child: _demoBox(context),
        );
        break;
      case 'Scale':
        child = ScaleTransition(
          scale: _controller.drive(Tween(begin: 0.5, end: 1.2)),
          child: _demoBox(context),
        );
        break;
      case 'Rotate':
        child = RotationTransition(
          turns: _controller,
          child: _demoBox(context),
        );
        break;
      case 'Slide':
        child = SlideTransition(
          position: _controller.drive(Tween(begin: const Offset(-1, 0), end: Offset.zero)),
          child: _demoBox(context),
        );
        break;
      case 'AnimatedContainer':
        child = _animatedContainerDemo(context);
        break;
      case 'Hero':
        child = _heroDemo(context);
        break;
      case 'Staggered':
        child = _staggeredDemo(context);
        break;
      case 'AnimatedBuilder':
      default:
        child = AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final scale = 0.8 + _controller.value * 0.4;
            return Transform.scale(scale: scale, child: _demoBox(context));
          },
        );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.type)),
      body: Center(child: child),
    );
  }

  Widget _demoBox(BuildContext context) => Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
      );

  Widget _animatedContainerDemo(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) {
        return Container(
          width: 80 + 80 * value,
          height: 80 + 80 * value,
          decoration: BoxDecoration(
            color: Color.lerp(Colors.blue, Colors.red, value),
            borderRadius: BorderRadius.circular(12 + 20 * value),
          ),
        );
      },
    );
  }

  Widget _heroDemo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(title: const Text('Hero Detail')),
            body: Center(
              child: Hero(
                tag: 'hero-box',
                child: _demoBox(context),
              ),
            ),
          );
        }));
      },
      child: Hero(tag: 'hero-box', child: _demoBox(context)),
    );
  }

  Widget _staggeredDemo(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = Curves.easeInOut.transform(_controller.value);
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(scale: scale, child: _demoBox(context)),
              Positioned(
                bottom: 10 + 80 * _controller.value,
                child: Container(width: 40, height: 6, color: Colors.white70),
              )
            ],
          );
        },
      ),
    );
  }
}
