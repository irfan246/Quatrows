import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quatrows/application/easy_bloc/quatrows_bloc.dart';
import 'package:quatrows/presentation/page/end_game.dart';
import 'package:quatrows/presentation/widget/button_answer.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;

    double fontSize() {
      if (screenWidth < 1844) {
        return screenWidth * 0.01054166;
      } else if (screenWidth < 900) {
        return screenWidth * 0.00854166;
      } else {
        return screenWidth * 0.01354166;
      }
    }

    return BlocBuilder<QuatrowsBloc, QuatrowsState>(
      builder: (context, state) {
        if (state is QuatrowsLoadedState) {
          return SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: screenHight * 0.1362346,
                automaticallyImplyLeading: false,
                flexibleSpace: Stack(
                  children: [
                    Positioned(
                      left: screenWidth * 0.02604166,
                      top: screenHight * 0.0285,
                      child: IconButton(
                        onPressed: () {
                          context.read<QuatrowsBloc>().add(ResetGameEvent());
                          Navigator.of(context).pop();
                        },
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        icon: Image.asset(
                          'assets/images/icon_back_white.png',
                          width: screenWidth * 0.0421875,
                          height: screenHight * 0.076632,
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  'Mudah',
                  style: TextStyle(
                    color: Color(0xFFFBF5F3),
                    fontSize: screenWidth * 0.025,
                    fontFamily: 'Coolvetica',
                  ),
                ),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: screenWidth * 0.522,
                      height: screenHight * 0.75686,
                      child: GridView.builder(
                        itemCount: 16,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: screenWidth * 0.0104166,
                          mainAxisSpacing: screenHight * 0.019,
                          childAspectRatio: 1.6,
                        ),
                        itemBuilder: (context, index) {
                          final text = state.listText[index];
                          final isSelected = state.selectedTexts.contains(text);
                          final isCorrectGroup =
                              index >= (16 - state.correctGroups * 4);
                          return ButtonAnswer(
                            text: text,
                            isSelected: isSelected,
                            isCorrectGroup: isCorrectGroup,
                            onTap: () {
                              if (!isSelected && !isCorrectGroup) {
                                context
                                    .read<QuatrowsBloc>()
                                    .add(SelectEvent(text));
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHight * 0.037843,
                      left: screenWidth * 0.02604166,
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.00522),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(screenWidth * 0.0078125,
                                  screenHight * 0.009463),
                              color: Color(0xFFA669A3),
                            ),
                            BoxShadow(
                              offset: Offset(-screenWidth * 0.0078125,
                                  screenHight * 0.009463),
                              color: Color(0xFFA669A3),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<QuatrowsBloc>()
                                .add(CancelSelectionEvent());
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                screenWidth * 0.075, screenHight * 0.0832545),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.00522),
                            ),
                            backgroundColor: Color(0xFFB370B0),
                          ),
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              fontFamily: 'Coolvetica',
                              fontSize: fontSize(),
                              color: Color(0xFF1E1D1C),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHight * 0.037843,
                      right: screenWidth * 0.02604166,
                    ),
                    child: (state.selectedTexts.length % 4 != 0 ||
                            state.selectedTexts.isEmpty)
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    screenWidth * 0.00522),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(screenWidth * 0.0078125,
                                        screenHight * 0.009463),
                                    color: Color.fromARGB(255, 67, 141, 82),
                                  ),
                                  BoxShadow(
                                    offset: Offset(-screenWidth * 0.0078125,
                                        screenHight * 0.009463),
                                    color: Color.fromARGB(255, 67, 141, 82),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(screenWidth * 0.075,
                                      screenHight * 0.0832545),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.00522),
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 49, 139, 67),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Cek Jawaban',
                                  style: TextStyle(
                                    fontFamily: 'Coolvetica',
                                    fontSize: fontSize(),
                                    color: Color.fromARGB(255, 231, 231, 231),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.bottomRight,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    screenWidth * 0.00522),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(screenWidth * 0.0078125,
                                        screenHight * 0.009463),
                                    color: Color(0xFF3EA653),
                                  ),
                                  BoxShadow(
                                    offset: Offset(-screenWidth * 0.0078125,
                                        screenHight * 0.009463),
                                    color: Color(0xFF3EA653),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<QuatrowsBloc>()
                                      .add(CheckAnswerEvent());
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(screenWidth * 0.075,
                                      screenHight * 0.0832545),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.00522),
                                  ),
                                  backgroundColor: Color(0xFF4FC767),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Cek Jawaban',
                                  style: TextStyle(
                                    fontFamily: 'Coolvetica',
                                    fontSize: fontSize(),
                                    color: Color(0xFF1E1D1C),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHight * 0.428,
                      right: screenWidth * 0.04948,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: screenWidth * 0.0323,
                        height: screenHight * 0.07,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: state.errors > 0
                                ? Colors.transparent
                                : Color(0xFFFBF5F3),
                          ),
                          child: state.errors > 0
                              ? Image.asset(
                                  'assets/images/icon_wrong.png',
                                  width: screenWidth * 0.042,
                                  height: screenHight * 0.071,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHight * 0.331128,
                      right: screenWidth * 0.04948,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: screenWidth * 0.0323,
                        height: screenHight * 0.07,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: state.errors > 1
                                ? Colors.transparent
                                : Color(0xFFFBF5F3),
                          ),
                          child: state.errors > 1
                              ? Image.asset(
                                  'assets/images/icon_wrong.png',
                                  width: screenWidth * 0.042,
                                  height: screenHight * 0.071,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: screenHight * 0.23653,
                      right: screenWidth * 0.04948,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: screenWidth * 0.0323,
                        height: screenHight * 0.07,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: state.errors > 2
                                ? Colors.transparent
                                : Color(0xFFFBF5F3),
                          ),
                          child: state.errors > 2
                              ? Image.asset(
                                  'assets/images/icon_wrong.png',
                                  width: screenWidth * 0.042,
                                  height: screenHight * 0.071,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is QuatrowsWinState) {
          return EndGame(
            onTap: () {
              context.read<QuatrowsBloc>().add(ResetGameEvent());
              Navigator.of(context).pop();
            },
            title: 'Selamat !',
            subTitle: 'Kamu Berhasil Menemukan Semua Kelompoknya',
          );
        } else if (state is QuatrowsLoseState) {
          return EndGame(
            onTap: () {
              context.read<QuatrowsBloc>().add(ResetGameEvent());
              Navigator.of(context).pop();
            },
            title: 'Gagal !',
            subTitle: 'Kamu Gagal Menemukan Semua Kelompoknya',
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
