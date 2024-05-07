import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    print("Skilld length: ${items.length}");
    return items.isNotEmpty
        ? SizedBox(
          width: double.infinity,
          child: 
            GridView.builder(
            shrinkWrap:true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2, // Adjust this ratio as needed
            ),
            itemCount: items.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Text(
                      items[index],
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                ),
              );
            }))
       
          
        

        ): const Center(
          child: Text('No items'),
        );
        
      
  }
}