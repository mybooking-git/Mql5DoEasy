//+------------------------------------------------------------------+
//|                                                     IndBands.mqh |
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
//| Bollinger Bands® standard indicator                              |
//+------------------------------------------------------------------+
class CIndBands : public CIndicatorDE 
  {
private:

public:
   //--- Constructor
                     CIndBands(const string symbol,const ENUM_TIMEFRAMES timeframe,MqlParam &mql_param[]) :
                        CIndicatorDE(IND_BANDS,symbol,timeframe,
                                     INDICATOR_STATUS_STANDARD,
                                     INDICATOR_GROUP_TREND,
                                     "Bollinger Bands",
                                     "Bands("+symbol+","+TimeframeDescription(timeframe)+")",mql_param) { this.m_type=OBJECT_DE_TYPE_IND_BANDS; }
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
bool CIndBands::SupportProperty(ENUM_INDICATOR_PROP_INTEGER property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if the indicator supports the passed               |
//| real property, otherwise return 'false'                          |
//+------------------------------------------------------------------+
bool CIndBands::SupportProperty(ENUM_INDICATOR_PROP_DOUBLE property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Display a short description of indicator object in the journal   |
//+------------------------------------------------------------------+
void CIndBands::PrintShort(void)
  {
   string id=(this.ID()>WRONG_VALUE ? ", id #"+(string)this.ID()+"]" : "]");
   ::Print(GetStatusDescription()," ",this.Name()," ",this.Symbol()," ",TimeframeDescription(this.Timeframe())," [handle ",this.Handle(),id);
  }
//+------------------------------------------------------------------+
//| Display parameter description of indicator object in the journal |
//+------------------------------------------------------------------+
void CIndBands::PrintParameters(void)
  {
   ::Print(" --- ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_IND_PARAMETERS)," --- ");
   //--- bands_period
   ::Print(" - ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_PERIOD),": ",(string)m_mql_param[0].integer_value);
   //--- bands_shift
   ::Print(" - ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_SHIFT),": ",(string)m_mql_param[1].integer_value);
   //--- deviation
   ::Print(" - ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_STD_DEVIATION),": ",::DoubleToString(m_mql_param[2].integer_value),3);
   //--- applied_price
   ::Print(
           " - ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_APPLIED_PRICE),": ",
           (m_mql_param[3].integer_value<10 ? AppliedPriceDescription((ENUM_APPLIED_PRICE)m_mql_param[3].integer_value) : (string)m_mql_param[3].integer_value)
          );
  }
//+------------------------------------------------------------------+
