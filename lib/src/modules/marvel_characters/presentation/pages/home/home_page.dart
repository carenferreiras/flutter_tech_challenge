import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tech_challenge/src/core/core.dart';
import 'package:provider/provider.dart';

import '../../../marvel_characters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CharacterProvider>(context, listen: false).fetchCharacters();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Consumer<CharacterProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
              child: SpinKitThreeBounce(
            color: AppColors.backgroundDarkGrey,
          ));
        } else if (provider.characters.isEmpty) {
          return const Center(child: Text('No characters available'));
        } else {
          final lastClickedCharacters = provider.getLastClickedCharacters();

          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleSection(text: AppStrings.titleSection1),
                const SizedBox(
                  height: AppSizes.s16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppSizes.s24),
                  child: SizedBox(
                    height: AppSizes.s180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lastClickedCharacters.length,
                      itemBuilder: (context, index) {
                        final character = lastClickedCharacters[index];
                        return CharacterCardWidget(
                          imageUrl: character.imageUrl,
                          characterName: character.name,
                          onTap: () {
                            Provider.of<CharacterProvider>(context,
                                    listen: false)
                                .incrementCharacterClick(character.id);
                            Navigator.pushNamed(
                              context,
                              '/details',
                              arguments:
                                  character,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                _titleSection(text: AppStrings.titleSection2),
                SearchBarWidget(
                  onChanged: (value) {
                    setState(() {});
                    Provider.of<CharacterProvider>(context, listen: false)
                        .filterCharactersByName(value);
                  },
                ),
                const SizedBox(height: AppSizes.s24),
                Expanded(
                  flex: 1,
                  child: GridView.count(
                    mainAxisSpacing: AppSizes.s24,
                    crossAxisSpacing: AppSizes.s24,
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(AppSizes.s24),
                    children: List.generate(
                      provider.filteredCharacters.length,
                      (index) {
                        final character = provider.filteredCharacters[index];
                        return CharacterCardWidget(
                          onTap: () {
                            Provider.of<CharacterProvider>(context,
                                    listen: false)
                                .incrementCharacterClick(character.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CharacterDetailsPage(character: character),
                              ),
                            );
                          },
                          imageUrl: character.imageUrl,
                          characterName: character.name,
                          size: AppSizes.s156,
                          linearSize: AppSizes.s54,
                          paddinRight: 0,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _titleSection({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppSizes.s24, right: AppSizes.s24, top: AppSizes.s24),
      child: Text(
        text,
        style:
            AppTextStyles.characterNameStyle(color: AppColors.backgroundBlack),
      ),
    );
  }
}
