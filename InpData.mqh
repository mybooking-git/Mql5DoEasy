//+------------------------------------------------------------------+
//|                                                      InpData.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "GraphINI.mqh"
//+------------------------------------------------------------------+
//| Macro substitutions                                              |
//+------------------------------------------------------------------+
#define COMPILE_EN // Comment out the string for compilation in Russian 
//+------------------------------------------------------------------+
//| Input enumerations                                               |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| English language inputs                                          |
//+------------------------------------------------------------------+
#ifdef COMPILE_EN
//+------------------------------------------------------------------+
//| Modes of working with symbols                                    |
//+------------------------------------------------------------------+
enum ENUM_SYMBOLS_MODE
  {
   SYMBOLS_MODE_CURRENT,                              // Work only with the current Symbol
   SYMBOLS_MODE_DEFINES,                              // Work with a given list of Symbols
   SYMBOLS_MODE_MARKET_WATCH,                         // Work with Symbols from the "Market Watch" window
   SYMBOLS_MODE_ALL                                   // Work with a complete list of Symbols
  };
//+------------------------------------------------------------------+
//| Modes of working with timeframes                                 |
//+------------------------------------------------------------------+
enum ENUM_TIMEFRAMES_MODE
  {
   TIMEFRAMES_MODE_CURRENT,                           // Work only with the current timeframe
   TIMEFRAMES_MODE_LIST,                              // Work with a given list of timeframes
   TIMEFRAMES_MODE_ALL                                // Work with a complete list of timeframes
  };
//+------------------------------------------------------------------+
//| "Yes"/"No"                                                       |
//+------------------------------------------------------------------+
enum ENUM_INPUT_YES_NO
  {
   INPUT_NO  = 0,                                     // No
   INPUT_YES = 1                                      // Yes
  };
//+------------------------------------------------------------------+
//| Select color themes                                              |
//+------------------------------------------------------------------+
enum ENUM_INPUT_COLOR_THEME
  {
   INPUT_COLOR_THEME_BLUE_STEEL,                      // Blue steel
   INPUT_COLOR_THEME_LIGHT_CYAN_GRAY,                 // Light cyan gray
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Russian language inputs                                          |
//+------------------------------------------------------------------+
#else  
//+------------------------------------------------------------------+
//| Modes of working with symbols                                    |
//+------------------------------------------------------------------+
enum ENUM_SYMBOLS_MODE
  {
   SYMBOLS_MODE_CURRENT,                              // Работа только с текущим символом
   SYMBOLS_MODE_DEFINES,                              // Работа с заданным списком символов
   SYMBOLS_MODE_MARKET_WATCH,                         // Работа с символами из окна "Обзор рынка"
   SYMBOLS_MODE_ALL                                   // Работа с полным списком символов
  };
//+------------------------------------------------------------------+
//| Modes of working with timeframes                                 |
//+------------------------------------------------------------------+
enum ENUM_TIMEFRAMES_MODE
  {
   TIMEFRAMES_MODE_CURRENT,                           // Работа только с текущим таймфреймом
   TIMEFRAMES_MODE_LIST,                              // Работа с заданным списком таймфреймов
   TIMEFRAMES_MODE_ALL                                // Работа с полным списком таймфреймов
  };
//+------------------------------------------------------------------+
//| "Да"/"Нет"                                                       |
//+------------------------------------------------------------------+
enum ENUM_INPUT_YES_NO
  {
   INPUT_NO  = 0,                                     // Нет
   INPUT_YES = 1                                      // Да
  };
//+------------------------------------------------------------------+
//| Select color themes                                              |
//+------------------------------------------------------------------+
enum ENUM_COLOR_THEME
  {
   COLOR_THEME_BLUE_STEEL,                            // Голубая сталь
   COLOR_THEME_LIGHT_CYAN_GRAY,                       // Светлый серо-циановый
  };
//+------------------------------------------------------------------+
#endif 
//+------------------------------------------------------------------+
