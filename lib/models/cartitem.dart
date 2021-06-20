class CartItem{
  final String cartItemId;
  final String productId;
  final String uid;
  final int quantity;

  CartItem({this.productId,this.uid,this.quantity,this.cartItemId});

  Map<String,dynamic> toMap(){
    return {
      'productId' : productId,
      'quantity' : quantity,
      'cartItemId' : cartItemId,
      'uid' : uid
    };
  }

  CartItem.fromFirestore(Map<String, dynamic> firestore)
      : productId = firestore['productId'],
        quantity = firestore['quantity'],
        cartItemId = firestore['cartItemId'],
        uid = firestore['uid'];
}
