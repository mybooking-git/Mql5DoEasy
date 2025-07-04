//+------------------------------------------------------------------+
//|                                            SymbolsCollection.mqh |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include <Arrays\ArrayString.mqh>
#include "ListObj.mqh"
#include "..\Services\Select.mqh"
#include "..\Objects\Symbols\Symbol.mqh"
#include "..\Objects\Symbols\SymbolFX.mqh"
#include "..\Objects\Symbols\SymbolFXMajor.mqh"
#include "..\Objects\Symbols\SymbolFXMinor.mqh"
#include "..\Objects\Symbols\SymbolFXExotic.mqh"
#include "..\Objects\Symbols\SymbolFXRub.mqh"
#include "..\Objects\Symbols\SymbolMetall.mqh"
#include "..\Objects\Symbols\SymbolIndex.mqh"
#include "..\Objects\Symbols\SymbolIndicative.mqh"
#include "..\Objects\Symbols\SymbolCrypto.mqh"
#include "..\Objects\Symbols\SymbolCommodity.mqh"
#include "..\Objects\Symbols\SymbolExchange.mqh"
#include "..\Objects\Symbols\SymbolFutures.mqh"
#include "..\Objects\Symbols\SymbolCFD.mqh"
#include "..\Objects\Symbols\SymbolStocks.mqh"
#include "..\Objects\Symbols\SymbolBonds.mqh"
#include "..\Objects\Symbols\SymbolOption.mqh"
#include "..\Objects\Symbols\SymbolCollateral.mqh"
#include "..\Objects\Symbols\SymbolCustom.mqh"
#include "..\Objects\Symbols\SymbolCommon.mqh"
//+------------------------------------------------------------------+
//| Symbol collection                                                |
//+------------------------------------------------------------------+
class CSymbolsCollection : public CBaseObjExt
  {
private:
   CListObj          m_list_all_symbols;                          // The list of all symbol objects
   CArrayString      m_list_names;                                // Symbol name control list
   ENUM_SYMBOLS_MODE m_mode_list;                                 // Mode of working with symbol lists
   int               m_last_event;                                // The last event
   string            m_array_symbols[];                           // The array of used symbols passed from the program
   int               m_delta_symbol;                              // Difference in the number of symbols compared to the previous check
   int               m_total_symbols;                             // Number of symbols in the Market Watch window
   int               m_total_symbol_prev;                         // Number of symbols in the Market Watch window during the previous check
//--- Save names of used Market Watch symbols
   void              CopySymbolsNames(void);
//--- Return the flag of a symbol object presence by its name in the (1) list of all symbols, (2) Market Watch window, (3) control list
   bool              IsPresentSymbolInList(const string symbol_name);
   bool              IsPresentSymbolInMW(const string symbol_name);
   bool              IsPresentSymbolInControlList(const string symbol_name);
//--- Create the symbol object and place it to the list
   bool              CreateNewSymbol(const ENUM_SYMBOL_STATUS symbol_status,const string symbol_name,const int index);
//--- Return the (1) type of a used symbol list (Market watch/Server),
//--- (2) the number of visible symbols, (3) symbol index in the Market Watch window
   ENUM_SYMBOLS_MODE TypeSymbolsList(const string &symbol_used_array[]);
   int               SymbolsTotalVisible(void)                    const;
   int               SymbolIndexInMW(const string symbol_name)    const;
   
//--- Define a symbol affiliation with a group by name and return it
   ENUM_SYMBOL_STATUS SymbolStatus(const string symbol_name)      const;
//--- Return a symbol affiliation with a category by custom criteria
   ENUM_SYMBOL_STATUS StatusByCustomPredefined(const string symbol_name)  const;
//--- Return a symbol affiliation with categories by margin calculation
   ENUM_SYMBOL_STATUS StatusByCalcMode(const string symbol_name)  const;
//--- Return a symbol affiliation with pre-defined (1) majors, (2) minors, (3) exotics, (4) RUB,
//--- (5) indicatives, (6) metals, (7) commodities, (8) indices, (9) cryptocurrency, (10) options
   bool              IsPredefinedFXMajor(const string name)       const;
   bool              IsPredefinedFXMinor(const string name)       const;
   bool              IsPredefinedFXExotic(const string name)      const;
   bool              IsPredefinedFXRUB(const string name)         const;
   bool              IsPredefinedIndicative(const string name)    const;
   bool              IsPredefinedMetall(const string name)        const;
   bool              IsPredefinedCommodity(const string name)     const;
   bool              IsPredefinedIndex(const string name)         const;
   bool              IsPredefinedCrypto(const string name)        const;
   bool              IsPredefinedOption(const string name)        const;

public:
//--- Return itself
   CSymbolsCollection *GetObject(void)                                                                      { return &this;   }
//--- Return the full collection list 'as is'
   CArrayObj        *GetList(void)                                                                          { return &this.m_list_all_symbols;                                      }
//--- Return the list by selected (1) integer, (2) real and (3) string properties meeting the compared criterion
   CArrayObj        *GetList(ENUM_SYMBOL_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode=EQUAL)    { return CSelect::BySymbolProperty(this.GetList(),property,value,mode); }
   CArrayObj        *GetList(ENUM_SYMBOL_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode=EQUAL)   { return CSelect::BySymbolProperty(this.GetList(),property,value,mode); }
   CArrayObj        *GetList(ENUM_SYMBOL_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode=EQUAL)   { return CSelect::BySymbolProperty(this.GetList(),property,value,mode); }
//--- Return the (1) symbol object, (2) the symbol object index from the list by a name
   CSymbol          *GetSymbolObjByName(const string name);
   int               GetIndexObjByName(const string name);
//--- Return the number of new symbols in the Market Watch window
   int               NewSymbols(void)    const                                                              { return this.m_delta_symbol;                                           }
//--- Return (1) the mode of working with symbol lists, (2) the event flag and (3) the event of one of the collection symbols, (4) the last event
   ENUM_SYMBOLS_MODE ModeSymbolsList(void)                        const                                     { return this.m_mode_list;                                              }
   bool              IsEvent(void)                                const                                     { return this.m_is_event;                                               }
   int               GetLastEventsCode(void)                      const                                     { return this.m_event_code;                                             }
   int               GetLastEvent(void)                           const                                     { return this.m_last_event;                                             }
//--- Return the number of symbols in the collection
   int               GetSymbolsCollectionTotal(void)              const                                     { return this.m_list_all_symbols.Total();                               }

//--- Constructor
                     CSymbolsCollection();
   
//--- (1) Set the list of used symbols, (2) creating the symbol list (Market Watch or the complete list)
   bool              SetUsedSymbols(const string &symbol_used_array[]);
   bool              CreateSymbolsList(const bool flag);
//--- Update (1) all, (2) quote data of the collection symbols
   virtual void      Refresh(void);
   void              RefreshRates(void);
//--- Working with the events of the (1) collection symbol list, (2) market watch window
   void              RefreshAndEventsControl(void);
   void              MarketWatchEventsControl(const bool send_events=true);
//--- Return the description of the (1) Market Watch window event, (2) mode of working with symbols
   string            EventMWDescription(const ENUM_MW_EVENT event);
   string            ModeSymbolsListDescription(void);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CSymbolsCollection::CSymbolsCollection(void) : m_total_symbol_prev(0),
                                               m_delta_symbol(0),
                                               m_mode_list(SYMBOLS_MODE_CURRENT)
  {
   this.m_type=COLLECTION_SYMBOLS_ID;
   this.m_list_all_symbols.Sort(SORT_BY_SYMBOL_INDEX_MW);
   this.m_list_all_symbols.Clear();
   this.m_list_all_symbols.Type(COLLECTION_SYMBOLS_ID);
   this.m_list_names.Clear();
  }
//+------------------------------------------------------------------+
//| Update all collection symbol data                                |
//+------------------------------------------------------------------+
void CSymbolsCollection::Refresh(void)
  {
   int total=this.m_list_all_symbols.Total();
   if(total==0)
      return;
   for(int i=0;i<total;i++)
     {
      CSymbol *symbol=this.m_list_all_symbols.At(i);
      if(symbol==NULL)
         continue;
      symbol.Refresh();
     }
  }
//+------------------------------------------------------------------+
//| Update quote data of the collection symbols                      |
//+------------------------------------------------------------------+
void CSymbolsCollection::RefreshRates(void)
  {
   int total=this.m_list_all_symbols.Total();
   if(total==0)
      return;
   for(int i=0;i<total;i++)
     {
      CSymbol *symbol=this.m_list_all_symbols.At(i);
      if(symbol==NULL)
         continue;
      symbol.RefreshRates();
     }
  }
//+------------------------------------------------------------------+
//| Working with market watch window events                          |
//+------------------------------------------------------------------+
void CSymbolsCollection::MarketWatchEventsControl(const bool send_events=true)
  {
   ::ResetLastError();
//--- If no current prices are received, exit
   if(!::SymbolInfoTick(::Symbol(),this.m_tick))
     {
      this.m_global_error=::GetLastError();
      return;
     }
   uchar array[];
   int sum=0;
   this.m_hash_sum=0;
//--- Calculate the hash sum of all visible symbols in the Market Watch window
   this.m_total_symbols=this.SymbolsTotalVisible();
   //--- In the loop by all Market Watch window symbols
   int total_symbols=::SymbolsTotal(true);
   for(int i=0;i<total_symbols;i++)
     {
      //--- get a symbol name by index
      string name=::SymbolName(i,true);
      //--- skip if invisible
      if(!::SymbolInfoInteger(name,SYMBOL_VISIBLE))
         continue;
      //--- write symbol name (characters) codes to the uchar array
      ::StringToCharArray(name,array);
      //--- in a loop by the resulting array, sum up the values of all array cells creating the symbol code
      for(int j=::ArraySize(array)-1;j>WRONG_VALUE;j--)
         sum+=array[j];
      //--- add the symbol code and the loop index specifying the symbol index in the market watch list to the hash sum
      m_hash_sum+=i+sum;
     }
//--- If sending events is disabled, create the collection list and exit saving the current hash some as the previous one
   if(!send_events)
     {
      //--- Clear the list
      this.m_list_all_symbols.Clear();
      //--- Clear the collection list
      this.CreateSymbolsList(true);
      //--- Clear the market watch window snapshot
      this.CopySymbolsNames();
      //--- save the current hash some as the previous one
      this.m_hash_sum_prev=this.m_hash_sum;
      //--- save the current number of visible symbols as the previous one
      this.m_total_symbol_prev=this.m_total_symbols;
      return;
     }
   
//--- If the hash sum of symbols in the Market Watch window has changed
   if(this.m_hash_sum!=this.m_hash_sum_prev)
     {
      //--- Define the Market Watch window event
      this.m_delta_symbol=this.m_total_symbols-this.m_total_symbol_prev;
      ushort event_id=
        (ushort(
         this.m_total_symbols>this.m_total_symbol_prev ? MARKET_WATCH_EVENT_SYMBOL_ADD :
         this.m_total_symbols<this.m_total_symbol_prev ? MARKET_WATCH_EVENT_SYMBOL_DEL :
         MARKET_WATCH_EVENT_SYMBOL_SORT)
        );
      //--- Adding a symbol to the Market Watch window
      if(event_id==MARKET_WATCH_EVENT_SYMBOL_ADD)
        {
         string name="";
         //--- In the loop by all Market Watch window symbols
         int total=::SymbolsTotal(true), index=WRONG_VALUE;
         for(int i=0;i<total;i++)
           {
            //--- get the symbol name and check its "visibility". Skip it if invisible
            name=::SymbolName(i,true);
            if(!::SymbolInfoInteger(name,SYMBOL_VISIBLE))
               continue;
            //--- If there is no symbol in the collection symbol list yet
            if(!this.IsPresentSymbolInList(name))
              {
               //--- clear the collection list
               this.m_list_all_symbols.Clear();
               //--- recreate the collection list
               this.CreateSymbolsList(true);
               //--- create the symbol collection snapshot
               this.CopySymbolsNames();
               //--- get a new symbol index in the Market Watch window
               index=this.GetIndexObjByName(name);
               //--- If the "Adding a new symbol" event is successfully added to the event list 
               if(this.EventAdd(event_id,this.TickTime(),index,name))
                 {
                  //--- send the event to the chart:
                  //--- long value = event time in milliseconds, double value = symbol index, string value = added symbol name
                  ::EventChartCustom(this.m_chart_id_main,(ushort)event_id,this.TickTime(),index,name);
                 }
              }
           }
         //--- Save the new number of visible symbols in the market watch window
         this.m_total_symbols=this.SymbolsTotalVisible();
        }
      //--- Remove a symbol from the Market Watch window
      else if(event_id==MARKET_WATCH_EVENT_SYMBOL_DEL)
        {
         //--- clear the collection list 
         this.m_list_all_symbols.Clear();
         //--- recreate the collection list
         this.CreateSymbolsList(true);
         //--- In a loop by the market watch window snapshot
         int total=this.m_list_names.Total();
         for(int i=0; i<total;i++)
           {
            //--- get a symbol name 
            string name=this.m_list_names.At(i);
            if(name==NULL)
               continue;
            //--- if no symbol with such a name exists in the collection symbol list
            if(!this.IsPresentSymbolInList(name))
              {
               //--- If the "Removing a symbol" event is successfully added to the event list
               if(this.EventAdd(event_id,this.TickTime(),WRONG_VALUE,name))
                 {
                  //--- send the event to the chart:
                  //--- long value = event tine in milliseconds, double value = -1 for an absent symbol, string value = a removed symbol name
                  ::EventChartCustom(this.m_chart_id_main,(ushort)event_id,this.TickTime(),WRONG_VALUE,name);
                 }
              }
           }
         //--- Recreate the market watch snapshot
         this.CopySymbolsNames();
         //--- Save the new number of visible symbols in the market watch window
         this.m_total_symbols=this.SymbolsTotalVisible();
        }
      //--- Sorting symbols in the Market Watch window
      else if(event_id==MARKET_WATCH_EVENT_SYMBOL_SORT)
        {
         //--- clear the collection list 
         this.m_list_all_symbols.Clear();
         //--- set sorting of the collection list as sorting by index
         this.m_list_all_symbols.Sort(SORT_BY_SYMBOL_INDEX_MW);
         //--- recreate the collection list
         this.CreateSymbolsList(true);
         //--- get the current symbol index in the Market Watch window
         int index=this.GetIndexObjByName(Symbol());
         //--- send the event to the chart:
         //--- long value = event time in milliseconds, double value = current symbol index, string value = current symbol name
         ::EventChartCustom(this.m_chart_id_main,(ushort)event_id,this.TickTime(),index,::Symbol());
        }
      //--- save the current number of visible symbols as the previous one
      this.m_total_symbol_prev=this.m_total_symbols;
      //--- save the current hash some as the previous one
      this.m_hash_sum_prev=this.m_hash_sum;
     }
  }
//+------------------------------------------------------------------+
//| Working with the events of the collection symbol list            |
//+------------------------------------------------------------------+
void CSymbolsCollection::RefreshAndEventsControl(void)
  {
   this.m_is_event=false;
   this.m_list_events.Clear();
   this.m_list_events.Sort();
   //--- The full update of all collection symbols
   int total=this.m_list_all_symbols.Total();
   for(int i=0;i<total;i++)
     {
      CSymbol *symbol=this.m_list_all_symbols.At(i);
      if(symbol==NULL)
         continue;
      symbol.Refresh();
      if(!symbol.IsEvent())
         continue;
      CArrayObj *list=symbol.GetListEvents();
      if(list==NULL)
         continue;
      this.m_is_event=true;
      this.m_event_code=symbol.GetEventCode();
      int n=list.Total();
      for(int j=0; j<n; j++)
        {
         CEventBaseObj *event=list.At(j);
         if(event==NULL)
            continue;
         ushort event_id=event.ID();
         this.m_last_event=event_id;
         if(this.EventAdd((ushort)event.ID(),event.LParam(),event.DParam(),event.SParam()))
           {
            ::EventChartCustom(this.m_chart_id_main,(ushort)event_id,event.LParam(),event.DParam(),event.SParam());
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Create a symbol object and place it to the list                  |
//+------------------------------------------------------------------+
bool CSymbolsCollection::CreateNewSymbol(const ENUM_SYMBOL_STATUS symbol_status,const string symbol_name,const int index)
  {
   string name=(symbol_name==NULL || symbol_name=="" ? ::Symbol() : symbol_name);
   if(this.IsPresentSymbolInList(name))
     {
      return true;
     }
   if(#ifdef __MQL5__ !::SymbolInfoInteger(name,SYMBOL_EXIST) #else !Exist(name) #endif )
     {
      string t1=CMessage::Text(MSG_LIB_SYS_INPUT_ERROR_NO_SYMBOL);
      string t2=CMessage::Text(MSG_LIB_TEXT_SYMBOL_ON_SERVER);
      ::Print(DFUN,t1,name,t2);
      this.m_global_error=ERR_MARKET_UNKNOWN_SYMBOL;
      return false;
     }
   CSymbol *symbol=NULL;
   switch(symbol_status)
     {
      case SYMBOL_STATUS_FX         :  symbol=new CSymbolFX(name,index);         break;   // Forex symbol
      case SYMBOL_STATUS_FX_MAJOR   :  symbol=new CSymbolFXMajor(name,index);    break;   // Major Forex symbol
      case SYMBOL_STATUS_FX_MINOR   :  symbol=new CSymbolFXMinor(name,index);    break;   // Minor Forex symbol
      case SYMBOL_STATUS_FX_EXOTIC  :  symbol=new CSymbolFXExotic(name,index);   break;   // Exotic Forex symbol
      case SYMBOL_STATUS_FX_RUB     :  symbol=new CSymbolFXRub(name,index);      break;   // Forex symbol/RUR
      case SYMBOL_STATUS_METAL      :  symbol=new CSymbolMetall(name,index);     break;   // Metal
      case SYMBOL_STATUS_INDEX      :  symbol=new CSymbolIndex(name,index);      break;   // Index
      case SYMBOL_STATUS_INDICATIVE :  symbol=new CSymbolIndicative(name,index); break;   // Indicative
      case SYMBOL_STATUS_CRYPTO     :  symbol=new CSymbolCrypto(name,index);     break;   // Cryptocurrency symbol
      case SYMBOL_STATUS_COMMODITY  :  symbol=new CSymbolCommodity(name,index);  break;   // Commodity
      case SYMBOL_STATUS_EXCHANGE   :  symbol=new CSymbolExchange(name,index);   break;   // Exchange symbol
      case SYMBOL_STATUS_FUTURES    :  symbol=new CSymbolFutures(name,index);    break;   // Futures
      case SYMBOL_STATUS_CFD        :  symbol=new CSymbolCFD(name,index);        break;   // CFD
      case SYMBOL_STATUS_STOCKS     :  symbol=new CSymbolStocks(name,index);     break;   // Stock
      case SYMBOL_STATUS_BONDS      :  symbol=new CSymbolBonds(name,index);      break;   // Bond
      case SYMBOL_STATUS_OPTION     :  symbol=new CSymbolOption(name,index);     break;   // Option
      case SYMBOL_STATUS_COLLATERAL :  symbol=new CSymbolCollateral(name,index); break;   // Non-tradable asset
      case SYMBOL_STATUS_CUSTOM     :  symbol=new CSymbolCustom(name,index);     break;   // Custom symbol
      default                       :  symbol=new CSymbolCommon(name,index);     break;   // The rest
     }
   if(symbol==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_SYM_OBJ),name);
      return false;
     }
   if(!this.m_list_all_symbols.Add(symbol))
     {
      string t1=CMessage::Text(MSG_LIB_SYS_FAILED_ADD_SYM_OBJ);
      string t2=CMessage::Text(MSG_LIB_TEXT_SYMBOL_TO_LIST);
      ::Print(DFUN,t1,name,t2);
      delete symbol;
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Return the symbol object presence flag                           |
//| by its name in the list of all symbols                           |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPresentSymbolInList(const string symbol_name)
  {
   CArrayObj *list=dynamic_cast<CListObj*>(&this.m_list_all_symbols);
   list.Sort(SORT_BY_SYMBOL_NAME);
   list=CSelect::BySymbolProperty(list,SYMBOL_PROP_NAME,symbol_name,EQUAL);
   return(list==NULL || list.Total()==0 ? false : true);
  }
//+------------------------------------------------------------------+
//| Return the visible symbol object presence flag                   |
//| by its name in the Market Watch window                           |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPresentSymbolInMW(const string symbol_name)
  {
   int total=SymbolsTotal(true);
   for(int i=0;i<total;i++)
     {
      string name=::SymbolName(i,true);
      if(!::SymbolInfoInteger(name,SYMBOL_VISIBLE))
         continue;
      if(name==symbol_name)
         return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Return the flag of a symbol object presence in the control list  |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPresentSymbolInControlList(const string symbol_name)
  {
   int total=this.m_list_names.Total();
   for(int i=0;i<total;i++)
     {
      string name=this.m_list_names.At(i);
      if(name==NULL)
         continue;
      if(name==symbol_name)
         return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Set the list of used symbols                                     |
//+------------------------------------------------------------------+
bool CSymbolsCollection::SetUsedSymbols(const string &symbol_used_array[])
  {
   ::ArrayResize(this.m_array_symbols,0,SYMBOLS_COMMON_TOTAL);
   ::ArrayCopy(this.m_array_symbols,symbol_used_array);
   this.m_mode_list=this.TypeSymbolsList(this.m_array_symbols);
   this.m_list_all_symbols.Clear();
   this.m_list_all_symbols.Sort(SORT_BY_SYMBOL_INDEX_MW);
   //--- Use only the current symbol
   if(this.m_mode_list==SYMBOLS_MODE_CURRENT)
     {
      string name=::Symbol();
      ENUM_SYMBOL_STATUS status=this.SymbolStatus(name);
      return this.CreateNewSymbol(status,name,this.SymbolIndexInMW(name));
     }
   else
     {
      bool res=true;
      //--- Use the pre-defined symbol list
      if(this.m_mode_list==SYMBOLS_MODE_DEFINES)
        {
         int total=::ArraySize(this.m_array_symbols);
         for(int i=0;i<total;i++)
           {
            string name=this.m_array_symbols[i];
            ENUM_SYMBOL_STATUS status=this.SymbolStatus(name);
            bool add=this.CreateNewSymbol(status,name,this.SymbolIndexInMW(name));
            res &=add;
            if(!add) 
               continue;
           }
         //--- Create the new current symbol (if it is already in the list, it is not re-created)
         res &=this.CreateNewSymbol(this.SymbolStatus(NULL),NULL,this.SymbolIndexInMW(NULL));
         return res;
        }
      //--- Use the full list of the server symbols
      else if(this.m_mode_list==SYMBOLS_MODE_ALL)
        {
         return this.CreateSymbolsList(false);
        }
      //--- Use the symbol list from the Market Watch window
      else if(this.m_mode_list==SYMBOLS_MODE_MARKET_WATCH)
        {
         this.MarketWatchEventsControl(false);
         return true;
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Creating the symbol list (Market Watch or the complete list)     |
//+------------------------------------------------------------------+
bool CSymbolsCollection::CreateSymbolsList(const bool flag)
  {
   bool res=true;
   int total=::SymbolsTotal(flag);
   for(int i=0;i<total && i<SYMBOLS_COMMON_TOTAL;i++)
     {
      string name=::SymbolName(i,flag);
      if(flag && !::SymbolInfoInteger(name,SYMBOL_VISIBLE))
         continue;
      ENUM_SYMBOL_STATUS status=this.SymbolStatus(name);
      bool add=this.CreateNewSymbol(status,name,i);
      res &=add;
      if(!add) 
         continue;
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Save names of used Market Watch symbols                          |
//+------------------------------------------------------------------+
void CSymbolsCollection::CopySymbolsNames(void)
  {
   this.m_list_names.Clear();
   int total=this.m_list_all_symbols.Total();
   for(int i=0;i<total;i++)
     {
      CSymbol *symbol=this.m_list_all_symbols.At(i);
      if(symbol==NULL)
         continue;
      this.m_list_names.Add(symbol.Name());
     }
  }
//+------------------------------------------------------------------+
//|Return the type of a used symbol list (Market watch/Server)       |
//+------------------------------------------------------------------+
ENUM_SYMBOLS_MODE CSymbolsCollection::TypeSymbolsList(const string &symbol_used_array[])
  {
   int total=::ArraySize(symbol_used_array);
   if(total<1)
      return SYMBOLS_MODE_CURRENT;
   string type=::StringSubstr(symbol_used_array[0],13);
   return
     (
      type=="MARKET_WATCH" ? SYMBOLS_MODE_MARKET_WATCH   :
      type=="ALL"          ? SYMBOLS_MODE_ALL            :
      (total==1 && symbol_used_array[0]==::Symbol() ? SYMBOLS_MODE_CURRENT : SYMBOLS_MODE_DEFINES)
     );
  }
//+------------------------------------------------------------------+
//| Return the number of visible symbols in the Market Watch window  |
//+------------------------------------------------------------------+
int CSymbolsCollection::SymbolsTotalVisible(void) const
  {
   int total=::SymbolsTotal(true),n=0;
   for(int i=0;i<total;i++)
     {
      if(!::SymbolInfoInteger(::SymbolName(i,true),SYMBOL_VISIBLE))
         continue;
      n++;
     }
   return n;
  }
//+------------------------------------------------------------------+
//| Return symbol index in the Market Watch window                   |
//+------------------------------------------------------------------+
int CSymbolsCollection::SymbolIndexInMW(const string symbol_name) const
  {
   string name=(symbol_name==NULL || symbol_name=="" ? ::Symbol() : symbol_name);
   int total=::SymbolsTotal(true);
   for(int i=0;i<total;i++)
     {
      if(!::SymbolInfoInteger(::SymbolName(i,true),SYMBOL_VISIBLE))
         continue;
      if(SymbolName(i,true)==name)
         return i;
     }
   return WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| Define a symbol affiliation with a group by name and return it   |
//+------------------------------------------------------------------+
ENUM_SYMBOL_STATUS CSymbolsCollection::SymbolStatus(const string symbol_name) const
  {
   ENUM_SYMBOL_STATUS status=this.StatusByCustomPredefined(symbol_name);
   return(status==SYMBOL_STATUS_COMMON ? this.StatusByCalcMode(symbol_name) : status);
  }
//+------------------------------------------------------------------+
//| Return a symbol affiliation with majors                          |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPredefinedFXMajor(const string name) const
  {
   int total=::ArraySize(DataSymbolsFXMajors);
   for(int i=0;i<total;i++)
      if(name==DataSymbolsFXMajors[i])
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return a symbol affiliation with minors                          |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPredefinedFXMinor(const string name) const
  {
   int total=::ArraySize(DataSymbolsFXMinors);
   for(int i=0;i<total;i++)
      if(name==DataSymbolsFXMinors[i])
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return a symbol affiliation with exotic symbols                  |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPredefinedFXExotic(const string name) const
  {
   int total=::ArraySize(DataSymbolsFXExotics);
   for(int i=0;i<total;i++)
      if(name==DataSymbolsFXExotics[i])
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return a symbol affiliation with RUB symbols                     |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPredefinedFXRUB(const string name) const
  {
   int total=::ArraySize(DataSymbolsFXRub);
   for(int i=0;i<total;i++)
      if(name==DataSymbolsFXRub[i])
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return a symbol affiliation with indicative symbols              |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPredefinedIndicative(const string name) const
  {
   int total=::ArraySize(DataSymbolsFXIndicatives);
   for(int i=0;i<total;i++)
      if(name==DataSymbolsFXIndicatives[i])
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return a symbol affiliation with metals                          |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPredefinedMetall(const string name) const
  {
   int total=::ArraySize(DataSymbolsMetalls);
   for(int i=0;i<total;i++)
      if(name==DataSymbolsMetalls[i])
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return a symbol affiliation with commodities                     |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPredefinedCommodity(const string name) const
  {
   int total=::ArraySize(DataSymbolsCommodities);
   for(int i=0;i<total;i++)
      if(name==DataSymbolsCommodities[i])
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return a symbol affiliation with indices                         |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPredefinedIndex(const string name) const
  {
   int total=::ArraySize(DataSymbolsIndexes);
   for(int i=0;i<total;i++)
      if(name==DataSymbolsIndexes[i])
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return a symbol affiliation with a cryptocurrency                |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPredefinedCrypto(const string name) const
  {
   int total=::ArraySize(DataSymbolsCrypto);
   for(int i=0;i<total;i++)
      if(name==DataSymbolsCrypto[i])
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return a symbol affiliation with options                         |
//+------------------------------------------------------------------+
bool CSymbolsCollection::IsPredefinedOption(const string name) const
  {
   int total=::ArraySize(DataSymbolsOptions);
   for(int i=0;i<total;i++)
      if(name==DataSymbolsOptions[i])
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return a category by custom criteria                             |
//+------------------------------------------------------------------+
ENUM_SYMBOL_STATUS CSymbolsCollection::StatusByCustomPredefined(const string symbol_name) const
  {
   string name=(symbol_name==NULL || symbol_name=="" ? ::Symbol() : symbol_name);
   return
     (
      this.IsPredefinedFXMajor(name)      ?  SYMBOL_STATUS_FX_MAJOR     :
      this.IsPredefinedFXMinor(name)      ?  SYMBOL_STATUS_FX_MINOR     :
      this.IsPredefinedFXExotic(name)     ?  SYMBOL_STATUS_FX_EXOTIC    :
      this.IsPredefinedFXRUB(name)        ?  SYMBOL_STATUS_FX_RUB       :
      this.IsPredefinedOption(name)       ?  SYMBOL_STATUS_OPTION       :
      this.IsPredefinedCommodity(name)    ?  SYMBOL_STATUS_COMMODITY    :
      this.IsPredefinedCrypto(name)       ?  SYMBOL_STATUS_CRYPTO       :
      this.IsPredefinedMetall(name)       ?  SYMBOL_STATUS_METAL        :
      this.IsPredefinedIndex(name)        ?  SYMBOL_STATUS_INDEX        :
      this.IsPredefinedIndicative(name)   ?  SYMBOL_STATUS_INDICATIVE   :
      SYMBOL_STATUS_COMMON
     );
  }  
//+------------------------------------------------------------------+
//|Return affiliation with a margin calculation category             |
//+------------------------------------------------------------------+
ENUM_SYMBOL_STATUS CSymbolsCollection::StatusByCalcMode(const string symbol_name) const
  {
   ENUM_SYMBOL_CALC_MODE calc_mode=(ENUM_SYMBOL_CALC_MODE)::SymbolInfoInteger(symbol_name,SYMBOL_TRADE_CALC_MODE);
   return
     (
      calc_mode==SYMBOL_CALC_MODE_EXCH_OPTIONS_MARGIN                                                                               ?  SYMBOL_STATUS_OPTION       :
      calc_mode==SYMBOL_CALC_MODE_SERV_COLLATERAL                                                                                   ?  SYMBOL_STATUS_COLLATERAL   :
      calc_mode==SYMBOL_CALC_MODE_FUTURES                                                                                           ?  SYMBOL_STATUS_FUTURES      :
      calc_mode==SYMBOL_CALC_MODE_CFD           || calc_mode==SYMBOL_CALC_MODE_CFDINDEX || calc_mode==SYMBOL_CALC_MODE_CFDLEVERAGE  ?  SYMBOL_STATUS_CFD          :
      calc_mode==SYMBOL_CALC_MODE_FOREX         || calc_mode==SYMBOL_CALC_MODE_FOREX_NO_LEVERAGE                                    ?  SYMBOL_STATUS_FX           :
      calc_mode==SYMBOL_CALC_MODE_EXCH_STOCKS   || calc_mode==SYMBOL_CALC_MODE_EXCH_STOCKS_MOEX                                     ?  SYMBOL_STATUS_STOCKS       :
      calc_mode==SYMBOL_CALC_MODE_EXCH_BONDS    || calc_mode==SYMBOL_CALC_MODE_EXCH_BONDS_MOEX                                      ?  SYMBOL_STATUS_BONDS        :
      calc_mode==SYMBOL_CALC_MODE_EXCH_FUTURES  || calc_mode==SYMBOL_CALC_MODE_EXCH_FUTURES_FORTS                                   ?  SYMBOL_STATUS_FUTURES      :
      SYMBOL_STATUS_COMMON
     );
  }
//+------------------------------------------------------------------+
//| Return an object symbol from the list by a name                  |
//+------------------------------------------------------------------+
CSymbol *CSymbolsCollection::GetSymbolObjByName(const string name)
  {
   CArrayObj *list=this.GetList(SYMBOL_PROP_NAME,name,EQUAL);
   if(list==NULL || list.Total()==0)
      return NULL;
   CSymbol *symbol=list.At(0);
   return(symbol!=NULL ? symbol : NULL);
  }
//+------------------------------------------------------------------+
//| Return the symbol object index from the list by a name           |
//+------------------------------------------------------------------+
int CSymbolsCollection::GetIndexObjByName(const string name)
  {
   int total=this.m_list_all_symbols.Total();
   for(int i=0;i<total;i++)
     {
      CSymbol *symbol=this.m_list_all_symbols.At(i);
      if(symbol==NULL)
         continue;
      if(symbol.Name()==name)
         return i;
     }
   return WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| Return the Market Watch window event description                 |
//+------------------------------------------------------------------+
string CSymbolsCollection::EventMWDescription(const ENUM_MW_EVENT event)
  {
   return
     (
      event==MARKET_WATCH_EVENT_SYMBOL_ADD   ?  CMessage::Text(MSG_SYM_EVENT_SYMBOL_ADD)  :
      event==MARKET_WATCH_EVENT_SYMBOL_DEL   ?  CMessage::Text(MSG_SYM_EVENT_SYMBOL_DEL)  :
      event==MARKET_WATCH_EVENT_SYMBOL_SORT  ?  CMessage::Text(MSG_SYM_EVENT_SYMBOL_SORT) :
      EnumToString(event)
     );
  }
//+------------------------------------------------------------------+
//| Return a description of the mode of working with symbols         |
//+------------------------------------------------------------------+
string CSymbolsCollection::ModeSymbolsListDescription(void)
  {
   return
     (
      this.m_mode_list==SYMBOLS_MODE_CURRENT       ? CMessage::Text(MSG_SYM_SYMBOLS_MODE_CURRENT)        : 
      this.m_mode_list==SYMBOLS_MODE_DEFINES       ? CMessage::Text(MSG_SYM_SYMBOLS_MODE_DEFINES)        :
      this.m_mode_list==SYMBOLS_MODE_MARKET_WATCH  ? CMessage::Text(MSG_SYM_SYMBOLS_MODE_MARKET_WATCH)   :
      CMessage::Text(MSG_SYM_SYMBOLS_MODE_ALL)
     );
  }
//+------------------------------------------------------------------+

