//+------------------------------------------------------------------+
//|                                         TimeSeriesCollection.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "ListObj.mqh"
#include "..\Objects\Series\TimeSeriesDE.mqh"
#include "..\Objects\Symbols\Symbol.mqh"
//+------------------------------------------------------------------+
//| Symbol timeseries collection                                     |
//+------------------------------------------------------------------+
class CTimeSeriesCollection : public CBaseObjExt
  {
private:
   CListObj                m_list;                    // List of applied symbol timeseries
//--- Return the timeseries index by symbol name
   int                     IndexTimeSeries(const string symbol);
public:
//--- Return (1) oneself and (2) the timeseries list
   CTimeSeriesCollection  *GetObject(void)            { return &this;         }
   CArrayObj              *GetList(void)              { return &this.m_list;  }
//--- Return (1) the timeseries object of the specified symbol and (2) the timeseries object of the specified symbol/period
   CTimeSeriesDE          *GetTimeseries(const string symbol);
   CSeriesDE              *GetSeries(const string symbol,const ENUM_TIMEFRAMES timeframe);

//--- Create the symbol timeseries list collection
   bool                    CreateCollection(const CArrayObj *list_symbols);
//--- Set the flag of using (1) the specified timeseries of the specified symbol, (2) the specified timeseries of all symbols
//--- (3) all timeseries of the specified symbol and (4) all timeseries of all symbols
   void                    SetAvailable(const string symbol,const ENUM_TIMEFRAMES timeframe,const bool flag=true);
   void                    SetAvailable(const ENUM_TIMEFRAMES timeframe,const bool flag=true);
   void                    SetAvailable(const string symbol,const bool flag=true);
   void                    SetAvailable(const bool flag=true);
//--- Get the flag of using (1) the specified timeseries of the specified symbol, (2) the specified timeseries of all symbols
//--- (3) all timeseries of the specified symbol and (4) all timeseries of all symbols
   bool                    IsAvailable(const string symbol,const ENUM_TIMEFRAMES timeframe);
   bool                    IsAvailable(const ENUM_TIMEFRAMES timeframe);
   bool                    IsAvailable(const string symbol);
   bool                    IsAvailable(void);

//--- Set the history depth of (1) the specified timeseries of the specified symbol, (2) the specified timeseries of all symbols
//--- (3) all timeseries of the specified symbol and (4) all timeseries of all symbols
   bool                    SetRequiredUsedData(const string symbol,const ENUM_TIMEFRAMES timeframe,const uint required=0,const int rates_total=0);
   bool                    SetRequiredUsedData(const ENUM_TIMEFRAMES timeframe,const uint required=0,const int rates_total=0);
   bool                    SetRequiredUsedData(const string symbol,const uint required=0,const int rates_total=0);
   bool                    SetRequiredUsedData(const uint required=0,const int rates_total=0);
//--- Return the flag of data synchronization with the server data of the (1) specified timeseries of the specified symbol,
//--- (2) the specified timeseries of all symbols, (3) all timeseries of the specified symbol and (4) all timeseries of all symbols
   bool                    SyncData(const string symbol,const ENUM_TIMEFRAMES timeframe,const uint required=0,const int rates_total=0);
   bool                    SyncData(const ENUM_TIMEFRAMES timeframe,const uint required=0,const int rates_total=0);
   bool                    SyncData(const string symbol,const uint required=0,const int rates_total=0);
   bool                    SyncData(const uint required=0,const int rates_total=0);

//--- Return the bar object of the specified timeseries of the specified symbol of the specified position (1) by index, (2) by time
//--- bar object of the first timeseries corresponding to the bar open time on the second timeseries (3) by index, (4) by time
   CBar                   *GetBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index,const bool from_series=true);
   CBar                   *GetBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime bar_time);
   CBar                   *GetBarSeriesFirstFromSeriesSecond(const string symbol_first,const ENUM_TIMEFRAMES timeframe_first,const int index,
                                                             const string symbol_second=NULL,const ENUM_TIMEFRAMES timeframe_second=PERIOD_CURRENT);
   CBar                   *GetBarSeriesFirstFromSeriesSecond(const string symbol_first,const ENUM_TIMEFRAMES timeframe_first,const datetime first_bar_time,
                                                             const string symbol_second=NULL,const ENUM_TIMEFRAMES timeframe_second=PERIOD_CURRENT);

//--- Return the bar index on the specified timeframe chart by the current chart's bar index                                 |
   int                     IndexBarPeriodByBarCurrent(const int series_index,const string symbol,const ENUM_TIMEFRAMES timeframe);

//--- Return the flag of opening a new bar of the specified timeseries of the specified symbol
   bool                    IsNewBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time=0);

//--- (1) Create, (2) re-create a specified timeseries of a specified symbol, (3) re-create all timeseries
   bool                    CreateSeries(const string symbol,const ENUM_TIMEFRAMES timeframe,const int rates_total=0,const uint required=0);
   bool                    ReCreateSeries(const string symbol,const ENUM_TIMEFRAMES timeframe,const int rates_total=0,const uint required=0);
   bool                    ReCreateSeriesAll(const int rates_total=0,const uint required=0);
//--- Return (1) an empty, (2) partially filled timeseries
   CSeriesDE              *GetSeriesEmpty(void);
   CSeriesDE              *GetSeriesIncompleted(void);
//--- Update (1) the specified timeseries of the specified symbol, (2) all timeseries of a specified symbol,
//--- (3) all timeseries of all symbols, (4) all timeseries except the current one
   void                    Refresh(const string symbol,const ENUM_TIMEFRAMES timeframe,SDataCalculate &data_calculate);
   void                    Refresh(const string symbol,SDataCalculate &data_calculate);
   void                    Refresh(SDataCalculate &data_calculate);
   void                    RefreshAllExceptCurrent(SDataCalculate &data_calculate);

//--- Get events from the timeseries object and add them to the list
   bool                    SetEvents(CTimeSeriesDE *timeseries);

//--- Display (1) the complete and (2) short collection description in the journal
   void                    Print(const bool created=true);
   void                    PrintShort(const bool created=true);
   
//--- Copy the specified double property of the specified timeseries of the specified symbol to the array
//--- Regardless of the array indexing direction, copying is performed the same way as copying to a timeseries array
   bool                    CopyToBufferAsSeries(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                const ENUM_BAR_PROP_DOUBLE property,
                                                double &array[],
                                                const double empty=EMPTY_VALUE);
//--- Constructor
                           CTimeSeriesCollection();
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTimeSeriesCollection::CTimeSeriesCollection()
  {
   this.m_type=COLLECTION_SERIES_ID;
   this.m_list.Clear();
   this.m_list.Sort();
   this.m_list.Type(COLLECTION_SERIES_ID);
  }
//+------------------------------------------------------------------+
//| Return the timeseries index by symbol name                       |
//+------------------------------------------------------------------+
int CTimeSeriesCollection::IndexTimeSeries(const string symbol)
  {
   const CTimeSeriesDE *obj=new CTimeSeriesDE(symbol==NULL || symbol=="" ? ::Symbol() : symbol);
   if(obj==NULL)
      return WRONG_VALUE;
   this.m_list.Sort();
   int index=this.m_list.Search(obj);
   delete obj;
   return index;
  }
//+------------------------------------------------------------------+
//| Create the symbol timeseries collection list                     |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::CreateCollection(const CArrayObj *list_symbols)
  {
//--- If an empty list of symbol objects is passed, exit
   if(list_symbols==NULL)
      return false;
//--- Get the number of symbol objects in the passed list
   int total=list_symbols.Total();
//--- Clear the timeseries collection list
   this.m_list.Clear();
//--- In a loop by all symbol objects
   for(int i=0;i<total;i++)
     {
      //--- get the next symbol object
      CSymbol *symbol_obj=list_symbols.At(i);
      //--- if failed to get a symbol object, move on to the next one in the list
      if(symbol_obj==NULL)
         continue;
      //--- Create a new timeseries object with the current symbol name
      CTimeSeriesDE *timeseries=new CTimeSeriesDE(symbol_obj.Name());
      //--- If failed to create the timeseries object, move on to the next symbol in the list
      if(timeseries==NULL)
         continue;
      //--- Set the sorted list flag for the timeseries collection list
      this.m_list.Sort();
      //--- If the object with the same symbol name is already present in the timeseries collection list, remove the timeseries object
      if(this.m_list.Search(timeseries)>WRONG_VALUE)
         delete timeseries;
      //--- if failed to add the timeseries object to the collection list, remove the timeseries object
      else 
         if(!this.m_list.Add(timeseries))
            delete timeseries;
     }
//--- Return the flag indicating that the created collection list has a size greater than zero
   return this.m_list.Total()>0;
  }
//+------------------------------------------------------------------+
//| Return the timeseries object of the specified symbol             |
//+------------------------------------------------------------------+
CTimeSeriesDE *CTimeSeriesCollection::GetTimeseries(const string symbol)
  {
   int index=this.IndexTimeSeries(symbol);
   if(index==WRONG_VALUE)
      return NULL;
   CTimeSeriesDE *timeseries=this.m_list.At(index);
   return timeseries;
  }
//+------------------------------------------------------------------+
//| Return the timeseries object of the specified symbol/period      |
//+------------------------------------------------------------------+
CSeriesDE *CTimeSeriesCollection::GetSeries(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CTimeSeriesDE *timeseries=this.GetTimeseries(symbol);
   if(timeseries==NULL)
      return NULL;
   CSeriesDE *series=timeseries.GetSeries(timeframe);
   return series;
  }
//+-----------------------------------------------------------------------+
//|Set the flag of using the specified timeseries of the specified symbol |
//+-----------------------------------------------------------------------+
void CTimeSeriesCollection::SetAvailable(const string symbol,const ENUM_TIMEFRAMES timeframe,const bool flag=true)
  {
   CSeriesDE *series=this.GetSeries(symbol,timeframe);
   if(series==NULL)
      return;
   series.SetAvailable(flag);
  }
//+------------------------------------------------------------------+
//|Set the flag of using the specified timeseries of all symbols     |
//+------------------------------------------------------------------+
void CTimeSeriesCollection::SetAvailable(const ENUM_TIMEFRAMES timeframe,const bool flag=true)
  {
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      CSeriesDE *series=timeseries.GetSeries(timeframe);
      if(series==NULL)
         continue;
      series.SetAvailable(flag);
     }
  }
//+------------------------------------------------------------------+
//|Set the flag of using all timeseries of the specified symbol      |
//+------------------------------------------------------------------+
void CTimeSeriesCollection::SetAvailable(const string symbol,const bool flag=true)
  {
   CTimeSeriesDE *timeseries=this.GetTimeseries(symbol);
   if(timeseries==NULL)
      return;
   CArrayObj *list=timeseries.GetListSeries();
   if(list==NULL)
      return;
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CSeriesDE *series=list.At(i);
      if(series==NULL)
         continue;
      series.SetAvailable(flag);
     }
  }
//+------------------------------------------------------------------+
//| Set the flag of using all timeseries of all symbols              |
//+------------------------------------------------------------------+
void CTimeSeriesCollection::SetAvailable(const bool flag=true)
  {
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      CArrayObj *list=timeseries.GetListSeries();
      if(list==NULL)
         continue;
      int total_series=list.Total();
      for(int j=0;j<total_series;j++)
        {
         CSeriesDE *series=list.At(j);
         if(series==NULL)
            continue;
         series.SetAvailable(flag);
        }
     }
  }
//+-------------------------------------------------------------------------+
//|Return the flag of using the specified timeseries of the specified symbol|
//+-------------------------------------------------------------------------+
bool CTimeSeriesCollection::IsAvailable(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CSeriesDE *series=this.GetSeries(symbol,timeframe);
   if(series==NULL)
      return false;
   return series.IsAvailable();
  }
//+------------------------------------------------------------------+
//| Return the flag of using the specified timeseries of all symbols |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::IsAvailable(const ENUM_TIMEFRAMES timeframe)
  {
   bool res=true;
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      CSeriesDE *series=timeseries.GetSeries(timeframe);
      if(series==NULL)
         continue;
      res &=series.IsAvailable();
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Return the flag of using all timeseries of the specified symbol  |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::IsAvailable(const string symbol)
  {
   bool res=true;
   CTimeSeriesDE *timeseries=this.GetTimeseries(symbol);
   if(timeseries==NULL)
      return false;
   CArrayObj *list=timeseries.GetListSeries();
   if(list==NULL)
      return false;
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CSeriesDE *series=list.At(i);
      if(series==NULL)
         continue;
      res &=series.IsAvailable();
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Return the flag of using all timeseries of all symbols           |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::IsAvailable(void)
  {
   bool res=true;
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      CArrayObj *list=timeseries.GetListSeries();
      if(list==NULL)
         continue;
      int total_series=list.Total();
      for(int j=0;j<total_series;j++)
        {
         CSeriesDE *series=list.At(j);
         if(series==NULL)
            continue;
         res &=series.IsAvailable();
        }
     }
   return res;
  }
//+--------------------------------------------------------------------------+
//|Set the history depth for the specified timeseries of the specified symbol|
//+--------------------------------------------------------------------------+
bool CTimeSeriesCollection::SetRequiredUsedData(const string symbol,const ENUM_TIMEFRAMES timeframe,const uint required=0,const int rates_total=0)
  {
   CSeriesDE *series=this.GetSeries(symbol,timeframe);
   if(series==NULL)
      return false;
   return series.SetRequiredUsedData(required,rates_total);
  }
//+------------------------------------------------------------------+
//| Set the history depth of the specified timeseries of all symbols |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::SetRequiredUsedData(const ENUM_TIMEFRAMES timeframe,const uint required=0,const int rates_total=0)
  {
   bool res=true;
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      CSeriesDE *series=timeseries.GetSeries(timeframe);
      if(series==NULL)
         continue;
      res &=series.SetRequiredUsedData(required,rates_total);
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Set the history depth for all timeseries of the specified symbol |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::SetRequiredUsedData(const string symbol,const uint required=0,const int rates_total=0)
  {
   bool res=true;
   CTimeSeriesDE *timeseries=this.GetTimeseries(symbol);
   if(timeseries==NULL)
      return false;
   CArrayObj *list=timeseries.GetListSeries();
   if(list==NULL)
      return false;
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CSeriesDE *series=list.At(i);
      if(series==NULL)
         continue;
      res &=series.SetRequiredUsedData(required,rates_total);
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Set the history depth for all timeseries of all symbols          |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::SetRequiredUsedData(const uint required=0,const int rates_total=0)
  {
   bool res=true;
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      CArrayObj *list=timeseries.GetListSeries();
      if(list==NULL)
         continue;
      int total_series=list.Total();
      for(int j=0;j<total_series;j++)
        {
         CSeriesDE *series=list.At(j);
         if(series==NULL)
            continue;
         res &=series.SetRequiredUsedData(required,rates_total);
        }
     }
   return res;
  }
//+----------------------------------------------------------------------+
//| Return the bar object of the specified timeseries by index           |
//| of the specified symbol of the specified position                    |
//| from_series=true - by the timeseries index, false - by the list index|
//+----------------------------------------------------------------------+
CBar *CTimeSeriesCollection::GetBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index,const bool from_series=true)
  {
   CSeriesDE *series=this.GetSeries(symbol,timeframe);
   if(series==NULL)
      return NULL;
//--- Depending on the from_series flag, return the pointer to the bar
//--- either by the chart timeseries index or by the bar index in the timeseries list
   return(from_series ? series.GetBar(index) : series.GetBarByListIndex(index));
  }
//+------------------------------------------------------------------+
//| Return the bar object of the specified timeseries                |
//| of the specified symbol of the specified position by time        |
//+------------------------------------------------------------------+
CBar *CTimeSeriesCollection::GetBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime bar_time)
  {
   CSeriesDE *series=this.GetSeries(symbol,timeframe);
   if(series==NULL)
      return NULL;
   return series.GetBar(bar_time);
  }
//+------------------------------------------------------------------+
//| Return the bar object of the first timeseries by index           |
//| corresponding to the bar open time on the second timeseries      |
//+------------------------------------------------------------------+
CBar *CTimeSeriesCollection::GetBarSeriesFirstFromSeriesSecond(const string symbol_first,const ENUM_TIMEFRAMES timeframe_first,const int index,
                                                               const string symbol_second=NULL,const ENUM_TIMEFRAMES timeframe_second=PERIOD_CURRENT)
  {
   CBar *bar_first=this.GetBar(symbol_first,timeframe_first,index);
   if(bar_first==NULL)
      return NULL;
   CBar *bar_second=this.GetBar(symbol_second,timeframe_second,bar_first.Time());
   return bar_second;
  }
//+------------------------------------------------------------------+
//| Return the bar object of the first timeseries by time            |
//| corresponding to the bar open time on the second timeseries      |
//+------------------------------------------------------------------+
CBar *CTimeSeriesCollection::GetBarSeriesFirstFromSeriesSecond(const string symbol_first,const ENUM_TIMEFRAMES timeframe_first,const datetime first_bar_time,
                                                               const string symbol_second=NULL,const ENUM_TIMEFRAMES timeframe_second=PERIOD_CURRENT)
  {
   CBar *bar_first=this.GetBar(symbol_first,timeframe_first,first_bar_time);
   if(bar_first==NULL)
      return NULL;
   CBar *bar_second=this.GetBar(symbol_second,timeframe_second,bar_first.Time());
   return bar_second;
  }
//+------------------------------------------------------------------+
//| Return new bar opening flag                                      |
//| for a specified timeseries of a specified symbol                 |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::IsNewBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time=0)
  {
   CSeriesDE *series=this.GetSeries(symbol,timeframe);
   if(series==NULL)
      return false;
//--- Return the result of checking the new bar of the specified timeseries
   return series.IsNewBar(time);
  }
//+------------------------------------------------------------------+
//| Return the flag of data synchronization with the server data     |
//| for a specified timeseries of a specified symbol                 |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::SyncData(const string symbol,const ENUM_TIMEFRAMES timeframe,const uint required=0,const int rates_total=0)
  {
   CSeriesDE *series=this.GetSeries(symbol,timeframe);
   if(series==NULL)
      return false;
   return series.SyncData(required,rates_total);
  }
//+------------------------------------------------------------------+
//| Return the flag of data synchronization with the server data     |
//| for a specified timeseries of all symbols                        |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::SyncData(const ENUM_TIMEFRAMES timeframe,const uint required=0,const int rates_total=0)
  {
   bool res=true;
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      CSeriesDE *series=timeseries.GetSeries(timeframe);
      if(series==NULL)
         continue;
      res &=series.SyncData(required,rates_total);
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Return the flag of data synchronization with the server data     |
//| for all timeseries of a specified symbol                         |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::SyncData(const string symbol,const uint required=0,const int rates_total=0)
  {
   bool res=true;
   CTimeSeriesDE *timeseries=this.GetTimeseries(symbol);
   if(timeseries==NULL)
      return false;
   CArrayObj *list=timeseries.GetListSeries();
   if(list==NULL)
      return false;
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CSeriesDE *series=list.At(i);
      if(series==NULL)
         continue;
      res &=series.SyncData(required,rates_total);
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Return the flag of data synchronization with the server data     |
//| for all timeseries of all symbols                                |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::SyncData(const uint required=0,const int rates_total=0)
  {
   bool res=true;
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      CArrayObj *list=timeseries.GetListSeries();
      if(list==NULL)
         continue;
      int total_series=list.Total();
      for(int j=0;j<total_series;j++)
        {
         CSeriesDE *series=list.At(j);
         if(series==NULL)
            continue;
         res &=series.SyncData(required,rates_total);
        }
     }
   return res;
  }
//+------------------------------------------------------------------+
//|Return the empty (created but not filled with data) timeseries    |
//+------------------------------------------------------------------+
CSeriesDE *CTimeSeriesCollection::GetSeriesEmpty(void)
  {
//--- In the loop by the timeseries object list
   int total_timeseries=this.m_list.Total();
   for(int i=0;i<total_timeseries;i++)
     {
      //--- get the next object of all symbol timeseries by the loop index
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL || !timeseries.IsAvailable())
         continue;
      //--- get the list of timeseries objects from the object of all symbol timeseries
      CArrayObj *list_series=timeseries.GetListSeries();
      if(list_series==NULL)
         continue;
      //--- in the loop by the symbol timeseries list
      int total_series=list_series.Total();
      for(int j=0;j<total_series;j++)
        {
         //--- get the next timeseries
         CSeriesDE *series=list_series.At(j);
         if(series==NULL || !series.IsAvailable())
            continue;
         //--- if the timeseries has no bar objects,
         //--- return the pointer to the timeseries
         if(series.DataTotal()==0)
            return series;
        }
     }
   return NULL;
  }
//+------------------------------------------------------------------+
//| Return partially filled timeseries                               |
//+------------------------------------------------------------------+
CSeriesDE *CTimeSeriesCollection::GetSeriesIncompleted(void)
  {
//--- In the loop by the timeseries object list
   int total_timeseries=this.m_list.Total();
   for(int i=0;i<total_timeseries;i++)
     {
      //--- get the next object of all symbol timeseries by the loop index
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL || !timeseries.IsAvailable())
         continue;
      //--- get the list of timeseries objects from the object of all symbol timeseries
      CArrayObj *list_series=timeseries.GetListSeries();
      if(list_series==NULL)
         continue;
      //--- in the loop by the symbol timeseries list
      int total_series=list_series.Total();
      for(int j=0;j<total_series;j++)
        {
         //--- get the next timeseries
         CSeriesDE *series=list_series.At(j);
         if(series==NULL || !series.IsAvailable())
            continue;
         //--- if the timeseries has bar objects,
         //--- but their number is not equal to the requested and available one for the symbol,
         //--- return the pointer to the timeseries
         if(series.DataTotal()>0 && series.AvailableUsedData()!=series.DataTotal())
            return series;
        }
     }
   return NULL;
  }
//+------------------------------------------------------------------+
//| Create the specified timeseries of the specified symbol          |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::CreateSeries(const string symbol,const ENUM_TIMEFRAMES timeframe,const int rates_total=0,const uint required=0)
  {
   CTimeSeriesDE *timeseries=this.GetTimeseries(symbol);
   if(timeseries==NULL)
      return false;
   if(!timeseries.AddSeries(timeframe,required))
      return false;
   if(!timeseries.SyncData(timeframe,required,rates_total))
      return false;
   return timeseries.CreateSeries(timeframe,required);
  }
//+------------------------------------------------------------------+
//| Re-create a specified timeseries of a specified symbol           |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::ReCreateSeries(const string symbol,const ENUM_TIMEFRAMES timeframe,const int rates_total=0,const uint required=0)
  {
   CTimeSeriesDE *timeseries=this.GetTimeseries(symbol);
   if(timeseries==NULL)
      return false;
   if(!timeseries.SyncData(timeframe,rates_total,required))
      return false;
   return timeseries.CreateSeries(timeframe,required);
  }
//+------------------------------------------------------------------+
//| Re-create all timeseries                                         |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::ReCreateSeriesAll(const int rates_total=0,const uint required=0)
  {
//--- In the loop by all symbol timeseries objects in the collection,
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      //--- get the next symbol timeseries object
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      //--- Get the list of all symbol timeseries
      CArrayObj *list=timeseries.GetListSeries();
      if(list==NULL)
         continue;
      //--- In a loop by all symbol timeseries
      int total_series=list.Total();
      for(int j=0;j<total_series;j++)
        {
         //--- Get the next timeseries
         CSeriesDE *series=list.At(j);
         if(series==NULL)
            continue;
         //--- check timeseries synchronization and re-create it
         if(!series.SyncData(required,rates_total))
            return false;
         if(series.Create(required)==0)
            return false;
        }
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Update the specified timeseries of the specified symbol          |
//+------------------------------------------------------------------+
void CTimeSeriesCollection::Refresh(const string symbol,const ENUM_TIMEFRAMES timeframe,SDataCalculate &data_calculate)
  {
//--- Reset the flag of an event in the timeseries collection and clear the event list
   this.m_is_event=false;
   this.m_list_events.Clear();
//--- Get the object of all symbol timeseries by a symbol name
   CTimeSeriesDE *timeseries=this.GetTimeseries(symbol);
   if(timeseries==NULL)
      return;
//--- If there is no new tick on the timeseries object symbol, exit
   if(!timeseries.IsNewTick())
      return;
//--- Update the required object timeseries of all symbol timeseries
   timeseries.Refresh(timeframe,data_calculate);
//--- If the timeseries has the enabled event flag,
//--- get events from symbol timeseries, write them to the collection event list
//--- and set the event flag in the collection
   if(timeseries.IsEvent())
      this.m_is_event=this.SetEvents(timeseries);
  }
//+------------------------------------------------------------------+
//| Update all timeseries of the specified symbol                    |
//+------------------------------------------------------------------+
void CTimeSeriesCollection::Refresh(const string symbol,SDataCalculate &data_calculate)
  {
//--- Reset the flag of an event in the timeseries collection and clear the event list
   this.m_is_event=false;
   this.m_list_events.Clear();
//--- Get the object of all symbol timeseries by a symbol name
   CTimeSeriesDE *timeseries=this.GetTimeseries(symbol);
   if(timeseries==NULL)
      return;
//--- If there is no new tick on the timeseries object symbol, exit
   if(!timeseries.IsNewTick())
      return;
//--- Update all object timeseries of all symbol timeseries
   timeseries.RefreshAll(data_calculate);
//--- If the timeseries has the enabled event flag,
//--- get events from symbol timeseries, write them to the collection event list
//--- and set the event flag in the collection
   if(timeseries.IsEvent())
      this.m_is_event=this.SetEvents(timeseries);
  }
//+------------------------------------------------------------------+
//| Update all timeseries of all symbols                             |
//+------------------------------------------------------------------+
void CTimeSeriesCollection::Refresh(SDataCalculate &data_calculate)
  {
//--- Reset the flag of an event in the timeseries collection and clear the event list
   this.m_is_event=false;
   this.m_list_events.Clear();
//--- In the loop by all symbol timeseries objects in the collection,
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      //--- get the next symbol timeseries object
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      //--- if there is no new tick on a timeseries symbol, move to the next object in the list
      if(!timeseries.IsNewTick())
         continue;
      //--- Update all symbol timeseries
      timeseries.RefreshAll(data_calculate); 
      //--- If the event flag enabled for the symbol timeseries object,
      //--- get events from symbol timeseries, write them to the collection event list
      //--- and set the event flag in the collection
      if(timeseries.IsEvent())
         this.m_is_event=this.SetEvents(timeseries);
     }
  }
//+------------------------------------------------------------------+
//| Update all timeseries except the current one                     |
//+------------------------------------------------------------------+
void CTimeSeriesCollection::RefreshAllExceptCurrent(SDataCalculate &data_calculate)
  {
//--- Reset the flag of an event in the timeseries collection and clear the event list
   this.m_is_event=false;
   this.m_list_events.Clear();
//--- In the loop by all symbol timeseries objects in the collection,
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      //--- get the next symbol timeseries object
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      //--- if the timeseries symbol is equal to the current chart symbol or
      //--- if there is no new tick on a timeseries symbol, move to the next object in the list
      if(timeseries.Symbol()==::Symbol() || !timeseries.IsNewTick())
         continue;
      //--- Update all symbol timeseries
      timeseries.RefreshAll(data_calculate);
      //--- If the event flag enabled for the symbol timeseries object,
      //--- get events from symbol timeseries, write them to the collection event list
      //--- and set the event flag in the collection
      if(timeseries.IsEvent())
         this.m_is_event=this.SetEvents(timeseries);
     }
  }
//+------------------------------------------------------------------+
//| Get events from the timeseries object and add them to the list   |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::SetEvents(CTimeSeriesDE *timeseries)
  {
//--- Set the flag of successfully adding an event to the list and
//--- get the list of symbol timeseries object events
   bool res=true;
   CArrayObj *list=timeseries.GetListEvents();
   if(list==NULL)
      return false;
//--- In the loop by the obtained list of events,
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      //--- get the next event by the loop index and
      CEventBaseObj *event=timeseries.GetEvent(i);
      if(event==NULL)
         continue;
      //--- add the result of adding the obtained event to the flag value
      //--- from the symbol timeseries list to the timeseries collection list
      res &=this.EventAdd(event.ID(),event.LParam(),event.DParam(),event.SParam());
     }
//--- Return the result of adding events to the list
   return res;
  }
//+------------------------------------------------------------------+
//| Display complete collection description in the journal           |
//+------------------------------------------------------------------+
void CTimeSeriesCollection::Print(const bool created=true)
  {
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      timeseries.Print(false,created);
     }
  }
//+------------------------------------------------------------------+
//| Display the short collection description in the journal          |
//+------------------------------------------------------------------+
void CTimeSeriesCollection::PrintShort(const bool created=true)
  {
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTimeSeriesDE *timeseries=this.m_list.At(i);
      if(timeseries==NULL)
         continue;
      timeseries.PrintShort(false,created);
     }
  }
//+------------------------------------------------------------------+
//| Copy the specified double property to the array                  |
//| for a specified timeseries of a specified symbol                 |
//+------------------------------------------------------------------+
bool CTimeSeriesCollection::CopyToBufferAsSeries(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                 const ENUM_BAR_PROP_DOUBLE property,
                                                 double &array[],
                                                 const double empty=EMPTY_VALUE)
  {
   CSeriesDE *series=this.GetSeries(symbol,timeframe);
   if(series==NULL)
      return false;
   return series.CopyToBufferAsSeries(property,array,empty);
  }
//+------------------------------------------------------------------+
//| Return the bar index on the specified timeframe chart            |
//| by the current chart's bar index                                 |
//+------------------------------------------------------------------+
int CTimeSeriesCollection::IndexBarPeriodByBarCurrent(const int series_index,const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CSeriesDE *series=this.GetSeries(::Symbol(),(ENUM_TIMEFRAMES)::Period());
   if(series==NULL)
      return WRONG_VALUE;
   CBar *bar=series.GetBar(series_index);
   if(bar==NULL)
      return WRONG_VALUE;
   return ::iBarShift(symbol,timeframe,bar.Time());
  }
//+------------------------------------------------------------------+
