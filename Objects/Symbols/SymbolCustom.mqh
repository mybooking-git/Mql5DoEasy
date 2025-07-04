//+------------------------------------------------------------------+
//|                                                 SymbolCustom.mqh |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "Symbol.mqh"
//+------------------------------------------------------------------+
//| Custom symbol                                                    |
//+------------------------------------------------------------------+
class CSymbolCustom : public CSymbol
  {
public:
//--- Constructor
                     CSymbolCustom(const string name,const int index) : CSymbol(SYMBOL_STATUS_CUSTOM,name,index)
                        { this.m_type=OBJECT_DE_TYPE_SYMBOL_CUSTOM; }
//--- Supported integer properties of a symbol
   virtual bool      SupportProperty(ENUM_SYMBOL_PROP_INTEGER property);
//--- Supported real properties of a symbol
   virtual bool      SupportProperty(ENUM_SYMBOL_PROP_DOUBLE property);
//--- Supported string properties of a symbol
   virtual bool      SupportProperty(ENUM_SYMBOL_PROP_STRING property);
//--- Display a short symbol description in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
  };
//+------------------------------------------------------------------+
//| Return 'true' if a symbol supports a passed                      |
//| integer property, otherwise return 'false'                       |
//+------------------------------------------------------------------+
bool CSymbolCustom::SupportProperty(ENUM_SYMBOL_PROP_INTEGER property)
  {
   if(property==SYMBOL_PROP_EXIST) return false;
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if a symbol supports a passed                      |
//| real property, otherwise return 'false'                          |
//+------------------------------------------------------------------+
bool CSymbolCustom::SupportProperty(ENUM_SYMBOL_PROP_DOUBLE property)
  {
   if(
      (this.ChartMode()==SYMBOL_CHART_MODE_BID     && 
        (
         property==SYMBOL_PROP_LAST                ||
         property==SYMBOL_PROP_LASTHIGH            ||
         property==SYMBOL_PROP_LASTLOW
        )
      )                                            ||
      (this.ChartMode()==SYMBOL_CHART_MODE_LAST    && 
        (
         property==SYMBOL_PROP_BID                 ||
         property==SYMBOL_PROP_BIDHIGH             ||
         property==SYMBOL_PROP_BIDLOW              ||
         property==SYMBOL_PROP_ASK                 ||
         property==SYMBOL_PROP_ASKHIGH             ||
         property==SYMBOL_PROP_ASKLOW
        )
      )
     ) return false;
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if a symbol supports a passed                      |
//| string property, otherwise return 'false'                        |
//+------------------------------------------------------------------+
bool CSymbolCustom::SupportProperty(ENUM_SYMBOL_PROP_STRING property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Display a short symbol description in the journal                |
//+------------------------------------------------------------------+
void CSymbolCustom::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print(this.GetStatusDescription()+" "+this.Name());
  }
//+------------------------------------------------------------------+
