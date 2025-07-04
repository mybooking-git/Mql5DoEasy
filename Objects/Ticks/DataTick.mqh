//+------------------------------------------------------------------+
//|                                                     DataTick.mqh |
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
#include "..\BaseObj.mqh"
#include "..\..\Services\DELib.mqh"
//+------------------------------------------------------------------+
//| "Tick" class                                                     |
//+------------------------------------------------------------------+
class CDataTick : public CBaseObj
  {
private:
   MqlTick           m_tick;                                      // Structure for obtaining current prices
   int               m_digits;                                    // Symbol's digits value
   long              m_long_prop[TICK_PROP_INTEGER_TOTAL];        // Integer properties
   double            m_double_prop[TICK_PROP_DOUBLE_TOTAL];       // Real properties
   string            m_string_prop[TICK_PROP_STRING_TOTAL];       // String properties

//--- Return the index of the array the tick’s (1) double and (2) string properties are actually located at
   int               IndexProp(ENUM_TICK_PROP_DOUBLE property)       const { return(int)property-TICK_PROP_INTEGER_TOTAL;                       }
   int               IndexProp(ENUM_TICK_PROP_STRING property)       const { return(int)property-TICK_PROP_INTEGER_TOTAL-TICK_PROP_DOUBLE_TOTAL;}

public:
//--- Set tick’s (1) integer, (2) real and (3) string property
   void              SetProperty(ENUM_TICK_PROP_INTEGER property,long value)  { this.m_long_prop[property]=value;                               }
   void              SetProperty(ENUM_TICK_PROP_DOUBLE property,double value) { this.m_double_prop[this.IndexProp(property)]=value;             }
   void              SetProperty(ENUM_TICK_PROP_STRING property,string value) { this.m_string_prop[this.IndexProp(property)]=value;             }
//--- Return tick’s (1) integer, (2) real and (3) string property from the properties array
   long              GetProperty(ENUM_TICK_PROP_INTEGER property)    const { return this.m_long_prop[property];                                 }
   double            GetProperty(ENUM_TICK_PROP_DOUBLE property)     const { return this.m_double_prop[this.IndexProp(property)];               }
   string            GetProperty(ENUM_TICK_PROP_STRING property)     const { return this.m_string_prop[this.IndexProp(property)];               }

//--- Return the flag of the tick supporting this property
   virtual bool      SupportProperty(ENUM_TICK_PROP_INTEGER property)      { return true; }
   virtual bool      SupportProperty(ENUM_TICK_PROP_DOUBLE property)       { return true; }
   virtual bool      SupportProperty(ENUM_TICK_PROP_STRING property)       { return true; }
//--- Return itself
   CDataTick        *GetObject(void)                                       { return &this;}

//--- Compare CDataTick objects with each other by the specified property (for sorting the lists by a specified object property)
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Compare CDataTick objects with each other by all properties (to search equal objects)
   bool              IsEqual(CDataTick* compared_obj) const;
//--- Constructors
                     CDataTick(){ this.m_type=OBJECT_DE_TYPE_TICK; }
                     CDataTick(const string symbol,const MqlTick &tick);
        
//+------------------------------------------------------------------+
//| Descriptions of object tick data properties                      |
//+------------------------------------------------------------------+
//--- Return description of tick's (1) integer, (2) real and (3) string property
   string            GetPropertyDescription(ENUM_TICK_PROP_INTEGER property);
   string            GetPropertyDescription(ENUM_TICK_PROP_DOUBLE property);
   string            GetPropertyDescription(ENUM_TICK_PROP_STRING property);

//--- Display the description of the object properties in the journal (full_prop=true - all properties, false - supported ones only - implemented in descendant classes)
   virtual void      Print(const bool full_prop=false,const bool dash=false);
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
//---  Return the (1) short name and (2) description of tick data object flags
   virtual string    Header(void);
   string            FlagsDescription(void);
   
//+------------------------------------------------------------------+ 
//| Methods of simplified access to tick data object properties      |
//+------------------------------------------------------------------+
//--- Return tick’s (1) Time, (2) time in milliseconds, (3) volume, (4) flags
   datetime          Time(void)                                         const { return (datetime)this.GetProperty(TICK_PROP_TIME);           }
   long              TimeMSC(void)                                      const { return this.GetProperty(TICK_PROP_TIME_MSC);                 }
   long              Volume(void)                                       const { return this.GetProperty(TICK_PROP_VOLUME);                   }
   uint              Flags(void)                                        const { return (uint)this.GetProperty(TICK_PROP_FLAGS);              }
   
//--- Return tick’s (1) Bid, (2) Ask, (3) Last price, (4) volume with greater accuracy, (5) spread of the tick
//--- size of the (9) candle upper, (10) lower wick
   double            Bid(void)                                          const { return this.GetProperty(TICK_PROP_BID);                      }
   double            Ask(void)                                          const { return this.GetProperty(TICK_PROP_ASK);                      }
   double            Last(void)                                         const { return this.GetProperty(TICK_PROP_LAST);                     }
   double            VolumeReal(void)                                   const { return this.GetProperty(TICK_PROP_VOLUME_REAL);              }
   double            Spread(void)                                       const { return this.GetProperty(TICK_PROP_SPREAD);                   }
   
//--- Return tick symbol
   string            Symbol(void)                                       const { return this.GetProperty(TICK_PROP_SYMBOL);                   }

//--- Return bar (1) time, (2) index on the specified timeframe the tick time falls into
   datetime          TimeBar(const ENUM_TIMEFRAMES timeframe)const
                       { return ::iTime(this.Symbol(),timeframe,this.Index(timeframe));                                                      }
   int               Index(const ENUM_TIMEFRAMES timeframe)  const
                       { return ::iBarShift(this.Symbol(),(timeframe==PERIOD_CURRENT ? ::Period() : timeframe),this.Time());                 }  

//--- Return the flag of (1) Bid, (2) Ask, (3) Last price change, (4) volume change; (5) buy and (6) sell deal
   bool              IsChangeBid()                                      const { return((this.Flags() & TICK_FLAG_BID)==TICK_FLAG_BID);       }
   bool              IsChangeAsk()                                      const { return((this.Flags() & TICK_FLAG_ASK)==TICK_FLAG_ASK);       }
   bool              IsChangeLast()                                     const { return((this.Flags() & TICK_FLAG_LAST)==TICK_FLAG_LAST);     }
   bool              IsChangeVolume()                                   const { return((this.Flags() & TICK_FLAG_VOLUME)==TICK_FLAG_VOLUME); }
   bool              IsChangeBuy()                                      const { return((this.Flags() & TICK_FLAG_BUY)==TICK_FLAG_BUY);       }
   bool              IsChangeSell()                                     const { return((this.Flags() & TICK_FLAG_SELL)==TICK_FLAG_SELL);     }
//---
  };
//+------------------------------------------------------------------+
//| Parametric constructor                                           |
//+------------------------------------------------------------------+
CDataTick::CDataTick(const string symbol,const MqlTick &tick)
  {
   this.m_type=OBJECT_DE_TYPE_TICK; 
//--- Save symbol’s Digits
   this.m_digits=(int)::SymbolInfoInteger(symbol,SYMBOL_DIGITS);
//--- Save integer tick properties
   this.SetProperty(TICK_PROP_TIME,tick.time);
   this.SetProperty(TICK_PROP_TIME_MSC,tick.time_msc);
   this.SetProperty(TICK_PROP_VOLUME,tick.volume);
   this.SetProperty(TICK_PROP_FLAGS,tick.flags);
//--- Save real tick properties
   this.SetProperty(TICK_PROP_BID,tick.bid);
   this.SetProperty(TICK_PROP_ASK,tick.ask);
   this.SetProperty(TICK_PROP_LAST,tick.last);
   this.SetProperty(TICK_PROP_VOLUME_REAL,tick.volume_real);
//--- Save additional tick properties
   this.SetProperty(TICK_PROP_SPREAD,tick.ask-tick.bid);
   this.SetProperty(TICK_PROP_SYMBOL,(symbol==NULL || symbol=="" ? ::Symbol() : symbol));
  }
//+--------------------------------------------------------------------+
//| Compare CDataTick objects with each other by the specified property|
//+--------------------------------------------------------------------+
int CDataTick::Compare(const CObject *node,const int mode=0) const
  {
   const CDataTick *obj_compared=node;
//--- compare integer properties of two objects
   if(mode<TICK_PROP_INTEGER_TOTAL)
     {
      long value_compared=obj_compared.GetProperty((ENUM_TICK_PROP_INTEGER)mode);
      long value_current=this.GetProperty((ENUM_TICK_PROP_INTEGER)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare real properties of two objects
   else if(mode<TICK_PROP_DOUBLE_TOTAL+TICK_PROP_INTEGER_TOTAL)
     {
      double value_compared=obj_compared.GetProperty((ENUM_TICK_PROP_DOUBLE)mode);
      double value_current=this.GetProperty((ENUM_TICK_PROP_DOUBLE)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare string properties of two objects
   else if(mode<TICK_PROP_DOUBLE_TOTAL+TICK_PROP_INTEGER_TOTAL+TICK_PROP_STRING_TOTAL)
     {
      string value_compared=obj_compared.GetProperty((ENUM_TICK_PROP_STRING)mode);
      string value_current=this.GetProperty((ENUM_TICK_PROP_STRING)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//| Compare CDataTick objects with each other by all properties      |
//+------------------------------------------------------------------+
bool CDataTick::IsEqual(CDataTick *compared_obj) const
  {
   int begin=0, end=TICK_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_TICK_PROP_INTEGER prop=(ENUM_TICK_PROP_INTEGER)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=TICK_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_TICK_PROP_DOUBLE prop=(ENUM_TICK_PROP_DOUBLE)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=TICK_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_TICK_PROP_STRING prop=(ENUM_TICK_PROP_STRING)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Display tick properties in the journal                           |
//+------------------------------------------------------------------+
void CDataTick::Print(const bool full_prop=false,const bool dash=false)
  {
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_BEG)," (",this.Header(),") =============");
   int begin=0, end=TICK_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_TICK_PROP_INTEGER prop=(ENUM_TICK_PROP_INTEGER)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=TICK_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_TICK_PROP_DOUBLE prop=(ENUM_TICK_PROP_DOUBLE)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=TICK_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_TICK_PROP_STRING prop=(ENUM_TICK_PROP_STRING)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_END)," (",this.Header(),") =============\n");
  }
//+------------------------------------------------------------------+
//| Return description of tick's integer property                    |
//+------------------------------------------------------------------+
string CDataTick::GetPropertyDescription(ENUM_TICK_PROP_INTEGER property)
  {
   return
     (
      property==TICK_PROP_TIME_MSC           ?  CMessage::Text(MSG_TICK_TIME_MSC)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+TimeMSCtoString(this.GetProperty(property),TIME_DATE|TIME_MINUTES|TIME_SECONDS)
         )  :
      property==TICK_PROP_TIME               ?  CMessage::Text(MSG_TICK_TIME)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::TimeToString(this.GetProperty(property),TIME_DATE|TIME_MINUTES|TIME_SECONDS)
         )  :
      property==TICK_PROP_VOLUME             ?  CMessage::Text(MSG_TICK_VOLUME)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==TICK_PROP_FLAGS              ?  CMessage::Text(MSG_TICK_FLAGS)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)+"\n"+CMessage::Text(MSG_LIB_TEXT_TICK_CHANGED_DATA)+this.FlagsDescription()
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of tick's real property                       |
//+------------------------------------------------------------------+
string CDataTick::GetPropertyDescription(ENUM_TICK_PROP_DOUBLE property)
  {
   int dg=(this.m_digits>0 ? this.m_digits : 1);
   return
     (
      property==TICK_PROP_BID                ?  CMessage::Text(MSG_LIB_PROP_BID)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==TICK_PROP_ASK                ?  CMessage::Text(MSG_LIB_PROP_ASK)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==TICK_PROP_LAST               ?  CMessage::Text(MSG_LIB_PROP_LAST)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==TICK_PROP_VOLUME_REAL        ?  CMessage::Text(MSG_TICK_VOLUME_REAL)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),2)
         )  :
      property==TICK_PROP_SPREAD             ?  CMessage::Text(MSG_TICK_SPREAD)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of tick's string property                     |
//+------------------------------------------------------------------+
string CDataTick::GetPropertyDescription(ENUM_TICK_PROP_STRING property)
  {
   return(property==TICK_PROP_SYMBOL ? CMessage::Text(MSG_LIB_PROP_SYMBOL)+": \""+this.GetProperty(property)+"\"" : "");
  }
//+------------------------------------------------------------------+
//| Display the description of flags                                 |
//+------------------------------------------------------------------+
string CDataTick::FlagsDescription(void)
  {
   string flags=
     (
      (this.IsChangeAsk()     ? "\n - "+CMessage::Text(MSG_LIB_TEXT_TICK_FLAG_ASK)     : "")+
      (this.IsChangeBid()     ? "\n - "+CMessage::Text(MSG_LIB_TEXT_TICK_FLAG_BID)     : "")+
      (this.IsChangeLast()    ? "\n - "+CMessage::Text(MSG_LIB_TEXT_TICK_FLAG_LAST)    : "")+
      (this.IsChangeVolume()  ? "\n - "+CMessage::Text(MSG_LIB_TEXT_TICK_FLAG_VOLUME)  : "")+
      (this.IsChangeBuy()     ? "\n - "+CMessage::Text(MSG_DEAL_TO_BUY)                : "")+
      (this.IsChangeSell()    ? "\n - "+CMessage::Text(MSG_DEAL_TO_SELL)               : "")
     );
  return flags; 
  }
//+------------------------------------------------------------------+
//| Display a short description of the tick in the journal           |
//+------------------------------------------------------------------+
void CDataTick::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print(this.Header());
  }
//+------------------------------------------------------------------+
//| Return a short name of tick data object                          |
//+------------------------------------------------------------------+
string CDataTick::Header(void)
  {
   return
     (
      CMessage::Text(MSG_TICK_TEXT_TICK)+" \""+this.Symbol()+"\" "+TimeMSCtoString(TimeMSC())
     );
  }
//+------------------------------------------------------------------+
