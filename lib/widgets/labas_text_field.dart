import 'package:Labas/localization/language_constants.dart';
import 'package:Labas/provider/widget_provider.dart';
import 'package:Labas/utilis/colors.dart';
import 'package:Labas/utilis/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabasTextField extends StatefulWidget {
  LabasTextField({
    Key key,
    @required this.textEditingController,
    @required this.hintText,
    this.obsecure = false,
    this.isPasswordText = false,
    this.isTextFormField = false,
    this.isFormType = 1,
    this.validatorText = '',
    this.onSaveText = '',
    this.maxLength,
    this.textInputType = TextInputType.text,
  }) : super(key: key);
  TextEditingController textEditingController;
  final String hintText;
  bool obsecure;
  bool isPasswordText;
  String errorText;
  bool isTextFormField;
  String validatorText;
  int isFormType;
  String onSaveText;
  int maxLength;
  TextInputType textInputType;

  @override
  _MelodyTextFieldState createState() => _MelodyTextFieldState();
}

class _MelodyTextFieldState extends State<LabasTextField> {
  Icon icon = Icon(Icons.remove_red_eye);

  @override
  Widget build(BuildContext context) {
    var _widgetProvider = Provider.of<WidgetProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: !widget.isTextFormField
          ? TextField(
              autocorrect: true,
              controller: widget.textEditingController,
              decoration: InputDecoration(
                errorText: '',
                hintStyle: hintTextStyle,
                hintText: widget.hintText,
                border: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
                suffixIconConstraints: BoxConstraints(
                  maxHeight: width * .1,
                  maxWidth: width * .1,
                  minWidth: width * .08,
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: width * .1,
                  maxWidth: width * .08,
                  minWidth: width * .08,
                ),
                prefixIcon: widget.isPasswordText
                    ? Icon(
                        Icons.lock,
                        size: 22,
                      )
                    : Icon(
                        Icons.phone,
                        size: 22,
                      ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                suffixIcon: widget.textEditingController.text.isNotEmpty
                    ? widget.isPasswordText
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.obsecure = !widget.obsecure;
                              });
                              if (widget.obsecure) {
                                _widgetProvider.changeIcon(
                                  Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  ),
                                );
                              } else {
                                _widgetProvider.changeIcon(
                                  Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: width * .06,
                              height: width * .06,
                              decoration: BoxDecoration(),
                              child: Center(
                                child: _widgetProvider.icon,
                              ),
                            ),
                          )
                        : !widget.isPasswordText
                            ? widget.textEditingController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.textEditingController.text = '';
                                      });
                                    },
                                    child: SizedBox(
                                      width: width * .06,
                                      height: width * .06,
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : widget.textEditingController.text == ''
                                    ? SizedBox()
                                    : SizedBox()
                            : SizedBox()
                    : SizedBox(),
              ),
              onChanged: (_) {
                setState(() {});
              },
              obscureText: widget.obsecure ? widget.obsecure : false,
              style: labelTextStyle,
            )
          : TextFormField(
              autovalidate: true,
              controller: widget.textEditingController,
              keyboardType: widget.textInputType,
              validator: (value) {
                //1 FOR SIMPLE FIELD, 2 FOR PHONE NUMBER, 3 FOR PASSWORD, 4 FOR CONFIRM PASSWORD, 5 FOR CORRECT EMAIL
                if (value.isEmpty) {
                  if (widget.isFormType == 2) {
                    return getTranslated(context, 'passwordText');
                  // } else if (widget.isFormType == 1) {
                  } else if (widget.isFormType == 0) {
                    if (value.isEmpty) {
                      return getTranslated(context, 'enterPhoneNumber');
                    }
                  }
                }
                if (widget.isFormType == 2) {
                  if (value.length < 8) {
                    if (widget.isFormType == 3) {
                      if (value.length < 8) {
                        return getTranslated(context, '8digitText');
                      }
                    }
                  }
                }

                if (widget.isFormType == 2) {
                  if (value.length > 8) {
                    if (widget.isFormType == 2) {
                      return getTranslated(context, '8digitText');
                    }
                  }
                }
              },
              decoration: InputDecoration(
                hintStyle: hintTextStyle,
                hintText: widget.hintText,
                border: new OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
                suffixIconConstraints: BoxConstraints(
                  maxHeight: width * .1,
                  maxWidth: width * .1,
                  minWidth: width * .08,
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: width * .1,
                  maxWidth: width * .08,
                  minWidth: width * .08,
                ),
                prefixIcon: widget.isPasswordText
                    ? Icon(
                        Icons.lock,
                        size: 22,
                      )
                    : Icon(
                        Icons.phone,
                        size: 22,
                      ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                suffixIcon: widget.textEditingController.text.isNotEmpty
                    ? widget.isPasswordText
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.obsecure = !widget.obsecure;
                              });
                              if (widget.obsecure) {
                                _widgetProvider.changeIcon(
                                  Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  ),
                                );
                              } else {
                                _widgetProvider.changeIcon(
                                  Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: width * .06,
                              height: width * .06,
                              decoration: BoxDecoration(),
                              child: Center(
                                child: _widgetProvider.icon,
                              ),
                            ),
                          )
                        : !widget.isPasswordText
                            ? widget.textEditingController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.textEditingController.text = '';
                                      });
                                    },
                                    child: SizedBox(
                                      width: width * .06,
                                      height: width * .06,
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : widget.textEditingController.text == ''
                                    ? SizedBox()
                                    : SizedBox()
                            : SizedBox()
                    : SizedBox(),
              ),
              onSaved: (newValue) {
                widget.validatorText = newValue;
              },
              maxLength: widget.maxLength,
              obscureText: widget.obsecure ? widget.obsecure : false,
              style: labelTextStyle,
            ),
    );
  }
}
