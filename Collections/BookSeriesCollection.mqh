//+------------------------------------------------------------------+
//|                                         BookSeriesCollection.mqh |
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
#include "..\Objects\Book\MBookSeries.mqh"
#include "..\Objects\Symbols\Symbol.mqh"
//+------------------------------------------------------------------+
//| Collection of symbol DOM series                                  |
//+------------------------------------------------------------------+
class CMBookSeriesCollection : public CBaseObj
  {
private:
   CListObj                m_list;                                   // List of used symbol DOM series
//--- Return the DOM series index by a symbol name
   int                     IndexMBookSeries(const string symbol);
public:
//--- Return (1) itself and (2) the DOM series collection list
   CMBookSeriesCollection *GetObject(void)                              { return &this;               }
   CArrayObj              *GetList(void)                                { return &this.m_list;        }
   //--- Return the list by selected (1) integer, (2) real and (3) string properties meeting the compared criterion
   CArrayObj              *GetList(ENUM_MBOOK_ORD_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode=EQUAL)  { return CSelect::ByMBookProperty(this.GetList(),property,value,mode);  }
   CArrayObj              *GetList(ENUM_MBOOK_ORD_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByMBookProperty(this.GetList(),property,value,mode);  }
   CArrayObj              *GetList(ENUM_MBOOK_ORD_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByMBookProperty(this.GetList(),property,value,mode);  }
//--- Return the number of DOM series in the list
   int                     DataTotal(void)                        const { return this.m_list.Total();    }
//--- Return the pointer to the DOM series object (1) by symbol and (2) by index in the list
   CMBookSeries           *GetMBookseries(const string symbol);
   CMBookSeries           *GetMBookseries(const int index)              { return this.m_list.At(index);}
//--- Create symbol DOM series collection list
   bool                    CreateCollection(const CArrayObj *list_symbols,const uint required=0);
//--- Set the flag of using the DOM series of (1) a specified symbol and (2) all symbols
   void                    SetAvailableMBookSeries(const string symbol,const bool flag=true);
   void                    SetAvailableMBookSeries(const bool flag=true);
//--- Return the flag of using the DOM series of (1) a specified symbol and (2) all symbols
   bool                    IsAvailableMBookSeries(const string symbol);
   bool                    IsAvailableMBookSeries(void);

//--- Set the number of DOM history days of (1) a specified symbol and (2) all symbols
   bool                    SetRequiredUsedDays(const string symbol,const uint required=0);
   bool                    SetRequiredUsedDays(const uint required=0);

//--- Return the DOM snapshot object of a specified symbol (1) by index and (2) by time in milliseconds
   CMBookSnapshot         *GetMBook(const string symbol,const int index);
   CMBookSnapshot         *GetMBook(const string symbol,const long time_msc);

//--- Update the DOM series of a specified symbol
   bool                    Refresh(const string symbol,const long time_msc);

//--- Display (1) the complete and (2) short collection description in the journal
   virtual void            Print(const bool full_prop=false,const bool dash=false);
   virtual void            PrintShort(const bool dash=false,const bool symbol=false);
   
//--- Constructor
                           CMBookSeriesCollection();
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CMBookSeriesCollection::CMBookSeriesCollection()
  {
   this.m_type=COLLECTION_MBOOKSERIES_ID;
   this.m_list.Clear();
   this.m_list.Sort();
   this.m_list.Type(COLLECTION_MBOOKSERIES_ID);
  }
//+------------------------------------------------------------------+
//| Create symbol DOM series collection list                         |
//+------------------------------------------------------------------+
bool CMBookSeriesCollection::CreateCollection(const CArrayObj *list_symbols,const uint required=0)
  {
//--- If an empty list of symbol objects is passed, exit
   if(list_symbols==NULL)
      return false;
//--- Get the number of symbol objects in the passed list
   int total=list_symbols.Total();
//--- Clear the DOM series collection list
   this.m_list.Clear();
//--- In a loop by all symbol objects
   for(int i=0;i<total;i++)
     {
      //--- get the next symbol object
      CSymbol *symbol_obj=list_symbols.At(i);
      //--- if failed to get a symbol object, move on to the next one in the list
      if(symbol_obj==NULL)
         continue;
      //--- Create a new DOM series object
      CMBookSeries *bookseries=new CMBookSeries(symbol_obj.Name(),required);
      //--- If failed to create the DOM series object, move on to the next symbol in the list
      if(bookseries==NULL)
         continue;
      //--- Set the sorted list flag for the DOM series collection list
      this.m_list.Sort();
      //--- If the object with the same symbol name is already present in the DOM series collection list, remove the DOM series object
      if(this.m_list.Search(bookseries)>WRONG_VALUE)
         delete bookseries;
      //--- otherwise, there is no object with such a symbol name in the collection yet
      else
        {
         //--- if failed to add the DOM series object to the collection list, remove the series object,
         //--- inform of that and return 'false'
         if(!this.m_list.Add(bookseries))
           {
            delete bookseries;
            ::Print(DFUN,"\"",symbol_obj.Name(),"\": ",CMessage::Text(MSG_MBOOK_SERIES_ERR_ADD_TO_LIST));
            return false;
           }
        } 
     }
//--- Collection created successfully, return 'true'
   return true;
  }
//+------------------------------------------------------------------+
//| Update the snapshot series list of a specified symbol DOM        |
//+------------------------------------------------------------------+
bool CMBookSeriesCollection::Refresh(const string symbol,const long time_msc)
  {
   CMBookSeries *bookseries=this.GetMBookseries(symbol);
   if(bookseries==NULL)
      return false;
   return bookseries.Refresh(time_msc);
  }
//+------------------------------------------------------------------+
//| Return the DOM series index by a symbol name                     |
//+------------------------------------------------------------------+
int CMBookSeriesCollection::IndexMBookSeries(const string symbol)
  {
   const CMBookSeries *obj=new CMBookSeries(symbol==NULL || symbol=="" ? ::Symbol() : symbol);
   if(obj==NULL)
      return WRONG_VALUE;
   this.m_list.Sort();
   int index=this.m_list.Search(obj);
   delete obj;
   return index;
  }
//+------------------------------------------------------------------+
//| Return the specified symbol DOM series object                    |
//+------------------------------------------------------------------+
CMBookSeries *CMBookSeriesCollection::GetMBookseries(const string symbol)
  {
   int index=this.IndexMBookSeries(symbol);
   return this.m_list.At(index);
  }
//+------------------------------------------------------------------+
//| Set the flag of using a series                                   |
//| of a specified symbol DOM                                        |
//+------------------------------------------------------------------+
void CMBookSeriesCollection::SetAvailableMBookSeries(const string symbol,const bool flag=true)
  {
   CMBookSeries *bookseries=this.GetMBookseries(symbol);
   if(bookseries==NULL)
      return;
   bookseries.SetAvailable(flag);
  }
//+------------------------------------------------------------------+
//|Set the flag of using the DOM series for all symbols              |
//+------------------------------------------------------------------+
void CMBookSeriesCollection::SetAvailableMBookSeries(const bool flag=true)
  {
   for(int i=0;i<this.m_list.Total();i++)
     {
      CMBookSeries *bookseries=this.m_list.At(i);
      if(bookseries==NULL)
         continue;
      bookseries.SetAvailable(flag);
     }
  }
//+------------------------------------------------------------------+
//|Return the flag of using the DOM series of a specified symbol     |
//+------------------------------------------------------------------+
bool CMBookSeriesCollection::IsAvailableMBookSeries(const string symbol)
  {
   CMBookSeries *bookseries=this.GetMBookseries(symbol);
   if(bookseries==NULL)
      return false;
   return bookseries.IsAvailable();
  }
//+------------------------------------------------------------------+
//| Return the flag of using the DOM series of all symbols           |
//+------------------------------------------------------------------+
bool CMBookSeriesCollection::IsAvailableMBookSeries(void)
  {
   bool res=true;
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CMBookSeries *bookseries=this.m_list.At(i);
      if(bookseries==NULL)
         continue;
      res &=bookseries.IsAvailable();
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Set the number of snapshots in history                           |
//| of a specified symbol DOM                                        |
//+------------------------------------------------------------------+
bool CMBookSeriesCollection::SetRequiredUsedDays(const string symbol,const uint required=0)
  {
   CMBookSeries *bookseries=this.GetMBookseries(symbol);
   if(bookseries==NULL)
      return false;
   bookseries.SetRequiredUsedDays(required);
   return true;
  }
//+------------------------------------------------------------------+
//|Set the number of snapshots in the DOM history of all symbols     |
//+------------------------------------------------------------------+
bool CMBookSeriesCollection::SetRequiredUsedDays(const uint required=0)
  {
   bool res=true;
   for(int i=0;i<this.m_list.Total();i++)
     {
      CMBookSeries *bookseries=this.m_list.At(i);
      if(bookseries==NULL)
        {
         res &=false;
         continue;
        }
      bookseries.SetRequiredUsedDays(required);
     }
   return res;
  }
//+------------------------------------------------------------------+
//|Return the DOM snapshot object of a specified symbol by index     |
//+------------------------------------------------------------------+
CMBookSnapshot *CMBookSeriesCollection::GetMBook(const string symbol,const int index)
  {
   CMBookSeries *bookseries=this.GetMBookseries(symbol);
   if(bookseries==NULL)
      return NULL;
   return bookseries.GetMBookByListIndex(index);
  }
//+------------------------------------------------------------------+
//| Return the DOM snapshot object of a specified symbol             |
//| by time in milliseconds                                          |
//+------------------------------------------------------------------+
CMBookSnapshot *CMBookSeriesCollection::GetMBook(const string symbol,const long time_msc)
  {
   CMBookSeries *bookseries=this.GetMBookseries(symbol);
   if(bookseries==NULL)
      return NULL;
   return bookseries.GetMBook(time_msc);
  }
//+------------------------------------------------------------------+
//| Display complete collection description in the journal           |
//+------------------------------------------------------------------+
void CMBookSeriesCollection::Print(const bool full_prop=false,const bool dash=false)
  {
   ::Print(CMessage::Text(MSG_MB_COLLECTION_TEXT_MBCOLLECTION),":");
   for(int i=0;i<this.m_list.Total();i++)
     {
      CMBookSeries *bookseries=this.m_list.At(i);
      if(bookseries==NULL)
         continue;
      bookseries.Print(false,true);
     }
  }
//+------------------------------------------------------------------+
//| Display the short collection description in the journal          |
//+------------------------------------------------------------------+
void CMBookSeriesCollection::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print(CMessage::Text(MSG_MB_COLLECTION_TEXT_MBCOLLECTION),":");
   for(int i=0;i<this.m_list.Total();i++)
     {
      CMBookSeries *bookseries=this.m_list.At(i);
      if(bookseries==NULL)
         continue;
      bookseries.PrintShort(true);
     }
  }
//+------------------------------------------------------------------+

