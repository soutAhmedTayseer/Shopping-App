import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../shop/cubit_shop.dart';
import '../web_view/web_view_screen.dart';

Widget buildArticleItem(articles,context)=> InkWell(
  onTap: () {
    // navigateTo(context, Webviewscreen(articles['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: NetworkImage('${articles['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Expanded(
                  child: Text(
                    '${articles['title']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${articles['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
      ],
    ),
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder(list, context, {isSearch = false})
{
  if (list.length > 0)
  {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: 40,
    );
  } else {
    return isSearch ? Container() : Center(child: CircularProgressIndicator());
  }
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateandfinish(context , widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);

void ShowToast({required String text,required ChooseToastColor state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor:ChooseColor(state) ,
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ChooseToastColor{SUCSESS,ERROR,WARNING}

Color ChooseColor(ChooseToastColor state){
  Color color;
  switch(state)
  {
    case ChooseToastColor.ERROR:
      color=Colors.red;
      break;

    case ChooseToastColor.SUCSESS:
      color=Colors.green;
      break;

    case ChooseToastColor.WARNING:
      color=Colors.yellow;
      break;

  }
  return color;
}


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,Function(String)? onSubmit, // Use String type for onSubmit
  Function(String)? onChange, // Use String type for onChange
  VoidCallback? onTap, // Use VoidCallback for onTap
  bool isPassword = false,
  required String? Function(String?) validate, // Specify returntype for validate
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed, // Use VoidCallback for suffixPressed
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),suffixIcon: suffix != null
          ? IconButton(
        onPressed: suffixPressed,
        icon: Icon(suffix),
      )
          : null,
        border: OutlineInputBorder(),
      ),
    );


Widget defaultButton({
  double width = double.infinity,
  required Color background ,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function, // Required button press callback
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,child: MaterialButton(
      onPressed: function,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget buildListProduct(
    model,
    context,
    {
      bool isOldPrice = true,
    }
    ) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.fill,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton( // Assuming you want to uncomment this later
                        onPressed: () {
                          if (model.id != null) {
                            ShopCubit.get(context).changeFavorites(model.id!); // Use non-null assertion operator (!)
                          }
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: (ShopCubit.get(context).favorites[model.id] ?? true) // Use null-aware operator (??)
                              ? Colors.pinkAccent
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );