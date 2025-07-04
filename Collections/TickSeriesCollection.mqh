//+------------------------------------------------------------------+
//|                                         TickSeriesCollection.mqh |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "ListObj.mqh"
#include "..\Objects\Ticks\TickSeries.mqh"
#include "..\Objects\Symbols\Symbol.mqh"
//+------------------------------------------------------------------+
//| Collection of tick series symbols                                |
//+------------------------------------------------------------------+
class CTickSeriesCollection : public CBaseObj
  {
private:
   CListObj                m_list;                                   // List of used symbol tick series
//--- Return the tick series index by symbol name
   int                     IndexTickSeries(const string symbol);
public:
//--- Return (1) itself and (2) tick series collection list and (3) the number of tick series in the list
   CTickSeriesCollection  *GetObject(void)                              { return &this;               }
   CArrayObj              *GetList(void)                                { return &this.m_list;        }
   int                     DataTotal(void)                        const { return this.m_list.Total(); }
//--- Return the pointer to the tick series object (1) by symbol and (2) by index in the list
   CTickSeries            *GetTickseries(const string symbol);
   CTickSeries            *GetTickseries(const int index)               { return this.m_list.At(index);}
//--- Create a collection list of symbol tick series
   bool                    CreateCollection(const CArrayObj *list_symbols,const uint required=0);
//--- Set the flag of using the tick series of (1) a specified symbol and (2) all symbols
   void                    SetAvailableTickSeries(const string symbol,const bool flag=true);
   void                    SetAvailableTickSeries(const bool flag=true);
//--- Return the flag of using the tick series of (1) a specified symbol and (2) all symbols
   bool                    IsAvailableTickSeries(const string symbol);
   bool                    IsAvailableTickSeries(void);

//--- Set the number of days of the tick history of (1) a specified symbol and (2) all symbols
   bool                    SetRequiredUsedDays(const string symbol,const uint required=0);
   bool                    SetRequiredUsedDays(const uint required=0);

//--- Return the last tick object of a specified symbol (1) by index, (2) by time and (3) by time in milliseconds
   CDataTick              *GetTick(const string symbol,const int index);
   CDataTick              *GetTick(const string symbol,const datetime tick_time);
   CDataTick              *GetTick(const string symbol,const long tick_time_msc);

//--- Return the new tick flag of a specified symbol
   bool                    IsNewTick(const string symbol);

//--- Create a tick series of (1) a specified symbol and (2) all symbols
   bool                    CreateTickSeries(const string symbol,const uint required=0);
   bool                    CreateTickSeriesAll(const uint required=0);
//--- Update (1) a tick series of a specified symbol, (2) all symbols and (3) all symbols except the current one
   void                    Refresh(const string symbol);
   void                    Refresh(void);
   void                    RefreshExpectCurrent(void);

//--- Display (1) the complete and (2) short collection description in the journal
   virtual void            Print(const bool full_prop=false,const bool dash=false);
   virtual void            PrintShort(const bool dash=false,const bool symbol=false);
   
//--- Constructor
                           CTickSeriesCollection();
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTickSeriesCollection::CTickSeriesCollection()
  {
   this.m_type=COLLECTION_TICKSERIES_ID;
   this.m_list.Clear();
   this.m_list.Sort();
   this.m_list.Type(COLLECTION_TICKSERIES_ID);
  }
//+------------------------------------------------------------------+
//| Create a collection list of symbol tick series                   |
//+------------------------------------------------------------------+
bool CTickSeriesCollection::CreateCollection(const CArrayObj *list_symbols,const uint required=0)
  {
//--- If an empty list of symbol objects is passed, exit
   if(list_symbols==NULL)
      return false;
//--- Get the number of symbol objects in the passed list
   int total=list_symbols.Total();
//--- Clear the tick series collection list
   this.m_list.Clear();
//--- In a loop by all symbol objects
   for(int i=0;i<total;i++)
     {
      //--- get the next symbol object
      CSymbol *symbol_obj=list_symbols.At(i);
      //--- if failed to get a symbol object, move on to the next one in the list
      if(symbol_obj==NULL)
         continue;
      //--- Create a new empty tick series object
      CTickSeries *tickseries=new CTickSeries();
      //--- If failed to create the tick series object, move on to the next symbol in the list
      if(tickseries==NULL)
         continue;
      //--- Set a symbol name for a tick series object
      tickseries.SetSymbol(symbol_obj.Name());
      //--- Set the sorted list flag for the tick series collection list
      this.m_list.Sort();
      //--- If the object with the same symbol name is already present in the tick series collection list, remove the tick series object
      if(this.m_list.Search(tickseries)>WRONG_VALUE)
         delete tickseries;
      //--- otherwise, there is no object with such a symbol name in the collection yet
      else
        {
         //--- Set the number of tick data days for a tick series object
         tickseries.SetRequiredUsedDays(required);
         //--- if failed to add the tick series object to the collection list, remove the tick series object
         if(!this.m_list.Add(tickseries))
            delete tickseries;
        } 
     }
//--- Return the flag indicating that the created collection list has a size greater than zero
   return this.m_list.Total()>0;
  }
//+------------------------------------------------------------------+
//| Create a tick series of a specified symbol                       |
//+------------------------------------------------------------------+
bool CTickSeriesCollection::CreateTickSeries(const string symbol,const uint required=0)
  {
   CTickSeries *tickseries=this.GetTickseries(symbol);
   if(tickseries==NULL)
      return false;
   return(tickseries.Create(required)>0);
  }
//+------------------------------------------------------------------+
//| Create tick series of all symbols                                |
//+------------------------------------------------------------------+
bool CTickSeriesCollection::CreateTickSeriesAll(const uint required=0)
  {
   bool res=true;
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTickSeries *tickseries=this.m_list.At(i);
      if(tickseries==NULL)
         continue;
      res &=(tickseries.Create(required)>0);
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Return the tick series index by symbol name                      |
//+------------------------------------------------------------------+
int CTickSeriesCollection::IndexTickSeries(const string symbol)
  {
   const CTickSeries *obj=new CTickSeries(symbol==NULL || symbol=="" ? ::Symbol() : symbol);
   if(obj==NULL)
      return WRONG_VALUE;
   this.m_list.Sort();
   int index=this.m_list.Search(obj);
   delete obj;
   return index;
  }
//+------------------------------------------------------------------+
//| Return the object of tick series of a specified symbol           |
//+------------------------------------------------------------------+
CTickSeries *CTickSeriesCollection::GetTickseries(const string symbol)
  {
   int index=this.IndexTickSeries(symbol);
   return this.m_list.At(index);
  }
//+------------------------------------------------------------------+
//| Set the flag of using the tick series of a specified symbol      |
//+------------------------------------------------------------------+
void CTickSeriesCollection::SetAvailableTickSeries(const string symbol,const bool flag=true)
  {
   CTickSeries *tickseries=this.GetTickseries(symbol);
   if(tickseries==NULL)
      return;
   tickseries.SetAvailable(flag);
  }
//+------------------------------------------------------------------+
//| Set the flag of using the tick series of all symbols             |
//+------------------------------------------------------------------+
void CTickSeriesCollection::SetAvailableTickSeries(const bool flag=true)
  {
   for(int i=0;i<this.m_list.Total();i++)
     {
      CTickSeries *tickseries=this.m_list.At(i);
      if(tickseries==NULL)
         continue;
      tickseries.SetAvailable(flag);
     }
  }
//+------------------------------------------------------------------+
//| Return the flag of using the tick series of a specified symbol   |
//+------------------------------------------------------------------+
bool CTickSeriesCollection::IsAvailableTickSeries(const string symbol)
  {
   CTickSeries *tickseries=this.GetTickseries(symbol);
   if(tickseries==NULL)
      return false;
   return tickseries.IsAvailable();
  }
//+------------------------------------------------------------------+
//| Return the flag of using tick series of all symbols              |
//+------------------------------------------------------------------+
bool CTickSeriesCollection::IsAvailableTickSeries(void)
  {
   bool res=true;
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CTickSeries *tickseries=this.m_list.At(i);
      if(tickseries==NULL)
         continue;
      res &=tickseries.IsAvailable();
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Set the number of days of the tick history of a specified symbol |
//+------------------------------------------------------------------+
bool CTickSeriesCollection::SetRequiredUsedDays(const string symbol,const uint required=0)
  {
   CTickSeries *tickseries=this.GetTickseries(symbol);
   if(tickseries==NULL)
      return false;
   tickseries.SetRequiredUsedDays(required);
   return true;
  }
//+------------------------------------------------------------------+
//| Set the number of days of the tick history of all symbols        |
//+------------------------------------------------------------------+
bool CTickSeriesCollection::SetRequiredUsedDays(const uint required=0)
  {
   bool res=true;
   for(int i=0;i<this.m_list.Total();i++)
     {
      CTickSeries *tickseries=this.m_list.At(i);
      if(tickseries==NULL)
        {
         res &=false;
         continue;
        }
      tickseries.SetRequiredUsedDays(required);
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Return the tick object of the specified symbol by index          |
//+------------------------------------------------------------------+
CDataTick *CTickSeriesCollection::GetTick(const string symbol,const int index)
  {
   CTickSeries *tickseries=this.GetTickseries(symbol);
   if(tickseries==NULL)
      return NULL;
   return tickseries.GetTickByListIndex(index);
  }
//+------------------------------------------------------------------+
//| Return the last tick object of the specified symbol by time      |
//+------------------------------------------------------------------+
CDataTick *CTickSeriesCollection::GetTick(const string symbol,const datetime tick_time)
  {
   CTickSeries *tickseries=this.GetTickseries(symbol);
   if(tickseries==NULL)
      return NULL;
   return tickseries.GetTick(tick_time);
  }
//+------------------------------------------------------------------+
//| Return the last tick object of the specified symbol              |
//| by time in milliseconds                                          |
//+------------------------------------------------------------------+
CDataTick *CTickSeriesCollection::GetTick(const string symbol,const long tick_time_msc)
  {
   CTickSeries *tickseries=this.GetTickseries(symbol);
   if(tickseries==NULL)
      return NULL;
   return tickseries.GetTick(tick_time_msc);
  }
//+------------------------------------------------------------------+
//| Return the new tick flag of a specified symbol                   |
//+------------------------------------------------------------------+
bool CTickSeriesCollection::IsNewTick(const string symbol)
  {
   CTickSeries *tickseries=this.GetTickseries(symbol);
   if(tickseries==NULL)
      return false;
   return tickseries.IsNewTick();
  }
//+------------------------------------------------------------------+
//| Update a tick series of a specified symbol                       |
//+------------------------------------------------------------------+
void CTickSeriesCollection::Refresh(const string symbol)
  {
   CTickSeries *tickseries=this.GetTickseries(symbol);
   if(tickseries==NULL)
      return;
   tickseries.Refresh();
  }
//+------------------------------------------------------------------+
//| Update tick series of all symbols                                |
//+------------------------------------------------------------------+
void CTickSeriesCollection::Refresh(void)
  {
   for(int i=0;i<this.m_list.Total();i++)
     {
      CTickSeries *tickseries=this.m_list.At(i);
      if(tickseries==NULL)
         continue;
      tickseries.Refresh();
     }
  }
//+------------------------------------------------------------------+
//| Update tick series of all symbols except the current one         |
//+------------------------------------------------------------------+
void CTickSeriesCollection::RefreshExpectCurrent(void)
  {
   for(int i=0;i<this.m_list.Total();i++)
     {
      CTickSeries *tickseries=this.m_list.At(i);
      if(tickseries==NULL || tickseries.Symbol()==::Symbol())
         continue;
      tickseries.Refresh();
     }
  }
//+------------------------------------------------------------------+
//| Display complete collection description in the journal           |
//+------------------------------------------------------------------+
void CTickSeriesCollection::Print(const bool full_prop=false,const bool dash=false)
  {
   for(int i=0;i<this.m_list.Total();i++)
     {
      CTickSeries *tickseries=this.m_list.At(i);
      if(tickseries==NULL)
         continue;
      tickseries.Print();
     }
  }
//+------------------------------------------------------------------+
//| Display the short collection description in the journal          |
//+------------------------------------------------------------------+
void CTickSeriesCollection::PrintShort(const bool dash=false,const bool symbol=false)
  {
   for(int i=0;i<this.m_list.Total();i++)
     {
      CTickSeries *tickseries=this.m_list.At(i);
      if(tickseries==NULL)
         continue;
      tickseries.PrintShort();
     }
  }
//+------------------------------------------------------------------+
