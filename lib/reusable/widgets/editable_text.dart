import 'package:flutter/material.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';

class EditableInfoField extends StatefulWidget {
   EditableInfoField(
      {Key? key,
      required this.textEditingController,
      required this.hint,
      required this.iconName,
      this.containerWidth,
      this.trailing,
      this.keyboardType,
        this.passwordIcon,
      this.isPassword,
      this.isObsecure,
      this.label,
      })
      : super(key: key);
  final TextEditingController textEditingController;
  final String hint;
   final String? label;
  final IconData iconName;
   Widget? passwordIcon;
  final TextInputType? keyboardType;
  final double? containerWidth;
  final Widget? trailing;
   bool? isPassword=false;
   bool? isObsecure=false;

  @override
  _EditableInfoFieldState createState() => _EditableInfoFieldState();
}

class _EditableInfoFieldState extends State<EditableInfoField> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      keyboardType: widget.keyboardType ?? TextInputType.text,
      controller: widget.textEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return '${widget.hint} can\'t be empty';
        } else {
          // widget.subCategoryName=value;
        }
        return null;
      },

      // },
      onChanged: (value) {},
      obscureText: widget.isObsecure??false,
      cursorColor: Theme.of(context).primaryColor,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        labelText: widget.label??widget.hint,
          prefixIcon:Icon(widget.iconName) ,
          prefixIconColor: Theme.of(context).primaryColor,
          suffix: widget.trailing ??  null,
          suffixIcon: widget.isPassword!?widget.passwordIcon:null,
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 13,
            color: ColorManager.lightGrey,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15)
          ),
          border: InputBorder.none),


    );
  }

}
