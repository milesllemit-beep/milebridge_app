import 'package:flutter/material.dart';

class AlphabetScreen extends StatelessWidget {
  const AlphabetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> letters = List.generate(
      26,
      (index) => String.fromCharCode(65 + index),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFEAF7F8),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF008080),

        title: const Text(
          "Learn Sign Language",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),

        child: GridView.builder(
          itemCount: letters.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),

          itemBuilder: (context, index) {
            final letter = letters[index];

            return GestureDetector(
              onTap: () {
                _showLetterDialog(
                  context,
                  letter,
                );
              },

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(22),

                  border: Border.all(
                    color: const Color(0x33008080),
                    width: 1.5,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.05,
                      ),

                      blurRadius: 12,

                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Center(
                  child: Text(
                    letter,

                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF008080),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showLetterDialog(
    BuildContext context,
    String letter,
  ) {
    final String imagePath =
        'assets/alphabet/${letter.toLowerCase()}.png';

    showDialog(
      context: context,

      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),

          child: Padding(
            padding: const EdgeInsets.all(22),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                // TITLE
                Text(
                  "LETTER $letter",

                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF008080),
                  ),
                ),

                const SizedBox(height: 20),

                // IMAGE CARD
                Container(
                  height: 250,
                  width: 250,

                  decoration: BoxDecoration(
                    color: const Color(0xFFF7FBFB),

                    borderRadius:
                        BorderRadius.circular(22),

                    border: Border.all(
                      color: const Color(0x22008080),
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(18),

                      child: Image.asset(
                        imagePath,

                        fit: BoxFit.contain,

                        errorBuilder:
                            (
                          context,
                          error,
                          stackTrace,
                        ) {

                          debugPrint(
                            "FAILED TO LOAD: $imagePath",
                          );

                          debugPrint(
                            error.toString(),
                          );

                          return const Center(
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,

                              children: [

                                Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                  size: 60,
                                ),

                                SizedBox(height: 12),

                                Text(
                                  "Image Not Found",

                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "American Sign Language Gesture",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF008080),

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 15,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),

                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      "CLOSE",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}