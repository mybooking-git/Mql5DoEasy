//+------------------------------------------------------------------+
//|                                                   NewTickObj.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
#property strict    // Necessary for mql4
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "..\..\Objects\BaseObj.mqh"
//+------------------------------------------------------------------+
//| "New tick" class                                                 |
//+------------------------------------------------------------------+
class CNewTickObj : public CBaseObj
  {
private:
   MqlTick           m_tick;                          // Structure of the current prices
   MqlTick           m_tick_prev;                     // Structure of the current prices during the previous check
   string            m_symbol;                        // Object symbol
   bool              m_new_tick;                      // New tick flag
public:
//--- Set a symbol
   void              SetSymbol(const string symbol)   { this.m_symbol=(symbol==NULL || symbol=="" ? ::Symbol() : symbol);  }
//--- Return the new tick flag
   bool              IsNewTick(void);
//--- Update price data in the tick structure and set the "New tick" event flag if necessary
   void              Refresh(void)                    { this.m_new_tick=this.IsNewTick(); }
//--- Constructors
                     CNewTickObj(void){ this.m_type=OBJECT_DE_TYPE_NEW_TICK; }
                     CNewTickObj(const string symbol);
  };
//+------------------------------------------------------------------+
//| CNewTickObj parametric constructor                               |
//+------------------------------------------------------------------+
CNewTickObj::CNewTickObj(const string symbol) : m_symbol(symbol),m_new_tick(false)
  {
   this.m_type=OBJECT_DE_TYPE_NEW_TICK; 
//--- Reset the structures of the new and previous ticks
   ::ZeroMemory(this.m_tick);
   ::ZeroMemory(this.m_tick_prev);
//--- If managed to get the current prices to the tick structure,
//--- copy data of the obtained tick to the previous tick data and reset the first launch flag
  if(::SymbolInfoTick(this.m_symbol,this.m_tick))
     { 
      this.m_tick_prev=this.m_tick;
      this.m_first_start=false;
     }
  }
//+------------------------------------------------------------------+
//| Return the new tick flag                                         |
//+------------------------------------------------------------------+
bool CNewTickObj::IsNewTick(void)
  {
//--- If failed to get the current prices to the tick structure, return 'false'
   if(!::SymbolInfoTick(this.m_symbol,this.m_tick))
      return false;
//--- If this is the first launch, copy data of the obtained tick to the previous tick data
//--- reset the first launch flag and return 'false'
   if(this.m_first_start)
     {
      this.m_tick_prev=this.m_tick;
      this.m_first_start=false;
      return false;
     }
//--- If the time of a new tick is not equal to the time of a tick during the previous check -
//--- copy data of the obtained tick to the previous tick data and return 'true'
   if(this.m_tick.time_msc!=this.m_tick_prev.time_msc)
     {
      this.m_tick_prev=this.m_tick;
      return true;
     }
//--- In all other cases, return 'false'
   return false;
  }
//+------------------------------------------------------------------+
