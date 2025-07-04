//+------------------------------------------------------------------+
//|                                                       Select.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include <Arrays\ArrayObj.mqh>
#include "..\Objects\Orders\Order.mqh"
#include "..\Objects\Events\Event.mqh"
#include "..\Objects\Accounts\Account.mqh"
#include "..\Objects\Symbols\Symbol.mqh"
#include "..\Objects\PendRequest\PendRequest.mqh"
#include "..\Objects\Series\SeriesDE.mqh"
#include "..\Objects\Indicators\Buffer.mqh"
#include "..\Objects\Indicators\IndicatorDE.mqh"
#include "..\Objects\Indicators\DataInd.mqh"
#include "..\Objects\Ticks\DataTick.mqh"
#include "..\Objects\Book\MarketBookOrd.mqh"
#include "..\Objects\MQLSignalBase\MQLSignal.mqh"
#include "..\Objects\Chart\ChartObj.mqh"
#include "..\Objects\Graph\GCnvElement.mqh"
#include "..\Objects\Graph\Standard\GStdGraphObj.mqh"
//+------------------------------------------------------------------+
//| Storage list                                                     |
//+------------------------------------------------------------------+
CArrayObj   ListStorage; // Storage object for storing sorted collection lists
//+------------------------------------------------------------------+
//| Class for sorting objects meeting the criterion                  |
//+------------------------------------------------------------------+
class CSelect
  {
private:
   //--- Method for comparing two values
   template<typename T>
   static bool       CompareValues(T value1,T value2,ENUM_COMPARER_TYPE mode);
public:
//+------------------------------------------------------------------+
//| Methods of working with orders                                   |
//+------------------------------------------------------------------+
   //--- Return the list of orders with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByOrderProperty(CArrayObj *list_source,ENUM_ORDER_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByOrderProperty(CArrayObj *list_source,ENUM_ORDER_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByOrderProperty(CArrayObj *list_source,ENUM_ORDER_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the order index with the maximum value of the order's (1) integer, (2) real and (3) string properties
   static int        FindOrderMax(CArrayObj *list_source,ENUM_ORDER_PROP_INTEGER property);
   static int        FindOrderMax(CArrayObj *list_source,ENUM_ORDER_PROP_DOUBLE property);
   static int        FindOrderMax(CArrayObj *list_source,ENUM_ORDER_PROP_STRING property);
   //--- Return the order index with the minimum value of the order's (1) integer, (2) real and (3) string properties
   static int        FindOrderMin(CArrayObj *list_source,ENUM_ORDER_PROP_INTEGER property);
   static int        FindOrderMin(CArrayObj *list_source,ENUM_ORDER_PROP_DOUBLE property);
   static int        FindOrderMin(CArrayObj *list_source,ENUM_ORDER_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with events                                   |
//+------------------------------------------------------------------+
   //--- Return the list of events with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByEventProperty(CArrayObj *list_source,ENUM_EVENT_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByEventProperty(CArrayObj *list_source,ENUM_EVENT_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByEventProperty(CArrayObj *list_source,ENUM_EVENT_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the event index with the maximum value of the event's (1) integer, (2) real and (3) string properties
   static int        FindEventMax(CArrayObj *list_source,ENUM_EVENT_PROP_INTEGER property);
   static int        FindEventMax(CArrayObj *list_source,ENUM_EVENT_PROP_DOUBLE property);
   static int        FindEventMax(CArrayObj *list_source,ENUM_EVENT_PROP_STRING property);
   //--- Return the event index with the minimum value of the event's (1) integer, (2) real and (3) string properties
   static int        FindEventMin(CArrayObj *list_source,ENUM_EVENT_PROP_INTEGER property);
   static int        FindEventMin(CArrayObj *list_source,ENUM_EVENT_PROP_DOUBLE property);
   static int        FindEventMin(CArrayObj *list_source,ENUM_EVENT_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with accounts                                 |
//+------------------------------------------------------------------+
   //--- Return the list of accounts with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByAccountProperty(CArrayObj *list_source,ENUM_ACCOUNT_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByAccountProperty(CArrayObj *list_source,ENUM_ACCOUNT_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByAccountProperty(CArrayObj *list_source,ENUM_ACCOUNT_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the account index with the maximum value of the account (1) integer, (2) real and (3) string properties
   static int        FindAccountMax(CArrayObj *list_source,ENUM_ACCOUNT_PROP_INTEGER property);
   static int        FindAccountMax(CArrayObj *list_source,ENUM_ACCOUNT_PROP_DOUBLE property);
   static int        FindAccountMax(CArrayObj *list_source,ENUM_ACCOUNT_PROP_STRING property);
   //--- Return the account index with the minimum value of the account (1) integer, (2) real and (3) string properties
   static int        FindAccountMin(CArrayObj *list_source,ENUM_ACCOUNT_PROP_INTEGER property);
   static int        FindAccountMin(CArrayObj *list_source,ENUM_ACCOUNT_PROP_DOUBLE property);
   static int        FindAccountMin(CArrayObj *list_source,ENUM_ACCOUNT_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with symbols                                  |
//+------------------------------------------------------------------+
   //--- Return the list of symbols with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *BySymbolProperty(CArrayObj *list_source,ENUM_SYMBOL_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *BySymbolProperty(CArrayObj *list_source,ENUM_SYMBOL_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *BySymbolProperty(CArrayObj *list_source,ENUM_SYMBOL_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the symbol index with the maximum value of the symbol's (1) integer, (2) real and (3) string properties
   static int        FindSymbolMax(CArrayObj *list_source,ENUM_SYMBOL_PROP_INTEGER property);
   static int        FindSymbolMax(CArrayObj *list_source,ENUM_SYMBOL_PROP_DOUBLE property);
   static int        FindSymbolMax(CArrayObj *list_source,ENUM_SYMBOL_PROP_STRING property);
   //--- Return the symbol index with the minimum value of the symbol's (1) integer, (2) real and (3) string properties
   static int        FindSymbolMin(CArrayObj *list_source,ENUM_SYMBOL_PROP_INTEGER property);
   static int        FindSymbolMin(CArrayObj *list_source,ENUM_SYMBOL_PROP_DOUBLE property);
   static int        FindSymbolMin(CArrayObj *list_source,ENUM_SYMBOL_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with pending requests                         |
//+------------------------------------------------------------------+
   //--- Return the list of pending requests with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByPendReqProperty(CArrayObj *list_source,ENUM_PEND_REQ_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByPendReqProperty(CArrayObj *list_source,ENUM_PEND_REQ_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByPendReqProperty(CArrayObj *list_source,ENUM_PEND_REQ_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the pending request index with the maximum value of the pending request's (1) integer, (2) real and (3) string properties
   static int        FindPendReqMax(CArrayObj *list_source,ENUM_PEND_REQ_PROP_INTEGER property);
   static int        FindPendReqMax(CArrayObj *list_source,ENUM_PEND_REQ_PROP_DOUBLE property);
   static int        FindPendReqMax(CArrayObj *list_source,ENUM_PEND_REQ_PROP_STRING property);
   //--- Return the pending request index with the minimum value of the pending request's (1) integer, (2) real and (3) string properties
   static int        FindPendReqMin(CArrayObj *list_source,ENUM_PEND_REQ_PROP_INTEGER property);
   static int        FindPendReqMin(CArrayObj *list_source,ENUM_PEND_REQ_PROP_DOUBLE property);
   static int        FindPendReqMin(CArrayObj *list_source,ENUM_PEND_REQ_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with timeseries bars                          |
//+------------------------------------------------------------------+
   //--- Return the list of bars with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByBarProperty(CArrayObj *list_source,ENUM_BAR_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByBarProperty(CArrayObj *list_source,ENUM_BAR_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByBarProperty(CArrayObj *list_source,ENUM_BAR_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the bar index in the list with the maximum value of the bar's (1) integer, (2) real and (3) string properties
   static int        FindBarMax(CArrayObj *list_source,ENUM_BAR_PROP_INTEGER property);
   static int        FindBarMax(CArrayObj *list_source,ENUM_BAR_PROP_DOUBLE property);
   static int        FindBarMax(CArrayObj *list_source,ENUM_BAR_PROP_STRING property);
   //--- Return the bar index in the list with the minimum value of the bar's (1) integer, (2) real and (3) string properties
   static int        FindBarMin(CArrayObj *list_source,ENUM_BAR_PROP_INTEGER property);
   static int        FindBarMin(CArrayObj *list_source,ENUM_BAR_PROP_DOUBLE property);
   static int        FindBarMin(CArrayObj *list_source,ENUM_BAR_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with indicator buffers                        |
//+------------------------------------------------------------------+
   //--- Return the list of buffers with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByBufferProperty(CArrayObj *list_source,ENUM_BUFFER_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByBufferProperty(CArrayObj *list_source,ENUM_BUFFER_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByBufferProperty(CArrayObj *list_source,ENUM_BUFFER_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the buffer index in the list with the maximum value of the buffer's (1) integer, (2) real and (3) string properties
   static int        FindBufferMax(CArrayObj *list_source,ENUM_BUFFER_PROP_INTEGER property);
   static int        FindBufferMax(CArrayObj *list_source,ENUM_BUFFER_PROP_DOUBLE property);
   static int        FindBufferMax(CArrayObj *list_source,ENUM_BUFFER_PROP_STRING property);
   //--- Return the buffer index in the list with the minimum value of the buffer's (1) integer, (2) real and (3) string properties
   static int        FindBufferMin(CArrayObj *list_source,ENUM_BUFFER_PROP_INTEGER property);
   static int        FindBufferMin(CArrayObj *list_source,ENUM_BUFFER_PROP_DOUBLE property);
   static int        FindBufferMin(CArrayObj *list_source,ENUM_BUFFER_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with indicators                               |
//+------------------------------------------------------------------+
   //--- Return the list of indicators with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByIndicatorProperty(CArrayObj *list_source,ENUM_INDICATOR_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByIndicatorProperty(CArrayObj *list_source,ENUM_INDICATOR_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByIndicatorProperty(CArrayObj *list_source,ENUM_INDICATOR_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the indicator index in the list with the maximum value of the indicator's (1) integer, (2) real and (3) string property
   static int        FindIndicatorMax(CArrayObj *list_source,ENUM_INDICATOR_PROP_INTEGER property);
   static int        FindIndicatorMax(CArrayObj *list_source,ENUM_INDICATOR_PROP_DOUBLE property);
   static int        FindIndicatorMax(CArrayObj *list_source,ENUM_INDICATOR_PROP_STRING property);
   //--- Return the indicator index in the list with the minimum value of the indicator's (1) integer, (2) real and (3) string property
   static int        FindIndicatorMin(CArrayObj *list_source,ENUM_INDICATOR_PROP_INTEGER property);
   static int        FindIndicatorMin(CArrayObj *list_source,ENUM_INDICATOR_PROP_DOUBLE property);
   static int        FindIndicatorMin(CArrayObj *list_source,ENUM_INDICATOR_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of work with indicator data                              |
//+------------------------------------------------------------------+
   //--- Return the list of indicator data with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByIndicatorDataProperty(CArrayObj *list_source,ENUM_IND_DATA_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByIndicatorDataProperty(CArrayObj *list_source,ENUM_IND_DATA_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByIndicatorDataProperty(CArrayObj *list_source,ENUM_IND_DATA_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the indicator data index in the list with the maximum value of (1) integer, (2) real and (3) string property of data
   static int        FindIndDataMax(CArrayObj *list_source,ENUM_IND_DATA_PROP_INTEGER property);
   static int        FindIndDataMax(CArrayObj *list_source,ENUM_IND_DATA_PROP_DOUBLE property);
   static int        FindIndDataMax(CArrayObj *list_source,ENUM_IND_DATA_PROP_STRING property);
   //--- Return the indicator data index in the list with the minimum value of (1) integer, (2) real and (3) string property of data
   static int        FindIndDataMin(CArrayObj *list_source,ENUM_IND_DATA_PROP_INTEGER property);
   static int        FindIndDataMin(CArrayObj *list_source,ENUM_IND_DATA_PROP_DOUBLE property);
   static int        FindIndDataMin(CArrayObj *list_source,ENUM_IND_DATA_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with tick data                                |
//+------------------------------------------------------------------+
   //--- Return the list of tick data with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByTickDataProperty(CArrayObj *list_source,ENUM_TICK_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByTickDataProperty(CArrayObj *list_source,ENUM_TICK_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByTickDataProperty(CArrayObj *list_source,ENUM_TICK_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the tick data index in the list with the maximum value of (1) integer, (2) real and (3) string property of data
   static int        FindTickDataMax(CArrayObj *list_source,ENUM_TICK_PROP_INTEGER property);
   static int        FindTickDataMax(CArrayObj *list_source,ENUM_TICK_PROP_DOUBLE property);
   static int        FindTickDataMax(CArrayObj *list_source,ENUM_TICK_PROP_STRING property);
   //--- Return the tick data index in the list with the minimum value of (1) integer, (2) real and (3) string property of data
   static int        FindTickDataMin(CArrayObj *list_source,ENUM_TICK_PROP_INTEGER property);
   static int        FindTickDataMin(CArrayObj *list_source,ENUM_TICK_PROP_DOUBLE property);
   static int        FindTickDataMin(CArrayObj *list_source,ENUM_TICK_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with DOM data                                 |
//+------------------------------------------------------------------+
   //--- Return the list of DOM data with one out of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByMBookProperty(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByMBookProperty(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByMBookProperty(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the DOM data index in the list with the maximum value of (1) integer, (2) real and (3) string property of data
   static int        FindMBookMax(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_INTEGER property);
   static int        FindMBookMax(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_DOUBLE property);
   static int        FindMBookMax(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_STRING property);
   //--- Return the DOM data index in the list with the minimum value of (1) integer, (2) real and (3) string property of data
   static int        FindMBookMin(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_INTEGER property);
   static int        FindMBookMin(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_DOUBLE property);
   static int        FindMBookMin(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with MQL5 signal data                         |
//+------------------------------------------------------------------+
   //--- Return the list of MQL5 signals with one of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByMQLSignalProperty(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByMQLSignalProperty(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByMQLSignalProperty(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the MQL5 signal index in the list with the maximum value of the (1) integer, (2) real and (3) string properties
   static int        FindMQLSignalMax(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_INTEGER property);
   static int        FindMQLSignalMax(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_DOUBLE property);
   static int        FindMQLSignalMax(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_STRING property);
   //--- Return the MQL5 signal in the list with the minimum value of (1) integer, (2) real and (3) string property
   static int        FindMQLSignalMin(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_INTEGER property);
   static int        FindMQLSignalMin(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_DOUBLE property);
   static int        FindMQLSignalMin(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with chart data                               |
//+------------------------------------------------------------------+
   //--- Return the list of charts with one of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByChartProperty(CArrayObj *list_source,ENUM_CHART_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByChartProperty(CArrayObj *list_source,ENUM_CHART_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByChartProperty(CArrayObj *list_source,ENUM_CHART_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the chart index with the maximum value of the (1) integer, (2) real and (3) string properties
   static int        FindChartMax(CArrayObj *list_source,ENUM_CHART_PROP_INTEGER property);
   static int        FindChartMax(CArrayObj *list_source,ENUM_CHART_PROP_DOUBLE property);
   static int        FindChartMax(CArrayObj *list_source,ENUM_CHART_PROP_STRING property);
   //--- Return the chart index with the minimum value of the (1) integer, (2) real and (3) string properties
   static int        FindChartMin(CArrayObj *list_source,ENUM_CHART_PROP_INTEGER property);
   static int        FindChartMin(CArrayObj *list_source,ENUM_CHART_PROP_DOUBLE property);
   static int        FindChartMin(CArrayObj *list_source,ENUM_CHART_PROP_STRING property);
//+----------------------------------------------------------------------------+
//| The methods of working with data of the graphical elements on the canvas   |
//+----------------------------------------------------------------------------+
   //--- Return the list of objects with one of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByGraphCanvElementProperty(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByGraphCanvElementProperty(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByGraphCanvElementProperty(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the graphical element index in the list with the maximum value of the (1) integer, (2) real and (3) string properties
   static int        FindGraphCanvElementMax(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_INTEGER property);
   static int        FindGraphCanvElementMax(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_DOUBLE property);
   static int        FindGraphCanvElementMax(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_STRING property);
   //--- Return the graphical element index in the list with the minimum value of the (1) integer, (2) real and (3) string properties
   static int        FindGraphCanvElementMin(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_INTEGER property);
   static int        FindGraphCanvElementMin(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_DOUBLE property);
   static int        FindGraphCanvElementMin(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_STRING property);
//+------------------------------------------------------------------+
//| Methods of working with standard graphical object data           |
//+------------------------------------------------------------------+
   //--- Return the list of objects with one of (1) integer, (2) real and (3) string properties meeting a specified criterion
   static CArrayObj *ByGraphicStdObjectProperty(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_INTEGER property,int index,long value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByGraphicStdObjectProperty(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index,double value,ENUM_COMPARER_TYPE mode);
   static CArrayObj *ByGraphicStdObjectProperty(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_STRING property,int index,string value,ENUM_COMPARER_TYPE mode);
   //--- Return the graphical object index in the list with the maximum value of the (1) integer, (2) real and (3) string properties
   static int        FindGraphicStdObjectMax(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_INTEGER property,int index);
   static int        FindGraphicStdObjectMax(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index);
   static int        FindGraphicStdObjectMax(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_STRING property,int index);
   //--- Return the graphical object index in the list with the minimum value of the (1) integer, (2) real and (3) string properties
   static int        FindGraphicStdObjectMin(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_INTEGER property,int index);
   static int        FindGraphicStdObjectMin(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index);
   static int        FindGraphicStdObjectMin(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_STRING property,int index);
//---
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Two values comparison method                                     |
//+------------------------------------------------------------------+
template<typename T>
bool CSelect::CompareValues(T value1,T value2,ENUM_COMPARER_TYPE mode)
  {
   return
     (
      mode==EQUAL && value1==value2          ?  true  :
      mode==NO_EQUAL && value1!=value2       ?  true  :
      mode==MORE && value1>value2            ?  true  :
      mode==LESS && value1<value2            ?  true  :
      mode==EQUAL_OR_MORE && value1>=value2  ?  true  :
      mode==EQUAL_OR_LESS && value1<=value2  ?  true  :  false
     );
  }
//+------------------------------------------------------------------+
//| Methods of working with order lists                              |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of orders with one integer                       |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByOrderProperty(CArrayObj *list_source,ENUM_ORDER_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      COrder *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of orders with one real                          |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByOrderProperty(CArrayObj *list_source,ENUM_ORDER_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      COrder *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of orders with one string                        |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByOrderProperty(CArrayObj *list_source,ENUM_ORDER_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      COrder *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the listed order index                                    |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindOrderMax(CArrayObj *list_source,ENUM_ORDER_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   COrder *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      COrder *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed order index                                    |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindOrderMax(CArrayObj *list_source,ENUM_ORDER_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   COrder *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      COrder *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed order index                                    |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindOrderMax(CArrayObj *list_source,ENUM_ORDER_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   COrder *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      COrder *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed order index                                    |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindOrderMin(CArrayObj* list_source,ENUM_ORDER_PROP_INTEGER property)
  {
   int index=0;
   COrder *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      COrder *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed order index                                    |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindOrderMin(CArrayObj* list_source,ENUM_ORDER_PROP_DOUBLE property)
  {
   int index=0;
   COrder *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      COrder *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed order index                                    |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindOrderMin(CArrayObj* list_source,ENUM_ORDER_PROP_STRING property)
  {
   int index=0;
   COrder *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      COrder *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with event lists                              |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of events with one integer                       |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByEventProperty(CArrayObj *list_source,ENUM_EVENT_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CEvent *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of events with one real                          |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByEventProperty(CArrayObj *list_source,ENUM_EVENT_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CEvent *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of events with one string                        |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByEventProperty(CArrayObj *list_source,ENUM_EVENT_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CEvent *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the listed event index                                    |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindEventMax(CArrayObj *list_source,ENUM_EVENT_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CEvent *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CEvent *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed event index                                    |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindEventMax(CArrayObj *list_source,ENUM_EVENT_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CEvent *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CEvent *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed event index                                    |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindEventMax(CArrayObj *list_source,ENUM_EVENT_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CEvent *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CEvent *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed event index                                    |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindEventMin(CArrayObj* list_source,ENUM_EVENT_PROP_INTEGER property)
  {
   int index=0;
   CEvent *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CEvent *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed event index                                    |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindEventMin(CArrayObj* list_source,ENUM_EVENT_PROP_DOUBLE property)
  {
   int index=0;
   CEvent *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CEvent *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed event index                                    |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindEventMin(CArrayObj* list_source,ENUM_EVENT_PROP_STRING property)
  {
   int index=0;
   CEvent *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CEvent *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with account lists                            |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of accounts with one integer                     |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByAccountProperty(CArrayObj *list_source,ENUM_ACCOUNT_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CAccount *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of accounts with one real                        |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByAccountProperty(CArrayObj *list_source,ENUM_ACCOUNT_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CAccount *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of accounts with one string                      |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByAccountProperty(CArrayObj *list_source,ENUM_ACCOUNT_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CAccount *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the account index in the list                             |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindAccountMax(CArrayObj *list_source,ENUM_ACCOUNT_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CAccount *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CAccount *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the account index in the list                             |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindAccountMax(CArrayObj *list_source,ENUM_ACCOUNT_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CAccount *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CAccount *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the account index in the list                             |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindAccountMax(CArrayObj *list_source,ENUM_ACCOUNT_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CAccount *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CAccount *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the account index in the list                             |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindAccountMin(CArrayObj* list_source,ENUM_ACCOUNT_PROP_INTEGER property)
  {
   int index=0;
   CAccount *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CAccount *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the account index in the list                             |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindAccountMin(CArrayObj* list_source,ENUM_ACCOUNT_PROP_DOUBLE property)
  {
   int index=0;
   CAccount *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CAccount *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the account index in the list                             |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindAccountMin(CArrayObj* list_source,ENUM_ACCOUNT_PROP_STRING property)
  {
   int index=0;
   CAccount *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CAccount *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with symbol lists                             |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of symbols with one integer                      |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::BySymbolProperty(CArrayObj *list_source,ENUM_SYMBOL_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CSymbol *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of symbols with one real                         |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::BySymbolProperty(CArrayObj *list_source,ENUM_SYMBOL_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CSymbol *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of symbols with one string                       |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::BySymbolProperty(CArrayObj *list_source,ENUM_SYMBOL_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CSymbol *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the listed symbol index                                   |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindSymbolMax(CArrayObj *list_source,ENUM_SYMBOL_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CSymbol *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CSymbol *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed symbol index                                   |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindSymbolMax(CArrayObj *list_source,ENUM_SYMBOL_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CSymbol *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CSymbol *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed symbol index                                   |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindSymbolMax(CArrayObj *list_source,ENUM_SYMBOL_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CSymbol *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CSymbol *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed symbol index                                   |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindSymbolMin(CArrayObj* list_source,ENUM_SYMBOL_PROP_INTEGER property)
  {
   int index=0;
   CSymbol *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CSymbol *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed symbol index                                   |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindSymbolMin(CArrayObj* list_source,ENUM_SYMBOL_PROP_DOUBLE property)
  {
   int index=0;
   CSymbol *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CSymbol *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed symbol index                                   |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindSymbolMin(CArrayObj* list_source,ENUM_SYMBOL_PROP_STRING property)
  {
   int index=0;
   CSymbol *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CSymbol *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with lists of pending trading requests        |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of requests with one integer                     |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByPendReqProperty(CArrayObj *list_source,ENUM_PEND_REQ_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CPendRequest *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of requests with one real                        |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByPendReqProperty(CArrayObj *list_source,ENUM_PEND_REQ_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CPendRequest *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of requests with one string                      |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByPendReqProperty(CArrayObj *list_source,ENUM_PEND_REQ_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CPendRequest *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the listed request index                                  |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindPendReqMax(CArrayObj *list_source,ENUM_PEND_REQ_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CPendRequest *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CPendRequest *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed request index                                  |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindPendReqMax(CArrayObj *list_source,ENUM_PEND_REQ_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CPendRequest *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CPendRequest *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed request index                                  |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindPendReqMax(CArrayObj *list_source,ENUM_PEND_REQ_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CPendRequest *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CPendRequest *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed request index                                  |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindPendReqMin(CArrayObj* list_source,ENUM_PEND_REQ_PROP_INTEGER property)
  {
   int index=0;
   CPendRequest *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CPendRequest *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed request index                                  |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindPendReqMin(CArrayObj* list_source,ENUM_PEND_REQ_PROP_DOUBLE property)
  {
   int index=0;
   CPendRequest *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CPendRequest *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed request index                                  |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindPendReqMin(CArrayObj* list_source,ENUM_PEND_REQ_PROP_STRING property)
  {
   int index=0;
   CPendRequest *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CPendRequest *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with timeseries bar lists                     |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of bars with one integer                         |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByBarProperty(CArrayObj *list_source,ENUM_BAR_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CBar *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of bars with one real                            |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByBarProperty(CArrayObj *list_source,ENUM_BAR_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CBar *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of bars with one string                          |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByBarProperty(CArrayObj *list_source,ENUM_BAR_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CBar *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the listed bar index                                      |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindBarMax(CArrayObj *list_source,ENUM_BAR_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CBar *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBar *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed bar index                                      |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindBarMax(CArrayObj *list_source,ENUM_BAR_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CBar *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBar *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed bar index                                      |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindBarMax(CArrayObj *list_source,ENUM_BAR_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CBar *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBar *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed bar index                                      |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindBarMin(CArrayObj* list_source,ENUM_BAR_PROP_INTEGER property)
  {
   int index=0;
   CBar *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBar *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed bar index                                      |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindBarMin(CArrayObj* list_source,ENUM_BAR_PROP_DOUBLE property)
  {
   int index=0;
   CBar *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBar *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the listed bar index                                      |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindBarMin(CArrayObj* list_source,ENUM_BAR_PROP_STRING property)
  {
   int index=0;
   CBar *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBar *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with buffer lists                             |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of buffers with one integer                      |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByBufferProperty(CArrayObj *list_source,ENUM_BUFFER_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CBuffer *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of buffers with one real                         |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByBufferProperty(CArrayObj *list_source,ENUM_BUFFER_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CBuffer *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of buffers with one string                       |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByBufferProperty(CArrayObj *list_source,ENUM_BUFFER_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CBuffer *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the buffer index in the list                              |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindBufferMax(CArrayObj *list_source,ENUM_BUFFER_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CBuffer *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBuffer *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the buffer index in the list                              |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindBufferMax(CArrayObj *list_source,ENUM_BUFFER_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CBuffer *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBuffer *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the buffer index in the list                              |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindBufferMax(CArrayObj *list_source,ENUM_BUFFER_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CBuffer *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBuffer *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the buffer index in the list                              |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindBufferMin(CArrayObj* list_source,ENUM_BUFFER_PROP_INTEGER property)
  {
   int index=0;
   CBuffer *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBuffer *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the buffer index in the list                              |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindBufferMin(CArrayObj* list_source,ENUM_BUFFER_PROP_DOUBLE property)
  {
   int index=0;
   CBuffer *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBuffer *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the buffer index in the list                              |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindBufferMin(CArrayObj* list_source,ENUM_BUFFER_PROP_STRING property)
  {
   int index=0;
   CBuffer *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CBuffer *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with indicator lists                          |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of indicators with one of integer                |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByIndicatorProperty(CArrayObj *list_source,ENUM_INDICATOR_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CIndicatorDE *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of indicators with one of real                   |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByIndicatorProperty(CArrayObj *list_source,ENUM_INDICATOR_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CIndicatorDE *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of indicators with one of string                 |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByIndicatorProperty(CArrayObj *list_source,ENUM_INDICATOR_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CIndicatorDE *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the indicator index in the list                           |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindIndicatorMax(CArrayObj *list_source,ENUM_INDICATOR_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CIndicatorDE *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CIndicatorDE *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the indicator index in the list                           |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindIndicatorMax(CArrayObj *list_source,ENUM_INDICATOR_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CIndicatorDE *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CIndicatorDE *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the indicator index in the list                           |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindIndicatorMax(CArrayObj *list_source,ENUM_INDICATOR_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CIndicatorDE *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CIndicatorDE *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the indicator index in the list                           |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindIndicatorMin(CArrayObj* list_source,ENUM_INDICATOR_PROP_INTEGER property)
  {
   int index=0;
   CIndicatorDE *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CIndicatorDE *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the indicator index in the list                           |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindIndicatorMin(CArrayObj* list_source,ENUM_INDICATOR_PROP_DOUBLE property)
  {
   int index=0;
   CIndicatorDE *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CIndicatorDE *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the indicator index in the list                           |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindIndicatorMin(CArrayObj* list_source,ENUM_INDICATOR_PROP_STRING property)
  {
   int index=0;
   CIndicatorDE *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CIndicatorDE *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of work with indicator data lists                        |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of indicators data with one of integer           |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByIndicatorDataProperty(CArrayObj *list_source,ENUM_IND_DATA_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CDataInd *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of indicators data with one of real              |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByIndicatorDataProperty(CArrayObj *list_source,ENUM_IND_DATA_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CDataInd *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of indicators data with one of string            |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByIndicatorDataProperty(CArrayObj *list_source,ENUM_IND_DATA_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CDataInd *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the indicator data index in the list                      |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindIndDataMax(CArrayObj *list_source,ENUM_IND_DATA_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CDataInd *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataInd *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the indicator data index in the list                      |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindIndDataMax(CArrayObj *list_source,ENUM_IND_DATA_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CDataInd *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataInd *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the indicator data index in the list                      |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindIndDataMax(CArrayObj *list_source,ENUM_IND_DATA_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CDataInd *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataInd *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the indicator data index in the list                      |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindIndDataMin(CArrayObj* list_source,ENUM_IND_DATA_PROP_INTEGER property)
  {
   int index=0;
   CDataInd *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataInd *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the indicator data index in the list                      |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindIndDataMin(CArrayObj* list_source,ENUM_IND_DATA_PROP_DOUBLE property)
  {
   int index=0;
   CDataInd *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataInd *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the indicator data index in the list                      |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindIndDataMin(CArrayObj* list_source,ENUM_IND_DATA_PROP_STRING property)
  {
   int index=0;
   CDataInd *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataInd *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with tick data lists                          |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of tick data with one of integer                 |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByTickDataProperty(CArrayObj *list_source,ENUM_TICK_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CDataTick *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of tick data with one of real                    |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByTickDataProperty(CArrayObj *list_source,ENUM_TICK_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CDataTick *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of tick data with one of string                  |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByTickDataProperty(CArrayObj *list_source,ENUM_TICK_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CDataTick *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the tick data in the list                                 |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindTickDataMax(CArrayObj *list_source,ENUM_TICK_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CDataTick *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataTick *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the tick data in the list                                 |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindTickDataMax(CArrayObj *list_source,ENUM_TICK_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CDataTick *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataTick *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the tick data in the list                                 |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindTickDataMax(CArrayObj *list_source,ENUM_TICK_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CDataTick *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataTick *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the tick data in the list                                 |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindTickDataMin(CArrayObj* list_source,ENUM_TICK_PROP_INTEGER property)
  {
   int index=0;
   CDataTick *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataTick *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the tick data in the list                                 |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindTickDataMin(CArrayObj* list_source,ENUM_TICK_PROP_DOUBLE property)
  {
   int index=0;
   CDataTick *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataTick *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the tick data in the list                                 |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindTickDataMin(CArrayObj* list_source,ENUM_TICK_PROP_STRING property)
  {
   int index=0;
   CDataTick *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CDataTick *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with DOM data                                 |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of DOM data with one of integer                  |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByMBookProperty(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CMarketBookOrd *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of DOM data with one of real                     |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByMBookProperty(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CMarketBookOrd *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of DOM data with one of string                   |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByMBookProperty(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CMarketBookOrd *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the DOM data index in the list                            |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindMBookMax(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CMarketBookOrd *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMarketBookOrd *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the DOM data index in the list                            |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindMBookMax(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CMarketBookOrd *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMarketBookOrd *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the DOM data index in the list                            |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindMBookMax(CArrayObj *list_source,ENUM_MBOOK_ORD_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CMarketBookOrd *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMarketBookOrd *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the DOM data index in the list                            |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindMBookMin(CArrayObj* list_source,ENUM_MBOOK_ORD_PROP_INTEGER property)
  {
   int index=0;
   CMarketBookOrd *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMarketBookOrd *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the DOM data index in the list                            |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindMBookMin(CArrayObj* list_source,ENUM_MBOOK_ORD_PROP_DOUBLE property)
  {
   int index=0;
   CMarketBookOrd *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMarketBookOrd *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the DOM data index in the list                            |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindMBookMin(CArrayObj* list_source,ENUM_MBOOK_ORD_PROP_STRING property)
  {
   int index=0;
   CMarketBookOrd *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMarketBookOrd *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with MQL5 signal data                         |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of MQL5 signals with one integer                 |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByMQLSignalProperty(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CMQLSignal *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of MQL5 signals with one real                    |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByMQLSignalProperty(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CMQLSignal *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of MQL5 signals with one string                  |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByMQLSignalProperty(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CMQLSignal *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the MQL5 signal index in the list                         |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindMQLSignalMax(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CMQLSignal *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMQLSignal *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the MQL5 signal index in the list                         |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindMQLSignalMax(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CMQLSignal *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMQLSignal *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the MQL5 signal index in the list                         |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindMQLSignalMax(CArrayObj *list_source,ENUM_SIGNAL_MQL5_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CMQLSignal *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMQLSignal *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the MQL5 signal index in the list                         |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindMQLSignalMin(CArrayObj* list_source,ENUM_SIGNAL_MQL5_PROP_INTEGER property)
  {
   int index=0;
   CMQLSignal *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMQLSignal *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the MQL5 signal index in the list                         |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindMQLSignalMin(CArrayObj* list_source,ENUM_SIGNAL_MQL5_PROP_DOUBLE property)
  {
   int index=0;
   CMQLSignal *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMQLSignal *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the MQL5 signal index in the list                         |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindMQLSignalMin(CArrayObj* list_source,ENUM_SIGNAL_MQL5_PROP_STRING property)
  {
   int index=0;
   CMQLSignal *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CMQLSignal *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Methods of working with chart data                               |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of charts with one integer                       |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByChartProperty(CArrayObj *list_source,ENUM_CHART_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CChartObj *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of charts with one real                          |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByChartProperty(CArrayObj *list_source,ENUM_CHART_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CChartObj *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of charts with one string                        |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByChartProperty(CArrayObj *list_source,ENUM_CHART_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CChartObj *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the chart index in the list                               |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindChartMax(CArrayObj *list_source,ENUM_CHART_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CChartObj *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CChartObj *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the chart index in the list                               |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindChartMax(CArrayObj *list_source,ENUM_CHART_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CChartObj *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CChartObj *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the chart index in the list                               |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindChartMax(CArrayObj *list_source,ENUM_CHART_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CChartObj *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CChartObj *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the chart index in the list                               |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindChartMin(CArrayObj* list_source,ENUM_CHART_PROP_INTEGER property)
  {
   int index=0;
   CChartObj *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CChartObj *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the chart index in the list                               |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindChartMin(CArrayObj* list_source,ENUM_CHART_PROP_DOUBLE property)
  {
   int index=0;
   CChartObj *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CChartObj *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the chart index in the list                               |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindChartMin(CArrayObj* list_source,ENUM_CHART_PROP_STRING property)
  {
   int index=0;
   CChartObj *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CChartObj *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+----------------------------------------------------------------------------+
//| The methods of working with data of the graphical elements on the canvas   |
//+----------------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of objects with one integer                      |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByGraphCanvElementProperty(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CGCnvElement *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of objects with one real                         |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByGraphCanvElementProperty(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CGCnvElement *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of objects with one string                       |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByGraphCanvElementProperty(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CGCnvElement *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindGraphCanvElementMax(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_INTEGER property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CGCnvElement *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGCnvElement *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      long obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindGraphCanvElementMax(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_DOUBLE property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CGCnvElement *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGCnvElement *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      double obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindGraphCanvElementMax(CArrayObj *list_source,ENUM_CANV_ELEMENT_PROP_STRING property)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int index=0;
   CGCnvElement *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGCnvElement *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      max_obj=list_source.At(index);
      string obj2_prop=max_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindGraphCanvElementMin(CArrayObj* list_source,ENUM_CANV_ELEMENT_PROP_INTEGER property)
  {
   int index=0;
   CGCnvElement *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGCnvElement *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      long obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindGraphCanvElementMin(CArrayObj* list_source,ENUM_CANV_ELEMENT_PROP_DOUBLE property)
  {
   int index=0;
   CGCnvElement *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGCnvElement *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      double obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindGraphCanvElementMin(CArrayObj* list_source,ENUM_CANV_ELEMENT_PROP_STRING property)
  {
   int index=0;
   CGCnvElement *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGCnvElement *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property);
      min_obj=list_source.At(index);
      string obj2_prop=min_obj.GetProperty(property);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) index=i;
     }
   return index;
  }
//+------------------------------------------------------------------+
//+---------------------------------------------------------------------------+
//| The methods of working with data of the graphical elements on the canvas  |
//+---------------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Return the list of objects with one integer                      |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByGraphicStdObjectProperty(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_INTEGER property,int index,long value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   int total=list_source.Total();
   for(int i=0; i<total; i++)
     {
      CGStdGraphObj *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      long obj_prop=obj.GetProperty(property,index);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of objects with one real                         |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByGraphicStdObjectProperty(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index,double value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CGStdGraphObj *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      double obj_prop=obj.GetProperty(property,index);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of objects with one string                       |
//| property meeting the specified criterion                         |
//+------------------------------------------------------------------+
CArrayObj *CSelect::ByGraphicStdObjectProperty(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_STRING property,int index,string value,ENUM_COMPARER_TYPE mode)
  {
   if(list_source==NULL) return NULL;
   CArrayObj *list=new CArrayObj();
   if(list==NULL) return NULL;
   list.FreeMode(false);
   ListStorage.Add(list);
   for(int i=0; i<list_source.Total(); i++)
     {
      CGStdGraphObj *obj=list_source.At(i);
      if(!obj.SupportProperty(property)) continue;
      string obj_prop=obj.GetProperty(property,index);
      if(CompareValues(obj_prop,value,mode)) list.Add(obj);
     }
   return list;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the maximum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindGraphicStdObjectMax(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_INTEGER property,int index)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int idx=0;
   CGStdGraphObj *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGStdGraphObj *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property,index);
      max_obj=list_source.At(idx);
      long obj2_prop=max_obj.GetProperty(property,index);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) idx=i;
     }
   return idx;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the maximum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindGraphicStdObjectMax(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int idx=0;
   CGStdGraphObj *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGStdGraphObj *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property,index);
      max_obj=list_source.At(idx);
      double obj2_prop=max_obj.GetProperty(property,index);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) idx=i;
     }
   return idx;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the maximum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindGraphicStdObjectMax(CArrayObj *list_source,ENUM_GRAPH_OBJ_PROP_STRING property,int index)
  {
   if(list_source==NULL) return WRONG_VALUE;
   int idx=0;
   CGStdGraphObj *max_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGStdGraphObj *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property,index);
      max_obj=list_source.At(idx);
      string obj2_prop=max_obj.GetProperty(property,index);
      if(CompareValues(obj1_prop,obj2_prop,MORE)) idx=i;
     }
   return idx;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the minimum integer property value                          |
//+------------------------------------------------------------------+
int CSelect::FindGraphicStdObjectMin(CArrayObj* list_source,ENUM_GRAPH_OBJ_PROP_INTEGER property,int index)
  {
   int idx=0;
   CGStdGraphObj *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGStdGraphObj *obj=list_source.At(i);
      long obj1_prop=obj.GetProperty(property,index);
      min_obj=list_source.At(idx);
      long obj2_prop=min_obj.GetProperty(property,index);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) idx=i;
     }
   return idx;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the minimum real property value                             |
//+------------------------------------------------------------------+
int CSelect::FindGraphicStdObjectMin(CArrayObj* list_source,ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index)
  {
   int idx=0;
   CGStdGraphObj *min_obj=NULL;
   int total=list_source.Total();
   if(total== 0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGStdGraphObj *obj=list_source.At(i);
      double obj1_prop=obj.GetProperty(property,index);
      min_obj=list_source.At(idx);
      double obj2_prop=min_obj.GetProperty(property,index);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) idx=i;
     }
   return idx;
  }
//+------------------------------------------------------------------+
//| Return the object index in the list                              |
//| with the minimum string property value                           |
//+------------------------------------------------------------------+
int CSelect::FindGraphicStdObjectMin(CArrayObj* list_source,ENUM_GRAPH_OBJ_PROP_STRING property,int index)
  {
   int idx=0;
   CGStdGraphObj *min_obj=NULL;
   int total=list_source.Total();
   if(total==0) return WRONG_VALUE;
   for(int i=1; i<total; i++)
     {
      CGStdGraphObj *obj=list_source.At(i);
      string obj1_prop=obj.GetProperty(property,index);
      min_obj=list_source.At(idx);
      string obj2_prop=min_obj.GetProperty(property,index);
      if(CompareValues(obj1_prop,obj2_prop,LESS)) idx=i;
     }
   return idx;
  }
//+------------------------------------------------------------------+
