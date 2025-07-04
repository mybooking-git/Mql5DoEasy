//+------------------------------------------------------------------+
//|                                                   TickSeries.mqh |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
#property strict    // Necessary for mql4
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "..\..\Services\Select.mqh"
#include "NewTickObj.mqh"
#include "DataTick.mqh"
//+------------------------------------------------------------------+
//| "Tick data series" class                                         |
//+------------------------------------------------------------------+
class CTickSeries : public CBaseObj
  {
private:
   string            m_symbol;                                          // Symbol
   ulong             m_last_time;                                       // Last tick time
   uint              m_amount;                                          // Amount of applied tick series data
   uint              m_required;                                        // Required number of days for tick series data
   CArrayObj         m_list_ticks;                                      // List of tick data
   CNewTickObj       m_new_tick_obj;                                    // "New tick" object
//--- Create a new tick data object
   CDataTick        *CreateNewTickObj(const MqlTick &tick);

public:
//--- Return (1) itself, (2) list of tick data and (3) "New tick" object of the tick series
   CTickSeries      *GetObject(void)                                    { return &this;               }
   CArrayObj        *GetList(void)                                      { return &m_list_ticks;       }
   CNewTickObj      *GetNewTickObj(void)                                { return &this.m_new_tick_obj;}

//--- Return the list of tick objects by selected (1) double, (2) integer and (3) string property fitting a compared condition
   CArrayObj        *GetList(ENUM_TICK_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode=EQUAL){ return CSelect::ByTickDataProperty(this.GetList(),property,value,mode); }
   CArrayObj        *GetList(ENUM_TICK_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByTickDataProperty(this.GetList(),property,value,mode); }
   CArrayObj        *GetList(ENUM_TICK_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode=EQUAL){ return CSelect::ByTickDataProperty(this.GetList(),property,value,mode); }
//--- Return the object of tick data by (1) index in the list, (2) time,
//--- (3) time in milliseconds, (4) the last one in the list and (5) the list size
   CDataTick        *GetTickByListIndex(const uint index);
   CDataTick        *GetTick(const datetime time); 
   CDataTick        *GetTick(const ulong time_msc); 
   CDataTick        *GetLastTick(void); 
   int               DataTotal(void)                              const { return this.m_list_ticks.Total();       }

//--- The comparison method for searching identical tick series objects by a symbol
   virtual int       Compare(const CObject *node,const int mode=0) const 
                       {   
                        const CTickSeries *compared_obj=node;
                        return(this.Symbol()==compared_obj.Symbol() ? 0 : this.Symbol()>compared_obj.Symbol() ? 1 : -1);
                       } 
//--- Return the tick series name
   string            Header(void);
//--- Display (1) the tick series description and (2) the tick series short description in the journal
   virtual void      Print(const bool full_prop=false,const bool dash=false);
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);

//--- Constructors
                     CTickSeries(void){ this.m_type=OBJECT_DE_TYPE_TICKSERIES; }
                     CTickSeries(const string symbol,const uint required=0);

//+------------------------------------------------------------------+ 
//| Methods of working with objects and accessing their properties   |
//+------------------------------------------------------------------+
//--- Set (1) a symbol and (2) a number of used tick series data
   void              SetSymbol(const string symbol);                     
   void              SetRequiredUsedDays(const uint required=0);

//--- Return (1) symbol, (2) number of used, (3) requested tick data and (4) new tick flag
   string            Symbol(void)                                 const { return this.m_symbol;                   }
   ulong             AvailableUsedData(void)                      const { return this.m_amount;                   }
   ulong             RequiredUsedDays(void)                       const { return this.m_required;                 }
   bool              IsNewTick(void)                                    { return this.m_new_tick_obj.IsNewTick(); }

//--- Return (1) Bid, (2) Ask, (3) Last, (4) volume with increased accuracy,
//--- (5) spread, (6) volume, (7) tick flags, (8) time, (9) time in milliseconds by index in the list
   double            Bid(const uint index);
   double            Ask(const uint index);
   double            Last(const uint index);
   double            VolumeReal(const uint index);
   double            Spread(const uint index);
   long              Volume(const uint index);
   uint              Flags(const uint index);
   datetime          Time(const uint index);
   long              TimeMSC(const uint index);
   
//--- Return (1) Bid, (2) Ask, (3) Last, (4) volume with increased accuracy,
//--- (5) spread, (6) volume, (7) tick flags by tick time in milliseconds
   double            Bid(const ulong time_msc);
   double            Ask(const ulong time_msc);
   double            Last(const ulong time_msc);
   double            VolumeReal(const ulong time_msc);
   double            Spread(const ulong time_msc);
   long              Volume(const ulong time_msc);
   uint              Flags(const ulong time_msc);
   
//--- Return (1) Bid, (2) Ask, (3) Last, (4) volume with increased accuracy,
//--- (5) spread, (6) volume and (7) tick flags by tick time
   double            Bid(const datetime time);
   double            Ask(const datetime time);
   double            Last(const datetime time);
   double            VolumeReal(const datetime time);
   double            Spread(const datetime time);
   long              Volume(const datetime time);
   uint              Flags(const datetime time);

//--- (1) Create and (2) update the tick series list
   int               Create(const uint required=0);
   void              Refresh(void);
  };
//+------------------------------------------------------------------+
//| Parametric constructor                                           |
//+------------------------------------------------------------------+
CTickSeries::CTickSeries(const string symbol,const uint required=0) : m_symbol(symbol),m_last_time(0)
  {
   this.m_type=OBJECT_DE_TYPE_TICKSERIES; 
   this.m_list_ticks.Clear();
   this.m_list_ticks.Sort(SORT_BY_TICK_TIME_MSC);
   this.SetRequiredUsedDays(required);
   this.m_new_tick_obj.SetSymbol(this.m_symbol);
   this.m_new_tick_obj.Refresh();
  }
//+------------------------------------------------------------------+
//| Set a symbol                                                     |
//+------------------------------------------------------------------+
void CTickSeries::SetSymbol(const string symbol)
  {
   if(this.m_symbol==symbol)
      return;
   this.m_symbol=(symbol==NULL || symbol=="" ? ::Symbol() : symbol);
  }
//+------------------------------------------------------------------+
//| Set the number of required tick data                             |
//+------------------------------------------------------------------+
void CTickSeries::SetRequiredUsedDays(const uint required=0)
  {
   this.m_required=(required<1 ? TICKSERIES_DEFAULT_DAYS_COUNT : required);
  }
//+------------------------------------------------------------------+
//| Create the series list of tick data                              |
//+------------------------------------------------------------------+
int CTickSeries::Create(const uint required=0)
  {
//--- If the tick series is not used, inform of that and exit
   if(!this.m_available)
     {
      ::Print(DFUN,this.m_symbol,": ",CMessage::Text(MSG_TICKSERIES_TEXT_IS_NOT_USE));
      return false;
     }
//--- Declare the ticks[] array we are to receive historical data to,
//--- clear the list of tick data objects and set the flag of sorting by time in milliseconds
   MqlTick ticks_array[];
   this.m_list_ticks.Clear();
   this.m_list_ticks.Sort(SORT_BY_TICK_TIME_MSC);
   this.m_last_time=0;
   ::ResetLastError();
   int err=ERR_SUCCESS;
//--- Calculate the day start time in milliseconds the ticks should be copied from
   MqlDateTime date_str={0};
   datetime date=::iTime(m_symbol,PERIOD_D1,this.m_required);
   ::TimeToStruct(date,date_str);
   date_str.hour=date_str.min=date_str.sec=0;
   date=::StructToTime(date_str);
   long date_from=(long)date*1000;
   if(date_from<1) date_from=1;
//--- Get historical data of the MqlTick structure to the tick[] array
//--- from the calculated date to the current time and save the obtained number in m_amount.
//--- If failed to get data, display the appropriate message and return zero
   this.m_amount=::CopyTicksRange(m_symbol,ticks_array,COPY_TICKS_ALL,date_from);
   if(this.m_amount<1)
     {
      err=::GetLastError();
      ::Print(DFUN,CMessage::Text(MSG_TICKSERIES_ERR_GET_TICK_DATA),": ",CMessage::Text(err),CMessage::Retcode(err));
      return 0;
     }
//--- Historical data is received in the rates[] array
//--- In the ticks[] array loop
   for(int i=0; i<(int)this.m_amount; i++)
     {
      //--- Create the tick object and add it to the list
      CDataTick *tick_obj=this.CreateNewTickObj(ticks_array[i]);
      if(tick_obj==NULL)
         continue;
      //--- If the tick time exceeds the previous one, write the new tick time to m_last_time as the starting one
      //--- to copy the newly arrived ticks in the tick series update method
      if(this.m_last_time<(ulong)tick_obj.TimeMSC())
         this.m_last_time=tick_obj.TimeMSC();
     }
//--- Return the size of the created tick object list
   return this.m_list_ticks.Total();
  }
//+------------------------------------------------------------------+
//| Update the tick series list                                      |
//+------------------------------------------------------------------+
void CTickSeries::Refresh(void)
  {
   MqlTick ticks_array[];
   if(IsNewTick())
     {
      //--- Copy ticks from m_last_time time+1 ms to the end of history
      int err=ERR_SUCCESS;
      int total=::CopyTicksRange(this.Symbol(),ticks_array,COPY_TICKS_ALL,this.m_last_time+1,0);
      //--- If the ticks have been copied, create new tick data objects and add them to the list in the loop by their number
      if(total>0)
        {
         for(int i=0;i<total;i++)
           {
            //--- Create the tick object and add it to the list
            CDataTick *tick_obj=this.CreateNewTickObj(ticks_array[i]);
            if(tick_obj==NULL)
               break;
            //--- Write the last tick time for subsequent copying of newly arrived ticks
            this.m_last_time=ticks_array[::ArraySize(ticks_array)-1].time_msc;
           }
         //--- If the number of ticks in the list exceeds the default maximum number,
         //--- remove the calculated number of tick objects from the end of the list
         if(this.DataTotal()>TICKSERIES_MAX_DATA_TOTAL)
           {
            int total_del=m_list_ticks.Total()-TICKSERIES_MAX_DATA_TOTAL;
            for(int j=0;j<total_del;j++)
               this.m_list_ticks.Delete(j);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Create a new tick data object                                    |
//+------------------------------------------------------------------+
CDataTick *CTickSeries::CreateNewTickObj(const MqlTick &tick)
  {
   //--- create a new object of tick data out of the MqlTick structure passed to the method
   int err=ERR_SUCCESS;
   ::ResetLastError();
   //--- If failed to create an object, inform of that and return NULL
   CDataTick* tick_obj=new CDataTick(this.m_symbol,tick);
   if(tick_obj==NULL)
     {
      ::Print
        (
         DFUN,CMessage::Text(MSG_TICKSERIES_FAILED_CREATE_TICK_DATA_OBJ)," ",this.Header()," ",::TimeMSCtoString(tick.time_msc),". ",
         CMessage::Text(MSG_LIB_SYS_ERROR),": ",CMessage::Text(::GetLastError())
        );
      return NULL;
     }
   //--- If failed to add a new tick data object to the list
   //--- display the appropriate message with the error description in the journal,
   //--- remove the newly created object and return NULL
   this.m_list_ticks.Sort();
   if(!this.m_list_ticks.InsertSort(tick_obj))
     {
      err=::GetLastError();
      ::Print(DFUN,CMessage::Text(MSG_TICKSERIES_FAILED_ADD_TO_LIST)," ",tick_obj.Header()," ",
                   CMessage::Text(MSG_LIB_SYS_ERROR),": ",CMessage::Text(err),CMessage::Retcode(err));
      delete tick_obj;
      return NULL;
     }
   //--- Return the pointer to the tick data object that was created and added to the list
   return tick_obj;
  }
//+------------------------------------------------------------------+
//| Return the tick object by its index in the list                  |
//+------------------------------------------------------------------+
CDataTick *CTickSeries::GetTickByListIndex(const uint index)
  {
   return this.m_list_ticks.At(index);
  }
//+------------------------------------------------------------------+
//| Return the last tick object by its time                          |
//+------------------------------------------------------------------+
CDataTick *CTickSeries::GetTick(const datetime time)
  {
   CArrayObj *list=GetList(TICK_PROP_TIME,time,EQUAL);
   if(list==NULL) return NULL;
   return list.At(list.Total()-1);
  }
//+------------------------------------------------------------------+
//| Return the last tick object by its time in milliseconds          |
//+------------------------------------------------------------------+
CDataTick *CTickSeries::GetTick(const ulong time_msc)
  {
   CArrayObj *list=GetList(TICK_PROP_TIME_MSC,time_msc,EQUAL);
   if(list==NULL) return NULL;
   return list.At(list.Total()-1);
  }
//+------------------------------------------------------------------+
//| Return the most recent tick data object from the list            |
//+------------------------------------------------------------------+
CDataTick *CTickSeries::GetLastTick(void)
  {
   return this.m_list_ticks.At(this.m_list_ticks.Total()-1);
  }
//+------------------------------------------------------------------+
//| Return tick's Bid by index in the list                           |
//+------------------------------------------------------------------+
double CTickSeries::Bid(const uint index)
  {
   CDataTick *tick=this.GetTickByListIndex(index);
   return(tick!=NULL ? tick.Bid() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's Bid by time in milliseconds                        |
//+------------------------------------------------------------------+
double CTickSeries::Bid(const ulong time_msc)
  {
   CDataTick *tick=this.GetTick(time_msc);
   return(tick!=NULL ? tick.Bid() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's Bid by time                                        |
//+------------------------------------------------------------------+
double CTickSeries::Bid(const datetime time)
  {
   CDataTick *tick=this.GetTick(time);
   return(tick!=NULL ? tick.Bid() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's Ask by index in the list                           |
//+------------------------------------------------------------------+
double CTickSeries::Ask(const uint index)
  {
   CDataTick *tick=this.GetTickByListIndex(index);
   return(tick!=NULL ? tick.Ask() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's Ask by time in milliseconds                        |
//+------------------------------------------------------------------+
double CTickSeries::Ask(const ulong time_msc)
  {
   CDataTick *tick=this.GetTick(time_msc);
   return(tick!=NULL ? tick.Ask() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's Ask by time                                        |
//+------------------------------------------------------------------+
double CTickSeries::Ask(const datetime time)
  {
   CDataTick *tick=this.GetTick(time);
   return(tick!=NULL ? tick.Ask() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's Last by index in the list                          |
//+------------------------------------------------------------------+
double CTickSeries::Last(const uint index)
  {
   CDataTick *tick=this.GetTickByListIndex(index);
   return(tick!=NULL ? tick.Last() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's Last by time in milliseconds                       |
//+------------------------------------------------------------------+
double CTickSeries::Last(const ulong time_msc)
  {
   CDataTick *tick=this.GetTick(time_msc);
   return(tick!=NULL ? tick.Last() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's Last by time                                       |
//+------------------------------------------------------------------+
double CTickSeries::Last(const datetime time)
  {
   CDataTick *tick=this.GetTick(time);
   return(tick!=NULL ? tick.Last() : 0);
  } 
//+-------------------------------------------------------------------------+
//| Return the volume with the increased tick accuracy by index in the list |
//+-------------------------------------------------------------------------+
double CTickSeries::VolumeReal(const uint index)
  {
   CDataTick *tick=this.GetTickByListIndex(index);
   return(tick!=NULL ? tick.VolumeReal() : 0);
  } 
//+--------------------------------------------------------------------------+
//|Return the volume with the increased tick accuracy by time in milliseconds|
//+--------------------------------------------------------------------------+
double CTickSeries::VolumeReal(const ulong time_msc)
  {
   CDataTick *tick=this.GetTick(time_msc);
   return(tick!=NULL ? tick.VolumeReal() : 0);
  } 
//+------------------------------------------------------------------+
//| Return the volume with the increased tick accuracy by time       |
//+------------------------------------------------------------------+
double CTickSeries::VolumeReal(const datetime time)
  {
   CDataTick *tick=this.GetTick(time);
   return(tick!=NULL ? tick.VolumeReal() : 0);
  } 
//+------------------------------------------------------------------+
//| Return the tick spread by index in the list                      |
//+------------------------------------------------------------------+
double CTickSeries::Spread(const uint index)
  {
   CDataTick *tick=this.GetTickByListIndex(index);
   return(tick!=NULL ? tick.Spread() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's spread by time in milliseconds                     |
//+------------------------------------------------------------------+
double CTickSeries::Spread(const ulong time_msc)
  {
   CDataTick *tick=this.GetTick(time_msc);
   return(tick!=NULL ? tick.Spread() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's spread by time                                     |
//+------------------------------------------------------------------+
double CTickSeries::Spread(const datetime time)
  {
   CDataTick *tick=this.GetTick(time);
   return(tick!=NULL ? tick.Spread() : 0);
  } 
//+------------------------------------------------------------------+
//| Return the tick volume by index in the list                      |
//+------------------------------------------------------------------+
long CTickSeries::Volume(const uint index)
  {
   CDataTick *tick=this.GetTickByListIndex(index);
   return(tick!=NULL ? tick.Volume() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's volume by time in milliseconds                     |
//+------------------------------------------------------------------+
long CTickSeries::Volume(const ulong time_msc)
  {
   CDataTick *tick=this.GetTick(time_msc);
   return(tick!=NULL ? tick.Volume() : 0);
  } 
//+------------------------------------------------------------------+
//| Return tick's volume by time                                     |
//+------------------------------------------------------------------+
long CTickSeries::Volume(const datetime time)
  {
   CDataTick *tick=this.GetTick(time);
   return(tick!=NULL ? tick.Volume() : 0);
  } 
//+------------------------------------------------------------------+
//| Return the tick flags by index in the list                       |
//+------------------------------------------------------------------+
uint CTickSeries::Flags(const uint index)
  {
   CDataTick *tick=this.GetTickByListIndex(index);
   return(tick!=NULL ? tick.Flags() : 0);
  } 
//+------------------------------------------------------------------+
//| Return the tick flags by time in milliseconds                    |
//+------------------------------------------------------------------+
uint CTickSeries::Flags(const ulong time_msc)
  {
   CDataTick *tick=this.GetTick(time_msc);
   return(tick!=NULL ? tick.Flags() : 0);
  } 
//+------------------------------------------------------------------+
//| Return the tick flags by time                                    |
//+------------------------------------------------------------------+
uint CTickSeries::Flags(const datetime time)
  {
   CDataTick *tick=this.GetTick(time);
   return(tick!=NULL ? tick.Flags() : 0);
  } 
//+------------------------------------------------------------------+
//| Return the tick series name                                      |
//+------------------------------------------------------------------+
string CTickSeries::Header(void)
  {
   return CMessage::Text(MSG_TICKSERIES_TEXT_TICKSERIES)+" \""+this.m_symbol+"\"";
  }
//+------------------------------------------------------------------+
//| Display the tick series description in the journal               |
//+------------------------------------------------------------------+
void CTickSeries::Print(const bool full_prop=false,const bool dash=false)
  {
   string txt=
     (
      CMessage::Text(MSG_TICKSERIES_REQUIRED_HISTORY_DAYS)+(string)this.RequiredUsedDays()+", "+
      CMessage::Text(MSG_LIB_TEXT_TS_AMOUNT_HISTORY_DATA)+(string)this.DataTotal()
     );
   ::Print(this.Header(),": ",txt);
  }
//+------------------------------------------------------------------+
//| Display the brief tick series description in the journal         |
//+------------------------------------------------------------------+
void CTickSeries::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print(this.Header());
  }
//+------------------------------------------------------------------+
