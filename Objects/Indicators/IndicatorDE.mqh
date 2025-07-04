//+------------------------------------------------------------------+
//|                                                  IndicatorDE.mqh |
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
#include "..\..\Objects\BaseObj.mqh"
#include "..\..\Objects\Indicators\SeriesDataInd.mqh"
//+------------------------------------------------------------------+
//| Abstract indicator class                                         |
//+------------------------------------------------------------------+
class CIndicatorDE : public CBaseObj
  {
protected:
   MqlParam          m_mql_param[];                                              // Array of indicator parameters
   CSeriesDataInd    m_series_data;                                              // Timeseries object of indicator buffer data
private:
   long              m_long_prop[INDICATOR_PROP_INTEGER_TOTAL];                  // Integer properties
   double            m_double_prop[INDICATOR_PROP_DOUBLE_TOTAL];                 // Real properties
   string            m_string_prop[INDICATOR_PROP_STRING_TOTAL];                 // String properties
   string            m_ind_type_description;                                     // Indicator type description
   int               m_buffers_total;                                            // Total number of indicator buffers
   
//--- Return the index of the array the buffer's (1) double and (2) string properties are actually located at
   int               IndexProp(ENUM_INDICATOR_PROP_DOUBLE property)        const { return(int)property-INDICATOR_PROP_INTEGER_TOTAL;                           }
   int               IndexProp(ENUM_INDICATOR_PROP_STRING property)        const { return(int)property-INDICATOR_PROP_INTEGER_TOTAL-INDICATOR_PROP_DOUBLE_TOTAL;}
   
//--- Comare (1) structures MqlParam, (2) array of structures MqlParam between each other
   bool              IsEqualMqlParams(MqlParam &struct1,MqlParam &struct2) const;
   bool              IsEqualMqlParamArrays(MqlParam &compared_struct[])    const;

protected:
//--- Protected parametric constructor
                     CIndicatorDE(ENUM_INDICATOR ind_type,
                                  string symbol,
                                  ENUM_TIMEFRAMES timeframe,
                                  ENUM_INDICATOR_STATUS status,
                                  ENUM_INDICATOR_GROUP group,
                                  string name,
                                  string shortname,
                                  MqlParam &mql_params[]);
public:  
//--- Default constructor
                     CIndicatorDE(void){ this.m_type=OBJECT_DE_TYPE_INDICATOR; }
//--- Destructor
                    ~CIndicatorDE(void);
                     
//--- Set buffer's (1) integer, (2) real and (3) string property
   void              SetProperty(ENUM_INDICATOR_PROP_INTEGER property,long value)   { this.m_long_prop[property]=value;                                        }
   void              SetProperty(ENUM_INDICATOR_PROP_DOUBLE property,double value)  { this.m_double_prop[this.IndexProp(property)]=value;                      }
   void              SetProperty(ENUM_INDICATOR_PROP_STRING property,string value)  { this.m_string_prop[this.IndexProp(property)]=value;                      }
//--- Return buffer’s (1) integer, (2) real and (3) string property from the properties array
   long              GetProperty(ENUM_INDICATOR_PROP_INTEGER property)        const { return this.m_long_prop[property];                                       }
   double            GetProperty(ENUM_INDICATOR_PROP_DOUBLE property)         const { return this.m_double_prop[this.IndexProp(property)];                     }
   string            GetProperty(ENUM_INDICATOR_PROP_STRING property)         const { return this.m_string_prop[this.IndexProp(property)];                     }
//--- Return description of buffer's (1) integer, (2) real and (3) string property
   string            GetPropertyDescription(ENUM_INDICATOR_PROP_INTEGER property);
   string            GetPropertyDescription(ENUM_INDICATOR_PROP_DOUBLE property);
   string            GetPropertyDescription(ENUM_INDICATOR_PROP_STRING property);
//--- Return the flag of the buffer supporting the property
   virtual bool      SupportProperty(ENUM_INDICATOR_PROP_INTEGER property)          { return true;       }
   virtual bool      SupportProperty(ENUM_INDICATOR_PROP_DOUBLE property)           { return true;       }
   virtual bool      SupportProperty(ENUM_INDICATOR_PROP_STRING property)           { return true;       }

//--- Compare CIndicatorDE objects by all possible properties (for sorting the lists by a specified indicator object property)
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Compare CIndicatorDE objects by all properties (to search equal indicator objects)
   bool              IsEqual(CIndicatorDE* compared_obj) const;
                     
//--- Set indicator’s (1) group, (2) empty value of buffers, (3) name, (4) short name, (5) ID
   void              SetGroup(const ENUM_INDICATOR_GROUP group)      { this.SetProperty(INDICATOR_PROP_GROUP,group);                         }
   void              SetEmptyValue(const double value)               { this.SetProperty(INDICATOR_PROP_EMPTY_VALUE,value);                   }
   void              SetName(const string name)                      { this.SetProperty(INDICATOR_PROP_NAME,name);                           }
   void              SetShortName(const string shortname)            { this.SetProperty(INDICATOR_PROP_SHORTNAME,shortname);                 }
   void              SetID(const int id)                             { this.SetProperty(INDICATOR_PROP_ID,id);                               }
   void              SetBuffersTotal(const int buffers_total)        { this.m_buffers_total=buffers_total;                                   }
   
//--- Return indicator’s (1) status, (2) group, (3) timeframe, (4) type, (5) handle, (6) ID,
//--- (7) empty value of buffers, (8) name, (9) short name, (10) symbol, (11) number of buffers
   ENUM_INDICATOR_STATUS Status(void)                          const { return (ENUM_INDICATOR_STATUS)this.GetProperty(INDICATOR_PROP_STATUS);}
   ENUM_INDICATOR_GROUP  Group(void)                           const { return (ENUM_INDICATOR_GROUP)this.GetProperty(INDICATOR_PROP_GROUP);  }
   ENUM_TIMEFRAMES   Timeframe(void)                           const { return (ENUM_TIMEFRAMES)this.GetProperty(INDICATOR_PROP_TIMEFRAME);   }
   ENUM_INDICATOR    TypeIndicator(void)                       const { return (ENUM_INDICATOR)this.GetProperty(INDICATOR_PROP_TYPE);         }
   int               Handle(void)                              const { return (int)this.GetProperty(INDICATOR_PROP_HANDLE);                  }
   int               ID(void)                                  const { return (int)this.GetProperty(INDICATOR_PROP_ID);                      }
   double            EmptyValue(void)                          const { return this.GetProperty(INDICATOR_PROP_EMPTY_VALUE);                  }
   string            Name(void)                                const { return this.GetProperty(INDICATOR_PROP_NAME);                         }
   string            ShortName(void)                           const { return this.GetProperty(INDICATOR_PROP_SHORTNAME);                    }
   string            Symbol(void)                              const { return this.GetProperty(INDICATOR_PROP_SYMBOL);                       }
   int               BuffersTotal(void)                        const { return this.m_buffers_total;                                          }
   
//--- Return description of (1) type, (2) status, (3) group, (4) timeframe, (5) empty value of indicator, (6) parameter of m_mql_param array
   string            GetTypeDescription(void)                  const { return m_ind_type_description;                                        }
   string            GetStatusDescription(void)                const;
   string            GetGroupDescription(void)                 const;
   string            GetTimeframeDescription(void)             const;
   string            GetEmptyValueDescription(void)            const;
   string            GetMqlParamDescription(const int index)   const;

//--- Return indicator data timeseries
   CSeriesDataInd   *GetSeriesData(void)                             { return &this.m_series_data;  }
   
//--- Display the description of indicator object properties in the journal (full_prop=true - all properties, false - supported ones only)
   virtual void      Print(const bool full_prop=false,const bool dash=false);
//--- Display (1) a short description, (2) description of indicator object parameters in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
   virtual void      PrintParameters(void) {;}

//--- Return data of specified buffer from specified bar (1) by index, (2) by bar time
   double            GetDataBuffer(const int buffer_num,const int index);
   double            GetDataBuffer(const int buffer_num,const datetime time);
  };
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CIndicatorDE::~CIndicatorDE(void)
  {
   ::IndicatorRelease(this.Handle());
  }
//+------------------------------------------------------------------+
//| Closed parametric constructor                                    |
//+------------------------------------------------------------------+
CIndicatorDE::CIndicatorDE(ENUM_INDICATOR ind_type,
                           string symbol,
                           ENUM_TIMEFRAMES timeframe,
                           ENUM_INDICATOR_STATUS status,
                           ENUM_INDICATOR_GROUP group,
                           string name,
                           string shortname,
                           MqlParam &mql_params[])
  {
//--- Set the object type
   this.m_type=OBJECT_DE_TYPE_INDICATOR; 
//--- Write description of indicator type
   this.m_ind_type_description=IndicatorTypeDescription(ind_type);
//--- If parameter array size passed to constructor is more than zero
//--- fill in the array of object parameters with data from the array passed to constructor
   int count=::ArrayResize(this.m_mql_param,::ArraySize(mql_params));
   for(int i=0;i<count;i++)
     {
      this.m_mql_param[i].type         = mql_params[i].type;
      this.m_mql_param[i].double_value = mql_params[i].double_value;
      this.m_mql_param[i].integer_value= mql_params[i].integer_value;
      this.m_mql_param[i].string_value = mql_params[i].string_value;
     }
//--- Create indicator handle
   int handle=::IndicatorCreate(symbol,timeframe,ind_type,count,this.m_mql_param);
   
//--- Save integer properties
   this.m_long_prop[INDICATOR_PROP_STATUS]                     = status;
   this.m_long_prop[INDICATOR_PROP_TYPE]                       = ind_type;
   this.m_long_prop[INDICATOR_PROP_GROUP]                      = group;
   this.m_long_prop[INDICATOR_PROP_TIMEFRAME]                  = timeframe;
   this.m_long_prop[INDICATOR_PROP_HANDLE]                     = handle;
   this.m_long_prop[INDICATOR_PROP_ID]                         = WRONG_VALUE;
   
//--- Save real properties
   this.m_double_prop[this.IndexProp(INDICATOR_PROP_EMPTY_VALUE)]=EMPTY_VALUE; 
//--- Save string properties
   this.m_string_prop[this.IndexProp(INDICATOR_PROP_SYMBOL)]   = (symbol==NULL || symbol=="" ? ::Symbol() : symbol);
   this.m_string_prop[this.IndexProp(INDICATOR_PROP_NAME)]     = name;
   this.m_string_prop[this.IndexProp(INDICATOR_PROP_SHORTNAME)]= shortname;
  }
//+------------------------------------------------------------------+
//| Class methods                                                    |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Compare CIndicatorDE objects with each other                     |
//| by all possible properties                                       |
//+------------------------------------------------------------------+
int CIndicatorDE::Compare(const CObject *node,const int mode=0) const
  {
   const CIndicatorDE *compared_obj=node;
//--- compare integer properties of two indicators
   if(mode<INDICATOR_PROP_INTEGER_TOTAL)
     {
      long value_compared=compared_obj.GetProperty((ENUM_INDICATOR_PROP_INTEGER)mode);
      long value_current=this.GetProperty((ENUM_INDICATOR_PROP_INTEGER)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare real properties of two indicators
   else if(mode<INDICATOR_PROP_INTEGER_TOTAL+INDICATOR_PROP_DOUBLE_TOTAL)
     {
      double value_compared=compared_obj.GetProperty((ENUM_INDICATOR_PROP_DOUBLE)mode);
      double value_current=this.GetProperty((ENUM_INDICATOR_PROP_DOUBLE)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare string properties of two indicators
   else if(mode<INDICATOR_PROP_INTEGER_TOTAL+INDICATOR_PROP_DOUBLE_TOTAL+INDICATOR_PROP_STRING_TOTAL)
     {
      string value_compared=compared_obj.GetProperty((ENUM_INDICATOR_PROP_STRING)mode);
      string value_current=this.GetProperty((ENUM_INDICATOR_PROP_STRING)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//| Compare CIndicatorDE objects with each other by all properties   |
//+------------------------------------------------------------------+
bool CIndicatorDE::IsEqual(CIndicatorDE *compared_obj) const
  {
   if(!IsEqualMqlParamArrays(compared_obj.m_mql_param))
      return false;
   int begin=0, end=INDICATOR_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_INDICATOR_PROP_INTEGER prop=(ENUM_INDICATOR_PROP_INTEGER)i;
      if(prop==INDICATOR_PROP_HANDLE || prop==INDICATOR_PROP_ID) continue;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=INDICATOR_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_INDICATOR_PROP_DOUBLE prop=(ENUM_INDICATOR_PROP_DOUBLE)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=INDICATOR_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_INDICATOR_PROP_STRING prop=(ENUM_INDICATOR_PROP_STRING)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Compare MqlParam structures with each other                      |
//+------------------------------------------------------------------+
bool CIndicatorDE::IsEqualMqlParams(MqlParam &struct1,MqlParam &struct2) const
  {
   bool res=
     (struct1.type!=struct2.type ? false :
      (struct1.type==TYPE_STRING && struct1.string_value==struct2.string_value) ||
      (struct1.type<TYPE_STRING && struct1.type>TYPE_ULONG && struct1.double_value==struct2.double_value) ||
      (struct1.type<TYPE_FLOAT && struct1.integer_value==struct2.integer_value) ? true : false
     );
   return res;
  }
//+------------------------------------------------------------------+
//| Compare array of MqlParam structures with each other             |
//+------------------------------------------------------------------+
bool CIndicatorDE::IsEqualMqlParamArrays(MqlParam &compared_struct[]) const
  {
   int total=::ArraySize(this.m_mql_param);
   int size=::ArraySize(compared_struct);
   if(total!=size || total==0 || size==0)
      return false;
   for(int i=0;i<total;i++)
     {
      if(!this.IsEqualMqlParams(this.m_mql_param[i],compared_struct[i]))
         return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Return description of indicator's integer property               |
//+------------------------------------------------------------------+
string CIndicatorDE::GetPropertyDescription(ENUM_INDICATOR_PROP_INTEGER property)
  {
   return
     (
      property==INDICATOR_PROP_STATUS     ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_STATUS)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetStatusDescription()
         )  :
      property==INDICATOR_PROP_TYPE       ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_TYPE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetTypeDescription()
         )  :
      property==INDICATOR_PROP_GROUP      ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_GROUP)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetGroupDescription()
         )  :
      property==INDICATOR_PROP_ID         ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_ID)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==INDICATOR_PROP_TIMEFRAME  ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_TIMEFRAME)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetTimeframeDescription()
         )  :
      property==INDICATOR_PROP_HANDLE     ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_HANDLE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of indicator's real property                  |
//+------------------------------------------------------------------+
string CIndicatorDE::GetPropertyDescription(ENUM_INDICATOR_PROP_DOUBLE property)
  {
   return
     (
      property==INDICATOR_PROP_EMPTY_VALUE    ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_EMPTY_VALUE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetEmptyValueDescription()
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of indicator's string property                |
//+------------------------------------------------------------------+
string CIndicatorDE::GetPropertyDescription(ENUM_INDICATOR_PROP_STRING property)
  {
   return
     (
      property==INDICATOR_PROP_SYMBOL     ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_SYMBOL)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.Symbol()
         )  :
      property==INDICATOR_PROP_NAME       ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_NAME)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.Name()==NULL || this.Name()=="" ? CMessage::Text(MSG_LIB_PROP_NOT_SET) : "\""+this.Name()+"\"")
         )  :
      property==INDICATOR_PROP_SHORTNAME  ?  CMessage::Text(MSG_LIB_TEXT_IND_TEXT_SHORTNAME)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.ShortName()==NULL || this.ShortName()=="" ? CMessage::Text(MSG_LIB_PROP_NOT_SET) : "\""+this.ShortName()+"\"")
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return indicator status description                              |
//+------------------------------------------------------------------+
string CIndicatorDE::GetStatusDescription(void) const
  {
   return
     (
      this.Status()==INDICATOR_STATUS_CUSTOM    ? CMessage::Text(MSG_LIB_TEXT_IND_TEXT_STATUS_CUSTOM)    :
      this.Status()==INDICATOR_STATUS_STANDARD  ? CMessage::Text(MSG_LIB_TEXT_IND_TEXT_STATUS_STANDARD)  :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return indicator group description                               |
//+------------------------------------------------------------------+
string CIndicatorDE::GetGroupDescription(void) const
  {
   return
     (
      this.Group()==INDICATOR_GROUP_TREND       ? CMessage::Text(MSG_LIB_TEXT_IND_TEXT_GROUP_TREND)      :
      this.Group()==INDICATOR_GROUP_OSCILLATOR  ? CMessage::Text(MSG_LIB_TEXT_IND_TEXT_GROUP_OSCILLATOR) :
      this.Group()==INDICATOR_GROUP_VOLUMES     ? CMessage::Text(MSG_LIB_TEXT_IND_TEXT_GROUP_VOLUMES)    :
      this.Group()==INDICATOR_GROUP_ARROWS      ? CMessage::Text(MSG_LIB_TEXT_IND_TEXT_GROUP_ARROWS)     :
      "Any"
     );
  }
//+------------------------------------------------------------------+
//| Return description of the used timeframe                         |
//+------------------------------------------------------------------+
string CIndicatorDE::GetTimeframeDescription(void) const
  {
   string timeframe=TimeframeDescription(this.Timeframe());
   return(this.Timeframe()==PERIOD_CURRENT ? CMessage::Text(MSG_LIB_TEXT_PERIOD_CURRENT)+" ("+timeframe+")" : timeframe);
  } 
//+------------------------------------------------------------------+
//| Return description of the set empty value                        |
//+------------------------------------------------------------------+
string CIndicatorDE::GetEmptyValueDescription(void) const
  {
   double value=fabs(this.EmptyValue());
   return(value<EMPTY_VALUE ? ::DoubleToString(this.EmptyValue(),(this.EmptyValue()==0 ? 1 : 8)) : (this.EmptyValue()>0 ? "EMPTY_VALUE" : "-EMPTY_VALUE"));
  }
//+------------------------------------------------------------------+
//| Return the description of parameter of m_mql_param array         |
//+------------------------------------------------------------------+
string CIndicatorDE::GetMqlParamDescription(const int index) const
  {
   return "["+(string)index+"] "+MqlParameterDescription(this.m_mql_param[index]);
  }
//+------------------------------------------------------------------+
//| Display indicator properties in the journal                      |
//+------------------------------------------------------------------+
void CIndicatorDE::Print(const bool full_prop=false,const bool dash=false)
  {
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_BEG),": \"",this.GetStatusDescription(),"\" =============");
   int begin=0, end=INDICATOR_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_INDICATOR_PROP_INTEGER prop=(ENUM_INDICATOR_PROP_INTEGER)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=INDICATOR_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_INDICATOR_PROP_DOUBLE prop=(ENUM_INDICATOR_PROP_DOUBLE)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=INDICATOR_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_INDICATOR_PROP_STRING prop=(ENUM_INDICATOR_PROP_STRING)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   this.PrintParameters();
   ::Print("================== ",CMessage::Text(MSG_LIB_PARAMS_LIST_END),": \"",this.GetStatusDescription(),"\" ==================\n");
  }
//+------------------------------------------------------------------+
//| Return data of specified buffer from specified bar by index      |
//+------------------------------------------------------------------+
double CIndicatorDE::GetDataBuffer(const int buffer_num,const int index)
  {
   double array[1]={EMPTY_VALUE};
   int copied=::CopyBuffer(this.Handle(),buffer_num,index,1,array);
   return(copied==1 ? array[0] : this.EmptyValue());
  }
//+------------------------------------------------------------------+
//| Return data of specified buffer from specified bar by time       |
//+------------------------------------------------------------------+
double CIndicatorDE::GetDataBuffer(const int buffer_num,const datetime time)
  {
   double array[1]={EMPTY_VALUE};
   int copied=::CopyBuffer(this.Handle(),buffer_num,time,1,array);
   return(copied==1 ? array[0] : this.EmptyValue());
  }
//+------------------------------------------------------------------+
