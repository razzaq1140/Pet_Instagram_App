import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../constants/global_variables.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final VoidCallback onLike;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onLike,
    required this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme(context).onPrimary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: colorScheme(context).outline.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 70),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: colorScheme(context).outline.withOpacity(0.2),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(widget.product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 0,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.product.isFavorite = !widget.product.isFavorite;
                      });
                      widget.onLike();
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: colorScheme(context).primary,
                        ),
                        child: Icon(
                          // Icons.favorite,
                          // color: widget.product.isFavorite
                          //     ? Colors.red // Color when liked
                          //     : Colors.grey, // Color when not liked
                          // size: 20,
                          Icons.favorite,
                          color: widget.product.isFavorite
                              ? Theme.of(context)
                                  .colorScheme
                                  .error // Color when liked
                              : colorScheme(context)
                                  .onPrimary, // Color when not liked
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.title,
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  "\$${widget.product.price}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: colorScheme(context).primary,
                  child: IconButton(
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: colorScheme(context).surface,
                      size: 18,
                    ),
                    onPressed: () {}, // Add your logic here
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
