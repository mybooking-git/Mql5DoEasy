//+------------------------------------------------------------------+
//|                                                 TimeSeriesDE.mqh |
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
#include "SeriesDE.mqh"
#include "..\Ticks\NewTickObj.mqh"
//+------------------------------------------------------------------+
//| Symbol timeseries class                                          |
//+------------------------------------------------------------------+
class CTimeSeriesDE : public CBaseObjExt
  {
private:
   string            m_symbol;                                             // Timeseries symbol
   CNewTickObj       m_new_tick;                                           // "New tick" object
   CArrayObj         m_list_series;                                        // List of timeseries by timeframes
   datetime          m_server_firstdate;                                   // The very first date in history by a server symbol
   datetime          m_terminal_firstdate;                                 // The very first date in history by a symbol in the client terminal
//--- Return (1) the timeframe index in the list and (2) the timeframe by the list index
   int               IndexTimeframe(const ENUM_TIMEFRAMES timeframe);
   ENUM_TIMEFRAMES   TimeframeByIndex(const uchar index)             const { return TimeframeByEnumIndex(uchar(index+1));                       }
//--- Set the very first date in history by symbol on the server and in the client terminal
   void              SetTerminalServerDate(void)
                       {
                        this.m_server_firstdate=(datetime)::SeriesInfoInteger(this.m_symbol,::Period(),SERIES_SERVER_FIRSTDATE);
                        this.m_terminal_firstdate=(datetime)::SeriesInfoInteger(this.m_symbol,::Period(),SERIES_TERMINAL_FIRSTDATE);
                       }
public:
//--- Return (1) oneself, (2) the full list of timeseries, (3) specified timeseries object and (4) timeseries object by index
   CTimeSeriesDE    *GetObject(void)                                       { return &this;                                                      }
   CArrayObj        *GetListSeries(void)                                   { return &this.m_list_series;                                        }
   CSeriesDE        *GetSeries(const ENUM_TIMEFRAMES timeframe)            { return this.m_list_series.At(this.IndexTimeframe(timeframe));      }
   CSeriesDE        *GetSeriesByIndex(const uchar index)                   { return this.m_list_series.At(index);                               }
//--- Set/return timeseries symbol
   void              SetSymbol(const string symbol)                        { this.m_symbol=(symbol==NULL || symbol=="" ? ::Symbol() : symbol);  }
   string            Symbol(void)                                    const { return this.m_symbol;                                              }
//--- Set the history depth (1) of a specified timeseries and (2) of all applied symbol timeseries
   bool              SetRequiredUsedData(const ENUM_TIMEFRAMES timeframe,const uint required=0,const int rates_total=0);
   bool              SetRequiredAllUsedData(const uint required=0,const int rates_total=0);
//--- Return the flag of data synchronization with the server data of the (1) specified timeseries, (2) all timeseries
   bool              SyncData(const ENUM_TIMEFRAMES timeframe,const int rates_total=0,const uint required=0);
   bool              SyncAllData(const int rates_total=0,const uint required=0);
//--- Return the very first date in history by symbol (1) on the server, (2) in the client terminal and (3) the new tick flag
   datetime          ServerFirstDate(void)                           const { return this.m_server_firstdate;                                    }
   datetime          TerminalFirstDate(void)                         const { return this.m_terminal_firstdate;                                  }
   bool              IsNewTick(void)                                       { return this.m_new_tick.IsNewTick();                                }
//--- (1) Add the specified timeseries list to the list and create (2) the specified timeseries list
   bool              AddSeries(const ENUM_TIMEFRAMES timeframe,const uint required=0);
   bool              CreateSeries(const ENUM_TIMEFRAMES timeframe,const uint required=0);
//--- Update (1) the specified timeseries list and (2) all timeseries lists
   void              Refresh(const ENUM_TIMEFRAMES timeframe,SDataCalculate &data_calculate);
   void              RefreshAll(SDataCalculate &data_calculate);

//--- Copy the specified double property of the specified timeseries to the array
//--- Regardless of the array indexing direction, copying is performed the same way as copying to a timeseries array
   bool              CopyToBufferAsSeries(const ENUM_TIMEFRAMES timeframe,
                                          const ENUM_BAR_PROP_DOUBLE property,
                                          double &array[],
                                          const double empty=EMPTY_VALUE);

//--- Compare CTimeSeriesDE objects (by symbol)
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Display (1) description and (2) short symbol timeseries description in the journal
   virtual void      Print(const bool full_prop=false,const bool created=false);
   virtual void      PrintShort(const bool dash=false,const bool created=false);
   
//--- Constructors
                     CTimeSeriesDE(void){ this.m_type=OBJECT_DE_TYPE_SERIES_SYMBOL; }
                     CTimeSeriesDE(const string symbol);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTimeSeriesDE::CTimeSeriesDE(const string symbol) : m_symbol(symbol)
  {
   this.m_type=OBJECT_DE_TYPE_SERIES_SYMBOL; 
   this.m_list_series.Clear();
   this.m_list_series.Sort();
   this.SetTerminalServerDate();
   this.m_new_tick.SetSymbol(this.m_symbol);
   this.m_new_tick.Refresh();
  }
//+------------------------------------------------------------------+
//| Compare CTimeSeriesDE objects by symbol                          |
//+------------------------------------------------------------------+
int CTimeSeriesDE::Compare(const CObject *node,const int mode=0) const
  {
   const CTimeSeriesDE *compared_obj=node;
   return(this.Symbol()>compared_obj.Symbol() ? 1 : this.Symbol()<compared_obj.Symbol() ? -1 : 0);
  }
//+------------------------------------------------------------------+
//| Return the timeframe index in the list                           |
//+------------------------------------------------------------------+
int CTimeSeriesDE::IndexTimeframe(const ENUM_TIMEFRAMES timeframe)
  {
   const CSeriesDE *obj=new CSeriesDE(this.m_symbol,(timeframe==PERIOD_CURRENT ? (ENUM_TIMEFRAMES)::Period() : timeframe));
   if(obj==NULL)
      return WRONG_VALUE;
   this.m_list_series.Sort();
   int index=this.m_list_series.Search(obj);
   delete obj;
   return index;
  }
//+------------------------------------------------------------------+
//| Set a history depth of a specified timeseries                    |
//+------------------------------------------------------------------+
bool CTimeSeriesDE::SetRequiredUsedData(const ENUM_TIMEFRAMES timeframe,const uint required=0,const int rates_total=0)
  {
   if(this.m_symbol==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_TS_TEXT_FIRST_SET_SYMBOL));
      return false;
     }
   CSeriesDE *series_obj=this.m_list_series.At(this.IndexTimeframe(timeframe));
   return series_obj.SetRequiredUsedData(required,rates_total);
  }
//+------------------------------------------------------------------+
//| Set the history depth of all applied symbol timeseries           |
//+------------------------------------------------------------------+
bool CTimeSeriesDE::SetRequiredAllUsedData(const uint required=0,const int rates_total=0)
  {
   if(this.m_symbol==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_TS_TEXT_FIRST_SET_SYMBOL));
      return false;
     }
   bool res=true;
   int total=this.m_list_series.Total();
   for(int i=0;i<total;i++)
     {
      CSeriesDE *series_obj=this.m_list_series.At(i);
      if(series_obj==NULL)
         continue;
      res &=series_obj.SetRequiredUsedData(required,rates_total);
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Return the flag of data synchronization                          |
//| with the server data                                             |
//+------------------------------------------------------------------+
bool CTimeSeriesDE::SyncData(const ENUM_TIMEFRAMES timeframe,const int rates_total=0,const uint required=0)
  {
   if(this.m_symbol==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_TS_TEXT_FIRST_SET_SYMBOL));
      return false;
     }
   CSeriesDE *series_obj=this.m_list_series.At(this.IndexTimeframe(timeframe));
   if(series_obj==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_TS_FAILED_GET_SERIES_OBJ),this.m_symbol," ",TimeframeDescription(timeframe));
      return false;
     }
   return series_obj.SyncData(required,rates_total);
  }
//+------------------------------------------------------------------+
//| Return the flag of data synchronization                          |
//| of all timeseries with the server data                           |
//+------------------------------------------------------------------+
bool CTimeSeriesDE::SyncAllData(const int rates_total=0,const uint required=0)
  {
   if(this.m_symbol==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_TS_TEXT_FIRST_SET_SYMBOL));
      return false;
     }
   bool res=true;
   int total=this.m_list_series.Total();
   for(int i=0;i<total;i++)
     {
      CSeriesDE *series_obj=this.m_list_series.At(i);
      if(series_obj==NULL || !series_obj.IsAvailable())
         continue;
      res &=series_obj.SyncData(required,rates_total);
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Add the specified timeseries list to the list                    |
//+------------------------------------------------------------------+
bool CTimeSeriesDE::AddSeries(const ENUM_TIMEFRAMES timeframe,const uint required=0)
  {
   bool res=false;
   CSeriesDE *series=new CSeriesDE(this.m_symbol,timeframe,required);
   if(series==NULL)
      return res;
   this.m_list_series.Sort();
   if(this.m_list_series.Search(series)==WRONG_VALUE)
      res=this.m_list_series.Add(series);
   series.SetAvailable(true);
   if(!res)
      delete series;
   return res;
  }
//+------------------------------------------------------------------+
//| Create a specified timeseries list                               |
//+------------------------------------------------------------------+
bool CTimeSeriesDE::CreateSeries(const ENUM_TIMEFRAMES timeframe,const uint required=0)
  {
   CSeriesDE *series_obj=this.m_list_series.At(this.IndexTimeframe(timeframe));
   if(series_obj==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_TS_FAILED_GET_SERIES_OBJ),this.m_symbol," ",TimeframeDescription(timeframe));
      return false;
     }
   if(series_obj.RequiredUsedData()==0)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_BAR_TEXT_FIRS_SET_AMOUNT_DATA));
      return false;
     }
   return(series_obj.Create(required)>0);
  }
//+------------------------------------------------------------------+
//| Update a specified timeseries list                               |
//+------------------------------------------------------------------+
void CTimeSeriesDE::Refresh(const ENUM_TIMEFRAMES timeframe,SDataCalculate &data_calculate)
  {
//--- Reset the timeseries event flag and clear the list of all timeseries events
   this.m_is_event=false;
   this.m_list_events.Clear();
//--- Get the timeseries from the list by its timeframe
   CSeriesDE *series_obj=this.m_list_series.At(this.IndexTimeframe(timeframe));
   if(series_obj==NULL || series_obj.DataTotal()==0 || !series_obj.IsAvailable())
      return;
//--- Update the timeseries list
   series_obj.Refresh(data_calculate);
   datetime time=
     (
      this.m_program==PROGRAM_INDICATOR && series_obj.Symbol()==::Symbol() && series_obj.Timeframe()==(ENUM_TIMEFRAMES)::Period() ? 
      data_calculate.rates.time : 
      series_obj.LastBarDate()
     );
//--- If the timeseries object features the New bar event
   if(series_obj.IsNewBar(time))
     {
      //--- send the "New bar" event to the control program chart
      series_obj.SendEvent(SERIES_EVENTS_NEW_BAR);
      //--- set the values of the first date in history on the server and in the terminal
      this.SetTerminalServerDate();
      //--- add the "New bar" event to the list of timeseries events
      //--- in case of successful addition, set the event flag for the timeseries
      if(this.EventAdd(SERIES_EVENTS_NEW_BAR,time,series_obj.Timeframe(),series_obj.Symbol()))
         this.m_is_event=true;
         
      //--- Check skipped bars
      int missing=series_obj.GetNewBarObj().BarsBetweenNewBars();
      if(missing>1)
        {
         //--- send the "Bars skipped" event to the control program chart
         series_obj.SendEvent(SERIES_EVENTS_MISSING_BARS);
         //--- add the "Bars skipped" event to the list of timeseries events
         this.EventAdd(SERIES_EVENTS_MISSING_BARS,missing,series_obj.Timeframe(),series_obj.Symbol());
        }
     }
  }
//+------------------------------------------------------------------+
//| Update all timeseries lists                                      |
//+------------------------------------------------------------------+
void CTimeSeriesDE::RefreshAll(SDataCalculate &data_calculate)
  {
//--- Reset the flags indicating the necessity to set the first date in history on the server and in the terminal
//--- and the timeseries event flag, and clear the list of all timeseries events
   bool upd=false;
   this.m_is_event=false;
   this.m_list_events.Clear();
//--- In the loop by the list of all used timeseries,
   int total=this.m_list_series.Total();
   for(int i=0;i<total;i++) 
     {
      //--- get the next timeseries object by the loop index
      CSeriesDE *series_obj=this.m_list_series.At(i);
      if(series_obj==NULL || !series_obj.IsAvailable() || series_obj.DataTotal()==0)
         continue;
      //--- update the timeseries list
      series_obj.Refresh(data_calculate);
      datetime time=
        (
         this.m_program==PROGRAM_INDICATOR && series_obj.Symbol()==::Symbol() && series_obj.Timeframe()==(ENUM_TIMEFRAMES)::Period() ? 
         data_calculate.rates.time : 
         series_obj.LastBarDate()
        );
      //--- If the timeseries object features the New bar event
      if(series_obj.IsNewBar(time))
        {
         //--- send the "New bar" event to the control program chart,
         series_obj.SendEvent(SERIES_EVENTS_NEW_BAR);
         //--- set the flag indicating the necessity to set the first date in history on the server and in the terminal
         upd=true;
         //--- add the "New bar" event to the list of timeseries events
         //--- in case of successful addition, set the event flag for the timeseries
         if(this.EventAdd(SERIES_EVENTS_NEW_BAR,time,series_obj.Timeframe(),series_obj.Symbol()))
            this.m_is_event=true;
            
         //--- Check skipped bars
         int missing=series_obj.GetNewBarObj().BarsBetweenNewBars();
         if(missing>1)
           {
            //--- send the "Bars skipped" event to the control program chart
            series_obj.SendEvent(SERIES_EVENTS_MISSING_BARS);
            //--- add the "Bars skipped" event to the list of timeseries events
            this.EventAdd(SERIES_EVENTS_MISSING_BARS,missing,series_obj.Timeframe(),series_obj.Symbol());
           }
        }
     }
//--- if the flag indicating the necessity to set the first date in history on the server and in the terminal is enabled,
//--- set the values of the first date in history on the server and in the terminal
   if(upd)
      this.SetTerminalServerDate();
  }
//+------------------------------------------------------------------+
//| Copy the specified double property of the specified timeseries   |
//+------------------------------------------------------------------+
bool CTimeSeriesDE::CopyToBufferAsSeries(const ENUM_TIMEFRAMES timeframe,
                                         const ENUM_BAR_PROP_DOUBLE property,
                                         double &array[],
                                         const double empty=EMPTY_VALUE)
  {
   CSeriesDE *series=this.GetSeries(timeframe);
   if(series==NULL)
      return false;
   return series.CopyToBufferAsSeries(property,array,empty);
  }
//+------------------------------------------------------------------+
//| Display descriptions of all symbol timeseries in the journal     |
//+------------------------------------------------------------------+
void CTimeSeriesDE::Print(const bool full_prop=false,const bool created=false)
  {
   ::Print(CMessage::Text(MSG_LIB_TEXT_TS_TEXT_SYMBOL_TIMESERIES)," ",this.m_symbol,": ");
   for(int i=0;i<this.m_list_series.Total();i++)
     {
      CSeriesDE *series=this.m_list_series.At(i);
      if(series==NULL || (created && series.DataTotal()==0))
         continue;
      series.Print();
     }
  }
//+--------------------------------------------------------------------+
//| Display short descriptions of all symbol timeseries in the journal |
//+--------------------------------------------------------------------+
void CTimeSeriesDE::PrintShort(const bool dash=false,const bool created=false)
  {
   ::Print(CMessage::Text(MSG_LIB_TEXT_TS_TEXT_SYMBOL_TIMESERIES)," ",this.m_symbol,": ");
   for(int i=0;i<this.m_list_series.Total();i++)
     {
      CSeriesDE *series=this.m_list_series.At(i);
      if(series==NULL || (created && series.DataTotal()==0))
         continue;
      series.PrintShort();
     }
  }
//+------------------------------------------------------------------+
