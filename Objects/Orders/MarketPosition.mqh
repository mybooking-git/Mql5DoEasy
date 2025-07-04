//+------------------------------------------------------------------+
//|                                               MarketPosition.mqh |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "Order.mqh"
//+------------------------------------------------------------------+
//| Market position                                                  |
//+------------------------------------------------------------------+
class CMarketPosition : public COrder
  {
public:
   //--- Constructor
                     CMarketPosition(const ulong ticket=0) : COrder(ORDER_STATUS_MARKET_POSITION,ticket) { this.m_type=OBJECT_DE_TYPE_MARKET_POSITION; }
   //--- Supported position properties (1) real, (2) integer
   virtual bool      SupportProperty(ENUM_ORDER_PROP_INTEGER property);
   virtual bool      SupportProperty(ENUM_ORDER_PROP_DOUBLE property);
   virtual bool      SupportProperty(ENUM_ORDER_PROP_STRING property);
  };
//+------------------------------------------------------------------+
//| Return 'true' if a position supports a passed                    |
//| integer property, otherwise return 'false'                       |
//+------------------------------------------------------------------+
bool CMarketPosition::SupportProperty(ENUM_ORDER_PROP_INTEGER property)
  {
   if(property==ORDER_PROP_TIME_CLOSE        || 
      property==ORDER_PROP_TIME_EXP          ||
      property==ORDER_PROP_POSITION_BY_ID    ||
      property==ORDER_PROP_DEAL_ENTRY        ||
      property==ORDER_PROP_STATE             ||
      property==ORDER_PROP_CLOSE_BY_SL       ||
      property==ORDER_PROP_CLOSE_BY_TP       ||
      property==ORDER_PROP_DEAL_ORDER_TICKET
   #ifdef __MQL5__                           ||
      property==ORDER_PROP_TICKET_FROM       ||
      property==ORDER_PROP_TICKET_TO
   #endif 
     ) return false;
   return true;
}
//+------------------------------------------------------------------+
//| Return 'true' if a position supports a passed                    |
//| real property, otherwise return 'false'                          |
//+------------------------------------------------------------------+
bool CMarketPosition::SupportProperty(ENUM_ORDER_PROP_DOUBLE property)
  {
   if(property==ORDER_PROP_PRICE_CLOSE       || 
      property==ORDER_PROP_PRICE_STOP_LIMIT
   #ifdef __MQL5__                           ||
      property==ORDER_PROP_COMMISSION        ||
      property==ORDER_PROP_VOLUME_CURRENT
   #endif 
     ) return false;
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if a position supports a passed                    |
//| string property, otherwise return 'false'                        |
//+------------------------------------------------------------------+
bool CMarketPosition::SupportProperty(ENUM_ORDER_PROP_STRING property)
  {
   if(property==ORDER_PROP_EXT_ID) return false;
   return true;
  }
//+------------------------------------------------------------------+
