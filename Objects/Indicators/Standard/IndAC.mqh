//+------------------------------------------------------------------+
//|                                                        IndAC.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "..\\IndicatorDE.mqh"
//+------------------------------------------------------------------+
//| Accelerator Oscillator standard indicator                        |
//+------------------------------------------------------------------+
class CIndAC : public CIndicatorDE
  {
private:

public:
   //--- Constructor
                     CIndAC(const string symbol,const ENUM_TIMEFRAMES timeframe,MqlParam &mql_param[]) : 
                        CIndicatorDE(IND_AC,symbol,timeframe,
                                     INDICATOR_STATUS_STANDARD,
                                     INDICATOR_GROUP_OSCILLATOR,
                                     "Accelerator Oscillator",
                                     "AC("+symbol+","+TimeframeDescription(timeframe)+")",mql_param) { this.m_type=OBJECT_DE_TYPE_IND_AC; }
   //--- Supported indicator properties (1) real, (2) integer
   virtual bool      SupportProperty(ENUM_INDICATOR_PROP_DOUBLE property);
   virtual bool      SupportProperty(ENUM_INDICATOR_PROP_INTEGER property);

//--- Display (1) a short description, (2) description of indicator object parameters in the journal
   virtual void      PrintShort(void);
   virtual void      PrintParameters(void) {;}
  };
//+------------------------------------------------------------------+
//| Return 'true' if the indicator supports the passed               |
//| integer property, otherwise return 'false'                       |
//+------------------------------------------------------------------+
bool CIndAC::SupportProperty(ENUM_INDICATOR_PROP_INTEGER property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if the indicator supports the passed               |
//| real property, otherwise return 'false'                          |
//+------------------------------------------------------------------+
bool CIndAC::SupportProperty(ENUM_INDICATOR_PROP_DOUBLE property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Display a short description of indicator object in the journal   |
//+------------------------------------------------------------------+
void CIndAC::PrintShort(void)
  {
   string id=(this.ID()>WRONG_VALUE ? ", id #"+(string)this.ID()+"]" : "]");
   ::Print(GetStatusDescription()," ",this.Name()," ",this.Symbol()," ",TimeframeDescription(this.Timeframe())," [handle ",this.Handle(),id);
  }
//+------------------------------------------------------------------+
