import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/app/core/utils/extensions.dart';

import '../../../core/utils/constants.dart';

class AnimatedChild extends AnimatedWidget {
  final int? index;

  final Widget? child;

  final Key? btnKey;

  final String? label;

  final VoidCallback? onTap;

  final VoidCallback? toggleChildren;

  const AnimatedChild({
    Key? key,
    this.btnKey,
    required Animation<double> animation,
    this.index,
    this.child,
    this.label,
    this.onTap,
    this.toggleChildren,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (label != null)
          ScaleTransition(
            scale: animation,
            child: Container(
              padding: (child == null) ? const EdgeInsets.symmetric(vertical: 8) : null,
              key: (child == null) ? btnKey : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Material(
                  type: MaterialType.transparency,
                  borderRadius: BorderRadius.circular(6.0),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () {
                      if (onTap != null) {
                        onTap!();
                      }
                      toggleChildren!();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 8.0,
                      ),
                      child: Text(label!),
                    ),
                  ),
                ).decorate(color: Colors.white, padding: 5),
              ),
            ),
          ),
        if (child != null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            height: 60.0,
            width: 60.0,
            child: ScaleTransition(
              scale: animation,
              child: FloatingActionButton(
                key: btnKey,
                onPressed: () {
                  if (onTap != null) {
                    onTap!();
                  }
                  toggleChildren!();
                },
                backgroundColor: Constants.accentColor,
                foregroundColor: Colors.white,
                child: child,
              ),
            ),
          )
      ],
    );
  }
}

class BackgroundOverlay extends AnimatedWidget {
  final double opacity;
  final GlobalKey dialKey;
  final LayerLink layerLink;
  final ShapeBorder shape;
  final VoidCallback? onTap;
  final bool closeManually;
  // final String? tooltip;

  const BackgroundOverlay({
    Key? key,
    this.onTap,
    required this.shape,
    required Animation<double> animation,
    required this.dialKey,
    required this.layerLink,
    required this.closeManually,
    // required this.tooltip,
    this.opacity = 0.7,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white.withOpacity(opacity * animation.value), BlendMode.srcOut),
          child: Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTap: closeManually ? null : onTap,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white, backgroundBlendMode: BlendMode.dstOut),
                ),
              ),
              Positioned(
                width: dialKey.globalPaintBounds?.size.width,
                child: CompositedTransformFollower(
                  link: layerLink,
                  showWhenUnlinked: false,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: () {
                      final Widget child = GestureDetector(
                        onTap: onTap,
                        child: Container(
                          width: dialKey.globalPaintBounds?.size.width,
                          height: dialKey.globalPaintBounds?.size.height,
                          decoration: ShapeDecoration(
                            shape: shape == const CircleBorder() ? const StadiumBorder() : shape,
                            color: Colors.white,
                          ),
                        ),
                      );
                      return child;
                    }(),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

typedef AsyncChildrenBuilder = Future<List<SpeedDialChild>> Function(BuildContext context);

class SpeedDial extends StatefulWidget {
  final List<SpeedDialChild> children;

  // final String? tooltip;

  final AsyncChildrenBuilder? onOpenBuilder;

  final ValueNotifier<bool>? openCloseDial;

  const SpeedDial({
    Key? key,
    this.children = const [],
    // this.tooltip,
    this.onOpenBuilder,
    this.openCloseDial,
  }) : super(key: key);

  @override
  SpeedDialState createState() => SpeedDialState();
}

class SpeedDialState extends State<SpeedDial> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  bool _open = false;
  OverlayEntry? overlayEntry;
  OverlayEntry? backgroundOverlay;
  final LayerLink _layerLink = LayerLink();
  final dialKey = GlobalKey<State<StatefulWidget>>();

  @override
  void initState() {
    super.initState();
    widget.openCloseDial?.addListener(_onOpenCloseDial);

    _checkChildren();
  }

  @override
  void dispose() {
    if (backgroundOverlay != null && backgroundOverlay!.mounted) {
      backgroundOverlay?.remove();
    }
    overlayEntry?.dispose();
    _controller.dispose();
    widget.openCloseDial?.removeListener(_onOpenCloseDial);
    super.dispose();
  }

  @override
  void didUpdateWidget(SpeedDial oldWidget) {
    if (oldWidget.children.length != widget.children.length) {
      _controller.duration = const Duration(milliseconds: 200);
    }

    widget.openCloseDial?.removeListener(_onOpenCloseDial);
    widget.openCloseDial?.addListener(_onOpenCloseDial);
    super.didUpdateWidget(oldWidget);
  }

  void _checkChildren() {
    if (widget.children.length > 5) {
      debugPrint('Warning ! You are using more than 5 children, which is not compliant with Material design specs.');
    }
  }

  void _onOpenCloseDial() {
    final show = widget.openCloseDial?.value;
    if (!mounted) return;
    if (_open != show) {
      _toggleChildren();
    }
  }

  void _toggleChildren() async {
    if (!mounted) return;

    final opening = !_open;
    if (opening && widget.onOpenBuilder != null) {
      widget.children.clear();
      final widgets = await widget.onOpenBuilder!(context);
      widget.children.addAll(widgets);
      _checkChildren();
    }

    if (widget.children.isNotEmpty) {
      toggleOverlay();
      widget.openCloseDial?.value = opening;
    }
  }

  toggleOverlay() {
    if (_open) {
      _controller.reverse().whenComplete(() {
        overlayEntry?.remove();
        if (backgroundOverlay != null && backgroundOverlay!.mounted) {
          backgroundOverlay?.remove();
        }
      });
    } else {
      if (_controller.isAnimating) {
        return;
      }
      overlayEntry = OverlayEntry(
        builder: (ctx) => _ChildrensOverlay(
          widget: widget,
          dialKey: dialKey,
          layerLink: _layerLink,
          controller: _controller,
          toggleChildren: _toggleChildren,
          animationCurve: Curves.easeInOut,
        ),
      );

      backgroundOverlay = OverlayEntry(
        builder: (ctx) {
          return BackgroundOverlay(
            dialKey: dialKey,
            layerLink: _layerLink,
            closeManually: false,
            // tooltip: widget.tooltip,
            shape: const CircleBorder(),
            onTap: _toggleChildren,
            animation: _controller,
            opacity: 0.5,
          );
        },
      );

      if (!mounted) return;

      _controller.forward();
      Overlay.of(context).insert(backgroundOverlay!);
      Overlay.of(context).insert(overlayEntry!);
    }

    if (!mounted) return;
    setState(() {
      _open = !_open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, ch) => CompositedTransformTarget(
        link: _layerLink,
        key: dialKey,
        child: AnimatedContainer(
          curve: Curves.easeInOutBack,
          duration: const Duration(milliseconds: 150),
          height: 56.0,
          child: FittedBox(
            child: GestureDetector(
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: ColorTween(begin: Get.theme.colorScheme.secondary, end: Get.theme.primaryColor).lerp(_controller.value),
                foregroundColor: ColorTween(begin: Colors.white, end: Colors.white).lerp(_controller.value),
                onPressed: _toggleChildren,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, _) => Transform.rotate(
                    angle: _controller.value * pi / 2,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: (_controller.value < 0.4)
                          ? const Center(
                              child: Icon(
                                Icons.menu_open,
                                key: ValueKey<int>(0),
                              ),
                            )
                          : Transform.rotate(
                              angle: -pi * 1 / 2,
                              child: const Center(
                                child: Icon(
                                  Icons.close,
                                  key: ValueKey<int>(1),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChildrensOverlay extends StatelessWidget {
  const _ChildrensOverlay({
    Key? key,
    required this.widget,
    required this.layerLink,
    required this.dialKey,
    required this.controller,
    required this.toggleChildren,
    this.animationCurve,
  }) : super(key: key);

  final SpeedDial widget;
  final GlobalKey<State<StatefulWidget>> dialKey;
  final LayerLink layerLink;
  final AnimationController controller;
  final Function toggleChildren;
  final Curve? animationCurve;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Positioned(
            child: CompositedTransformFollower(
          followerAnchor: Alignment.bottomRight,
          offset: Offset((dialKey.globalPaintBounds == null ? 0 : dialKey.globalPaintBounds!.size.width) + max(const Size(56.0, 56.0).width - 56, 0) / 2, 0),
          link: layerLink,
          showWhenUnlinked: false,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: max(const Size(56.0, 56.0).width - 56, 0) / 2,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: widget.children
                    .map((SpeedDialChild child) {
                      int index = widget.children.indexOf(child);
                      return AnimatedChild(
                        animation: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: controller,
                            curve: Interval(
                              index / widget.children.length,
                              1.0,
                              curve: Curves.easeInOut,
                            ),
                          ),
                        ),
                        index: index,
                        btnKey: child.key,
                        label: child.label,
                        onTap: child.onTap,
                        toggleChildren: () {
                          if (!false) toggleChildren();
                        },
                        child: child.child,
                      );
                    })
                    .toList()
                    .reversed
                    .toList(),
              ),
            ),
          ),
        )),
      ],
    );
  }
}

class SpeedDialChild {
  final Key? key;

  final String? label;

  final Widget? child;

  final VoidCallback? onTap;

  SpeedDialChild({
    this.key,
    this.label,
    this.child,
    this.onTap,
  });
}
