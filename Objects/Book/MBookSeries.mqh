//+------------------------------------------------------------------+
//|                                                  MBookSeries.mqh |
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
#include "MarketBookSnapshot.mqh"
//+------------------------------------------------------------------+
//| "DOM snapshot series" class                                      |
//+------------------------------------------------------------------+
class CMBookSeries : public CBaseObj
  {
private:
   string            m_symbol;                                          // Symbol
   uint              m_amount;                                          // Number of used DOM snapshots in the series
   uint              m_required;                                        // Required number of days for DOM snapshot series
   CArrayObj         m_list;                                            // DOM snapshot series list
   MqlBookInfo       m_book_info[];                                     // DOM structure array
public:
//--- Return (1) itself and (2) the series list
   CMBookSeries     *GetObject(void)                                    { return &this;   }
   CArrayObj        *GetList(void)                                      { return &m_list; }

//--- Return the DOM snapshot list by selected (1) double, (2) integer and (3) string properties fitting the compared condition
   CArrayObj        *GetList(ENUM_MBOOK_ORD_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode=EQUAL){ return CSelect::ByMBookProperty(this.GetList(),property,value,mode); }
   CArrayObj        *GetList(ENUM_MBOOK_ORD_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByMBookProperty(this.GetList(),property,value,mode); }
   CArrayObj        *GetList(ENUM_MBOOK_ORD_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode=EQUAL){ return CSelect::ByMBookProperty(this.GetList(),property,value,mode); }

//--- Return the DOM snapshot object by (1) index in the list, (2) time and (3) actual list size
   CMBookSnapshot   *GetMBookByListIndex(const uint index)        const { return this.m_list.At(index);              }
   CMBookSnapshot   *GetLastMBook(void)                           const { return this.m_list.At(this.DataTotal()-1); }
   CMBookSnapshot   *GetMBook(const long time_msc); 
   int               DataTotal(void)                              const { return this.m_list.Total();                }

//--- Set a (1) symbol, (2) a number of days for DOM snapshots
   void              SetSymbol(const string symbol);
   void              SetRequiredUsedDays(const uint required=0);

//--- The comparison method for searching and sorting DOM snapshot series objects by symbol
   virtual int       Compare(const CObject *node,const int mode=0) const 
                       {   
                        const CMBookSeries *compared_obj=node;
                        return(this.Symbol()==compared_obj.Symbol() ? 0 : this.Symbol()>compared_obj.Symbol() ? 1 : -1);
                       } 
//--- Return the name of the DOM  snapshot series
   string            Header(void);
//--- Display (1) description and (2) short description of a DOM snapshot series
   virtual void      Print(const bool full_prop=false,const bool dash=false);
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);

//--- Constructors
                     CMBookSeries(){ this.m_type=OBJECT_DE_TYPE_BOOK_SERIES; }
                     CMBookSeries(const string symbol,const uint required=0);

//+------------------------------------------------------------------+ 
//| Methods of working with objects and accessing their properties   |
//+------------------------------------------------------------------+
//--- Return (1) a symbol, a number of (2) used and (3) requested DOM snapshots in the series and
//--- (4) the time of a DOM snapshot specified by the index in milliseconds
   string            Symbol(void)                                          const { return this.m_symbol;    }
   ulong             AvailableUsedData(void)                               const { return this.m_amount;    }
   ulong             RequiredUsedDays(void)                                const { return this.m_required;  }
   long              MBookTime(const int index) const;
//--- update the list of DOM snapshot series
   bool              Refresh(const long time_msc);
  };
//+------------------------------------------------------------------+
//| Parametric constructor                                           |
//+------------------------------------------------------------------+
CMBookSeries::CMBookSeries(const string symbol,const uint required=0) : m_symbol(symbol)
  {
   this.m_type=OBJECT_DE_TYPE_BOOK_SERIES;
   this.m_list.Clear();
   this.m_list.Sort(SORT_BY_MBOOK_ORD_TIME_MSC);
   this.SetRequiredUsedDays(required);
  }
//+------------------------------------------------------------------+
//| Update the list of DOM snapshot series                           |
//+------------------------------------------------------------------+
bool CMBookSeries::Refresh(const long time_msc)
  {
//--- Get DOM entries to the structure array
   if(!::MarketBookGet(this.m_symbol,this.m_book_info))
      return false;
//--- Create a new DOM snapshot object
   CMBookSnapshot *book=new CMBookSnapshot(this.m_symbol,time_msc,this.m_book_info);
   if(book==NULL)
      return false;
//--- Set the flag of a list sorted by time for the list and add the created DOM snapshot to it
   this.m_list.Sort(SORT_BY_MBOOK_ORD_TIME_MSC);
   if(!this.m_list.InsertSort(book))
     {
      delete book;
      return false;
     }
//--- Set time in milliseconds to all DOM snapshot order objects
   book.SetTimeToOrders(time_msc);
//--- If the number of snapshots in the list exceeds the default maximum number,
//--- remove the calculated number of snapshot objects from the end of the list
   if(this.DataTotal()>MBOOKSERIES_MAX_DATA_TOTAL)
     {
      int total_del=this.m_list.Total()-MBOOKSERIES_MAX_DATA_TOTAL;
      for(int i=0;i<total_del;i++)
         this.m_list.Delete(i);
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Set a symbol                                                     |
//+------------------------------------------------------------------+
void CMBookSeries::SetSymbol(const string symbol)
  {
   if(this.m_symbol==symbol)
      return;
   this.m_symbol=(symbol==NULL || symbol=="" ? ::Symbol() : symbol);
  }
//+------------------------------------------------------------------+
//| Set the number of days for DOM snapshots in the series           |
//+------------------------------------------------------------------+
void CMBookSeries::SetRequiredUsedDays(const uint required=0)
  {
   this.m_required=(required<1 ? MBOOKSERIES_DEFAULT_DAYS_COUNT : required);
  }
//+------------------------------------------------------------------+
//| Return the DOM snapshot object by its time                       |
//+------------------------------------------------------------------+
CMBookSnapshot *CMBookSeries::GetMBook(const long time_msc)
  {
   CMBookSnapshot *book=new CMBookSnapshot();
   if(book==NULL)
      return NULL;
   book.SetTime(time_msc);
   this.m_list.Sort();
   int index=this.m_list.Search(book);
   delete book;
   return this.m_list.At(index);
  }
//+------------------------------------------------------------------+
//| Return the time in milliseconds                                  |
//| of a DOM snapshot specified by index                             |
//+------------------------------------------------------------------+
long CMBookSeries::MBookTime(const int index) const
  {
   CMBookSnapshot *book=this.m_list.At(index);
   return(book!=NULL ? book.Time() : 0);
  }
//+------------------------------------------------------------------+
//| Return the name of the DOM snapshot series                       |
//+------------------------------------------------------------------+
string CMBookSeries::Header(void)
  {
   return CMessage::Text(MSG_MBOOK_SERIES_TEXT_MBOOKSERIES)+" \""+this.m_symbol+"\"";
  }
//+------------------------------------------------------------------+
//| Display the description of the DOM snapshot series in the journal|
//+------------------------------------------------------------------+
void CMBookSeries::Print(const bool full_prop=false,const bool dash=false)
  {
   string txt=
     (
      CMessage::Text(MSG_TICKSERIES_REQUIRED_HISTORY_DAYS)+(string)this.RequiredUsedDays()+", "+
      CMessage::Text(MSG_LIB_TEXT_TS_ACTUAL_DEPTH)+(string)this.DataTotal()
     );
   ::Print((dash ? "- " : ""),this.Header(),": ",txt);
  }
//+------------------------------------------------------------------+
//| Display a short description of a DOM snapshot series             |
//+------------------------------------------------------------------+
void CMBookSeries::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print((dash ? "- " : ""),this.Header());
  }
//+------------------------------------------------------------------+
