//+------------------------------------------------------------------+
//|                                                    IndCustom.mqh |
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
//| Custom indicator                                                 |
//+------------------------------------------------------------------+
class CIndCustom : public CIndicatorDE 
  {
private:

public:
   //--- Constructor
                     CIndCustom(const string symbol,const ENUM_TIMEFRAMES timeframe,MqlParam &mql_param[]) :
                        CIndicatorDE(IND_CUSTOM,symbol,timeframe,
                                     INDICATOR_STATUS_CUSTOM,
                                     INDICATOR_GROUP_ANY,
                                     mql_param[0].string_value,
                                     mql_param[0].string_value+"("+(symbol==NULL || symbol=="" ? ::Symbol() : symbol)+
                                                               ","+TimeframeDescription(timeframe)+")",mql_param) { this.m_type=OBJECT_DE_TYPE_IND_CUSTOM; }
   //--- Supported indicator properties (1) real, (2) integer
   virtual bool      SupportProperty(ENUM_INDICATOR_PROP_DOUBLE property);
   virtual bool      SupportProperty(ENUM_INDICATOR_PROP_INTEGER property);
   
//--- Display (1) a short description, (2) description of indicator object parameters in the journal
   virtual void      PrintShort(void);
   virtual void      PrintParameters(void);
  };
//+------------------------------------------------------------------+
//| Return 'true' if the indicator supports the passed               |
//| integer property, otherwise return 'false'                       |
//+------------------------------------------------------------------+
bool CIndCustom::SupportProperty(ENUM_INDICATOR_PROP_INTEGER property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if the indicator supports the passed               |
//| real property, otherwise return 'false'                          |
//+------------------------------------------------------------------+
bool CIndCustom::SupportProperty(ENUM_INDICATOR_PROP_DOUBLE property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Display a short description of indicator object in the journal   |
//+------------------------------------------------------------------+
void CIndCustom::PrintShort(void)
  {
   string id=(this.ID()>WRONG_VALUE ? ", id #"+(string)this.ID()+"]" : "]");
   ::Print(GetStatusDescription()," ",this.Name()," ",this.Symbol()," ",TimeframeDescription(this.Timeframe())," [handle ",this.Handle(),id);
  }
//+------------------------------------------------------------------+
//| Display parameter description of indicator object in the journal |
//+------------------------------------------------------------------+
void CIndCustom::PrintParameters(void)
  {
   ::Print(" --- ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_IND_PARAMETERS)," --- ");
   
   int total=::ArraySize(this.m_mql_param);
   for(int i=1;i<total;i++)
     {
      ::Print(" - ",this.GetMqlParamDescription(i));
     }
  }
//+------------------------------------------------------------------+
