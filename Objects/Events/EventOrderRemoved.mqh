//+------------------------------------------------------------------+
//|                                            EventOrderRemoved.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "Event.mqh"
//+------------------------------------------------------------------+
//| Pending order removal event                                      |
//+------------------------------------------------------------------+
class CEventOrderRemoved : public CEvent
  {
public:
//--- Constructor
                     CEventOrderRemoved(const int event_code,const ulong ticket=0) : CEvent(EVENT_STATUS_HISTORY_PENDING,event_code,ticket)
                       { this.m_type=OBJECT_DE_TYPE_EVENT_ORDER_REMOVED; }
//--- Supported order properties (1) real, (2) integer
   virtual bool      SupportProperty(ENUM_EVENT_PROP_INTEGER property);
   virtual bool      SupportProperty(ENUM_EVENT_PROP_DOUBLE property);
//--- (1) Display a brief message about the event in the journal, (2) Send the event to the chart
   virtual void      PrintShort(void);
   virtual void      SendEvent(void);
  };
//+------------------------------------------------------------------+
//| Return 'true' if the event supports the passed                   |
//| integer property, otherwise return 'false'                       |
//+------------------------------------------------------------------+
bool CEventOrderRemoved::SupportProperty(ENUM_EVENT_PROP_INTEGER property)
  {
   if(property==EVENT_PROP_TYPE_DEAL_EVENT         ||
      property==EVENT_PROP_TICKET_DEAL_EVENT       ||
      property==EVENT_PROP_TYPE_ORDER_POSITION     ||
      property==EVENT_PROP_TICKET_ORDER_POSITION   ||
      property==EVENT_PROP_TIME_ORDER_POSITION
     ) return false;
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if the event supports the passed                   |
//| real property, otherwise return 'false'                          |
//+------------------------------------------------------------------+
bool CEventOrderRemoved::SupportProperty(ENUM_EVENT_PROP_DOUBLE property)
  {
   return(property==EVENT_PROP_PROFIT ? false : true);
  }
//+------------------------------------------------------------------+
//| Display a brief message about the event in the journal           |
//+------------------------------------------------------------------+
void CEventOrderRemoved::PrintShort(void)
  {
   string head="- "+this.TypeEventDescription()+": "+TimeMSCtoString(this.TimePosition())+" -\n";
   string sl=(this.PriceStopLoss()>0 ? ", sl "+::DoubleToString(this.PriceStopLoss(),this.m_digits) : "");
   string tp=(this.PriceTakeProfit()>0 ? ", tp "+::DoubleToString(this.PriceTakeProfit(),this.m_digits) : "");
   string vol=::DoubleToString(this.VolumeOrderInitial(),DigitsLots(this.Symbol()));
   string magic_id=((this.GetPendReqID()>0 || this.GetGroupID1()>0 || this.GetGroupID2()>0) ? " ("+(string)this.GetMagicID()+")" : "");
   string group_id1=(this.GetGroupID1()>0 ? ", G1: "+(string)this.GetGroupID1() : "");
   string group_id2=(this.GetGroupID2()>0 ? ", G2: "+(string)this.GetGroupID2() : "");
   string pend_req_id=(this.GetPendReqID()>0 ? ", ID: "+(string)this.GetPendReqID() : "");
   string magic=(this.Magic()!=0 ? ", "+CMessage::Text(MSG_ORD_MAGIC)+" "+(string)this.Magic()+magic_id+group_id1+group_id2+pend_req_id : "");
   string type=this.TypeOrderFirstDescription()+" #"+(string)this.TicketOrderEvent();
   string price=" "+CMessage::Text(MSG_LIB_TEXT_AT_PRICE)+" "+::DoubleToString(this.PriceOpen(),this.m_digits);
   string txt=head+this.Symbol()+" "+CMessage::Text(MSG_LIB_TEXT_DELETED)+" "+vol+" "+type+price+sl+tp+magic;
   ::Print(txt);
  }
//+------------------------------------------------------------------+
//| Send the event to the chart                                      |
//+------------------------------------------------------------------+
void CEventOrderRemoved::SendEvent(void)
  {
   this.PrintShort();
   ::EventChartCustom(this.m_chart_id_main,(ushort)this.m_trade_event,this.TicketOrderEvent(),this.PriceOpen(),this.Symbol());
  }
//+------------------------------------------------------------------+
