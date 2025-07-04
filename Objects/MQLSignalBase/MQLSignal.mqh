//+------------------------------------------------------------------+
//|                                                    MQLSignal.mqh |
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
#include "..\..\Objects\BaseObj.mqh"
//+------------------------------------------------------------------+
//| MQL5 signal class                                                |
//+------------------------------------------------------------------+
class CMQLSignal : public CBaseObj
  {
private:
   long              m_long_prop[SIGNAL_MQL5_PROP_INTEGER_TOTAL];       // Integer properties
   double            m_double_prop[SIGNAL_MQL5_PROP_DOUBLE_TOTAL];      // Real properties
   string            m_string_prop[SIGNAL_MQL5_PROP_STRING_TOTAL];      // String properties

//--- Return the index of the array the (1) double and (2) string properties are actually located at
   int               IndexProp(ENUM_SIGNAL_MQL5_PROP_DOUBLE property)   const { return(int)property-SIGNAL_MQL5_PROP_INTEGER_TOTAL;                               }
   int               IndexProp(ENUM_SIGNAL_MQL5_PROP_STRING property)   const { return(int)property-SIGNAL_MQL5_PROP_INTEGER_TOTAL-SIGNAL_MQL5_PROP_DOUBLE_TOTAL; }

public:
//--- Set object's (1) integer, (2) real and (3) string properties
   void              SetProperty(ENUM_SIGNAL_MQL5_PROP_INTEGER property,long value)    { this.m_long_prop[property]=value;                      }
   void              SetProperty(ENUM_SIGNAL_MQL5_PROP_DOUBLE property,double value)   { this.m_double_prop[this.IndexProp(property)]=value;    }
   void              SetProperty(ENUM_SIGNAL_MQL5_PROP_STRING property,string value)   { this.m_string_prop[this.IndexProp(property)]=value;    }
//--- Return object’s (1) integer, (2) real and (3) string property from the properties array
   long              GetProperty(ENUM_SIGNAL_MQL5_PROP_INTEGER property)         const { return this.m_long_prop[property];                     }
   double            GetProperty(ENUM_SIGNAL_MQL5_PROP_DOUBLE property)          const { return this.m_double_prop[this.IndexProp(property)];   }
   string            GetProperty(ENUM_SIGNAL_MQL5_PROP_STRING property)          const { return this.m_string_prop[this.IndexProp(property)];   }
//--- Return itself
   CMQLSignal       *GetObject(void)                                                   { return &this;}

//--- Return the flag of the object supporting this property
   virtual bool      SupportProperty(ENUM_SIGNAL_MQL5_PROP_INTEGER property)           { return true; }
   virtual bool      SupportProperty(ENUM_SIGNAL_MQL5_PROP_DOUBLE property)            { return true; }
   virtual bool      SupportProperty(ENUM_SIGNAL_MQL5_PROP_STRING property)            { return true; }

//--- Get description of (1) integer, (2) real and (3) string properties
   string            GetPropertyDescription(ENUM_SIGNAL_MQL5_PROP_INTEGER property);
   string            GetPropertyDescription(ENUM_SIGNAL_MQL5_PROP_DOUBLE property);
   string            GetPropertyDescription(ENUM_SIGNAL_MQL5_PROP_STRING property);

//--- Display the description of the object properties in the journal (full_prop=true - all properties, false - supported ones only - implemented in descendant classes)
   virtual void      Print(const bool full_prop=false,const bool dash=false);
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
//--- Return the object short name
   virtual string    Header(const bool shrt=false);
   
//--- Compare CMQLSignal objects by a specified property (to sort the list by an MQL5 signal object)
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Compare CMQLSignal objects by all properties (to search for equal MQL5 signal objects)
   bool              IsEqual(CMQLSignal* compared_obj) const;
   
//--- Set signal object properties
   void              SetProperties(void);
//--- Look for a signal with a specified ID in the database, return the signal index
   int               IndexBase(const long signal_id);
//--- Select a signal in the signal database by its ID
   bool              SelectBase(const long signal_id);
   
//--- Constructors
                     CMQLSignal(){ this.m_type=OBJECT_DE_TYPE_MQL5_SIGNAL; }
                     CMQLSignal(const long signal_id);
                     
public:
//+------------------------------------------------------------------+ 
//| Methods of simplified access to MQL5 signal object               |
//+------------------------------------------------------------------+
//--- Returns the dates of (1) publication, (2) monitoring start, (3) trading statistics last update,
//--- (4) ID, (5) trading account leverage, (6) trading result in pips, (7) position in the signal rating,
//--- (8) number of subscribers, (9) number of trades, (10) account type, (11) flag of the current account subscription to a signal
   datetime          DatePublished(void)     const { return (datetime)this.GetProperty(SIGNAL_MQL5_PROP_DATE_PUBLISHED);         }
   datetime          DateStarted(void)       const { return (datetime)this.GetProperty(SIGNAL_MQL5_PROP_DATE_STARTED);           }
   datetime          DateUpdated(void)       const { return (datetime)this.GetProperty(SIGNAL_MQL5_PROP_DATE_UPDATED);           }
   long              ID(void)                const { return this.GetProperty(SIGNAL_MQL5_PROP_ID);                               }
   long              Leverage(void)          const { return this.GetProperty(SIGNAL_MQL5_PROP_LEVERAGE);                         }
   long              Pips(void)              const { return this.GetProperty(SIGNAL_MQL5_PROP_PIPS);                             }
   long              Rating(void)            const { return this.GetProperty(SIGNAL_MQL5_PROP_RATING);                           }
   long              Subscribers(void)       const { return this.GetProperty(SIGNAL_MQL5_PROP_SUBSCRIBERS);                      }
   long              Trades(void)            const { return this.GetProperty(SIGNAL_MQL5_PROP_TRADES);                           }
   long              TradeMode(void)         const { return (long)this.GetProperty(SIGNAL_MQL5_PROP_TRADE_MODE);                 }
   bool              SubscriptionStatus(void)const { return (bool)this.GetProperty(SIGNAL_MQL5_PROP_SUBSCRIPTION_STATUS);        }
//--- Return (1) the account balance, (2) account funds, (3) account growth in %,
//--- (4) maximum drawdown, (5) subscription price and (6) signal ROI value (Return on Investment) in %
   double            Balance(void)           const { return this.GetProperty(SIGNAL_MQL5_PROP_BALANCE);                          }
   double            Equity(void)            const { return this.GetProperty(SIGNAL_MQL5_PROP_EQUITY);                           }
   double            Gain(void)              const { return this.GetProperty(SIGNAL_MQL5_PROP_GAIN);                             }
   double            MaxDrawdown(void)       const { return this.GetProperty(SIGNAL_MQL5_PROP_MAX_DRAWDOWN);                     }
   double            Price(void)             const { return this.GetProperty(SIGNAL_MQL5_PROP_PRICE);                            }
   double            ROI(void)               const { return this.GetProperty(SIGNAL_MQL5_PROP_ROI);                              }
//--- Return (1) signal author's login, (2) broker (company) name,
//--- (3) broker server, (4) signal name and (5) signal account currency
   string            AuthorLogin(void)       const { return this.GetProperty(SIGNAL_MQL5_PROP_AUTHOR_LOGIN);                     }
   string            Broker(void)            const { return this.GetProperty(SIGNAL_MQL5_PROP_BROKER);                           }
   string            BrokerServer(void)      const { return this.GetProperty(SIGNAL_MQL5_PROP_BROKER_SERVER);                    }
   string            Name(void)              const { return this.GetProperty(SIGNAL_MQL5_PROP_NAME);                             }
   string            Currency(void)          const { return this.GetProperty(SIGNAL_MQL5_PROP_CURRENCY);                         }

//--- Set the dates of (1) publication, (2) monitoring start, (3) trading statistics last update,
//--- (4) ID, (5) trading account leverage, (6) trading result in pips, (7) position in the signal rating,
//--- (8) number of subscribers, (9) number of trades, (10) account type, (11) flag of the current account subscription to a signal
   void              SetDatePublished(const datetime date)  { this.SetProperty(SIGNAL_MQL5_PROP_DATE_PUBLISHED,date);            }
   void              SetDateStarted(const datetime date)    { this.SetProperty(SIGNAL_MQL5_PROP_DATE_STARTED,date);              }
   void              SetDateUpdated(const datetime date)    { this.SetProperty(SIGNAL_MQL5_PROP_DATE_UPDATED,date);              }
   void              SetID(const long id)                   { this.SetProperty(SIGNAL_MQL5_PROP_ID,id);                          }
   void              SetLeverage(const long value)          { this.SetProperty(SIGNAL_MQL5_PROP_LEVERAGE,value);                 }
   void              SetPips(const long value)              { this.SetProperty(SIGNAL_MQL5_PROP_PIPS,value);                     }
   void              SetRating(const long value)            { this.SetProperty(SIGNAL_MQL5_PROP_RATING,value);                   }
   void              SetSubscribers(const long value)       { this.SetProperty(SIGNAL_MQL5_PROP_SUBSCRIBERS,value);              }
   void              SetTrades(const long value)            { this.SetProperty(SIGNAL_MQL5_PROP_TRADES,value);                   }
   void              SetTradeMode(const long mode)          { this.SetProperty(SIGNAL_MQL5_PROP_TRADE_MODE,mode);                }
   void              SetSubscriptionStatus(const bool flag) { this.SetProperty(SIGNAL_MQL5_PROP_SUBSCRIPTION_STATUS,flag);       }
//--- Set (1) the account balance, (2) account funds, (3) account growth in %,
//--- (4) maximum drawdown, (5) subscription price and (6) signal ROI value (Return on Investment) in %
   void              SetBalance(const double value)         { this.SetProperty(SIGNAL_MQL5_PROP_BALANCE,value);                  }
   void              SetEquity(const double value)          { this.SetProperty(SIGNAL_MQL5_PROP_EQUITY,value);                   }
   void              SetGain(const double value)            { this.SetProperty(SIGNAL_MQL5_PROP_GAIN,value);                     }
   void              SetMaxDrawdown(const double value)     { this.SetProperty(SIGNAL_MQL5_PROP_MAX_DRAWDOWN,value);             }
   void              SetPrice(const double value)           { this.SetProperty(SIGNAL_MQL5_PROP_PRICE,value);                    }
   void              SetROI(const double value)             { this.SetProperty(SIGNAL_MQL5_PROP_ROI,value);                      }
//--- Set (1) signal author's login, (2) broker (company) name,
//--- (3) broker server, (4) signal name and (5) signal account currency
   void              SetAuthorLogin(const string value)     { this.SetProperty(SIGNAL_MQL5_PROP_AUTHOR_LOGIN,value);             }
   void              SetBroker(const string value)          { this.SetProperty(SIGNAL_MQL5_PROP_BROKER,value);                   }
   void              SetBrokerServer(const string value)    { this.SetProperty(SIGNAL_MQL5_PROP_BROKER_SERVER,value);            }
   void              SetName(const string value)            { this.SetProperty(SIGNAL_MQL5_PROP_NAME,value);                     }
   void              SetCurrency(const string value)        { this.SetProperty(SIGNAL_MQL5_PROP_CURRENCY,value);                 }

//--- Return the account type name
   string            TradeModeDescription(void);
   
//--- Subscribe to a signal
   bool              Subscribe(void)                        { return ::SignalSubscribe(this.ID()); }
   
  };
//+------------------------------------------------------------------+
//| Parametric constructor                                           |
//+------------------------------------------------------------------+
CMQLSignal::CMQLSignal(const long signal_id)
  {
   this.m_type=OBJECT_DE_TYPE_MQL5_SIGNAL; 
   this.m_long_prop[SIGNAL_MQL5_PROP_ID] = signal_id;
   this.SetProperties();
  }
//+------------------------------------------------------------------+
//| Set object properties                                            |
//+------------------------------------------------------------------+
void CMQLSignal::SetProperties(void)
  {
   this.m_long_prop[SIGNAL_MQL5_PROP_SUBSCRIPTION_STATUS]            = (::SignalInfoGetInteger(SIGNAL_INFO_ID)==this.ID());
   this.m_long_prop[SIGNAL_MQL5_PROP_TRADE_MODE]                     = ::SignalBaseGetInteger(SIGNAL_BASE_TRADE_MODE);
   this.m_long_prop[SIGNAL_MQL5_PROP_DATE_PUBLISHED]                 = ::SignalBaseGetInteger(SIGNAL_BASE_DATE_PUBLISHED);
   this.m_long_prop[SIGNAL_MQL5_PROP_DATE_STARTED]                   = ::SignalBaseGetInteger(SIGNAL_BASE_DATE_STARTED);
   this.m_long_prop[SIGNAL_MQL5_PROP_DATE_UPDATED]                   = ::SignalBaseGetInteger(SIGNAL_BASE_DATE_UPDATED);
   this.m_long_prop[SIGNAL_MQL5_PROP_LEVERAGE]                       = ::SignalBaseGetInteger(SIGNAL_BASE_LEVERAGE);
   this.m_long_prop[SIGNAL_MQL5_PROP_PIPS]                           = ::SignalBaseGetInteger(SIGNAL_BASE_PIPS);
   this.m_long_prop[SIGNAL_MQL5_PROP_RATING]                         = ::SignalBaseGetInteger(SIGNAL_BASE_RATING);
   this.m_long_prop[SIGNAL_MQL5_PROP_SUBSCRIBERS]                    = ::SignalBaseGetInteger(SIGNAL_BASE_SUBSCRIBERS);
   this.m_long_prop[SIGNAL_MQL5_PROP_TRADES]                         = ::SignalBaseGetInteger(SIGNAL_BASE_TRADES);
   
   this.m_double_prop[this.IndexProp(SIGNAL_MQL5_PROP_BALANCE)]      = ::SignalBaseGetDouble(SIGNAL_BASE_BALANCE);
   this.m_double_prop[this.IndexProp(SIGNAL_MQL5_PROP_EQUITY)]       = ::SignalBaseGetDouble(SIGNAL_BASE_EQUITY);
   this.m_double_prop[this.IndexProp(SIGNAL_MQL5_PROP_GAIN)]         = ::SignalBaseGetDouble(SIGNAL_BASE_GAIN);
   this.m_double_prop[this.IndexProp(SIGNAL_MQL5_PROP_MAX_DRAWDOWN)] = ::SignalBaseGetDouble(SIGNAL_BASE_MAX_DRAWDOWN);
   this.m_double_prop[this.IndexProp(SIGNAL_MQL5_PROP_PRICE)]        = ::SignalBaseGetDouble(SIGNAL_BASE_PRICE);
   this.m_double_prop[this.IndexProp(SIGNAL_MQL5_PROP_ROI)]          = ::SignalBaseGetDouble(SIGNAL_BASE_ROI);
   
   this.m_string_prop[this.IndexProp(SIGNAL_MQL5_PROP_AUTHOR_LOGIN)] = ::SignalBaseGetString(SIGNAL_BASE_AUTHOR_LOGIN);
   this.m_string_prop[this.IndexProp(SIGNAL_MQL5_PROP_BROKER)]       = ::SignalBaseGetString(SIGNAL_BASE_BROKER);
   this.m_string_prop[this.IndexProp(SIGNAL_MQL5_PROP_BROKER_SERVER)]= ::SignalBaseGetString(SIGNAL_BASE_BROKER_SERVER);
   this.m_string_prop[this.IndexProp(SIGNAL_MQL5_PROP_NAME)]         = ::SignalBaseGetString(SIGNAL_BASE_NAME);
   this.m_string_prop[this.IndexProp(SIGNAL_MQL5_PROP_CURRENCY)]     = ::SignalBaseGetString(SIGNAL_BASE_CURRENCY);
  }
//+----------------------------------------------------------------------+
//| Compare CMQLSignal objects with each other by the specified property |
//+----------------------------------------------------------------------+
int CMQLSignal::Compare(const CObject *node,const int mode=0) const
  {
   const CMQLSignal *obj_compared=node;
//--- compare integer properties of two objects
   if(mode<SIGNAL_MQL5_PROP_INTEGER_TOTAL)
     {
      long value_compared=obj_compared.GetProperty((ENUM_SIGNAL_MQL5_PROP_INTEGER)mode);
      long value_current=this.GetProperty((ENUM_SIGNAL_MQL5_PROP_INTEGER)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare real properties of two objects
   else if(mode<SIGNAL_MQL5_PROP_DOUBLE_TOTAL+SIGNAL_MQL5_PROP_INTEGER_TOTAL)
     {
      double value_compared=obj_compared.GetProperty((ENUM_SIGNAL_MQL5_PROP_DOUBLE)mode);
      double value_current=this.GetProperty((ENUM_SIGNAL_MQL5_PROP_DOUBLE)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare string properties of two objects
   else if(mode<SIGNAL_MQL5_PROP_DOUBLE_TOTAL+SIGNAL_MQL5_PROP_INTEGER_TOTAL+SIGNAL_MQL5_PROP_STRING_TOTAL)
     {
      string value_compared=obj_compared.GetProperty((ENUM_SIGNAL_MQL5_PROP_STRING)mode);
      string value_current=this.GetProperty((ENUM_SIGNAL_MQL5_PROP_STRING)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//| Compare CMQLSignal objects by all properties                     |
//+------------------------------------------------------------------+
bool CMQLSignal::IsEqual(CMQLSignal *compared_obj) const
  {
   int begin=0, end=SIGNAL_MQL5_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_SIGNAL_MQL5_PROP_INTEGER prop=(ENUM_SIGNAL_MQL5_PROP_INTEGER)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=SIGNAL_MQL5_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_SIGNAL_MQL5_PROP_DOUBLE prop=(ENUM_SIGNAL_MQL5_PROP_DOUBLE)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=SIGNAL_MQL5_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_SIGNAL_MQL5_PROP_STRING prop=(ENUM_SIGNAL_MQL5_PROP_STRING)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Return description of object's integer property                  |
//+------------------------------------------------------------------+
string CMQLSignal::GetPropertyDescription(ENUM_SIGNAL_MQL5_PROP_INTEGER property)
  {
   return
     (
      property==SIGNAL_MQL5_PROP_TRADE_MODE     ?  CMessage::Text(MSG_SIGNAL_MQL5_TRADE_MODE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.TradeModeDescription()
         )  :
      property==SIGNAL_MQL5_PROP_DATE_PUBLISHED ?  CMessage::Text(MSG_SIGNAL_MQL5_DATE_PUBLISHED)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::TimeToString(this.DatePublished())
         )  :
      property==SIGNAL_MQL5_PROP_DATE_STARTED   ?  CMessage::Text(MSG_SIGNAL_MQL5_DATE_STARTED)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::TimeToString(this.DateStarted())
         )  :
      property==SIGNAL_MQL5_PROP_DATE_UPDATED   ?  CMessage::Text(MSG_SIGNAL_MQL5_DATE_UPDATED)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::TimeToString(this.DateUpdated())
         )  :
      property==SIGNAL_MQL5_PROP_ID             ?  CMessage::Text(MSG_SIGNAL_MQL5_ID)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==SIGNAL_MQL5_PROP_LEVERAGE       ?  CMessage::Text(MSG_SIGNAL_MQL5_LEVERAGE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==SIGNAL_MQL5_PROP_PIPS           ?  CMessage::Text(MSG_SIGNAL_MQL5_PIPS)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==SIGNAL_MQL5_PROP_RATING         ?  CMessage::Text(MSG_SIGNAL_MQL5_RATING)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==SIGNAL_MQL5_PROP_SUBSCRIBERS    ?  CMessage::Text(MSG_SIGNAL_MQL5_SUBSCRIBERS)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==SIGNAL_MQL5_PROP_TRADES        ?  CMessage::Text(MSG_SIGNAL_MQL5_TRADES)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==SIGNAL_MQL5_PROP_SUBSCRIPTION_STATUS  ?  CMessage::Text(MSG_SIGNAL_MQL5_SUBSCRIPTION_STATUS)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property) ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of object's real property                     |
//+------------------------------------------------------------------+
string CMQLSignal::GetPropertyDescription(ENUM_SIGNAL_MQL5_PROP_DOUBLE property)
  {
   return
     (
      property==SIGNAL_MQL5_PROP_BALANCE         ?  CMessage::Text(MSG_ACC_PROP_BALANCE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),2)
         )  :
      property==SIGNAL_MQL5_PROP_EQUITY   ?  CMessage::Text(MSG_SIGNAL_MQL5_EQUITY)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),2)
         )  :
         
      property==SIGNAL_MQL5_PROP_GAIN   ?  CMessage::Text(MSG_SIGNAL_MQL5_GAIN)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),2)
         )  :
      property==SIGNAL_MQL5_PROP_MAX_DRAWDOWN   ?  CMessage::Text(MSG_SIGNAL_MQL5_MAX_DRAWDOWN)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),2)
         )  :
      property==SIGNAL_MQL5_PROP_PRICE   ?  CMessage::Text(MSG_SIGNAL_MQL5_PRICE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),2)
         )  :
      property==SIGNAL_MQL5_PROP_ROI   ?  CMessage::Text(MSG_SIGNAL_MQL5_ROI)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),2)
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of object's string property                   |
//+------------------------------------------------------------------+
string CMQLSignal::GetPropertyDescription(ENUM_SIGNAL_MQL5_PROP_STRING property)
  {
   return
     (
      property==SIGNAL_MQL5_PROP_AUTHOR_LOGIN   ?  CMessage::Text(MSG_SIGNAL_MQL5_AUTHOR_LOGIN)+": \""+this.GetProperty(property)+"\""    :
      property==SIGNAL_MQL5_PROP_BROKER         ?  CMessage::Text(MSG_SIGNAL_MQL5_BROKER)+": \""+this.GetProperty(property)+"\""          :
      property==SIGNAL_MQL5_PROP_BROKER_SERVER  ?  CMessage::Text(MSG_SIGNAL_MQL5_BROKER_SERVER)+": \""+this.GetProperty(property)+"\""   :
      property==SIGNAL_MQL5_PROP_NAME           ?  CMessage::Text(MSG_SIGNAL_MQL5_NAME)+": \""+this.GetProperty(property)+"\""            :
      property==SIGNAL_MQL5_PROP_CURRENCY       ?  CMessage::Text(MSG_SIGNAL_MQL5_CURRENCY)+": \""+this.GetProperty(property)+"\""        :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Display object properties in the journal                         |
//+------------------------------------------------------------------+
void CMQLSignal::Print(const bool full_prop=false,const bool dash=false)
  {
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_BEG)," (",this.Header(),") =============");
   int begin=0, end=SIGNAL_MQL5_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_SIGNAL_MQL5_PROP_INTEGER prop=(ENUM_SIGNAL_MQL5_PROP_INTEGER)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=SIGNAL_MQL5_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_SIGNAL_MQL5_PROP_DOUBLE prop=(ENUM_SIGNAL_MQL5_PROP_DOUBLE)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=SIGNAL_MQL5_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_SIGNAL_MQL5_PROP_STRING prop=(ENUM_SIGNAL_MQL5_PROP_STRING)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_END)," (",this.Header(),") =============\n");
  }
//+------------------------------------------------------------------+
//| Display a short description of the object in the journal         |
//+------------------------------------------------------------------+
void CMQLSignal::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print
     (
      (dash ? "- " : ""),this.Header(true),
      " \"",this.Name(),"\". ",
      CMessage::Text(MSG_SIGNAL_MQL5_AUTHOR_LOGIN),": ",this.AuthorLogin(),
      ", ID ",this.ID(),
      ", ",CMessage::Text(MSG_SIGNAL_MQL5_TEXT_GAIN),": ",::DoubleToString(this.Gain(),2),
      ", ",CMessage::Text(MSG_SIGNAL_MQL5_TEXT_DRAWDOWN),": ",::DoubleToString(this.MaxDrawdown(),2),
      ", ",CMessage::Text(MSG_LIB_TEXT_REQUEST_PRICE),": ",::DoubleToString(this.Price(),2),
      ", ",CMessage::Text(MSG_SIGNAL_MQL5_TEXT_SUBSCRIBERS),": ",this.Subscribers()
     );
  }
//+------------------------------------------------------------------+
//| Return the object short name                                     |
//+------------------------------------------------------------------+
string CMQLSignal::Header(const bool shrt=false)
  {
   return(shrt ? CMessage::Text(MSG_SIGNAL_MQL5_TEXT_SIGNAL) : CMessage::Text(MSG_SIGNAL_MQL5_TEXT_SIGNAL_MQL5));
  }
//+------------------------------------------------------------------+
//| Return the account type name                                     |
//+------------------------------------------------------------------+
string CMQLSignal::TradeModeDescription(void)
  {
   return
     (
      this.TradeMode()==0 ? CMessage::Text(MSG_ACC_TRADE_MODE_REAL)     :
      this.TradeMode()==1 ? CMessage::Text(MSG_ACC_TRADE_MODE_DEMO)     :
      this.TradeMode()==2 ? CMessage::Text(MSG_ACC_TRADE_MODE_CONTEST)  :
      CMessage::Text(MSG_ACC_TRADE_MODE_UNKNOWN)
     );
  }
//+------------------------------------------------------------------+
//| Look for a signal with a specified ID in the database,           |
//| return the index of a detected signal                            |
//+------------------------------------------------------------------+
int CMQLSignal::IndexBase(const long signal_id)
  {
   int total=::SignalBaseTotal();
   for(int i=0;i<total;i++)
     {
      if(::SignalBaseSelect(i) && ::SignalBaseGetInteger(SIGNAL_BASE_ID)==signal_id)
         return i;
     }
   return WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| Select a signal by its ID in the signal database                 |
//+------------------------------------------------------------------+
bool CMQLSignal::SelectBase(const long signal_id)
  {
   return(this.IndexBase(signal_id)!=WRONG_VALUE);
  }
//+------------------------------------------------------------------+
