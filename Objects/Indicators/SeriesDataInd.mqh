//+------------------------------------------------------------------+
//|                                                SeriesDataInd.mqh |
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
#include "..\..\Services\Select.mqh"
#include "..\..\Services\NewBarObj.mqh"
#include "DataInd.mqh"
//+------------------------------------------------------------------+
//| “Indicator data list” class                                      |
//+------------------------------------------------------------------+
class CSeriesDataInd : public CBaseObj
  {
private:
   ENUM_TIMEFRAMES   m_timeframe;                                       // Timeframe
   ENUM_INDICATOR    m_ind_type;                                        // Indicator type
   string            m_symbol;                                          // Symbol
   string            m_period_description;                              // Timeframe string description
   int               m_ind_handle;                                      // Indicator handle
   int               m_ind_id;                                          // Indicator ID
   int               m_buffers_total;                                   // Number of indicator buffers
   uint              m_amount;                                          // Amount of applied timeseries data
   uint              m_required;                                        // Required amount of applied timeseries data
   uint              m_bars;                                            // Number of bars in history by symbol and timeframe
   bool              m_sync;                                            // Synchronized data flag
   CArrayObj         m_list_data;                                       // Indicator data list
   CNewBarObj        m_new_bar_obj;                                     // "New bar" object
//--- Create a new indicator data object, return pointer to it
   CDataInd         *CreateNewDataInd(const int buffer_num,const datetime time,const double value);
   
public:
//--- Return (1) oneself, (2) the full list of indicator data
   CSeriesDataInd   *GetObject(void)                                    { return &this;               }
   CArrayObj        *GetList(void)                                      { return &this.m_list_data;   }

//--- Return the list of indicator data by selected (1) double, (2) integer and (3) string property fitting a compared condition
   CArrayObj        *GetList(ENUM_IND_DATA_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode=EQUAL){ return CSelect::ByIndicatorDataProperty(this.GetList(),property,value,mode); }
   CArrayObj        *GetList(ENUM_IND_DATA_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByIndicatorDataProperty(this.GetList(),property,value,mode); }
   CArrayObj        *GetList(ENUM_IND_DATA_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode=EQUAL){ return CSelect::ByIndicatorDataProperty(this.GetList(),property,value,mode); }

//--- Return indicator data object by (1) time, (2) bar number and buffer number
   CDataInd         *GetIndDataByTime(const int buffer_num,const datetime time);
   CDataInd         *GetIndDataByBar(const int buffer_num,const uint shift);
   
//--- Set (1) symbol, (2) timeframe, (3) symbol and timeframe, (4) amount of applied timeseries data,
//--- (5) handle, (6) ID, (7) number of indicator buffers
   void              SetSymbol(const string symbol);
   void              SetTimeframe(const ENUM_TIMEFRAMES timeframe);
   void              SetSymbolPeriod(const string symbol,const ENUM_TIMEFRAMES timeframe);
   bool              SetRequiredUsedData(const uint required);
   void              SetIndHandle(const int handle)                              { this.m_ind_handle=handle;   }
   void              SetIndID(const int id)                                      { this.m_ind_id=id;           }
   void              SetIndBuffersTotal(const int total)                         { this.m_buffers_total=total; }

//--- Return (1) symbol, (2) timeframe, number of (3) used and (4) requested timeseries data,
//--- (5) number of bars in timeseries, (6) handle, (7) ID, (8) number of indicator buffers
   string            Symbol(void)                                          const { return this.m_symbol;                            }
   ENUM_TIMEFRAMES   Timeframe(void)                                       const { return this.m_timeframe;                         }
   ulong             AvailableUsedData(void)                               const { return this.m_amount;                            }
   ulong             RequiredUsedData(void)                                const { return this.m_required;                          }
   ulong             Bars(void)                                            const { return this.m_bars;                              }
   int               IndHandle(void)                                       const { return this.m_ind_handle;                        }
   int               IndID(void)                                           const { return this.m_ind_id;                            }
   int               IndBuffersTotal(void)                                 const { return this.m_buffers_total;                     }
   bool              IsNewBar(const datetime time)                               { return this.m_new_bar_obj.IsNewBar(time);        }
   bool              IsNewBarManual(const datetime time)                         { return this.m_new_bar_obj.IsNewBarManual(time);  }

//--- Return real list size
   int               DataTotal(void)                                       const { return this.m_list_data.Total();                 }
 
//--- Save the new bar time during the manual time management
   void              SaveNewBarTime(const datetime time)                         { this.m_new_bar_obj.SaveNewBarTime(time);         }
   
//--- (1) Create, (2) update the indicator data list
   int               Create(const uint required=0);
   void              Refresh(void);

//--- Return data of specified indicator buffer by (1) open time, (2) bar index
   double            BufferValue(const int buffer_num,const datetime time);
   double            BufferValue(const int buffer_num,const uint shift);

//--- Constructors
                     CSeriesDataInd(void){ this.m_type=OBJECT_DE_TYPE_IND_DATA_LIST; }
                     CSeriesDataInd(const int handle,
                                    const ENUM_INDICATOR ind_type,
                                    const int ind_id,
                                    const int buffers_total,
                                    const string symbol,const ENUM_TIMEFRAMES timeframe,const uint required=0);
  };
//+------------------------------------------------------------------+
//| Parametric constructor                                           |
//+------------------------------------------------------------------+
CSeriesDataInd::CSeriesDataInd(const int handle,
                               const ENUM_INDICATOR ind_type,
                               const int ind_id,
                               const int buffers_total,
                               const string symbol,const ENUM_TIMEFRAMES timeframe,const uint required=0) :
                               m_bars(0), m_amount(0),m_required(0),m_sync(false)
  {
//--- Set the object type
   this.m_type=OBJECT_DE_TYPE_IND_DATA_LIST; 
//--- Clear the list and set for it the flag of the list sorted by time
   this.m_list_data.Clear();
   this.m_list_data.Sort(SORT_BY_IND_DATA_TIME);
//--- Set values for all object variables
   this.SetSymbolPeriod(symbol,timeframe);
   this.m_sync=this.SetRequiredUsedData(required);
   this.m_period_description=TimeframeDescription(this.m_timeframe);
   this.m_ind_handle=handle;
   this.m_ind_type=ind_type;
   this.m_ind_id=ind_id;
   this.m_buffers_total=buffers_total;
  }
//+------------------------------------------------------------------+
//| Set a symbol                                                     |
//+------------------------------------------------------------------+
void CSeriesDataInd::SetSymbol(const string symbol)
  {
   if(this.m_symbol==symbol)
      return;
   this.m_symbol=(symbol==NULL || symbol=="" ? ::Symbol() : symbol);
  }
//+------------------------------------------------------------------+
//| Set a timeframe                                                  |
//+------------------------------------------------------------------+
void CSeriesDataInd::SetTimeframe(const ENUM_TIMEFRAMES timeframe)
  {
   if(this.m_timeframe==timeframe)
      return;
   this.m_timeframe=(timeframe==PERIOD_CURRENT ? (ENUM_TIMEFRAMES)::Period() : timeframe);
  }
//+------------------------------------------------------------------+
//| Set a symbol and timeframe                                       |
//+------------------------------------------------------------------+
void CSeriesDataInd::SetSymbolPeriod(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   this.SetSymbol(symbol);
   this.SetTimeframe(timeframe);
  }
//+------------------------------------------------------------------+
//| Set the number of required data                                  |
//+------------------------------------------------------------------+
bool CSeriesDataInd::SetRequiredUsedData(const uint required)
  {
//--- If this is indicator program - report and leave
   if(this.m_program==PROGRAM_INDICATOR)
     {
      ::Print(CMessage::Text(MSG_LIB_TEXT_METHOD_NOT_FOR_INDICATORS));
      return false;
     }
//--- Set the necessary amount of data - if less than 1 is passed use by default (1000), or else - the passed value
   this.m_required=(required<1 ? SERIES_DEFAULT_BARS_COUNT : required);
//--- Launch download of historical data (relevant for the “cold” start)
   datetime array[1];
   ::CopyTime(this.m_symbol,this.m_timeframe,0,1,array);
//--- Set the number of available timeseries bars
   this.m_bars=(uint)::SeriesInfoInteger(this.m_symbol,this.m_timeframe,SERIES_BARS_COUNT);
//--- If succeeded to set the number of available history bars, set the amount of data in the list:
   if(this.m_bars>0)
     {
      //--- if zero 'required' value is passed,
      //--- use either the default value (1000 bars) or the number of available history bars - the least one of them
      //--- if non-zero 'required' value is passed,
      //--- use either the 'required' value or the number of available history bars - the least one of them
      this.m_amount=(required==0 ? ::fmin(SERIES_DEFAULT_BARS_COUNT,this.m_bars) : ::fmin(required,this.m_bars));
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Create a new indicator data object, return the pointer           |
//+------------------------------------------------------------------+
CDataInd* CSeriesDataInd::CreateNewDataInd(const int buffer_num,const datetime time,const double value)
  {
   CDataInd* data_ind=new CDataInd(this.m_ind_type,this.m_ind_handle,this.m_ind_id,buffer_num,this.m_symbol,this.m_timeframe,time,value);
   return data_ind;
  }
//+------------------------------------------------------------------+
//| Create indicator data timeseries list                            |
//+------------------------------------------------------------------+
int CSeriesDataInd::Create(const uint required=0)
  {
//--- If this is indicator program - report and leave
   if(this.m_program==PROGRAM_INDICATOR)
     {
      ::Print(CMessage::Text(MSG_LIB_TEXT_METHOD_NOT_FOR_INDICATORS));
      return false;
     }
//--- If the required history depth is not set for the list yet,
//--- display the appropriate message and return zero,
   if(this.m_amount==0)
     {
      ::Print(DFUN,this.m_symbol," ",TimeframeDescription(this.m_timeframe),": ",CMessage::Text(MSG_LIB_TEXT_BAR_TEXT_FIRS_SET_AMOUNT_DATA));
      return 0;
     }
//--- otherwise, if the passed 'required' value exceeds zero and is not equal to the one already set, 
//--- while the passed ‘required’ value is less than the available bar number,
//--- set the new value of the required history depth for the list
   else if(required>0 && this.m_amount!=required && required<this.m_bars)
     {
      //--- If failed to set a new value, return zero
      if(!this.SetRequiredUsedData(required))
         return 0;
     }
//--- For the data[] array we are to receive historical data to,
//--- set the flag of direction like in the timeseries,
//--- clear the list of indicator data objects and set the flag of sorting by timeseries bar time
   double data[];
   ::ArraySetAsSeries(data,true);
   this.m_list_data.Clear();
   this.m_list_data.Sort(SORT_BY_IND_DATA_TIME);
   ::ResetLastError();

   int err=ERR_SUCCESS;
//--- In a loop by the number of indicator data buffers
   for(int i=0;i<this.m_buffers_total;i++)
     {
      //--- Get historical data of i buffer of indicator to data[] array  starting from the current bar in the amount of m_amount,
      //--- if failed to get data, display the appropriate message and return zero
      int copied=::CopyBuffer(this.m_ind_handle,i,0,this.m_amount,data);
      if(copied<1)
        {
         err=::GetLastError();
         ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_IND_DATA_FAILED_GET_SERIES_DATA)," ",this.m_symbol," ",TimeframeDescription(this.m_timeframe),". ",
                      CMessage::Text(MSG_LIB_SYS_ERROR),": ",CMessage::Text(err),CMessage::Retcode(err));
         return 0;
        }
      //--- In the loop by amount of required data
      for(int j=0;j<(int)this.m_amount;j++)
        {
         //--- Get time of j bar
         ::ResetLastError();
         datetime time=::iTime(this.m_symbol,this.m_timeframe,j);
         //--- If failed to get time
         //--- display the appropriate message with the error description in the journal and move on to the next loop iteration by data (j)
         if(time==0)
           {
            err=::GetLastError();
            ::Print( DFUN,CMessage::Text(MSG_LIB_SYS_ERROR_FAILED_GET_TIME),CMessage::Text(err),CMessage::Retcode(err));
            continue;
           }
         //--- If failed to create a new indicator data object from i buffer
         //--- display the appropriate message with the error description in the journal and move on to the next loop iteration by data (j)
         CDataInd* data_ind=CreateNewDataInd(i,time,data[j]);
         if(data_ind==NULL)
           {
            err=::GetLastError();
            ::Print
              (
               DFUN,CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_IND_DATA_OBJ)," ",::TimeToString(time),". ",
               CMessage::Text(MSG_LIB_SYS_ERROR),": ",CMessage::Text(err),CMessage::Retcode(err)
              );
            continue;
           }
         //--- If failed to add a new indicator data object to list
         //--- display the appropriate message with the error description in the journal, remove data object
         //--- and move on to the next loop iteration by data
         if(!this.m_list_data.Add(data_ind))
           {
            err=::GetLastError();
            ::Print
              (
               DFUN,CMessage::Text(MSG_LIB_TEXT_IND_DATA_FAILED_ADD_TO_LIST)," ",::TimeToString(time),". ",
               CMessage::Text(MSG_LIB_SYS_ERROR),": ",CMessage::Text(err),CMessage::Retcode(err)
              );
            delete data_ind;
            continue;
           }
        }
     }
//--- Return the size of the created list of indicator data objects
   return this.m_list_data.Total();
  }
//+------------------------------------------------------------------+
//| Update indicator data timeseries list and data                   |
//+------------------------------------------------------------------+
void CSeriesDataInd::Refresh(void)
  {
//--- If this is indicator program - report and leave
   if(this.m_program==PROGRAM_INDICATOR)
     {
      ::Print(CMessage::Text(MSG_LIB_TEXT_METHOD_NOT_FOR_INDICATORS));
      return;
     }
//--- If indicator data timeseries is not used, exit
   if(!this.m_available)
      return;
   double data[1];
   
//--- Get the current bar time
   int err=ERR_SUCCESS;
   ::ResetLastError();
   datetime time=::iTime(this.m_symbol,this.m_timeframe,0);
   //--- If failed to get time
   //--- display the appropriate message with the error description in the journal and exit
   if(time==0)
     {
      err=::GetLastError();
      ::Print( DFUN,CMessage::Text(MSG_LIB_SYS_ERROR_FAILED_GET_TIME),CMessage::Text(err),CMessage::Retcode(err));
      return;
     }
   
//--- Set the flag of sorting the data list by time
   this.m_list_data.Sort(SORT_BY_IND_DATA_TIME);
//--- If a new bar is present on a symbol and period
   if(this.IsNewBarManual(time))
     {
      //--- create new indicator data objects by the number of buffers and add them to the list end
      for(int i=0;i<this.m_buffers_total;i++)
        {
         //--- Get data of the current bar of indicator’s i buffer to data[] array,
         //--- if failed to get data, display the appropriate message and exit
         int copied=::CopyBuffer(this.m_ind_handle,i,0,1,data);
         if(copied<1)
           {
            err=::GetLastError();
            ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_IND_DATA_FAILED_GET_CURRENT_DATA)," ",this.m_symbol," ",TimeframeDescription(this.m_timeframe),". ",
                         CMessage::Text(MSG_LIB_SYS_ERROR),": ",CMessage::Text(err),CMessage::Retcode(err));
            return;
           }
         //--- Create a new data object of indicator’s i buffer
         CDataInd* data_ind=CreateNewDataInd(i,time,data[0]);
         if(data_ind==NULL)
            return;
         //--- If the created object was not added to the list - remove this object and exit from the method
         if(!this.m_list_data.InsertSort(data_ind))
           {
            delete data_ind;
            return;
           }
        }
      //--- if the size of indicator data timeseries has ecxeeded the requested number of bars, remove the earliest data object
      if(this.m_list_data.Total()>(int)this.m_required)
         this.m_list_data.Delete(0);
      //--- save the new bar time as the previous one for the subsequent new bar check
      this.SaveNewBarTime(time);
     }
 
//--- Get the list of indicator data objects by the time of current bar start
   CArrayObj *list=CSelect::ByIndicatorDataProperty(this.GetList(),IND_DATA_PROP_TIME,time,EQUAL);
//--- In the loop, by the number of indicator buffers get indicator data objects from the list by loop index
   for(int i=0;i<this.m_buffers_total;i++)
     {
      //--- If failed to get object from the list - exit
      CDataInd *data_ind=this.GetIndDataByTime(i,time);
      if(data_ind==NULL)
         return;
      //--- Copy data of indicator’s i buffer from current bar
      int copied=::CopyBuffer(this.m_ind_handle,i,0,1,data);
      if(copied<1)
        {
         err=::GetLastError();
         ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_IND_DATA_FAILED_GET_CURRENT_DATA)," ",this.m_symbol," ",TimeframeDescription(this.m_timeframe),". ",
                      CMessage::Text(MSG_LIB_SYS_ERROR),": ",CMessage::Text(err),CMessage::Retcode(err));
         return;
        }
      //--- Add received value of indicator’s i buffer to indicator data object
      data_ind.SetBufferValue(data[0]);
     }
  }
//+------------------------------------------------------------------+
//| Return indicator data object by time and buffer number           |
//+------------------------------------------------------------------+
CDataInd* CSeriesDataInd::GetIndDataByTime(const int buffer_num,const datetime time)
  {
   CArrayObj *list=GetList(IND_DATA_PROP_TIME,time,EQUAL);
   list=CSelect::ByIndicatorDataProperty(list,IND_DATA_PROP_IND_BUFFER_NUM,buffer_num,EQUAL);
   return list.At(0);
  }
//+------------------------------------------------------------------+
//| Return indicator data object by bar and buffer number            |
//+------------------------------------------------------------------+
CDataInd* CSeriesDataInd::GetIndDataByBar(const int buffer_num,const uint shift)
  {
   datetime time=::iTime(this.m_symbol,this.m_timeframe,(int)shift);
   if(time==0)
      return NULL;
   return this.GetIndDataByTime(buffer_num,time);
  }
//+------------------------------------------------------------------+
//| Return data of specified indicator buffer by time                |
//+------------------------------------------------------------------+
double CSeriesDataInd::BufferValue(const int buffer_num,const datetime time)
  {
   CDataInd *data_ind=this.GetIndDataByTime(buffer_num,time);
   return(data_ind==NULL ? EMPTY_VALUE : data_ind.BufferValue());
  }
//+------------------------------------------------------------------+
//| Return data of specified indicator buffer by bar index           |
//+------------------------------------------------------------------+
double CSeriesDataInd::BufferValue(const int buffer_num,const uint shift)
  {
   CDataInd *data_ind=this.GetIndDataByBar(buffer_num,shift);
   return(data_ind==NULL ? EMPTY_VALUE : data_ind.BufferValue());
  }
//+------------------------------------------------------------------+
