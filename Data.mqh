//+------------------------------------------------------------------+
//|                                                         Data.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "InpData.mqh"
//+------------------------------------------------------------------+
//| Macro substitutions                                              |
//+------------------------------------------------------------------+
#define INPUT_SEPARATOR                (",")    // Separator in the inputs string
#define TOTAL_LANG                     (2)      // Number of used languages
//+------------------------------------------------------------------+
//| Structures                                                       |
//+------------------------------------------------------------------+
struct SDataCalculate
  {
   int         rates_total;                     // size of input time series
   int         prev_calculated;                 // number of handled bars at the previous call
   int         begin;                           // where significant data starts from
   double      price;                           // current array value for calculation
   MqlRates    rates;                           // Price structure
  } rates_data;
//+------------------------------------------------------------------+
//| Arrays                                                           |
//+------------------------------------------------------------------+
string            ArrayUsedSymbols[];           // Array of used symbols' names
ENUM_TIMEFRAMES   ArrayUsedTimeframes[];        //  Array of used timeframes
//+------------------------------------------------------------------+
//| Enumerations                                                     |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ 
//| Data sets                                                        |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Major Forex symbols                                              |
//+------------------------------------------------------------------+
string DataSymbolsFXMajors[]=
  {
   "AUDCAD","AUDCHF","AUDJPY","AUDNZD","AUDUSD","CADCHF","CADJPY","CHFJPY","EURAUD","EURCAD","EURCHF","EURGBP","EURJPY","EURNZD",
   "EURUSD","GBPAUD","GBPCAD","GBPCHF","GBPJPY","GBPNZD","GBPUSD","NZDCAD","NZDCHF","NZDJPY","NZDUSD","USDCAD","USDCHF","USDJPY"
  };
//+------------------------------------------------------------------+
//| Minor Forex symbols                                              |
//+------------------------------------------------------------------+
string DataSymbolsFXMinors[]=
  {
   "EURCZK","EURDKK","EURHKD","EURNOK","EURPLN","EURSEK","EURSGD","EURTRY","EURZAR","GBPSEK","GBPSGD"
      ,"NZDSGD","USDCZK","USDDKK","USDHKD","USDNOK","USDPLN","USDSEK","USDSGD","USDTRY","USDZAR"
  };
//+------------------------------------------------------------------+
//| Exotic Forex symbols                                             |
//+------------------------------------------------------------------+
string DataSymbolsFXExotics[]=
  {
   "EURMXN","USDCNH","USDMXN","EURTRY","USDTRY"
  };
//+------------------------------------------------------------------+
//| Forex RUB symbols                                                |
//+------------------------------------------------------------------+
string DataSymbolsFXRub[]=
  {
   "EURRUB","USDRUB"
  };
//+------------------------------------------------------------------+
//| Indicative Forex symbols                                         |
//+------------------------------------------------------------------+
string DataSymbolsFXIndicatives[]=
  {
   "EUREUC","USDEUC","USDUSC"
  };
//+------------------------------------------------------------------+
//| Metal symbols                                                    |
//+------------------------------------------------------------------+
string DataSymbolsMetalls[]=
  {
   "XAGUSD","XAUUSD"
  };
//+------------------------------------------------------------------+
//| Commodity symbols                                                |
//+------------------------------------------------------------------+
string DataSymbolsCommodities[]=
  {
   "BRN","WTI","NG"
  };
//+------------------------------------------------------------------+
//| Indices                                                          |
//+------------------------------------------------------------------+
string DataSymbolsIndexes[]=
  {
   "CAC40","HSI50","ASX200","STOXX50","NQ100","FTSE100","DAX30","IBEX35","SPX500","NIKK225"
   "Volatility 10 Index","Volatility 25 Index","Volatility 50 Index","Volatility 75 Index","Volatility 100 Index",
   "HF Volatility 10 Index","HF Volatility 50 Index","Crash 1000 Index","Boom 1000 Index","Step Index"
  };
//+------------------------------------------------------------------+
//| Cryptocurrency symbols                                           |
//+------------------------------------------------------------------+
string DataSymbolsCrypto[]=
  {
   "BCHUSD","BTCEUR","BTCUSD","DSHUSD","EOSUSD","ETHEUR","ETHUSD","LTCUSD","XRPUSD"
  };
//+------------------------------------------------------------------+
//| Options                                                          |
//+------------------------------------------------------------------+
string DataSymbolsOptions[]=
  {
   "BO Volatility 10 Index","BO Volatility 25 Index","BO Volatility 50 Index","BO Volatility 75 Index","BO Volatility 100 Index"
  };
//+------------------------------------------------------------------+
//| List of the library's text message indices                       |
//+------------------------------------------------------------------+
enum ENUM_MESSAGES_LIB
  {
   MSG_LIB_PARAMS_LIST_BEG=ERR_USER_ERROR_FIRST,      // Beginning of the parameter list
   MSG_LIB_PARAMS_LIST_END,                           // End of the parameter list
   MSG_LIB_PROP_NOT_SUPPORTED,                        // Property not supported
   MSG_LIB_PROP_NOT_SUPPORTED_MQL4,                   // Property not supported in MQL4
   MSG_LIB_PROP_NOT_SUPPORTED_MT5_LESS_2155,          // Property not supported in MetaTrader 5 versions lower than 2155
   MSG_LIB_PROP_NOT_SUPPORTED_POSITION,               // Property not supported for position
   MSG_LIB_PROP_NOT_SUPPORTED_PENDING,                // Property not supported for pending order
   MSG_LIB_PROP_NOT_SUPPORTED_MARKET,                 // Property not supported for market order
   MSG_LIB_PROP_NOT_SUPPORTED_MARKET_HIST,            // Property not supported for historical market order
   MSG_LIB_PROP_NOT_SET,                              // Value not set
   MSG_LIB_PROP_EMPTY,                                // Not set
   MSG_LIB_PROP_AUTO,                                 // Formed by the terminal
   MSG_LIB_PROP_AS_IN_ORDER,                          // According to the order expiration mode
   
   MSG_LIB_SYS_ERROR,                                 // Error
   MSG_LIB_SYS_NOT_SYMBOL_ON_SERVER,                  // Error. No such symbol on server
   MSG_LIB_SYS_NOT_SYMBOL_ON_LIST,                    // Error. No such symbol in the list of used symbols: 
   MSG_LIB_SYS_FAILED_PUT_SYMBOL,                     // Failed to place to market watch. Error: 
   MSG_LIB_SYS_NOT_GET_PRICE,                         // Failed to get current prices. Error: 
   MSG_LIB_SYS_NOT_GET_MARGIN_RATES,                  // Failed to get margin ratios. Error: 
   MSG_LIB_SYS_NOT_GET_DATAS,                         // Failed to get data
   
   MSG_LIB_SYS_FAILED_CREATE_STORAGE_FOLDER,          // Failed to create folder for storing files. Error: 
   MSG_LIB_SYS_FAILED_ADD_ACC_OBJ_TO_LIST,            // Error. Failed to add current account object to collection list
   MSG_LIB_SYS_FAILED_CREATE_CURR_ACC_OBJ,            // Error. Failed to create account object with current account data
   MSG_LIB_SYS_FAILED_OPEN_FILE_FOR_WRITE,            // Could not open file for writing
   MSG_LIB_SYS_INPUT_ERROR_NO_SYMBOL,                 // Input error: no symbol
   MSG_LIB_SYS_FAILED_CREATE_SYM_OBJ,                 // Failed to create symbol object
   MSG_LIB_SYS_FAILED_ADD_SYM_OBJ,                    // Failed to add symbol
   MSG_LIB_SYS_FAILED_CREATE_ELM_OBJ,                 // Failed to create the graphical element object
   MSG_LIB_SYS_OBJ_ALREADY_IN_LIST,                   // Such an object is already present in the list
   MSG_LIB_SYS_FAILED_GET_DATA_GRAPH_RES,             // Failed to receive graphical resource data
   
   MSG_LIB_SYS_NOT_GET_CURR_PRICES,                   // Failed to get current prices by event symbol
   MSG_LIB_SYS_EVENT_ALREADY_IN_LIST,                 // This event is already in the list
   MSG_LIB_SYS_FILE_RES_ALREADY_IN_LIST,              // This file already created and added to list:
   MSG_LIB_SYS_FAILED_CREATE_RES_LINK,                // Error. Failed to create object pointing to resource file
   MSG_LIB_SYS_ERROR_ALREADY_CREATED_COUNTER,         // Error. Counter with ID already created
   MSG_LIB_SYS_FAILED_CREATE_COUNTER,                 // Failed to create timer counter
   MSG_LIB_SYS_FAILED_CREATE_TEMP_LIST,               // Error creating temporary list
   MSG_LIB_SYS_ERROR_NOT_MARKET_LIST,                 // Error. This is not a market collection list
   MSG_LIB_SYS_ERROR_NOT_HISTORY_LIST,                // Error. This is not a history collection list
   MSG_LIB_SYS_FAILED_ADD_ORDER_TO_LIST,              // Could not add order to list
   MSG_LIB_SYS_FAILED_ADD_DEAL_TO_LIST,               // Could not add deal to list
   MSG_LIB_SYS_FAILED_ADD_CTRL_ORDER_TO_LIST,         // Failed to add control order
   MSG_LIB_SYS_FAILED_ADD_CTRL_POSITION_TO_LIST,      // Failed to add control position
   MSG_LIB_SYS_FAILED_ADD_MODIFIED_ORD_TO_LIST,       // Could not add modified order to list of modified orders
   MSG_LIB_SYS_FAILED_CREATE_TIMER,                   // Failed to create timer. Error: 
    
   MSG_LIB_SYS_NO_TICKS_YET,                          // No ticks yet
   MSG_LIB_SYS_FAILED_CREATE_OBJ_STRUCT,              // Could not create object structure
   MSG_LIB_SYS_FAILED_WRITE_UARRAY_TO_FILE,           // Could not write uchar array to file
   MSG_LIB_SYS_FAILED_LOAD_UARRAY_FROM_FILE,          // Could not load uchar array from file
   MSG_LIB_SYS_FAILED_CREATE_OBJ_STRUCT_FROM_UARRAY,  // Could not create object structure from uchar array
   MSG_LIB_SYS_FAILED_SAVE_OBJ_STRUCT_TO_UARRAY,      // Failed to save object structure to uchar array, error
   MSG_LIB_SYS_ERROR_INDEX,                           // Error. "index" value should be within 0 - 3
   MSG_LIB_SYS_ERROR_FAILED_CONV_TO_LOWERCASE,        // Failed to convert string to lowercase, error
   
   MSG_LIB_SYS_ERROR_EMPTY_SYMBOLS_STRING,            // Error. Predefined symbols string empty, to be used
   MSG_LIB_SYS_FAILED_PREPARING_SYMBOLS_ARRAY,        // Failed to prepare array of used symbols. Error 
   MSG_LIB_SYS_FAILED_GET_SYMBOLS_ARRAY,              // Failed to get array of used symbols.
   MSG_LIB_SYS_ERROR_EMPTY_PERIODS_STRING,            // Error. The string of predefined periods is empty and is to be used
   MSG_LIB_SYS_FAILED_PREPARING_PERIODS_ARRAY,        // Failed to prepare array of used periods. Error 
   MSG_LIB_SYS_INVALID_ORDER_TYPE,                    // Invalid order type:
   
   MSG_LIB_SYS_ERROR_FAILED_GET_PRICE_ASK,            // Failed to get Ask price. Error
   MSG_LIB_SYS_ERROR_FAILED_GET_PRICE_BID,            // Failed to get Bid price. Error
   MSG_LIB_SYS_ERROR_FAILED_GET_TIME,                 // Failed to get time. Error
   MSG_LIB_SYS_ERROR_FAILED_OPEN_BUY,                 // Failed to open Buy position. Error
   MSG_LIB_SYS_ERROR_FAILED_PLACE_BUYLIMIT,           // Failed to set BuyLimit order. Error
   MSG_LIB_SYS_ERROR_FAILED_PLACE_BUYSTOP,            // Failed to set BuyStop order. Error
   MSG_LIB_SYS_ERROR_FAILED_PLACE_BUYSTOPLIMIT,       // Failed to set BuyStopLimit order. Error
   MSG_LIB_SYS_ERROR_FAILED_OPEN_SELL,                // Failed to open Sell position. Error
   MSG_LIB_SYS_ERROR_FAILED_PLACE_SELLLIMIT,          // Failed to set SellLimit order. Error
   MSG_LIB_SYS_ERROR_FAILED_PLACE_SELLSTOP,           // Failed to set SellStop order. Error
   MSG_LIB_SYS_ERROR_FAILED_PLACE_SELLSTOPLIMIT,      // Failed to set SellStopLimit order. Error
   MSG_LIB_SYS_ERROR_FAILED_SELECT_POS,               // Failed to select position. Error
   MSG_LIB_SYS_ERROR_POSITION_ALREADY_CLOSED,         // Position already closed
   MSG_LIB_SYS_ERROR_NOT_POSITION,                    // Error. Not a position:
   MSG_LIB_SYS_ERROR_NO_OPEN_POSITION_WITH_TICKET,    // Error. No open position with ticket #
   MSG_LIB_SYS_ERROR_NO_PLACED_ORDER_WITH_TICKET,     // Error. No placed order with ticket #
   MSG_LIB_SYS_ERROR_FAILED_CLOSE_POS,                // Failed to closed position. Error 
   MSG_LIB_SYS_ERROR_FAILED_SELECT_POS_BY,            // Failed to select opposite position. Error
   MSG_LIB_SYS_ERROR_POSITION_BY_ALREADY_CLOSED,      // Opposite position already closed
   MSG_LIB_SYS_ERROR_NOT_POSITION_BY,                 // Error. Opposite position is not a position:
   MSG_LIB_SYS_ERROR_FAILED_CLOSE_POS_BY,             // Failed to close position by opposite one. Error
   MSG_LIB_SYS_ERROR_FAILED_SELECT_ORD,               // Failed to select order. Error 
   MSG_LIB_SYS_ERROR_ORDER_ALREADY_DELETED,           // Order already deleted
   MSG_LIB_SYS_ERROR_NOT_ORDER,                       // Error. Not an order:
   MSG_LIB_SYS_ERROR_FAILED_DELETE_ORD,               // Failed to delete order. Error
   MSG_LIB_SYS_ERROR_SELECT_CLOSED_POS_TO_MODIFY,     // Error. Closed position selected for modification:
   MSG_LIB_SYS_ERROR_FAILED_MODIFY_POS,               // Failed to modify position. Error 
   MSG_LIB_SYS_ERROR_SELECT_DELETED_ORD_TO_MODIFY,    // Error. Removed order selected for modification:
   MSG_LIB_SYS_ERROR_FAILED_MODIFY_ORD,               // Failed to modify order. Error
   MSG_LIB_SYS_ERROR_UNABLE_PLACE_WITHOUT_TIME_SPEC,  // Error: Cannot place order without explicitly specified expiration time
   MSG_LIB_SYS_ERROR_FAILED_GET_TRADE_OBJ,            // Error. Failed to get trading object
   MSG_LIB_SYS_ERROR_FAILED_GET_POS_OBJ,              // Error. Failed to get position object
   MSG_LIB_SYS_ERROR_FAILED_GET_ORD_OBJ,              // Error. Failed to get order object
   MSG_LIB_SYS_ERROR_FAILED_GET_SYM_OBJ,              // Error. Failed to get symbol object
   MSG_LIB_SYS_ERROR_CODE_OUT_OF_RANGE,               // Return code out of range of error codes
   MSG_LIB_SYS_FAILED_CREATE_PAUSE_OBJ,               // Failed to create the \"Pause\" object
   MSG_LIB_SYS_FAILED_CREATE_BAR_OBJ,                 // Failed to create the \"Bar\" object
   MSG_LIB_SYS_FAILED_SYNC_DATA,                      // Failed to synchronize data with the server
   MSG_LIB_SYS_FAILED_DRAWING_ARRAY_RESIZE,           // Failed to change the array size of drawn buffers
   MSG_LIB_SYS_FAILED_COLORS_ARRAY_RESIZE,            // Failed to change the color array size
   MSG_LIB_SYS_FAILED_ARRAY_RESIZE,                   // Failed to change the array size
   MSG_LIB_SYS_FAILED_ADD_BUFFER,                     // Failed to add buffer object to the list
   MSG_LIB_SYS_FAILED_CREATE_BUFFER_OBJ,              // Failed to create \"Indicator buffer\"
   MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST,                // Could not add object to the list
   
   MSG_LIB_SYS_FAILED_CREATE_LONG_DATA_OBJ,           // Failed to create long data object
   MSG_LIB_SYS_FAILED_CREATE_DOUBLE_DATA_OBJ,         // Failed to create double data object
   MSG_LIB_SYS_FAILED_CREATE_STRING_DATA_OBJ,         // Failed to create string data object
   
   MSG_LIB_SYS_FAILED_DECREASE_LONG_ARRAY,            // Failed to decrease long array size
   MSG_LIB_SYS_FAILED_DECREASE_DOUBLE_ARRAY,          // Failed to decrease double array size
   MSG_LIB_SYS_FAILED_DECREASE_STRING_ARRAY,          // Failed to decrease string array size
   
   MSG_LIB_SYS_FAILED_GET_LONG_DATA_OBJ,              // Failed to get long data object
   MSG_LIB_SYS_FAILED_GET_DOUBLE_DATA_OBJ,            // Failed to get double data object
   MSG_LIB_SYS_FAILED_GET_STRING_DATA_OBJ,            // Failed to get string data object
   
   MSG_LIB_SYS_REQUEST_OUTSIDE_LONG_ARRAY,            // Request outside long array
   MSG_LIB_SYS_REQUEST_OUTSIDE_DOUBLE_ARRAY,          // Request outside double array
   MSG_LIB_SYS_REQUEST_OUTSIDE_STRING_ARRAY,          // Request outside string array
   MSG_LIB_SYS_REQUEST_OUTSIDE_ARRAY,                 // Request outside the array
   MSG_LIB_SYS_FAILED_CONV_GRAPH_OBJ_COORDS_TO_XY,    // Failed to convert graphical object coordinates into screen ones
   MSG_LIB_SYS_FAILED_CONV_TIMEPRICE_COORDS_TO_XY,    // Failed to convert time/price coordinates into screen ones
   
   MSG_LIB_TEXT_YES,                                  // Yes
   MSG_LIB_TEXT_NO,                                   // No
   MSG_LIB_TEXT_AND,                                  // and
   MSG_LIB_TEXT_IN,                                   // in
   MSG_LIB_TEXT_TO,                                   // to
   
   MSG_LIB_TEXT_OPENED,                               // Opened
   MSG_LIB_TEXT_PLACED,                               // Placed
   MSG_LIB_TEXT_DELETED,                              // Deleted
   MSG_LIB_TEXT_CLOSED,                               // Closed
   MSG_LIB_TEXT_CLOSED_BY,                            // close by
   MSG_LIB_TEXT_CLOSED_VOL,                           // Closed volume
   MSG_LIB_TEXT_AT_PRICE,                             // at price
   MSG_LIB_TEXT_ON_PRICE,                             // on price
   MSG_LIB_TEXT_TRIGGERED,                            // Triggered
   MSG_LIB_TEXT_TURNED_TO,                            // turned to
   MSG_LIB_TEXT_ADDED,                                // Added
   MSG_LIB_TEXT_SYMBOL_ON_SERVER,                     // on server
   MSG_LIB_TEXT_SYMBOL_TO_LIST,                       // to list
   MSG_LIB_TEXT_FAILED_ADD_TO_LIST,                   // failed to add to list
   MSG_LIB_TEXT_TIME_UNTIL_THE_END_DAY,               // Order lifetime till the end of the current day to be used
   MSG_LIB_TEXT_OBJ_NO_PERIODS,                       // Not shown on any timeframe
   MSG_LIB_TEXT_OBJ_ALL_PERIODS,                      // Drawn on all timeframes
   
   MSG_LIB_TEXT_JANUARY,                              // January
   MSG_LIB_TEXT_FEBRUARY,                             // February
   MSG_LIB_TEXT_MARCH,                                // March
   MSG_LIB_TEXT_APRIL,                                // April
   MSG_LIB_TEXT_MAY,                                  // May
   MSG_LIB_TEXT_JUNE,                                 // June
   MSG_LIB_TEXT_JULY,                                 // July
   MSG_LIB_TEXT_AUGUST,                               // August
   MSG_LIB_TEXT_SEPTEMBER,                            // September
   MSG_LIB_TEXT_OCTOBER,                              // October
   MSG_LIB_TEXT_NOVEMBER,                             // November
   MSG_LIB_TEXT_DECEMBER,                             // December
   
   MSG_LIB_TEXT_ALIGN_LEFT,                           // Left alignment 
   MSG_LIB_TEXT_ALIGN_CENTER,                         // Center alignment
   MSG_LIB_TEXT_ALIGN_RIGHT,                          // Right alignment
   
   MSG_LIB_TEXT_GANN_UP_TREND,                        // Line corresponds to an uptrend
   MSG_LIB_TEXT_GANN_DOWN_TREND,                      // Line corresponds to a downtrend
   
   MSG_LIB_TEXT_ELLIOTT_GRAND_SUPERCYCLE,             // Grand Supercycle
   MSG_LIB_TEXT_ELLIOTT_SUPERCYCLE,                   // Supercycle
   MSG_LIB_TEXT_ELLIOTT_CYCLE,                        // Cycle
   MSG_LIB_TEXT_ELLIOTT_PRIMARY,                      // Primary cycle
   MSG_LIB_TEXT_ELLIOTT_INTERMEDIATE,                 // Intermediate
   MSG_LIB_TEXT_ELLIOTT_MINOR,                        // Minor cycle
   MSG_LIB_TEXT_ELLIOTT_MINUTE,                       // Minute
   MSG_LIB_TEXT_ELLIOTT_MINUETTE,                     // Second (Minuette)
   MSG_LIB_TEXT_ELLIOTT_SUBMINUETTE,                  // Subsecond (Subminuette)
   
   MSG_LIB_TEXT_BUTTON_STATE_PRESSED,                 // Pressed
   MSG_LIB_TEXT_BUTTON_STATE_DEPRESSED,               // Released
   
   MSG_LIB_TEXT_CORNER_LEFT_UPPER,                    // Center of coordinates at the upper left corner of the chart
   MSG_LIB_TEXT_CORNER_LEFT_LOWER,                    // Center of coordinates at the lower left corner of the chart
   MSG_LIB_TEXT_CORNER_RIGHT_LOWER,                   // Center of coordinates at the lower right corner of the chart
   MSG_LIB_TEXT_CORNER_RIGHT_UPPER,                   // Center of coordinates at the upper right corner of the chart
   
   MSG_LIB_TEXT_BORDER_FLAT,                          // Flat
   MSG_LIB_TEXT_BORDER_RAISED,                        // Raised
   MSG_LIB_TEXT_BORDER_SUNKEN,                        // Sunken
   
   MSG_LIB_TEXT_SUNDAY,                               // Sunday
   MSG_LIB_TEXT_MONDAY,                               // Monday
   MSG_LIB_TEXT_TUESDAY,                              // Tuesday
   MSG_LIB_TEXT_WEDNESDAY,                            // Wednesday
   MSG_LIB_TEXT_THURSDAY,                             // Thursday
   MSG_LIB_TEXT_FRIDAY,                               // Friday
   MSG_LIB_TEXT_SATURDAY,                             // Saturday
   MSG_LIB_TEXT_SYMBOL,                               // symbol: 
   MSG_LIB_TEXT_ACCOUNT,                              // account: 
   MSG_LIB_TEXT_CHART,                                // chart: 
   MSG_LIB_TEXT_CHART_WND,                            // chart window: 
   MSG_LIB_TEXT_PROP_VALUE,                           // Property value
   MSG_LIB_TEXT_INC_BY,                               // increased by
   MSG_LIB_TEXT_DEC_BY,                               // decreased by
   MSG_LIB_TEXT_MORE_THEN,                            // more than
   MSG_LIB_TEXT_LESS_THEN,                            // less than
   MSG_LIB_TEXT_EQUAL,                                // equal
   MSG_LIB_TEXT_ERROR_COUNTER_WITN_ID,                // Error. Counter with ID 
   MSG_LIB_TEXT_STEP,                                 // , step
   MSG_LIB_TEXT_AND_PAUSE,                            //  and pause 
   MSG_LIB_TEXT_ALREADY_EXISTS,                       // already exists
   MSG_LIB_TEXT_CREATED,                              // Created
   MSG_LIB_TEXT_ATTEMPTS,                             // Attempts
   MSG_LIB_TEXT_WAIT,                                 // Wait
   MSG_LIB_TEXT_END,                                  // End
   MSG_LIB_TEXT_PERIOD_CURRENT,                       // Current chart period
   
   MSG_LIB_TEXT_BASE_OBJ_UNKNOWN_EVENT,               // Base object unknown event
   MSG_LIB_TEXT_TERMINAL_NOT_MAIL_ENABLED,            // Sending emails disabled in terminal
   MSG_LIB_TEXT_TERMINAL_NOT_PUSH_ENABLED,            // Sending push notifications disabled in terminal
   MSG_LIB_TEXT_TERMINAL_NOT_FTP_ENABLED,             // Sending files to FTP address disabled in terminal
   
   MSG_LIB_TEXT_ARRAY_DATA_INTEGER_NULL,              // Controlled integer properties data array has zero size
   MSG_LIB_TEXT_NEED_SET_INTEGER_VALUE,               // You should first set the size of the array equal to the number of object integer properties
   MSG_LIB_TEXT_TODO_USE_INTEGER_METHOD,              // To do this, use the method
   MSG_LIB_TEXT_WITH_NUMBER_INTEGER_VALUE,            // with number value of integer properties of object in the parameter
   
   MSG_LIB_TEXT_ARRAY_DATA_DOUBLE_NULL,               // Controlled double properties data array has zero size
   MSG_LIB_TEXT_NEED_SET_DOUBLE_VALUE,                // You should first set the size of the array equal to the number of object double properties
   MSG_LIB_TEXT_TODO_USE_DOUBLE_METHOD,               // To do this, use the method
   MSG_LIB_TEXT_WITH_NUMBER_DOUBLE_VALUE,             // with number value of double properties of object in the parameter
   
   MSG_LIB_PROP_BID,                                  // Bid price
   MSG_LIB_PROP_ASK,                                  // Ask price
   MSG_LIB_PROP_LAST,                                 // Last deal price
   MSG_LIB_PROP_PRICE_SL,                             // StopLoss price
   MSG_LIB_PROP_PRICE_TP,                             // TakeProfit price
   MSG_LIB_PROP_DEAL_FEE,                             // Deal fee
   MSG_LIB_PROP_PROFIT,                               // Profit
   MSG_LIB_PROP_SYMBOL,                               // Symbol
   MSG_LIB_PROP_BALANCE,                              // Balance operation
   MSG_LIB_PROP_CREDIT,                               // Credit operation
   MSG_LIB_PROP_CLOSE_BY_SL,                          // Closing by StopLoss
   MSG_LIB_PROP_CLOSE_BY_TP,                          // Closing by TakeProfit
   MSG_LIB_PROP_ACCOUNT,                              // Account
   
//--- COrder
   MSG_ORD_BUY,                                       // Buy
   MSG_ORD_SELL,                                      // Sell
   MSG_ORD_TO_BUY,                                    // Buy order
   MSG_ORD_TO_SELL,                                   // Sell order
   MSG_DEAL_TO_BUY,                                   // Buy deal
   MSG_DEAL_TO_SELL,                                  // Sell deal
   MSG_ORD_MARKET,                                    // Market order
   MSG_ORD_HISTORY,                                   // Historical order
   MSG_ORD_DEAL,                                      // Deal
   MSG_ORD_POSITION,                                  // Position
   MSG_ORD_PENDING_ACTIVE,                            // Active pending order
   MSG_ORD_PENDING,                                   // Pending order
   MSG_ORD_UNKNOWN_TYPE,                              // Unknown order type
   MSG_POS_UNKNOWN_TYPE,                              // Unknown position type
   MSG_POS_UNKNOWN_DEAL,                              // Unknown deal type
   //---
   MSG_ORD_SL_ACTIVATED,                              // Due to StopLoss
   MSG_ORD_TP_ACTIVATED,                              // Due to TakeProfit
   MSG_ORD_PLACED_FROM_MQL4,                          // Placed from mql4 program
   MSG_ORD_STATE_CANCELLED,                           // Order cancelled
   MSG_ORD_STATE_CANCELLED_CLIENT,                    // Order withdrawn by client
   MSG_ORD_STATE_STARTED,                             // Order verified but not yet accepted by broker
   MSG_ORD_STATE_PLACED,                              // Order accepted
   MSG_ORD_STATE_PARTIAL,                             // Order filled partially
   MSG_ORD_STATE_FILLED,                              // Order filled in full
   MSG_ORD_STATE_REJECTED,                            // Order rejected
   MSG_ORD_STATE_EXPIRED,                             // Order withdrawn upon expiration
   MSG_ORD_STATE_REQUEST_ADD,                         // Order in the state of registration (placing in the trading system)
   MSG_ORD_STATE_REQUEST_MODIFY,                      // Order in the state of modification
   MSG_ORD_STATE_REQUEST_CANCEL,                      // Order in deletion state
   MSG_ORD_STATE_UNKNOWN,                             // Unknown state
   //---
   MSG_ORD_REASON_CLIENT,                             // Order set from desktop terminal
   MSG_ORD_REASON_MOBILE,                             // Order set from mobile app
   MSG_ORD_REASON_WEB,                                // Order set from web platform
   MSG_ORD_REASON_EXPERT,                             // Order set from EA or script
   MSG_ORD_REASON_SO,                                 // Due to Stop Out
   MSG_ORD_REASON_DEAL_CLIENT,                        // Deal carried out from desktop terminal
   MSG_ORD_REASON_DEAL_MOBILE,                        // Deal carried out from mobile app
   MSG_ORD_REASON_DEAL_WEB,                           // Deal carried out from web platform
   MSG_ORD_REASON_DEAL_EXPERT,                        // Deal carried out from EA or script
   MSG_ORD_REASON_DEAL_STOPOUT,                       // Due to Stop Out
   MSG_ORD_REASON_DEAL_ROLLOVER,                      // Due to position rollover
   MSG_ORD_REASON_DEAL_VMARGIN,                       // Due to variation margin
   MSG_ORD_REASON_DEAL_SPLIT,                         // Due to split
   MSG_ORD_REASON_POS_CLIENT,                         // Position opened from desktop terminal
   MSG_ORD_REASON_POS_MOBILE,                         // Position opened from mobile app
   MSG_ORD_REASON_POS_WEB,                            // Position opened from web platform
   MSG_ORD_REASON_POS_EXPERT,                         // Position opened from EA or script
   //---
   MSG_ORD_MAGIC,                                     // Magic number
   MSG_ORD_TICKET,                                    // Ticket
   MSG_ORD_TICKET_FROM,                               // Parent order ticket
   MSG_ORD_TICKET_TO,                                 // Inherited order ticket
   MSG_ORD_TIME_EXP,                                  // Expiration date
   MSG_ORD_TYPE_FILLING,                              // Execution type by residue
   MSG_ORD_TYPE_TIME,                                 // Order lifetime
   MSG_ORD_TYPE,                                      // Type
   MSG_ORD_TYPE_BY_DIRECTION,                         // Direction
   MSG_ORD_REASON,                                    // Reason
   MSG_ORD_POSITION_ID,                               // Position ID
   MSG_ORD_DEAL_ORDER_TICKET,                         // Deal by order ticket
   MSG_ORD_DEAL_ENTRY,                                // Deal direction
   MSG_ORD_DEAL_IN,                                   // Entry to market
   MSG_ORD_DEAL_OUT,                                  // Out from market
   MSG_ORD_DEAL_INOUT,                                // Reversal
   MSG_ORD_DEAL_OUT_BY,                               // Close by
   MSG_ORD_POSITION_BY_ID,                            // Opposite position ID
   MSG_ORD_TIME_OPEN,                                 // Open time in milliseconds
   MSG_ORD_TIME_CLOSE,                                // Close time in milliseconds
   MSG_ORD_TIME_UPDATE,                               // Position change time in milliseconds
   MSG_ORD_STATE,                                     // State
   MSG_ORD_STATUS,                                    // Status
   MSG_ORD_DISTANCE_PT,                               // Distance from price in points
   MSG_ORD_PROFIT_PT,                                 // Profit in points
   MSG_ORD_MAGIC_ID,                                  // Magic number ID
   MSG_ORD_GROUP_ID1,                                 // First group ID
   MSG_ORD_GROUP_ID2,                                 // Second group ID
   MSG_ORD_PEND_REQ_ID,                               // Pending request ID
   MSG_ORD_PRICE_OPEN,                                // Open price
   MSG_ORD_PRICE_CLOSE,                               // Close price
   MSG_ORD_PRICE_STOP_LIMIT,                          // Limit order price when StopLimit order activated
   MSG_ORD_COMMISSION,                                // Commission
   MSG_ORD_SWAP,                                      // Swap
   MSG_ORD_VOLUME,                                    // Volume
   MSG_ORD_VOLUME_CURRENT,                            // Unfulfilled volume
   MSG_ORD_PROFIT_FULL,                               // Profit+commission+swap
   MSG_ORD_COMMENT,                                   // Comment
   MSG_ORD_COMMENT_EXT,                               // Custom comment
   MSG_ORD_EXT_ID,                                    // Exchange ID
   MSG_ORD_CLOSE_BY,                                  // Closing order
   
//--- CEvent
   MSG_EVN_EVENT,                                     // Event
   MSG_EVN_TYPE,                                      // Event type
   MSG_EVN_TIME,                                      // Event time
   MSG_EVN_STATUS,                                    // Event status
   MSG_EVN_REASON,                                    // Event reason
   MSG_EVN_TYPE_DEAL,                                 // Deal type
   MSG_EVN_TICKET_DEAL,                               // Deal ticket
   MSG_EVN_TYPE_ORDER,                                // Event order type
   MSG_EVN_TYPE_ORDER_POSITION,                       // Position order type
   MSG_EVN_TICKET_ORDER_POSITION,                     // Position first order ticket
   MSG_EVN_TICKET_ORDER_EVENT,                        // Event order ticket
   MSG_EVN_POSITION_ID,                               // Position ID
   MSG_EVN_POSITION_BY_ID,                            // Opposite position ID
   MSG_EVN_MAGIC_BY_ID,                               // Opposite position magic number
   MSG_EVN_TIME_ORDER_POSITION,                       // Position open time
   MSG_EVN_TYPE_ORD_POS_BEFORE,                       // Position order type before changing direction
   MSG_EVN_TICKET_ORD_POS_BEFORE,                     // Position order ticket before changing direction
   MSG_EVN_TYPE_ORD_POS_CURRENT,                      // Current position order type
   MSG_EVN_TICKET_ORD_POS_CURRENT,                    // Current position order ticket
   MSG_EVN_PRICE_EVENT,                               // Price during an event
   MSG_EVN_VOLUME_ORDER_INITIAL,                      // Order initial volume
   MSG_EVN_VOLUME_ORDER_EXECUTED,                     // Executed order volume
   MSG_EVN_VOLUME_ORDER_CURRENT,                      // Remaining order volume
   MSG_EVN_VOLUME_POSITION_EXECUTED,                  // Current position volume
   MSG_EVN_PRICE_OPEN_BEFORE,                         // Price open before modification
   MSG_EVN_PRICE_SL_BEFORE,                           // StopLoss price before modification
   MSG_EVN_PRICE_TP_BEFORE,                           // TakeProfit price before modification
   MSG_EVN_PRICE_EVENT_ASK,                           // Ask price during an event
   MSG_EVN_PRICE_EVENT_BID,                           // Bid price during an event
   MSG_EVN_SYMBOL_BY_POS,                             // Opposite position symbol
   //---
   MSG_EVN_STATUS_MARKET_PENDING,                     // Pending order placed
   MSG_EVN_STATUS_MARKET_POSITION,                    // Position opened
   MSG_EVN_STATUS_HISTORY_PENDING,                    // Pending order removed
   MSG_EVN_STATUS_HISTORY_POSITION,                   // Position closed
   MSG_EVN_STATUS_UNKNOWN,                            // Unknown status
   //---
   MSG_EVN_NO_EVENT,                                  // No trading event
   MSG_EVN_PENDING_ORDER_PLASED,                      // Pending order placed
   MSG_EVN_PENDING_ORDER_REMOVED,                     // Pending order removed
   MSG_EVN_ACCOUNT_CREDIT,                            // Accruing credit
   MSG_EVN_ACCOUNT_CREDIT_WITHDRAWAL,                 // Withdrawal of credit
   MSG_EVN_ACCOUNT_CHARGE,                            // Additional charges
   MSG_EVN_ACCOUNT_CORRECTION,                        // Correcting entry
   MSG_EVN_ACCOUNT_BONUS,                             // Charging bonuses
   MSG_EVN_ACCOUNT_COMISSION,                         // Additional commissions
   MSG_EVN_ACCOUNT_COMISSION_DAILY,                   // Commission charged at the end of a day
   MSG_EVN_ACCOUNT_COMISSION_MONTHLY,                 // Commission charged at the end of a trading month
   MSG_EVN_ACCOUNT_COMISSION_AGENT_DAILY,             // Agent commission charged at the end of a trading day
   MSG_EVN_ACCOUNT_COMISSION_AGENT_MONTHLY,           // Agent commission charged at the end of a month
   MSG_EVN_ACCOUNT_INTEREST,                          // Accruing interest on free funds
   MSG_EVN_BUY_CANCELLED,                             // Canceled buy deal
   MSG_EVN_SELL_CANCELLED,                            // Canceled sell deal
   MSG_EVN_DIVIDENT,                                  // Accruing dividends
   MSG_EVN_DIVIDENT_FRANKED,                          // Accrual of franked dividend
   MSG_EVN_TAX,                                       // Tax accrual
   MSG_EVN_BALANCE_REFILL,                            // Balance refill
   MSG_EVN_BALANCE_WITHDRAWAL,                        // Withdrawing funds from balance
   MSG_EVN_ACTIVATED_PENDING,                         // Pending order activated
   MSG_EVN_ACTIVATED_PENDING_PARTIALLY,               // Pending order partial activation
   MSG_EVN_POSITION_OPENED_PARTIALLY,                 // Position opened partially
   MSG_EVN_POSITION_CLOSED_PARTIALLY,                 // Position closed partially
   MSG_EVN_POSITION_CLOSED_BY_POS,                    // Position closed by opposite position
   MSG_EVN_POSITION_CLOSED_PARTIALLY_BY_POS,          // Position closed partially by opposite position
   MSG_EVN_POSITION_CLOSED_BY_SL,                     // Position closed by StopLoss
   MSG_EVN_POSITION_CLOSED_BY_TP,                     // Position closed by TakeProfit
   MSG_EVN_POSITION_CLOSED_PARTIALLY_BY_SL,           // Position closed partially by StopLoss
   MSG_EVN_POSITION_CLOSED_PARTIALLY_BY_TP,           // Position closed partially by TakeProfit
   MSG_EVN_POSITION_REVERSED_BY_MARKET,               // Position reversal by market request
   MSG_EVN_POSITION_REVERSED_BY_PENDING,              // Position reversal by triggered a pending order
   MSG_EVN_POSITION_REVERSE_PARTIALLY,                // Position reversal by partial request execution
   MSG_EVN_POSITION_VOLUME_ADD_BY_MARKET,             // Added volume to position by market request
   MSG_EVN_POSITION_VOLUME_ADD_BY_PENDING,            // Added volume to a position by activating a pending order
   MSG_EVN_MODIFY_ORDER_PRICE,                        // Modified order price
   MSG_EVN_MODIFY_ORDER_PRICE_SL,                     // Modified order price and StopLoss
   MSG_EVN_MODIFY_ORDER_PRICE_TP,                     // Modified order price and TakeProfit
   MSG_EVN_MODIFY_ORDER_PRICE_SL_TP,                  // Modified order price, StopLoss and TakeProfit
   MSG_EVN_MODIFY_ORDER_SL_TP,                        // Modified order's StopLoss and TakeProfit
   MSG_EVN_MODIFY_ORDER_SL,                           // Modified order StopLoss
   MSG_EVN_MODIFY_ORDER_TP,                           // Modified order TakeProfit
   MSG_EVN_MODIFY_POSITION_SL_TP,                     // Modified of position StopLoss and TakeProfit
   MSG_EVN_MODIFY_POSITION_SL,                        // Modified position's StopLoss
   MSG_EVN_MODIFY_POSITION_TP,                        // Modified position's TakeProfit
   //---
   MSG_EVN_REASON_ADD,                                // Added volume to position
   MSG_EVN_REASON_ADD_PARTIALLY,                      // Volume added to the position by partially completed request
   MSG_EVN_REASON_ADD_BY_PENDING_PARTIALLY,           // Added volume to a position by partial activation of a pending order
   MSG_EVN_REASON_STOPLIMIT_TRIGGERED,                // StopLimit order triggered
   MSG_EVN_REASON_MODIFY,                             // Modification
   MSG_EVN_REASON_CANCEL,                             // Cancelation
   MSG_EVN_REASON_EXPIRED,                            // Expired
   MSG_EVN_REASON_DONE,                               // Fully completed market request
   MSG_EVN_REASON_DONE_PARTIALLY,                     // Partially completed market request
   MSG_EVN_REASON_REVERSE,                            // Position reversal
   MSG_EVN_REASON_REVERSE_BY_PENDING_PARTIALLY,       // Position reversal in case of a pending order partial execution
   MSG_EVN_REASON_DONE_SL_PARTIALLY,                  // Partial closing by StopLoss
   MSG_EVN_REASON_DONE_TP_PARTIALLY,                  // Partial closing by TakeProfit
   MSG_EVN_REASON_DONE_BY_POS,                        // Close by
   MSG_EVN_REASON_DONE_PARTIALLY_BY_POS,              // Partial closing by an opposite position
   MSG_EVN_REASON_DONE_BY_POS_PARTIALLY,              // Closed by incomplete volume of opposite position
   MSG_EVN_REASON_DONE_PARTIALLY_BY_POS_PARTIALLY,    // Closed partially by incomplete volume of opposite position
   
//--- CSymbol
   MSG_SYM_PROP_INDEX,                                // Index in \"Market Watch window\"
   MSG_SYM_PROP_SECTOR,                               // Economic sector
   MSG_SYM_PROP_INDUSTRY,                             // Industry or economy branch
   MSG_SYM_PROP_CUSTOM,                               // Custom symbol
   MSG_SYM_PROP_CHART_MODE,                           // Price type used for generating symbols bars
   MSG_SYM_PROP_EXIST,                                // Symbol with this name exists
   MSG_SYM_PROP_SELECT,                               // Symbol selected in Market Watch
   MSG_SYM_PROP_VISIBLE,                              // Symbol visible in Market Watch
   MSG_SYM_PROP_SESSION_DEALS,                        // Number of deals in the current session
   MSG_SYM_PROP_SESSION_BUY_ORDERS,                   // Number of Buy orders at the moment
   MSG_SYM_PROP_SESSION_SELL_ORDERS,                  // Number of Sell orders at the moment
   MSG_SYM_PROP_VOLUME,                               // Volume of the last deal
   MSG_SYM_PROP_VOLUMEHIGH,                           // Maximal day volume
   MSG_SYM_PROP_VOLUMELOW,                            // Minimal day volume
   MSG_SYM_PROP_TIME,                                 // Latest quote time
   MSG_SYM_PROP_TIME_MSC,                             // Time of the last quote in milliseconds
   MSG_SYM_PROP_DIGITS,                               // Number of decimal places
   MSG_SYM_PROP_DIGITS_LOTS,                          // Digits after a decimal point in the value of the lot
   MSG_SYM_PROP_SPREAD,                               // Spread in points
   MSG_SYM_PROP_SPREAD_FLOAT,                         // Floating spread
   MSG_SYM_PROP_TICKS_BOOKDEPTH,                      // Maximum number of orders displayed in the Depth of Market
   MSG_SYM_PROP_TRADE_CALC_MODE,                      // Contract price calculation mode
   MSG_SYM_PROP_TRADE_MODE,                           // Order filling type
   MSG_SYM_PROP_START_TIME,                           // Symbol trading start date
   MSG_SYM_PROP_EXPIRATION_TIME,                      // Symbol trading end date
   MSG_SYM_PROP_TRADE_STOPS_LEVEL,                    // Minimal indention from the close price to place Stop orders
   MSG_SYM_PROP_TRADE_FREEZE_LEVEL,                   // Freeze distance for trading operations
   MSG_SYM_PROP_TRADE_EXEMODE,                        // Trade execution mode
   MSG_SYM_PROP_SWAP_MODE,                            // Swap calculation model
   MSG_SYM_PROP_SWAP_ROLLOVER3DAYS,                   // Triple-day swap day
   MSG_SYM_PROP_MARGIN_HEDGED_USE_LEG,                // Calculating hedging margin using the larger leg
   MSG_SYM_PROP_EXPIRATION_MODE,                      // Flags of allowed order expiration modes
   MSG_SYM_PROP_FILLING_MODE,                         // Flags of allowed order filling modes
   MSG_SYM_PROP_ORDER_MODE,                           // Flags of allowed order types
   MSG_SYM_PROP_ORDER_GTC_MODE,                       // Expiration of Stop Loss and Take Profit orders
   MSG_SYM_PROP_OPTION_MODE,                          // Option type
   MSG_SYM_PROP_OPTION_RIGHT,                         // Option right
   MSG_SYM_PROP_BACKGROUND_COLOR,                     // Background color of the symbol in Market Watch
   //---
   MSG_SYM_PROP_BIDHIGH,                              // Maximal Bid of the day
   MSG_SYM_PROP_BIDLOW,                               // Minimal Bid of the day
   MSG_SYM_PROP_ASKHIGH,                              // Maximum Ask of the day
   MSG_SYM_PROP_ASKLOW,                               // Minimal Ask of the day
   MSG_SYM_PROP_LASTHIGH,                             // Maximal Last of the day
   MSG_SYM_PROP_LASTLOW,                              // Minimal Last of the day
   MSG_SYM_PROP_VOLUME_REAL,                          // Real volume of the last deal
   MSG_SYM_PROP_VOLUMEHIGH_REAL,                      // Maximum real volume of the day
   MSG_SYM_PROP_VOLUMELOW_REAL,                       // Minimum real volume of the day
   MSG_SYM_PROP_OPTION_STRIKE,                        // Strike price
   MSG_SYM_PROP_POINT,                                // One point value
   MSG_SYM_PROP_TRADE_TICK_VALUE,                     // Calculated tick price for a position
   MSG_SYM_PROP_TRADE_TICK_VALUE_PROFIT,              // Calculated tick value for a winning position
   MSG_SYM_PROP_TRADE_TICK_VALUE_LOSS,                // Calculated tick value for a losing position
   MSG_SYM_PROP_TRADE_TICK_SIZE,                      // Minimum price change
   MSG_SYM_PROP_TRADE_CONTRACT_SIZE,                  // Trade contract size
   MSG_SYM_PROP_TRADE_ACCRUED_INTEREST,               // Accrued interest
   MSG_SYM_PROP_TRADE_FACE_VALUE,                     // Initial bond value set by the issuer
   MSG_SYM_PROP_TRADE_LIQUIDITY_RATE,                 // Liquidity rate
   MSG_SYM_PROP_VOLUME_MIN,                           // Minimum volume for a deal
   MSG_SYM_PROP_VOLUME_MAX,                           // Maximum volume for a deal
   MSG_SYM_PROP_VOLUME_STEP,                          // Minimum volume change step for deal execution
   MSG_SYM_PROP_VOLUME_LIMIT,                         // Maximum allowed aggregate volume of an open position and pending orders in one direction
   MSG_SYM_PROP_SWAP_LONG,                            // Long swap value
   MSG_SYM_PROP_SWAP_SHORT,                           // Short swap value
   MSG_SYM_PROP_MARGIN_INITIAL,                       // Initial margin
   MSG_SYM_PROP_MARGIN_MAINTENANCE,                   // Maintenance margin for an instrument
   MSG_SYM_PROP_MARGIN_LONG_INITIAL,                  // Initial margin requirement applicable to long positions
   MSG_SYM_PROP_MARGIN_SHORT_INITIAL,                 // Initial margin requirement applicable to short positions
   MSG_SYM_PROP_MARGIN_LONG_MAINTENANCE,              // Maintenance margin requirement applicable to long positions
   MSG_SYM_PROP_MARGIN_SHORT_MAINTENANCE,             // Maintenance margin requirement applicable to short positions
   MSG_SYM_PROP_MARGIN_BUY_STOP_INITIAL,              // Initial margin requirement applicable to BuyStop orders
   MSG_SYM_PROP_MARGIN_BUY_LIMIT_INITIAL,             // Initial margin requirement applicable to BuyLimit orders
   MSG_SYM_PROP_MARGIN_BUY_STOPLIMIT_INITIAL,         // Initial margin requirement applicable to BuyStopLimit orders
   MSG_SYM_PROP_MARGIN_SELL_STOP_INITIAL,             // Initial margin requirement applicable to SellStop orders
   MSG_SYM_PROP_MARGIN_SELL_LIMIT_INITIAL,            // Initial margin requirement applicable to SellLimit orders
   MSG_SYM_PROP_MARGIN_SELL_STOPLIMIT_INITIAL,        // Initial margin requirement applicable to SellStopLimit orders
   MSG_SYM_PROP_MARGIN_BUY_STOP_MAINTENANCE,          // Maintenance margin requirement applicable to BuyStop orders
   MSG_SYM_PROP_MARGIN_BUY_LIMIT_MAINTENANCE,         // Maintenance margin requirement applicable to BuyLimit orders
   MSG_SYM_PROP_MARGIN_BUY_STOPLIMIT_MAINTENANCE,     // Maintenance margin requirement applicable to BuyStopLimit orders
   MSG_SYM_PROP_MARGIN_SELL_STOP_MAINTENANCE,         // Maintenance margin requirement applicable to SellStop orders
   MSG_SYM_PROP_MARGIN_SELL_LIMIT_MAINTENANCE,        // Maintenance margin requirement applicable to SellLimit orders
   MSG_SYM_PROP_MARGIN_SELL_STOPLIMIT_MAINTENANCE,    // Maintenance margin requirement applicable to SellStopLimit orders
   MSG_SYM_PROP_SESSION_VOLUME,                       // Summary volume of the current session deals
   MSG_SYM_PROP_SESSION_TURNOVER,                     // Summary turnover of the current session
   MSG_SYM_PROP_SESSION_INTEREST,                     // Summary open interest
   MSG_SYM_PROP_SESSION_BUY_ORDERS_VOLUME,            // Current volume of Buy orders
   MSG_SYM_PROP_SESSION_SELL_ORDERS_VOLUME,           // Current volume of Sell orders
   MSG_SYM_PROP_SESSION_OPEN,                         // Session open price
   MSG_SYM_PROP_SESSION_CLOSE,                        // Session close price
   MSG_SYM_PROP_SESSION_AW,                           // Average weighted session price
   MSG_SYM_PROP_SESSION_PRICE_SETTLEMENT,             // Settlement price of the current session
   MSG_SYM_PROP_SESSION_PRICE_LIMIT_MIN,              // Minimum session price
   MSG_SYM_PROP_SESSION_PRICE_LIMIT_MAX,              // Maximum session pric
   MSG_SYM_PROP_MARGIN_HEDGED,                        // Size of a contract or margin for one lot of hedged positions
   
   MSG_SYM_PROP_PRICE_CHANGE,                         // Change of the current price relative to the end of the previous trading day in %
   MSG_SYM_PROP_PRICE_VOLATILITY,                     // Price volatility in %
   MSG_SYM_PROP_PRICE_THEORETICAL,                    // Theoretical option price
   MSG_SYM_PROP_PRICE_DELTA,                          // Option/warrant delta
   MSG_SYM_PROP_PRICE_THETA,                          // Option/warrant theta
   MSG_SYM_PROP_PRICE_GAMMA,                          // Option/warrant gamma
   MSG_SYM_PROP_PRICE_VEGA,                           // Option/warrant vega
   MSG_SYM_PROP_PRICE_RHO,                            // Option/warrant rho
   MSG_SYM_PROP_PRICE_OMEGA,                          // Option/warrant omega
   MSG_SYM_PROP_PRICE_SENSITIVITY,                    // Option/warrant sensitivity
   //---
   MSG_SYM_PROP_NAME,                                 // Symbol name
   MSG_SYM_PROP_BASIS,                                // Underlying asset of derivative
   MSG_SYM_PROP_COUNTRY,                              // Country
   MSG_SYM_PROP_SECTOR_NAME,                          // Economic sector
   MSG_SYM_PROP_INDUSTRY_NAME,                        // Economy or industry branch
   MSG_SYM_PROP_CURRENCY_BASE,                        // Basic currency of symbol
   MSG_SYM_PROP_CURRENCY_PROFIT,                      // Profit currency
   MSG_SYM_PROP_CURRENCY_MARGIN,                      // Margin currency
   MSG_SYM_PROP_BANK,                                 // Feeder of the current quote
   MSG_SYM_PROP_DESCRIPTION,                          // Symbol description
   MSG_SYM_PROP_FORMULA,                              // Formula used for custom symbol pricing
   MSG_SYM_PROP_ISIN,                                 // Symbol name in ISIN system
   MSG_SYM_PROP_PAGE,                                 // Address of web page containing symbol information
   MSG_SYM_PROP_PATH,                                 // Location in symbol tree
   MSG_SYM_PROP_CAYEGORY,                             // Symbol category
   MSG_SYM_PROP_EXCHANGE,                             // Name of an exchange a symbol is traded on
   //---
   MSG_SYM_STATUS_FX,                                 // Forex symbol
   MSG_SYM_STATUS_FX_MAJOR,                           // Major Forex symbo
   MSG_SYM_STATUS_FX_MINOR,                           // Minor Forex symbol
   MSG_SYM_STATUS_FX_EXOTIC,                          // Exotic Forex symbol
   MSG_SYM_STATUS_FX_RUB,                             // Forex symbol/RUB
   MSG_SYM_STATUS_METAL,                              // Metal
   MSG_SYM_STATUS_INDEX,                              // Index
   MSG_SYM_STATUS_INDICATIVE,                         // Indicative
   MSG_SYM_STATUS_CRYPTO,                             // Cryptocurrency symbol
   MSG_SYM_STATUS_COMMODITY,                          // Commodity symbol
   MSG_SYM_STATUS_EXCHANGE,                           // Exchange symbol
   MSG_SYM_STATUS_FUTURES,                            // Futures
   MSG_SYM_STATUS_CFD,                                // CFD
   MSG_SYM_STATUS__STOCKS,                            // Security
   MSG_SYM_STATUS_BONDS,                              // Bond
   MSG_SYM_STATUS_OPTION,                             // Option
   MSG_SYM_STATUS_COLLATERAL,                         // Non-tradable asset
   MSG_SYM_STATUS_CUSTOM,                             // Custom symbol
   MSG_SYM_STATUS_COMMON,                             // General group symbol
   //---
   MSG_SYM_CHART_MODE_BID,                            // Bars are based on Bid prices
   MSG_SYM_CHART_MODE_LAST,                           // Bars are based on Last prices
   MSG_SYM_CALC_MODE_FOREX,                           // Forex mode
   MSG_SYM_CALC_MODE_FOREX_NO_LEVERAGE,               // Forex No Leverage mode
   MSG_SYM_CALC_MODE_FUTURES,                         // Futures mode
   MSG_SYM_CALC_MODE_CFD,                             // CFD mode
   MSG_SYM_CALC_MODE_CFDINDEX,                        // CFD index mode
   MSG_SYM_CALC_MODE_CFDLEVERAGE,                     // CFD Leverage mode
   MSG_SYM_CALC_MODE_EXCH_STOCKS,                     // Exchange mode
   MSG_SYM_CALC_MODE_EXCH_FUTURES,                    // Futures mode
   MSG_SYM_CALC_MODE_EXCH_FUTURES_FORTS,              // FORTS Futures mode
   MSG_SYM_CALC_MODE_EXCH_BONDS,                      // Exchange Bonds mode
   MSG_SYM_CALC_MODE_EXCH_STOCKS_MOEX,                // Exchange MOEX Stocks mode
   MSG_SYM_CALC_MODE_EXCH_BONDS_MOEX,                 // Exchange MOEX Bonds mode
   MSG_SYM_CALC_MODE_SERV_COLLATERAL,                 // Collateral mode
   MSG_SYM_MODE_UNKNOWN,                              // Unknown mode
   //---
   MSG_SYM_TRADE_MODE_DISABLED,                       // Trading disabled for symbol
   MSG_SYM_TRADE_MODE_LONGONLY,                       // Only long positions allowed
   MSG_SYM_TRADE_MODE_SHORTONLY,                      // Only short positions allowed
   MSG_SYM_TRADE_MODE_CLOSEONLY,                      // Close only
   MSG_SYM_TRADE_MODE_FULL,                           // No trading limitations
   
   MSG_SYM_MARKET_ORDER_DISABLED,                     // Market orders disabled
   MSG_SYM_LIMIT_ORDER_DISABLED,                      // Limit orders disabled
   MSG_SYM_STOP_ORDER_DISABLED,                       // Stop orders disabled
   MSG_SYM_STOP_LIMIT_ORDER_DISABLED,                 // StopLimit orders disabled
   MSG_SYM_SL_ORDER_DISABLED,                         // StopLoss orders disabled
   MSG_SYM_TP_ORDER_DISABLED,                         // TakeProfit orders disabled
   MSG_SYM_CLOSE_BY_ORDER_DISABLED,                   // CloseBy orders disabled
   //---
   MSG_SYM_TRADE_EXECUTION_REQUEST,                   // Execution by request
   MSG_SYM_TRADE_EXECUTION_INSTANT,                   // Instant execution
   MSG_SYM_TRADE_EXECUTION_MARKET,                    // Market execution
   MSG_SYM_TRADE_EXECUTION_EXCHANGE,                  // Exchange execution
   //---
   MSG_SYM_SWAP_MODE_DISABLED,                        // No swaps
   MSG_SYM_SWAP_MODE_POINTS,                          // Swaps charged in points
   MSG_SYM_SWAP_MODE_CURRENCY_SYMBOL,                 // Swaps charged in money in symbol base currency
   MSG_SYM_SWAP_MODE_CURRENCY_MARGIN,                 // Swaps charged in money in symbol margin currency
   MSG_SYM_SWAP_MODE_CURRENCY_DEPOSIT,                // Swaps charged in money in client deposit currency
   MSG_SYM_SWAP_MODE_INTEREST_CURRENT,                // Swaps charged in money in client deposit currency
   MSG_SYM_SWAP_MODE_INTEREST_OPEN,                   // Swaps charged as specified annual interest from position open price
   MSG_SYM_SWAP_MODE_REOPEN_CURRENT,                  // Swaps charged by reopening positions by close price
   MSG_SYM_SWAP_MODE_REOPEN_BID,                      // Swaps charged by reopening positions by the current Bid price
   //---
   MSG_SYM_ORDERS_GTC,                                // Pending orders and Stop Loss/Take Profit levels valid for unlimited period until their explicit cancellation
   MSG_SYM_ORDERS_DAILY,                              // At the end of the day, all Stop Loss and Take Profit levels, as well as pending orders deleted
   MSG_SYM_ORDERS_DAILY_EXCLUDING_STOPS,              // At the end of the day, only pending orders deleted, while Stop Loss and Take Profit levels preserved
   //---
   MSG_SYM_OPTION_MODE_EUROPEAN,                      // European option may only be exercised on specified date
   MSG_SYM_OPTION_MODE_AMERICAN,                      // American option may be exercised on any trading day or before expiry
   MSG_SYM_OPTION_MODE_UNKNOWN,                       // Unknown option type
   MSG_SYM_OPTION_RIGHT_CALL,                         // Call option gives you right to buy asset at specified price
   MSG_SYM_OPTION_RIGHT_PUT,                          // Put option gives you right to sell asset at specified price
   //---
   MSG_SYM_MARKET_ORDER_ALLOWED_YES,                  // Market order (Yes)
   MSG_SYM_MARKET_ORDER_ALLOWED_NO,                   // Market order (No)
   MSG_SYM_LIMIT_ORDER_ALLOWED_YES,                   // Limit order (Yes)
   MSG_SYM_LIMIT_ORDER_ALLOWED_NO,                    // Limit order (No)
   MSG_SYM_STOP_ORDER_ALLOWED_YES,                    // Stop order (Yes)
   MSG_SYM_STOP_ORDER_ALLOWED_NO,                     // Stop order (No)
   MSG_SYM_STOPLIMIT_ORDER_ALLOWED_YES,               // Stop limit order (Yes)
   MSG_SYM_STOPLIMIT_ORDER_ALLOWED_NO,                // Stop limit order (No)
   MSG_SYM_STOPLOSS_ORDER_ALLOWED_YES,                // StopLoss (Yes)
   MSG_SYM_STOPLOSS_ORDER_ALLOWED_NO,                 // StopLoss (No)
   MSG_SYM_TAKEPROFIT_ORDER_ALLOWED_YES,              // TakeProfit (Yes)
   MSG_SYM_TAKEPROFIT_ORDER_ALLOWED_NO,               // TakeProfit (No)
   MSG_SYM_CLOSEBY_ORDER_ALLOWED_YES,                 // Close by (Yes)
   MSG_SYM_CLOSEBY_ORDER_ALLOWED_NO,                  // Close by (No)
   MSG_SYM_FILLING_MODE_RETURN_YES,                   // Return (Yes)
   MSG_SYM_FILLING_MODE_FOK_YES,                      // Fill or Kill (Yes)
   MSG_SYM_FILLING_MODE_FOK_NO,                       // Fill or Kill (No)
   MSG_SYM_FILLING_MODE_IOK_YES,                      // Immediate or Cancel order (Yes)
   MSG_SYM_FILLING_MODE_IOK_NO,                       // Immediate or Cancel order (No)
   MSG_SYM_EXPIRATION_MODE_GTC_YES,                   // Unlimited (Yes)
   MSG_SYM_EXPIRATION_MODE_GTC_NO,                    // Unlimited (No)
   MSG_SYM_EXPIRATION_MODE_DAY_YES,                   // Valid till the end of the day (Yes)
   MSG_SYM_EXPIRATION_MODE_DAY_NO,                    // Valid till the end of the day (No)
   MSG_SYM_EXPIRATION_MODE_SPECIFIED_YES,             // Time is specified in the order (Yes)
   MSG_SYM_EXPIRATION_MODE_SPECIFIED_NO,              // Time is specified in the order (No)
   MSG_SYM_EXPIRATION_MODE_SPECIFIED_DAY_YES,         // Date specified in order (Yes)
   MSG_SYM_EXPIRATION_MODE_SPECIFIED_DAY_NO,          // Date specified in order (No)
   //---
   MSG_SYM_EVENT_SYMBOL_ADD,                          // Added symbol to Market Watch window
   MSG_SYM_EVENT_SYMBOL_DEL,                          // Symbol removed from Market Watch window
   MSG_SYM_EVENT_SYMBOL_SORT,                         // Changed location of symbols in Market Watch window
   MSG_SYM_SYMBOLS_MODE_CURRENT,                      // Work with current symbol only
   MSG_SYM_SYMBOLS_MODE_DEFINES,                      // Work with predefined symbol list
   MSG_SYM_SYMBOLS_MODE_MARKET_WATCH,                 // Work with Market Watch window symbols
   MSG_SYM_SYMBOLS_MODE_ALL,                          // Work with full list of all available symbols
   MSG_SYM_SYMBOLS_BOOK_ADD,                          // Subscribed to Depth of Market 
   MSG_SYM_SYMBOLS_BOOK_DEL,                          // Unsubscribed from Depth of Market 
   MSG_SYM_SYMBOLS_MODE_BOOK,                         // Subscription to Depth of Market
   MSG_SYM_SYMBOLS_ERR_BOOK_ADD,                      // Error subscribing to DOM 
   MSG_SYM_SYMBOLS_ERR_BOOK_DEL,                      // Error unsubscribing from DOM 
   
   //--- ENUM_SYMBOL_SECTOR
   MSG_SYM_SECTOR_UNDEFINED,                          // Undefined
   MSG_SYM_SECTOR_BASIC_MATERIALS,                    // Basic materials
   MSG_SYM_SECTOR_COMMUNICATION_SERVICES,             // Communication services
   MSG_SYM_SECTOR_CONSUMER_CYCLICAL,                  // Consumer cyclical
   MSG_SYM_SECTOR_CONSUMER_DEFENSIVE,                 // Consumer defensive
   MSG_SYM_SECTOR_CURRENCY,                           // Currencies
   MSG_SYM_SECTOR_CURRENCY_CRYPTO,                    // Cryptocurrencies
   MSG_SYM_SECTOR_ENERGY,                             // Energy
   MSG_SYM_SECTOR_FINANCIAL,                          // Finance
   MSG_SYM_SECTOR_HEALTHCARE,                         // Healthcare
   MSG_SYM_SECTOR_INDUSTRIALS,                        // Industrials
   MSG_SYM_SECTOR_REAL_ESTATE,                        // Real estate
   MSG_SYM_SECTOR_TECHNOLOGY,                         // Technology
   MSG_SYM_SECTOR_UTILITIES,                          // Utilities
   MSG_SYM_SECTOR_INDEXES,                            // Indices
   MSG_SYM_SECTOR_COMMODITIES,                        // Commodities
   
   //--- ENUM_SYMBOL_INDUSTRY
   MSG_SYM_INDUSTRY_UNDEFINED,                        // Undefined
   //--- Basic materials
   MSG_SYM_INDUSTRY_AGRICULTURAL_INPUTS,              // Agricultural inputs
   MSG_SYM_INDUSTRY_ALUMINIUM,                        // Aluminium
   MSG_SYM_INDUSTRY_BUILDING_MATERIALS,               // Building materials
   MSG_SYM_INDUSTRY_CHEMICALS,                        // Chemicals
   MSG_SYM_INDUSTRY_COKING_COAL,                      // Coking coal
   MSG_SYM_INDUSTRY_COPPER,                           // Copper
   MSG_SYM_INDUSTRY_GOLD,                             // Gold
   MSG_SYM_INDUSTRY_LUMBER_WOOD,                      // Lumber and wood production
   MSG_SYM_INDUSTRY_INDUSTRIAL_METALS,                // Other industrial metals and mining
   MSG_SYM_INDUSTRY_PRECIOUS_METALS,                  // Other precious metals and mining
   MSG_SYM_INDUSTRY_PAPER,                            // Paper and paper products
   MSG_SYM_INDUSTRY_SILVER,                           // Silver
   MSG_SYM_INDUSTRY_SPECIALTY_CHEMICALS,              // Specialty chemicals
   MSG_SYM_INDUSTRY_STEEL,                            // Steel
   //--- Communication services
   MSG_SYM_INDUSTRY_ADVERTISING,                      // Advertising agencies
   MSG_SYM_INDUSTRY_BROADCASTING,                     // Broadcasting
   MSG_SYM_INDUSTRY_GAMING_MULTIMEDIA,                // Electronic gaming and multimedia
   MSG_SYM_INDUSTRY_ENTERTAINMENT,                    // Entertainment
   MSG_SYM_INDUSTRY_INTERNET_CONTENT,                 // Internet content and information
   MSG_SYM_INDUSTRY_PUBLISHING,                       // Publishing
   MSG_SYM_INDUSTRY_TELECOM,                          // Telecom services
   //--- Consumer cyclical
   MSG_SYM_INDUSTRY_APPAREL_MANUFACTURING,            // Apparel manufacturing
   MSG_SYM_INDUSTRY_APPAREL_RETAIL,                   // Apparel retail
   MSG_SYM_INDUSTRY_AUTO_MANUFACTURERS,               // Auto manufacturers
   MSG_SYM_INDUSTRY_AUTO_PARTS,                       // Auto parts
   MSG_SYM_INDUSTRY_AUTO_DEALERSHIP,                  // Auto and truck dealerships
   MSG_SYM_INDUSTRY_DEPARTMENT_STORES,                // Department stores
   MSG_SYM_INDUSTRY_FOOTWEAR_ACCESSORIES,             // Footwear and accessories
   MSG_SYM_INDUSTRY_FURNISHINGS,                      // Furnishing, fixtures and appliances
   MSG_SYM_INDUSTRY_GAMBLING,                         // Gambling
   MSG_SYM_INDUSTRY_HOME_IMPROV_RETAIL,               // Home improvement retail
   MSG_SYM_INDUSTRY_INTERNET_RETAIL,                  // Internet retail
   MSG_SYM_INDUSTRY_LEISURE,                          // Leisure
   MSG_SYM_INDUSTRY_LODGING,                          // Lodging
   MSG_SYM_INDUSTRY_LUXURY_GOODS,                     // Luxury goods
   MSG_SYM_INDUSTRY_PACKAGING_CONTAINERS,             // Packaging and containers
   MSG_SYM_INDUSTRY_PERSONAL_SERVICES,                // Personal services
   MSG_SYM_INDUSTRY_RECREATIONAL_VEHICLES,            // Recreational vehicles
   MSG_SYM_INDUSTRY_RESIDENT_CONSTRUCTION,            // Residential construction
   MSG_SYM_INDUSTRY_RESORTS_CASINOS,                  // Resorts and casinos
   MSG_SYM_INDUSTRY_RESTAURANTS,                      // Restaurants
   MSG_SYM_INDUSTRY_SPECIALTY_RETAIL,                 // Specialty retail
   MSG_SYM_INDUSTRY_TEXTILE_MANUFACTURING,            // Textile manufacturing
   MSG_SYM_INDUSTRY_TRAVEL_SERVICES,                  // Travel services
   //--- Consumer defensive
   MSG_SYM_INDUSTRY_BEVERAGES_BREWERS,                // Beverages - Brewers
   MSG_SYM_INDUSTRY_BEVERAGES_NON_ALCO,               // Beverages - Non-alcoholic
   MSG_SYM_INDUSTRY_BEVERAGES_WINERIES,               // Beverages - Wineries and distilleries
   MSG_SYM_INDUSTRY_CONFECTIONERS,                    // Confectioners
   MSG_SYM_INDUSTRY_DISCOUNT_STORES,                  // Discount stores
   MSG_SYM_INDUSTRY_EDUCATION_TRAINIG,                // Education and training services
   MSG_SYM_INDUSTRY_FARM_PRODUCTS,                    // Farm products
   MSG_SYM_INDUSTRY_FOOD_DISTRIBUTION,                // Food distribution
   MSG_SYM_INDUSTRY_GROCERY_STORES,                   // Grocery stores
   MSG_SYM_INDUSTRY_HOUSEHOLD_PRODUCTS,               // Household and personal products
   MSG_SYM_INDUSTRY_PACKAGED_FOODS,                   // Packaged foods
   MSG_SYM_INDUSTRY_TOBACCO,                          // Tobacco
   //--- Energy
   MSG_SYM_INDUSTRY_OIL_GAS_DRILLING,                 // Oil and gas drilling
   MSG_SYM_INDUSTRY_OIL_GAS_EP,                       // Oil and gas extraction and processing
   MSG_SYM_INDUSTRY_OIL_GAS_EQUIPMENT,                // Oil and gas equipment and services
   MSG_SYM_INDUSTRY_OIL_GAS_INTEGRATED,               // Oil and gas integrated
   MSG_SYM_INDUSTRY_OIL_GAS_MIDSTREAM,                // Oil and gas midstream
   MSG_SYM_INDUSTRY_OIL_GAS_REFINING,                 // Oil and gas refining and marketing
   MSG_SYM_INDUSTRY_THERMAL_COAL,                     // Thermal coal
   MSG_SYM_INDUSTRY_URANIUM,                          // Uranium
   //--- Finance
   MSG_SYM_INDUSTRY_EXCHANGE_TRADED_FUND,             // Exchange traded fund
   MSG_SYM_INDUSTRY_ASSETS_MANAGEMENT,                // Assets management
   MSG_SYM_INDUSTRY_BANKS_DIVERSIFIED,                // Banks - Diversified
   MSG_SYM_INDUSTRY_BANKS_REGIONAL,                   // Banks - Regional
   MSG_SYM_INDUSTRY_CAPITAL_MARKETS,                  // Capital markets
   MSG_SYM_INDUSTRY_CLOSE_END_FUND_DEBT,              // Closed-End fund - Debt
   MSG_SYM_INDUSTRY_CLOSE_END_FUND_EQUITY,            // Closed-end fund - Equity
   MSG_SYM_INDUSTRY_CLOSE_END_FUND_FOREIGN,           // Closed-end fund - Foreign
   MSG_SYM_INDUSTRY_CREDIT_SERVICES,                  // Credit services
   MSG_SYM_INDUSTRY_FINANCIAL_CONGLOMERATE,           // Financial conglomerates
   MSG_SYM_INDUSTRY_FINANCIAL_DATA_EXCHANGE,          // Financial data and stock exchange
   MSG_SYM_INDUSTRY_INSURANCE_BROKERS,                // Insurance brokers
   MSG_SYM_INDUSTRY_INSURANCE_DIVERSIFIED,            // Insurance - Diversified
   MSG_SYM_INDUSTRY_INSURANCE_LIFE,                   // Insurance - Life
   MSG_SYM_INDUSTRY_INSURANCE_PROPERTY,               // Insurance - Property and casualty
   MSG_SYM_INDUSTRY_INSURANCE_REINSURANCE,            // Insurance - Reinsurance
   MSG_SYM_INDUSTRY_INSURANCE_SPECIALTY,              // Insurance - Specialty
   MSG_SYM_INDUSTRY_MORTGAGE_FINANCE,                 // Mortgage finance
   MSG_SYM_INDUSTRY_SHELL_COMPANIES,                  // Shell companies
   //--- Healthcare
   MSG_SYM_INDUSTRY_BIOTECHNOLOGY,                    // Biotechnology
   MSG_SYM_INDUSTRY_DIAGNOSTICS_RESEARCH,             // Diagnostics and research
   MSG_SYM_INDUSTRY_DRUGS_MANUFACTURERS,              // Drugs manufacturers - general
   MSG_SYM_INDUSTRY_DRUGS_MANUFACTURERS_SPEC,         // Drugs manufacturers - Specialty and generic
   MSG_SYM_INDUSTRY_HEALTHCARE_PLANS,                 // Healthcare plans
   MSG_SYM_INDUSTRY_HEALTH_INFORMATION,               // Health information services
   MSG_SYM_INDUSTRY_MEDICAL_FACILITIES,               // Medical care facilities
   MSG_SYM_INDUSTRY_MEDICAL_DEVICES,                  // Medical devices
   MSG_SYM_INDUSTRY_MEDICAL_DISTRIBUTION,             // Medical distribution
   MSG_SYM_INDUSTRY_MEDICAL_INSTRUMENTS,              // Medical instruments and supplies
   MSG_SYM_INDUSTRY_PHARM_RETAILERS,                  // Pharmaceutical retailers
   //--- Industrials
   MSG_SYM_INDUSTRY_AEROSPACE_DEFENSE,                // Aerospace and defense
   MSG_SYM_INDUSTRY_AIRLINES,                         // Airlines
   MSG_SYM_INDUSTRY_AIRPORTS_SERVICES,                // Airports and air services
   MSG_SYM_INDUSTRY_BUILDING_PRODUCTS,                // Building products and equipment
   MSG_SYM_INDUSTRY_BUSINESS_EQUIPMENT,               // Business equipment and supplies
   MSG_SYM_INDUSTRY_CONGLOMERATES,                    // Сonglomerates
   MSG_SYM_INDUSTRY_CONSULTING_SERVICES,              // Consulting services
   MSG_SYM_INDUSTRY_ELECTRICAL_EQUIPMENT,             // Electrical equipment and parts
   MSG_SYM_INDUSTRY_ENGINEERING_CONSTRUCTION,         // Engineering and construction
   MSG_SYM_INDUSTRY_FARM_HEAVY_MACHINERY,             // Farm and heavy construction machinery
   MSG_SYM_INDUSTRY_INDUSTRIAL_DISTRIBUTION,          // Industrial distribution
   MSG_SYM_INDUSTRY_INFRASTRUCTURE_OPERATIONS,        // Infrastructure operations
   MSG_SYM_INDUSTRY_FREIGHT_LOGISTICS,                // Integrated freight and logistics
   MSG_SYM_INDUSTRY_MARINE_SHIPPING,                  // Marine shipping
   MSG_SYM_INDUSTRY_METAL_FABRICATION,                // Metal fabrication
   MSG_SYM_INDUSTRY_POLLUTION_CONTROL,                // Pollution and treatment controls
   MSG_SYM_INDUSTRY_RAILROADS,                        // Railroads
   MSG_SYM_INDUSTRY_RENTAL_LEASING,                   // Rental and leasing services
   MSG_SYM_INDUSTRY_SECURITY_PROTECTION,              // Security and protection services
   MSG_SYM_INDUSTRY_SPEALITY_BUSINESS_SERVICES,       // Specialty business services
   MSG_SYM_INDUSTRY_SPEALITY_MACHINERY,               // Specialty industrial machinery
   MSG_SYM_INDUSTRY_STUFFING_EMPLOYMENT,              // Stuffing and employment services
   MSG_SYM_INDUSTRY_TOOLS_ACCESSORIES,                // Tools and accessories
   MSG_SYM_INDUSTRY_TRUCKING,                         // Trucking
   MSG_SYM_INDUSTRY_WASTE_MANAGEMENT,                 // Waste management
   //--- Real estate
   MSG_SYM_INDUSTRY_REAL_ESTATE_DEVELOPMENT,          // Real estate - Development
   MSG_SYM_INDUSTRY_REAL_ESTATE_DIVERSIFIED,          // Real estate - Diversified
   MSG_SYM_INDUSTRY_REAL_ESTATE_SERVICES,             // Real estate services
   MSG_SYM_INDUSTRY_REIT_DIVERSIFIED,                 // REIT - Diversified
   MSG_SYM_INDUSTRY_REIT_HEALTCARE,                   // REIT - Healthcase facilities
   MSG_SYM_INDUSTRY_REIT_HOTEL_MOTEL,                 // REIT - Hotel and motel
   MSG_SYM_INDUSTRY_REIT_INDUSTRIAL,                  // REIT - Industrial
   MSG_SYM_INDUSTRY_REIT_MORTAGE,                     // REIT - Mortgage
   MSG_SYM_INDUSTRY_REIT_OFFICE,                      // REIT - Office
   MSG_SYM_INDUSTRY_REIT_RESIDENTAL,                  // REIT - Residential
   MSG_SYM_INDUSTRY_REIT_RETAIL,                      // REIT - Retail
   MSG_SYM_INDUSTRY_REIT_SPECIALITY,                  // REIT - Specialty
   //--- Technology
   MSG_SYM_INDUSTRY_COMMUNICATION_EQUIPMENT,          // Communication equipment
   MSG_SYM_INDUSTRY_COMPUTER_HARDWARE,                // Computer hardware
   MSG_SYM_INDUSTRY_CONSUMER_ELECTRONICS,             // Consumer electronics
   MSG_SYM_INDUSTRY_ELECTRONIC_COMPONENTS,            // Electronic components
   MSG_SYM_INDUSTRY_ELECTRONIC_DISTRIBUTION,          // Electronics and computer distribution
   MSG_SYM_INDUSTRY_IT_SERVICES,                      // Information technology services
   MSG_SYM_INDUSTRY_SCIENTIFIC_INSTRUMENTS,           // Scientific and technical instruments
   MSG_SYM_INDUSTRY_SEMICONDUCTOR_EQUIPMENT,          // Semiconductor equipment and materials
   MSG_SYM_INDUSTRY_SEMICONDUCTORS,                   // Semiconductors
   MSG_SYM_INDUSTRY_SOFTWARE_APPLICATION,             // Software - Application
   MSG_SYM_INDUSTRY_SOFTWARE_INFRASTRUCTURE,          // Software - Infrastructure
   MSG_SYM_INDUSTRY_SOLAR,                            // Solar
   //--- Utilities
   MSG_SYM_INDUSTRY_UTILITIES_DIVERSIFIED,            // Utilities - Diversified
   MSG_SYM_INDUSTRY_UTILITIES_POWERPRODUCERS,         // Utilities - Independent power producers
   MSG_SYM_INDUSTRY_UTILITIES_RENEWABLE,              // Utilities - Renewable
   MSG_SYM_INDUSTRY_UTILITIES_REGULATED_ELECTRIC,     // Utilities - Regulated electric
   MSG_SYM_INDUSTRY_UTILITIES_REGULATED_GAS,          // Utilities - Regulated gas
   MSG_SYM_INDUSTRY_UTILITIES_REGULATED_WATER,        // Utilities - Regulated water  

//--- CAccount
   MSG_ACC_ACCOUNT,                                   // Account
   MSG_ACC_PROP_LOGIN,                                // Account number
   MSG_ACC_PROP_TRADE_MODE,                           // Trading account type
   MSG_ACC_PROP_LEVERAGE,                             // Leverage
   MSG_ACC_PROP_LIMIT_ORDERS,                         // Maximum allowed number of active pending orders
   MSG_ACC_PROP_MARGIN_SO_MODE,                       // Mode of setting the minimum available margin level
   MSG_ACC_PROP_TRADE_ALLOWED,                        // Trading permission of the current account
   MSG_ACC_PROP_TRADE_EXPERT,                         // Trading permission of an EA
   MSG_ACC_PROP_MARGIN_MODE,                          // Margin calculation mode
   MSG_ACC_PROP_CURRENCY_DIGITS,                      // Number of decimal places for the account currency
   MSG_ACC_PROP_SERVER_TYPE,                          // Trade server type
   MSG_ACC_PROP_FIFO_CLOSE,                           // Flag of a position closure by FIFO rule only
   //---
   MSG_ACC_PROP_BALANCE,                              // Account balance
   MSG_ACC_PROP_CREDIT,                               // Account credit
   MSG_ACC_PROP_PROFIT,                               // Current profit of an account
   MSG_ACC_PROP_EQUITY,                               // Account equity
   MSG_ACC_PROP_MARGIN,                               // Account margin used in deposit currency
   MSG_ACC_PROP_MARGIN_FREE,                          // Free margin of account
   MSG_ACC_PROP_MARGIN_LEVEL,                         // Margin level on an account in %
   MSG_ACC_PROP_MARGIN_SO_CALL,                       // Margin call level
   MSG_ACC_PROP_MARGIN_SO_SO,                         // Margin stop out level
   MSG_ACC_PROP_MARGIN_INITIAL,                       // Amount reserved on account to cover margin of all pending orders
   MSG_ACC_PROP_MARGIN_MAINTENANCE,                   // Min equity reserved on account to cover min amount of all open positions
   MSG_ACC_PROP_ASSETS,                               // Current assets on an account
   MSG_ACC_PROP_LIABILITIES,                          // Current liabilities on an account
   MSG_ACC_PROP_COMMISSION_BLOCKED,                   // Sum of blocked commissions on an account
   //---
   MSG_ACC_PROP_NAME,                                 // Client name
   MSG_ACC_PROP_SERVER,                               // Trade server name
   MSG_ACC_PROP_CURRENCY,                             // Deposit currency
   MSG_ACC_PROP_COMPANY,                              // Name of a company serving account
   //---
   MSG_ACC_TRADE_MODE_DEMO,                           // Demo account
   MSG_ACC_TRADE_MODE_CONTEST,                        // Contest account
   MSG_ACC_TRADE_MODE_REAL,                           // Real account
   MSG_ACC_TRADE_MODE_UNKNOWN,                        // Unknown account type
   //---
   MSG_ACC_STOPOUT_MODE_PERCENT,                      // Account stop out mode in %
   MSG_ACC_STOPOUT_MODE_MONEY,                        // Account stop out mode in money
   MSG_ACC_MARGIN_MODE_RETAIL_NETTING,                // Netting mode
   MSG_ACC_MARGIN_MODE_RETAIL_HEDGING,                // Hedging mode
   MSG_ACC_MARGIN_MODE_RETAIL_EXCHANGE,               // Exchange mode
   MSG_ACC_UNABLE_CLOSE_BY,                           // Close by is available only on hedging accounts
   MSG_ACC_SAME_TYPE_CLOSE_BY,                        // Error. Positions for close by are of the same type
   
//--- CEngine
   MSG_ENG_NO_TRADE_EVENTS,                           // There have been no trade events since the last launch of EA
   MSG_ENG_FAILED_GET_LAST_TRADE_EVENT_DESCR,         // Failed to get description of the last trading event
   MSG_ENG_FAILED_GET_MARKET_POS_LIST,                // Failed to get the list of open positions
   MSG_ENG_FAILED_GET_PENDING_ORD_LIST,               // Failed to get the list of placed orders
   MSG_ENG_NO_OPEN_POSITIONS,                         // No open positions
   MSG_ENG_NO_PLACED_ORDERS,                          // No placed orders
   MSG_ENG_ERR_VALUE_PLOTS,                           // Attention! Value \"indicator_plots\" must be 
   MSG_ENG_ERR_VALUE_ORDERS,                          // Attention! Value \"indicator_buffers\" must be 

//--- CTrading
   MSG_LIB_TEXT_TERMINAL_NOT_TRADE_ENABLED,           // Trade operations are not allowed in the terminal (the AutoTrading button is disabled))
   MSG_LIB_TEXT_EA_NOT_TRADE_ENABLED,                 // EA is not allowed to trade (F7 --> Common --> Allow Automated Trading)
   MSG_LIB_TEXT_ACCOUNT_NOT_TRADE_ENABLED,            // Trading is disabled for the current account
   MSG_LIB_TEXT_ACCOUNT_EA_NOT_TRADE_ENABLED,         // Trading on the trading server side is disabled for EAs on the current account
   MSG_LIB_TEXT_REQUEST_REJECTED_DUE,                 // Request was rejected before sending to the server due to:
   MSG_LIB_TEXT_INVALID_REQUEST,                      // Invalid request:
   MSG_LIB_TEXT_NOT_ENOUTH_MONEY_FOR,                 // Insufficient funds for performing a trade
   MSG_LIB_TEXT_MAX_VOLUME_LIMIT_EXCEEDED,            // Exceeded maximum allowed aggregate volume of orders and positions in one direction
   MSG_LIB_TEXT_REQ_VOL_LESS_MIN_VOLUME,              // Request volume is less than the minimum acceptable one
   MSG_LIB_TEXT_REQ_VOL_MORE_MAX_VOLUME,              // Request volume exceeds the maximum acceptable one
   MSG_LIB_TEXT_CLOSE_BY_ORDERS_DISABLED,             // Close by is disabled
   MSG_LIB_TEXT_INVALID_VOLUME_STEP,                  // Request volume is not a multiple of the minimum lot change step gradation
   MSG_LIB_TEXT_CLOSE_BY_SYMBOLS_UNEQUAL,             // Symbols of opposite positions are not equal
   MSG_LIB_TEXT_SL_LESS_STOP_LEVEL,                   // StopLoss violates requirements for symbol's StopLevel
   MSG_LIB_TEXT_TP_LESS_STOP_LEVEL,                   // TakeProfit violates requirements for symbol's StopLevel
   MSG_LIB_TEXT_PRICE_LESS_STOP_LEVEL,                // Order distance in points is less than a value allowed by symbol's StopLevel parameter
   MSG_LIB_TEXT_LIMIT_LESS_STOP_LEVEL,                // Limit order distance in points relative to a stop order is less than a value allowed by symbol's StopLevel parameter
   MSG_LIB_TEXT_SL_LESS_FREEZE_LEVEL,                 // The distance from the price to StopLoss is less than a value allowed by symbol's FreezeLevel parameter
   MSG_LIB_TEXT_TP_LESS_FREEZE_LEVEL,                 // The distance from the price to TakeProfit is less than a value allowed by symbol's FreezeLevel parameter
   MSG_LIB_TEXT_PR_LESS_FREEZE_LEVEL,                 // The distance from the price to an order activation level is less than a value allowed by symbol's FreezeLevel parameter
   MSG_LIB_TEXT_UNSUPPORTED_SL_TYPE,                  // Unsupported StopLoss parameter type (should be 'int' or 'double')
   MSG_LIB_TEXT_UNSUPPORTED_TP_TYPE,                  // Unsupported TakeProfit parameter type (should be 'int' or 'double')
   MSG_LIB_TEXT_UNSUPPORTED_PR_TYPE,                  // Unsupported price parameter type (should be 'int' or 'double')
   MSG_LIB_TEXT_UNSUPPORTED_PL_TYPE,                  // Unsupported limit order price parameter type (should be 'int' or 'double')
   MSG_LIB_TEXT_UNSUPPORTED_PRICE_TYPE_IN_REQ,        // Unsupported price parameter type in a request
   MSG_LIB_TEXT_TRADING_DISABLE,                      // Trading disabled for the EA until the reason is eliminated
   MSG_LIB_TEXT_TRADING_OPERATION_ABORTED,            // Trading operation is interrupted
   MSG_LIB_TEXT_CORRECTED_TRADE_REQUEST,              // Correcting trading request parameters
   MSG_LIB_TEXT_CREATE_PENDING_REQUEST,               // Creating a pending request
   MSG_LIB_TEXT_NOT_POSSIBILITY_CORRECT_LOT,          // Unable to correct a lot
   MSG_LIB_TEXT_FAILING_CREATE_PENDING_REQ,           // Failed to create a pending request
   MSG_LIB_TEXT_TRY_N,                                // Trading attempt #
   MSG_LIB_TEXT_RE_TRY_N,                             // Repeated trading attempt #
   
   MSG_LIB_TEXT_REQUEST_ACTION,                       // Type of a performed action
   MSG_LIB_TEXT_REQUEST_MAGIC,                        // EA stamp (magic number)
   MSG_LIB_TEXT_REQUEST_ORDER,                        // Order ticket
   MSG_LIB_TEXT_REQUEST_SYMBOL,                       // Name of a trading instrument
   MSG_LIB_TEXT_REQUEST_VOLUME,                       // Requested volume of a deal in lots
   MSG_LIB_TEXT_REQUEST_PRICE,                        // Price
   MSG_LIB_TEXT_REQUEST_STOPLIMIT,                    // StopLimit
   MSG_LIB_TEXT_REQUEST_SL,                           // Stop Loss
   MSG_LIB_TEXT_REQUEST_TP,                           // Take Profit
   MSG_LIB_TEXT_REQUEST_DEVIATION,                    // Maximum price deviation
   MSG_LIB_TEXT_REQUEST_TYPE,                         // Order type
   MSG_LIB_TEXT_REQUEST_TYPE_FILLING,                 // Order filling type
   MSG_LIB_TEXT_REQUEST_TYPE_TIME,                    // Order lifetime type
   MSG_LIB_TEXT_REQUEST_EXPIRATION,                   // Order expiration date
   MSG_LIB_TEXT_REQUEST_COMMENT,                      // Order comment
   MSG_LIB_TEXT_REQUEST_POSITION,                     // Position ticket
   MSG_LIB_TEXT_REQUEST_POSITION_BY,                  // Opposite position ticket
   
   MSG_LIB_TEXT_REQUEST_ACTION_DEAL,                  // Place a market order
   MSG_LIB_TEXT_REQUEST_ACTION_PENDING,               // Place a pending order
   MSG_LIB_TEXT_REQUEST_ACTION_SLTP,                  // Change open position Stop Loss and Take Profit
   MSG_LIB_TEXT_REQUEST_ACTION_MODIFY,                // Change parameters of the previously placed trading order
   MSG_LIB_TEXT_REQUEST_ACTION_REMOVE,                // Remove a pending order
   MSG_LIB_TEXT_REQUEST_ACTION_CLOSE_BY,              // Close a position by an opposite one
   MSG_LIB_TEXT_REQUEST_ACTION_UNCNOWN,               // Unknown trading operation type
   
   MSG_LIB_TEXT_REQUEST_ORDER_FILLING_FOK,            // Order is executed in the specified volume only, otherwise it is canceled
   MSG_LIB_TEXT_REQUEST_ORDER_FILLING_IOK,            // Order is filled within an available volume, while the unfilled one is canceled
   MSG_LIB_TEXT_REQUEST_ORDER_FILLING_RETURN,         // Order is filled within an available volume, while the unfilled one remains
   
   MSG_LIB_TEXT_REQUEST_ORDER_TIME_GTC,               // Order is valid till explicitly canceled
   MSG_LIB_TEXT_REQUEST_ORDER_TIME_DAY,               // Order is valid only during the current trading day
   MSG_LIB_TEXT_REQUEST_ORDER_TIME_SPECIFIED,         // Order is valid till the expiration date
   MSG_LIB_TEXT_REQUEST_ORDER_TIME_SPECIFIED_DAY,     // Order is valid till 23:59:59 of a specified day
   
   MSG_LIB_TEXT_REQUEST,                              // Pending request #
   MSG_LIB_TEXT_REQUEST_ACTIVATED,                    // Pending request activated: #
   MSG_LIB_TEXT_REQUEST_DATAS,                        // Trading request parameters
   MSG_LIB_TEXT_PEND_REQUEST_DATAS,                   // Pending trading request parameters
   MSG_LIB_TEXT_PEND_REQUEST_CREATED,                 // Pending request created
   MSG_LIB_TEXT_PEND_REQUEST_DELETED,                 // Removed due to expiration
   MSG_LIB_TEXT_PEND_REQUEST_EXECUTED,                // Removed due to execution
   MSG_LIB_TEXT_PEND_REQUEST_GETTING_FAILED,          // Failed to obtain a pending request object from the list
   MSG_LIB_TEXT_PEND_REQUEST_FAILED_ADD_PARAMS,       // Failed to add request activation parameters. Error: 

   MSG_LIB_TEXT_PEND_REQUEST_PRICE_CREATE,            // Price at the moment of request generation
   MSG_LIB_TEXT_PEND_REQUEST_TIME_CREATE,             // Request creation time
   MSG_LIB_TEXT_PEND_REQUEST_TIME_ACTIVATE,           // Request activation time
   MSG_LIB_TEXT_PEND_REQUEST_WAITING,                 // Waiting time between trading attempts
   MSG_LIB_TEXT_PEND_REQUEST_CURRENT_ATTEMPT,         // Current trading attempt
   MSG_LIB_TEXT_PEND_REQUEST_TOTAL_ATTEMPTS,          // Total number of trading attempts
   MSG_LIB_TEXT_PEND_REQUEST_ID,                      // Trading request ID
   MSG_LIB_TEXT_PEND_REQUEST_RETCODE,                 // Return code a request is based on
   MSG_LIB_TEXT_PEND_REQUEST_TYPE,                    // Pending request type
   MSG_LIB_TEXT_PEND_REQUEST_BY_ERROR,                // Pending request generated based on the error code
   MSG_LIB_TEXT_PEND_REQUEST_BY_REQUEST,              // Pending request created by request
   MSG_LIB_TEXT_PEND_REQUEST_WAITING_ONSET,           // Wait for the first trading attempt
   
   MSG_LIB_TEXT_PEND_REQUEST_STATUS,                  // Pending request status
   MSG_LIB_TEXT_PEND_REQUEST_STATUS_OPEN,             // Pending request to open a position
   MSG_LIB_TEXT_PEND_REQUEST_STATUS_CLOSE,            // Pending request to close a position
   MSG_LIB_TEXT_PEND_REQUEST_STATUS_SLTP,             // Pending request to modify position stop orders
   MSG_LIB_TEXT_PEND_REQUEST_STATUS_PLACE,            // Pending request to place a pending order
   MSG_LIB_TEXT_PEND_REQUEST_STATUS_REMOVE,           // Pending request to delete a pending order
   MSG_LIB_TEXT_PEND_REQUEST_STATUS_MODIFY,           // Pending request to modify pending order parameters
   
   MSG_LIB_TEXT_PEND_REQUEST_ACTUAL_VOLUME,           // Actual volume
   MSG_LIB_TEXT_PEND_REQUEST_ACTUAL_PRICE,            // Actual order price
   MSG_LIB_TEXT_PEND_REQUEST_ACTUAL_STOPLIMIT,        // Actual StopLimit order price
   MSG_LIB_TEXT_PEND_REQUEST_ACTUAL_SL,               // Actual StopLoss order price
   MSG_LIB_TEXT_PEND_REQUEST_ACTUAL_TP,               // Actual TakeProfit order price
   MSG_LIB_TEXT_PEND_REQUEST_ACTUAL_TYPE_FILLING,     // Actual order filling type
   MSG_LIB_TEXT_PEND_REQUEST_ACTUAL_TYPE_TIME,        // Actual order expiration type
   MSG_LIB_TEXT_PEND_REQUEST_ACTUAL_EXPIRATION,       // Actual order lifetime
   
   MSG_LIB_TEXT_PEND_REQUEST_NO_FREE_IDS,             // No free IDs to create a pending request
   MSG_LIB_TEXT_PEND_REQUEST_ACTIVATION_TERMS,        // Activation conditions
   MSG_LIB_TEXT_PEND_REQUEST_CRITERION,               // Criterion
   MSG_LIB_TEXT_PEND_REQUEST_ADD_CRITERIONS,          // Added pending request activation conditions

//--- CBar
   MSG_LIB_TEXT_BAR_FAILED_GET_BAR_DATA,              // Failed to receive bar data
   MSG_LIB_TEXT_BAR_FAILED_DT_STRUCT_WRITE,           // Failed to write time to time structure
   MSG_LIB_TEXT_BAR_FAILED_GET_SERIES_DATA,           // Failed to receive timeseries data
   MSG_LIB_TEXT_BAR_FAILED_ADD_TO_LIST,               // Failed to add bar object to the list
   MSG_LIB_TEXT_BAR,                                  // Bar
   MSG_LIB_TEXT_BAR_PERIOD,                           // Timeframe
   MSG_LIB_TEXT_BAR_SPREAD,                           // Spread
   MSG_LIB_TEXT_BAR_VOLUME_TICK,                      // Tick volume
   MSG_LIB_TEXT_BAR_VOLUME_REAL,                      // Exchange volume
   MSG_LIB_TEXT_BAR_TIME,                             // Period start time
   MSG_LIB_TEXT_BAR_TIME_YEAR,                        // Year
   MSG_LIB_TEXT_BAR_TIME_MONTH,                       // Month
   MSG_LIB_TEXT_BAR_TIME_DAY_OF_YEAR,                 // Day serial number in a year
   MSG_LIB_TEXT_BAR_TIME_DAY_OF_WEEK,                 // Week day
   MSG_LIB_TEXT_BAR_TIME_DAY,                         // Month day
   MSG_LIB_TEXT_BAR_TIME_HOUR,                        // Hour
   MSG_LIB_TEXT_BAR_TIME_MINUTE,                      // Minute
   MSG_LIB_TEXT_BAR_INDEX,                            // Index in timeseries
   MSG_LIB_TEXT_BAR_HIGH,                             // Highest price for the period
   MSG_LIB_TEXT_BAR_LOW,                              // Lowest price for the period
   MSG_LIB_TEXT_BAR_CANDLE_SIZE,                      // Candle size
   MSG_LIB_TEXT_BAR_CANDLE_SIZE_BODY,                 // Candle body size
   MSG_LIB_TEXT_BAR_CANDLE_SIZE_SHADOW_UP,            // Candle upper wick size
   MSG_LIB_TEXT_BAR_CANDLE_SIZE_SHADOW_DOWN,          // Candle lower wick size
   MSG_LIB_TEXT_BAR_CANDLE_BODY_TOP,                  // Candle body top
   MSG_LIB_TEXT_BAR_CANDLE_BODY_BOTTOM,               // Candle body bottom
   MSG_LIB_TEXT_BAR_TYPE_BULLISH,                     // Bullish bar
   MSG_LIB_TEXT_BAR_TYPE_BEARISH,                     // Bearish bar
   MSG_LIB_TEXT_BAR_TYPE_NULL,                        // Zero bar
   MSG_LIB_TEXT_BAR_TYPE_CANDLE_ZERO_BODY,            // Candle with a zero body
   MSG_LIB_TEXT_BAR_TEXT_FIRS_SET_AMOUNT_DATA,        // First, we need to set the required amount of data using SetRequiredUsedData()
  
//--- CTimeSeries
   MSG_LIB_TEXT_TS_TEXT_FIRST_SET_SYMBOL,             // First, set a symbol using SetSymbol()
   MSG_LIB_TEXT_TS_TEXT_IS_NOT_USE,                   // Timeseries is not used. Set the flag using SetAvailable()
   MSG_LIB_TEXT_TS_TEXT_UNKNOWN_TIMEFRAME,            // Unknown timeframe
   MSG_LIB_TEXT_TS_FAILED_GET_SERIES_OBJ,             // Failed to receive the timeseries object
   MSG_LIB_TEXT_TS_REQUIRED_HISTORY_DEPTH,            // Requested history depth
   MSG_LIB_TEXT_TS_ACTUAL_DEPTH,                      // Actual history depth
   MSG_LIB_TEXT_TS_AMOUNT_HISTORY_DATA,               // Created historical data
   MSG_LIB_TEXT_TS_HISTORY_BARS,                      // Number of history bars on the server
   MSG_LIB_TEXT_TS_TEXT_SYMBOL_TIMESERIES,            // Symbol timeseries
   MSG_LIB_TEXT_TS_TEXT_TIMESERIES,                   // Timeseries
   MSG_LIB_TEXT_TS_TEXT_REQUIRED,                     // Requested
   MSG_LIB_TEXT_TS_TEXT_ACTUAL,                       // Actual
   MSG_LIB_TEXT_TS_TEXT_CREATED,                      // Created
   MSG_LIB_TEXT_TS_TEXT_HISTORY_BARS,                 // On the server
   MSG_LIB_TEXT_TS_TEXT_SYMBOL_FIRSTDATE,             // The very first date by a period symbol
   MSG_LIB_TEXT_TS_TEXT_SYMBOL_LASTBAR_DATE,          // Time of opening the last bar by period symbol
   MSG_LIB_TEXT_TS_TEXT_SYMBOL_SERVER_FIRSTDATE,      // The very first date in history by a server symbol
   MSG_LIB_TEXT_TS_TEXT_SYMBOL_TERMINAL_FIRSTDATE,    // The very first date in history by a symbol in the client terminal
   MSG_LIB_TEXT_TS_TEXT_CREATED_OK,                   // successfully created
   MSG_LIB_TEXT_TS_TEXT_NOT_CREATED,                  // not created
   MSG_LIB_TEXT_TS_TEXT_IS_SYNC,                      // synchronized
   MSG_LIB_TEXT_TS_TEXT_ATTEMPT,                      // Attempt:
   MSG_LIB_TEXT_TS_TEXT_WAIT_FOR_SYNC,                // Waiting for data synchronization ...

//--- CBuffer
   MSG_LIB_TEXT_BUFFER_TEXT_INDEX_BASE,               // Base data buffer index
   MSG_LIB_TEXT_BUFFER_TEXT_INDEX_PLOT,               // Plotted buffer serial number
   MSG_LIB_TEXT_BUFFER_TEXT_INDEX_COLOR,              // Color buffer index
   MSG_LIB_TEXT_BUFFER_TEXT_NUM_DATAS,                // Number of data buffers
   MSG_LIB_TEXT_BUFFER_TEXT_INDEX_NEXT_BASE,          // Index of the array to be assigned as the next indicator buffer
   MSG_LIB_TEXT_BUFFER_TEXT_INDEX_NEXT_PLOT,          // Index of the next drawn buffer
   MSG_LIB_TEXT_BUFFER_TEXT_ID,                       // Indicator buffer ID
   MSG_LIB_TEXT_BUFFER_TEXT_IND_LINE_MODE,            // Indicator line
   MSG_LIB_TEXT_BUFFER_TEXT_IND_HANDLE,               // Handle of an indicator using a buffer
   MSG_LIB_TEXT_BUFFER_TEXT_IND_TYPE,                 // Type of an indicator using a buffer
   MSG_LIB_TEXT_BUFFER_TEXT_IND_LINE_ADDITIONAL_NUM,  // Number of additional line
   MSG_LIB_TEXT_BUFFER_TEXT_TIMEFRAME,                // Buffer (timeframe) data period
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS,                   // Buffer status
   MSG_LIB_TEXT_BUFFER_TEXT_TYPE,                     // Buffer type
   MSG_LIB_TEXT_BUFFER_TEXT_ACTIVE,                   // Active
   MSG_LIB_TEXT_BUFFER_TEXT_ARROW_CODE,               // Arrow code
   MSG_LIB_TEXT_BUFFER_TEXT_ARROW_SHIFT,              // The vertical shift of the arrows
   MSG_LIB_TEXT_BUFFER_TEXT_DRAW_BEGIN,               // The number of initial bars that are not drawn and values in DataWindow
   MSG_LIB_TEXT_BUFFER_TEXT_DRAW_TYPE,                // Graphical construction type
   MSG_LIB_TEXT_BUFFER_TEXT_SHOW_DATA,                // Display construction values in DataWindow
   MSG_LIB_TEXT_BUFFER_TEXT_SHIFT,                    // Indicator graphical construction shift by time axis in bars
   MSG_LIB_TEXT_BUFFER_TEXT_LINE_STYLE,               // Line style
   MSG_LIB_TEXT_BUFFER_TEXT_LINE_WIDTH,               // Line width
   MSG_LIB_TEXT_BUFFER_TEXT_ARROW_SIZE,               // Arrow size
   MSG_LIB_TEXT_BUFFER_TEXT_COLOR_NUM,                // Number of colors
   MSG_LIB_TEXT_BUFFER_TEXT_COLOR,                    // Drawing color
   MSG_LIB_TEXT_BUFFER_TEXT_EMPTY_VALUE,              // Empty value for plotting where nothing will be drawn
   MSG_LIB_TEXT_BUFFER_TEXT_SYMBOL,                   // Buffer symbol
   MSG_LIB_TEXT_BUFFER_TEXT_LABEL,                    // Name of the graphical indicator series displayed in DataWindow
   MSG_LIB_TEXT_BUFFER_TEXT_IND_NAME,                 // Name of an indicator using a buffer
   MSG_LIB_TEXT_BUFFER_TEXT_IND_NAME_SHORT,           // Short name of an indicator using a buffer
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_NAME,              // Indicator buffer with graphical construction type
   MSG_LIB_TEXT_BUFFER_TEXT_INVALID_PROPERTY_BUFF,    // Invalid number of indicator buffers (#property indicator_buffers)
   MSG_LIB_TEXT_BUFFER_TEXT_MAX_BUFFERS_REACHED,      // Reached maximum possible number of indicator buffers
   MSG_LIB_TEXT_BUFFER_TEXT_NO_BUFFER_OBJ,            // No buffer object for standard indicator

   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_NONE,              // No drawing
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_FILLING,           // Color filling between two levels
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_LINE,              // Line
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_HISTOGRAM,         // Histogram from the zero line
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_ARROW,             // Drawing with arrows
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_SECTION,           // Section
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_HISTOGRAM2,        // Histogram on two indicator buffers
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_ZIGZAG,            // Zigzag
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_BARS,              // Display as bars
   MSG_LIB_TEXT_BUFFER_TEXT_STATUS_CANDLES,           // Display as candles
   
   MSG_LIB_TEXT_BUFFER_TEXT_TYPE_CALCULATE,           // Calculated buffer
   MSG_LIB_TEXT_BUFFER_TEXT_TYPE_DATA,                // Colored data buffer
   MSG_LIB_TEXT_BUFFER_TEXT_BUFFER,                   // Buffer
   
   MSG_LIB_TEXT_BUFFER_TEXT_STYLE_SOLID,              // Solid line
   MSG_LIB_TEXT_BUFFER_TEXT_STYLE_DASH,               // Dashed line
   MSG_LIB_TEXT_BUFFER_TEXT_STYLE_DOT,                // Dotted line
   MSG_LIB_TEXT_BUFFER_TEXT_STYLE_DASHDOT,            // Dot-dash line
   MSG_LIB_TEXT_BUFFER_TEXT_STYLE_DASHDOTDOT,         // Dash - two dots
   
//--- CIndicatorDE
   MSG_LIB_TEXT_IND_TEXT_STATUS,                      // Indicator status
   MSG_LIB_TEXT_IND_TEXT_STATUS_STANDARD,             // Standard indicator
   MSG_LIB_TEXT_IND_TEXT_STATUS_CUSTOM,               // Custom indicator
   
   MSG_LIB_TEXT_IND_TEXT_TYPE,                        // Indicator type
   MSG_LIB_TEXT_IND_TEXT_TIMEFRAME,                   // Indicator timeframe
   MSG_LIB_TEXT_IND_TEXT_HANDLE,                      // Indicator handle

   MSG_LIB_TEXT_IND_TEXT_GROUP,                       // Indicator group
   MSG_LIB_TEXT_IND_TEXT_GROUP_TREND,                 // Trend indicator
   MSG_LIB_TEXT_IND_TEXT_GROUP_OSCILLATOR,            // Oscillator
   MSG_LIB_TEXT_IND_TEXT_GROUP_VOLUMES,               // Volumes
   MSG_LIB_TEXT_IND_TEXT_GROUP_ARROWS,                // Arrow indicator
   MSG_LIB_TEXT_IND_TEXT_ID,                          // Indicator ID
   
   MSG_LIB_TEXT_IND_TEXT_EMPTY_VALUE,                 // Empty value for plotting where nothing will be drawn
   MSG_LIB_TEXT_IND_TEXT_SYMBOL,                      // Indicator symbol
   MSG_LIB_TEXT_IND_TEXT_NAME,                        // Indicator name
   MSG_LIB_TEXT_IND_TEXT_SHORTNAME,                   // Indicator short name
   
   MSG_LIB_TEXT_IND_TEXT_IND_PARAMETERS,              // Indicator parameters
   MSG_LIB_TEXT_IND_TEXT_APPLIED_VOLUME,              // Volume type for calculation
   MSG_LIB_TEXT_IND_TEXT_PERIOD,                      // Averaging period
   MSG_LIB_TEXT_IND_TEXT_FAST_PERIOD,                 // Fast MA period
   MSG_LIB_TEXT_IND_TEXT_SLOW_PERIOD,                 // Slow MA period
   MSG_LIB_TEXT_IND_TEXT_SIGNAL,                      // Difference averaging period
   MSG_LIB_TEXT_IND_TEXT_TENKAN_PERIOD,               // Tenkan-sen period
   MSG_LIB_TEXT_IND_TEXT_KIJUN_PERIOD,                // Kijun-sen period
   MSG_LIB_TEXT_IND_TEXT_SPANB_PERIOD,                // Senkou Span B period
   MSG_LIB_TEXT_IND_TEXT_JAW_PERIOD,                  // Period for jaw line calculation
   MSG_LIB_TEXT_IND_TEXT_TEETH_PERIOD,                // Period for teeth line calculation
   MSG_LIB_TEXT_IND_TEXT_LIPS_PERIOD,                 // Period for lips line calculation
   MSG_LIB_TEXT_IND_TEXT_JAW_SHIFT,                   // Horizontal shift of jaws line
   MSG_LIB_TEXT_IND_TEXT_TEETH_SHIFT,                 // Horizontal shift of teeth line
   MSG_LIB_TEXT_IND_TEXT_LIPS_SHIFT,                  // Horizontal shift of lips line
   MSG_LIB_TEXT_IND_TEXT_SHIFT,                       // Horizontal shift of the indicator
   MSG_LIB_TEXT_IND_TEXT_MA_METHOD,                   // Smoothing type
   MSG_LIB_TEXT_IND_TEXT_APPLIED_PRICE,               // Price type or handle
   MSG_LIB_TEXT_IND_TEXT_STD_DEVIATION,               // Number of standard deviations
   MSG_LIB_TEXT_IND_TEXT_DEVIATION,                   // Deviation of channel borders from the central line
   MSG_LIB_TEXT_IND_TEXT_STEP,                        // Price change step — acceleration factor
   MSG_LIB_TEXT_IND_TEXT_MAXIMUM,                     // Maximum step
   MSG_LIB_TEXT_IND_TEXT_KPERIOD,                     // K period (number of bars for calculation)
   MSG_LIB_TEXT_IND_TEXT_DPERIOD,                     // D period (primary smoothing period)
   MSG_LIB_TEXT_IND_TEXT_SLOWING,                     // Final smoothing
   MSG_LIB_TEXT_IND_TEXT_PRICE_FIELD,                 // Stochastic calculation method
   MSG_LIB_TEXT_IND_TEXT_CMO_PERIOD,                  // Chande Momentum period
   MSG_LIB_TEXT_IND_TEXT_SMOOTHING_PERIOD,            // Smoothing factor period
   MSG_LIB_TEXT_IND_TEXT_CUSTOM_PARAM,                // Input parameter
   
//--- CIndicatorsCollection
   MSG_LIB_SYS_FAILED_ADD_IND_TO_LIST,                // Error. Failed to add indicator object to list
   MSG_LIB_SYS_INVALID_IND_POINTER,                   // Error. Invalid pointer to indicator object is passed
   MSG_LIB_SYS_IND_ID_EXIST,                          // Error. The indicator object with the ID already exists
   
//--- CDataInd
   MSG_LIB_TEXT_IND_DATA_IND_BUFFER_NUM,              // Indicator buffer number
   MSG_LIB_TEXT_IND_DATA_BUFFER_VALUE,                // Indicator buffer value
   
//--- CSeriesDataInd
   MSG_LIB_TEXT_METHOD_NOT_FOR_INDICATORS,            // The method is not intended to handle indicator programs
   MSG_LIB_TEXT_IND_DATA_FAILED_GET_SERIES_DATA,      // Failed to get indicator data timeseries
   MSG_LIB_TEXT_IND_DATA_FAILED_GET_CURRENT_DATA,     // Failed to get current data of indicator buffer
   MSG_LIB_SYS_FAILED_CREATE_IND_DATA_OBJ,            // Failed to create indicator data object
   MSG_LIB_TEXT_IND_DATA_FAILED_ADD_TO_LIST,          // Failed to add indicator data object to list
   
//--- CTick
   MSG_TICK_TEXT_TICK,                                // Tick
   MSG_TICK_TIME_MSC,                                 // Time of the last update of prices in milliseconds
   MSG_TICK_TIME,                                     // Time of the last update of prices
   MSG_TICK_VOLUME,                                   // Volume for the current Last price
   MSG_TICK_FLAGS,                                    // Flags
   MSG_TICK_VOLUME_REAL,                              // Volume for the current Last price with greater accuracy
   MSG_TICK_SPREAD,                                   // Spread
   MSG_LIB_TEXT_TICK_CHANGED_DATA,                    // Changed data on tick:
   MSG_LIB_TEXT_TICK_FLAG_BID,                        // Bid price change
   MSG_LIB_TEXT_TICK_FLAG_ASK,                        // Ask price change
   MSG_LIB_TEXT_TICK_FLAG_LAST,                       // Last deal price change
   MSG_LIB_TEXT_TICK_FLAG_VOLUME,                     // Volume change
   
//--- CTickSeries
   MSG_TICKSERIES_TEXT_TICKSERIES,                    // Tick series
   MSG_TICKSERIES_ERR_GET_TICK_DATA,                  // Failed to get tick data
   MSG_TICKSERIES_FAILED_CREATE_TICK_DATA_OBJ,        // Failed to create tick data object
   MSG_TICKSERIES_FAILED_ADD_TO_LIST,                 // Failed to add tick data object to list
   MSG_TICKSERIES_TEXT_IS_NOT_USE,                    // Tick series not used. Set the flag using SetAvailable()
   MSG_TICKSERIES_REQUIRED_HISTORY_DAYS,              // Requested number of days
   
//--- CMarketBookOrd
   MSG_MBOOK_ORD_TEXT_MBOOK_ORD,                      // Order in DOM
   MSG_MBOOK_ORD_VOLUME,                              // Volume
   MSG_MBOOK_ORD_VOLUME_REAL,                         // Extended accuracy volume
   MSG_MBOOK_ORD_STATUS_BUY,                          // Buy side
   MSG_MBOOK_ORD_STATUS_SELL,                         // Sell side
   MSG_MBOOK_ORD_TYPE_SELL,                           // Sell order
   MSG_MBOOK_ORD_TYPE_BUY,                            // Buy order 
   MSG_MBOOK_ORD_TYPE_SELL_MARKET,                    // Sell order by Market
   MSG_MBOOK_ORD_TYPE_BUY_MARKET,                     // Buy order by Market

//--- CMarketBookSnapshot
   MSG_MBOOK_SNAP_TEXT_SNAPSHOT,                      // DOM snapshot
   MSG_MBOOK_SNAP_VOLUME_BUY,                         // Buy volume
   MSG_MBOOK_SNAP_VOLUME_SELL,                        // Sell volume
   
//--- CMBookSeries
   MSG_MBOOK_SERIES_TEXT_MBOOKSERIES,                 // DOM snapshot series
   MSG_MBOOK_SERIES_ERR_ADD_TO_LIST,                  // Error. Failed to add DOM snapshot series to the list
   
//--- CMBookSeriesCollection
   MSG_MB_COLLECTION_TEXT_MBCOLLECTION,               // DOM snapshot series collection
 
//--- CMQLSignal
   MSG_SIGNAL_MQL5_TEXT_SIGNAL,                       // Signal
   MSG_SIGNAL_MQL5_TEXT_SIGNAL_MQL5,                  // MQL5.com Signals service signal
   MSG_SIGNAL_MQL5_TRADE_MODE,                        // Account type
   MSG_SIGNAL_MQL5_DATE_PUBLISHED,                    // Publication date
   MSG_SIGNAL_MQL5_DATE_STARTED,                      // Monitoring start date
   MSG_SIGNAL_MQL5_DATE_UPDATED,                      // Date of the latest update of the trading statistics
   MSG_SIGNAL_MQL5_ID,                                // ID
   MSG_SIGNAL_MQL5_LEVERAGE,                          // Trading account leverage
   MSG_SIGNAL_MQL5_PIPS,                              // Trading result in pips
   MSG_SIGNAL_MQL5_RATING,                            // Position in the signal rating
   MSG_SIGNAL_MQL5_SUBSCRIBERS,                       // Number of subscribers
   MSG_SIGNAL_MQL5_TRADES,                            // Number of trades
   MSG_SIGNAL_MQL5_SUBSCRIPTION_STATUS,               // Status of account subscription to a signal
   MSG_SIGNAL_MQL5_EQUITY,                            // Account equity
   MSG_SIGNAL_MQL5_GAIN,                              // Account growth in %
   MSG_SIGNAL_MQL5_MAX_DRAWDOWN,                      // Maximum drawdown
   MSG_SIGNAL_MQL5_PRICE,                             // Signal subscription price
   MSG_SIGNAL_MQL5_ROI,                               // Signal ROI (Return on Investment) in %
   MSG_SIGNAL_MQL5_AUTHOR_LOGIN,                      // Author login
   MSG_SIGNAL_MQL5_BROKER,                            // Broker (company) name
   MSG_SIGNAL_MQL5_BROKER_SERVER,                     // Broker server
   MSG_SIGNAL_MQL5_NAME,                              // Name
   MSG_SIGNAL_MQL5_CURRENCY,                          // Account currency
   MSG_SIGNAL_MQL5_TEXT_GAIN,                         // Growth
   MSG_SIGNAL_MQL5_TEXT_DRAWDOWN,                     // Drawdown
   MSG_SIGNAL_MQL5_TEXT_SUBSCRIBERS,                  // Subscribers
   
//--- CMQLSignalsCollection
   MSG_MQLSIG_COLLECTION_TEXT_MQL5_SIGNAL_COLLECTION, // Collection of MQL5.com Signals service signals
   MSG_MQLSIG_COLLECTION_TEXT_SIGNALS_PAID,           // Paid signals
   MSG_MQLSIG_COLLECTION_TEXT_SIGNALS_FREE,           // Free signals
   MSG_MQLSIG_COLLECTION_TEXT_SIGNALS_NEW,            // New signal added to collection
   MSG_MQLSIG_COLLECTION_ERR_FAILED_GET_SIGNAL,       // Failed to receive signal from collection
   MSG_SIGNAL_INFO_PARAMETERS,                        // Signal copying parameters
   MSG_SIGNAL_INFO_EQUITY_LIMIT,                      // Percentage for converting deal volume
   MSG_SIGNAL_INFO_SLIPPAGE,                          // Market order slippage when synchronizing positions and copying deals
   MSG_SIGNAL_INFO_VOLUME_PERCENT,                    // Limitation on signal equity
   MSG_SIGNAL_INFO_CONFIRMATIONS_DISABLED,            // Enable synchronization without confirmation dialog
   MSG_SIGNAL_INFO_COPY_SLTP,                         // Copy Stop Loss and Take Profit
   MSG_SIGNAL_INFO_DEPOSIT_PERCENT,                   // Limit by deposit
   MSG_SIGNAL_INFO_ID,                                // Signal ID
   MSG_SIGNAL_INFO_SUBSCRIPTION_ENABLED,              // Enable copying deals by subscription
   MSG_SIGNAL_INFO_TERMS_AGREE,                       // Agree to the terms of use of the Signals service
   MSG_SIGNAL_INFO_NAME,                              // Signal name
   MSG_SIGNAL_INFO_SIGNALS_PERMISSION,                // Allow using signals for program
   MSG_SIGNAL_INFO_TEXT_SIGNAL_SUBSCRIBED,            // Subscribed to signal
   MSG_SIGNAL_INFO_TEXT_SIGNAL_UNSUBSCRIBED,          // Unsubscribed from signal
   MSG_SIGNAL_INFO_ERR_SIGNAL_NOT_ALLOWED,            // Signal service disabled for program
   MSG_SIGNAL_INFO_TEXT_CHECK_SETTINGS,               // Please check program settings (Common-->Allow modification of Signals settings)
   
//--- CChartObj
   MSG_CHART_OBJ_ID,                                  // Chart ID
   MSG_CHART_OBJ_SHOW,                                // Draw price chart attributes
   MSG_CHART_OBJ_IS_OBJECT,                           // Chart object
   MSG_CHART_OBJ_BRING_TO_TOP,                        // Chart above all others
   MSG_CHART_OBJ_CONTEXT_MENU,                        // Access the context menu using the right click
   MSG_CHART_OBJ_CROSSHAIR_TOOL,                      // Access the Crosshair tool using the middle click
   MSG_CHART_OBJ_MOUSE_SCROLL,                        // Scroll the chart horizontally using the left mouse button
   MSG_CHART_OBJ_EVENT_MOUSE_WHEEL,                   // Send messages about mouse wheel events to all MQL5 programs on a chart
   MSG_CHART_OBJ_EVENT_MOUSE_MOVE,                    // Send messages about mouse button click and movement events to all MQL5 programs on a chart
   MSG_CHART_OBJ_EVENT_OBJECT_CREATE,                 // Send messages about the graphical object creation event to all MQL5 programs on a chart
   MSG_CHART_OBJ_EVENT_OBJECT_DELETE,                 // Send messages about the graphical object destruction event to all MQL5 programs on a chart
   MSG_CHART_OBJ_MODE,                                // Chart type
   MSG_CHART_OBJ_FOREGROUND,                          // Price chart in the foreground
   MSG_CHART_OBJ_SHIFT,                               // Shift of the price chart from the right border
   MSG_CHART_OBJ_AUTOSCROLL,                          // Auto scroll to the right border of the chart
   MSG_CHART_OBJ_KEYBOARD_CONTROL,                    // Manage the chart using a keyboard
   MSG_CHART_OBJ_QUICK_NAVIGATION,                    // Allow the chart to intercept Space and Enter key strokes to activate the quick navigation bar
   MSG_CHART_OBJ_SCALE,                               // Scale
   MSG_CHART_OBJ_SCALEFIX,                            // Fixed scale
   MSG_CHART_OBJ_SCALEFIX_11,                         // Scale 1:1
   MSG_CHART_OBJ_SCALE_PT_PER_BAR,                    // Scale in points per bar
   MSG_CHART_OBJ_SHOW_TICKER,                         // Display a symbol ticker in the upper left corner
   MSG_CHART_OBJ_SHOW_OHLC,                           // Display OHLC values in the upper left corner
   MSG_CHART_OBJ_SHOW_BID_LINE,                       // Display Bid value as a horizontal line on the chart
   MSG_CHART_OBJ_SHOW_ASK_LINE,                       // Display Ask value as a horizontal line on a chart
   MSG_CHART_OBJ_SHOW_LAST_LINE,                      // Display Last value as a horizontal line on a chart
   MSG_CHART_OBJ_SHOW_PERIOD_SEP,                     // Display vertical separators between adjacent periods
   MSG_CHART_OBJ_SHOW_GRID,                           // Display a grid on the chart
   MSG_CHART_OBJ_SHOW_VOLUMES,                        // Display volumes on a chart
   MSG_CHART_OBJ_SHOW_OBJECT_DESCR,                   // Display text descriptions of objects
   MSG_CHART_OBJ_VISIBLE_BARS,                        // Number of bars on a chart that are available for display
   MSG_CHART_OBJ_WINDOWS_TOTAL,                       // Total number of chart windows including indicator subwindows
   MSG_CHART_OBJ_WINDOW_IS_VISIBLE,                   // Subwindow visibility
   MSG_CHART_OBJ_WINDOW_HANDLE,                       // Chart window handle
   MSG_CHART_OBJ_WINDOW_YDISTANCE,                    // Distance in Y axis pixels between the upper frame of the indicator subwindow and the upper frame of the chart main window   
   MSG_CHART_OBJ_FIRST_VISIBLE_BAR,                   // Number of the first visible bar on the chart
   MSG_CHART_OBJ_WIDTH_IN_BARS,                       // Width of the chart in bars   
   MSG_CHART_OBJ_WIDTH_IN_PIXELS,                     // Width of the chart in pixels   
   MSG_CHART_OBJ_HEIGHT_IN_PIXELS,                    // Height of the chart in pixels   
   MSG_CHART_OBJ_COLOR_BACKGROUND,                    // Color of background of the chart
   MSG_CHART_OBJ_COLOR_FOREGROUND,                    // Color of axes, scale and OHLC line
   MSG_CHART_OBJ_COLOR_GRID,                          // Grid color
   MSG_CHART_OBJ_COLOR_VOLUME,                        // Color of volumes and position opening levels
   MSG_CHART_OBJ_COLOR_CHART_UP,                      // Color for the up bar, shadows and body borders of bull candlesticks
   MSG_CHART_OBJ_COLOR_CHART_DOWN,                    // Color of down bar, its shadow and border of body of the bullish candlestick
   MSG_CHART_OBJ_COLOR_CHART_LINE,                    // Color of the chart line and the Doji candlesticks
   MSG_CHART_OBJ_COLOR_CANDLE_BULL,                   // Color of body of a bullish candlestick
   MSG_CHART_OBJ_COLOR_CANDLE_BEAR,                   //  Color of body of a bearish candlestick
   MSG_CHART_OBJ_COLOR_BID,                           // Color of the Bid price line
   MSG_CHART_OBJ_COLOR_ASK,                           // Color of the Ask price line
   MSG_CHART_OBJ_COLOR_LAST,                          // Color of the last performed deal's price line (Last)
   MSG_CHART_OBJ_COLOR_STOP_LEVEL,                    // Color of stop order levels (Stop Loss and Take Profit)
   MSG_CHART_OBJ_SHOW_TRADE_LEVELS,                   // Display trade levels on the chart (levels of open positions, Stop Loss, Take Profit and pending orders)
   MSG_CHART_OBJ_DRAG_TRADE_LEVELS,                   // Drag trading levels on a chart using a mouse
   MSG_CHART_OBJ_SHOW_DATE_SCALE,                     // Display the time scale on a chart
   MSG_CHART_OBJ_SHOW_PRICE_SCALE,                    // Display a price scale on a chart
   MSG_CHART_OBJ_SHOW_ONE_CLICK,                      // Display the quick trading panel on the chart
   MSG_CHART_OBJ_IS_MAXIMIZED,                        // Chart window maximized
   MSG_CHART_OBJ_IS_MINIMIZED,                        // Chart window minimized
   MSG_CHART_OBJ_IS_DOCKED,                           // Chart window docked
   MSG_CHART_OBJ_FLOAT_LEFT,                          // Left coordinate of the undocked chart window relative to the virtual screen
   MSG_CHART_OBJ_FLOAT_TOP,                           // Upper coordinate of the undocked chart window relative to the virtual screen
   MSG_CHART_OBJ_FLOAT_RIGHT,                         // Right coordinate of the undocked chart window relative to the virtual screen
   MSG_CHART_OBJ_FLOAT_BOTTOM,                        // Bottom coordinate of the undocked chart window relative to the virtual screen

   MSG_CHART_OBJ_SHIFT_SIZE,                          // Shift size of the zero bar from the right border in %
   MSG_CHART_OBJ_FIXED_POSITION,                      // Chart fixed position from the left border in %   
   MSG_CHART_OBJ_FIXED_MAX,                           // Chart fixed maximum
   MSG_CHART_OBJ_FIXED_MIN,                           // Chart fixed minimum
   MSG_CHART_OBJ_POINTS_PER_BAR,                      // Scale in points per bar
   MSG_CHART_OBJ_PRICE_MIN,                           // Chart minimum
   MSG_CHART_OBJ_PRICE_MAX,                           // Chart maximum

   MSG_CHART_OBJ_COMMENT,                             // Chart comment text
   MSG_CHART_OBJ_EXPERT_NAME,                         // Name of an EA launched on the chart
   MSG_CHART_OBJ_SCRIPT_NAME,                         // Name of a script launched on the chart
   
   MSG_CHART_OBJ_CHART_BARS,                          // Display as bars
   MSG_CHART_OBJ_CHART_CANDLES,                       // Display as Japaneses candlesticks
   MSG_CHART_OBJ_CHART_LINE,                          // Display as a line drawn at Close prices
   MSG_CHART_OBJ_CHART_VOLUME_HIDE,                   // Volumes not displayed
   MSG_CHART_OBJ_CHART_VOLUME_TICK,                   // Tick volumes
   MSG_CHART_OBJ_CHART_VOLUME_REAL,                   // Trading volumes
   
   MSG_CHART_OBJ_CHART_WINDOW,                        // Main chart window
   MSG_CHART_OBJ_CHART_SUBWINDOW,                     // Chart subwindow
   MSG_CHART_OBJ_CHART_SUBWINDOWS_NUM,                // Subwindows
   MSG_CHART_OBJ_INDICATORS_MW_NAME_LIST,             // Indicators in the main chart window
   MSG_CHART_OBJ_INDICATORS_SW_NAME_LIST,             // Indicators in the chart window
   MSG_CHART_OBJ_INDICATOR,                           // Indicator
   MSG_CHART_OBJ_INDICATORS_TOTAL,                    // Indicators
   MSG_CHART_OBJ_WINDOW_N,                            // Window
   MSG_CHART_OBJ_INDICATORS_NONE,                     // No indicators
   MSG_CHART_OBJ_ERR_FAILED_GET_WIN_OBJ,              // Failed to receive the chart window object
   MSG_CHART_OBJ_SCREENSHOT_CREATED,                  // Screenshot created
   MSG_CHART_OBJ_TEMPLATE_SAVED,                      // Chart template saved
   MSG_CHART_OBJ_TEMPLATE_APPLIED,                    // Template applied to chart
   
   MSG_CHART_OBJ_INDICATOR_ADDED,                     // Indicator added
   MSG_CHART_OBJ_INDICATOR_REMOVED,                   // Indicator removed
   MSG_CHART_OBJ_INDICATOR_CHANGED,                   // Indicator changed
   MSG_CHART_OBJ_WINDOW_ADDED,                        // Subwindow added
   MSG_CHART_OBJ_WINDOW_REMOVED,                      // Subwindow removed

//--- CChartObjCollection
   MSG_CHART_COLLECTION_TEXT_CHART_COLLECTION,        // Chart collection
   MSG_CHART_COLLECTION_ERR_FAILED_CREATE_CHART_OBJ,  // Failed to create a new chart object
   MSG_CHART_COLLECTION_ERR_FAILED_ADD_CHART,         // Failed to add a chart object to the collection
   MSG_CHART_COLLECTION_ERR_CHARTS_MAX,               // Cannot open new chart. Number of open charts at maximum
   MSG_CHART_COLLECTION_CHART_OPENED,                 // Chart opened
   MSG_CHART_COLLECTION_CHART_CLOSED,                 // Chart closed
   MSG_CHART_COLLECTION_CHART_SYMB_CHANGED,           // Chart symbol changed
   MSG_CHART_COLLECTION_CHART_TF_CHANGED,             // Chart timeframe changed
   MSG_CHART_COLLECTION_CHART_SYMB_TF_CHANGED,        // Chart symbol and timeframe changed

//--- CGCnvElement
   MSG_CANV_ELEMENT_ERR_EMPTY_ARRAY,                  // Error! Empty array
   MSG_CANV_ELEMENT_ERR_ARRAYS_NOT_MATCH,             // Error! Array-copy of the resource does not match the original
   
//--- CForm
   MSG_FORM_OBJECT_TEXT_NO_SHADOW_OBJ_FIRST_CREATE_IT,// No shadow object. Create it using the CreateShadowObj() method
   MSG_FORM_OBJECT_ERR_FAILED_CREATE_SHADOW_OBJ,      // Failed to create a new shadow object
   MSG_FORM_OBJECT_ERR_FAILED_CREATE_PC_OBJ,          // Failed to create new pixel copier object
   MSG_FORM_OBJECT_PC_OBJ_ALREADY_IN_LIST,            // Pixel copier object with ID already present in the list 
   MSG_FORM_OBJECT_PC_OBJ_NOT_EXIST_LIST,             // No pixel copier object with ID in the list 

//--- CFrame
   MSG_FORM_OBJECT_ERR_FAILED_CREATE_FRAME,           // Failed to create a new animation frame object
   MSG_FORM_OBJECT_FRAME_ALREADY_IN_LIST,             // Animation frame object with ID already present in the list 
   MSG_FORM_OBJECT_FRAME_NOT_EXIST_LIST,              // Animation frame object with ID not present in the list 

//--- CShadowObj
   MSG_SHADOW_OBJ_IMG_SMALL_BLUR_LARGE,               // Error! Image size too small or blur too extensive

//--- CGraphElementsCollection
   MSG_GRAPH_ELM_COLLECTION_ERR_OBJ_ALREADY_EXISTS,   // Error. A chart control object already exists with chart ID 
   MSG_GRAPH_ELM_COLLECTION_ERR_FAILED_CREATE_CTRL_OBJ,// Failed to create chart control object with chart ID 
   MSG_GRAPH_ELM_COLLECTION_ERR_FAILED_GET_CTRL_OBJ,  // Failed to get chart control object with chart ID 
   MSG_GRAPH_ELM_COLLECTION_ERR_GR_OBJ_ALREADY_EXISTS,// Such graphical object already exists: 
   
//--- GStdGraphObj
   MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ,     // Failed to create the class object for a graphical object 
   MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_STD_GRAPH_OBJ, // Failed to create a graphical object 
   MSG_GRAPH_STD_OBJ_ERR_NOT_FIND_SUBWINDOW,          // Failed to find the chart subwindow
   MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_SNAPSHOT,      // Failed to create a snapshot of the graphical object change history
   MSG_GRAPH_STD_OBJ_SUCCESS_CREATE_SNAPSHOT,         // Created a snapshot of the graphical object change history
   
   MSG_GRAPH_ELEMENT_TYPE_STANDARD,                   // Standard graphical object
   MSG_GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED,          // Extended standard graphical object
   MSG_GRAPH_ELEMENT_TYPE_ELEMENT,                    // Element
   MSG_GRAPH_ELEMENT_TYPE_SHADOW_OBJ,                 // Shadow object
   MSG_GRAPH_ELEMENT_TYPE_FORM,                       // Form
   MSG_GRAPH_ELEMENT_TYPE_WINDOW,                     // Window
   
   MSG_GRAPH_OBJ_BELONG_PROGRAM,                      // Graphical object belongs to a program
   MSG_GRAPH_OBJ_BELONG_NO_PROGRAM,                   // Graphical object does not belong to a program
//---
   MSG_GRAPH_STD_OBJ_ANY,                             // Abstract graphical object
   MSG_GRAPH_STD_OBJ_VLINE,                           // Vertical line
   MSG_GRAPH_STD_OBJ_HLINE,                           // Horizontal line
   MSG_GRAPH_STD_OBJ_TREND,                           // Trend line
   MSG_GRAPH_STD_OBJ_TRENDBYANGLE,                    // Trend line by angle
   MSG_GRAPH_STD_OBJ_CYCLES,                          // Cyclic lines
   MSG_GRAPH_STD_OBJ_ARROWED_LINE,                    // Arrowed line object
   MSG_GRAPH_STD_OBJ_CHANNEL,                         // Equidistant channel
   MSG_GRAPH_STD_OBJ_STDDEVCHANNEL,                   // Standard deviation channel
   MSG_GRAPH_STD_OBJ_REGRESSION,                      // Linear regression channel
   MSG_GRAPH_STD_OBJ_PITCHFORK,                       // Andrews' pitchfork
   MSG_GRAPH_STD_OBJ_GANNLINE,                        // Gann line
   MSG_GRAPH_STD_OBJ_GANNFAN,                         // Gann fan
   MSG_GRAPH_STD_OBJ_GANNGRID,                        // Gann grid
   MSG_GRAPH_STD_OBJ_FIBO,                            // Fibo levels
   MSG_GRAPH_STD_OBJ_FIBOTIMES,                       // Fibo time zones
   MSG_GRAPH_STD_OBJ_FIBOFAN,                         // Fibo fan
   MSG_GRAPH_STD_OBJ_FIBOARC,                         // Fibo arcs
   MSG_GRAPH_STD_OBJ_FIBOCHANNEL,                     // Fibo channel
   MSG_GRAPH_STD_OBJ_EXPANSION,                       // Fibo expansion
   MSG_GRAPH_STD_OBJ_ELLIOTWAVE5,                     // Elliott 5 waves
   MSG_GRAPH_STD_OBJ_ELLIOTWAVE3,                     // Elliott 3 waves
   MSG_GRAPH_STD_OBJ_RECTANGLE,                       // Rectangle
   MSG_GRAPH_STD_OBJ_TRIANGLE,                        // Triangle
   MSG_GRAPH_STD_OBJ_ELLIPSE,                         // Ellipse
   MSG_GRAPH_STD_OBJ_ARROW_THUMB_UP,                  // Thumb up
   MSG_GRAPH_STD_OBJ_ARROW_THUMB_DOWN,                // Thumb down
   MSG_GRAPH_STD_OBJ_ARROW_UP,                        // Arrow up
   MSG_GRAPH_STD_OBJ_ARROW_DOWN,                      // Arrow down
   MSG_GRAPH_STD_OBJ_ARROW_STOP,                      // Stop
   MSG_GRAPH_STD_OBJ_ARROW_CHECK,                     // Check mark
   MSG_GRAPH_STD_OBJ_ARROW_LEFT_PRICE,                // Left price label
   MSG_GRAPH_STD_OBJ_ARROW_RIGHT_PRICE,               // Right price label
   MSG_GRAPH_STD_OBJ_ARROW_BUY,                       // Buy
   MSG_GRAPH_STD_OBJ_ARROW_SELL,                      // Sell
   MSG_GRAPH_STD_OBJ_ARROW,                           // Arrow
   MSG_GRAPH_STD_OBJ_TEXT,                            // Text
   MSG_GRAPH_STD_OBJ_LABEL,                           // Text label
   MSG_GRAPH_STD_OBJ_BUTTON,                          // Button
   MSG_GRAPH_STD_OBJ_CHART,                           // Chart
   MSG_GRAPH_STD_OBJ_BITMAP,                          // Bitmap
   MSG_GRAPH_STD_OBJ_BITMAP_LABEL,                    // Bitmap label
   MSG_GRAPH_STD_OBJ_EDIT,                            // Edit
   MSG_GRAPH_STD_OBJ_EVENT,                           // Event object which corresponds to an event in Economic Calendar
   MSG_GRAPH_STD_OBJ_RECTANGLE_LABEL,                 // Rectangle Label object used to create and design the custom graphical interface

   MSG_GRAPH_OBJ_PROP_ID,                             // Object ID
   MSG_GRAPH_OBJ_PROP_BASE_ID,                        // Base object ID
   MSG_GRAPH_OBJ_PROP_TYPE,                           // Graphical object type (ENUM_OBJECT)
   MSG_GRAPH_OBJ_PROP_ELEMENT_TYPE,                   // Graphical object type (ENUM_GRAPH_ELEMENT_TYPE)
   MSG_GRAPH_OBJ_PROP_BELONG,                         // Graphical object affiliation
   MSG_GRAPH_OBJ_PROP_CHART_ID,                       // Chart ID
   MSG_GRAPH_OBJ_PROP_WND_NUM,                        // Chart subwindow index
   MSG_GRAPH_OBJ_PROP_CHANGE_MEMORY,                  // Change history
   MSG_GRAPH_OBJ_PROP_CREATETIME,                     // Creation time
   MSG_GRAPH_OBJ_PROP_TIMEFRAMES,                     // Object visibility on timeframes
   MSG_GRAPH_OBJ_PROP_BACK,                           // Background object
   MSG_GRAPH_OBJ_PROP_ZORDER,                         // Priority of a graphical object for receiving the event of clicking on a chart
   MSG_GRAPH_OBJ_PROP_HIDDEN,                         // Disable displaying the name of a graphical object in the terminal object list
   MSG_GRAPH_OBJ_PROP_SELECTED,                       // Object selection
   MSG_GRAPH_OBJ_PROP_SELECTABLE,                     // Object availability
   MSG_GRAPH_OBJ_PROP_NUM,                            // Object index in the list
   MSG_GRAPH_OBJ_PROP_TIME,                           // Time coordinate
   MSG_GRAPH_OBJ_PROP_COLOR,                          // Color
   MSG_GRAPH_OBJ_PROP_STYLE,                          // Style
   MSG_GRAPH_OBJ_PROP_WIDTH,                          // Line width
   MSG_GRAPH_OBJ_PROP_FILL,                           // Object color filling
   MSG_GRAPH_OBJ_PROP_READONLY,                       // Ability to edit text in the Edit object
   MSG_GRAPH_OBJ_PROP_LEVELS,                         // Number of levels
   MSG_GRAPH_OBJ_PROP_LEVELCOLOR,                     // Level line color
   MSG_GRAPH_OBJ_PROP_LEVELSTYLE,                     // Level line style
   MSG_GRAPH_OBJ_PROP_LEVELWIDTH,                     // Level line width
   MSG_GRAPH_OBJ_PROP_ALIGN,                          // Horizontal text alignment in the Edit object (OBJ_EDIT)
   MSG_GRAPH_OBJ_PROP_FONTSIZE,                       // Font size
   MSG_GRAPH_OBJ_PROP_RAY_LEFT,                       // Ray goes to the left
   MSG_GRAPH_OBJ_PROP_RAY_RIGHT,                      // Ray goes to the right
   MSG_GRAPH_OBJ_PROP_RAY,                            // Vertical line goes through all windows of a chart
   MSG_GRAPH_OBJ_PROP_ELLIPSE,                        // Display the full ellipse of the Fibonacci Arc object
   MSG_GRAPH_OBJ_PROP_ARROWCODE,                      // Arrow code for the "Arrow" object
   MSG_GRAPH_OBJ_PROP_ANCHOR,                         // Position of the binding point of the graphical object
   MSG_GRAPH_OBJ_PROP_XDISTANCE,                      // Distance from the base corner along the X axis in pixels
   MSG_GRAPH_OBJ_PROP_YDISTANCE,                      // Distance from the base corner along the Y axis in pixels
   MSG_GRAPH_OBJ_PROP_DIRECTION,                      // Gann object trend
   MSG_GRAPH_OBJ_PROP_DEGREE,                         // Elliott wave marking level
   MSG_GRAPH_OBJ_PROP_DRAWLINES,                      // Display lines for Elliott wave marking
   MSG_GRAPH_OBJ_PROP_STATE,                          // Button state (pressed/released)
   MSG_GRAPH_OBJ_PROP_CHART_OBJ_PERIOD,               // Chart object period
   MSG_GRAPH_OBJ_PROP_CHART_OBJ_DATE_SCALE,           // Time scale display flag for the Chart object
   MSG_GRAPH_OBJ_PROP_CHART_OBJ_PRICE_SCALE,          // Price scale display flag for the Chart object
   MSG_GRAPH_OBJ_PROP_CHART_OBJ_CHART_SCALE,          // Chart object scale
   MSG_GRAPH_OBJ_PROP_XSIZE,                          // Object width along the X axis in pixels.
   MSG_GRAPH_OBJ_PROP_YSIZE,                          // Object height along the Y axis in pixels.
   MSG_GRAPH_OBJ_PROP_XOFFSET,                        // X coordinate of the upper-left corner of the visibility area.
   MSG_GRAPH_OBJ_PROP_YOFFSET,                        // Y coordinate of the upper-left corner of the visibility area.
   MSG_GRAPH_OBJ_PROP_BGCOLOR,                        // Background color for OBJ_EDIT, OBJ_BUTTON, OBJ_RECTANGLE_LABEL
   MSG_GRAPH_OBJ_PROP_CORNER,                         // Chart corner for binding a graphical object
   MSG_GRAPH_OBJ_PROP_BORDER_TYPE,                    // Border type for "Rectangle border"
   MSG_GRAPH_OBJ_PROP_BORDER_COLOR,                   // Border color for OBJ_EDIT and OBJ_BUTTON
//---
   MSG_GRAPH_OBJ_PROP_PRICE,                          // Price coordinate
   MSG_GRAPH_OBJ_PROP_LEVELVALUE,                     // Level value
   MSG_GRAPH_OBJ_PROP_SCALE,                          // Scale (property of Gann objects and Fibonacci Arcs objects)
   MSG_GRAPH_OBJ_PROP_ANGLE,                          // Angle
   MSG_GRAPH_OBJ_PROP_DEVIATION,                      // Deviation
//---
   MSG_GRAPH_OBJ_PROP_NAME,                           // Object name
   MSG_GRAPH_OBJ_PROP_BASE_NAME,                      // Base object name
   MSG_GRAPH_OBJ_PROP_TEXT,                           // Object description (text contained in the object)
   MSG_GRAPH_OBJ_PROP_TOOLTIP,                        // Tooltip text
   MSG_GRAPH_OBJ_PROP_LEVELTEXT,                      // Level description
   MSG_GRAPH_OBJ_PROP_FONT,                           // Font
   MSG_GRAPH_OBJ_PROP_BMPFILE,                        // BMP file name for the "Bitmap Level" object
   MSG_GRAPH_OBJ_PROP_SYMBOL,                         // Symbol for the Chart object

   MSG_GRAPH_OBJ_PROP_SPECIES,                        // Graphical object species
   MSG_GRAPH_OBJ_PROP_SPECIES_LINES,                  // Lines
   MSG_GRAPH_OBJ_PROP_SPECIES_CHANNELS,               // Channels
   MSG_GRAPH_OBJ_PROP_SPECIES_GANN,                   // Gann
   MSG_GRAPH_OBJ_PROP_SPECIES_FIBO,                   // Fibo
   MSG_GRAPH_OBJ_PROP_SPECIES_ELLIOTT,                // Elliott
   MSG_GRAPH_OBJ_PROP_SPECIES_SHAPES,                 // Shapes
   MSG_GRAPH_OBJ_PROP_SPECIES_ARROWS,                 // Arrows
   MSG_GRAPH_OBJ_PROP_SPECIES_GRAPHICAL,              // Graphical objects
   MSG_GRAPH_OBJ_PROP_GROUP,                          // Group of objects
   MSG_GRAPH_OBJ_TEXT_CLICK_COORD,                    // (Chart click coordinate)
   MSG_GRAPH_OBJ_TEXT_ANCHOR_TOP,                     // Arrow anchor point is located at the top
   MSG_GRAPH_OBJ_TEXT_ANCHOR_BOTTOM,                  // Arrow anchor point is located at the bottom
   
   MSG_GRAPH_OBJ_TEXT_ANCHOR_LEFT_UPPER,              // Anchor point at the upper left corner
   MSG_GRAPH_OBJ_TEXT_ANCHOR_LEFT,                    // Anchor point at the left center
   MSG_GRAPH_OBJ_TEXT_ANCHOR_LEFT_LOWER,              // Anchor point at the lower left corner
   MSG_GRAPH_OBJ_TEXT_ANCHOR_LOWER,                   // Anchor point at the bottom center
   MSG_GRAPH_OBJ_TEXT_ANCHOR_RIGHT_LOWER,             // Anchor point at the lower right corner
   MSG_GRAPH_OBJ_TEXT_ANCHOR_RIGHT,                   // Anchor point at the right center
   MSG_GRAPH_OBJ_TEXT_ANCHOR_RIGHT_UPPER,             // Anchor point at the upper right corner
   MSG_GRAPH_OBJ_TEXT_ANCHOR_UPPER,                   // Anchor point at the upper center
   MSG_GRAPH_OBJ_TEXT_ANCHOR_CENTER,                  // Anchor point at the very center of the object
   
   MSG_GRAPH_OBJ_TEXT_TIME_PRICE,                     // Price/time coordinates
   MSG_GRAPH_OBJ_TEXT_PIVOT,                          // Pivot point
   MSG_GRAPH_OBJ_TEXT_LEVELSVALUE_ALL,                // Level values
   MSG_GRAPH_OBJ_TEXT_LEVEL,                          // Level
   MSG_GRAPH_OBJ_TEXT_BMP_FILE_STATE_ON,              // On state
   MSG_GRAPH_OBJ_TEXT_BMP_FILE_STATE_OFF,             // Off state
   
//--- CDataPropObj
   MSG_DATA_PROP_OBJ_OUT_OF_PROP_RANGE,               // Passed property is out of object property range
   MSG_GRAPH_OBJ_FAILED_CREATE_NEW_HIST_OBJ,          // Failed to create an object of the graphical object change history
   MSG_GRAPH_OBJ_FAILED_ADD_OBJ_TO_HIST_LIST,         // Failed to add the change history object to the list
   MSG_GRAPH_OBJ_FAILED_GET_HIST_OBJ,                 // Failed to receive the change history object
   MSG_GRAPH_OBJ_FAILED_INC_ARRAY_SIZE,               // Failed to increase the array size

//--- CGraphElementsCollection
   MSG_GRAPH_OBJ_FAILED_GET_ADDED_OBJ_LIST,           // Failed to get the list of newly added objects
   MSG_GRAPH_OBJ_FAILED_DETACH_OBJ_FROM_LIST,         // Failed to remove a graphical object from the list
   MSG_GRAPH_OBJ_FAILED_DELETE_OBJ_FROM_LIST,         // Failed to remove a graphical object from the list
   MSG_GRAPH_OBJ_FAILED_DELETE_OBJ_FROM_CHART,        // Failed to remove a graphical object from the chart
   MSG_GRAPH_OBJ_FAILED_ADD_OBJ_TO_DEL_LIST,          // Failed to set a graphical object to the list of removed objects
   MSG_GRAPH_OBJ_FAILED_ADD_OBJ_TO_RNM_LIST,          // Failed to set a graphical object to the list of renamed objects
   
   MSG_GRAPH_OBJ_CREATE_EVN_CTRL_INDICATOR,           // Indicator for controlling and sending events created
   MSG_GRAPH_OBJ_FAILED_CREATE_EVN_CTRL_INDICATOR,    // Failed to create the indicator for controlling and sending events
   MSG_GRAPH_OBJ_ADDED_EVN_CTRL_INDICATOR,            // Indicator for controlling and sending events successfully added to the chart
   MSG_GRAPH_OBJ_FAILED_ADD_EVN_CTRL_INDICATOR,       // Failed to add the indicator for controlling and sending events
   MSG_GRAPH_OBJ_ALREADY_EXIST_EVN_CTRL_INDICATOR,    // Indicator for controlling and sending events is already present on the chart
   MSG_GRAPH_OBJ_CLOSED_CHARTS,                       // Chart window closed:
   MSG_GRAPH_OBJ_OBJECTS_ON_CLOSED_CHARTS,            // Objects removed together with charts:
   MSG_GRAPH_OBJ_FAILED_CREATE_EVN_OBJ,               // Failed to create the event object for a graphical object
   MSG_GRAPH_OBJ_FAILED_ADD_EVN_OBJ,                  // Failed to add the event object to the list
   MSG_GRAPH_OBJ_GRAPH_OBJ_PROP_CHANGE_HISTORY,       // Property change history: 
   
   MSG_GRAPH_OBJ_EVN_GRAPH_OBJ_CREATE,                // New graphical object created
   MSG_GRAPH_OBJ_EVN_GRAPH_OBJ_CHANGE,                // Changed the graphical object property
   MSG_GRAPH_OBJ_EVN_GRAPH_OBJ_RENAME,                // Graphical object renamed
   MSG_GRAPH_OBJ_EVN_GRAPH_OBJ_DELETE,                // Graphical object removed
   MSG_GRAPH_OBJ_EVN_GRAPH_OBJ_DEL_CHART,             // Graphical object removed together with the chart
   
//--- CGStdGraphObj (Extended)
   MSG_GRAPH_OBJ_FAILED_CREATE_NEW_EXT_OBJ,           // Failed to create the class object of an extended graphical object
   MSG_GRAPH_OBJ_FAILED_CREATE_NEW_BASE_EXT_OBJ,      // Failed to create the base object for an extended graphical object
   MSG_GRAPH_OBJ_FAILED_ADD_EXT_OBJ_TO_LIST,          // Failed to add the extended standard graphical object to the list
   MSG_GRAPH_OBJ_FAILED_ADD_BASE_EXT_OBJ_TO_LIST,     // Failed to add the base object to the list
   MSG_GRAPH_OBJ_FAILED_CREATE_NEW_DEP_EXT_OBJ,       // Failed to create the subordinate object of an extended graphical object
   MSG_GRAPH_OBJ_FAILED_ADD_DEP_EXT_OBJ_TO_LIST,      // Failed to add the subordinate object to the list
   MSG_GRAPH_OBJ_FAILED_GET_EXT_OBJ_FROM_LIST,        // Failed to receive the extended graphical object from the list
   MSG_GRAPH_OBJ_PROP_NUM_EXT_BASE_OBJ,               // Base object of the extended graphical object
   MSG_GRAPH_OBJ_NOT_EXT_OBJ,                         // The object is not an extended standard graphical object
   
//--- CLinkedPivotPoint
   MSG_GRAPH_OBJ_EXT_NOT_ANY_PIVOTS_X,                // Not a single pivot point is set for the object along the X axis
   MSG_GRAPH_OBJ_EXT_NOT_ANY_PIVOTS_Y,                // Not a single pivot point is set for the object along the Y axis
   MSG_GRAPH_OBJ_EXT_NOT_ATACHED_TO_BASE,             // The object is not attached to the basic graphical object
   MSG_GRAPH_OBJ_EXT_FAILED_CREATE_PP_DATA_OBJ,       // Failed to create a data object for the X and Y pivot points
   MSG_GRAPH_OBJ_EXT_NUM_BASE_PP_TO_SET_X,            // Number of base object pivot points for calculating the X coordinate: 
   MSG_GRAPH_OBJ_EXT_NUM_BASE_PP_TO_SET_Y,            // Number of base object pivot points for calculating the Y coordinate: 

//--- CGStdGraphObjExtToolkit
   MSG_GRAPH_OBJ_EXT_FAILED_ARR_RESIZE_TIME_DATA,     // Failed to change the size of the pivot point time data array
   MSG_GRAPH_OBJ_EXT_FAILED_ARR_RESIZE_PRICE_DATA,    // Failed to change the size of the pivot point price data array
   MSG_GRAPH_OBJ_EXT_FAILED_CREATE_CTRL_POINT_FORM,   // Failed to create a form object to manage a pivot point
   
  };
//+------------------------------------------------------------------+
//| Array of predefined library messages                             |
//| (1) in user's country language                                   |
//| (2) in the international language (English)                      |
//| (3) any additional language.                                     |
//|  The default languages are English and Russian.                  |
//|  To add the necessary number of other languages, simply          |
//|  set the total number of used languages in TOTAL_LANG            |
//|  and add the necessary translation after the English text        |
//+------------------------------------------------------------------+
string messages_library[][TOTAL_LANG]=
  {
   {"Начало списка параметров","The beginning of the parameter list"},
   {"Конец списка параметров","End of parameter list"},
   {"Свойство не поддерживается","Property not supported"},
   {"Свойство не поддерживается в MQL4","Property not supported in MQL4"},
   {"Свойство не поддерживается в MetaTrader5 версии ниже 2155","Property not supported in MetaTrader5, build lower than 2155"},
   {"Свойство не поддерживается у позиции","Property not supported for position"},
   {"Свойство не поддерживается у отложенного ордера","Property not supported for pending order"},
   {"Свойство не поддерживается у маркет-ордера","Property not supported for market order"},
   {"Свойство не поддерживается у исторического маркет-ордера","Property not supported for history market order"},
   {"Значение не задано","Value not set"},
   {"Отсутствует","Not set"},
   {"Формируется терминалом","Formed by the terminal"},
   {"В соответствии с режимом истечения ордера","In accordance with the order expiration mode"},
   
   {"Ошибка ","Error "},
   {"Ошибка. Такого символа нет на сервере","Error. No such symbol on server"},
   {"Ошибка. Такого символа нет в списке используемых символов: ","Error. This symbol is not in the list of symbols used: "},
   {"Не удалось поместить в обзор рынка. Ошибка: ","Failed to put in market watch. Error: "},
   {"Не удалось получить текущие цены. Ошибка: ","Could not get current prices. Error: "},
   {"Не удалось получить коэффициенты взимания маржи. Ошибка: ","Failed to get margin rates. Error: "},
   {"Не удалось получить данные ","Failed to get data of "},
   
   {"Не удалось создать папку хранения файлов. Ошибка: ","Could not create file storage folder. Error: "},
   {"Ошибка. Не удалось добавить текущий объект-аккаунт в список-коллекцию","Error. Failed to add current account object to collection list"},
   {"Ошибка. Не удалось создать объект-аккаунт с данными текущего счёта","Error. Failed to create account object with current account data"},
   {"Не удалось открыть для записи файл ","Could not open file for writing: "},
   {"Ошибка входных данных: нет символа ","Input error: no "},
   {"Не удалось создать объект-символ ","Failed to create symbol object "},
   {"Не удалось добавить символ ","Failed to add "},
   {"Не удалось создать объект-графический элемент ","Failed to create graphic element object "},
   {"Такой объект уже есть в списке","Such an object is already in the list"},
   {"Не удалось получить данные графического ресурса","Failed to get graphic resource data"},
   
   {"Не удалось получить текущие цены по символу события ","Failed to get current prices by event symbol "},
   {"Такое событие уже есть в списке","This event already in the list"},
   {"Такой файл уже создан и добавлен в список: ","This file has already been created and added to list: "},
   {"Ошибка. Не удалось создать объект-указатель на файл ресурса","Error. Failed to create resource file link object"},
   
   {"Ошибка. Уже создан счётчик с идентификатором ","Error. Already created counter with id "},
   {"Не удалось создать счётчик таймера ","Failed to create timer counter "},
   
   {"Ошибка создания временного списка","Error creating temporary list"},
   {"Ошибка. Список не является списком рыночной коллекции","Error. The list is not a list of market collection"},
   {"Ошибка. Список не является списком исторической коллекции","Error. The list is not a list of history collection"},
   {"Не удалось добавить ордер в список","Could not add order to list"},
   {"Не удалось добавить сделку в список","Could not add deal to list"},
   {"Не удалось добавить контрольный ордер ","Failed to add control order "},
   {"Не удалось добавить контрольную позицию ","Failed to add a control position "},
   {"Не удалось добавить модифицированный ордер в список изменённых ордеров","Could not add modified order to list of modified orders"},
   {"Не удалось создать таймер. Ошибка: ","Could not create timer. Error: "},
   
   {"Ещё не было тиков","No ticks yet"},
   {"Не удалось создать структуру объекта","Could not create object structure"},
   {"Не удалось записать uchar-массив в файл","Could not write uchar array to file"},
   {"Не удалось загрузить uchar-массив из файла","Could not load uchar array from file"},
   {"Не удалось создать структуру объекта из uchar-массива","Could not create object structure from uchar array"},
   {"Не удалось сохранить структуру объекта в uchar-массив, ошибка ","Failed to save object structure to uchar array, error "},
   {"Ошибка. Значение \"index\" должно быть в пределах 0 - 3","Error. \"index\" value should be between 0 - 3"},
   {"Не удалось преобразовать строку в нижний регистр, ошибка ","Failed to convert string to lowercase, error "},
   
   {"Ошибка. Строка предопределённых символов пустая, будет использоваться ","Error. String of predefined symbols is empty, the Symbol will be used: "},
   {"Не удалось подготовить массив используемых символов. Ошибка ","Failed to create an array of used symbols. Error "},
   {"Не удалось получить массив используемых символов","Failed to get array of used symbols"},
   {"Ошибка. Строка предопределённых периодов пустая, будет использоваться ","Error. String of predefined periods is empty, the Period will be used: "},
   {"Не удалось подготовить массив используемых периодов. Ошибка ","Failed to create an array of used periods. Error "},
   {"Неправильный тип ордера: ","Invalid order type: "},

   {"Не удалось получить цену Ask. Ошибка ","Could not get Ask price. Error "},
   {"Не удалось получить цену Bid. Ошибка ","Could not get Bid price. Error "},
   {"Не удалось получить время. Ошибка ","Could not get time. Error "},
   {"Не удалось открыть позицию Buy. Ошибка ","Failed to open Buy position. Error "},
   {"Не удалось установить ордер BuyLimit. Ошибка ","Could not place order BuyLimit. Error "},
   {"Не удалось установить ордер BuyStop. Ошибка ","Could not place order BuyStop. Error "},
   {"Не удалось установить ордер BuyStopLimit. Ошибка ","Could not place order BuyStopLimit. Error "},

   {"Не удалось открыть позицию Sell. Ошибка ","Failed to open Sell position. Error "},
   {"Не удалось установить ордер SellLimit. Ошибка ","Could not place SellLimit order. Error "},
   {"Не удалось установить ордер SellStop. Ошибка ","Could not place SellStop order. Error "},
   {"Не удалось установить ордер SellStopLimit. Ошибка ","Could not place SellStopLimit order. Error "},

   {"Не удалось выбрать позицию. Ошибка ","Could not select position. Error "},
   {"Позиция уже закрыта","Position already closed"},
   {"Ошибка. Не позиция: ","Error. Not position: "},
   {"Ошибка. Нет открытой позиции с тикетом #","Error. No open position with ticket #"},
   {"Ошибка. Нет установленного ордера с тикетом #","Error. No placed order with ticket #"},
   {"Не удалось закрыть позицию. Ошибка ","Could not close position. Error "},
   {"Не удалось выбрать встречную позицию. Ошибка ","Could not select opposite position. Error "},
   {"Встречная позиция уже закрыта","Opposite position already closed"},
   {"Ошибка. Встречная позиция не является позицией: ","Error. Opposite position is not a position: "},
   {"Не удалось закрыть позицию встречной. Ошибка ","Could not close position by opposite position. Error "},
   {"Не удалось выбрать ордер. Ошибка ","Could not select order. Error "},
   {"Ордер уже удалён","Order already deleted"},
   {"Ошибка. Не ордер: ","Error. Not order: "},
   {"Не удалось удалить ордер. Ошибка ","Could not delete order. Error "},
   {"Ошибка. Для модификации выбрана закрытая позиция: ","Error. Closed position selected for modification: "},
   {"Не удалось модифицировать позицию. Ошибка ","Failed to modify position. Error "},
   {"Ошибка. Для модификации выбран удалённый ордер: ","Error. Deleted order selected for modification: "},
   {"Не удалось модифицировать ордер. Ошибка ","Failed to order modify. Error "},
   {"Ошибка: невозможно разместить ордер без явно заданного его времени истечения","Error: Unable to place order without explicitly specified expiration time"},
   {"Ошибка. Не удалось получить торговый объект","Error. Failed to get a trade object"},
   {"Ошибка. Не удалось получить объект-позицию","Error. Failed to get position object"},
   {"Ошибка. Не удалось получить объект-ордер","Error. Failed to get order object"},
   {"Ошибка. Не удалось получить объект-символ","Error. Failed to get symbol object"},
   {"Код возврата вне заданного диапазона кодов ошибок","Return code out of range of error codes"},
   {"Не удалось создать объект \"Пауза\"","Failed to create object \"Pause\""},
   {"Не удалось создать объект \"Бар\"","Failed to create object \"Bar\""},
   {"Не удалось синхронизировать данные с сервером","Failed to sync data with server"},
   {"Не удалось изменить размер массива рисуемых буферов","Failed to resize drawing buffers array"},
   {"Не удалось изменить размер массива цветов","Failed to resize color array"},
   {"Не удалось изменить размер массива ","Failed to resize array "},
   {"Не удалось добавить объект-буфер в список","Failed to add buffer object to list"},
   {"Не удалось создать объект \"Индикаторный буфер\"","Failed to create object \"Indicator buffer\""},
   {"Не удалось добавить объект в список","Failed to add object to the list"},
   
   {"Не удалось создать объект long-данных","Failed to create long-data object"},
   {"Не удалось создать объект double-данных","Failed to create double-data object"},
   {"Не удалось создать объект string-данных","Failed to create string-data object"},
   
   {"Не удалось уменьшить размер long-массива","Failed to reduce the size of the long-array"},
   {"Не удалось уменьшить размер double-массива","Failed to reduce the size of the double-array"},
   {"Не удалось уменьшить размер string-массива","Failed to reduce the size of the string-array"},

   {"Не удалось получить объект long-данных","Failed to get long-data object"},
   {"Не удалось получить объект double-данных","Failed to get double-data object"},
   {"Не удалось получить объект string-данных","Failed to get string-data object"},
   
   {"Запрос за пределами long-массива","Data requested outside the long-array"},
   {"Запрос за пределами double-массива","Data requested outside the double-array"},
   {"Запрос за пределами string-массива","Data requested outside the string-array"},
   {"Запрос за пределами массива","Data requested outside the array"},
   {"Не удалось преобразовать координаты графического объекта в экранные","Failed to convert graphics object coordinates to screen coordinates"},
   {"Не удалось преобразовать координаты время/цена в экранные","Failed to convert time/price coordinates to screen coordinates"},
   
   {"Да","Yes"},
   {"Нет","No"},
   {"и","and"},
   {"в","in"},
   {"к","to"},
   
   {"Открыт","Opened"},
   {"Установлен","Placed"},
   {"Удалён","Deleted"},
   {"Закрыт","Closed"},
   {"встречным","by opposite"},
   {"Закрыт объём","Closed volume"},
   {"по цене","at price"},
   {"на цену","on price"},
   {"Сработал","Triggered"},
   {"изменён на","turned to"},
   {"Добавлено","Added"},
   {" на сервере"," symbol on server"},
   {" в список"," symbol to list"},
   {"не удалось добавить в список","failed to add to list"},
   {"Будет использоваться время действия ордера до конца текущего дня","Order validity time until the end of the current day will be used"},
   {"Не показывается ни на одном таймфрейме","Not shown on any timeframe"},
   {"Рисуется на всех таймфреймах","Drawn on all timeframes"},

   {"Январь","January"},
   {"Февраль","February"},
   {"Март","March"},
   {"Апрель","April"},
   {"Май","May"},
   {"Июнь","June"},
   {"Июль","July"},
   {"Август","August"},
   {"Сентябрь","September"},
   {"Октябрь","October"},
   {"Ноябрь","November"},
   {"Декабрь","December"},
   
   {"Выравнивание по левой границе","Left alignment"},
   {"Выравнивание по центру","Centered"},
   {"Выравнивание по правой границе","Right alignment",},
   
   {"Линия соответствует восходящему тренду","Line corresponding to the uptrend line"},
   {"Линия соответствует нисходящему тренду","Line corresponding to the downward trend"},
   
   {"Главный Суперцикл (Grand Supercycle)","Grand Supercycle"},
   {"Суперцикл (Supercycle)","Supercycle"},
   {"Цикл (Cycle)","Cycle"},
   {"Первичный цикл (Primary)","Primary"},
   {"Промежуточное звено (Intermediate)","Intermediate"},
   {"Второстепенный цикл (Minor)","Minor"},
   {"Минута (Minute)","Minute"},
   {"Секунда (Minuette)","Minuette"},
   {"Субсекунда (Subminuette)","Subminuette"},
   
   {"Нажата","Pressed"},
   {"Отжата","Depressed"},
   
   {"Центр координат в левом верхнем углу графика","Center of coordinates is in the upper left corner of the chart"},
   {"Центр координат в левом нижнем углу графика","Center of coordinates is in the lower left corner of the chart"},
   {"Центр координат в правом нижнем углу графика","Center of coordinates is in the lower right corner of the chart"},
   {"Центр координат в правом верхнем углу графика","Center of coordinates is in the upper right corner of the chart"},
   
   {"Плоский вид","Flat form"},
   {"Выпуклый вид","Prominent form"},
   {"Вогнутый вид","Concave form"},
   
   {"Воскресение","Sunday"},
   {"Понедельник","Monday"},
   {"Вторник","Tuesday"},
   {"Среда","Wednesday"},
   {"Четверг","Thursday"},
   {"Пятница","Friday"},
   {"Суббота","Saturday"},
   {"символа: ","symbol property: "},
   {"аккаунта: ","account property: "},
   {"чарта: ","chart property: "},
   {"окна чарта: ","chart window property: "},
   {"Значение свойства ","Value of the "},
   {" увеличено на "," increased by "},
   {" уменьшено на "," decreased by "},
   {" стало больше "," became more than "},
   {" стало меньше "," became less than "},
   {" равно "," is equal to "},
   
   {"Ошибка. Счётчик с идентификатором ","Error. Counter with ID "},
   {" шагом ",", step "},
   {" и паузой "," and pause "},
   {" уже существует"," already exists"},
   {"Создан","Created"},
   {"Попыток","Attempts"},
   {"Ожидание","Wait"},
   {"Окончание","End"},
   {"Текущий период графика","Current chart period"},
   
   {"Неизвестное событие базового объекта ","Unknown event of base object "},
   {"В терминале нет разрешения на отправку e-mail","Terminal does not have permission to send e-mail"},
   {"В терминале нет разрешения на отправку Push-уведомлений","Terminal does not have permission to send push notifications"},
   {"В терминале нет разрешения на отправку файлов на FTP-адрес","Terminal does not have permission to send files to FTP address"},
   
   {"Массив данных контролируемых integer-свойств имеет нулевой размер","Controlled integer properties data array has zero size"},
   {"Необходимо сначала установить размер массива равным количеству integer-свойств объекта","You should first set size of array equal to number of object integer properties"},
   {"Для этого используйте метод CBaseObj::SetControlDataArraySizeLong()","To do this, use CBaseObj::SetControlDataArraySizeLong() method"},
   {"со значением количества integer-свойств объекта в параметре \"size\"","with value of number of integer properties of object in \"size\" parameter"},
   
   {"Массив данных контролируемых double-свойств имеет нулевой размер","Controlled double properties data array has zero size"},
   {"Необходимо сначала установить размер массива равным количеству double-свойств объекта","You must first set size of the array equal to number of object double properties"},
   {"Для этого используйте метод CBaseObj::SetControlDataArraySizeDouble()","To do this, use CBaseObj::SetControlDataArraySizeDouble() method"},
   {"со значением количества double-свойств объекта в параметре \"size\"","with value of number of double properties of object in \"size\" parameter"},
   
   {"Цена Bid","Bid price"},
   {"Цена Ask","Ask price"},
   {"Цена Last","Last price"},
   {"Цена StopLoss","StopLoss price"},
   {"Цена TakeProfit","TakeProfit price"},
   {"Оплата за проведение сделки","Fee for making a deal"},
   {"Прибыль","Profit"},
   {"Символ","Symbol"},
   {"Балансовая операция","Balance operation"},
   {"Кредитная операция","Credit operation"},
   {"Закрытие по StopLoss","Close by StopLoss"},
   {"Закрытие по TakeProfit","Close by TakeProfit"},
   {"Счёт","Account"},
   
//--- COrder
   {"Buy","Buy"},
   {"Sell","Sell"},
   {"Ордер на покупку","Buy order"},
   {"Ордер на продажу","Sell order"},
   
   {"Сделка на покупку","Buy deal"},
   {"Сделка на продажу","Sell deal"},
   
   {"Маркет-ордер","Market-order"},
   {"Исторический ордер","History order"},
   {"Сделка","Deal"},
   {"Позиция","Active position"},
   {"Установленный отложенный ордер","Active pending order"},
   {"Отложенный ордер","Pending order"},
   {"Неизвестный тип ордера","Unknown order type"},
   {"Неизвестный тип позиции","Unknown position type"},
   {"Неизвестный тип сделки","Unknown deal type"},
   //---
   {"Срабатывание StopLoss","Due to StopLoss"},
   {"Срабатывание TakeProfit","Due to TakeProfit"},
   {"Выставлен из mql4-программы","Placed from mql4 program"},
   {"Ордер отменён","Order cancelled"},
   {"Ордер снят клиентом","Order withdrawn by client"},
   {"Ордер проверен на корректность, но еще не принят брокером","Order verified but not yet accepted by broker"}, 
   {"Ордер принят","Order accepted"},
   {"Ордер выполнен частично","Order filled partially"},
   {"Ордер выполнен полностью","Order filled in full"},
   {"Ордер отклонен","Order rejected"},
   {"Ордер снят по истечении срока его действия","Order withdrawn upon expiration"},
   {"Ордер в состоянии регистрации (выставление в торговую систему)","Order in state of registration (placing in trading system)"},
   {"Ордер в состоянии модификации","Order in state of modification"}, 
   {"Ордер в состоянии удаления","Order in deletion state"},
   {"Неизвестное состояние","Unknown state"},
   //---
   {"Ордер выставлен из десктопного терминала","Order set from desktop terminal"},
   {"Ордер выставлен из мобильного приложения","Order set from mobile app"},
   {"Ордер выставлен из веб-платформы","Oder set from web platform"},
   {"Ордер выставлен советником или скриптом","Order set from EA or script"},
   {"Ордер выставлен в результате наступления Stop Out","Due to Stop Out"},
   {"Сделка проведена из десктопного терминала","Deal carried out from desktop terminal"},
   {"Сделка проведена из мобильного приложения","Deal carried out from mobile app"},
   {"Сделка проведена из веб-платформы","Deal carried out from web platform"},
   {"Сделка проведена из советника или скрипта","Deal carried out from EA or script"},
   {"Сделка проведена в результате наступления Stop Out","Due to Stop Out"},
   {"Сделка проведена по причине переноса позиции","Due to position rollover"},
   {"Сделка проведена по причине начисления/списания вариационной маржи","Due to variation margin"},
   {"Сделка проведена по причине сплита (понижения цены) инструмента","Due to split"},
   {"Позиция открыта из десктопного терминала","Position opened from desktop terminal"},
   {"Позиция открыта из мобильного приложения","Position opened from mobile app"},
   {"Позиция открыта из веб-платформы","Position opened from web platform"},
   {"Позиция открыта из советника или скрипта","Position opened from EA or script"},
   //---
   {"Магический номер","Magic number"},
   {"Тикет","Ticket"},
   {"Тикет родительского ордера","Ticket of parent order"},
   {"Тикет наследуемого ордера","Inherited order ticket"},
   {"Дата экспирации","Date of expiration"},
   {"Тип исполнения по остатку","Order filling type"},
   {"Время жизни ордера","Order lifetime"},
   {"Тип","Type"},
   {"Тип по направлению","Type by direction"},
   {"Причина","Reason"},
   {"Идентификатор позиции","Position identifier"},
   {"Сделка на основании ордера с тикетом","Deal by order ticket"},
   {"Направление сделки","Deal entry"},
   {"Вход в рынок","Entry to market"},
   {"Выход из рынка","Out from market"},
   {"Разворот","Turning in opposite direction"},
   {"Закрытие встречной позицией","Closing by opposite position"},
   {"Идентификатор встречной позиции","Opposite position identifier"},
   {"Время открытия в миллисекундах","Opening time in milliseconds"},
   {"Время закрытия в миллисекундах","Closing time in milliseconds"},
   {"Время изменения позиции в миллисекундах","Time to change the position in milliseconds"},
   {"Состояние","Statе"},
   {"Статус","Status"},
   {"Дистанция от цены в пунктах","Distance from price in points"},
   {"Прибыль в пунктах","Profit in points"},
   {"Идентификатор магического номера","Magic number's identifier"},
   {"Идентификатор первой группы","First group's identifier"},
   {"Идентификатор второй группы","Second group's identifier"},
   {"Идентификатор отложенного запроса","Pending request's identifier"},
   {"Цена открытия","Price open"},
   {"Цена закрытия","Price close"},
   {"Цена постановки Limit ордера при активации StopLimit ордера","Price of placing Limit order when StopLimit order activated"},
   {"Комиссия","Comission"},
   {"Своп","Swap"},
   {"Объём","Volume"},
   {"Невыполненный объём","Unfulfilled volume"},
   {"Прибыль+комиссия+своп","Profit+Comission+Swap"},
   {"Комментарий","Comment"},
   {"Пользовательский комментарий","Custom comment"},
   {"Идентификатор на бирже","Exchange identifier"},
   {"Закрывающий ордер","Order for closing by"},
   
//--- CEvent
   {"Событие","Event"},
   {"Тип события","Event's type"},
   {"Время события","Time of event"},
   {"Статус события","Status of event"},
   {"Причина события","Reason of event"},
   {"Тип сделки","Deal's type"},
   {"Тикет сделки","Deal's ticket"},
   {"Тип ордера события","Event's order type"},
   {"Тип ордера позиции","Position's order type"},
   {"Тикет первого ордера позиции","Position's first order ticket"},
   {"Тикет ордера события","Event's order ticket"},
   {"Идентификатор позиции","Position ID"},
   {"Идентификатор встречной позиции","Opposite position's ID"},
   {"Магический номер встречной позиции","Magic number of opposite position"},
   {"Время открытия позиции","Position's opened time"},
   {"Тип ордера позиции до смены направления","Type order of position before changing direction"},
   {"Тикет ордера позиции до смены направления","Ticket order of position before changing direction"},
   {"Тип ордера текущей позиции","Type order of current position"},
   {"Тикет ордера текущей позиции","Ticket order of current position"},
   {"Цена на момент события","Price at the time of event"},
   {"Начальный объём ордера","Order initial volume"},
   {"Исполненный объём ордера","Order executed volume"},
   {"Оставшийся объём ордера","Order remaining volume"},
   {"Текущий объём позиции","Position current volume"},
   {"Цена открытия до модификации","Price open before modification"},
   {"Цена StopLoss до модификации","Price StopLoss before modification"},
   {"Цена TakeProfit до модификации","Price TakeProfit before modification"},
   {"Цена Ask в момент события","Price Ask at the time of event"},
   {"Цена Bid в момент события","Price Bid at the time of event"},
   {"Символ встречной позиции","Symbol of opposite position"},
   //---
   {"Установлен отложенный ордер","Pending order placed"},
   {"Открыта позиция","Position opened"},
   {"Удален отложенный ордер","Pending order removed"},
   {"Закрыта позиция","Position closed"},
   {"Неизвестный статус","Unknown status"},
   //---
   {"Нет торгового события","No trade event"},
   {"Отложенный ордер установлен","Pending order placed"},
   {"Отложенный ордер удалён","Pending order removed"},
   {"Начисление кредита","Credit"},
   {"Изъятие кредитных средств","Withdrawal of credit"},
   {"Дополнительные сборы","Additional charge"},
   {"Корректирующая запись","Correction"},
   {"Перечисление бонусов","Bonus"},
   {"Дополнительные комиссии","Additional commission"},
   {"Комиссия, начисляемая в конце торгового дня","Daily commission"},
   {"Комиссия, начисляемая в конце месяца","Monthly commission"},
   {"Агентская комиссия, начисляемая в конце торгового дня","Daily agent commission"},
   {"Агентская комиссия, начисляемая в конце месяца","Monthly agent commission"},
   {"Начисления процентов на свободные средства","Interest rate"},
   {"Отмененная сделка покупки","Canceled buy deal"},
   {"Отмененная сделка продажи","Canceled sell deal"},
   {"Начисление дивиденда","Dividend operations"},
   {"Начисление франкированного дивиденда","Franked (non-taxable) dividend operations"},
   {"Начисление налога","Tax charges"},
   {"Пополнение баланса","Balance refill"},
   {"Снятие средств с баланса","Withdrawals from balance"},
   //---
   {"Активирован отложенный ордер","Pending order activated"},
   {"Частичное срабатывание отложенного ордера","Pending order partially triggered"},
   {"Позиция открыта частично","Position opened partially"},
   {"Позиция закрыта частично","Position closed partially"},
   {"Позиция закрыта встречной","Position closed by opposite position"},
   {"Позиция закрыта встречной частично","Position closed partially by opposite position"},
   {"Позиция закрыта по StopLoss","Position closed by StopLoss"},
   {"Позиция закрыта по TakeProfit","Position closed by TakeProfit"},
   {"Позиция закрыта частично по StopLoss","Position closed partially by StopLoss"},
   {"Позиция закрыта частично по TakeProfit","Position closed partially by TakeProfit"},
   {"Разворот позиции по рыночному запросу","Position reversal by market request"},
   {"Разворот позиции срабатыванием отложенного ордера","Position reversal by triggering pending order"},
   {"Разворот позиции частичным исполнением заявки","Position reversal by partially completing request"},
   {"Добавлен объём к позиции по рыночному запросу","Added volume to position by market request"},
   {"Добавлен объём к позиции активацией отложенного ордера","Added volume to position by activation of pending order"},
   {"Модифицирована цена установки ордера","Modified order price"},
   {"Модифицированы цена установки и StopLoss ордера","Modified order price and StopLoss"},
   {"Модифицированы цена установки и TakeProfit ордера","Modified order price and TakeProfit"},
   {"Модифицированы цена установки, StopLoss и TakeProfit ордера","Modified order price, StopLoss and TakeProfit"},
   {"Модифицированы цены StopLoss и TakeProfit ордера","Modified order StopLoss and TakeProfit"},
   {"Модифицирован StopLoss ордера","Modified order StopLoss"},
   {"Модифицирован TakeProfit ордера","Modified order TakeProfit"},
   {"Модифицированы цены StopLoss и TakeProfit позиции","Modified StopLoss and TakeProfit"},
   {"Модифицирован StopLoss позиции","Modified StopLoss"},
   {"Модифицирован TakeProfit позиции","Modified TakeProfit"},
   //---
   {"Добавлен объём к позиции","Added volume to position"},
   {"Добавлен объём к позиции частичным исполнением заявки","Volume added to position by partially completing request"},
   {"Добавлен объём к позиции частичной активацией отложенного ордера","Added volume to position by partially triggering pending order"},
   {"Сработал StopLimit-ордер","StopLimit order triggered"},
   {"Модификация","Modified"},
   {"Отмена","Canceled"},
   {"Истёк срок действия","Expired"},
   {"Рыночный запрос, выполненный в полном объёме","Fully completed market request"},
   {"Выполненный частично рыночный запрос","Partially completed market request"},
   {"Разворот позиции","Position reversal"},
   {"Разворот позиции при при частичном срабатывании отложенного ордера","Position reversal on partially triggered pending order"},
   {"Частичное закрытие по StopLoss","Partial close by StopLoss triggered"},
   {"Частичное закрытие по TakeProfit","Partial close by TakeProfit triggered"},
   {"Закрытие встречной позицией","Closed by opposite position"},
   {"Частичное закрытие встречной позицией","Closed partially by opposite position"},
   {"Закрытие частью объёма встречной позиции","Closed by incomplete volume of opposite position"},
   {"Частичное закрытие частью объёма встречной позиции","Closed partially by incomplete volume of opposite position"},

//--- CSymbol
   {"Индекс в окне \"Обзор рынка\"","Index in \"Market Watch window\""},
   
   {"Сектор экономики","The sector of the economy"},
   {"Вид промышленности или отрасль экономики","The industry or the economy branch"},
   
   {"Пользовательский символ","Custom symbol"},
   {"Тип цены для построения баров","Price type used for generating symbols bars"},
   {"Символ с таким именем существует","Symbol with this name exists"},
   {"Символ выбран в Market Watch","Symbol selected in Market Watch"},
   {"Символ отображается в Market Watch","Symbol visible in Market Watch"},
   {"Количество сделок в текущей сессии","Number of deals in current session"},
   {"Общее число ордеров на покупку в текущий момент","Number of Buy orders at the moment"},
   {"Общее число ордеров на продажу в текущий момент","Number of Sell orders at the moment"},
   {"Объем в последней сделке","Volume of the last deal"},
   {"Максимальный объём за день","Maximum day volume"},
   {"Минимальный объём за день","Minimum day volume"},
   {"Время последней котировки","Time of last quote"},
   {"Время последней котировки в миллисекундах","Time of the last quote in milliseconds"},
   {"Количество знаков после запятой","Digits after decimal point"},
   {"Количество знаков после запятой в значении лота","Digits after decimal point in lot value"},
   {"Размер спреда в пунктах","Spread value in points"},
   {"Плавающий спред","Floating spread"},
   {"Максимальное количество показываемых заявок в стакане","Maximum number of requests shown in Depth of Market"},
   {"Способ вычисления стоимости контракта","Contract price calculation mode"},
   {"Тип исполнения ордеров","Order execution type"},
   {"Дата начала торгов по инструменту","Date of symbol trade beginning"},
   {"Дата окончания торгов по инструменту","Date of symbol trade end"},
   {"Минимальный отступ от цены закрытия для установки Stop ордеров","Minimum indention from close price to place Stop orders"},
   {"Дистанция заморозки торговых операций","Distance to freeze trade operations in points"},
   {"Режим заключения сделок","Deal execution mode"},
   {"Модель расчета свопа","Swap calculation model"},
   {"День недели для начисления тройного свопа","Day of week to charge 3 days swap rollover"},
   {"Расчет хеджированной маржи по наибольшей стороне","Calculating hedging margin using larger leg"},
   {"Флаги разрешенных режимов истечения ордера","Flags of allowed order expiration modes"},
   {"Флаги разрешенных режимов заливки ордера","Flags of allowed order filling modes"},
   {"Флаги разрешённых типов ордеров","Flags of allowed order types"},
   {"Срок действия StopLoss и TakeProfit ордеров","Expiration of Stop Loss and Take Profit orders"},
   {"Тип опциона","Option type"},
   {"Право опциона","Option right"},
   {"Цвет фона символа в Market Watch","Background color of symbol in Market Watch"},
   {"Максимальный Bid за день","Maximum Bid of the day"},
   {"Минимальный Bid за день","Minimum Bid of the day"},
   {"Максимальный Ask за день","Maximum Ask of the day"},
   {"Минимальный Ask за день","Minimum Ask of the day"},
   {"Максимальный Last за день","Maximum Last of the day"},
   {"Минимальный Last за день","Minimum Last of the day"},
   {"Реальный объём за день","Real volume of last deal"},
   {"Максимальный реальный объём за день","Maximum real volume of the day"},
   {"Минимальный реальный объём за день","Minimum real volume of the day"},
   {"Цена исполнения опциона","Strike price"},
   {"Значение одного пункта","Symbol point value"},
   {"Рассчитанная стоимость тика для позиции","Calculated tick price for position"},
   {"Рассчитанная стоимость тика для прибыльной позиции","Calculated tick price for profitable position"},
   {"Рассчитанная стоимость тика для убыточной позиции","Calculated tick price for losing position"},
   {"Минимальное изменение цены","Minimum price change"},
   {"Размер торгового контракта","Trade contract size"},
   {"Накопленный купонный доход","Accumulated coupon interest"},
   {"Начальная стоимость облигации, установленная эмитентом","Initial bond value set by issuer"},
   {"Коэффициент ликвидности","Liquidity rate"},
   {"Минимальный объем для заключения сделки","Minimum volume for deal"},
   {"Максимальный объем для заключения сделки","Maximum volume for deal"},
   {"Минимальный шаг изменения объема для заключения сделки","Minimum volume change step for deal execution"},
   {
    "Максимально допустимый общий объем позиции и отложенных ордеров в одном направлении",
    "Maximum allowed aggregate volume of open position and pending orders in one direction"
   },
   {"Значение свопа на покупку","Long swap value"},
   {"Значение свопа на продажу","Short swap value"},
   {"Начальная (инициирующая) маржа","Initial margin"},
   {"Поддерживающая маржа по инструменту","Maintenance margin"},
   {"Коэффициент взимания начальной маржи по длинным позициям","Coefficient of initial margin charging for long positions"},
   {"Коэффициент взимания начальной маржи по коротким позициям","Coefficient of initial margin charging for short positions"},
   {"Коэффициент взимания поддерживающей маржи по длинным позициям","Coefficient of maintenance margin charging for long positions"},
   {"Коэффициент взимания поддерживающей маржи по коротким позициям","Coefficient of maintenance margin charging for short positions"},
   {"Коэффициент взимания начальной маржи по BuyStop ордерам","Coefficient of initial margin charging for BuyStop orders"},
   {"Коэффициент взимания начальной маржи по BuyLimit ордерам","Coefficient of initial margin charging for BuyLimit orders"},
   {"Коэффициент взимания начальной маржи по BuyStopLimit ордерам","Coefficient of initial margin charging for BuyStopLimit orders"},
   {"Коэффициент взимания начальной маржи по SellStop ордерам","Coefficient of initial margin charging for SellStop orders"},
   {"Коэффициент взимания начальной маржи по SellLimit ордерам","Coefficient of initial margin charging for SellLimit orders"},
   {"Коэффициент взимания начальной маржи по SellStopLimit ордерам","Coefficient of initial margin charging for SellStopLimit orders"},
   {"Коэффициент взимания поддерживающей маржи по BuyStop ордерам","Coefficient of maintenance margin charging for BuyStop orders"},
   {"Коэффициент взимания поддерживающей маржи по BuyLimit ордерам","Coefficient of maintenance margin charging for BuyLimit orders"},
   {"Коэффициент взимания поддерживающей маржи по BuyStopLimit ордерам","Coefficient of maintenance margin charging for BuyStopLimit orders"},
   {"Коэффициент взимания поддерживающей маржи по SellStop ордерам","Coefficient of maintenance margin charging for SellStop orders"},
   {"Коэффициент взимания поддерживающей маржи по SellLimit ордерам","Coefficient of maintenance margin charging for SellLimit orders"},
   {"Коэффициент взимания поддерживающей маржи по SellStopLimit ордерам","Coefficient of maintenance margin charging for SellStopLimit orders"},
   {"Cуммарный объём сделок в текущую сессию","Summary volume of current session deals"},
   {"Cуммарный оборот в текущую сессию","Summary turnover of the current session"},
   {"Cуммарный объём открытых позиций","Summary open interest"},
   {"Общий объём ордеров на покупку в текущий момент","Current volume of Buy orders"},
   {"Общий объём ордеров на продажу в текущий момент","Current volume of Sell orders"},
   {"Цена открытия сессии","Open price of the current session"},
   {"Цена закрытия сессии","Close price of the current session"},
   {"Средневзвешенная цена сессии","Average weighted price of the current session"},
   {"Цена поставки на текущую сессию","Settlement price of the current session"},
   {"Минимально допустимое значение цены на сессию","Minimum price of the current session"},
   {"Максимально допустимое значение цены на сессию","Maximum price of the current session"},
   {"Размер контракта или маржи для одного лота перекрытых позиций","Contract size or margin value per one lot of hedged positions"},
   
   {"Изменение текущей цены относительно конца предыдущего торгового дня, в процентах","Change of the current price relative to the end of the previous trading day in %"},
   {"Волатильность цены в процентах","Price volatility in %"},
   {"Теоретическая цена опциона","Theoretical option price"},
   {"Дельта опциона/варранта","Option/warrant delta"},
   {"Тета опциона/варранта","Option/warrant theta"},
   {"Гамма опциона/варранта","Option/warrant gamma"},
   {"Вега опциона/варранта","Option/warrant vega"},
   {"Ро опциона/варранта","Option/warrant rho"},
   {"Омега опциона/варранта","Option/warrant omega"},
   {"Чувствительность опциона/варранта","Option/warrant sensitivity"},

   {"Имя символа","Symbol name"},
   {"Имя базового актива для производного инструмента","Underlying asset of derivative"},
   {"Страна","Cuntry"},
   {"Сектор экономики","Sector of the economy"},
   {"Отрасль экономики или вид промышленности","Branch of the economy or type of industry"},
   {"Базовая валюта инструмента","Basic currency of symbol"},
   {"Валюта прибыли","Profit currency"},
   {"Валюта залоговых средств","Margin currency"},
   {"Источник текущей котировки","Feeder of the current quote"},
   {"Описание символа","Symbol description"},
   {"Формула для построения цены пользовательского символа","Formula used for custom symbol pricing"},
   {"Имя торгового символа в системе международных идентификационных кодов","Name of symbol in ISIN system"},
   {"Адрес интернет страницы с информацией по символу","Address of web page containing symbol information"},
   {"Путь в дереве символов","Path in symbol tree"},
   {"Название категории или сектора, к которой принадлежит торговый символ","Name of sector or category trading symbol belongs to"},
   {"Название биржи или площадки, на которой торгуется символ","Name of exchange financial symbol traded in"},
   //---
   {"Форекс символ","Forex symbol"},
   {"Форекс символ-мажор","Forex major symbol"},
   {"Форекс символ-минор","Forex minor symbol"},
   {"Форекс символ-экзотик","Forex Exotic Symbol"},
   {"Форекс символ/рубль","Forex symbol RUB"},
   {"Металл","Metal"},
   {"Индекс","Index"},
   {"Индикатив","Indicative"},
   {"Криптовалютный символ","Crypto symbol"},
   {"Товарный символ","Commodity symbol"},
   {"Биржевой символ","Exchange symbol"},
   {"Фьючерс","Furures"},
   {"Контракт на разницу","Contract For Difference"},
   {"Ценная бумага","Stocks"},
   {"Облигация","Bonds"},
   {"Опцион","Option"},
   {"Неторгуемый актив","Collateral"},
   {"Пользовательский символ","Custom symbol"},
   {"Символ общей группы","Common group symbol"},
   //---
   {"Бары строятся по ценам Bid","Bars based on Bid prices"},
   {"Бары строятся по ценам Last","Bars based on Last prices"},
   {"Расчет прибыли и маржи для Форекс","Forex mode"},
   {"Расчет прибыли и маржи для Форекс без учета плеча","Forex No Leverage mode"},
   {"Расчет залога и прибыли для фьючерсов","Futures mode"},
   {"Расчет залога и прибыли для CFD","CFD mode"},
   {"Расчет залога и прибыли для CFD на индексы","CFD index mode"},
   {"Расчет залога и прибыли для CFD при торговле с плечом","CFD Leverage mode"},
   {"Расчет залога и прибыли для торговли ценными бумагами на бирже","Exchange mode"},
   {"Расчет залога и прибыли для торговли фьючерсными контрактами на бирже","Futures mode"},
   {"Расчет залога и прибыли для торговли фьючерсными контрактами на FORTS","FORTS Futures mode"},
   {"Расчет прибыли и маржи по торговым облигациям на бирже","Exchange Bonds mode"},
   {"Расчет прибыли и маржи при торговле ценными бумагами на MOEX","Exchange MOEX Stocks mode"},
   {"Расчет прибыли и маржи по торговым облигациям на MOEX","Exchange MOEX Bonds mode"},
   {"Используется в качестве неторгуемого актива на счете","Collateral mode"},
   {"Неизвестный режим","Unknown mode"},
   {"Торговля по символу запрещена","Trading disabled for symbol"},
   {"Разрешены только покупки","Allowed only long positions"},
   {"Разрешены только продажи","Allowed only short positions"},
   {"Разрешены только операции закрытия позиций","Allowed only position close operations"},
   {"Нет ограничений на торговые операции","No trade restrictions"},
   {"Торговля рыночными ордерами запрещена","Trading through market orders prohibited"},
   {"Установка Limit-ордеров запрещена","Limit orders prohibited"},
   {"Установка Stop-ордеров запрещена","Stop orders prohibited"},
   {"Установка StopLimit-ордеров запрещена","StopLimit orders prohibited"},
   {"Установка StopLoss-ордеров запрещена","StopLoss orders prohibited"},
   {"Установка TakeProfit-ордеров запрещена","TakeProfit orders prohibited"},
   {"Установка CloseBy-ордеров запрещена","CloseBy orders prohibited"},
   //---
   {"Торговля по запросу","Execution by request"},
   {"Торговля по потоковым ценам","Instant execution"},
   {"Исполнение ордеров по рынку","Market execution"},
   {"Биржевое исполнение","Exchange execution"},
   //---
   {"Нет свопов","Swaps disabled (no swaps)"},
   {"Свопы начисляются в пунктах","Swaps charged in points"},
   {"Свопы начисляются в деньгах в базовой валюте символа","Swaps charged in money in symbol base currency"},
   {"Свопы начисляются в деньгах в маржинальной валюте символа","Swaps charged in money in symbol margin currency"},
   {"Свопы начисляются в деньгах в валюте депозита клиента","Swaps charged in money in client deposit currency"},
   {
    "Свопы начисляются в годовых процентах от цены инструмента на момент расчета свопа",
    "Swaps charged as specified annual interest from the instrument price at calculation of swap"
   },
   {"Свопы начисляются в годовых процентах от цены открытия позиции по символу","Swaps charged as specified annual interest from open price of position"},
   {"Свопы начисляются переоткрытием позиции по цене закрытия","Swaps charged by reopening positions by close price"},
   {"Свопы начисляются переоткрытием позиции по текущей цене Bid","Swaps charged by reopening positions by current Bid price"},
   //---
   {
    "Отложенные ордеры и уровни Stop Loss/Take Profit действительны неограниченно по времени до явной отмены",
    "Pending orders and Stop Loss/Take Profit levels valid for unlimited period until their explicit cancellation"
   },
   {
    "При смене торгового дня отложенные ордеры и все уровни StopLoss и TakeProfit удаляются",
    "At the end of the day, all Stop Loss and Take Profit levels, as well as pending orders, deleted"
   },
   {
    "При смене торгового дня удаляются только отложенные ордеры, уровни StopLoss и TakeProfit сохраняются",
    "At the end of the day, only pending orders deleted, while Stop Loss and Take Profit levels preserved"
   },
   //---
   {"Европейский тип опциона – может быть погашен только в указанную дату","European option may only be exercised on specified date"},
   {"Американский тип опциона – может быть погашен в любой день до истечения срока опциона","American option may be exercised on any trading day or before expiry"},
   {"Неизвестный тип опциона","Unknown option type"},
   {"Опцион, дающий право купить актив по фиксированной цене","Call option gives you right to buy asset at specified price"},
   {"Опцион, дающий право продать актив по фиксированной цене","Call option gives you right to sell asset at specified price"},
   //---
   {"Рыночный ордер (Да)","Market order (Yes)"},
   {"Рыночный ордер (Нет)","Market order (No)"},
   {"Лимит ордер (Да)","Limit order (Yes)"},
   {"Лимит ордер (Нет)","Limit order (No)"},
   {"Стоп ордер (Да)","Stop order (Yes)"},
   {"Стоп ордер (Нет)","Stop order (No)"},
   {"Стоп-лимит ордер (Да)","StopLimit order (Yes)"},
   {"Стоп-лимит ордер (Нет)","StopLimit order (No)"},
   {"StopLoss (Да)","StopLoss (Yes)"},
   {"StopLoss (Нет)","StopLoss (No)"},
   {"TakeProfit (Да)","TakeProfit (Yes)"},
   {"TakeProfit (Нет)","TakeProfit (No)"},
   {"Закрытие встречным (Да)","CloseBy order (Yes)"},
   {"Закрытие встречным (Нет)","CloseBy order (No)"},
   {"Вернуть (Да)","Return (Yes)"},
   {"Всё/Ничего (Да)","Fill or Kill (Yes)"},
   {"Всё/Ничего (Нет)","Fill or Kill (No)"},
   {"Всё/Частично (Да)","Immediate or Cancel order (Yes)"},
   {"Всё/Частично (Нет)","Immediate or Cancel order (No)"},
   {"Неограниченно (Да)","Unlimited (Yes)"},
   {"Неограниченно (Нет)","Unlimited (No)"},
   {"До конца дня (Да)","Valid till end of the day (Yes)"},
   {"До конца дня (Нет)","Valid till end of the day (No)"},
   {"Срок указывается в ордере (Да)","Time specified in order (Yes)"},
   {"Срок указывается в ордере (Нет)","Time specified in order (No)"},
   {"День указывается в ордере (Да)","Date specified in order (Yes)"},
   {"День указывается в ордере (Нет)","Date specified in order (No)"},
   
   {"В окно \"Обзор рынка\" добавлен символ","Added symbol to \"Market Watch\" window"},
   {"Из окна \"Обзор рынка\" удалён символ","Removed from \"Market Watch\" window"},
   {"Изменено расположение символов в окне \"Обзор рынка\"","Changed arrangement of symbols in \"Market Watch\" window"},
   {"Работа только с текущим символом","Work only with the current symbol"},
   {"Работа с предопределённым списком символов","Work with predefined list of symbols"},
   {"Работа с символами из окна \"Обзор рынка\"","Working with symbols from \"Market Watch\" window"},
   {"Работа с полным списком всех доступных символов","Work with full list of all available symbols"},
   {"Осуществлена подписка на стакан цен ","Subscribed to Depth of Market"},
   {"Осуществлена отписка от стакан цен ","Unsubscribed from Depth of Market"},
   {"Подписка на стакан цен","Subscription to Depth of Market"},
   {"Ошибка при подписке на стакан цен",""},
   {"Ошибка при отписке от стакан цен",""},
   
   //--- ENUM_SYMBOL_SECTOR
   {"Не определен","Undefined"},
   {"Сырье","Basic materials"},
   {"Услуги связи","Communication services"},
   {"Потребление циклического спроса","Consumer cyclical"},
   {"Основное потребление","Consumer defensive"},
   {"Валюты","Currencies"},
   {"Криптовалюты","Cryptocurrencies"},
   {"Энергетика","Energy"},
   {"Финансы","Finance"},
   {"Здравоохранение","Healthcare"},
   {"Промышленность","Industrials"},
   {"Недвижимость","Real estate"},
   {"Технологии","Technology"},
   {"Коммунальные услуги","Utilities"},
   {"Индексы","Indexes"},
   {"Биржевые товары","Commodities"},
   
   //--- ENUM_SYMBOL_INDUSTRY
   {"Не определено","Undefined"},
   //--- Basic materials
   {"Сельскохозяйственные ресурсы","Agricultural inputs"},
   {"Алюминий","Aluminium"},
   {"Строительные материалы","Building materials"},
   {"Химикаты","Chemicals"},
   {"Коксующийся уголь","Coking coal"},
   {"Медь","Copper"},
   {"Золото","Gold"},
   {"Производство пиломатериалов и древесины","Lumber and wood production"},
   {"Прочие промышленные металлы и добыча","Other industrial metals and mining"},
   {"Прочие драгоценные металлы и добыча","Other precious metals and mining"},
   {"Целлюлозно-бумажные изделия","Paper and paper products"},
   {"Серебро","Silver"},
   {"Специальные химикаты","Specialty chemicals"},
   {"Сталь","Steel"},
   //--- Communication services
   {"Рекламные агентства","Advertising agencies"},
   {"Вещание","Broadcasting"},
   {"Электронные игры и мультимедиа","Electronic gaming and multimedia"},
   {"Развлечения","Entertainment"},
   {"Интернет-контент и информация","Internet content and information"},
   {"Издательство","Publishing"},
   {"Телекоммуникационные услуги","Telecom services"},
   //--- Consumer cyclical
   {"Производство одежды","Apparel manufacturing"},
   {"Розничная продажа одежды","Apparel retail"},
   {"Автомобилестроение","Auto manufacturers"},
   {"Автозапчасти","Auto parts"},
   {"Дилеры легковых и грузовых автомобилей","Auto and truck dealerships"},
   {"Универсальные магазины","Department stores"},
   {"Обувь и аксессуары","Footwear and accessories"},
   {"Мебель, фурнитура и бытовая техника","Furnishing, fixtures and appliances"},
   {"Игорные предприятия","Gambling"},
   {"Розничная торговля товарами для дома","Home improvement retail"},
   {"Розничная онлайн-торговля","Internet retail"},
   {"Досуг","Leisure"},
   {"Жилье","Lodging"},
   {"Товары класса \"люкс\"","Luxury goods"},
   {"Упаковка","Packaging and containers"},
   {"Персональные услуги","Personal services"},
   {"Транспортные средства для отдыха","Recreational vehicles"},
   {"Жилищное строительство","Residential construction"},
   {"Курорты и казино","Resorts and casinos"},
   {"Рестораны","Restaurants"},
   {"Специализированная розничная торговля","Specialty retail"},
   {"Текстильное производство","Textile manufacturing"},
   {"Туристические услуги","Travel services"},
   //--- Consumer defensive
   {"Напитки - Пивовары","Beverages - Brewers"},
   {"Напитки - Безалкогольные","Beverages - Non-alcoholic"},
   {"Напитки - Винзаводы и ликеро-водочные заводы","Beverages - Wineries and distilleries"},
   {"Кондитеры","Confectioners"},
   {"Дисконтные магазины","Discount stores"},
   {"Образование и обучение","Education and training services"},
   {"Сельскохозяйственные продукты","Farm products"},
   {"Дистрибуция продуктов питания","Food distribution"},
   {"Продуктовые магазины","Grocery stores"},
   {"Товары для дома и быта","Household and personal products"},
   {"Упакованные продукты","Packaged foods"},
   {"Табак","Tobacco"},
   //--- Energy
   {"Бурение нефтяных и газовых скважин","Oil and gas drilling"},
   {"Добыча и переработка нефти и газа","Oil and gas extraction and processing"},
   {"Нефтегазовое оборудование и услуги","Oil and gas equipment and services"},
   {"Интегрированные нефтегазовые компании","Oil and gas integrated"},
   {"Транспортировка нефти и газа","Oil and gas midstream"},
   {"Переработка и сбыт нефти и газа","Oil and gas refining and marketing"},
   {"Энергетический уголь","Thermal coal"},
   {"Уран","Uranium"},
   //--- Finance
   {"Биржевой фонд","Exchange traded fund"},
   {"Управление активами","Assets management"},
   {"Банки - Диверсифицированные","Banks - Diversified"},
   {"Банки - Региональные","Banks - Regional"},
   {"Финансовые рынки","Capital markets"},
   {"Закрытый фонд - Долговые инструменты","Closed-End fund - Debt"},
   {"Закрытый фонд - Акции","Closed-end fund - Equity"},
   {"Закрытый фонд - Иностранные","Closed-end fund - Foreign"},
   {"Кредитные услуги","Credit services"},
   {"Финансовые конгломераты","Financial conglomerates"},
   {"Финансовые данные и биржи","Financial data and stock exchange"},
   {"Страховые брокеры","Insurance brokers"},
   {"Страхование - Диверсифицированные","Insurance - Diversified"},
   {"Страхование - Жизнь","Insurance - Life"},
   {"Страхование - Недвижимость и несчастные случаи","Insurance - Property and casualty"},
   {"Страхование - Перестрахование","Insurance - Reinsurance"},
   {"Страхование - Специальное","Insurance - Specialty"},
   {"Ипотечное финансирование","Mortgage finance"},
   {"Шелл-компании","Shell companies"},
   //--- Healthcare
   {"Биотехнологии","Biotechnology"},
   {"Диагностика и исследования","Diagnostics and research"},
   {"Фармацевтическое производство - Общее","Drugs manufacturers - general"},
   {"Фармацевтическое производство - Специальное и дженерики","Drugs manufacturers - Specialty and generic"},
   {"Планы здравоохранения","Healthcare plans"},
   {"Информационные службы здравоохранения","Health information services"},
   {"Медицинские учреждения","Medical care facilities"},
   {"Медицинское оборудование","Medical devices"},
   {"Медицинские дистрибьюторы","Medical distribution"},
   {"Медицинские инструменты и расходные материалы","Medical instruments and supplies"},
   {"Фармацевтические ритейлеры","Pharmaceutical retailers"},
   //--- Industrials
   {"Аэрокосмическая и оборонная промышленность","Aerospace and defense"},
   {"Авиакомпании","Airlines"},
   {"Аэропорты и воздушные перевозки","Airports and air services"},
   {"Строительные материалы и оборудование","Building products and equipment"},
   {"Деловое оборудование и материалы","Business equipment and supplies"},
   {"Конгломераты","Conglomerates"},
   {"Консалтинговые услуги","Consulting services"},
   {"Электрооборудование и запчасти","Electrical equipment and parts"},
   {"Инженерное дело и строительство","Engineering and construction"},
   {"Сельскохозяйственное и тяжелое строительное оборудование","Farm and heavy construction machinery"},
   {"Промышленные дистрибьюторы","Industrial distribution"},
   {"Инфраструктурные операции","Infrastructure operations"},
   {"Интегрированные перевозки и логистика","Integrated freight and logistics"},
   {"Морские перевозки","Marine shipping"},
   {"Металлопроизводство","Metal fabrication"},
   {"Контроль загрязнения и очистка","Pollution and treatment controls"},
   {"Железные дороги","Railroads"},
   {"Аренда и лизинг","Rental and leasing services"},
   {"Безопасность и защита","Security and protection services"},
   {"Специализированные бизнес-услуги","Specialty business services"},
   {"Специализированные промышленные машины","Specialty industrial machinery"},
   {"Услуги по трудоустройству","Stuffing and employment services"},
   {"Инструменты и инвентарь","Tools and accessories"},
   {"Грузоперевозки","Trucking"},
   {"Управление отходами","Waste management"},
   //--- Real estate
   {"Недвижимость - Строительство","Real estate - Development"},
   {"Недвижимость - Диверсифицированные","Real estate - Diversified"},
   {"Услуги в сфере недвижимости","Real estate services"},
   {"Инвестиционный фонд недвижимости - Диверсифицированные","REIT - Diversified"},
   {"Инвестиционный фонд недвижимости - Медицинские учреждения","REIT - Healthcase facilities"},
   {"Инвестиционный фонд недвижимости - Отели","REIT - Hotel and motel"},
   {"Инвестиционный фонд недвижимости - Промышленность","REIT - Industrial"},
   {"Инвестиционный фонд недвижимости - Ипотека","REIT - Mortgage"},
   {"Инвестиционный фонд недвижимости - Офисы","REIT - Office"},
   {"Инвестиционный фонд недвижимости - Жилые помещения","REIT - Residential"},
   {"Инвестиционный фонд недвижимости - Розница","REIT - Retail"},
   {"Инвестиционный фонд недвижимости - Специальные помещения","REIT - Specialty"},
   //--- Technology
   {"Коммуникационное оборудование","Communication equipment"},
   {"Компьютерное оборудование","Computer hardware"},
   {"Бытовая электроника","Consumer electronics"},
   {"Электронные компоненты","Electronic components"},
   {"Дистрибуция электроники и компьютеров","Electronics and computer distribution"},
   {"Услуги информационных технологий","Information technology services"},
   {"Научно-технические инструменты","Scientific and technical instruments"},
   {"Полупроводниковое оборудование и материалы","Semiconductor equipment and materials"},
   {"Полупроводники","Semiconductors"},
   {"Программное обеспечение - Приложения","Software - Application"},
   {"Программное обеспечение - Инфраструктура","Software - Infrastructure"},
   {"Солнечная энергетика","Solar"},
   //--- Utilities
   {"Коммунальные предприятия - Диверсифицированные","Utilities - Diversified"},
   {"Коммунальные предприятия - Независимые производители энергии","Utilities - Independent power producers"},
   {"Коммунальные предприятия - Возобновляемая энергия","Utilities - Renewable"},
   {"Коммунальные предприятия - Регулируемые электрические компании","Utilities - Regulated electric"},
   {"Коммунальные предприятия - Регулируемые газовые компании","Utilities - Regulated gas"},
   {"Коммунальные предприятия - Регулируемые водоканалы","Utilities - Regulated water"},
   
//--- CAccount
   {"Аккаунт","Account"},
   {"Номер счёта","Account number"},
   {"Тип торгового счета","Account trade mode"},
   {"Размер предоставленного плеча","Account leverage"},
   {"Максимально допустимое количество действующих отложенных ордеров","Maximum allowed number of active pending orders"},
   {"Режим задания минимально допустимого уровня залоговых средств","Mode for setting minimum allowed margin"},
   {"Разрешенность торговли для текущего счета","Allowed trade for the current account"},
   {"Разрешенность торговли для эксперта","Allowed trade for Expert Advisor"},
   {"Режим расчета маржи","Margin calculation mode"},
   {"Количество знаков после запятой для валюты счета","Number of decimal places in account currency"},
   {"Тип торгового сервера","Type of trading server"},
   {"Признак закрытия позиций только по правилу FIFO","Sign of closing positions only according to FIFO rule"},
   //---
   {"Баланс счета","Account balance"},
   {"Предоставленный кредит","Account credit"},
   {"Текущая прибыль на счете","Current profit on account"},
   {"Собственные средства на счете","Account equity"},
   {"Зарезервированные залоговые средства на счете","Account margin used in deposit currency"},
   {"Свободные средства на счете, доступные для открытия позиции","Free margin of account"},
   {"Уровень залоговых средств на счете в процентах","Account margin level in percents"},
   {"Уровень залоговых средств для наступления Margin Call","Margin call level"},
   {"Уровень залоговых средств для наступления Stop Out","Margin stop out level"},
   {
    "Зарезервированные средства для обеспечения гарантийной суммы по всем отложенным ордерам",
    "Amount reserved on account to cover margin of all pending orders"
   },
   {
    "Зарезервированные средства для обеспечения минимальной суммы по всем открытым позициям",
    "Min equity reserved on account to cover the min amount of all open positions"
   },
   {"Текущий размер активов на счёте","Сurrent assets of account"},
   {"Текущий размер обязательств на счёте","Сurrent liabilities on account"},
   {"Сумма заблокированных комиссий по счёту","Сurrent blocked commission amount on account"},
   //---
   {"Имя клиента","Client name"},
   {"Имя торгового сервера","Trade server name"},
   {"Валюта депозита","Account currency"},
   {"Имя компании, обслуживающей счет","Name of company that serves account"},
   //---
   {"Демонстрационный счёт","Demo account"},
   {"Конкурсный счёт","Contest account"},
   {"Реальный счёт","Real account"},
   {"Неизвестный тип счёта","Unknown account type"},
   //---
   {"Уровень задается в процентах","Account StopOut mode in percents"},
   {"Уровень задается в деньгах","Account StopOut mode in money"},
   {"Внебиржевой рынок в режиме \"Неттинг\"","Netting mode"},
   {"Внебиржевой рынок в режиме \"Хеджинг\"","Hedging mode"},
   {"Биржевой рынок","Exchange market mode"},
   {"Закрытие встречным доступно только на счетах с типом \"Хеджинг\"","Close by opposite position available only on \"Hedging\" accounts"},
   {"Ошибка. Позиции для встречного закрытия имеют один и тот же тип","Error. Positions of the same type in counterclosure request"},
   
//--- CEngine
   {"С момента последнего запуска ЕА торговых событий не было","No trade events since the last launch of EA"},
   {"Не удалось получить описание последнего торгового события","Failed to get description of the last trading event"},
   {"Не удалось получить список открытых позиций","Failed to get open positions list"},
   {"Не удалось получить список установленных ордеров","Failed to get pending orders list"},
   {"Нет открытых позиций","No open positions"},
   {"Нет установленных ордеров","No placed orders"},
   {"Внимание! Значение \"indicator_plots\" должно быть ","Attention! Value of \"indicator_plots\" should be "},
   {"Внимание! Значение \"indicator_buffers\" должно быть ","Attention! Value of \"indicator_buffers\" should be "},
   
//--- CTrading
   {"В терминале нет разрешения на проведение торговых операций (отключена кнопка \"Авто-торговля\")","No permission to conduct trading operations in terminal (\"AutoTrading\" button disabled)"},
   {"Для советника нет разрешения на проведение торговых операций (F7 --> Общие --> \"Разрешить автоматическую торговлю\")","EA does not have permission to conduct trading operations (F7 --> Common --> \"Allow Automatic Trading\")"},
   {"Для текущего счёта запрещена торговля","Trading prohibited for the current account"},
   {"Для советников на текущем счёте запрещена торговля на стороне торгового сервера","From the side of trade server, trading for EA on the current account prohibited"},
   {"Запрос отклонён до отправки на сервер по причине:","Request rejected before being sent to server due to:"},
   {"Ошибочный запрос:","Invalid request:"},
   {"Недостаточно средств для совершения торговой операции","Not enough money to perform trading operation"},
   {"Превышен максимальный совокупный объём ордеров и позиций в одном направлении","Exceeded maximum total volume of orders and positions in one direction"},
   {"Объём в запросе меньше минимально-допустимого","Volume in request less than minimum allowable"},
   {"Объём в запросе больше максимально-допустимого","Volume in request greater than maximum allowable"},
   {"Закрытие встречным запрещено","CloseBy orders prohibited"},
   {"Объём в запросе не кратен минимальной градации шага изменения лота","Volume in request not a multiple of minimum gradation of step for changing lot"},
   {"Символы встречных позиций не равны","Symbols of two opposite positions not equal"},
   {"Значение StopLoss нарушает требования по параметру StopLevel символа","StopLoss values violate StopLevel parameter requirements"},
   {"Значение TakeProfit нарушает требования по параметру StopLevel символа","TakeProfit values violate StopLevel parameter requirements"},
   {"Дистанция установки ордера в пунктах меньше разрешённой параметром StopLevel символа","Distance to place order in points less than allowed by symbol's StopLevel"},
   {"Дистанция установки лимит-ордера относительно стоп-ордера меньше разрешённой параметром StopLevel символа","Distance to place limit order relative to stop order less than allowed by symbol's StopLevel"},
   {"Дистанция от цены до StopLoss меньше разрешённой параметром FreezeLevel символа","Distance from price to StopLoss less than allowed by symbol's FreezeLevel"},
   {"Дистанция от цены до TakeProfit меньше разрешённой параметром FreezeLevel символа","Distance from price to TakeProfit less than allowed by symbol's FreezeLevel"},
   {"Дистанция от цены до цены срабатывания ордера меньше разрешённой параметром FreezeLevel символа","Distance from price to order triggering price less than allowed by symbol's FreezeLevel"},
   {"Неподдерживаемый тип параметра StopLoss (необходимо int или double)","Unsupported StopLoss parameter type (int or double required)"},
   {"Неподдерживаемый тип параметра TakeProfit (необходимо int или double)","Unsupported TakeProfit parameter type (int or double required)"},
   {"Неподдерживаемый тип параметра цены (необходимо int или double)","Unsupported price parameter type (int or double required)"},
   {"Неподдерживаемый тип параметра цены limit-ордера (необходимо int или double)","Unsupported type of price parameter for limit order (int or double required)"},
   {"Неподдерживаемый тип параметра цены в запросе","Unsupported price parameter type in request"},
   {"Торговля отключена для эксперта до устранения причины запрета","Trading for expert disabled till this ban eliminated"},
   {"Торговая операция прервана","Trading operation aborted"},
   {"Корректировка параметров торгового запроса ...","Correction of trade request parameters ..."},
   {"Создание отложенного запроса","Create pending request"},
   {"Нет возможности скорректировать лот","Unable to correct lot"},
   {"Не удалось создать отложенный запрос","Failed to create pending request"},
   {"Торговая попытка #","Trading attempt #"},
   {"Повторная торговая попытка #","Retry trading attempt #"},
   
   {"Тип выполняемого действия","Trade operation type"},
   {"Штамп эксперта (magic number)","Expert Advisor ID (magic number)"},
   {"Тикет ордера","Order ticket"},
   {"Имя торгового инструмента","Trade symbol"},
   {"Запрашиваемый объем сделки в лотах","Requested volume for a deal in lots"},
   {"Цена","Price"},
   {"Уровень StopLimit ордера","StopLimit order level"},
   {"Уровень Stop Loss ордера","StopLoss order level"},
   {"Уровень Take Profit ордера","TakeProfit order level"},
   {"Максимальное отклонение от цены","Maximal deviation from the price"},
   {"Тип ордера","Order type"},
   {"Тип ордера по исполнению","Order execution type"},
   {"Тип ордера по времени действия","Order expiration type"},
   {"Срок истечения ордера","Order expiration time"},
   {"Комментарий к ордеру","Order comment"},
   {"Тикет позиции","Position ticket"},
   {"Тикет встречной позиции","Opposite position ticket"},
   
   {"Поставить рыночный ордер","Place market order"},
   {"Установить отложенный ордер","Place pending order"},
   {"Изменить значения Stop Loss и Take Profit у открытой позиции","Modify Stop Loss and Take Profit values of an opened position"},
   {"Изменить параметры отложенного ордера","Modify pending order parameters"},
   {"Удалить отложенный ордер","Delete pending order"},
   {"Закрыть позицию встречной","Close a position by an opposite one"},
   {"Неизвестный тип торговой операции","Unknown trade action type"},
   
   {"Ордер исполняется исключительно в указанном объеме, иначе отменяется (FOK)","The order is executed exclusively in the specified volume, otherwise it is canceled (FOK)"},
   {"Ордер исполняется на доступный объем, неисполненный отменяется (IOK)","Order executed on available volume, unfulfilled canceled (IOK)"},
   {"Ордер исполняется на доступный объем, неисполненный остаётся (Return)","Order executed at available volume, unfulfilled remains in market (Return)"},
   
   {"Ордер действителен до явной отмены","Good Till Cancel order"},
   {"Ордер действителен только в течение текущего торгового дня","Good till current trade day order"},
   {"Ордер действителен до даты истечения","Good till expired order"},
   {"Ордер действителен до 23:59:59 указанного дня","Order will be effective till 23:59:59 of specified day"},
   
   {"Отложенный запрос #","Pending request #"},
   {"Активирован отложенный запрос: #","Pending request activated: #"},
   {"Параметры торгового запроса","Trade request parameters"},
   {"Параметры отложенного торгового запроса","Pending trade request parameters"},
   {"Создан отложенный запрос","Pending request created"},
   {"Удалён в связи с окончанием времени его действия","Deleted due to expiration"},
   {"Удалён в связи с его исполнением","Deleted due completed"},
   {"Не удалось получить объект-отложенный запрос из списка","Failed to get pending request object from list"},
   {"Не удалось добавить параметры активации запроса. Ошибка: ","Failed to add request activation parameters. Error: "},
   
   {"Цена в момент создания запроса","Price at time of request create"},
   {"Время создания запроса","Request creation time"},
   {"Время активации запроса","Request activation time"},
   {"Время ожидания между торговыми попытками","Waiting time between trading attempts"},
   {"Текущая торговая попытка","Current trading attempt"},
   {"Общее количество торговых попыток","Total trade attempts"},
   {"Идентификатор отложенного запроса","Pending request ID"},
   {"Код возврата, на основании которого создан запрос","Return code based on which the request was created"},
   {"Тип отложенного запроса","Pending request type"},
   {"Отложенный запрос, созданный по коду ошибки","Pending request that was created as a result of the error code"},
   {"Отложенный запрос, созданный по запросу","Pending request created by request"},
   {"Ожидание наступления времени первой торговой попытки","Waiting for the onset time of the first trading attempt"},
   
   {"Статус отложенного запроса","Pending request status"},
   {"Отложенный запрос на открытие позиции","Pending request to open position"},
   {"Отложенный запрос на закрытие позиции","Pending request to close position"},
   {"Отложенный запрос на модификацию стоп-приказов позиции","Pending request to modify position stop orders"},
   {"Отложенный запрос на установку отложенного ордера","Pending request to place pending order"},
   {"Отложенный запрос на удаление отложенного ордера","Pending request to remove pending order"},
   {"Отложенный запрос на модификацию параметров отложенного ордера","Pending request to modify pending order parameters"},
   
   {"Фактический объем","Actual volume"},
   {"Фактическая цена установки ордера","Actual order placement price"},
   {"Фактическая цена установки StopLimit-ордера","Actual StopLimit-order placement price"},
   {"Фактическая цена установки StopLoss-ордера","Actual StopLoss-order placement price"},
   {"Фактическая цена установки TakeProfit-ордера","Actual TakeProfit-order placement price"},
   {"Фактический тип заливки ордера","Actual order filling type"},
   {"Фактический тип экспирации ордера","Actual of order expiration type"},
   {"Фактическое время жизни ордера","Actual of order lifetime"},
   
   {"Нет свободных идентификаторов для создания отложенного запроса","No free IDs to create pending request"},
   {"Условия активации","Activation terms"},
   {"Критерий","Criterion"},
   {"Добавлены условия активации отложенного запроса","Pending request activation conditions added"},
   
//--- CBar
   {"Не удалось получить данные бара","Failed to get bar data"},
   {"Не удалось записать время в структуру времени","Failed to write time to datetime structure"},
   {"Не удалось получить данные таймсерии","Failed to get timeseries data"},
   {"Не удалось добавить объект-бар в список","Failed to add bar object to list"},
   {"Бар","Bar"},
   {"Таймфрейм","Timeframe"},
   {"Спред","Spread"},
   {"Тиковый объём","Tick volume"},
   {"Биржевой объём","Real volume"},
   {"Время начала периода","Period start time"},
   {"Год","Year"},
   {"Месяц","Month"},
   {"Порядковый номер дня в году","Sequence day number in the year"},
   {"День недели","Day of week"},
   {"День месяца","Day od month"},
   {"Час","Hour"},
   {"Минута","Minute"},
   {"Индекс в таймсерии","Timeseries index"},
   {"Наивысшая цена за период","Highest price for the period"},
   {"Наименьшая цена за период","Lowest price for the period"},
   {"Размер свечи","Candle size"},
   {"Размер тела свечи","Candle body size"},
   {"Размер верхней тени свечи","Candle upper shadow size"},
   {"Размер нижней тени свечи","Candle lower shadow size"},
   {"Верх тела свечи","Top of the candle body"},
   {"Низ тела свечи","Bottom of the candle body"},
   
   {"Бычий бар","Bullish bar"},
   {"Медвежий бар","Bearish bar"},
   {"Нулевой бар","Zero-bar"},
   {"Свеча с нулевым телом","Candle with zero body"},
   {"Сначала нужно установить требуемое количество данных при помощи SetRequiredUsedData()","First you need to set required amount of data using SetRequiredUsedData()"},
   
//--- CTimeSeries
   {"Сначала нужно установить символ при помощи SetSymbol()","First you need to set the Symbol using SetSymbol()"},
   {"Таймсерия не используется. Нужно установить флаг использования при помощи SetAvailable()","Timeseries are not used. Need to set the use flag using SetAvailable()"},
   {"Неизвестный таймфрейм","Unknown timeframe"},
   {"Не удалось получить объект-таймсерию ","Failed to get timeseries object "},
   {"Запрошенная глубина истории: ","Required history depth: "},
   {"Фактическая глубина истории: ","Actual history depth: "},
   {"Создано исторических данных: ","Total historical data created: "},
   {"Баров истории на сервере: ","Server history Bars number: "},
   {"Таймсерия символа","Symbol time series"},
   {"Таймсерия","Timeseries"},
   {"Запрошено","Required"},
   {"Фактически","Actual"},
   {"Создано","Created"},
   {"На сервере","On server"},
   {"Самая первая дата по символу-периоду","The very first date for the symbol-period"},
   {"Время открытия последнего бара по символу-периоду","Open time of the last bar of the symbol-period"},
   {"Самая первая дата в истории по символу на сервере","The very first date in the history of the symbol on the server"},
   {"Самая первая дата в истории по символу в клиентском терминале","The very first date in the history of the symbol in the client terminal"},
   {"создана успешно","created successfully"},
   {"не создана","not created"},
   {"синхронизирована","synchronized"},
   {"Попытка: ","Attempt: "},
   {"Ожидание синхронизации данных ...","Waiting for data synchronization ..."},
   
//--- CBuffer
   {"Индекс базового буфера данных","Index of Base data buffer"},
   {"Порядковый номер рисуемого буфера","Plot buffer sequence number"},
   {"Индекс буфера цвета","Color buffer index"},
   {"Количество буферов данных","Number of data buffers"},
   {"Индекс массива для назначения следующим индикаторным буфером","Array index for assignment as the next indicator buffer"},
   {"Индекс следующего по счёту рисуемого буфера","Index of the next drawable buffer"},
   {"Идентификатор буферов индикатора","Indicator Buffer Id"},
   {"Линия индикатора","Indicator line"},
   {"Хэндл индикатора, использующего буфер","Indicator handle that uses the buffer"},
   {"Тип индикатора, использующего буфер","Indicator type that uses the buffer"},
   {"Номер дополнительной линии","Additional line number"},
   {"Период данных буфера (таймфрейм)","Buffer data Period (Timeframe)"},
   {"Статус буфера","Buffer status"},
   {"Тип буфера","Buffer type"},
   {"Активен","Active"},
   {"Код стрелки","Arrow code"},
   {"Смещение стрелок по вертикали","Vertical shift of arrows"},
   {"Количество начальных баров без отрисовки и значений в DataWindow","Number of initial bars without drawing and values in DataWindow"},
   {"Тип графического построения","Type of graphical construction"},
   {"Отображение значений построения в окне DataWindow","Display construction values in DataWindow"},
   {"Сдвиг графического построения индикатора по оси времени в барах","Shift of indicator plotting along time axis in bars"},
   {"Стиль линии отрисовки","Drawing line style "},
   {"Толщина линии отрисовки","Thickness of drawing line"},
   {"Размер значка стрелки","Arrow icon size"},
   {"Количество цветов","Number of colors"},
   {"Цвет отрисовки","The index of a buffer containing the drawing color"},
   {"Пустое значение для построения, для которого нет отрисовки","Empty value for plotting, for which there is no drawing"},
   {"Символ буфера","Buffer Symbol"},
   {"Имя индикаторной графической серии, отображаемое в окне DataWindow","Name of indicator graphical series to display in DataWindow"},
   {"Наименование индикатора, использующего буфер","Name of indicator that uses buffer"},
   {"Короткое наименование индикатора, использующего буфер","The shortname of the indicator that uses the buffer"},
   {"Индикаторный буфер с типом графического построения","Indicator buffer with graphic plot type"},
   {"Неправильно указано количество буферов индикатора (#property indicator_buffers)","Number of indicator buffers is incorrect (#property indicator_buffers)"},
   {"Достигнуто максимально возможное количество индикаторных буферов","Maximum number of indicator buffers reached"},
   {"Нет ни одного объекта-буфера для стандартного индикатора","There is no buffer object for the standard indicator"},
   
   {"Нет отрисовки","No drawing"},
   {"Цветовая заливка между двумя уровнями","Color fill between the two levels"},
   {"Линия","Line"},
   {"Гистограмма от нулевой линии","Histogram from the zero line"},
   {"Отрисовка стрелками","Drawing arrows"},
   {"Отрезки","Section"},
   {"Гистограмма на двух индикаторных буферах","Histogram of the two indicator buffers"},
   {"Зигзаг","Zigzag"},
   {"Отображение в виде баров","Display as sequence of bars"},
   {"Отображение в виде свечей","Display as sequence of candlesticks"},
   
   {"Расчётный буфер","Calculated buffer"},
   {"Цветной буфер данных","Colored Data buffer"},
   {"Буфер","Buffer"},
   
   {"Сплошная линия","Solid line"},
   {"Прерывистая линия","Broken line"},
   {"Пунктирная линия","Dotted line"},
   {"Штрих-пунктирная линия","Dash-dot line"},
   {"Штрих - две точки","Dash - two points"},
   
//--- CIndicatorDE
   {"Статус индикатора","Indicator status"},
   {"Стандартный индикатор","Standard indicator"},
   {"Пользовательский индикатор","Custom indicator"},
   {"Тип индикатора","Indicator type"},
   {"Таймфрейм индикатора","Indicator timeframe"},
   {"Хэндл индикатора","Indicator handle"},
   {"Группа индикатора","Indicator group"},
   {"Трендовый индикатор","Trend indicator"},
   {"Осциллятор","Solid lineOscillator"},
   {"Объёмы","Volumes"},
   {"Стрелочный индикатор","Arrow indicator"},
   {"Идентификатор индикатора","Indicator ID"},
   {"Пустое значение для построения, для которого нет отрисовки","Empty value for plotting, for which there is no drawing"},
   {"Символ индикатора","Indicator symbol"},
   {"Имя индикатора","Indicator name"},
   {"Короткое имя индикатора","Indicator shortname"},
   
   {"Параметры индикатора","Indicator parameters"},
   {"Тип объема для расчета","Volume type for calculation"},
   {"Период усреднения","Averaging period"},
   {"Период быстрой скользящей","Fast MA period"},
   {"Период медленной скользящей","Slow MA period"},
   {"Период усреднения разности","Averaging period for their difference"},
   {"Период Tenkan-sen","Tenkan-sen period"},
   {"Период Kijun-sen","Kijun-sen period"},
   {"Период Senkou Span B","Senkou Span B period"},
   {"Период для расчета челюстей","Period for the calculation of jaws"},
   {"Период для расчета зубов","Period for the calculation of teeth"},
   {"Период для расчета губ","Period for the calculation of lips"},
   {"Смещение челюстей по горизонтали","Horizontal shift of jaws"},
   {"Смещение зубов по горизонтали","Horizontal shift of teeth"},
   {"Смещение губ по горизонтали","Horizontal shift of lips"},
   {"Смещение индикатора по горизонтали","Horizontal shift of the indicator"},
   {"Тип сглаживания","Smoothing type"},
   {"Тип цены или handle","Price type or handle"},
   {"Количество стандартных отклонений","Number of standard deviations"},
   {"Отклонение границ от средней линии","Deviation of boundaries from the midline"},
   {"Шаг изменения цены - коэффициент ускорения","Price increment step - acceleration factor"},
   {"Максимальный шаг","Maximum value of step"},
   {"K-период (количество баров для расчетов)","K-period (number of bars for calculations)"},
   {"D-период (период первичного сглаживания)","D-period (period of first smoothing)"},
   {"Окончательное сглаживание","Final smoothing"},
   {"Способ расчета стохастика","Stochastic calculation method"},
   {"Период Chande Momentum","Chande Momentum period"},
   {"Период фактора сглаживания","Smoothing factor period"},
   {"Входной параметр","Input parameter"},
   
//--- CIndicatorsCollection
   {"Ошибка. Не удалось добавить объект-индикатор в список","Error. Failed to add indicator object to list"},
   {"Ошибка. Передан неверный указатель на объект-индикатор","Error. Invalid pointer to indicator object passed"},
   {"Ошибка. Уже существует объект-индикатор с идентификатором","Error. There is already exist an indicator object with ID"},
   
//--- CDataInd
   {"Номер буфера индикатора","Indicator buffer number"},
   {"Значение буфера индикатора","Indicator buffer value"},
   
//--- CSeriesDataInd
   {"Метод не предназначен для работы с программами-индикаторами","The method is not intended for working with indicator programs"},
   {"Не удалось получить таймсерию индикаторных данных","Failed to get indicator data timeseries"},
   {"Не удалось получить текущие данные буфера индикатора","Failed to get the current data of the indicator buffer"},
   {"Не удалось создать объект индикаторных данных","Failed to create indicator data object"},
   {"Не удалось добавить объект индикаторных данных в список","Failed to add indicator data object to the list"},
   
//--- CTick
   {"Тик","Tick"},
   {"Время последнего обновления цен в миллисекундах","Last price update time in milliseconds"},
   {"Время последнего обновления цен","Last price update time"},
   {"Объем для текущей цены Last","Volume for the current Last price"},
   {"Флаги","Flags"},
   {"Объем для текущей цены Last c повышенной точностью","Volume for the current \"Last\" price with increased accuracy"},
   {"Спред","Spread"},
   {"Изменённые данные на тике:","Changed data on a tick:"},
   {"Изменение цены Bid","Bid price change"},
   {"Изменение цены Ask","Ask price change"},
   {"Изменение цены последней сделки","Last price change"},
   {"Изменение объема","Volume change"},
   
//--- TickSeries
   {"Тиковая серия","Tickseries"},
   {"Ошибка получения тиковых данных","Error getting tick data"},
   {"Не удалось создать объект тиковых данных","Failed to create tick data object"},
   {"Не удалось добавить объект тиковых данных в список","Failed to add tick data object to the list"},
   {"Тиковая серия не используется. Нужно установить флаг использования при помощи SetAvailable()","Tick series are not used. Need to set the use flag using SetAvailable()"},
   {"Запрошенное количество дней: ","Number of days requested: "},
   
//--- CMarketBookOrd
   {"Заявка в стакане цен","Order in Depth of Market"},
   {"Объем","Volume"},
   {"Объем c повышенной точностью","Volume Real"},
   {"Сторона Buy","Buy side"},
   {"Сторона Sell","Sell side"},
   {"Заявка на продажу","Sell order"},
   {"Заявка на покупку","Buy order"},
   {"Заявка на продажу по рыночной цене","Sell order at market price"},
   {"Заявка на покупку по рыночной цене","Buy order at market price"},
   
//--- CMarketBookSnapshot
   {"Снимок стакана цен","Depth of Market Snapshot"},
   {"Объём на покупку","Buy Volume"},
   {"Объём на продажу","Sell Volume"},
   
//--- CMBookSeries
   {"Серия снимков стакана цен","Series of shots of the Depth of Market"},
   {"Ошибка. Не удалось добавить серию снимков стакана цен в список","Error. Failed to add a shots series of the Depth of Market to the list"},
   
//--- CMBookSeriesCollection
   {"Коллекция серий снимков стакана цен","Collection of series of the Depth of Market shot"},   
   
//--- CMQLSignal
   {"Сигнал","Signal"},
   {"Сигнал сервиса сигналов mql5.com","Signal from mql5.com signal service"},
   {"Тип счета","Account type"},
   {"Дата публикации","Publication date"},
   {"Дата начала мониторинга","Monitoring starting date"},
   {"Дата последнего обновления торговой статистики","The date of the last update of the signal's trading statistics"},
   {"ID","ID"},
   {"Плечо торгового счета","Account leverage"},
   {"Результат торговли в пипсах","Profit in pips"},
   {"Позиция в рейтинге сигналов","Position in rating"},
   {"Количество подписчиков","Number of subscribers"},
   {"Количество трейдов","Number of trades"},
   {"Состояние подписки счёта на этот сигнал","Account subscription status for this signal"},
   {"Средства на счете","Account equity"},
   {"Прирост счета в процентах","Account gain"},
   {"Максимальная просадка","Account maximum drawdown"},
   {"Цена подписки на сигнал","Signal subscription price"},
   {"Значение ROI (Return on Investment) сигнала в %","Return on Investment (%)"},
   {"Логин автора","Author login"},
   {"Наименование брокера (компании)","Broker name (company)"},
   {"Сервер брокера","Broker server"},
   {"Имя","Name"},
   {"Валюта счета","Base currency"},
   {"Прирост","Gain"},
   {"Просадка","Drawdown"},
   {"Подписчиков","Subscribers"},
   
//--- CMQLSignalsCollection
   {"Коллекция сигналов сервиса сигналов mql5.com","Collection of signals from the mql5.com signal service"},
   {"Платных сигналов","Paid signals"},
   {"Бесплатных сигналов","Free signals"},
   {"Новый сигнал добавлен в коллекцию","New signal added to collection"},
   {"Не удалось получить сигнал из коллекции","Failed to get signal from collection"},
   {"Параметры копирования сигнала","Signal copying parameters"},
   {"Процент для конвертации объема сделки","Equity limit"},
   {"Проскальзывание, с которым выставляются рыночные ордера при синхронизации позиций и копировании сделок","Slippage (used when placing market orders in synchronization of positions and copying of trades)"},
   {"Ограничение по средствам для сигнала","Maximum percent of deposit used"},
   {"Разрешение синхронизации без показа диалога подтверждения","Allow synchronization without confirmation dialog"},
   {"Копирование Stop Loss и Take Profit","Copy Stop Loss and Take Profit"},
   {"Ограничение по депозиту","Deposit percent"},
   {"Идентификатор сигнала","Signal ID"},
   {"Разрешение на копирование сделок по подписке","Permission to copy trades by subscription"},
   {"Согласие с условиями использования сервиса \"Сигналы\"","Agree to the terms of use of the \"Signals\" service"},
   {"Имя сигнала","Signal name"},
   {"Разрешение на работу с сигналами для программы","Permission to work with signals for the program"},
   {"Осуществлена подписка на сигнал","Signal subscribed"},
   {"Осуществлена отписка от сигнала","Signal unsubscribed"},
   {"Работа с сервисом сигналов для программы не разрешена","Work with the \"Signals\" service is not allowed for the program"},
   {
    "Пожалуйста, проверьте настройки программы (Общие --> Разрешить изменение настроек Сигналов)",
    "Please check the program settings (Common --> Allow modification of Signals settings)"
   },
   
//--- CChartObj
   {"Идентификатор графика","Chart ID"},
   {"Отрисовка атрибутов ценового графика","Drawing attributes of a price chart"},
   {"Объект \"График\"","Object \"Chart\""},
   {"График поверх всех других","Chart on top of other charts"},
   {"Доступ к контекстному меню по нажатию правой клавиши мыши","Accessing the context menu by pressing the right mouse button"},
   {"Доступ к инструменту \"Перекрестие\" по нажатию средней клавиши мыши","Accessing the \"Crosshair tool\" by pressing the middle mouse button"},
   {"Прокрутка графика левой кнопкой мышки по горизонтали","Scrolling the chart horizontally using the left mouse button"},
   {"Отправка всем mql5-программам на графике сообщений о событиях колёсика мыши","Sending messages about mouse wheel events to all mql5 programs on a chart"},
   {"Отправка всем mql5-программам на графике сообщений о событиях перемещения и нажатия кнопок мыши","Send notifications of mouse move and mouse click events to all mql5 programs on a chart"},
   {"Отправка всем mql5-программам на графике сообщений о событии создания графического объекта","Send a notification of an event of new object creation to all mql5-programs on a chart"},
   {"Отправка всем mql5-программам на графике сообщений о событии уничтожения графического объекта","Send a notification of an event of object deletion to all mql5-programs on a chart"},
   {"Тип графика","Chart type"},
   {"Ценовой график на переднем плане","Price chart in the foreground"},
   {"Отступ ценового графика от правого края","Price chart indent from the right border"},
   {"Автоматический переход к правому краю графика","Automatic moving to the right border of the chart"},
   {"Управление графиком с помощью клавиатуры","Managing the chart using a keyboard"},
   {"Перехват графиком нажатий клавиш Space и Enter для активации строки быстрой навигации","Allowed to intercept Space and Enter key presses on the chart to activate the quick navigation bar"},
   {"Масштаб","Scale"},
   {"Фиксированный масштаб","Fixed scale mode"},
   {"Масштаб 1:1","Scale 1:1 mode"},
   {"Масштаб в пунктах на бар","Scale to be specified in points per bar"},
   {"Отображение в левом верхнем углу тикера символа","Display a symbol ticker in the upper left corner"},
   {"Отображение в левом верхнем углу значений OHLC","Display OHLC values in the upper left corner"},
   {"Отображение значения Bid горизонтальной линией на графике","Display Bid values as a horizontal line in a chart"},
   {"Отображение значения Ask горизонтальной линией на графике","Display Ask values as a horizontal line in a chart"},
   {"Отображение значения Last горизонтальной линией на графике","Display Last values as a horizontal line in a chart"},
   {"Отображение вертикальных разделителей между соседними периодами","Display vertical separators between adjacent periods"},
   {"Отображение сетки на графике","Display grid in the chart"},
   {"Отображение объемов на графике","Display volume in the chart"},
   {"Отображение текстовых описаний объектов","Display textual descriptions of objects"},
   {"Количество баров на графике, доступных для отображения","The number of bars on the chart that can be displayed"},
   {"Общее количество окон графика с подокнами индикаторов","The total number of chart windows, including indicator subwindows"},
   {"Видимость подокна","Visibility of subwindow"},
   {"Хэндл окна графика","Chart window handle"},
   {"Дистанция в пикселях по оси Y между верхней рамкой подокна индикатора и верхней рамкой главного окна графика","The distance between the upper frame of the indicator subwindow and the upper frame of the main chart window"},
   {"Номер первого видимого бара на графике","Number of the first visible bar in the chart"},
   {"Ширина графика в барах","Chart width in bars"},
   {"Ширина графика в пикселях","Chart width in pixels"},
   {"Высота графика в пикселях","Chart height in pixels"},
   {"Цвет фона графика","Chart background color"},
   {"Цвет осей, шкалы и строки OHLC","Color of axes, scales and OHLC line"},
   {"Цвет сетки","Grid color"},
   {"Цвет объемов и уровней открытия позиций","Color of volumes and position opening levels"},
   {"Цвет бара вверх, тени и окантовки тела бычьей свечи","Color for the up bar, shadows and body borders of bull candlesticks"},
   {"Цвет бара вниз, тени и окантовки тела медвежьей свечи","Color for the down bar, shadows and body borders of bear candlesticks"},
   {"Цвет линии графика и японских свечей \"Доджи\"","Line chart color and color of \"Doji\" Japanese candlesticks"},
   {"Цвет тела бычьей свечи","Body color of a bull candlestick"},
   {"Цвет тела медвежьей свечи","Body color of a bear candlestick"},
   {"Цвет линии Bid-цены","Bid price level color"},
   {"Цвет линии Ask-цены","Ask price level color"},
   {"Цвет линии цены последней совершенной сделки (Last)","Line color of the last executed deal price (Last)"},
   {"Цвет уровней стоп-ордеров (Stop Loss и Take Profit)","Color of stop order levels (Stop Loss and Take Profit)"},
   {"Отображение на графике торговых уровней (уровни открытых позиций, Stop Loss, Take Profit и отложенных ордеров)","Displaying trade levels in the chart (levels of open positions, Stop Loss, Take Profit and pending orders)"},
   {"Перетаскивание торговых уровней на графике с помощью мышки","Permission to drag trading levels on a chart with a mouse"},
   {"Отображение на графике шкалы времени","Showing the time scale on a chart"},
   {"Отображение на графике ценовой шкалы","Showing the price scale on a chart"},
   {"Отображение на графике панели быстрой торговли","Showing the \"One click trading\" panel on a chart"},
   {"Окно графика развернуто","Chart window is maximized"},
   {"Окно графика свернуто","Chart window is minimized"},
   {"Окно графика закреплено","The chart window is docked"},
   {"Левая координата открепленного графика относительно виртуального экрана","The left coordinate of the undocked chart window relative to the virtual screen"},
   {"Верхняя координата открепленного графика относительно виртуального экрана","The top coordinate of the undocked chart window relative to the virtual screen"},
   {"Правая координата открепленного графика  относительно виртуального экрана","The right coordinate of the undocked chart window relative to the virtual screen"},
   {"Нижняя координата открепленного графика  относительно виртуального экрана","The bottom coordinate of the undocked chart window relative to the virtual screen"},
   
   {"Размер отступа нулевого бара от правого края в процентах","The size of the zero bar indent from the right border in percents"},
   {"Положение фиксированной позиции графика от левого края в процентах","Chart fixed position from the left border in percent value"},
   {"Фиксированный максимум графика","Fixed  chart maximum"},
   {"Фиксированный минимум графика","Fixed  chart minimum "},
   {"Масштаб в пунктах на бар","Scale in points per bar"},
   {"Минимум графика","Chart minimum"},
   {"Максимум графика","Chart maximum"},
   
   {"Текст комментария на графике","Text of a comment in a chart"},
   {"Имя эксперта, запущенного на графике","The name of the Expert Advisor running on the chart"},
   {"Имя скрипта, запущенного на графике","The name of the script running on the chart"},
   
   {"Отображение в виде баров","Display as sequence of bars"},
   {"Отображение в виде японских свечей","Display as Japanese candlesticks"},
   {"Отображение в виде линии, проведенной по ценам Close","Display as a line drawn by Close prices"},
   {"Объемы не показаны","Volumes are not shown"},
   {"Тиковые объемы","Tick volumes"},
   {"Торговые объемы","Trade volumes"},
   
   {"Главное окно графика","Main chart window"},
   {"Подокно графика","Chart subwindow"},
   {"Подокон","Subwindows"},
   {"Индикаторы в главном окне графика","Indicators in the main chart window"},
   {"Индикаторы в окне графика","Indicators in the chart window"},
   {"Индикатор","Indicator"},
   {"Индикаторов","Indicators total"},
   {"Окно","Window"},
   {"Отсутствуют","No indicators"},
   {"Не удалось получить объект-окно графика","Failed to get the chart window object"},
   {"Скриншот создан","Screenshot created"},
   {"Шаблон графика сохранён","Chart template saved"},
   {"Шаблон применён к графику","Template applied to the chart"},
   
   {"Добавлен индикатор","Added indicator"},
   {"Удалён индикатор","Removed indicator"},
   {"Изменён индикатор","Changed indicator"},
   
   {"Добавлено подокно","Added subwindow"},
   {"Удалено подокно","Removed subwindow"},
   
//--- CChartObjCollection
   {"Коллекция чартов","Chart collection"},
   {"Не удалось создать новый объект-чарт","Failed to create new chart object"},
   {"Не удалось добавить объект-чарт в коллекцию","Failed to add chart object to collection"},
   {"Нельзя открыть новый график, так как количество открытых графиков уже максимальное","You cannot open a new chart, since the number of open charts is already maximum"},
   {"Открыт график","Open chart"},
   {"Закрыт график","Closed chart"},
   {"Изменён символ графика","Changed chart symbol"},
   {"Изменён таймфрейм графика","Changed chart timeframe"},
   {"Изменён символ и таймфрейм графика","Changed the symbol and timeframe of the chart"},

//--- CGCnvElement
   {"Ошибка! Пустой массив","Error! Empty array"},
   {"Ошибка! Массив-копия ресурса не совпадает с оригиналом","Error! Array-copy of the resource does not match the original"},

//--- CForm
   {"Отсутствует объект тени. Необходимо сначала его создать при помощи метода CreateShadowObj()","There is no shadow object. You must first create it using the CreateShadowObj () method"},
   {"Не удалось создать новый объект для тени","Failed to create new object for shadow"},
   {"Не удалось создать новый объект-копировщик пикселей","Failed to create new pixel copier object"},
   {"В списке уже есть объект-копировщик пикселей с идентификатором ","There is already a pixel copier object in the list with ID "},
   {"В списке нет объекта-копировщика пикселей с идентификатором ","No pixel copier object with ID "},
   
//--- CFrame
   {"Не удалось создать новый объект-кадр анимации","Failed to create new animation frame object"},
   {"В списке уже есть объект-кадр анимации с идентификатором ","The list already contains an animation frame object with an ID "},
   {"В списке нет объекта-кадра анимации с идентификатором ","No animation frame object with ID "},
   
//--- CShadowObj
   {"Ошибка! Размер изображения очень маленький или очень большое размытие","Error! Image size is very small or very large blur"},
      
//--- CGraphElementsCollection
   {"Ошибка. Уже существует объект управления чартами с идентификатором чарта ","Error. A chart control object already exists with chart id "},
   {"Не удалось создать объект управления чартами с идентификатором чарта ","Failed to create chart control object with chart id "},
   {"Не удалось получить объект управления чартами с идентификатором чарта ","Failed to get chart control object with chart id "},
   {"Такой графический объект уже существует: ","Such a graphic object already exists: "},
   
//--- GStdGraphObj
   {"Не удалось создать объект класса для графического объекта ","Failed to create class object for graphic object"},
   {"Не удалось создать графический объект ","Failed to create graphic object "},
   {"Не удалось найти подокно графика","Could not find chart subwindow"},
   {"Не удалось создать снимок истории изменений графического объекта","Failed to create a snapshot of the change history of a graphic object"},
   {"Создан снимок истории изменений графического объекта","A snapshot of the history of changes to a graphical object has been created"},
   
   {"Стандартный графический объект","Standard graphic object"},
   {"Расширенный стандартный графический объект","Extended standard graphic object"},
   {"Элемент","Element"},
   {"Объект тени","Shadow object"},
   {"Форма","Form"},
   {"Окно","Window"},
   
   {"Графический объект принадлежит программе","The graphic object belongs to the program"},
   {"Графический объект не принадлежит программе","The graphic object does not belong to the program"},
   
   {"Абстрактный графический объект","Abstract graphic object"},
   {"Вертикальная линия","Vertical Line"},
   {"Горизонтальная линия","Horizontal Line"},
   {"Трендовая линия","Trend Line"},
   {"Трендовая линия по углу","Trend Line By Angle"},
   {"Циклические линии","Cycle Lines"},
   {"Линия со стрелкой","Arrowed Line"},
   {"Равноудаленный канал","Equidistant Channel"},
   {"Канал стандартного отклонения","Standard Deviation Channel"},
   {"Канал линейной регрессии","Linear Regression Channel"},
   {"Вилы Эндрюса","Andrews’ Pitchfork"},
   {"Линия Ганна","Gann Line"},
   {"Веер Ганна","Gann Fan"},
   {"Сетка Ганна","Gann Grid"},
   {"Уровни Фибоначчи","Fibonacci Retracement"},
   {"Временные зоны Фибоначчи","Fibonacci Time Zones"},
   {"Веер Фибоначчи","Fibonacci Fan"},
   {"Дуги Фибоначчи","Fibonacci Arcs"},
   {"Канал Фибоначчи","Fibonacci Channel"},
   {"Расширение Фибоначчи","Fibonacci Expansion"},
   {"5-волновка Эллиотта","Elliott Motive Wave"},
   {"3-волновка Эллиотта","Elliott Correction Wave"},
   {"Прямоугольник","Rectangle"},
   {"Треугольник","Triangle"},
   {"Эллипс","Ellipse"},
   {"Знак \"Хорошо\"","Thumbs Up"},
   {"Знак \"Плохо\"","Thumbs Down"},
   {"Знак \"Стрелка вверх\"","Arrow Up"},
   {"Знак \"Стрелка вниз\"","Arrow Down"},
   {"Знак \"Стоп\"","Stop Sign"},
   {"Знак \"Птичка\"","Check Sign"},
   {"Левая ценовая метка","Left Price Label"},
   {"Правая ценовая метка","Right Price Label"},
   {"Знак \"Buy\"","Buy Sign"},
   {"Знак \"Sell\"","Sell Sign"},
   {"Стрелка","Arrow"},
   {"Текст","Text"},
   {"Текстовая метка","Label"},
   {"Кнопка","Button"},
   {"График","Chart"},
   {"Рисунок","Bitmap"},
   {"Графическая метка","Bitmap Label"},
   {"Поле ввода","Edit"},
   {"Событие в экономическом календаре","The \"Event\" object corresponding to an event in the economic calendar"},
   {"Прямоугольная метка","The \"Rectangle label\" object for creating and designing the custom graphical interface"},
   
   {"Идентификатор объекта","Object ID"},
   {"Идентификатор базового объекта","Base object ID"},
   {"Тип объекта","Object type"},
   {"Тип графического элемента","Graphic element type"},
   {"Принадлежность объекта","Object belongs to"},
   {"Идентификатор графика объекта","Object chart ID"},
   {"Номер подокна графика","Chart subwindow number"},
   {"История изменений","Change history"},
   {"Время создания","Time of creation"},
   {"Видимость объекта на таймфреймах","Visibility of an object at timeframes"},
   {"Объект на заднем плане","Object in the background"},
   {"Приоритет графического объекта на получение события нажатия мышки на графике","Priority of a graphical object for receiving events of clicking on a chart"},
   {"Запрет на показ имени графического объекта в списке объектов терминала","Prohibit showing of the name of a graphical object in the terminal objects list"},
   {"Выделенность объекта","Object is selected"},
   {"Доступность объекта","Object availability"},
   {"Номер объекта в списке","Object number in the list"},
   {"Координата времени","Time coordinate"},
   {"Цвет","Color"},
   {"Стиль","Style"},
   {"Толщина линии","Line thickness"},
   {"Заливка объекта цветом","Fill an object with color"},
   {"Возможность редактирования текста","Ability to edit text"},
   {"Количество уровней","Number of levels"},
   {"Цвет линии-уровня","Color of the line-level"},
   {"Стиль линии-уровня","Style of the line-level"},
   {"Толщина линии-уровня","Thickness of the line-level"},
   {"Горизонтальное выравнивание текста","Horizontal text alignment"},
   {"Размер шрифта","Font size"},
   {"Луч продолжается влево","Ray goes to the left"},
   {"Луч продолжается вправо","Ray goes to the right"},
   {"Вертикальная линия продолжается на все окна графика","A vertical line goes through all the windows of a chart"},
   {"Отображение полного эллипса","Showing the full ellipse"},
   {"Код стрелки","Arrow code"},
   {"Положение точки привязки","Location of the anchor point"},
   {"Дистанция в пикселях по оси X от угла привязки","The distance in pixels along the X axis from the binding corner"},
   {"Дистанция в пикселях по оси Y от угла привязки","The distance in pixels along the Y axis from the binding corner"},
   {"Тренд","Trend"},
   {"Уровень","Level"},
   {"Отображение линий","Displaying lines"},
   {"Состояние кнопки","Button state"},
   {"Период графика","Chart timeframe"},
   {"Отображение шкалы времени","Displaying the time scale"},
   {"Отображение ценовой шкалы","Displaying the price scale"},
   {"Масштаб графика","Chart scale"},
   {"Ширина по оси X в пикселях","Width along the X axis in pixels"},
   {"Высота по оси Y в пикселях","Height along the Y axis in pixels"},
   {"X-координата левого верхнего угла прямоугольной области видимости","The X coordinate of the upper left corner of the rectangular visible area"},
   {"Y-координата левого верхнего угла прямоугольной области видимости","The Y coordinate of the upper left corner of the rectangular visible area"},
   {"Цвет фона","Background color"},
   {"Угол графика для привязки","The corner of the chart to link a graphical object"},
   {"Тип рамки","Border type"},
   {"Цвет рамки","Border color"},
   {"Координата цены","Price coordinate"},
   {"Значение уровня","Level value"},
   {"Масштаб","Scale"},
   {"Угол","Angle"},
   {"Отклонение","Deviation"},
   {"Имя","Name"},
   {"Имя базового объекта","Base object name"},
   {"Описание","Description"},
   {"Текст всплывающей подсказки","The text of a tooltip"},
   {"Описание уровня","Level description"},
   {"Шрифт","Font"},
   {"Имя BMP-файла","BMP-file name"},
   {"Символ графика","Chart Symbol"},
   
   {"Вид графического объекта","Graphic object species"},
   {"Линии","Lines"},
   {"Каналы","Channels"},
   {"Ганн","Gann"},
   {"Фибоначчи","Fibonacci"},
   {"Эллиотт","Elliott"},
   {"Фигуры","Shapes"},
   {"Стрелки","Arrows"},
   {"Графические объекты","Graphical"},
   {"Группа объектов","Object group"},
   
   {"(Координата щелчка по графику)","(Chart click coordinate)"},
   {"Точка привязки для стрелки находится сверху","Anchor on the top side"},
   {"Точка привязки для стрелки находится снизу","Anchor on the bottom side"},

   {"Точка привязки в левом верхнем углу","Anchor point at the upper left corner"},
   {"Точка привязки слева по центру","Anchor point to the left in the center"},
   {"Точка привязки в левом нижнем углу","Anchor point at the lower left corner"},
   {"Точка привязки снизу по центру","Anchor point below in the center"},
   {"Точка привязки в правом нижнем углу","Anchor point at the lower right corner"},
   {"Точка привязки справа по центру","Anchor point to the right in the center"},
   {"Точка привязки в правом верхнем углу","Anchor point at the upper right corner"},
   {"Точка привязки сверху по центру","Anchor point above in the center"},
   {"Точка привязки строго по центру объекта","Anchor point strictly in the center of the object"},
   
   {"Координаты цена/время","Price/time coordinates"},
   {"Опорная точка ","Pivot point "},
   {"Значения уровней","Level values"},
   {"Уровень ","Level "},
   {"Состояние \"On\"","State \"On\""},
   {"Состояние \"Off\"","State \"Off\""},
   
//--- CDataPropObj
   {"Переданное свойство находится за пределами диапазона свойств объекта","The passed property is outside the range of the object's properties"},
   {"Не удалось создать объект истории изменений графического объекта","Failed to create a graphical object change history object"},
   {"Не удалось добавить объект истории изменений в список","Failed to add change history object to the list"},
   {"Не удалось получить объект истории изменений","Failed to get change history object"},
   {"Не удалось увеличить размер массива","Failed to increase array size"},
   
//--- CGraphElementsCollection
   {"Не удалось получить список вновь добавленных объектов","Failed to get the list of newly added objects"},
   {"Не удалось изъять графический объект из списка","Failed to detach graphic object from the list"},
   {"Не удалось удалить графический объект из списка","Failed to delete graphic object from the list"},
   {"Не удалось удалить графический объект с графика","Failed to delete graphic object from the chart"},
   {"Не удалось поместить графический объект в список удалённых объектов","Failed to place graphic object in the list of deleted objects"},
   {"Не удалось поместить графический объект в список переименованных объектов","Failed to place graphic object in the list of renamed objects"},
   
   {"Создан индикатор контроля и отправки событий","An indicator for monitoring and sending events has been created"},
   {"Не удалось создать индикатор контроля и отправки событий","Failed to create indicator for monitoring and sending events"},
   {"Индикатор контроля и отправки событий успешно добавлен на график ","The indicator for monitoring and sending events has been successfully added to the chart "},
   {"Не удалось добавить индикатор контроля и отправки событий на график ","Failed to add the indicator of monitoring and sending events to the chart "},
   {"Индикатор контроля и отправки событий уже есть на графике","The indicator for monitoring and sending events is already on the chart"},
   {"Закрыто окон графиков: ","Closed chart windows: "},
   {"С ними удалено объектов: ","Objects removed with them: "},
   {"Не удалось создать объект-событие для графического объекта","Failed to create event object for graphic object"},
   {"Не удалось добавить объект-событие в список","Failed to add event object to list"},
   {"История изменения свойства: ","Property change history: "},
   
   {"Создан новый графический объект","New graphic object created"},
   {"Изменено свойство графического объекта","Changed graphic object property"},
   {"Графический объект переименован","Graphic object renamed"},
   {"Удалён графический объект","Graphic object deleted"},
   {"Графический объект удалён вместе с графиком","The graphic object has been removed along with the chart"},
   
//--- CGStdGraphObj (Extended)
   {"Не удалось создать объект класса расширенного графического объекта","Failed to create the class object of extended standart graphics object"},
   {"Не удалось создать базовый объект расширенного графического объекта","Failed to create the base object of a extended graphics object"},
   {"Не удалось добавить расширенный стандартный графический объект в список","Failed to add extended standard graphic object to the list"},
   {"Не удалось добавить базовый объект в список","Failed to add base object to list"},
   {"Не удалось создать подчинённый объект расширенного графического объекта","Failed to create the dependent object of a extended graphics object"},
   {"Не удалось добавить подчинённый объект в список","Failed to add dependent object to list"},
   {"Не удалось получить расширенный графический объект из списка","Failed to get extended graphic object from list"},
   {"Базовый объект расширенного графического объекта","The base object of the extended graphical object"},
   {"Объект не является расширенным стандартным графическим объектом","The object is not an extended standard graphical object"},
   
//--- CLinkedPivotPoint
   {"Для объекта не установлено ни одной опорной точки по оси X","The object does not have any pivot points set along the x-axis"},
   {"Для объекта не установлено ни одной опорной точки по оси Y","The object does not have any pivot points set along the y-axis"},
   {"Объект не привязан к базовому графическому объекту","The object is not attached to the base graphical object"},
   {"Не удалось создать объект данных опорной точки X и Y.","Failed to create X and Y reference point data object"},
   {"Количество опорных точек базового объекта для расчёта координаты X: ","Number of reference points of the base object to set the X coordinate: "},
   {"Количество опорных точек базового объекта для расчёта координаты Y: ","Number of reference points of the base object to set the Y coordinate: "},
   
//--- CGStdGraphObjExtToolkit
   {"Не удалось изменить размер массива данных времени опорной точки","Failed to resize pivot point time data array"},
   {"Не удалось изменить размер массива данных цены опорной точки","Failed to resize pivot point price data array"},
   {"Не удалось создать объект-форму для контроля опорной точки","Failed to create form object to control pivot point"},
   
  };
//+---------------------------------------------------------------------+
//| Array of messages for trade server return codes (10004 - 10045)     |
//| (1) in user's country language                                      |
//| (2) in the international language                                   |
//+---------------------------------------------------------------------+
string messages_ts_ret_code[][TOTAL_LANG]=
  {
   {"Реквота","Requote"},                                                                                                                          // 10004
   {"Неизвестный код возврата торгового сервера","Unknown trading server return code"},                                                   // 10005
   {"Запрос отклонен","Request rejected"},                                                                                                         // 10006
   {"Запрос отменен трейдером","Request canceled by trader"},                                                                                      // 10007
   {"Ордер размещен","Order placed"},                                                                                                              // 10008
   {"Заявка выполнена","Request completed"},                                                                                                       // 10009
   {"Заявка выполнена частично","Only part of the request completed"},                                                                         // 10010
   {"Ошибка обработки запроса","Request processing error"},                                                                                        // 10011
   {"Запрос отменен по истечению времени","Request canceled by timeout"},                                                                          // 10012
   {"Неправильный запрос","Invalid request"},                                                                                                      // 10013
   {"Неправильный объем в запросе","Invalid volume in request"},                                                                               // 10014
   {"Неправильная цена в запросе","Invalid price in request"},                                                                                 // 10015
   {"Неправильные стопы в запросе","Invalid stops in request"},                                                                                // 10016
   {"Торговля запрещена","Trade disabled"},                                                                                                     // 10017
   {"Рынок закрыт","Market closed"},                                                                                                            // 10018
   {"Нет достаточных денежных средств для выполнения запроса","There is not enough money to complete request"},                                // 10019
   {"Цены изменились","Prices changed"},                                                                                                           // 10020
   {"Отсутствуют котировки для обработки запроса","There are no quotes to process request"},                                                   // 10021
   {"Неверная дата истечения ордера в запросе","Invalid order expiration date in request"},                                                    // 10022
   {"Состояние ордера изменилось","Order state changed"},                                                                                          // 10023
   {"Слишком частые запросы","Too frequent requests"},                                                                                             // 10024
   {"В запросе нет изменений","No changes in request"},                                                                                            // 10025
   {"Автотрейдинг запрещен сервером","Autotrading disabled by server"},                                                                            // 10026
   {"Автотрейдинг запрещен клиентским терминалом","Autotrading disabled by client terminal"},                                                      // 10027
   {"Запрос заблокирован для обработки","Request locked for processing"},                                                                          // 10028
   {"Ордер или позиция заморожены","Order or position frozen"},                                                                                    // 10029
   {"Указан неподдерживаемый тип исполнения ордера по остатку","Invalid order filling type"},                                                      // 10030
   {"Нет соединения с торговым сервером","No connection with trade server"},                                                                   // 10031
   {"Операция разрешена только для реальных счетов","Operation allowed only for live accounts"},                                                // 10032
   {"Достигнут лимит на количество отложенных ордеров","Number of pending orders reached limit"},                                      // 10033
   {"Достигнут лимит на объем ордеров и позиций для данного символа","Volume of orders and positions for symbol reached limit"},   // 10034
   {"Неверный или запрещённый тип ордера","Incorrect or prohibited order type"},                                                                   // 10035
   {"Позиция с указанным идентификатором уже закрыта","Position with specified identifier already closed"},                           // 10036
   {"Неизвестный код возврата торгового сервера","Unknown trading server return code"},                                                   // 10037
   {"Закрываемый объем превышает текущий объем позиции","Close volume exceeds the current position volume"},                                     // 10038
   {"Для указанной позиции уже есть ордер на закрытие","Close order already exists for specified position"},                                   // 10039
   {"Достигнут лимит на количество открытых позиций","Number of positions reached limit"},                                             // 10040
   {
    "Запрос на активацию отложенного ордера отклонен, а сам ордер отменен",                                                                        // 10041
    "Pending order activation request rejected, order canceled"
   },
   {
    "Запрос отклонен, так как на символе установлено правило \"Разрешены только длинные позиции\"",                                                // 10042
    "Request rejected, because \"Only long positions are allowed\" rule set for symbol"
   },
   {
    "Запрос отклонен, так как на символе установлено правило \"Разрешены только короткие позиции\"",                                               // 10043
    "Request rejected, because \"Only short positions are allowed\" rule set for symbol"
   },
   {
    "Запрос отклонен, так как на символе установлено правило \"Разрешено только закрывать существующие позиции\"",                                 // 10044
    "Request rejected because \"Only position closing is allowed\" rule set for symbol"
   },
   {
    "Запрос отклонен, так как для торгового счета установлено правило \"Разрешено закрывать существующие позиции только по правилу FIFO\"",        // 10045
    "Request rejected, because \"Position closing is allowed only by FIFO rule\" flag set for trading account"
   },
   {
    "Запрос отклонен, так как для торгового счета установлено правило \"Запрещено открывать встречные позиции по одному символу\"",                // 10046
    "The request is rejected, because the \"Opposite positions on a single symbol are disabled\" rule is set for the trading account"
   },
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (0, 4001 - 4019)          |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime[][TOTAL_LANG]=
  {
   {"Операция выполнена успешно","Operation completed successfully"},                                                                          // 0
   {"Неожиданная внутренняя ошибка","Unexpected internal error"},                                                                                  // 4001
   {"Ошибочный параметр при внутреннем вызове функции клиентского терминала","Wrong parameter in inner call of client terminal function"}, // 4002
   {"Ошибочный параметр при вызове системной функции","Wrong parameter when calling system function"},                                         // 4003
   {"Недостаточно памяти для выполнения системной функции","Not enough memory to perform system function"},                                    // 4004
   {
    "Структура содержит объекты строк и/или динамических массивов и/или структуры с такими объектами и/или классы",                                // 4005
    "Structure contains objects of strings and/or dynamic arrays and/or structure of such objects and/or classes"
   },                                                                                                                                                    
   {
    "Массив неподходящего типа, неподходящего размера или испорченный объект динамического массива",                                               // 4006
    "Array of wrong type, wrong size, or damaged object of dynamic array"
   },
   {
    "Недостаточно памяти для перераспределения массива либо попытка изменения размера статического массива",                                       // 4007
    "Not enough memory for relocation of array, or attempt to change size of static array"
   },
   {"Недостаточно памяти для перераспределения строки","Not enough memory for relocation of string"},                                          // 4008
   {"Неинициализированная строка","Not initialized string"},                                                                                       // 4009
   {"Неправильное значение даты и/или времени","Invalid date and/or time"},                                                                        // 4010
   {"Общее число элементов в массиве не может превышать 2147483647","Total amount of elements in array cannot exceed 2147483647"},             // 4011
   {"Ошибочный указатель","Wrong pointer"},                                                                                                        // 4012
   {"Ошибочный тип указателя","Wrong type of pointer"},                                                                                            // 4013
   {"Системная функция не разрешена для вызова","Function not allowed for call"},                                                               // 4014
   {"Совпадение имени динамического и статического ресурсов","Names of dynamic and static resource match"},                            // 4015
   {"Ресурс с таким именем в EX5 не найден","Resource with this name not found in EX5"},                                                  // 4016
   {"Неподдерживаемый тип ресурса или размер более 16 MB","Unsupported resource type or its size exceeds 16 Mb"},                                  // 4017
   {"Имя ресурса превышает 63 символа","Resource name exceeds 63 characters"},                                                                 // 4018
   {"При вычислении математической функции произошло переполнение ","Overflow occurred when calculating math function "},                          // 4019
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (4101 - 4116)             |
//| (Charts)                                                         |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_charts[][TOTAL_LANG]=
  {
   {"Ошибочный идентификатор графика","Wrong chart ID"},                                                                                           // 4101
   {"График не отвечает","Chart does not respond"},                                                                                                // 4102
   {"График не найден","Chart not found"},                                                                                                         // 4103
   {"У графика нет эксперта, который мог бы обработать событие","No Expert Advisor in chart that could handle event"},                     // 4104
   {"Ошибка открытия графика","Chart opening error"},                                                                                              // 4105
   {"Ошибка при изменении для графика символа и периода","Failed to change chart symbol and period"},                                              // 4106
   {"Ошибочное значение параметра для функции по работе с графиком","Error value of parameter for function of working with charts"},       // 4107
   {"Ошибка при создании таймера","Failed to create timer"},                                                                                       // 4108
   {"Ошибочный идентификатор свойства графика","Wrong chart property ID"},                                                                         // 4109
   {"Ошибка при создании скриншота","Error creating screenshots"},                                                                                 // 4110
   {"Ошибка навигации по графику","Error navigating through chart"},                                                                               // 4111
   {"Ошибка при применении шаблона","Error applying template"},                                                                                    // 4112
   {"Подокно, содержащее указанный индикатор, не найдено","Subwindow containing indicator not found"},                                     // 4113
   {"Ошибка при добавлении индикатора на график","Error adding indicator to chart"},                                                            // 4114
   {"Ошибка при удалении индикатора с графика","Error deleting indicator from chart"},                                                      // 4115
   {"Индикатор не найден на указанном графике","Indicator not found on specified chart"},                                                      // 4116
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (4201 - 4205)             |
//| (Graphical objects)                                              |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_graph_obj[][TOTAL_LANG]=
  {
   {"Ошибка при работе с графическим объектом","Error working with graphical object"},                                                           // 4201
   {"Графический объект не найден","Graphical object not found"},                                                                              // 4202
   {"Ошибочный идентификатор свойства графического объекта","Wrong ID of graphical object property"},                                            // 4203
   {"Невозможно получить дату, соответствующую значению","Unable to get date corresponding to value"},                                         // 4204
   {"Невозможно получить значение, соответствующее дате","Unable to get value corresponding to date"},                                         // 4205
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (4301 - 4305)             |
//| (MarketInfo)                                                     |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_market[][TOTAL_LANG]=
  {
   {"Неизвестный символ","Unknown symbol"},                                                                                                        // 4301
   {"Символ не выбран в MarketWatch","Symbol not selected in MarketWatch"},                                                                     // 4302
   {"Ошибочный идентификатор свойства символа","Wrong identifier of symbol property"},                                                           // 4303
   {"Время последнего тика неизвестно (тиков не было)","Time of the last tick not known (no ticks)"},                                           // 4304
   {"Ошибка добавления или удаления символа в MarketWatch","Error adding or deleting symbol in MarketWatch"},                                    // 4305
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (4401 - 4407)             |
//| (Access to history)                                              |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_history[][TOTAL_LANG]=
  {
   {"Запрашиваемая история не найдена","Requested history not found"},                                                                             // 4401
   {"Ошибочный идентификатор свойства истории","Wrong ID of history property"},                                                                // 4402
   {"Превышен таймаут при запросе истории","Exceeded history request timeout"},                                                                    // 4403
   {"Количество запрашиваемых баров ограничено настройками терминала","Number of requested bars limited by terminal settings"},                    // 4404
   {"Множество ошибок при загрузке истории","Multiple errors when loading history"},                                                               // 4405
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4406
   {"Принимающий массив слишком мал чтобы вместить все запрошенные данные","Receiving array too small to store all requested data"},            // 4407
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (4501 - 4524)             |
//| (Global Variables)                                               |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_global[][TOTAL_LANG]=
  {
   {"Глобальная переменная клиентского терминала не найдена","Global variable of client terminal not found"},                               // 4501
   {
    "Глобальная переменная клиентского терминала с таким именем уже существует",                                                                   // 4502
    "Global variable of client terminal with the same name already exists"
   },
   {"Не было модификаций глобальных переменных","Global variables not modified"},                                                             // 4503
   {"Не удалось открыть и прочитать файл со значениями глобальных переменных","Cannot read file with global variable values"},                     // 4504
   {"Не удалось записать файл со значениями глобальных переменных","Cannot write file with global variable values"},                               // 4505
   
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4506
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4507
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4508
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4509
   
   {"Не удалось отправить письмо","Email sending failed"},                                                                                         // 4510
   {"Не удалось воспроизвести звук","Sound playing failed"},                                                                                       // 4511
   {"Ошибочный идентификатор свойства программы","Wrong identifier of program property"},                                                      // 4512
   {"Ошибочный идентификатор свойства терминала","Wrong identifier of terminal property"},                                                     // 4513
   {"Не удалось отправить файл по ftp","File sending via ftp failed"},                                                                             // 4514
   {"Не удалось отправить уведомление","Failed to send notification"},                                                                           // 4515
   {
    "Неверный параметр для отправки уведомления – в функцию SendNotification() передали пустую строку или NULL",                                   // 4516
    "Invalid parameter for sending notification – empty string or NULL passed to SendNotification() function"
   },
   {
    "Неверные настройки уведомлений в терминале (не указан ID или не выставлено разрешение)",                                                      // 4517
    "Wrong settings of notifications in terminal (ID not specified or permission not set)"
   },
   {"Слишком частая отправка уведомлений","Too frequent sending of notifications"},                                                                // 4518
   {"Не указан FTP сервер","FTP server not specified"},                                                                                         // 4519
   {"Не указан FTP логин","FTP login not specified"},                                                                                           // 4520
   {"Не найден файл в директории MQL5\\Files для отправки на FTP сервер","File not found in MQL5\\Files directory to send on FTP server"},     // 4521
   {"Ошибка при подключении к FTP серверу","FTP connection failed"},                                                                               // 4522
   {"На FTP сервере не найдена директория для выгрузки файла ","FTP path not found on server"},                                                    // 4523
   {"Подключение к FTP серверу закрыто","FTP connection closed"},                                                                                  // 4524
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (4601 - 4603)             |
//| (Custom indicator buffers and properties)                        |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_custom_indicator[][TOTAL_LANG]=
  {
   {"Недостаточно памяти для распределения индикаторных буферов","Not enough memory for distribution of indicator buffers"},                   // 4601
   {"Ошибочный индекс своего индикаторного буфера","Wrong indicator buffer index"},                                                                // 4602
   {"Ошибочный идентификатор свойства пользовательского индикатора","Wrong ID of custom indicator property"},                                  // 4603
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (4701 - 4758)             |
//| (Account)                                                        |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_account[][TOTAL_LANG]=
  {
   {"Ошибочный идентификатор свойства счета","Wrong account property ID"},                                                                         // 4701
   
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4702
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4703
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4704
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4705
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4706
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4707
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4708
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4709
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4710
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4711
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4712
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4713
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4714
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4715
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4716
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4717
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4718
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4719
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4720
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4721
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4722
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4723
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4724
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4725
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4726
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4727
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4728
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4729
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4730
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4731
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4732
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4733
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4734
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4735
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4736
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4737
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4738
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4739
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4740
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4741
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4742
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4743
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4744
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4745
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4746
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4747
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4748
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4749
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4750
   
   {"Ошибочный идентификатор свойства торговли","Wrong trade property ID"},                                                                        // 4751
   {"Торговля для эксперта запрещена","Trading by Expert Advisors prohibited"},                                                                    // 4752
   {"Позиция не найдена","Position not found"},                                                                                                    // 4753
   {"Ордер не найден","Order not found"},                                                                                                          // 4754
   {"Сделка не найдена","Deal not found"},                                                                                                         // 4755
   {"Не удалось отправить торговый запрос","Trade request sending failed"},                                                                        // 4756
   {"Неизвестный код ошибки","Unknown error code"},                                                                                       // 4757
   {"Не удалось вычислить значение прибыли или маржи","Failed to calculate profit or margin"},                                                     // 4758
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (4801 - 4812)             |
//| (Indicators)                                                     |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_indicator[][TOTAL_LANG]=
  {
   {"Неизвестный символ","Unknown symbol"},                                                                                                        // 4801
   {"Индикатор не может быть создан","Indicator cannot be created"},                                                                               // 4802
   {"Недостаточно памяти для добавления индикатора","Not enough memory to add indicator"},                                                     // 4803
   {"Индикатор не может быть применен к другому индикатору","Indicator cannot be applied to another indicator"},                               // 4804
   {"Ошибка при добавлении индикатора","Error applying indicator to chart"},                                                                    // 4805
   {"Запрошенные данные не найдены","Requested data not found"},                                                                                   // 4806
   {"Ошибочный хэндл индикатора","Wrong indicator handle"},                                                                                        // 4807
   {"Неправильное количество параметров при создании индикатора","Wrong number of parameters when creating indicator"},                         // 4808
   {"Отсутствуют параметры при создании индикатора","No parameters when creating indicator"},                                                   // 4809
   {
    "Первым параметром в массиве должно быть имя пользовательского индикатора",                                                                    // 4810
    "First parameter in array should be name of custom indicator"
   },
   {"Неправильный тип параметра в массиве при создании индикатора","Invalid parameter type in array when creating indicator"},              // 4811
   {"Ошибочный индекс запрашиваемого индикаторного буфера","Wrong index of requested indicator buffer"},                                       // 4812
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (4901 - 4904)             |
//| (Market depth)                                                   |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_books[][TOTAL_LANG]=
  {
   {"Стакан цен не может быть добавлен","Depth Of Market cannot be added"},                                                                       // 4901
   {"Стакан цен не может быть удален","Depth Of Market cannot be removed"},                                                                       // 4902
   {"Данные стакана цен не могут быть получены","Data from Depth Of Market cannot be obtained"},                                              // 4903
   {"Ошибка при подписке на получение новых данных стакана цен","Error in subscribing to receive new data from Depth Of Market"},                  // 4904
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (5001 - 5027)             |
//| (File operations)                                                |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_files[][TOTAL_LANG]=
  {
   {"Не может быть открыто одновременно более 64 файлов","More than 64 files cannot be opened at the same time"},                                  // 5001
   {"Недопустимое имя файла","Invalid file name"},                                                                                                 // 5002
   {"Слишком длинное имя файла","Too long file name"},                                                                                             // 5003
   {"Ошибка открытия файла","File opening error"},                                                                                                 // 5004
   {"Недостаточно памяти для кеша чтения","Not enough memory for cache to read"},                                                                  // 5005
   {"Ошибка удаления файла","File deleting error"},                                                                                                // 5006
   {"Файл с таким хэндлом уже был закрыт, либо не открывался вообще","File with this handle was closed or was not opening at all"},             // 5007
   {"Ошибочный хэндл файла","Wrong file handle"},                                                                                                  // 5008
   {"Файл должен быть открыт для записи","File must be opened for writing"},                                                                   // 5009
   {"Файл должен быть открыт для чтения","File must be opened for reading"},                                                                   // 5010
   {"Файл должен быть открыт как бинарный","File must be opened as binary one"},                                                             // 5011
   {"Файл должен быть открыт как текстовый","File must be opened as text"},                                                                  // 5012
   {"Файл должен быть открыт как текстовый или CSV","File must be opened as text or CSV"},                                                   // 5013
   {"Файл должен быть открыт как CSV","File must be opened as CSV"},                                                                           // 5014
   {"Ошибка чтения файла","File reading error"},                                                                                                   // 5015
   {"Должен быть указан размер строки, так как файл открыт как бинарный","String size must be specified, because the file opened as binary"},   // 5016
   {
    "Для строковых массивов должен быть текстовый файл, для остальных – бинарный",                                                                 // 5017
    "Text file must be for string arrays, for other arrays - binary"
   },
   {"Это не файл, а директория","This is not file, this is directory"},                                                                        // 5018
   {"Файл не существует","File does not exist"},                                                                                                   // 5019
   {"Файл не может быть переписан","File cannot be rewritten"},                                                                                   // 5020
   {"Ошибочное имя директории","Wrong directory name"},                                                                                            // 5021
   {"Директория не существует","Directory does not exist"},                                                                                        // 5022
   {"Это файл, а не директория","This is file, not directory"},                                                                                // 5023
   {"Директория не может быть удалена","Directory cannot be removed"},                                                                         // 5024
   {
    "Не удалось очистить директорию (возможно, один или несколько файлов заблокированы)",                                                          // 5025
    "Failed to clear directory (probably one or more files blocked)"
   },
   {"Не удалось записать ресурс в файл","Failed to write resource to file"},                                                                   // 5026
   {
    "Не удалось прочитать следующую порцию данных из CSV-файла, так как достигнут конец файла",                                                    // 5027
    "Unable to read next piece of data from CSV file, since end of file reached"
   },
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (5030 - 5044)             |
//| (String conversion)                                              |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_string[][TOTAL_LANG]=
  {
   {"В строке нет даты","No date in string"},                                                                                                  // 5030
   {"В строке ошибочная дата","Wrong date in string"},                                                                                         // 5031
   {"В строке ошибочное время","Wrong time in string"},                                                                                        // 5032
   {"Ошибка преобразования строки в дату","Error converting string to date"},                                                                      // 5033
   {"Недостаточно памяти для строки","Not enough memory for string"},                                                                          // 5034
   {"Длина строки меньше, чем ожидалось","String length less than expected"},                                                               // 5035
   {"Слишком большое число, больше, чем ULONG_MAX","Too large number, more than ULONG_MAX"},                                                       // 5036
   {"Ошибочная форматная строка","Invalid format string"},                                                                                         // 5037
   {"Форматных спецификаторов больше, чем параметров","Amount of format specifiers more than parameters"},                                     // 5038
   {"Параметров больше, чем форматных спецификаторов","Amount of parameters more than format specifiers"},                                     // 5039
   {"Испорченный параметр типа string","Damaged parameter of string type"},                                                                        // 5040
   {"Позиция за пределами строки","Position outside string"},                                                                                  // 5041
   {"К концу строки добавлен 0, бесполезная операция","0 added to string end, useless operation"},                                           // 5042
   {"Неизвестный тип данных при конвертации в строку","Unknown data type when converting to string"},                                            // 5043
   {"Испорченный объект строки","Damaged string object"},                                                                                          // 5044
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (5050 - 5063)             |
//| (Working with arrays)                                            |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_array[][TOTAL_LANG]=
  {
   {"Копирование несовместимых массивов","Copying incompatible arrays"},                                                                           // 5050
   {
    "Приемный массив объявлен как AS_SERIES, и он недостаточного размера",                                                                         // 5051
    "Receiving array declared as AS_SERIES, and it is of insufficient size"
   },
   {"Слишком маленький массив, стартовая позиция за пределами массива","Too small array, starting position outside the array"},             // 5052
   {"Массив нулевой длины","Array of zero length"},                                                                                             // 5053
   {"Должен быть числовой массив","Must be numeric array"},                                                                                      // 5054
   {"Должен быть одномерный массив","Must be one-dimensional array"},                                                                            // 5055
   {"Таймсерия не может быть использована","Timeseries cannot be used"},                                                                           // 5056
   {"Должен быть массив типа double","Must be array of double type"},                                                                           // 5057
   {"Должен быть массив типа float","Must be array of float type"},                                                                             // 5058
   {"Должен быть массив типа long","Must be array of long type"},                                                                               // 5059
   {"Должен быть массив типа int","Must be array of int type"},                                                                                 // 5060
   {"Должен быть массив типа short","Must be array of short type"},                                                                             // 5061
   {"Должен быть массив типа char","Must be array of char type"},                                                                               // 5062
   {"Должен быть массив типа string","String array only"},                                                                                         // 5063
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (5100 - 5114)             |
//| (Working with OpenCL)                                            |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_opencl[][TOTAL_LANG]=
  {
   {"Функции OpenCL на данном компьютере не поддерживаются","OpenCL functions not supported on this computer"},                                // 5100
   {"Внутренняя ошибка при выполнении OpenCL","Internal error occurred when running OpenCL"},                                                      // 5101
   {"Неправильный хэндл OpenCL","Invalid OpenCL handle"},                                                                                          // 5102
   {"Ошибка при создании контекста OpenCL","Error creating OpenCL context"},                                                                   // 5103
   {"Ошибка создания очереди выполнения в OpenCL","Failed to create run queue in OpenCL"},                                                       // 5104
   {"Ошибка при компиляции программы OpenCL","Error occurred when compiling OpenCL program"},                                                   // 5105
   {"Слишком длинное имя точки входа (кернел OpenCL)","Too long kernel name (OpenCL kernel)"},                                                     // 5106
   {"Ошибка создания кернел - точки входа OpenCL","Error creating OpenCL kernel"},                                                              // 5107
   {
    "Ошибка при установке параметров для кернел OpenCL (точки входа в программу OpenCL)",                                                          // 5108
    "Error occurred when setting parameters for OpenCL kernel"
   },
   {"Ошибка выполнения программы OpenCL","OpenCL program runtime error"},                                                                          // 5109
   {"Неверный размер буфера OpenCL","Invalid size of OpenCL buffer"},                                                                          // 5110
   {"Неверное смещение в буфере OpenCL","Invalid offset in OpenCL buffer"},                                                                    // 5111
   {"Ошибка создания буфера OpenCL","Failed to create OpenCL buffer"},                                                                          // 5112
   {"Превышено максимальное число OpenCL объектов","Too many OpenCL objects"},                                                                     // 5113
   {"Ошибка выбора OpenCL устройства","OpenCL device selection error"},                                                                             // 5114
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages  (5120 - 5130)            |
//| (Working with databases)                                         |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_database[][TOTAL_LANG]=
  {
   {"Внутренняя ошибка базы данных","Internal database error"},                                                                                    // 5120
   {"Невалидный хендл базы данных","Invalid database handle"},                                                                                     // 5121
   {"Превышено максимально допустимое количество объектов Database","Exceeded the maximum acceptable number of Database objects"},                 // 5122
   {"Ошибка подключения к базе данных","Database connection error"},                                                                               // 5123
   {"Ошибка выполнения запроса","Request execution error"},                                                                                        // 5124
   {"Ошибка создания запроса","Request generation error"},                                                                                         // 5125
   {"Данных для чтения больше нет","No more data to read"},                                                                                        // 5126
   {"Ошибка перехода к следующей записи запроса","Failed to move to the next request entry"},                                                      // 5127
   {"Данные для чтения результатов запроса еще не готовы","Data for reading request results are not ready yet"},                                   // 5128
   {"Ошибка автоподстановки параметров в SQL-запрос","Failed to auto substitute parameters to an SQL request"},                                    // 5129
   {"Запрос базы данных не только для чтения","Database query not read only"},                                                                     // 5130
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (5200 - 5203)             |
//| (Working with WebRequest())                                      |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_webrequest[][TOTAL_LANG]=
  {
   {"URL не прошел проверку","Invalid URL"},                                                                                                       // 5200
   {"Не удалось подключиться к указанному URL","Failed to connect to specified URL"},                                                              // 5201
   {"Превышен таймаут получения данных","Timeout exceeded"},                                                                                       // 5202
   {"Ошибка в результате выполнения HTTP запроса","HTTP request failed"},                                                                          // 5203
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (5270 - 5275)             |
//| (Working with network (sockets))                                 |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_netsocket[][TOTAL_LANG]=
  {
   {"В функцию передан неверный хэндл сокета","Invalid socket handle passed to function"},                                                         // 5270
   {"Открыто слишком много сокетов (максимум 128)","Too many open sockets (max 128)"},                                                             // 5271
   {"Ошибка соединения с удаленным хостом","Failed to connect to remote host"},                                                                    // 5272
   {"Ошибка отправки/получения данных из сокета","Failed to send/receive data from socket"},                                                       // 5273
   {"Ошибка установления защищенного соединения (TLS Handshake)","Failed to establish secure connection (TLS Handshake)"},                         // 5274
   {"Отсутствуют данные о сертификате, которым защищено подключение","No data on certificate protecting connection"},                          // 5275
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (5300 - 5310)             |
//| (Custom symbols)                                                 |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_custom_symbol[][TOTAL_LANG]=
  {
   {"Должен быть указан пользовательский символ","Custom symbol must be specified"},                                                             // 5300
   {"Некорректное имя пользовательского символа","Name of custom symbol invalid"},                                                      // 5301
   {"Слишком длинное имя для пользовательского символа","Name of custom symbol too long"},                                              // 5302
   {"Слишком длинный путь для пользовательского символа","Path of custom symbol too long"},                                             // 5303
   {"Пользовательский символ с таким именем уже существует","Custom symbol with the same name already exists"},                                  // 5304
   {
    "Ошибка при создании, удалении или изменении пользовательского символа",                                                                       // 5305
    "Error occurred while creating, deleting or changing custom symbol"
   },
   {"Попытка удалить пользовательский символ, выбранный в обзоре рынка","You are trying to delete custom symbol selected in Market Watch"},      // 5306
   {"Неправильное свойство пользовательского символа","Invalid custom symbol property"},                                                        // 5307
   {"Ошибочный параметр при установке свойства пользовательского символа","Wrong parameter while setting property of custom symbol"},      // 5308
   {
    "Слишком длинный строковый параметр при установке свойства пользовательского символа",                                                         // 5309
    "Too long string parameter while setting property of custom symbol"
   },
   {"Не упорядоченный по времени массив тиков","Ticks in array not arranged in order of time"},                                        // 5310
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages (5400 - 5402)             |
//| (Economic calendar)                                              |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_calendar[][TOTAL_LANG]=
  {
   {"Размер массива недостаточен для получения описаний всех значений","Array size insufficient for receiving descriptions of all values"},     // 5400
   {"Превышен лимит запроса по времени","Request time limit exceeded"},                                                                            // 5401
   {"Страна не найдена","Country not found"},                                                                                                   // 5402
  };
//+------------------------------------------------------------------+
//| Array of execution time error messages  (5601 - 5626)            |
//| (Working with databases)                                         |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_sqlite[][TOTAL_LANG]=
  {
   {"Общая ошибка","Generic error"},                                                                                                               // 5601
   {"Внутренняя логическая ошибка в SQLite","SQLite internal logic error"},                                                                        // 5602
   {"Отказано в доступе","Access denied"},                                                                                                         // 5603
   {"Процедура обратного вызова запросила прерывание","Callback routine requested abort"},                                                         // 5604
   {"Файл базы данных заблокирован","Database file locked"},                                                                                       // 5605
   {"Таблица в базе данных заблокирована ","Database table locked"},                                                                               // 5606
   {"Сбой malloc()","Insufficient memory for completing operation"},                                                                               // 5607
   {"Попытка записи в базу данных, доступной только для чтения ","Attempt to write to readonly database"},                                         // 5608
   {"Операция прекращена с помощью sqlite3_interrupt() ","Operation terminated by sqlite3_interrupt()"},                                           // 5609
   {"Ошибка дискового ввода-вывода","Disk I/O error"},                                                                                             // 5610
   {"Образ диска базы данных испорчен","Database disk image corrupted"},                                                                           // 5611
   {"Неизвестный код операции в sqlite3_file_control()","Unknown operation code in sqlite3_file_control()"},                                       // 5612
   {"Ошибка вставки, так как база данных заполнена ","Insertion failed because database is full"},                                                 // 5613
   {"Невозможно открыть файл базы данных","Unable to open the database file"},                                                                     // 5614
   {"Ошибка протокола блокировки базы данных ","Database lock protocol error"},                                                                    // 5615
   {"Только для внутреннего использования","Internal use only"},                                                                                   // 5616
   {"Схема базы данных изменена","Database schema changed"},                                                                                       // 5617
   {"Строка или BLOB превышает ограничение по размеру","String or BLOB exceeds size limit"},                                                       // 5618
   {"Прервано из-за нарушения ограничения","Abort due to constraint violation"},                                                                   // 5619
   {"Несоответствие типов данных","Data type mismatch"},                                                                                           // 5620
   {"Ошибка неправильного использования библиотеки","Library used incorrectly"},                                                                   // 5621
   {"Использование функций операционной системы, не поддерживаемых на хосте","Uses OS features not supported on host"},                            // 5622
   {"Отказано в авторизации","Authorization denied"},                                                                                              // 5623
   {"Не используется ","Not used "},                                                                                                               // 5624
   {"2-й параметр для sqlite3_bind находится вне диапазона","Bind parameter error, incorrect index"},                                              // 5625
   {"Открытый файл не является файлом базы данных","File opened that is not database file"},                                                       // 5626
  };
//+------------------------------------------------------------------+
#ifdef __MQL4__
//+------------------------------------------------------------------+
//| Array of messages for MQL4 trade server return codes (0 - 150)   |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_ts_ret_code_mql4[][TOTAL_LANG]=
  {
   {"Нет ошибки","No error returned"},                                                             // 0
   {"Нет ошибки, но результат неизвестен","No error returned, but result unknown"},         // 1
   {"Общая ошибка","Common error"},                                                                // 2
   {"Неправильные параметры","Invalid trade parameters"},                                          // 3
   {"Торговый сервер занят","Trade server busy"},                                               // 4
   {"Старая версия клиентского терминала","Old version of client terminal"},                   // 5
   {"Нет связи с торговым сервером","No connection with trade server"},                            // 6
   {"Недостаточно прав","Not enough rights"},                                                      // 7
   {"Слишком частые запросы","Too frequent requests"},                                             // 8
   {"Недопустимая операция, нарушающая функционирование сервера","Malfunctional trade operation"}, // 9
   
   {"Счет заблокирован","Account disabled"},                                                       // 64
   {"Неправильный номер счета","Invalid account"},                                                 // 65
   
   {"Истек срок ожидания совершения сделки","Trade timeout"},                                      // 128
   {"Неправильная цена","Invalid price"},                                                          // 129
   {"Неправильные стопы","Invalid stops"},                                                         // 130
   {"Неправильный объем","Invalid trade volume"},                                                  // 131
   {"Рынок закрыт","Market closed"},                                                            // 132
   {"Торговля запрещена","Trade disabled"},                                                     // 133
   {"Недостаточно денег для совершения операции","Not enough money"},                              // 134
   {"Цена изменилась","Price changed"},                                                            // 135
   {"Нет цен","Off quotes"},                                                                       // 136
   {"Брокер занят","Broker busy"},                                                              // 137
   {"Новые цены","Requote"},                                                                       // 138
   {"Ордер заблокирован и уже обрабатывается","Order locked"},                                  // 139
   {"Разрешена только покупка","Buy orders only allowed"},                                         // 140
   {"Слишком много запросов","Too many requests"},                                                 // 141
   {"Неизвестный код возврата торгового сервера","Unknown trading server return code"},     // 142
   {"Неизвестный код возврата торгового сервера","Unknown trading server return code"},     // 143
   {"Неизвестный код возврата торгового сервера","Unknown trading server return code"},     // 144
   {
    "Модификация запрещена, так как ордер слишком близок к рынку",                                 // 145
    "Modification denied because order too close to market"
   }, 
   {"Подсистема торговли занята","Trade context busy"},     // 146
   {"Использование даты истечения ордера запрещено брокером","Expirations denied by broker"},  // 147
   {
    "Количество открытых и отложенных ордеров достигло предела, установленного брокером",          // 148
    "Amount of open and pending orders reached limit set by broker"
   },
   {
    "Попытка открыть противоположный ордер в случае, если хеджирование запрещено",                 // 149
    "Attempt to open order opposite to existing one when hedging disabled"
   },
   {
    "Попытка закрыть позицию по инструменту в противоречии с правилом FIFO",                       // 150
    "Attempt to close order contravening FIFO rule"
   },
  };
//+------------------------------------------------------------------+
//| Array of MQL4 execution time error messages (4000 - 4030)        |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_4000_4030[][TOTAL_LANG]=
  {
   {"Нет ошибки","No error returned"},                                                             // 4000
   {"Неправильный указатель функции","Wrong function pointer"},                                    // 4001
   {"Индекс массива - вне диапазона","Array index out of range"},                               // 4002
   {"Нет памяти для стека функций","No memory for function call stack"},                           // 4003
   {"Переполнение стека после рекурсивного вызова","Recursive stack overflow"},                    // 4004
   {"На стеке нет памяти для передачи параметров","Not enough stack for parameter"},               // 4005
   {"Нет памяти для строкового параметра","No memory for parameter string"},                       // 4006
   {"Нет памяти для временной строки","No memory for temp string"},                                // 4007
   {"Неинициализированная строка","Not initialized string"},                                       // 4008
   {"Неинициализированная строка в массиве","Not initialized string in array"},                    // 4009
   {"Нет памяти для строкового массива","No memory for array string"},                             // 4010
   {"Слишком длинная строка","Too long string"},                                                   // 4011
   {"Остаток от деления на ноль","Remainder from zero divide"},                                    // 4012
   {"Деление на ноль","Zero divide"},                                                              // 4013
   {"Неизвестная команда","Unknown command"},                                                      // 4014
   {"Неправильный переход","Wrong jump (never generated error)"},                                  // 4015
   {"Неинициализированный массив","Not initialized array"},                                        // 4016
   {"Вызовы DLL не разрешены","DLL calls not allowed"},                                        // 4017
   {"Невозможно загрузить библиотеку","Cannot load library"},                                      // 4018
   {"Невозможно вызвать функцию","Cannot call function"},                                          // 4019
   {"Вызовы внешних библиотечных функций не разрешены","Expert function calls not allowed"},   // 4020
   {
    "Недостаточно памяти для строки, возвращаемой из функции",                                     // 4021
    "Not enough memory for temp string returned from function"
   },
   {"Система занята","System busy (never generated error)"},                                    // 4022
   {"Критическая ошибка вызова DLL-функции","DLL function call critical error"},                   // 4023
   {"Внутренняя ошибка","Internal error"},                                                         // 4024
   {"Нет памяти","Out of memory"},                                                                 // 4025
   {"Неверный указатель","Invalid pointer"},                                                       // 4026
   {
    "Слишком много параметров форматирования строки",                                              // 4027
    "Too many formatters in format function"
   },
   {
    "Число параметров превышает число параметров форматирования строки",                           // 4028
    "Parameters count exceeds formatters count"
   },
   {"Неверный массив","Invalid array"},                                                            // 4029
   {"График не отвечает","No reply from chart"},                                                   // 4030
  };
//+------------------------------------------------------------------+
//| Array of MQL4 execution time error messages (4050 - 4075)        |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_4050_4075[][TOTAL_LANG]=
  {
   {"Неправильное количество параметров функции","Invalid function parameters count"},             // 4050
   {"Недопустимое значение параметра функции","Invalid function parameter value"},                 // 4051
   {"Внутренняя ошибка строковой функции","String function internal error"},                       // 4052
   {"Ошибка массива","Some array error"},                                                          // 4053
   {"Неправильное использование массива-таймсерии","Incorrect series array using"},                // 4054
   {"Ошибка пользовательского индикатора","Custom indicator error"},                               // 4055
   {"Массивы несовместимы","Arrays incompatible"},                                             // 4056
   {"Ошибка обработки глобальных переменных","Global variables processing error"},                 // 4057
   {"Глобальная переменная не обнаружена","Global variable not found"},                            // 4058
   {"Функция не разрешена в тестовом режиме","Function not allowed in testing mode"},           // 4059
   {"Функция не разрешена","Function not allowed for call"},                                    // 4060
   {"Ошибка отправки почты","Send mail error"},                                                    // 4061
   {"Ожидается параметр типа string","String parameter expected"},                                 // 4062
   {"Ожидается параметр типа integer","Integer parameter expected"},                               // 4063
   {"Ожидается параметр типа double","Double parameter expected"},                                 // 4064
   {"В качестве параметра ожидается массив","Array as parameter expected"},                        // 4065
   {
    "Запрошенные исторические данные в состоянии обновления",                                      // 4066
    "Requested history data in updating state"
   },
   {"Ошибка при выполнении торговой операции","Internal trade error"},                             // 4067
   {"Ресурс не найден","Resource not found"},                                                      // 4068
   {"Ресурс не поддерживается","Resource not supported"},                                          // 4069
   {"Дубликат ресурса","Duplicate resource"},                                                      // 4070
   {"Ошибка инициализации пользовательского индикатора","Custom indicator cannot initialize"},     // 4071
   {"Ошибка загрузки пользовательского индикатора","Cannot load custom indicator"},                // 4072
   {"Нет исторических данных","No history data"},                                                  // 4073
   {"Не хватает памяти для исторических данных","No memory for history data"},                     // 4074
   {"Не хватает памяти для расчёта индикатора","Not enough memory for indicator calculation"},     // 4075
  };
//+------------------------------------------------------------------+
//| Array of MQL4 execution time error messages (4099 - 4112)        |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_4099_4112[][TOTAL_LANG]=
  {
   {"Конец файла","End of file"},                                                                  // 4099
   {"Ошибка при работе с файлом","Some file error"},                                               // 4100
   {"Неправильное имя файла","Wrong file name"},                                                   // 4101
   {"Слишком много открытых файлов","Too many opened files"},                                      // 4102
   {"Невозможно открыть файл","Cannot open file"},                                                 // 4103
   {"Несовместимый режим доступа к файлу","Incompatible access to file"},                        // 4104
   {"Ни один ордер не выбран","No order selected"},                                                // 4105
   {"Неизвестный символ","Unknown symbol"},                                                        // 4106
   {"Неправильный параметр цены для торговой функции","Invalid price"},                            // 4107
   {"Неверный номер тикета","Invalid ticket"},                                                     // 4108
   {
    "Торговля не разрешена. Необходимо включить опцию \"Разрешить советнику торговать\" в свойствах эксперта", // 4109
    "Trading not allowed. Enable \"Allow live trading\" checkbox in Expert Advisor properties"
   },
   {
    "Ордера на покупку не разрешены. Необходимо проверить свойства эксперта",                      // 4110
    "Longs not allowed. Check Expert Advisor properties"
   },
   {
    "Ордера на продажу не разрешены. Необходимо проверить свойства эксперта",                      // 4111
    "Shorts not allowed. Check Expert Advisor properties"
   },
   {
    "Автоматическая торговля с помощью экспертов/скриптов запрещена на стороне сервера",           // 4112
    "Automated trading by Expert Advisors/Scripts disabled by trade server"
   },
  };
//+------------------------------------------------------------------+
//| Array of MQL4 execution time error messages (4200 - 4220)        |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_4200_4220[][TOTAL_LANG]=
  {
   {"Объект уже существует","Object already exists"},                                              // 4200
   {"Запрошено неизвестное свойство объекта","Unknown object property"},                           // 4201
   {"Объект не существует","Object does not exist"},                                               // 4202
   {"Неизвестный тип объекта","Unknown object type"},                                              // 4203
   {"Нет имени объекта","No object name"},                                                         // 4204
   {"Ошибка координат объекта","Object coordinates error"},                                        // 4205
   {"Не найдено указанное подокно","No specified subwindow"},                                      // 4206
   {"Ошибка при работе с объектом","Graphical object error"},                                      // 4207
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4208
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4209
   {"Неизвестное свойство графика","Unknown chart property"},                                      // 4210
   {"График не найден","Chart not found"},                                                         // 4211
   {"Не найдено подокно графика","Chart subwindow not found"},                                     // 4212
   {"Индикатор не найден","Chart indicator not found"},                                            // 4213
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4214
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4215
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4216
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4217
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4218
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4219
   {"Ошибка выбора инструмента","Symbol select error"},                                            // 4220
  };
//+------------------------------------------------------------------+
//| Array of MQL4 execution time error messages (4250 - 4266)        |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_4250_4266[][TOTAL_LANG]=
  {
   {"Ошибка отправки push-уведомления","Notification error"},                                      // 4250
   {"Ошибка параметров push-уведомления","Notification parameter error"},                          // 4251
   {"Уведомления запрещены","Notifications disabled"},                                             // 4252
   {"Слишком частые запросы отсылки push-уведомлений","Notification send too frequent"},           // 4253
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4254
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4255
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4256
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4257
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4258
   {"Неизвестный код ошибки","Unknown error code"},                                       // 4259
   {"Не указан FTP сервер","FTP server not specified"},                                         // 4260
   {"Не указан FTP логин","FTP login not specified"},                                           // 4261
   {"Ошибка при подключении к FTP серверу","FTP connection failed"},                               // 4262
   {"Подключение к FTP серверу закрыто","FTP connection closed"},                                  // 4263
   {"На FTP сервере не найдена директория для выгрузки файла ","FTP path not found on server"},    // 4264
   {
    "Не найден файл в директории MQL4\\Files для отправки на FTP сервер",                          // 4265
    "File not found in MQL4\\Files directory to send to FTP server"
   }, 
   {"Ошибка при передаче файла на FTP сервер","Common error during FTP data transmission"},        // 4266
  };
//+------------------------------------------------------------------+
//| Array of MQL4 execution time error messages (5001 - 5029)        |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_5001_5029[][TOTAL_LANG]=
  {
   {"Слишком много открытых файлов","Too many opened files"},                                      // 5001
   {"Неверное имя файла","Wrong file name"},                                                       // 5002
   {"Слишком длинное имя файла","Too long file name"},                                             // 5003
   {"Ошибка открытия файла","Cannot open file"},                                                   // 5004
   {"Ошибка размещения буфера текстового файла","Text file buffer allocation error"},              // 5005
   {"Ошибка удаления файла","Cannot delete file"},                                                 // 5006
   {
    "Неверный хендл файла (файл закрыт или не был открыт)",                                        // 5007
    "Invalid file handle (file closed or not opened)"
   },
   {
    "Неверный хендл файла (индекс хендла отсутствует в таблице)",                                  // 5008
    "Wrong file handle (handle index out of handle table)"
   },
   {"Файл должен быть открыт с флагом FILE_WRITE","File must be opened with FILE_WRITE flag"},     // 5009
   {"Файл должен быть открыт с флагом FILE_READ","File must be opened with FILE_READ flag"},       // 5010
   {"Файл должен быть открыт с флагом FILE_BIN","File must be opened with FILE_BIN flag"},         // 5011
   {"Файл должен быть открыт с флагом FILE_TXT","File must be opened with FILE_TXT flag"},         // 5012
   {
    "Файл должен быть открыт с флагом FILE_TXT или FILE_CSV",                                      // 5013
    "File must be opened with FILE_TXT or FILE_CSV flag"
   },
   {"Файл должен быть открыт с флагом FILE_CSV","File must be opened with FILE_CSV flag"},         // 5014
   {"Ошибка чтения файла","File read error"},                                                      // 5015
   {"Ошибка записи файла","File write error"},                                                     // 5016
   {
    "Размер строки должен быть указан для двоичных файлов",                                        // 5017
    "String size must be specified for binary file"
   },
   {
    "Неверный тип файла (для строковых массивов-TXT, для всех других-BIN)",                        // 5018
    "Incompatible file (for string arrays-TXT, for others-BIN)"
   },
   {"Файл является директорией","File is directory not file"},                                     // 5019
   {"Файл не существует","File does not exist"},                                                   // 5020
   {"Файл не может быть перезаписан","File cannot be rewritten"},                                  // 5021
   {"Неверное имя директории","Wrong directory name"},                                             // 5022
   {"Директория не существует","Directory does not exist"},                                        // 5023
   {"Указанный файл не является директорией","Specified file is not directory"},                   // 5024
   {"Ошибка удаления директории","Cannot delete directory"},                                       // 5025
   {"Ошибка очистки директории","Cannot clean directory"},                                         // 5026
   {"Ошибка изменения размера массива","Array resize error"},                                      // 5027
   {"Ошибка изменения размера строки","String resize error"},                                      // 5028
   {
    "Структура содержит строки или динамические массивы",                                          // 5029
    "Structure contains strings or dynamic arrays"
   },
  };
//+------------------------------------------------------------------+
//| Array of MQL4 execution time error messages (5200 - 5203)        |
//| (1) in user's country language                                   |
//| (2) in the international language                                |
//+------------------------------------------------------------------+
string messages_runtime_5200_5203[][TOTAL_LANG]=
  {
   {"URL не прошел проверку","Invalid URL"},                                                       // 5200
   {"Не удалось подключиться к указанному URL","Failed to connect to specified URL"},              // 5201
   {"Превышен таймаут получения данных","Timeout exceeded"},                                       // 5202
   {"Ошибка в результате выполнения HTTP запроса","HTTP request failed"},                          // 5203
  };
#endif 
//+------------------------------------------------------------------+
