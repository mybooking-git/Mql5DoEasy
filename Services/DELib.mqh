//+------------------------------------------------------------------+
//|                                                        DELib.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property strict  // Necessary for mql4
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "..\Defines.mqh"
#include "Message.mqh"
#include "TimerCounter.mqh"
#include "Pause.mqh"
#include "Colors.mqh"
#include "XDimArray.mqh"
//+------------------------------------------------------------------+
//| Service functions                                                |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Display all sorting enumeration constants in the journal         |
//+------------------------------------------------------------------+
void EnumNumbersTest()
  {
   string enm="ENUM_SORT_SYMBOLS_MODE";
   string t=StringSubstr(enm,5,5)+"";//"BY";
   Print("Search of the values of the enumaration ",enm,":");
   ENUM_SORT_SYMBOLS_MODE type=0;
   while(StringFind(EnumToString(type),t)==0)
     {
      Print(enm,"[",type,"]=",EnumToString(type));
      if(type>500) break;
      type++;
     }
   Print("\nNumber of members of the ",enm,"=",type);
  }
//+------------------------------------------------------------------+
//| Return the text in one of two languages                          |
//+------------------------------------------------------------------+
string TextByLanguage(const string text_country_lang,const string text_en)
  {
   return(TerminalInfoString(TERMINAL_LANGUAGE)==COUNTRY_LANG ? text_country_lang : text_en);
  }
//+------------------------------------------------------------------+
//| Return time with milliseconds                                    |
//+------------------------------------------------------------------+
string TimeMSCtoString(const long time_msc,int flags=TIME_DATE|TIME_MINUTES|TIME_SECONDS)
  {
   return TimeToString(time_msc/1000,flags)+"."+IntegerToString(time_msc%1000,3,'0');
  }
//+------------------------------------------------------------------+
//| Returns the number of decimal places in a symbol lot             |
//+------------------------------------------------------------------+
uint DigitsLots(const string symbol_name) 
  { 
   return (int)ceil(fabs(log10(SymbolInfoDouble(symbol_name,SYMBOL_VOLUME_STEP))));
  }
//+------------------------------------------------------------------+
//| Return the minimum symbol lot                                    |
//+------------------------------------------------------------------+
double MinimumLots(const string symbol_name) 
  { 
   return SymbolInfoDouble(symbol_name,SYMBOL_VOLUME_MIN);
  }
//+------------------------------------------------------------------+
//| Return the maximum symbol lot                                    |
//+------------------------------------------------------------------+
double MaximumLots(const string symbol_name) 
  { 
   return SymbolInfoDouble(symbol_name,SYMBOL_VOLUME_MAX);
  }
//+------------------------------------------------------------------+
//| Return the symbol lot change step                                |
//+------------------------------------------------------------------+
double StepLots(const string symbol_name) 
  { 
   return SymbolInfoDouble(symbol_name,SYMBOL_VOLUME_STEP);
  }
//+------------------------------------------------------------------+
//| Return the normalized lot                                        |
//+------------------------------------------------------------------+
double NormalizeLot(const string symbol_name, double order_lots) 
  {
   double ml=SymbolInfoDouble(symbol_name,SYMBOL_VOLUME_MIN);
   double mx=SymbolInfoDouble(symbol_name,SYMBOL_VOLUME_MAX);
   double ln=NormalizeDouble(order_lots,DigitsLots(symbol_name));
   return(ln<ml ? ml : ln>mx ? mx : ln);
  }
//+------------------------------------------------------------------+
//| Prepare the symbol array for a symbol collection                 |
//+------------------------------------------------------------------+
bool CreateUsedSymbolsArray(const ENUM_SYMBOLS_MODE mode_used_symbols,string defined_used_symbols,string &used_symbols_array[])
  {
//--- When working with the current symbol
   if(mode_used_symbols==SYMBOLS_MODE_CURRENT)
     {
      //--- Write the name of the current symbol to the only array cell
      ArrayResize(used_symbols_array,1);
      used_symbols_array[0]=Symbol();
      return true;
     }
//--- If working with a predefined symbol set (from the defined_used_symbols string)
   else if(mode_used_symbols==SYMBOLS_MODE_DEFINES)
     {
      //--- Set comma as a separator (defined in the Datas.mqh file, page 11)
      string separator=INPUT_SEPARATOR;
      int n=StringParamsPrepare(defined_used_symbols,separator,used_symbols_array);
      //--- if nothing is found, display the appropriate message (working with the current symbol is selected automatically)
      if(n<1)
        {
         int err_code=GetLastError();
         string err=
           (n==0  ?  
            DFUN_ERR_LINE+CMessage::Text(MSG_LIB_SYS_ERROR_EMPTY_SYMBOLS_STRING)+Symbol() :
            DFUN_ERR_LINE+CMessage::Text(MSG_LIB_SYS_FAILED_PREPARING_SYMBOLS_ARRAY)+(string)err_code+": "+CMessage::Text(err_code)
           );
         Print(err);
         return false;
        }
     }
//--- If working with the Market Watch window or the full list
   else
     {
      //--- Add the (mode_used_symbols) working mode to the only array cell
      ArrayResize(used_symbols_array,1);
      used_symbols_array[0]=EnumToString(mode_used_symbols);
     }
//--- All is successful
   return true;
  }
//+--------------------------------------------------------------------------------+
//| Search for a symbol and return the flag indicating its presence on the server  |
//+--------------------------------------------------------------------------------+
bool Exist(const string name)
  {
   int total=SymbolsTotal(false);
   for(int i=0;i<total;i++)
      if(SymbolName(i,false)==name)
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Prepare the array of timeframes for the timeseries collection    |
//+------------------------------------------------------------------+
bool CreateUsedTimeframesArray(const ENUM_TIMEFRAMES_MODE mode_used_periods,string defined_used_periods,string &used_periods_array[])
  {
//--- If working with the current chart period, fill the array with the current timeframe description string
   if(mode_used_periods==TIMEFRAMES_MODE_CURRENT)
     {
      ArrayResize(used_periods_array,1,21);
      used_periods_array[0]=TimeframeDescription((ENUM_TIMEFRAMES)Period());
      return true;
     }
//--- If working with a predefined set of chart periods (from the defined_used_periods string)
   else if(mode_used_periods==TIMEFRAMES_MODE_LIST)
     {
      //--- Set comma as a separator (defined in the Datas.mqh file, page 11)
      string separator=INPUT_SEPARATOR;
      //--- Fill in the array of parameters from the string with predefined timeframes
      int n=StringParamsPrepare(defined_used_periods,separator,used_periods_array);
      //--- if nothing is found, display the appropriate message (working with the current period is selected automatically)
      if(n<1)
        {
         int err_code=GetLastError();
         string err=
           (n==0  ?  
            DFUN_ERR_LINE+CMessage::Text(MSG_LIB_SYS_ERROR_EMPTY_PERIODS_STRING)+TimeframeDescription((ENUM_TIMEFRAMES)Period()) :
            DFUN_ERR_LINE+CMessage::Text(MSG_LIB_SYS_FAILED_PREPARING_PERIODS_ARRAY)+(string)err_code+": "+CMessage::Text(err_code)
           );
         Print(err);
         //--- Set the current period to the array
         ArrayResize(used_periods_array,1,21);
         used_periods_array[0]=TimeframeDescription((ENUM_TIMEFRAMES)Period());
         return false;
        }
     }
//--- If working with the full list of timeframes, fill in the array with strings describing all timeframes
   else
     {
      ArrayResize(used_periods_array,21,21);
      for(int i=0;i<21;i++)
         used_periods_array[i]=TimeframeDescription(TimeframeByEnumIndex(uchar(i+1)));
     }

//--- Add the current chart timeframe to the list of used periods
   bool f=false;
   for(int i=0;i<ArraySize(used_periods_array);i++)
     {
      if(used_periods_array[i]==TimeframeDescription((ENUM_TIMEFRAMES)Period()))
        {
         f=true;
         break;
        }
     }
   //--- If the list of used periods features no timeframe of the current chart
   if(!f)
     {
      //--- Increase the array of used periods by 1 and add the current chart period to it
      ArrayResize(used_periods_array,ArraySize(used_periods_array)+1);
      used_periods_array[ArraySize(used_periods_array)-1]=TimeframeDescription((ENUM_TIMEFRAMES)Period());
     }
//--- All is successful
   return true;
  }
//+------------------------------------------------------------------+
//| Prepare the passed string of parameters                          |
//+------------------------------------------------------------------+
int StringParamsPrepare(string defined_used,string separator,string &array[])
  {
//--- Replace erroneous separators with correct ones
   if(separator!=";" && StringFind(defined_used,";")>WRONG_VALUE)  StringReplace(defined_used,";",separator);   
   if(separator!=":" && StringFind(defined_used,":")>WRONG_VALUE)  StringReplace(defined_used,":",separator); 
   if(separator!="|" && StringFind(defined_used,"|")>WRONG_VALUE)  StringReplace(defined_used,"|",separator);   
   if(separator!="/" && StringFind(defined_used,"/")>WRONG_VALUE)  StringReplace(defined_used,"/",separator); 
   if(separator!="\\"&& StringFind(defined_used,"\\")>WRONG_VALUE) StringReplace(defined_used,"\\",separator);  
   if(separator!="'" && StringFind(defined_used,"'")>WRONG_VALUE)  StringReplace(defined_used,"'",separator); 
   if(separator!="-" && StringFind(defined_used,"-")>WRONG_VALUE)  StringReplace(defined_used,"-",separator);   
   if(separator!="`" && StringFind(defined_used,"`")>WRONG_VALUE)  StringReplace(defined_used,"`",separator);

//--- Delete as long as there are spaces
   while(StringFind(defined_used," ")>WRONG_VALUE && !IsStopped()) 
      StringReplace(defined_used," ","");
//--- As soon as there are double separators (after removing spaces between them), replace them with a separator
   while(StringFind(defined_used,separator+separator)>WRONG_VALUE && !IsStopped())
      StringReplace(defined_used,separator+separator,separator);
//--- If a single separator remains before the first symbol in the string, replace it with a space
   if(StringFind(defined_used,separator)==0) 
      StringSetCharacter(defined_used,0,32);
//--- If a single separator remains after the last symbol in the string, replace it with a space
   if(StringFind(defined_used,separator,StringLen(defined_used)-1)==StringLen(defined_used)-1) 
      StringSetCharacter(defined_used,StringLen(defined_used)-1,32);

//--- Remove all redundant things to the left and right
   #ifdef __MQL5__
      StringTrimLeft(defined_used);
      StringTrimRight(defined_used);
//---  __MQL4__
   #else 
      defined_used=StringTrimLeft(defined_used);
      defined_used=StringTrimRight(defined_used);
   #endif 
//--- Prepare the array 
   ArrayResize(array,0);
   ResetLastError();
//--- divide the string by separators (comma), write all detected substrings into the array and return the number of obtained substrings
   return StringSplit(defined_used,StringGetCharacter(separator,0),array);
  }
//+------------------------------------------------------------------+
//| Return the timeframe index in the ENUM_TIMEFRAMES enumeration    |
//+------------------------------------------------------------------+
char IndexEnumTimeframe(ENUM_TIMEFRAMES timeframe)
  {
   int statement=(timeframe==PERIOD_CURRENT ? Period() : timeframe);
   switch(statement)
     {
      case PERIOD_M1    :  return 1;
      case PERIOD_M2    :  return 2;
      case PERIOD_M3    :  return 3;
      case PERIOD_M4    :  return 4;
      case PERIOD_M5    :  return 5;
      case PERIOD_M6    :  return 6;
      case PERIOD_M10   :  return 7;
      case PERIOD_M12   :  return 8;
      case PERIOD_M15   :  return 9;
      case PERIOD_M20   :  return 10;
      case PERIOD_M30   :  return 11;
      case PERIOD_H1    :  return 12;
      case PERIOD_H2    :  return 13;
      case PERIOD_H3    :  return 14;
      case PERIOD_H4    :  return 15;
      case PERIOD_H6    :  return 16;
      case PERIOD_H8    :  return 17;
      case PERIOD_H12   :  return 18;
      case PERIOD_D1    :  return 19;
      case PERIOD_W1    :  return 20;
      case PERIOD_MN1   :  return 21;
      default           :  Print(DFUN,CMessage::Text(MSG_LIB_TEXT_TS_TEXT_UNKNOWN_TIMEFRAME)); return WRONG_VALUE;
     }
  }
//+------------------------------------------------------------------+
//| Return the timeframe by the ENUM_TIMEFRAMES enumeration index    |
//+------------------------------------------------------------------+
ENUM_TIMEFRAMES TimeframeByEnumIndex(const uchar index)
  {
   if(index==0) return(ENUM_TIMEFRAMES)Period();
   switch(index)
     {
      case 1   :  return PERIOD_M1;
      case 2   :  return PERIOD_M2;
      case 3   :  return PERIOD_M3;
      case 4   :  return PERIOD_M4;
      case 5   :  return PERIOD_M5;
      case 6   :  return PERIOD_M6;
      case 7   :  return PERIOD_M10;
      case 8   :  return PERIOD_M12;
      case 9   :  return PERIOD_M15;
      case 10  :  return PERIOD_M20;
      case 11  :  return PERIOD_M30;
      case 12  :  return PERIOD_H1;
      case 13  :  return PERIOD_H2;
      case 14  :  return PERIOD_H3;
      case 15  :  return PERIOD_H4;
      case 16  :  return PERIOD_H6;
      case 17  :  return PERIOD_H8;
      case 18  :  return PERIOD_H12;
      case 19  :  return PERIOD_D1;
      case 20  :  return PERIOD_W1;
      case 21  :  return PERIOD_MN1;
      default  :  Print(DFUN,CMessage::Text(MSG_LIB_SYS_NOT_GET_DATAS),"... ",CMessage::Text(MSG_SYM_STATUS_INDEX),": ",(string)index); return WRONG_VALUE;
     }
  }
//+------------------------------------------------------------------+
//| Return the timeframe by its description                          |
//+------------------------------------------------------------------+
ENUM_TIMEFRAMES TimeframeByDescription(const string timeframe)
  {
   return
     (
      timeframe=="M1"   ?  PERIOD_M1   :
      timeframe=="M2"   ?  PERIOD_M2   :
      timeframe=="M3"   ?  PERIOD_M3   :
      timeframe=="M4"   ?  PERIOD_M4   :
      timeframe=="M5"   ?  PERIOD_M5   :
      timeframe=="M6"   ?  PERIOD_M6   :
      timeframe=="M10"  ?  PERIOD_M10  :
      timeframe=="M12"  ?  PERIOD_M12  :
      timeframe=="M15"  ?  PERIOD_M15  :
      timeframe=="M20"  ?  PERIOD_M20  :
      timeframe=="M30"  ?  PERIOD_M30  :
      timeframe=="H1"   ?  PERIOD_H1   :
      timeframe=="H2"   ?  PERIOD_H2   :
      timeframe=="H3"   ?  PERIOD_H3   :
      timeframe=="H4"   ?  PERIOD_H4   :
      timeframe=="H6"   ?  PERIOD_H6   :
      timeframe=="H8"   ?  PERIOD_H8   :
      timeframe=="H12"  ?  PERIOD_H12  :
      timeframe=="D1"   ?  PERIOD_D1   :
      timeframe=="W1"   ?  PERIOD_W1   :
      timeframe=="MN1"  ?  PERIOD_MN1  :
      PERIOD_CURRENT
     );
  }
//+------------------------------------------------------------------+
//| Return correct StopLoss relative to StopLevel                    |
//+------------------------------------------------------------------+
double CorrectStopLoss(const string symbol_name,const ENUM_ORDER_TYPE order_type,const double price_set,const double stop_loss,const int spread_multiplier=2)
  {
   if(stop_loss==0) return 0;
   int lv=StopLevel(symbol_name,spread_multiplier), dg=(int)SymbolInfoInteger(symbol_name,SYMBOL_DIGITS);
   double pt=SymbolInfoDouble(symbol_name,SYMBOL_POINT);
   double price=(order_type==ORDER_TYPE_BUY ? SymbolInfoDouble(symbol_name,SYMBOL_BID) : order_type==ORDER_TYPE_SELL ? SymbolInfoDouble(symbol_name,SYMBOL_ASK) : price_set);
   return
     (order_type==ORDER_TYPE_BUY       || 
      order_type==ORDER_TYPE_BUY_LIMIT || 
      order_type==ORDER_TYPE_BUY_STOP
      #ifdef __MQL5__                  ||
      order_type==ORDER_TYPE_BUY_STOP_LIMIT
      #endif ? 
      NormalizeDouble(fmin(price-lv*pt,stop_loss),dg) :
      NormalizeDouble(fmax(price+lv*pt,stop_loss),dg)
     );
  }
//+------------------------------------------------------------------+
//| Return correct StopLoss relative to StopLevel                    |
//+------------------------------------------------------------------+
double CorrectStopLoss(const string symbol_name,const ENUM_ORDER_TYPE order_type,const double price_set,const int stop_loss,const int spread_multiplier=2)
  {
   if(stop_loss==0) return 0;
   int lv=StopLevel(symbol_name,spread_multiplier), dg=(int)SymbolInfoInteger(symbol_name,SYMBOL_DIGITS);
   double pt=SymbolInfoDouble(symbol_name,SYMBOL_POINT);
   double price=(order_type==ORDER_TYPE_BUY ? SymbolInfoDouble(symbol_name,SYMBOL_BID) : order_type==ORDER_TYPE_SELL ? SymbolInfoDouble(symbol_name,SYMBOL_ASK) : price_set);
   return
     (order_type==ORDER_TYPE_BUY       || 
      order_type==ORDER_TYPE_BUY_LIMIT || 
      order_type==ORDER_TYPE_BUY_STOP
      #ifdef __MQL5__                  ||
      order_type==ORDER_TYPE_BUY_STOP_LIMIT
      #endif ?
      NormalizeDouble(fmin(price-lv*pt,price-stop_loss*pt),dg) :
      NormalizeDouble(fmax(price+lv*pt,price+stop_loss*pt),dg)
     );
  }
//+------------------------------------------------------------------+
//| Return correct TakeProfit relative to StopLevel                  |
//+------------------------------------------------------------------+
double CorrectTakeProfit(const string symbol_name,const ENUM_ORDER_TYPE order_type,const double price_set,const double take_profit,const int spread_multiplier=2)
  {
   if(take_profit==0) return 0;
   int lv=StopLevel(symbol_name,spread_multiplier), dg=(int)SymbolInfoInteger(symbol_name,SYMBOL_DIGITS);
   double pt=SymbolInfoDouble(symbol_name,SYMBOL_POINT);
   double price=(order_type==ORDER_TYPE_BUY ? SymbolInfoDouble(symbol_name,SYMBOL_BID) : order_type==ORDER_TYPE_SELL ? SymbolInfoDouble(symbol_name,SYMBOL_ASK) : price_set);
   return
     (order_type==ORDER_TYPE_BUY       || 
      order_type==ORDER_TYPE_BUY_LIMIT || 
      order_type==ORDER_TYPE_BUY_STOP
      #ifdef __MQL5__                  ||
      order_type==ORDER_TYPE_BUY_STOP_LIMIT
      #endif ?
      NormalizeDouble(fmax(price+lv*pt,take_profit),dg) :
      NormalizeDouble(fmin(price-lv*pt,take_profit),dg)
     );
  }
//+------------------------------------------------------------------+
//| Return correct TakeProfit relative to StopLevel                  |
//+------------------------------------------------------------------+
double CorrectTakeProfit(const string symbol_name,const ENUM_ORDER_TYPE order_type,const double price_set,const int take_profit,const int spread_multiplier=2)
  {
   if(take_profit==0) return 0;
   int lv=StopLevel(symbol_name,spread_multiplier), dg=(int)SymbolInfoInteger(symbol_name,SYMBOL_DIGITS);
   double pt=SymbolInfoDouble(symbol_name,SYMBOL_POINT);
   double price=(order_type==ORDER_TYPE_BUY ? SymbolInfoDouble(symbol_name,SYMBOL_BID) : order_type==ORDER_TYPE_SELL ? SymbolInfoDouble(symbol_name,SYMBOL_ASK) : price_set);
   return
     (order_type==ORDER_TYPE_BUY       || 
      order_type==ORDER_TYPE_BUY_LIMIT || 
      order_type==ORDER_TYPE_BUY_STOP
      #ifdef __MQL5__                  ||
      order_type==ORDER_TYPE_BUY_STOP_LIMIT
      #endif ?
      ::NormalizeDouble(::fmax(price+lv*pt,price+take_profit*pt),dg) :
      ::NormalizeDouble(::fmin(price-lv*pt,price-take_profit*pt),dg)
     );
  }
//+------------------------------------------------------------------+
//| Return the correct order placement price                         |
//| relative to StopLevel                                            |
//+------------------------------------------------------------------+
double CorrectPricePending(const string symbol_name,const ENUM_ORDER_TYPE order_type,const double price_set,const double price=0,const int spread_multiplier=2)
  {
   double pt=SymbolInfoDouble(symbol_name,SYMBOL_POINT),pp=0;
   int lv=StopLevel(symbol_name,spread_multiplier), dg=(int)SymbolInfoInteger(symbol_name,SYMBOL_DIGITS);
   switch((int)order_type)
     {
      case ORDER_TYPE_BUY_LIMIT        :  pp=(price==0 ? SymbolInfoDouble(symbol_name,SYMBOL_ASK) : price); return NormalizeDouble(fmin(pp-lv*pt,price_set),dg);
      case ORDER_TYPE_BUY_STOP         :  
      case ORDER_TYPE_BUY_STOP_LIMIT   :  pp=(price==0 ? SymbolInfoDouble(symbol_name,SYMBOL_ASK) : price); return NormalizeDouble(fmax(pp+lv*pt,price_set),dg);
      case ORDER_TYPE_SELL_LIMIT       :  pp=(price==0 ? SymbolInfoDouble(symbol_name,SYMBOL_BID) : price); return NormalizeDouble(fmax(pp+lv*pt,price_set),dg);
      case ORDER_TYPE_SELL_STOP        :  
      case ORDER_TYPE_SELL_STOP_LIMIT  :  pp=(price==0 ? SymbolInfoDouble(symbol_name,SYMBOL_BID) : price); return NormalizeDouble(fmin(pp-lv*pt,price_set),dg);
      default                          :  Print(DFUN,CMessage::Text(MSG_LIB_SYS_INVALID_ORDER_TYPE),EnumToString(order_type)); return 0;
     }
  }
//+------------------------------------------------------------------+
//| Return the correct order placement price                         |
//| relative to StopLevel                                            |
//+------------------------------------------------------------------+
double CorrectPricePending(const string symbol_name,const ENUM_ORDER_TYPE order_type,const int distance_set,const double price=0,const int spread_multiplier=2)
  {
   double pt=SymbolInfoDouble(symbol_name,SYMBOL_POINT),pp=0;
   int lv=StopLevel(symbol_name,spread_multiplier), dg=(int)SymbolInfoInteger(symbol_name,SYMBOL_DIGITS);
   switch((int)order_type)
     {
      case ORDER_TYPE_BUY_LIMIT        :  pp=(price==0 ? SymbolInfoDouble(symbol_name,SYMBOL_ASK) : price); return NormalizeDouble(fmin(pp-lv*pt,pp-distance_set*pt),dg);
      case ORDER_TYPE_BUY_STOP         :  
      case ORDER_TYPE_BUY_STOP_LIMIT   :  pp=(price==0 ? SymbolInfoDouble(symbol_name,SYMBOL_ASK) : price); return NormalizeDouble(fmax(pp+lv*pt,pp+distance_set*pt),dg);
      case ORDER_TYPE_SELL_LIMIT       :  pp=(price==0 ? SymbolInfoDouble(symbol_name,SYMBOL_BID) : price); return NormalizeDouble(fmax(pp+lv*pt,pp+distance_set*pt),dg);
      case ORDER_TYPE_SELL_STOP        :  
      case ORDER_TYPE_SELL_STOP_LIMIT  :  pp=(price==0 ? SymbolInfoDouble(symbol_name,SYMBOL_BID) : price); return NormalizeDouble(fmin(pp-lv*pt,pp-distance_set*pt),dg);
      default                          :  Print(DFUN,CMessage::Text(MSG_LIB_SYS_INVALID_ORDER_TYPE),EnumToString(order_type)); return 0;
     }
  }
//+------------------------------------------------------------------+
//| Check the stop level in points relative to StopLevel             |
//+------------------------------------------------------------------+
bool CheckStopLevel(const string symbol_name,const int stop_in_points,const int spread_multiplier)
  {
   return(stop_in_points>=StopLevel(symbol_name,spread_multiplier));
  }
//+------------------------------------------------------------------+
//| Return StopLevel in points                                       |
//+------------------------------------------------------------------+
int StopLevel(const string symbol_name,const int spread_multiplier)
  {
   int spread=(int)SymbolInfoInteger(symbol_name,SYMBOL_SPREAD);
   int stop_level=(int)SymbolInfoInteger(symbol_name,SYMBOL_TRADE_STOPS_LEVEL);
   return(stop_level==0 ? spread*spread_multiplier : stop_level);
  }
//+------------------------------------------------------------------+
//| Return the order name                                            |
//+------------------------------------------------------------------+
string OrderTypeDescription(const ENUM_ORDER_TYPE type,bool as_order=true,bool prefix_for_market_order=true,bool descr=true)
  {
   string pref=
     (
      !prefix_for_market_order ? "" :
      #ifdef __MQL5__ CMessage::Text(MSG_ORD_MARKET) 
      #else/*__MQL4__*/(as_order ? CMessage::Text(MSG_ORD_MARKET) : CMessage::Text(MSG_ORD_POSITION)) #endif 
     );
   return
     (
      type==ORDER_TYPE_BUY_LIMIT       ?  (descr ? CMessage::Text(MSG_ORD_PENDING) : "")+" Buy Limit"       :
      type==ORDER_TYPE_BUY_STOP        ?  (descr ? CMessage::Text(MSG_ORD_PENDING) : "")+" Buy Stop"        :
      type==ORDER_TYPE_SELL_LIMIT      ?  (descr ? CMessage::Text(MSG_ORD_PENDING) : "")+" Sell Limit"      :
      type==ORDER_TYPE_SELL_STOP       ?  (descr ? CMessage::Text(MSG_ORD_PENDING) : "")+" Sell Stop"       :
   #ifdef __MQL5__
      type==ORDER_TYPE_BUY_STOP_LIMIT  ?  (descr ? CMessage::Text(MSG_ORD_PENDING) : "")+" Buy Stop Limit"  :
      type==ORDER_TYPE_SELL_STOP_LIMIT ?  (descr ? CMessage::Text(MSG_ORD_PENDING) : "")+" Sell Stop Limit" :
      type==ORDER_TYPE_CLOSE_BY        ?  CMessage::Text(MSG_ORD_CLOSE_BY)                                  :  
   #else 
      type==ORDER_TYPE_BALANCE         ?  CMessage::Text(MSG_LIB_PROP_BALANCE)                              :
      type==ORDER_TYPE_CREDIT          ?  CMessage::Text(MSG_LIB_PROP_CREDIT)                               :
   #endif 
      type==ORDER_TYPE_BUY             ?  pref+" Buy"                                                       :
      type==ORDER_TYPE_SELL            ?  pref+" Sell"                                                      :  
      CMessage::Text(MSG_ORD_UNKNOWN_TYPE)
     );
  }
//+------------------------------------------------------------------+
//| Return the order filling mode description                        |
//+------------------------------------------------------------------+
string OrderTypeFillingDescription(const ENUM_ORDER_TYPE_FILLING type)
  {
   return
     (
      type==ORDER_FILLING_FOK    ?  CMessage::Text(MSG_LIB_TEXT_REQUEST_ORDER_FILLING_FOK)   :
      type==ORDER_FILLING_IOC    ?  CMessage::Text(MSG_LIB_TEXT_REQUEST_ORDER_FILLING_IOK)   :
      type==ORDER_FILLING_RETURN ?  CMessage::Text(MSG_LIB_TEXT_REQUEST_ORDER_FILLING_RETURN): 
      type==WRONG_VALUE          ? "WRONG_VALUE"   :  EnumToString(type)
     );
  }
//+------------------------------------------------------------------+
//| Return the order expiration type description                     |
//+------------------------------------------------------------------+
string OrderTypeTimeDescription(const ENUM_ORDER_TYPE_TIME type)
  {
   return
     (
      type==ORDER_TIME_GTC             ?  CMessage::Text(MSG_LIB_TEXT_REQUEST_ORDER_TIME_GTC)            :
      type==ORDER_TIME_DAY             ?  CMessage::Text(MSG_LIB_TEXT_REQUEST_ORDER_TIME_DAY)            :
      type==ORDER_TIME_SPECIFIED       ?  CMessage::Text(MSG_LIB_TEXT_REQUEST_ORDER_TIME_SPECIFIED)      :
      type==ORDER_TIME_SPECIFIED_DAY   ?  CMessage::Text(MSG_LIB_TEXT_REQUEST_ORDER_TIME_SPECIFIED_DAY)  :
      type==WRONG_VALUE                ? "WRONG_VALUE"   :  EnumToString(type)
     );
  }
//+------------------------------------------------------------------+
//| Return the position name                                         |
//+------------------------------------------------------------------+
string PositionTypeDescription(const ENUM_POSITION_TYPE type)
  {
   return
     (
      type==POSITION_TYPE_BUY    ? "Buy"  :
      type==POSITION_TYPE_SELL   ? "Sell" :  
      CMessage::Text(MSG_POS_UNKNOWN_TYPE)
     );
  }
//+------------------------------------------------------------------+
//| Return the deal name                                             |
//+------------------------------------------------------------------+
string DealTypeDescription(const ENUM_DEAL_TYPE type)
  {
   return
     (
      type==DEAL_TYPE_BUY                       ?  CMessage::Text(MSG_DEAL_TO_BUY)                          :
      type==DEAL_TYPE_SELL                      ?  CMessage::Text(MSG_DEAL_TO_SELL)                         :
      type==DEAL_TYPE_BALANCE                   ?  CMessage::Text(MSG_LIB_PROP_BALANCE)                     :
      type==DEAL_TYPE_CREDIT                    ?  CMessage::Text(MSG_EVN_ACCOUNT_CREDIT)                   :
      type==DEAL_TYPE_CHARGE                    ?  CMessage::Text(MSG_EVN_ACCOUNT_CHARGE)                   :
      type==DEAL_TYPE_CORRECTION                ?  CMessage::Text(MSG_EVN_ACCOUNT_CORRECTION)               :
      type==DEAL_TYPE_BONUS                     ?  CMessage::Text(MSG_EVN_ACCOUNT_BONUS)                    :
      type==DEAL_TYPE_COMMISSION                ?  CMessage::Text(MSG_EVN_ACCOUNT_COMISSION)                :
      type==DEAL_TYPE_COMMISSION_DAILY          ?  CMessage::Text(MSG_EVN_ACCOUNT_COMISSION_DAILY)          :
      type==DEAL_TYPE_COMMISSION_MONTHLY        ?  CMessage::Text(MSG_EVN_ACCOUNT_COMISSION_MONTHLY)        :
      type==DEAL_TYPE_COMMISSION_AGENT_DAILY    ?  CMessage::Text(MSG_EVN_ACCOUNT_COMISSION_AGENT_DAILY)    :
      type==DEAL_TYPE_COMMISSION_AGENT_MONTHLY  ?  CMessage::Text(MSG_EVN_ACCOUNT_COMISSION_AGENT_MONTHLY)  :
      type==DEAL_TYPE_INTEREST                  ?  CMessage::Text(MSG_EVN_ACCOUNT_INTEREST)                 :
      type==DEAL_TYPE_BUY_CANCELED              ?  CMessage::Text(MSG_EVN_BUY_CANCELLED)                    :
      type==DEAL_TYPE_SELL_CANCELED             ?  CMessage::Text(MSG_EVN_SELL_CANCELLED)                   :
      type==DEAL_DIVIDEND                       ?  CMessage::Text(MSG_EVN_DIVIDENT)                         :
      type==DEAL_DIVIDEND_FRANKED               ?  CMessage::Text(MSG_EVN_DIVIDENT_FRANKED)                 :
      type==DEAL_TAX                            ?  CMessage::Text(MSG_EVN_TAX)                              : 
      CMessage::Text(MSG_POS_UNKNOWN_DEAL)
     );
  }
//+------------------------------------------------------------------+
//| Return position type by order type                               |
//+------------------------------------------------------------------+
ENUM_POSITION_TYPE PositionTypeByOrderType(ENUM_ORDER_TYPE type_order)
  {
   if(type_order==ORDER_TYPE_CLOSE_BY)
      return WRONG_VALUE;
   return ENUM_POSITION_TYPE(type_order%2);
  }
//+------------------------------------------------------------------+
//| Return an order type by a position type                          |
//+------------------------------------------------------------------+
ENUM_ORDER_TYPE OrderTypeByPositionType(ENUM_POSITION_TYPE type_position)
  {
   return (ENUM_ORDER_TYPE)type_position;
  }
//+------------------------------------------------------------------+
//| Return a reverse order type by a position type                   |
//+------------------------------------------------------------------+
ENUM_ORDER_TYPE OrderTypeOppositeByPositionType(ENUM_POSITION_TYPE type_position)
  {
   return(type_position==POSITION_TYPE_BUY ? ORDER_TYPE_SELL :  ORDER_TYPE_BUY);
  }
//+------------------------------------------------------------------+
//| Return week day names                                            |
//+------------------------------------------------------------------+
string DayOfWeekDescription(const ENUM_DAY_OF_WEEK day_of_week)
  {
   return
     (
      day_of_week==SUNDAY     ?  CMessage::Text(MSG_LIB_TEXT_SUNDAY)    :
      day_of_week==MONDAY     ?  CMessage::Text(MSG_LIB_TEXT_MONDAY)    :
      day_of_week==TUESDAY    ?  CMessage::Text(MSG_LIB_TEXT_TUESDAY)   :
      day_of_week==WEDNESDAY  ?  CMessage::Text(MSG_LIB_TEXT_WEDNESDAY) :
      day_of_week==THURSDAY   ?  CMessage::Text(MSG_LIB_TEXT_THURSDAY)  :
      day_of_week==FRIDAY     ?  CMessage::Text(MSG_LIB_TEXT_FRIDAY)    :
      day_of_week==SATURDAY   ?  CMessage::Text(MSG_LIB_TEXT_SATURDAY)  :
      EnumToString(day_of_week)
     );
  }
//+------------------------------------------------------------------+
//| Return month names                                               |
//+------------------------------------------------------------------+
string MonthDescription(const int month)
  {
   return
     (
      month==1    ?  CMessage::Text(MSG_LIB_TEXT_JANUARY)   :
      month==2    ?  CMessage::Text(MSG_LIB_TEXT_FEBRUARY)  :
      month==3    ?  CMessage::Text(MSG_LIB_TEXT_MARCH)     :
      month==4    ?  CMessage::Text(MSG_LIB_TEXT_APRIL)     :
      month==5    ?  CMessage::Text(MSG_LIB_TEXT_MAY)       :
      month==6    ?  CMessage::Text(MSG_LIB_TEXT_JUNE)      :
      month==7    ?  CMessage::Text(MSG_LIB_TEXT_JULY)      :
      month==8    ?  CMessage::Text(MSG_LIB_TEXT_AUGUST)    :
      month==9    ?  CMessage::Text(MSG_LIB_TEXT_SEPTEMBER) :
      month==10   ?  CMessage::Text(MSG_LIB_TEXT_OCTOBER)   :
      month==11   ?  CMessage::Text(MSG_LIB_TEXT_NOVEMBER)  :
      month==12   ?  CMessage::Text(MSG_LIB_TEXT_DECEMBER)  :
      (string)month
     );
  }
//+------------------------------------------------------------------+
//| Display the trading request description in the journal           |
//+------------------------------------------------------------------+
void PrintRequestDescription(const MqlTradeRequest &request)
  {
   string datas=
     (
      " - "+RequestActionDescription(request)+"\n"+
      " - "+RequestMagicDescription(request)+"\n"+
      " - "+RequestOrderDescription(request)+"\n"+
      " - "+RequestSymbolDescription(request)+"\n"+
      " - "+RequestVolumeDescription(request)+"\n"+
      " - "+RequestPriceDescription(request)+"\n"+
      " - "+RequestStopLimitDescription(request)+"\n"+
      " - "+RequestStopLossDescription(request)+"\n"+
      " - "+RequestTakeProfitDescription(request)+"\n"+
      " - "+RequestDeviationDescription(request)+"\n"+
      " - "+RequestTypeDescription(request)+"\n"+
      " - "+RequestTypeFillingDescription(request)+"\n"+
      " - "+RequestTypeTimeDescription(request)+"\n"+
      " - "+RequestExpirationDescription(request)+"\n"+
      " - "+RequestCommentDescription(request)+"\n"+
      " - "+RequestPositionDescription(request)+"\n"+
      " - "+RequestPositionByDescription(request)
     );
   Print("================== ",CMessage::Text(MSG_LIB_TEXT_REQUEST_DATAS)," ==================\n",datas,"\n");
  }
//+------------------------------------------------------------------+
//| Return the executed action type description                      |
//+------------------------------------------------------------------+
string RequestActionDescription(const MqlTradeRequest &request)
  {
   int code_descr=
     (
      request.action==TRADE_ACTION_DEAL      ?  MSG_LIB_TEXT_REQUEST_ACTION_DEAL       :
      request.action==TRADE_ACTION_PENDING   ?  MSG_LIB_TEXT_REQUEST_ACTION_PENDING    :
      request.action==TRADE_ACTION_SLTP      ?  MSG_LIB_TEXT_REQUEST_ACTION_SLTP       :
      request.action==TRADE_ACTION_MODIFY    ?  MSG_LIB_TEXT_REQUEST_ACTION_MODIFY     :
      request.action==TRADE_ACTION_REMOVE    ?  MSG_LIB_TEXT_REQUEST_ACTION_REMOVE     :
      request.action==TRADE_ACTION_CLOSE_BY  ?  MSG_LIB_TEXT_REQUEST_ACTION_CLOSE_BY   :
      MSG_LIB_TEXT_REQUEST_ACTION_UNCNOWN
     );
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_ACTION)+": "+CMessage::Text(code_descr);
  }
//+------------------------------------------------------------------+
//| Return the magic number value description                        |
//+------------------------------------------------------------------+
string RequestMagicDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_ORD_MAGIC)+": "+(string)request.magic;
  }
//+------------------------------------------------------------------+
//| Return the order ticket value description                        |
//+------------------------------------------------------------------+
string RequestOrderDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_ORDER)+": "+(request.order>0 ? (string)request.order : CMessage::Text(MSG_LIB_PROP_NOT_SET));
  }
//+------------------------------------------------------------------+
//| Return the trading instrument name description                   |
//+------------------------------------------------------------------+
string RequestSymbolDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_SYMBOL)+": "+request.symbol;
  }
//+------------------------------------------------------------------+
//| Return the request volume description                            |
//+------------------------------------------------------------------+
string RequestVolumeDescription(const MqlTradeRequest &request)
  {
   int dg=(int)DigitsLots(request.symbol);
   int dgl=(dg==0 ? 1 : dg);
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_VOLUME)+": "+(request.volume>0 ? DoubleToString(request.volume,dgl) : CMessage::Text(MSG_LIB_PROP_NOT_SET));
  }
//+------------------------------------------------------------------+
//| Return the request price value description                       |
//+------------------------------------------------------------------+
string RequestPriceDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_PRICE)+": "+(request.price>0 ? DoubleToString(request.price,(int)SymbolInfoInteger(request.symbol,SYMBOL_DIGITS)) : CMessage::Text(MSG_LIB_PROP_NOT_SET));
  }
//+------------------------------------------------------------------+
//| Return the request StopLimit order price description             |
//+------------------------------------------------------------------+
string RequestStopLimitDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_STOPLIMIT)+": "+(request.stoplimit>0 ? DoubleToString(request.stoplimit,(int)SymbolInfoInteger(request.symbol,SYMBOL_DIGITS)) : CMessage::Text(MSG_LIB_PROP_NOT_SET));
  }
//+------------------------------------------------------------------+
//| Return the request StopLoss order price description              |
//+------------------------------------------------------------------+
string RequestStopLossDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_SL)+": "+(request.sl>0 ? DoubleToString(request.sl,(int)SymbolInfoInteger(request.symbol,SYMBOL_DIGITS)) : CMessage::Text(MSG_LIB_PROP_NOT_SET));
  }
//+------------------------------------------------------------------+
//| Return the request TakeProfit order price description            |
//+------------------------------------------------------------------+
string RequestTakeProfitDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_TP)+": "+(request.tp>0 ? DoubleToString(request.tp,(int)SymbolInfoInteger(request.symbol,SYMBOL_DIGITS)) : CMessage::Text(MSG_LIB_PROP_NOT_SET));
  }
//+------------------------------------------------------------------+
//| Return the request deviation size description                    |
//+------------------------------------------------------------------+
string RequestDeviationDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_DEVIATION)+": "+(string)request.deviation;
  }
//+------------------------------------------------------------------+
//| Return the request order type description                        |
//+------------------------------------------------------------------+
string RequestTypeDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_TYPE)+": "+OrderTypeDescription(request.type);
  }
//+------------------------------------------------------------------+
//| Return the request order filling mode description                |
//+------------------------------------------------------------------+
string RequestTypeFillingDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_TYPE_FILLING)+": "+OrderTypeFillingDescription(request.type_filling);
  }
//+------------------------------------------------------------------+
//| Return the request order lifetime type description               |
//+------------------------------------------------------------------+
string RequestTypeTimeDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_TYPE_TIME)+": "+OrderTypeTimeDescription(request.type_time);
  }
//+------------------------------------------------------------------+
//| Return the request order expiration time description             |
//+------------------------------------------------------------------+
string RequestExpirationDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_EXPIRATION)+": "+(request.expiration>0 ? TimeToString(request.expiration) : CMessage::Text(MSG_LIB_PROP_NOT_SET));
  }
//+------------------------------------------------------------------+
//| Return the request order comment description                     |
//+------------------------------------------------------------------+
string RequestCommentDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_COMMENT)+": "+(request.comment!="" && request.comment!=NULL ? "\""+request.comment+"\"" : CMessage::Text(MSG_LIB_PROP_NOT_SET));
  }
//+------------------------------------------------------------------+
//| Return the request position ticket description                   |
//+------------------------------------------------------------------+
string RequestPositionDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_POSITION)+": "+(request.position>0 ? (string)request.position : CMessage::Text(MSG_LIB_PROP_NOT_SET));
  }
//+------------------------------------------------------------------+
//| Return the request opposite position ticket description          |
//+------------------------------------------------------------------+
string RequestPositionByDescription(const MqlTradeRequest &request)
  {
   return CMessage::Text(MSG_LIB_TEXT_REQUEST_POSITION_BY)+": "+(request.position_by>0 ? (string)request.position_by : CMessage::Text(MSG_LIB_PROP_NOT_SET));
  }
//+------------------------------------------------------------------+
//| Return the comparison type description                           |
//+------------------------------------------------------------------+
string ComparisonTypeDescription(const ENUM_COMPARER_TYPE type)
  {
   switch((int)type)
     {
      case EQUAL           :  return " == ";
      case MORE            :  return " > ";
      case LESS            :  return " < ";
      case EQUAL_OR_MORE   :  return " >= ";
      case EQUAL_OR_LESS   :  return " <= ";
      default              :  return " != ";
     }
  }
//+------------------------------------------------------------------+
//| Return timeframe description                                     |
//+------------------------------------------------------------------+
string TimeframeDescription(const ENUM_TIMEFRAMES timeframe)
  {
   return StringSubstr(EnumToString((timeframe>PERIOD_CURRENT ? timeframe : (ENUM_TIMEFRAMES)Period())),7);
  }
//+------------------------------------------------------------------+
//| Return volume description for calculation                        |
//+------------------------------------------------------------------+
string AppliedVolumeDescription(const ENUM_APPLIED_VOLUME volume)
  {
   return StringSubstr(EnumToString(volume),7);
  }
//+------------------------------------------------------------------+
//| Return indicator type description                                |
//+------------------------------------------------------------------+
string IndicatorTypeDescription(const ENUM_INDICATOR indicator)
  {
   return StringSubstr(EnumToString(indicator),4);
  }
//+------------------------------------------------------------------+
//| Return averaging method description                              |
//+------------------------------------------------------------------+
string AveragingMethodDescription(const ENUM_MA_METHOD method)
  {
   return StringSubstr(EnumToString(method),5);
  }
//+------------------------------------------------------------------+
//| Return applied price description                                 |
//+------------------------------------------------------------------+
string AppliedPriceDescription(const ENUM_APPLIED_PRICE price)
  {
   return StringSubstr(EnumToString(price),6);
  }
//+------------------------------------------------------------------+
//| Return stochastic price calculation description                  |
//+------------------------------------------------------------------+
string StochPriceDescription(const ENUM_STO_PRICE price)
  {
   return StringSubstr(EnumToString(price),4);
  }
//+------------------------------------------------------------------+
//| Return the description of parameter MqlParam array               |
//+------------------------------------------------------------------+
string MqlParameterDescription(const MqlParam &mql_param)
  {
   int type=mql_param.type;
   string res=CMessage::Text(MSG_ORD_TYPE)+" "+typename(type)+": ";
   //--- string parameter type
   if(type==TYPE_STRING)
      res+=mql_param.string_value;
   //--- datetime parameter type
   else if(type==TYPE_DATETIME)
      res+=TimeToString(mql_param.integer_value,TIME_DATE|TIME_MINUTES|TIME_SECONDS);
   //--- color parameter type
   else if(type==TYPE_COLOR)
      res+=ColorToString((color)mql_param.integer_value,true);
   //--- bool parameter type
   else if(type==TYPE_BOOL)
      res+=(string)(bool)mql_param.integer_value;
   //--- integer types
   else if(type>TYPE_BOOL && type<TYPE_FLOAT)
      res+=(string)mql_param.integer_value;
   //--- real types
   else
      res+=DoubleToString(mql_param.double_value,8);
   return res;
  }
//+------------------------------------------------------------------+
//| Return the flag of a prefixed object presence                    |
//+------------------------------------------------------------------+
bool IsPresentObectByPrefix(const string object_prefix)
  {
   for(int i=ObjectsTotal(0,0)-1;i>=0;i--)
      if(StringFind(ObjectName(0,i,0),object_prefix)>WRONG_VALUE)
         return true;
   return false;
  }
//+-------------------------------------------------------------------------+
//| Return the number of bars of one period in a single bar of another one  |
//+-------------------------------------------------------------------------+
int NumberBarsInTimeframe(ENUM_TIMEFRAMES timeframe,ENUM_TIMEFRAMES period=PERIOD_CURRENT)
  {
   return PeriodSeconds(timeframe)/PeriodSeconds(period==PERIOD_CURRENT ? (ENUM_TIMEFRAMES)Period() : period);
  }
//+------------------------------------------------------------------+
//| Copy data from the first OnCalculate() form to the structure     |
//+------------------------------------------------------------------+
void CopyData(const int rates_total,
              const int prev_calculated,
              const int begin,
              const double &price[])
  {
//--- Get the array indexing flag as in the timeseries. If failed,
//--- set the indexing direction for the array as in the timeseries
   bool as_series_price=ArrayGetAsSeries(price);
   if(!as_series_price)
      ArraySetAsSeries(price,true);
//--- Copy the array zero bar to the OnCalculate() SDataCalculate data structure
   rates_data.rates_total=rates_total;
   rates_data.prev_calculated=prev_calculated;
   rates_data.begin=begin;
   rates_data.price=price[0];
//--- Return the array's initial indexing direction
   if(!as_series_price)
      ArraySetAsSeries(price,false);
  }
//+------------------------------------------------------------------+
//| Copy data from the second OnCalculate() form to the structure    |
//+------------------------------------------------------------------+
void CopyData(const int rates_total,
              const int prev_calculated,
              const datetime &time[],
              const double &open[],
              const double &high[],
              const double &low[],
              const double &close[],
              const long &tick_volume[],
              const long &volume[],
              const int &spread[])
  {
//--- Get the array indexing flags as in the timeseries. If failed,
//--- set the indexing direction or the arrays as in the timeseries
   bool as_series_time=ArrayGetAsSeries(time);
   if(!as_series_time)
      ArraySetAsSeries(time,true);
   bool as_series_open=ArrayGetAsSeries(open);
   if(!as_series_open)
      ArraySetAsSeries(open,true);
   bool as_series_high=ArrayGetAsSeries(high);
   if(!as_series_high)
      ArraySetAsSeries(high,true);
   bool as_series_low=ArrayGetAsSeries(low);
   if(!as_series_low)
      ArraySetAsSeries(low,true);
   bool as_series_close=ArrayGetAsSeries(close);
   if(!as_series_close)
      ArraySetAsSeries(close,true);
   bool as_series_tick_volume=ArrayGetAsSeries(tick_volume);
   if(!as_series_tick_volume)
      ArraySetAsSeries(tick_volume,true);
   bool as_series_volume=ArrayGetAsSeries(volume);
   if(!as_series_volume)
      ArraySetAsSeries(volume,true);
   bool as_series_spread=ArrayGetAsSeries(spread);
   if(!as_series_spread)
      ArraySetAsSeries(spread,true);
//--- Copy the arrays' zero bar to the OnCalculate() SDataCalculate data structure
   rates_data.rates_total=rates_total;
   rates_data.prev_calculated=prev_calculated;
   rates_data.rates.time=time[0];
   rates_data.rates.open=open[0];
   rates_data.rates.high=high[0];
   rates_data.rates.low=low[0];
   rates_data.rates.close=close[0];
   rates_data.rates.tick_volume=tick_volume[0];
   rates_data.rates.real_volume=(#ifdef __MQL5__ volume[0] #else 0 #endif);
   rates_data.rates.spread=(#ifdef __MQL5__ spread[0] #else 0 #endif);
//--- Return the arrays' initial indexing direction
   if(!as_series_time)
      ArraySetAsSeries(time,false);
   if(!as_series_open)
      ArraySetAsSeries(open,false);
   if(!as_series_high)
      ArraySetAsSeries(high,false);
   if(!as_series_low)
      ArraySetAsSeries(low,false);
   if(!as_series_close)
      ArraySetAsSeries(close,false);
   if(!as_series_tick_volume)
      ArraySetAsSeries(tick_volume,false);
   if(!as_series_volume)
      ArraySetAsSeries(volume,false);
   if(!as_series_spread)
      ArraySetAsSeries(spread,false);
  }
//+------------------------------------------------------------------+
//| Copy data from the second OnCalculate() form to the structure    |
//| and set the "as timeseries" flag to all arrays                   |
//+------------------------------------------------------------------+
void CopyDataAsSeries(const int rates_total,
                      const int prev_calculated,
                      const datetime &time[],
                      const double &open[],
                      const double &high[],
                      const double &low[],
                      const double &close[],
                      const long &tick_volume[],
                      const long &volume[],
                      const int &spread[])
  {
//--- set the indexing direction or the arrays as in the timeseries
   ArraySetAsSeries(time,true);
   ArraySetAsSeries(open,true);
   ArraySetAsSeries(high,true);
   ArraySetAsSeries(low,true);
   ArraySetAsSeries(close,true);
   ArraySetAsSeries(tick_volume,true);
   ArraySetAsSeries(volume,true);
   ArraySetAsSeries(spread,true);
//--- Copy the arrays' zero bar to the OnCalculate() SDataCalculate data structure
   rates_data.rates_total=rates_total;
   rates_data.prev_calculated=prev_calculated;
   rates_data.rates.time=time[0];
   rates_data.rates.open=open[0];
   rates_data.rates.high=high[0];
   rates_data.rates.low=low[0];
   rates_data.rates.close=close[0];
   rates_data.rates.tick_volume=tick_volume[0];
   rates_data.rates.real_volume=(#ifdef __MQL5__ volume[0] #else 0 #endif);
   rates_data.rates.spread=(#ifdef __MQL5__ spread[0] #else 0 #endif);
  }
//+------------------------------------------------------------------+
//| Set standard indicator's decimal capacity and levels             |
//+------------------------------------------------------------------+
void SetIndicatorLevels(const string symbol,const ENUM_INDICATOR ind_type)
  {
   int digits=(int)SymbolInfoInteger(symbol,SYMBOL_DIGITS);
   switch(ind_type)
     {
      case IND_AD          :
      case IND_CHAIKIN     :
      case IND_OBV         :
      case IND_VOLUMES     : digits=0;    break;
      
      case IND_AO          :
      case IND_BEARS       :
      case IND_BULLS       :
      case IND_FORCE       :
      case IND_STDDEV      :
      case IND_AMA         :
      case IND_DEMA        :
      case IND_FRAMA       :
      case IND_MA          :
      case IND_TEMA        :
      case IND_VIDYA       :
      case IND_BANDS       :
      case IND_ENVELOPES   :
      case IND_MACD        : digits+=1;   break;
      
      case IND_AC          :
      case IND_OSMA        : digits+=2;   break;
      
      case IND_MOMENTUM    : digits=2;    break;
      
      case IND_CCI         :
        IndicatorSetInteger(INDICATOR_LEVELS,2);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,0,100);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,1,-100);
        digits=2;
        break;
      case IND_DEMARKER    :
        IndicatorSetInteger(INDICATOR_LEVELS,2);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,0,0.7);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,1,0.3);
        digits=3;
        break;
      case IND_MFI         :
        IndicatorSetInteger(INDICATOR_LEVELS,2);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,0,80);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,1,20);
        break;
      case IND_RSI         :
        IndicatorSetInteger(INDICATOR_LEVELS,3);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,0,70);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,1,50);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,2,30);
        digits=2;
        break;
      case IND_STOCHASTIC  :
        IndicatorSetInteger(INDICATOR_LEVELS,2);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,0,80);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,1,20);
        digits=2;
        break;
      case IND_WPR         :
        IndicatorSetInteger(INDICATOR_LEVELS,2);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,0,-80);
        IndicatorSetDouble(INDICATOR_LEVELVALUE,1,-20);
        digits=2;
        break;
     
      case IND_ATR         :              break;
      case IND_SAR         :              break;
      case IND_TRIX        :              break;
      
      default:
        IndicatorSetInteger(INDICATOR_LEVELS,0);
        break;
     }
   #ifdef __MQL5__
      IndicatorSetInteger(INDICATOR_DIGITS,digits);
   #else 
      IndicatorDigits(digits);
   #endif 
  }
//+------------------------------------------------------------------+
//| Return the description of the method of displaying a price chart |
//+------------------------------------------------------------------+
string ChartModeDescription(ENUM_CHART_MODE mode)
  {
   return
     (
      mode==CHART_BARS     ? CMessage::Text(MSG_CHART_OBJ_CHART_BARS)      :
      mode==CHART_CANDLES  ? CMessage::Text(MSG_CHART_OBJ_CHART_CANDLES)   :
      CMessage::Text(MSG_CHART_OBJ_CHART_LINE)
     );
  }
//+--------------------------------------------------------------------------+
//|Return the description of the mode of displaying volumes on a price chart |
//+--------------------------------------------------------------------------+
string ChartModeVolumeDescription(ENUM_CHART_VOLUME_MODE mode)
  {
   return
     (
      mode==CHART_VOLUME_TICK ? CMessage::Text(MSG_CHART_OBJ_CHART_VOLUME_TICK)  :
      mode==CHART_VOLUME_REAL ? CMessage::Text(MSG_CHART_OBJ_CHART_VOLUME_REAL)  :
      CMessage::Text(MSG_CHART_OBJ_CHART_VOLUME_HIDE)
     );
  }
//+------------------------------------------------------------------+
//| Return the file name (program name+local time)                   |
//+------------------------------------------------------------------+
string FileNameWithTimeLocal(const string time_prefix=NULL)
  {
   string name=
     (
      MQLInfoString(MQL_PROGRAM_NAME)+"_"+time_prefix+(time_prefix==NULL ? "" : "_")+
      TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES|TIME_SECONDS)
     );
   ResetLastError();
   if(StringReplace(name," ","_")==WRONG_VALUE)
      CMessage::ToLog(DFUN,GetLastError(),true);
   if(StringReplace(name,":",".")==WRONG_VALUE)
      CMessage::ToLog(DFUN,GetLastError(),true);
   return name;
  }
//+------------------------------------------------------------------+
//| Return the maximum value in the array                            |
//+------------------------------------------------------------------+
template<typename T>
bool ArrayMaximumValue(const string source,const T &array[],T &max_value)
  {
   if(ArraySize(array)==0)
     {
      CMessage::ToLog(source,MSG_CANV_ELEMENT_ERR_EMPTY_ARRAY);
      return false;
     }
   max_value=0;
   int index=ArrayMaximum(array);
   if(index==WRONG_VALUE)
      return false;
   max_value=array[index];
   return true;
  }
//+------------------------------------------------------------------+
//| Return the minimum value in the array                            |
//+------------------------------------------------------------------+
template<typename T>
bool ArrayMinimumValue(const string source,const T &array[],T &min_value)
  {
   if(ArraySize(array)==0)
     {
      CMessage::ToLog(source,MSG_CANV_ELEMENT_ERR_EMPTY_ARRAY);
      return false;
     }
   min_value=0;
   int index=ArrayMinimum(array);
   if(index==WRONG_VALUE)
      return false;
   min_value=array[index];
   return true;
  }
//+------------------------------------------------------------------+
//| Return the description of the drawn shape type                   |
//+------------------------------------------------------------------+
string FigureTypeDescription(const ENUM_FIGURE_TYPE figure_type)
  {
   return(StringSubstr(EnumToString(figure_type),12));
  }
//+------------------------------------------------------------------+
//| Return description of the line style                             |
//+------------------------------------------------------------------+
string LineStyleDescription(const ENUM_LINE_STYLE style)
  {
   return
     (
      style==STYLE_SOLID      ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STYLE_SOLID)      :
      style==STYLE_DASH       ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STYLE_DASH)       :
      style==STYLE_DOT        ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STYLE_DOT)        :
      style==STYLE_DASHDOT    ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STYLE_DASHDOT)    :
      style==STYLE_DASHDOTDOT ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STYLE_DASHDOTDOT) :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the alignment type description                            |
//+------------------------------------------------------------------+
string AlignModeDescription(ENUM_ALIGN_MODE align)
  {
   return
     (
      align==ALIGN_LEFT    ? CMessage::Text(MSG_LIB_TEXT_ALIGN_LEFT)    :
      align==ALIGN_CENTER  ? CMessage::Text(MSG_LIB_TEXT_ALIGN_CENTER)  :
      align==ALIGN_RIGHT   ? CMessage::Text(MSG_LIB_TEXT_ALIGN_RIGHT)   :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the Gann grid trend direction          |
//+------------------------------------------------------------------+
string GannDirectDescription(const ENUM_GANN_DIRECTION direction)
  {
   return
     (
      direction==GANN_UP_TREND   ? CMessage::Text(MSG_LIB_TEXT_GANN_UP_TREND)    :
      direction==GANN_DOWN_TREND ? CMessage::Text(MSG_LIB_TEXT_GANN_DOWN_TREND)  :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the Elliott wave marking level         |
//+------------------------------------------------------------------+
string ElliotWaveDegreeDescription(const ENUM_ELLIOT_WAVE_DEGREE degree)
  {
   return
     (
      degree==ELLIOTT_GRAND_SUPERCYCLE ? CMessage::Text(MSG_LIB_TEXT_ELLIOTT_GRAND_SUPERCYCLE)  :
      degree==ELLIOTT_SUPERCYCLE       ? CMessage::Text(MSG_LIB_TEXT_ELLIOTT_SUPERCYCLE)        :
      degree==ELLIOTT_CYCLE            ? CMessage::Text(MSG_LIB_TEXT_ELLIOTT_CYCLE)             :
      degree==ELLIOTT_PRIMARY          ? CMessage::Text(MSG_LIB_TEXT_ELLIOTT_PRIMARY)           :
      degree==ELLIOTT_INTERMEDIATE     ? CMessage::Text(MSG_LIB_TEXT_ELLIOTT_INTERMEDIATE)      :
      degree==ELLIOTT_MINOR            ? CMessage::Text(MSG_LIB_TEXT_ELLIOTT_MINOR)             :
      degree==ELLIOTT_MINUTE           ? CMessage::Text(MSG_LIB_TEXT_ELLIOTT_MINUTE)            :
      degree==ELLIOTT_MINUETTE         ? CMessage::Text(MSG_LIB_TEXT_ELLIOTT_MINUETTE)          :
      degree==ELLIOTT_SUBMINUETTE      ? CMessage::Text(MSG_LIB_TEXT_ELLIOTT_SUBMINUETTE)       :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the chart corner, relative to          |
//| which the coordinates in pixels are specified                    |
//+------------------------------------------------------------------+
string BaseCornerDescription(const ENUM_BASE_CORNER corner)
  {
   return
     (
      corner==CORNER_LEFT_UPPER  ? CMessage::Text(MSG_LIB_TEXT_CORNER_LEFT_UPPER)   :
      corner==CORNER_LEFT_LOWER  ? CMessage::Text(MSG_LIB_TEXT_CORNER_LEFT_LOWER)   :
      corner==CORNER_RIGHT_LOWER ? CMessage::Text(MSG_LIB_TEXT_CORNER_RIGHT_LOWER)  :
      corner==CORNER_RIGHT_UPPER ? CMessage::Text(MSG_LIB_TEXT_CORNER_RIGHT_UPPER)  :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the graphical object frame look        |
//+------------------------------------------------------------------+
string BorderTypeDescription(const ENUM_BORDER_TYPE border_type)
  {
   return
     (
      border_type==BORDER_FLAT   ? CMessage::Text(MSG_LIB_TEXT_BORDER_FLAT)   :
      border_type==BORDER_RAISED ? CMessage::Text(MSG_LIB_TEXT_BORDER_RAISED) :
      border_type==BORDER_SUNKEN ? CMessage::Text(MSG_LIB_TEXT_BORDER_SUNKEN) :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the standard graphical object type     |
//+------------------------------------------------------------------+
string StdGraphObjectTypeDescription(const ENUM_OBJECT type)
  {
   return
     (
      type==OBJ_VLINE               ? CMessage::Text(MSG_GRAPH_STD_OBJ_VLINE)             :
      type==OBJ_HLINE               ? CMessage::Text(MSG_GRAPH_STD_OBJ_HLINE)             :
      type==OBJ_TREND               ? CMessage::Text(MSG_GRAPH_STD_OBJ_TREND)             :
      type==OBJ_TRENDBYANGLE        ? CMessage::Text(MSG_GRAPH_STD_OBJ_TRENDBYANGLE)      :
      type==OBJ_CYCLES              ? CMessage::Text(MSG_GRAPH_STD_OBJ_CYCLES)            :
      type==OBJ_ARROWED_LINE        ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROWED_LINE)      :
      type==OBJ_CHANNEL             ? CMessage::Text(MSG_GRAPH_STD_OBJ_CHANNEL)           :
      type==OBJ_STDDEVCHANNEL       ? CMessage::Text(MSG_GRAPH_STD_OBJ_STDDEVCHANNEL)     :
      type==OBJ_REGRESSION          ? CMessage::Text(MSG_GRAPH_STD_OBJ_REGRESSION)        :
      type==OBJ_PITCHFORK           ? CMessage::Text(MSG_GRAPH_STD_OBJ_PITCHFORK)         :
      type==OBJ_GANNLINE            ? CMessage::Text(MSG_GRAPH_STD_OBJ_GANNLINE)          :
      type==OBJ_GANNFAN             ? CMessage::Text(MSG_GRAPH_STD_OBJ_GANNFAN)           :
      type==OBJ_GANNGRID            ? CMessage::Text(MSG_GRAPH_STD_OBJ_GANNGRID)          :
      type==OBJ_FIBO                ? CMessage::Text(MSG_GRAPH_STD_OBJ_FIBO)              :
      type==OBJ_FIBOTIMES           ? CMessage::Text(MSG_GRAPH_STD_OBJ_FIBOTIMES)         :
      type==OBJ_FIBOFAN             ? CMessage::Text(MSG_GRAPH_STD_OBJ_FIBOFAN)           :
      type==OBJ_FIBOARC             ? CMessage::Text(MSG_GRAPH_STD_OBJ_FIBOARC)           :
      type==OBJ_FIBOCHANNEL         ? CMessage::Text(MSG_GRAPH_STD_OBJ_FIBOCHANNEL)       :
      type==OBJ_EXPANSION           ? CMessage::Text(MSG_GRAPH_STD_OBJ_EXPANSION)         :
      type==OBJ_ELLIOTWAVE5         ? CMessage::Text(MSG_GRAPH_STD_OBJ_ELLIOTWAVE5)       :
      type==OBJ_ELLIOTWAVE3         ? CMessage::Text(MSG_GRAPH_STD_OBJ_ELLIOTWAVE3)       :
      type==OBJ_RECTANGLE           ? CMessage::Text(MSG_GRAPH_STD_OBJ_RECTANGLE)         :
      type==OBJ_TRIANGLE            ? CMessage::Text(MSG_GRAPH_STD_OBJ_TRIANGLE)          :
      type==OBJ_ELLIPSE             ? CMessage::Text(MSG_GRAPH_STD_OBJ_ELLIPSE)           :
      type==OBJ_ARROW_THUMB_UP      ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW_THUMB_UP)    :
      type==OBJ_ARROW_THUMB_DOWN    ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW_THUMB_DOWN)  :
      type==OBJ_ARROW_UP            ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW_UP)          :
      type==OBJ_ARROW_DOWN          ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW_DOWN)        :
      type==OBJ_ARROW_STOP          ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW_STOP)        :
      type==OBJ_ARROW_CHECK         ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW_CHECK)       :
      type==OBJ_ARROW_LEFT_PRICE    ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW_LEFT_PRICE)  :
      type==OBJ_ARROW_RIGHT_PRICE   ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW_RIGHT_PRICE) :
      type==OBJ_ARROW_BUY           ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW_BUY)         :
      type==OBJ_ARROW_SELL          ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW_SELL)        :
      type==OBJ_ARROW               ? CMessage::Text(MSG_GRAPH_STD_OBJ_ARROW)             :
      type==OBJ_TEXT                ? CMessage::Text(MSG_GRAPH_STD_OBJ_TEXT)              :
      type==OBJ_LABEL               ? CMessage::Text(MSG_GRAPH_STD_OBJ_LABEL)             :
      type==OBJ_BUTTON              ? CMessage::Text(MSG_GRAPH_STD_OBJ_BUTTON)            :
      type==OBJ_CHART               ? CMessage::Text(MSG_GRAPH_STD_OBJ_CHART)             :
      type==OBJ_BITMAP              ? CMessage::Text(MSG_GRAPH_STD_OBJ_BITMAP)            :
      type==OBJ_BITMAP_LABEL        ? CMessage::Text(MSG_GRAPH_STD_OBJ_BITMAP_LABEL)      :
      type==OBJ_EDIT                ? CMessage::Text(MSG_GRAPH_STD_OBJ_EDIT)              :
      type==OBJ_EVENT               ? CMessage::Text(MSG_GRAPH_STD_OBJ_EVENT)             :
      type==OBJ_RECTANGLE_LABEL     ? CMessage::Text(MSG_GRAPH_STD_OBJ_RECTANGLE_LABEL)   :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the anchor point description                              |
//| for the Arrow graphical object                                   |
//+------------------------------------------------------------------+
string AnchorForArrowObjDescription(const ENUM_ARROW_ANCHOR anchor)
  {
   return
     (
      anchor==ANCHOR_TOP      ? CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_TOP)    :
      anchor==ANCHOR_BOTTOM   ? CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_BOTTOM) :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the anchor point description for graphical objects        |
//+------------------------------------------------------------------+
string AnchorForGraphicsObjDescription(const ENUM_ANCHOR_POINT anchor)
  {
   return
     (
      anchor==ANCHOR_LEFT_UPPER  ?  CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_LEFT_UPPER)  :
      anchor==ANCHOR_LEFT        ?  CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_LEFT)        :
      anchor==ANCHOR_LEFT_LOWER  ?  CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_LEFT_LOWER)  :
      anchor==ANCHOR_LOWER       ?  CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_LOWER)       :
      anchor==ANCHOR_RIGHT_LOWER ?  CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_RIGHT_LOWER) :
      anchor==ANCHOR_RIGHT       ?  CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_RIGHT)       :
      anchor==ANCHOR_RIGHT_UPPER ?  CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_RIGHT_UPPER) :
      anchor==ANCHOR_UPPER       ?  CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_UPPER)       :
      anchor==ANCHOR_CENTER      ?  CMessage::Text(MSG_GRAPH_OBJ_TEXT_ANCHOR_CENTER)      :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the flag of displaying the graphical                      |
//| object on a specified chart timeframe                            |
//+------------------------------------------------------------------+
bool IsVisibleOnTimeframe(const ENUM_TIMEFRAMES timeframe,const int flags)
  {
   if(flags==OBJ_ALL_PERIODS)
      return true;
   if(flags==OBJ_NO_PERIODS)
      return false;
   int flag=0;
   switch((int)timeframe)
     {
      case PERIOD_M1    :  flag=0x00000001;  break;
      case PERIOD_M2    :  flag=0x00000002;  break;
      case PERIOD_M3    :  flag=0x00000004;  break;
      case PERIOD_M4    :  flag=0x00000008;  break;
      case PERIOD_M5    :  flag=0x00000010;  break;
      case PERIOD_M6    :  flag=0x00000020;  break;
      case PERIOD_M10   :  flag=0x00000040;  break;
      case PERIOD_M12   :  flag=0x00000080;  break;
      case PERIOD_M15   :  flag=0x00000100;  break;
      case PERIOD_M20   :  flag=0x00000200;  break;
      case PERIOD_M30   :  flag=0x00000400;  break;
      case PERIOD_H1    :  flag=0x00000800;  break;
      case PERIOD_H2    :  flag=0x00001000;  break;
      case PERIOD_H3    :  flag=0x00002000;  break;
      case PERIOD_H4    :  flag=0x00004000;  break;
      case PERIOD_H6    :  flag=0x00008000;  break;
      case PERIOD_H8    :  flag=0x00010000;  break;
      case PERIOD_H12   :  flag=0x00020000;  break;
      case PERIOD_D1    :  flag=0x00040000;  break;
      case PERIOD_W1    :  flag=0x00080000;  break;
      case PERIOD_MN1   :  flag=0x00100000;  break;
      default:
        break;
     }
   return((flags & flag)==flag);
  }
//+------------------------------------------------------------------+
//| Create a new standard graphical object                           |
//+------------------------------------------------------------------+
bool CreateNewStdGraphObject(const long chart_id,
                             const string name,
                             const ENUM_OBJECT type,
                             const int subwindow,
                             const datetime time1,
                             const double price1,
                             const datetime time2=0,
                             const double price2=0,
                             const datetime time3=0,
                             const double price3=0,
                             const datetime time4=0,
                             const double price4=0,
                             const datetime time5=0,
                             const double price5=0)
  {
   ::ResetLastError();
   switch(type)
     {
      //--- Lines
      case OBJ_VLINE             : return ::ObjectCreate(chart_id,name,OBJ_VLINE,subwindow,time1,0);
      case OBJ_HLINE             : return ::ObjectCreate(chart_id,name,OBJ_HLINE,subwindow,0,price1);
      case OBJ_TREND             : return ::ObjectCreate(chart_id,name,OBJ_TREND,subwindow,time1,price1,time2,price2);
      case OBJ_TRENDBYANGLE      : return ::ObjectCreate(chart_id,name,OBJ_TRENDBYANGLE,subwindow,time1,price1,time2,price2);
      case OBJ_CYCLES            : return ::ObjectCreate(chart_id,name,OBJ_CYCLES,subwindow,time1,price1,time2,price2);
      case OBJ_ARROWED_LINE      : return ::ObjectCreate(chart_id,name,OBJ_ARROWED_LINE,subwindow,time1,price1,time2,price2);
      //--- Channels
      case OBJ_CHANNEL           : return ::ObjectCreate(chart_id,name,OBJ_CHANNEL,subwindow,time1,price1,time2,price2,time3,price3);
      case OBJ_STDDEVCHANNEL     : return ::ObjectCreate(chart_id,name,OBJ_STDDEVCHANNEL,subwindow,time1,price1,time2,price2);
      case OBJ_REGRESSION        : return ::ObjectCreate(chart_id,name,OBJ_REGRESSION,subwindow,time1,price1,time2,price2);
      case OBJ_PITCHFORK         : return ::ObjectCreate(chart_id,name,OBJ_PITCHFORK,subwindow,time1,price1,time2,price2,time3,price3);
      //--- Gann
      case OBJ_GANNLINE          : return ::ObjectCreate(chart_id,name,OBJ_GANNLINE,subwindow,time1,price1,time2,price2);
      case OBJ_GANNFAN           : return ::ObjectCreate(chart_id,name,OBJ_GANNFAN,subwindow,time1,price1,time2,price2);
      case OBJ_GANNGRID          : return ::ObjectCreate(chart_id,name,OBJ_GANNGRID,subwindow,time1,price1,time2,price2);
      //--- Fibo
      case OBJ_FIBO              : return ::ObjectCreate(chart_id,name,OBJ_FIBO,subwindow,time1,price1,time2,price2);
      case OBJ_FIBOTIMES         : return ::ObjectCreate(chart_id,name,OBJ_FIBOTIMES,subwindow,time1,price1,time2,price2);
      case OBJ_FIBOFAN           : return ::ObjectCreate(chart_id,name,OBJ_FIBOFAN,subwindow,time1,price1,time2,price2);
      case OBJ_FIBOARC           : return ::ObjectCreate(chart_id,name,OBJ_FIBOARC,subwindow,time1,price1,time2,price2);
      case OBJ_FIBOCHANNEL       : return ::ObjectCreate(chart_id,name,OBJ_FIBOCHANNEL,subwindow,time1,price1,time2,price2,time3,price3);
      case OBJ_EXPANSION         : return ::ObjectCreate(chart_id,name,OBJ_EXPANSION,subwindow,time1,price1,time2,price2,time3,price3);
      //--- Elliott
      case OBJ_ELLIOTWAVE5       : return ::ObjectCreate(chart_id,name,OBJ_ELLIOTWAVE5,subwindow,time1,price1,time2,price2,time3,price3,time4,price4,time5,price5);
      case OBJ_ELLIOTWAVE3       : return ::ObjectCreate(chart_id,name,OBJ_ELLIOTWAVE3,subwindow,time1,price1,time2,price2,time3,price3);
      //--- Shapes
      case OBJ_RECTANGLE         : return ::ObjectCreate(chart_id,name,OBJ_RECTANGLE,subwindow,time1,price1,time2,price2);
      case OBJ_TRIANGLE          : return ::ObjectCreate(chart_id,name,OBJ_TRIANGLE,subwindow,time1,price1,time2,price2,time3,price3);
      case OBJ_ELLIPSE           : return ::ObjectCreate(chart_id,name,OBJ_ELLIPSE,subwindow,time1,price1,time2,price2,time3,price3);
      //--- Arrows
      case OBJ_ARROW_THUMB_UP    : return ::ObjectCreate(chart_id,name,OBJ_ARROW_THUMB_UP,subwindow,time1,price1);
      case OBJ_ARROW_THUMB_DOWN  : return ::ObjectCreate(chart_id,name,OBJ_ARROW_THUMB_DOWN,subwindow,time1,price1);
      case OBJ_ARROW_UP          : return ::ObjectCreate(chart_id,name,OBJ_ARROW_UP,subwindow,time1,price1);
      case OBJ_ARROW_DOWN        : return ::ObjectCreate(chart_id,name,OBJ_ARROW_DOWN,subwindow,time1,price1);
      case OBJ_ARROW_STOP        : return ::ObjectCreate(chart_id,name,OBJ_ARROW_STOP,subwindow,time1,price1);
      case OBJ_ARROW_CHECK       : return ::ObjectCreate(chart_id,name,OBJ_ARROW_CHECK,subwindow,time1,price1);
      case OBJ_ARROW_LEFT_PRICE  : return ::ObjectCreate(chart_id,name,OBJ_ARROW_LEFT_PRICE,subwindow,time1,price1);
      case OBJ_ARROW_RIGHT_PRICE : return ::ObjectCreate(chart_id,name,OBJ_ARROW_RIGHT_PRICE,subwindow,time1,price1);
      case OBJ_ARROW_BUY         : return ::ObjectCreate(chart_id,name,OBJ_ARROW_BUY,subwindow,time1,price1);
      case OBJ_ARROW_SELL        : return ::ObjectCreate(chart_id,name,OBJ_ARROW_SELL,subwindow,time1,price1);
      case OBJ_ARROW             : return ::ObjectCreate(chart_id,name,OBJ_ARROW,subwindow,time1,price1);
      //--- Graphical objects
      case OBJ_TEXT              : return ::ObjectCreate(chart_id,name,OBJ_TEXT,subwindow,time1,price1);
      case OBJ_LABEL             : return ::ObjectCreate(chart_id,name,OBJ_LABEL,subwindow,0,0);
      case OBJ_BUTTON            : return ::ObjectCreate(chart_id,name,OBJ_BUTTON,subwindow,0,0);
      case OBJ_CHART             : return ::ObjectCreate(chart_id,name,OBJ_CHART,subwindow,0,0);
      case OBJ_BITMAP            : return ::ObjectCreate(chart_id,name,OBJ_BITMAP,subwindow,time1,price1);
      case OBJ_BITMAP_LABEL      : return ::ObjectCreate(chart_id,name,OBJ_BITMAP_LABEL,subwindow,0,0);
      case OBJ_EDIT              : return ::ObjectCreate(chart_id,name,OBJ_EDIT,subwindow,0,0);
      case OBJ_EVENT             : return ::ObjectCreate(chart_id,name,OBJ_EVENT,subwindow,time1,0);
      case OBJ_RECTANGLE_LABEL   : return ::ObjectCreate(chart_id,name,OBJ_RECTANGLE_LABEL,subwindow,0,0);
      //---
      default: return false;
     }
  }
//+------------------------------------------------------------------+
