import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

///
///
///
class HideableCodeWidget extends StatefulWidget {
  final String code;
  final String? title;
  final bool bordered;
  final bool showQrCode;

  const HideableCodeWidget({
    required this.code,
    this.bordered = true,
    super.key,
    this.title,
    this.showQrCode = false,
  });

  @override
  State<HideableCodeWidget> createState() => _HideableCodeWidgetState();
}

///
///
///
class _HideableCodeWidgetState extends State<HideableCodeWidget> {
  bool _isHidden = true;

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: widget.bordered
            ? Border.all(
                color: CupertinoColors.systemGrey,
              )
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          if (widget.title != null)
            Text(
              widget.title!,
              style: const TextStyle(
                fontSize: 12,
                color: CupertinoColors.systemGrey,
              ),
            ),

          /// Code
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /// Hide Button
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => setState(() {
                  _isHidden = !_isHidden;
                }),
                child: Icon(
                  _isHidden ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                ),
              ),

              /// Code
              Text(
                _isHidden ? '*' * widget.code.length : widget.code,
                style: const TextStyle(
                  fontSize: 20,
                  color: CupertinoColors.systemGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          /// QR Code
          if (widget.showQrCode && !_isHidden)
            SizedBox(

              width: 200,
              child: PrettyQrView.data(
                data: widget.code,
                decoration: const PrettyQrDecoration(
                  background: CupertinoColors.systemGroupedBackground,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
