//+------------------------------------------------------------------+
//|                                                      DataInd.mqh |
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
#include "..\BaseObj.mqh"
//+------------------------------------------------------------------+
//| Indicator data class                                             |
//+------------------------------------------------------------------+
class CDataInd : public CBaseObj
  {
private:
   int               m_digits;                                    // Digits value of indicator data
   int               m_index;                                     // Bar index
   string            m_period_description;                        // Timeframe string description
   long              m_long_prop[IND_DATA_PROP_INTEGER_TOTAL];    // Integer properties
   double            m_double_prop[IND_DATA_PROP_DOUBLE_TOTAL];   // Real properties
   string            m_string_prop[IND_DATA_PROP_STRING_TOTAL];   // String properties

//--- Return the index of the array the object's (1) double and (2) string properties are located at
   int               IndexProp(ENUM_IND_DATA_PROP_DOUBLE property)   const { return(int)property-IND_DATA_PROP_INTEGER_TOTAL;                            }
   int               IndexProp(ENUM_IND_DATA_PROP_STRING property)   const { return(int)property-IND_DATA_PROP_INTEGER_TOTAL-IND_DATA_PROP_DOUBLE_TOTAL; }

public:
//--- Set (1) integer, (2) real and (3) string properties of indicator data
   void              SetProperty(ENUM_IND_DATA_PROP_INTEGER property,long value) { this.m_long_prop[property]=value;                               }
   void              SetProperty(ENUM_IND_DATA_PROP_DOUBLE property,double value){ this.m_double_prop[this.IndexProp(property)]=value;             }
   void              SetProperty(ENUM_IND_DATA_PROP_STRING property,string value){ this.m_string_prop[this.IndexProp(property)]=value;             }
//--- Return (1) integer, (2) real and (3) string property of indicator data from the properties array
   long              GetProperty(ENUM_IND_DATA_PROP_INTEGER property)   const { return this.m_long_prop[property];                                 }
   double            GetProperty(ENUM_IND_DATA_PROP_DOUBLE property)    const { return this.m_double_prop[this.IndexProp(property)];               }
   string            GetProperty(ENUM_IND_DATA_PROP_STRING property)    const { return this.m_string_prop[this.IndexProp(property)];               }

//--- Return the flag of the object supporting this property
   virtual bool      SupportProperty(ENUM_IND_DATA_PROP_INTEGER property)     { return true; }
   virtual bool      SupportProperty(ENUM_IND_DATA_PROP_DOUBLE property)      { return true; }
   virtual bool      SupportProperty(ENUM_IND_DATA_PROP_STRING property)      { return true; }
//--- Return itself
   CDataInd         *GetObject(void)                                          { return &this;}
//--- Set (1) symbol, timeframe and time for the object, (2) indicator type, (3) number of buffers, (4) number of data buffer,
//--- (5) ID, (6) handle, (7) data value, (8) name, (9) indicator short name
   void              SetSymbolPeriod(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);
   void              SetIndicatorType(const ENUM_INDICATOR type)              { this.SetProperty(IND_DATA_PROP_INDICATOR_TYPE,type);               }
   void              SetBufferNum(const int num)                              { this.SetProperty(IND_DATA_PROP_IND_BUFFER_NUM,num);                }
   void              SetIndicatorID(const int id)                             { this.SetProperty(IND_DATA_PROP_IND_ID,id);                         }
   void              SetIndicatorHandle(const int handle)                     { this.SetProperty(IND_DATA_PROP_IND_HANDLE,handle);                 }
   void              SetBufferValue(const double value)                       { this.SetProperty(IND_DATA_PROP_BUFFER_VALUE,value);                }
   void              SetIndicatorName(const string name)                      { this.SetProperty(IND_DATA_PROP_IND_NAME,name);                     }
   void              SetIndicatorShortname(const string shortname)            { this.SetProperty(IND_DATA_PROP_IND_SHORTNAME,shortname);           }
   
//--- Compare CDataInd objects with each other by all possible properties (for sorting the lists by a specified property of data object)
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Compare CDataInd objects with each other by all properties (to search equal objects)
   bool              IsEqual(CDataInd* compared_data) const;
//--- Constructors
                     CDataInd(){ this.m_type=OBJECT_DE_TYPE_IND_DATA; }
                     CDataInd(const ENUM_INDICATOR ind_type,
                              const int ind_handle,
                              const int ind_id,
                              const int buffer_num,
                              const string symbol,
                              const ENUM_TIMEFRAMES timeframe,
                              const datetime time,
                              const double value);
                     
//+------------------------------------------------------------------+ 
//| Methods of simplified access to object properties                |
//+------------------------------------------------------------------+
//--- Return (1) bar period start time, (2) timeframe, (3) indicator type,
//--- (4) number of buffers, (5) buffer number, (6) ID, (7) indicator handle
   datetime          Time(void)                                         const { return (datetime)this.GetProperty(IND_DATA_PROP_TIME);                   }
   ENUM_TIMEFRAMES   Timeframe(void)                                    const { return (ENUM_TIMEFRAMES)this.GetProperty(IND_DATA_PROP_PERIOD);          }
   ENUM_INDICATOR    IndicatorType(void)                                const { return (ENUM_INDICATOR)this.GetProperty(IND_DATA_PROP_INDICATOR_TYPE);   }
   int               BufferNum(void)                                    const { return (ENUM_INDICATOR)this.GetProperty(IND_DATA_PROP_IND_BUFFER_NUM);   }
   int               IndicatorID(void)                                  const { return (ENUM_INDICATOR)this.GetProperty(IND_DATA_PROP_IND_ID);           }
   int               IndicatorHandle(void)                              const { return (ENUM_INDICATOR)this.GetProperty(IND_DATA_PROP_IND_HANDLE);       }

//--- Return the value of indicator buffer data
   double            BufferValue(void)                                  const { return this.GetProperty(IND_DATA_PROP_BUFFER_VALUE);                     }
   
//--- Return (1) data symbol, (2) name, (3) indicator short name
   string            Symbol(void)                                       const { return this.GetProperty(IND_DATA_PROP_SYMBOL);                           }
   string            IndicatorName(void)                                const { return this.GetProperty(IND_DATA_PROP_IND_NAME);                         }
   string            IndicatorShortName(void)                           const { return this.GetProperty(IND_DATA_PROP_IND_SHORTNAME);                    }
//--- Return bar index on the specified timeframe the object bar time falls into
   int               Index(const ENUM_TIMEFRAMES timeframe)  const
                       { return ::iBarShift(this.Symbol(),(timeframe==PERIOD_CURRENT ? ::Period() : timeframe),this.Time());                             }
//--- Return Digits set for the object
   int               Digits(void)                                       const { return this.m_digits;                                                    }
//+------------------------------------------------------------------+
//| Description of properties of the object - indicator data         |
//+------------------------------------------------------------------+
//--- Return description of object's (1) integer, (2) real and (3) string property
   string            GetPropertyDescription(ENUM_IND_DATA_PROP_INTEGER property);
   string            GetPropertyDescription(ENUM_IND_DATA_PROP_DOUBLE property);
   string            GetPropertyDescription(ENUM_IND_DATA_PROP_STRING property);

//--- Return indicator type description
   string            IndicatorTypeDescription(void)                     const { return ::IndicatorTypeDescription(this.IndicatorType());                 }
//--- Display the description of the object properties in the journal (full_prop=true - all properties, false - supported ones only - implemented in descendant classes)
   virtual void      Print(const bool full_prop=false,const bool dash=false);
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
//---
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CDataInd::CDataInd(const ENUM_INDICATOR ind_type,
                   const int ind_handle,
                   const int ind_id,
                   const int buffer_num,
                   const string symbol,
                   const ENUM_TIMEFRAMES timeframe,
                   const datetime time,
                   const double value)
  {
   this.m_type=OBJECT_DE_TYPE_IND_DATA; 
   this.m_digits=(int)::SymbolInfoInteger(symbol,SYMBOL_DIGITS)+1;
   this.m_period_description=TimeframeDescription(timeframe);
   this.SetSymbolPeriod(symbol,timeframe,time);
   this.SetIndicatorType(ind_type);
   this.SetIndicatorHandle(ind_handle);
   this.SetBufferNum(buffer_num);
   this.SetIndicatorID(ind_id);
   this.SetBufferValue(value);
  }
//+--------------------------------------------------------------------+
//| Compare CDataInd objects with each other by the specified property |
//+--------------------------------------------------------------------+
int CDataInd::Compare(const CObject *node,const int mode=0) const
  {
   const CDataInd *obj_compared=node;
//--- compare integer properties of two objects
   if(mode<IND_DATA_PROP_INTEGER_TOTAL)
     {
      long value_compared=obj_compared.GetProperty((ENUM_IND_DATA_PROP_INTEGER)mode);
      long value_current=this.GetProperty((ENUM_IND_DATA_PROP_INTEGER)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare real properties of two objects
   else if(mode<IND_DATA_PROP_DOUBLE_TOTAL+IND_DATA_PROP_INTEGER_TOTAL)
     {
      double value_compared=obj_compared.GetProperty((ENUM_IND_DATA_PROP_DOUBLE)mode);
      double value_current=this.GetProperty((ENUM_IND_DATA_PROP_DOUBLE)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare string properties of two objects
   else if(mode<IND_DATA_PROP_DOUBLE_TOTAL+IND_DATA_PROP_INTEGER_TOTAL+IND_DATA_PROP_STRING_TOTAL)
     {
      string value_compared=obj_compared.GetProperty((ENUM_IND_DATA_PROP_STRING)mode);
      string value_current=this.GetProperty((ENUM_IND_DATA_PROP_STRING)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//| Compare CDataInd objects with each other by all properties       |
//+------------------------------------------------------------------+
bool CDataInd::IsEqual(CDataInd *compared_obj) const
  {
   int begin=0, end=BAR_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_IND_DATA_PROP_INTEGER prop=(ENUM_IND_DATA_PROP_INTEGER)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=IND_DATA_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_IND_DATA_PROP_DOUBLE prop=(ENUM_IND_DATA_PROP_DOUBLE)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=IND_DATA_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_IND_DATA_PROP_STRING prop=(ENUM_IND_DATA_PROP_STRING)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Set symbol, timeframe and object bar start time                  |
//+------------------------------------------------------------------+
void CDataInd::SetSymbolPeriod(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   this.SetProperty(IND_DATA_PROP_TIME,time);
   this.SetProperty(IND_DATA_PROP_SYMBOL,symbol);
   this.SetProperty(IND_DATA_PROP_PERIOD,timeframe);
  }
//+------------------------------------------------------------------+
//| Display object properties in the journal                         |
//+------------------------------------------------------------------+
void CDataInd::Print(const bool full_prop=false,const bool dash=false)
  {
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_BEG)," (",this.IndicatorShortName(),") =============");
   int begin=0, end=IND_DATA_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_IND_DATA_PROP_INTEGER prop=(ENUM_IND_DATA_PROP_INTEGER)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=IND_DATA_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_IND_DATA_PROP_DOUBLE prop=(ENUM_IND_DATA_PROP_DOUBLE)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=IND_DATA_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_IND_DATA_PROP_STRING prop=(ENUM_IND_DATA_PROP_STRING)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_END)," (",this.IndicatorShortName(),") =============\n");
  }
//+------------------------------------------------------------------+
//| Display a short description of the object in the journal         |
//+------------------------------------------------------------------+
void CDataInd::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print
     (
      this.IndicatorShortName(),
      " [",CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_BUFFER)," ",this.BufferNum(),
      ", ",CMessage::Text(MSG_SYM_STATUS_INDEX)," ",this.Index(this.Timeframe()),"]"
     );
  }
//+------------------------------------------------------------------+
//| Return description of object's integer property                  |
//+------------------------------------------------------------------+
string CDataInd::GetPropertyDescription(ENUM_IND_DATA_PROP_INTEGER property)
  {
   return
     (
      property==IND_DATA_PROP_TIME           ?  CMessage::Text(MSG_LIB_TEXT_BAR_TIME)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::TimeToString(this.GetProperty(property),TIME_DATE|TIME_MINUTES|TIME_SECONDS)
         )  :
      property==IND_DATA_PROP_PERIOD         ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_TIMEFRAME)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.m_period_description
         )  :
      property==IND_DATA_PROP_INDICATOR_TYPE ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_TYPE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.IndicatorTypeDescription()
         )  :
      property==IND_DATA_PROP_IND_BUFFER_NUM ?  CMessage::Text(MSG_LIB_TEXT_IND_DATA_IND_BUFFER_NUM)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==IND_DATA_PROP_IND_ID         ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_ID)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==IND_DATA_PROP_IND_HANDLE     ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_HANDLE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of object's real property                     |
//+------------------------------------------------------------------+
string CDataInd::GetPropertyDescription(ENUM_IND_DATA_PROP_DOUBLE property)
  {
   int dg=(this.m_digits>0 ? this.m_digits : 1);
   return
     (
      property==IND_DATA_PROP_BUFFER_VALUE   ?  CMessage::Text(MSG_LIB_TEXT_IND_DATA_BUFFER_VALUE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of object's string property                   |
//+------------------------------------------------------------------+
string CDataInd::GetPropertyDescription(ENUM_IND_DATA_PROP_STRING property)
  {
   return
     (
      property==IND_DATA_PROP_SYMBOL         ? CMessage::Text(MSG_LIB_TEXT_IND_TEXT_SYMBOL)+": \""+this.GetProperty(property)+"\""     : 
      property==IND_DATA_PROP_IND_NAME       ? CMessage::Text(MSG_LIB_TEXT_IND_TEXT_NAME)+": \""+this.GetProperty(property)+"\""       : 
      property==IND_DATA_PROP_IND_SHORTNAME  ? CMessage::Text(MSG_LIB_TEXT_IND_TEXT_SHORTNAME)+": \""+this.GetProperty(property)+"\""  : 
      ""
     );
  }
//+------------------------------------------------------------------+
