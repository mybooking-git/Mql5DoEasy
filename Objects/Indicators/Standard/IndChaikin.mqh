//+------------------------------------------------------------------+
//|                                                       IndCHO.mqh |
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
//| Chaikin Oscillator standard indicator                            |
//+------------------------------------------------------------------+
class CIndCHO : public CIndicatorDE
  {
private:

public:
   //--- Constructor
                     CIndCHO(const string symbol,const ENUM_TIMEFRAMES timeframe,MqlParam &mql_param[]) :
                        CIndicatorDE(IND_CHAIKIN,symbol,timeframe,
                                     INDICATOR_STATUS_STANDARD,
                                     INDICATOR_GROUP_OSCILLATOR,
                                     "Chaikin Oscillator",
                                     "CHO("+symbol+","+TimeframeDescription(timeframe)+")",mql_param) { this.m_type=OBJECT_DE_TYPE_IND_CHAIKIN; }
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
bool CIndCHO::SupportProperty(ENUM_INDICATOR_PROP_INTEGER property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if the indicator supports the passed               |
//| real property, otherwise return 'false'                          |
//+------------------------------------------------------------------+
bool CIndCHO::SupportProperty(ENUM_INDICATOR_PROP_DOUBLE property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Display a short description of indicator object in the journal   |
//+------------------------------------------------------------------+
void CIndCHO::PrintShort(void)
  {
   string id=(this.ID()>WRONG_VALUE ? ", id #"+(string)this.ID()+"]" : "]");
   ::Print(GetStatusDescription()," ",this.Name()," ",this.Symbol()," ",TimeframeDescription(this.Timeframe())," [handle ",this.Handle(),id);
  }
//+------------------------------------------------------------------+
//| Display parameter description of indicator object in the journal |
//+------------------------------------------------------------------+
void CIndCHO::PrintParameters(void)
  {
   ::Print(" --- ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_IND_PARAMETERS)," --- ");
   //--- fast_ma_period
   ::Print(" - ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_FAST_PERIOD),": ",(string)m_mql_param[0].integer_value);
   //--- slow_ma_period
   ::Print(" - ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_SLOW_PERIOD),": ",(string)m_mql_param[1].integer_value);
   //--- ma_method
   ::Print(" - ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_MA_METHOD),": ",AveragingMethodDescription((ENUM_MA_METHOD)m_mql_param[2].integer_value));
   //--- applied_volume
   ::Print(" - ",CMessage::Text(MSG_LIB_TEXT_IND_TEXT_APPLIED_VOLUME),": ",AppliedVolumeDescription((ENUM_APPLIED_VOLUME)m_mql_param[3].integer_value));
  }
//+------------------------------------------------------------------+
