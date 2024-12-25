import 'package:shopping_app/components/product_card.dart';
import 'package:shopping_app/entity/product.dart';
import 'package:shopping_app/entity/shoppingCart.dart';
import 'package:shopping_app/my_details_product.dart';
import 'package:shopping_app/utils/navigate_helper.dart';

ProductCard _buildRelatedProductCard(Product product) {
  return ProductCard(
    product: product,
    onAddToCart: (product) {
      setState(() {
        cart.add(product, quantity: 1);
      });
    },
    onProductTap: () {
      navigateToScreenWithPara(
          context, ProductDetailPage(productId: product.id), setState);
    },
    isLoggedIn: userData != null,
  );
}
