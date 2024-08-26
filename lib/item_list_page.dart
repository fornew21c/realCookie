import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:real_cookie/constants.dart';
import 'package:real_cookie/item_basket_page.dart';
import 'package:real_cookie/item_detail_page.dart';
import 'package:real_cookie/models/product.dart';
import 'package:real_cookie/my_order_list_page.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {

  List<Product> productList = [
    Product(
        productNo: 1,
        productName: "르뱅 쿠키",
        productImageUrl: "https://raw.githubusercontent.com/fornew21c/realCookie/main/images/levainCookie.jpeg",
        price: 4000),
    Product(
        productNo: 2,
        productName: "오레오 쿠키",
        productImageUrl: "https://raw.githubusercontent.com/fornew21c/realCookie/main/images/OreoCookie.jpeg",
        price: 3000),
    Product(
        productNo: 3,
        productName: "초코 쿠키",
        productImageUrl: "https://raw.githubusercontent.com/fornew21c/realCookie/main/images/ChocoCookie.jpeg",
        price: 3500),
    Product(
        productNo: 4,
        productName: "화이트 초코 쿠키",
        productImageUrl: "https://raw.githubusercontent.com/fornew21c/realCookie/main/images/WhiteChochoCookie.jpeg",
        price: 3500),
    Product(
        productNo: 5,
        productName: "플레인 스콘",
        productImageUrl: "https://raw.githubusercontent.com/fornew21c/realCookie/main/images/PlainScon.jpeg",
        price: 3000),
    Product(
        productNo: 6,
        productName: "얼그레이 스콘",
        productImageUrl: "https://raw.githubusercontent.com/fornew21c/realCookie/main/images/earlGrayScon.jpeg",
        price: 3500),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("쿠키 & 스콘"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const MyOrderListPage();
                  },
                ),
              );
            },
          ),
            IconButton(
              icon: const Icon(
                Icons.shopping_cart
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const ItemBasketPage();
                    },
                  ),
                );
              },
            ),
        ],
      ),
      body: GridView.builder(
        itemCount: productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.9,
          crossAxisCount: 2,
          // mainAxisExtent: 250,
        ),
        itemBuilder: (context, index) {
          return productContainer(
              productNo: productList[index].productNo ?? 0,
              productName: productList[index].productName ?? "",
              productImageUrl: productList[index].productImageUrl ?? "",
              price: productList[index].price ?? 0);
        },
      ),
    );
  }

  Widget productContainer(
      {
      required int productNo,
      required String productName,
      required String productImageUrl,
      required double price}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ItemDetailsPage(
                productNo: productNo,
                productName: productName,
                productImageUrl: productImageUrl,
                price: price);
          },
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            CachedNetworkImage(
              height: 150,
              fit: BoxFit.cover,
              imageUrl: productImageUrl,
              placeholder: (context, url) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return const Center(
                  child: Text("오류 발생"),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("${numberFormat.format(price)}원"),
            ),
          ],
        ),
      ),
    );
  }
}