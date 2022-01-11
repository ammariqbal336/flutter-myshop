import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/product.dart';
import 'package:shop/provider/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _pricefocusNode = FocusNode();
  final _descriptionfocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Product _product =
      Product(id: "", title: "", description: "", price: 0, imageUrl: "");
  var _isInit = true;
  @override
  void dispose() {
    _pricefocusNode.dispose();
    _descriptionfocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit && ModalRoute.of(context)?.settings.arguments != null) {
      Product _editProduct =
          ModalRoute.of(context)?.settings.arguments as Product;
      if (_editProduct != null) {
        _product = _editProduct;
        _imageUrlController.text = _product.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final _isValid = _form.currentState?.validate() ?? false;
    if (!_isValid) {
      return;
    }
    _form.currentState?.save();
    if (_product.id.isNotEmpty) {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_product);
    } else {
      Provider.of<ProductProvider>(context, listen: false).addProduct(_product);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    initialValue: _product.title,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_pricefocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Title";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _product = Product(
                          id: _product.id,
                          title: value ?? "",
                          price: _product.price,
                          description: _product.description,
                          imageUrl: _product.imageUrl,
                          isFavorite: _product.isFavorite);
                    },
                  ),
                  TextFormField(
                    initialValue: _product.price.toString(),
                    decoration: const InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _pricefocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionfocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Price";
                      }
                      if (double.tryParse(value) == null) {
                        return "Enter Valid Price";
                      }
                      if (double.parse(value) <= 0) {
                        return "Price must be greater than zero.";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _product = Product(
                          id: _product.id,
                          title: _product.title,
                          price: value != null ? double.parse(value) : 0,
                          description: _product.description,
                          imageUrl: _product.imageUrl,
                          isFavorite: _product.isFavorite);
                    },
                  ),
                  TextFormField(
                    initialValue: _product.description,
                    decoration: const InputDecoration(labelText: 'Description'),
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionfocusNode,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Description";
                      }
                      if (value.length < 10) {
                        return "Description must be greater than 10 characters";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _product = Product(
                          id: _product.id,
                          title: _product.title,
                          price: _product.price,
                          description: value ?? "",
                          imageUrl: _product.imageUrl,
                          isFavorite: _product.isFavorite);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? const Text("Enter Image Url")
                            : FittedBox(
                                child: Image.network(_imageUrlController.text),
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Image Url'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            setState(() {});
                          },
                          onSaved: (value) {
                            _product = Product(
                                id: _product.id,
                                title: _product.title,
                                price: _product.price,
                                description: _product.description,
                                imageUrl: value ?? "",
                                isFavorite: _product.isFavorite);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Image Url";
                            }
                            if (!value.startsWith("http") &&
                                !value.startsWith("https")) {
                              return "Url must be start with http or https";
                            }
                            if (!value.endsWith(".png") &&
                                !value.endsWith(".jpg") &&
                                !value.endsWith(".jpeg")) {
                              return "Url must be .jpg, .png or .jpeg";
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          controller: _imageUrlController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
