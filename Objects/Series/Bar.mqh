//+------------------------------------------------------------------+
//|                                                          Bar.mqh |
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
#include "..\..\Services\DELib.mqh"
//+------------------------------------------------------------------+
//| Bar class                                                        |
//+------------------------------------------------------------------+
class CBar : public CBaseObj
  {
private:
   MqlDateTime       m_dt_struct;                                 // Date structure
   int               m_digits;                                    // Symbol's digits value
   string            m_period_description;                        // Timeframe string description
   long              m_long_prop[BAR_PROP_INTEGER_TOTAL];         // Integer properties
   double            m_double_prop[BAR_PROP_DOUBLE_TOTAL];        // Real properties
   string            m_string_prop[BAR_PROP_STRING_TOTAL];        // String properties

//--- Return the index of the array the bar's (1) double and (2) string properties are located at
   int               IndexProp(ENUM_BAR_PROP_DOUBLE property)     const { return(int)property-BAR_PROP_INTEGER_TOTAL;                        }
   int               IndexProp(ENUM_BAR_PROP_STRING property)     const { return(int)property-BAR_PROP_INTEGER_TOTAL-BAR_PROP_DOUBLE_TOTAL;  }

//--- Return the bar type (bullish/bearish/zero)
   ENUM_BAR_BODY_TYPE BodyType(void)                              const;
//--- Calculate and return the size of (1) candle, (2) candle body,
//--- (3) upper, (4) lower candle wick,
//--- (5) candle body top and (6) bottom
   double            CandleSize(void)                             const { return(this.High()-this.Low());                                    }
   double            BodySize(void)                               const { return(this.BodyHigh()-this.BodyLow());                            }
   double            ShadowUpSize(void)                           const { return(this.High()-this.BodyHigh());                               }
   double            ShadowDownSize(void)                         const { return(this.BodyLow()-this.Low());                                 }
   double            BodyHigh(void)                               const { return ::fmax(this.Close(),this.Open());                           }
   double            BodyLow(void)                                const { return ::fmin(this.Close(),this.Open());                           }

//--- Return the (1) year and (2) month the bar belongs to, (3) week day,
//--- (4) bar serial number in a year, (5) day, (6) hour, (7) minute,
   int               TimeYear(void)                               const { return this.m_dt_struct.year;                                      }
   int               TimeMonth(void)                              const { return this.m_dt_struct.mon;                                       }
   int               TimeDayOfWeek(void)                          const { return this.m_dt_struct.day_of_week;                               }
   int               TimeDayOfYear(void)                          const { return this.m_dt_struct.day_of_year;                               }
   int               TimeDay(void)                                const { return this.m_dt_struct.day;                                       }
   int               TimeHour(void)                               const { return this.m_dt_struct.hour;                                      }
   int               TimeMinute(void)                             const { return this.m_dt_struct.min;                                       }

public:
//--- Set bar's (1) integer, (2) real and (3) string properties
   void              SetProperty(ENUM_BAR_PROP_INTEGER property,long value) { this.m_long_prop[property]=value;                              }
   void              SetProperty(ENUM_BAR_PROP_DOUBLE property,double value){ this.m_double_prop[this.IndexProp(property)]=value;            }
   void              SetProperty(ENUM_BAR_PROP_STRING property,string value){ this.m_string_prop[this.IndexProp(property)]=value;            }
//--- Return (1) integer, (2) real and (3) string bar properties from the properties array
   long              GetProperty(ENUM_BAR_PROP_INTEGER property)  const { return this.m_long_prop[property];                                 }
   double            GetProperty(ENUM_BAR_PROP_DOUBLE property)   const { return this.m_double_prop[this.IndexProp(property)];               }
   string            GetProperty(ENUM_BAR_PROP_STRING property)   const { return this.m_string_prop[this.IndexProp(property)];               }

//--- Return the flag of the bar supporting the property
   virtual bool      SupportProperty(ENUM_BAR_PROP_INTEGER property)    { return true; }
   virtual bool      SupportProperty(ENUM_BAR_PROP_DOUBLE property)     { return true; }
   virtual bool      SupportProperty(ENUM_BAR_PROP_STRING property)     { return true; }
//--- Return itself
   CBar             *GetObject(void)                                    { return &this;}
//--- Set (1) bar symbol, timeframe and time, (2) bar object parameters
   void              SetSymbolPeriod(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);
   void              SetProperties(const MqlRates &rates);

//--- Compare CBar objects by all possible properties (for sorting the lists by a specified bar object property)
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Compare CBar objects by all properties (to search for equal bar objects)
   bool              IsEqual(CBar* compared_bar) const;
//--- Constructors
                     CBar(){ this.m_type=OBJECT_DE_TYPE_SERIES_BAR; }
                     CBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time,const string source);
                     CBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const MqlRates &rates);
                     
//+------------------------------------------------------------------+ 
//| Methods of simplified access to bar object properties            |
//+------------------------------------------------------------------+
//--- Return the (1) type, (2) period, (3) spread, (4) tick, (5) exchange volume,
//--- (6) bar period start time, (7) year, (8) month the bar belongs to
//--- (9) week number since the year start, (10) week number since the month start
//--- (11) day, (12) hour, (13) minute
   ENUM_BAR_BODY_TYPE TypeBody(void)                                    const { return (ENUM_BAR_BODY_TYPE)this.GetProperty(BAR_PROP_TYPE);  }
   ENUM_TIMEFRAMES   Timeframe(void)                                    const { return (ENUM_TIMEFRAMES)this.GetProperty(BAR_PROP_PERIOD);   }
   int               Spread(void)                                       const { return (int)this.GetProperty(BAR_PROP_SPREAD);               }
   long              VolumeTick(void)                                   const { return this.GetProperty(BAR_PROP_VOLUME_TICK);               }
   long              VolumeReal(void)                                   const { return this.GetProperty(BAR_PROP_VOLUME_REAL);               }
   datetime          Time(void)                                         const { return (datetime)this.GetProperty(BAR_PROP_TIME);            }
   long              Year(void)                                         const { return this.GetProperty(BAR_PROP_TIME_YEAR);                 }
   long              Month(void)                                        const { return this.GetProperty(BAR_PROP_TIME_MONTH);                }
   long              DayOfWeek(void)                                    const { return this.GetProperty(BAR_PROP_TIME_DAY_OF_WEEK);          }
   long              DayOfYear(void)                                    const { return this.GetProperty(BAR_PROP_TIME_DAY_OF_YEAR);          }
   long              Day(void)                                          const { return this.GetProperty(BAR_PROP_TIME_DAY);                  }
   long              Hour(void)                                         const { return this.GetProperty(BAR_PROP_TIME_HOUR);                 }
   long              Minute(void)                                       const { return this.GetProperty(BAR_PROP_TIME_MINUTE);               }

//--- Return bar's (1) Open, (2) High, (3) Low, (4) Close price,
//--- size of the (5) candle, (6) body, (7) candle top, (8) bottom,
//--- size of the (9) candle upper, (10) lower wick
   double            Open(void)                                         const { return this.GetProperty(BAR_PROP_OPEN);                      }
   double            High(void)                                         const { return this.GetProperty(BAR_PROP_HIGH);                      }
   double            Low(void)                                          const { return this.GetProperty(BAR_PROP_LOW);                       }
   double            Close(void)                                        const { return this.GetProperty(BAR_PROP_CLOSE);                     }
   double            Size(void)                                         const { return this.GetProperty(BAR_PROP_CANDLE_SIZE);               }
   double            SizeBody(void)                                     const { return this.GetProperty(BAR_PROP_CANDLE_SIZE_BODY);          }
   double            TopBody(void)                                      const { return this.GetProperty(BAR_PROP_CANDLE_BODY_TOP);           }
   double            BottomBody(void)                                   const { return this.GetProperty(BAR_PROP_CANDLE_BODY_BOTTOM);        }
   double            SizeShadowUp(void)                                 const { return this.GetProperty(BAR_PROP_CANDLE_SIZE_SHADOW_UP);     }
   double            SizeShadowDown(void)                               const { return this.GetProperty(BAR_PROP_CANDLE_SIZE_SHADOW_DOWN);   }
   
//--- Return bar symbol
   string            Symbol(void)                                       const { return this.GetProperty(BAR_PROP_SYMBOL);                    }
//--- Return bar index on the specified timeframe the bar time falls into
   int               Index(const ENUM_TIMEFRAMES timeframe)  const
                       { return ::iBarShift(this.Symbol(),(timeframe==PERIOD_CURRENT ? ::Period() : timeframe),this.Time());                 }  
//+------------------------------------------------------------------+
//| Descriptions of bar object properties                            |
//+------------------------------------------------------------------+
//--- Get description of a bar's (1) integer, (2) real and (3) string properties
   string            GetPropertyDescription(ENUM_BAR_PROP_INTEGER property);
   string            GetPropertyDescription(ENUM_BAR_PROP_DOUBLE property);
   string            GetPropertyDescription(ENUM_BAR_PROP_STRING property);

//--- Return the bar type description
   string            BodyTypeDescription(void)  const;
//--- Display the description of the object properties in the journal (full_prop=true - all properties, false - supported ones only - implemented in descendant classes)
   virtual void      Print(const bool full_prop=false,const bool dash=false);
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
//--- Return the (1) short name and (2) description of bar object parameters
   virtual string    Header(void);
   string            ParameterDescription(void);
   
//---
  };
//+------------------------------------------------------------------+
//| Constructor 1                                                    |
//+------------------------------------------------------------------+
CBar::CBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time,const string source)
  {
   this.m_type=OBJECT_DE_TYPE_SERIES_BAR; 
   MqlRates rates_array[1];
   this.SetSymbolPeriod(symbol,timeframe,time);
   ::ResetLastError();
//--- If failed to get the requested data by time and write bar data to the MqlRates array,
//--- display an error message, create and fill the structure with zeros, and write it to the rates_array array
   if(::CopyRates(symbol,timeframe,time,1,rates_array)<1)
     {
      int err_code=::GetLastError();
      ::Print
        (
         DFUN,"(1)-> ",source,symbol," ",TimeframeDescription(timeframe)," ",::TimeToString(time),": ",
         CMessage::Text(MSG_LIB_TEXT_BAR_FAILED_GET_BAR_DATA),". ",
         CMessage::Text(MSG_LIB_SYS_ERROR),"> ",CMessage::Text(err_code)," ",
         CMessage::Retcode(err_code)
        );
      //--- Set the requested bar time to the structure with zero fields
      MqlRates err={0};
      err.time=time;
      rates_array[0]=err;
     }
   ::ResetLastError();
//--- If failed to set time to the time structure, display the error message
   if(!::TimeToStruct(rates_array[0].time,this.m_dt_struct))
     {
      int err_code=::GetLastError();
      ::Print
        (
         DFUN,"(1) ",symbol," ",TimeframeDescription(timeframe)," ",::TimeToString(time),": ",
         CMessage::Text(MSG_LIB_TEXT_BAR_FAILED_DT_STRUCT_WRITE),". ",
         CMessage::Text(MSG_LIB_SYS_ERROR),"> ",CMessage::Text(err_code)," ",
         CMessage::Retcode(err_code)
        );
     }
//--- Set the bar properties
   this.SetProperties(rates_array[0]);
  }
//+------------------------------------------------------------------+
//| Constructor 2                                                    |
//+------------------------------------------------------------------+
CBar::CBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const MqlRates &rates)
  {
   this.m_type=OBJECT_DE_TYPE_SERIES_BAR; 
   this.SetSymbolPeriod(symbol,timeframe,rates.time);
   ::ResetLastError();
//--- If failed to set time to the time structure, display the error message,
//--- create and fill the structure with zeros, set the bar properties from this structure and exit
   if(!::TimeToStruct(rates.time,this.m_dt_struct))
     {
      int err_code=::GetLastError();
      ::Print
        (
         DFUN,"(2) ",symbol," ",TimeframeDescription(timeframe)," ",::TimeToString(rates.time),": ",
         CMessage::Text(MSG_LIB_TEXT_BAR_FAILED_DT_STRUCT_WRITE),". ",
         CMessage::Text(MSG_LIB_SYS_ERROR),"> ",CMessage::Text(err_code)," ",
         CMessage::Retcode(err_code)
        );
      //--- Set the requested bar time to the structure with zero fields
      MqlRates err={0};
      err.time=rates.time;
      this.SetProperties(err);
      return;
     }
//--- Set the bar properties
   this.SetProperties(rates);
  }
//+------------------------------------------------------------------+
//| Compare CBar objects with each other by the specified property   |
//+------------------------------------------------------------------+
int CBar::Compare(const CObject *node,const int mode=0) const
  {
   const CBar *bar_compared=node;
//--- compare integer properties of two bars
   if(mode<BAR_PROP_INTEGER_TOTAL)
     {
      long value_compared=bar_compared.GetProperty((ENUM_BAR_PROP_INTEGER)mode);
      long value_current=this.GetProperty((ENUM_BAR_PROP_INTEGER)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare real properties of two bars
   else if(mode<BAR_PROP_DOUBLE_TOTAL+BAR_PROP_INTEGER_TOTAL)
     {
      double value_compared=bar_compared.GetProperty((ENUM_BAR_PROP_DOUBLE)mode);
      double value_current=this.GetProperty((ENUM_BAR_PROP_DOUBLE)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare string properties of two bars
   else if(mode<BAR_PROP_DOUBLE_TOTAL+BAR_PROP_INTEGER_TOTAL+BAR_PROP_STRING_TOTAL)
     {
      string value_compared=bar_compared.GetProperty((ENUM_BAR_PROP_STRING)mode);
      string value_current=this.GetProperty((ENUM_BAR_PROP_STRING)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//| Compare CBar objects by all properties                           |
//+------------------------------------------------------------------+
bool CBar::IsEqual(CBar *compared_bar) const
  {
   int begin=0, end=BAR_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BAR_PROP_INTEGER prop=(ENUM_BAR_PROP_INTEGER)i;
      if(this.GetProperty(prop)!=compared_bar.GetProperty(prop)) return false; 
     }
   begin=end; end+=BAR_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BAR_PROP_DOUBLE prop=(ENUM_BAR_PROP_DOUBLE)i;
      if(this.GetProperty(prop)!=compared_bar.GetProperty(prop)) return false; 
     }
   begin=end; end+=BAR_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BAR_PROP_STRING prop=(ENUM_BAR_PROP_STRING)i;
      if(this.GetProperty(prop)!=compared_bar.GetProperty(prop)) return false; 
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Set bar symbol, timeframe and time                               |
//+------------------------------------------------------------------+
void CBar::SetSymbolPeriod(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   this.SetProperty(BAR_PROP_TIME,time);
   this.SetProperty(BAR_PROP_SYMBOL,symbol);
   this.SetProperty(BAR_PROP_PERIOD,timeframe);
   this.m_digits=(int)::SymbolInfoInteger(symbol,SYMBOL_DIGITS);
   this.m_period_description=TimeframeDescription(timeframe);
  }
//+------------------------------------------------------------------+
//| Set bar object parameters                                        |
//+------------------------------------------------------------------+
void CBar::SetProperties(const MqlRates &rates)
  {
   this.SetProperty(BAR_PROP_SPREAD,rates.spread);
   this.SetProperty(BAR_PROP_VOLUME_TICK,rates.tick_volume);
   this.SetProperty(BAR_PROP_VOLUME_REAL,rates.real_volume);
   this.SetProperty(BAR_PROP_TIME,rates.time);
   this.SetProperty(BAR_PROP_TIME_YEAR,this.TimeYear());
   this.SetProperty(BAR_PROP_TIME_MONTH,this.TimeMonth());
   this.SetProperty(BAR_PROP_TIME_DAY_OF_YEAR,this.TimeDayOfYear());
   this.SetProperty(BAR_PROP_TIME_DAY_OF_WEEK,this.TimeDayOfWeek());
   this.SetProperty(BAR_PROP_TIME_DAY,this.TimeDay());
   this.SetProperty(BAR_PROP_TIME_HOUR,this.TimeHour());
   this.SetProperty(BAR_PROP_TIME_MINUTE,this.TimeMinute());
//---
   this.SetProperty(BAR_PROP_OPEN,rates.open);
   this.SetProperty(BAR_PROP_HIGH,rates.high);
   this.SetProperty(BAR_PROP_LOW,rates.low);
   this.SetProperty(BAR_PROP_CLOSE,rates.close);
   this.SetProperty(BAR_PROP_CANDLE_SIZE,this.CandleSize());
   this.SetProperty(BAR_PROP_CANDLE_SIZE_BODY,this.BodySize());
   this.SetProperty(BAR_PROP_CANDLE_BODY_TOP,this.BodyHigh());
   this.SetProperty(BAR_PROP_CANDLE_BODY_BOTTOM,this.BodyLow());
   this.SetProperty(BAR_PROP_CANDLE_SIZE_SHADOW_UP,this.ShadowUpSize());
   this.SetProperty(BAR_PROP_CANDLE_SIZE_SHADOW_DOWN,this.ShadowDownSize());
//---
   this.SetProperty(BAR_PROP_TYPE,this.BodyType());
//--- Set the object type to the object of the graphical object management class
   this.m_graph_elm.SetTypeNode(this.m_type);
  }
//+------------------------------------------------------------------+
//| Display bar properties in the journal                            |
//+------------------------------------------------------------------+
void CBar::Print(const bool full_prop=false,const bool dash=false)
  {
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_BEG)," (",this.Header(),") =============");
   int begin=0, end=BAR_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BAR_PROP_INTEGER prop=(ENUM_BAR_PROP_INTEGER)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=BAR_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BAR_PROP_DOUBLE prop=(ENUM_BAR_PROP_DOUBLE)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=BAR_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BAR_PROP_STRING prop=(ENUM_BAR_PROP_STRING)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_END)," (",this.Header(),") =============\n");
  }
//+------------------------------------------------------------------+
//| Return the description of the bar object parameters              |
//+------------------------------------------------------------------+
string CBar::ParameterDescription(void)
  {
   int dg=(this.m_digits>0 ? this.m_digits : 1);
   return
     (
      ::TimeToString(this.Time(),TIME_DATE|TIME_MINUTES|TIME_SECONDS)+", "+
      "O: "+::DoubleToString(this.Open(),dg)+", "+
      "H: "+::DoubleToString(this.High(),dg)+", "+
      "L: "+::DoubleToString(this.Low(),dg)+", "+
      "C: "+::DoubleToString(this.Close(),dg)+", "+
      "V: "+(string)this.VolumeTick()+", "+
      (this.VolumeReal()>0 ? "R: "+(string)this.VolumeReal()+", " : "")+
      this.BodyTypeDescription()
     );
  }
//+------------------------------------------------------------------+
//| Display a short bar description in the journal                   |
//+------------------------------------------------------------------+
void CBar::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print(this.Header(),": ",this.ParameterDescription());
  }
//+------------------------------------------------------------------+
//| Return the bar object short name                                 |
//+------------------------------------------------------------------+
string CBar::Header(void)
  {
   return
     (
      CMessage::Text(MSG_LIB_TEXT_BAR)+" \""+this.GetProperty(BAR_PROP_SYMBOL)+"\" "+
      TimeframeDescription((ENUM_TIMEFRAMES)this.GetProperty(BAR_PROP_PERIOD))+"["+(string)this.Index(this.Timeframe())+"]"
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the bar integer property               |
//+------------------------------------------------------------------+
string CBar::GetPropertyDescription(ENUM_BAR_PROP_INTEGER property)
  {
   return
     (
      property==BAR_PROP_TIME                ?  CMessage::Text(MSG_LIB_TEXT_BAR_TIME)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::TimeToString(this.GetProperty(property),TIME_DATE|TIME_MINUTES|TIME_SECONDS)
         )  :
      property==BAR_PROP_TYPE                ?  CMessage::Text(MSG_ORD_TYPE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.BodyTypeDescription()
         )  :
      property==BAR_PROP_PERIOD              ?  CMessage::Text(MSG_LIB_TEXT_BAR_PERIOD)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.m_period_description
         )  :
      property==BAR_PROP_SPREAD              ?  CMessage::Text(MSG_LIB_TEXT_BAR_SPREAD)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BAR_PROP_VOLUME_TICK         ?  CMessage::Text(MSG_LIB_TEXT_BAR_VOLUME_TICK)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BAR_PROP_VOLUME_REAL         ?  CMessage::Text(MSG_LIB_TEXT_BAR_VOLUME_REAL)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BAR_PROP_TIME_YEAR           ?  CMessage::Text(MSG_LIB_TEXT_BAR_TIME_YEAR)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.Year()
         )  :
      property==BAR_PROP_TIME_MONTH          ?  CMessage::Text(MSG_LIB_TEXT_BAR_TIME_MONTH)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+MonthDescription((int)this.Month())
         )  :
      property==BAR_PROP_TIME_DAY_OF_YEAR    ?  CMessage::Text(MSG_LIB_TEXT_BAR_TIME_DAY_OF_YEAR)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)::IntegerToString(this.DayOfYear(),3,'0')
         )  :
      property==BAR_PROP_TIME_DAY_OF_WEEK    ?  CMessage::Text(MSG_LIB_TEXT_BAR_TIME_DAY_OF_WEEK)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+DayOfWeekDescription((ENUM_DAY_OF_WEEK)this.DayOfWeek())
         )  :
      property==BAR_PROP_TIME_DAY            ?  CMessage::Text(MSG_LIB_TEXT_BAR_TIME_DAY)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)::IntegerToString(this.Day(),2,'0')
         )  :
      property==BAR_PROP_TIME_HOUR           ?  CMessage::Text(MSG_LIB_TEXT_BAR_TIME_HOUR)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)::IntegerToString(this.Hour(),2,'0')
         )  :
      property==BAR_PROP_TIME_MINUTE         ?  CMessage::Text(MSG_LIB_TEXT_BAR_TIME_MINUTE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)::IntegerToString(this.Minute(),2,'0')
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the bar's real property                |
//+------------------------------------------------------------------+
string CBar::GetPropertyDescription(ENUM_BAR_PROP_DOUBLE property)
  {
   int dg=(this.m_digits>0 ? this.m_digits : 1);
   return
     (
      property==BAR_PROP_OPEN                ?  CMessage::Text(MSG_ORD_PRICE_OPEN)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==BAR_PROP_HIGH                ?  CMessage::Text(MSG_LIB_TEXT_BAR_HIGH)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==BAR_PROP_LOW                 ?  CMessage::Text(MSG_LIB_TEXT_BAR_LOW)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==BAR_PROP_CLOSE               ?  CMessage::Text(MSG_ORD_PRICE_CLOSE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==BAR_PROP_CANDLE_SIZE         ?  CMessage::Text(MSG_LIB_TEXT_BAR_CANDLE_SIZE)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==BAR_PROP_CANDLE_SIZE_BODY    ?  CMessage::Text(MSG_LIB_TEXT_BAR_CANDLE_SIZE_BODY)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==BAR_PROP_CANDLE_SIZE_SHADOW_UP  ?  CMessage::Text(MSG_LIB_TEXT_BAR_CANDLE_SIZE_SHADOW_UP)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==BAR_PROP_CANDLE_SIZE_SHADOW_DOWN   ?  CMessage::Text(MSG_LIB_TEXT_BAR_CANDLE_SIZE_SHADOW_DOWN)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==BAR_PROP_CANDLE_BODY_TOP     ?  CMessage::Text(MSG_LIB_TEXT_BAR_CANDLE_BODY_TOP)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      property==BAR_PROP_CANDLE_BODY_BOTTOM  ?  CMessage::Text(MSG_LIB_TEXT_BAR_CANDLE_BODY_BOTTOM)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.GetProperty(property),dg)
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the bar string property                |
//+------------------------------------------------------------------+
string CBar::GetPropertyDescription(ENUM_BAR_PROP_STRING property)
  {
   return(property==BAR_PROP_SYMBOL ? CMessage::Text(MSG_LIB_PROP_SYMBOL)+": \""+this.GetProperty(property)+"\"" : "");
  }
//+------------------------------------------------------------------+
//| Return the bar type (bullish/bearish/zero)                       |
//+------------------------------------------------------------------+
ENUM_BAR_BODY_TYPE CBar::BodyType(void) const
  {
   return
     (
      this.Close()>this.Open() ? BAR_BODY_TYPE_BULLISH : 
      this.Close()<this.Open() ? BAR_BODY_TYPE_BEARISH : 
      (this.ShadowUpSize()+this.ShadowDownSize()==0 ? BAR_BODY_TYPE_NULL : BAR_BODY_TYPE_CANDLE_ZERO_BODY)
     );
  }
//+------------------------------------------------------------------+
//| Return the bar type description                                  |
//+------------------------------------------------------------------+
string CBar::BodyTypeDescription(void) const
  {
   return
     (
      this.BodyType()==BAR_BODY_TYPE_BULLISH          ? CMessage::Text(MSG_LIB_TEXT_BAR_TYPE_BULLISH)          : 
      this.BodyType()==BAR_BODY_TYPE_BEARISH          ? CMessage::Text(MSG_LIB_TEXT_BAR_TYPE_BEARISH)          : 
      this.BodyType()==BAR_BODY_TYPE_CANDLE_ZERO_BODY ? CMessage::Text(MSG_LIB_TEXT_BAR_TYPE_CANDLE_ZERO_BODY) :
      CMessage::Text(MSG_LIB_TEXT_BAR_TYPE_NULL)
     );
  }
//+------------------------------------------------------------------+
