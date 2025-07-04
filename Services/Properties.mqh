//+------------------------------------------------------------------+
//|                                                   Properties.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
#property strict    // Necessary for mql4
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "DELib.mqh"
#include "XDimArray.mqh"
//+------------------------------------------------------------------+
//| Object property class                                            |
//+------------------------------------------------------------------+
class CDataPropObj : public CObject
  {
private:
   CArrayObj         m_list;           // list of property objects
   int               m_total_int;      // Number of integer parameters
   int               m_total_dbl;      // Number of real parameters
   int               m_total_str;      // Number of string parameters
   int               m_prop_max_dbl;   // Maximum possible real property value
   int               m_prop_max_str;   // Maximum possible string property value
//--- Return the index of the array the int, double or string property is actually located at
   int               IndexProp(int property) const
                       {
                        //--- If the passed value is less than the number of integer parameters,
                        //--- this is an integer property. Return the value passed to the method
                        if(property<this.m_total_int)
                           return property;
                        //--- Otherwise if the passed value is less than the maximum possible real property value,
                        //--- then this is a real property - return the calculated index in the array of real properties
                        else if(property<this.m_prop_max_dbl)
                           return property-this.m_total_int;
                        //--- Otherwise if the passed value is less than the maximum possible string property value,
                        //--- then this is a string property - return the calculated index in the array of string properties
                        else if(property<this.m_prop_max_str)
                           return property-this.m_total_int-this.m_total_dbl;
                        //--- Otherwise, if the passed value exceeds the maximum range of all values of all properties, 
                        //--- inform of this in the journal and return INT_MAX causing the error
                        //--- accessing the array in XDimArray file classes which send the appropriate warning to the journal
                        CMessage::ToLog(DFUN,MSG_DATA_PROP_OBJ_OUT_OF_PROP_RANGE);
                        return INT_MAX;
                       }
public:
//--- Return the pointer to (1) the list of property objects, as well as to the object of (2) integer, (3) real and (4) string properties
   CArrayObj        *GetList(void)                                                     { return &this.m_list;                                      }
   CXDimArrayLong   *Long()                                                      const { return this.m_list.At(0);                                 }
   CXDimArrayDouble *Double()                                                    const { return this.m_list.At(1);                                 }
   CXDimArrayString *String()                                                    const { return this.m_list.At(2);                                 }
   
//--- Set (1) integer, (2) real and (3) string properties in the appropriate property object
   void              SetLong(int property,int index,long value)                        { this.Long().Set(property,index,value);                    }
   void              SetDouble(int property,int index,double value)                    { this.Double().Set(this.IndexProp(property),index,value);  }
   void              SetString(int property,int index,string value)                    { this.String().Set(this.IndexProp(property),index,value);  }
   //--- Return (1) integer, (2) real and (3) string property from the appropriate object
   long              GetLong(int property,int index)                             const { return this.Long().Get(property,index);                   }
   double            GetDouble(int property,int index)                           const { return this.Double().Get(this.IndexProp(property),index); }
   string            GetString(int property,int index)                           const { return this.String().Get(this.IndexProp(property),index); }
   
//--- Return the size of the specified first dimension data array
   int               Size(const int range) const
                       {
                        if(range<this.m_total_int)
                           return this.Long().Size(range);
                        else if(range<this.m_prop_max_dbl)
                           return this.Double().Size(this.IndexProp(range));
                        else if(range<this.m_prop_max_str)
                           return this.String().Size(this.IndexProp(range));
                        return 0;
                       }
//--- Set the array size in the specified dimensionality
   bool              SetSizeRange(const int range,const int size)
                       {
                        if(range<this.m_total_int)
                           return this.Long().SetSizeRange(range,size);
                        else if(range<this.m_prop_max_dbl)
                           return this.Double().SetSizeRange(this.IndexProp(range),size);
                        else if(range<this.m_prop_max_str)
                           return this.String().SetSizeRange(this.IndexProp(range),size);
                        return false;
                       }
//--- Return the number of (1) integer, (2) real and (3) string parameters
   int               TotalLong(void)   const { return this.m_total_int; }
   int               TotalDouble(void) const { return this.m_total_dbl; }
   int               TotalString(void) const { return this.m_total_str; }

//--- Constructor
                     CDataPropObj(const int prop_total_integer,const int prop_total_double,const int prop_total_string)
                       {
                        //--- Set the passed amounts of integer, real and string properties in the variables
                        this.m_total_int=prop_total_integer;
                        this.m_total_dbl=prop_total_double;
                        this.m_total_str=prop_total_string;
                        //--- Calculate and set the maximum values of real and string properties to the variables
                        this.m_prop_max_dbl=this.m_total_int+this.m_total_dbl;
                        this.m_prop_max_str=this.m_total_int+this.m_total_dbl+this.m_total_str;
                        //--- Add newly created objects of integer, real and string properties to the list
                        this.m_list.Add(new CXDimArrayLong(this.m_total_int, 1));
                        this.m_list.Add(new CXDimArrayDouble(this.m_total_dbl,1));
                        this.m_list.Add(new CXDimArrayString(this.m_total_str,1));
                       }
//--- Destructor
                    ~CDataPropObj()
                       {
                        m_list.Clear();
                        m_list.Shutdown();
                       }
  };
//+------------------------------------------------------------------+
//| Object changed property snapshot class                           |
//+------------------------------------------------------------------+
class CChangedProps : public CDataPropObj
  {
private:
  long               m_time_change;                         // Property modification time
  string             m_symbol;                              // Chart window symbol
  int                m_digits;                              // Symbol's Digits
public:
//--- Set the (1) change time value, (2) symbol and (3) symbol's Digits
   void              SetTimeChanged(const long time)        { this.m_time_change=time;                   }
   void              SetSymbol(const string symbol)         { this.m_symbol=symbol;                      }
   void              SetDigits(const int digits)            { this.m_digits=digits;                      }
//--- Return the (1) change time value, (2) change time, (3) symbol and (4) symbol's Digits
   long              TimeChanged(void)                const { return this.m_time_change;                 }
   string            TimeChangedToString(void)        const { return TimeMSCtoString(this.m_time_change);}
   string            Symbol(void)                     const { return this.m_symbol;                      }
   int               Digits(void)                     const { return this.m_digits;                      }
//--- Constructor/destructor
                     CChangedProps (const int prop_total_integer,const int prop_total_double,const int prop_total_string,const long time_changed) : 
                        CDataPropObj(prop_total_integer,prop_total_double,prop_total_string) { this.m_time_change=time_changed;}
                    ~CChangedProps (void){;}
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Class of the history of graphical object property changes        |
//+------------------------------------------------------------------+
class CChangeHistory
  {
private:
  CArrayObj          m_list_changes;                  // List of the property change history
public:
//--- Return (1) the pointer to the property change history object and (2) the number of changes
   CChangedProps    *GetChangedPropsObj(const string source,const int index)
                       {
                        CChangedProps *props=this.m_list_changes.At(index<0 ? 0 : index);
                        if(props==NULL)
                           CMessage::ToLog(source,MSG_GRAPH_OBJ_FAILED_GET_HIST_OBJ);
                        return props;
                       }
   int               TotalChanges(void)               { return this.m_list_changes.Total();  }
//--- Create a new object of the graphical object property change history
   bool              CreateNewElement(CDataPropObj *element,const long time_change)
                       {
                        //--- Create a new object of the graphical object property snapshot
                        CChangedProps *obj=new CChangedProps(element.TotalLong(),element.TotalDouble(),element.TotalString(),time_change);
                        //--- If failed to create an object, inform of that and return 'false'
                        if(obj==NULL)
                          {
                           CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_CREATE_NEW_HIST_OBJ);
                           return false;
                          }
                        //--- If failed to add the object to the list, inform of that, remove the object and return 'false'
                        if(!this.m_list_changes.Add(obj))
                          {
                           CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_ADD_OBJ_TO_HIST_LIST);
                           delete obj;
                           return false;
                          }
                        //--- Get the ID of the chart the graphical object is located on
                        long chart_id=element.GetLong(GRAPH_OBJ_PROP_CHART_ID,0);
                        //--- Set a chart symbol and symbol's Digits for the graphical object property snapshot object
                        obj.SetSymbol(::ChartSymbol(chart_id));
                        obj.SetDigits((int)::SymbolInfoInteger(obj.Symbol(),SYMBOL_DIGITS));
                        //--- Copy all integer properties
                        for(int i=0;i<element.TotalLong();i++)
                          {
                           int total=element.Long().Size(i);
                           if(obj.SetSizeRange(i,total))
                             {
                              for(int r=0;r<total;r++)
                                 obj.Long().Set(i,r,element.Long().Get(i,r));
                             }
                           else
                              CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_INC_ARRAY_SIZE);
                          }
                        //--- Copy all real properties
                        for(int i=0;i<element.TotalDouble();i++)
                          {
                           int total=element.Double().Size(i);
                           if(obj.Double().SetSizeRange(i,total))
                             {
                              for(int r=0;r<total;r++)
                                 obj.Double().Set(i,r,element.Double().Get(i,r));
                             }
                           else
                              CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_INC_ARRAY_SIZE);
                          }
                        //--- Copy all string properties
                        for(int i=0;i<element.TotalString();i++)
                          {
                           int total=element.String().Size(i);
                           if(obj.String().SetSizeRange(i,total))
                             {
                              for(int r=0;r<total;r++)
                                 obj.String().Set(i,r,element.String().Get(i,r));
                             }
                           else
                              CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_INC_ARRAY_SIZE);
                          }
                        return true;
                       }
//--- Return by index in the list of the graphical object change history object
//--- the value from the specified index of the (1) long, (2) double and (3) string array
   long              GetLong(const int time_index,const ENUM_GRAPH_OBJ_PROP_INTEGER prop,const int index)
                       {
                        CChangedProps *properties=this.GetChangedPropsObj(DFUN,time_index);
                        if(properties==NULL)
                           return 0;
                        return properties.GetLong(prop,index);
                       }
   double            GetDouble(const int time_index,const ENUM_GRAPH_OBJ_PROP_DOUBLE prop,const int index)
                       {
                        CChangedProps *properties=this.GetChangedPropsObj(DFUN,time_index);
                        if(properties==NULL)
                           return 0;
                        return properties.GetDouble(prop,index);
                       }
   string            GetString(const int time_index,const ENUM_GRAPH_OBJ_PROP_STRING prop,const int index)
                       {
                        CChangedProps *properties=this.GetChangedPropsObj(DFUN,time_index);
                        if(properties==NULL)
                           return "";
                        return properties.GetString(prop,index);
                       }
//--- Constructor/destructor
                     CChangeHistory(void){;}
                    ~CChangeHistory(void){;}
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Data class of the current and previous properties                |
//+------------------------------------------------------------------+
class CProperties : public CObject
  {
private:
   CArrayObj         m_list;  // List for storing the pointers to property objects
public:
   CDataPropObj     *Curr;    // Pointer to the current properties object
   CDataPropObj     *Prev;    // Pointer to the previous properties object
   CChangeHistory   *History; // Pointer to the change history object
//--- Set the array size ('size') in the specified dimension ('range')
   bool              SetSizeRange(const int range,const int size)
                       {
                        return(this.Curr.SetSizeRange(range,size) && this.Prev.SetSizeRange(range,size) ? true : false);
                       }
//--- Return the size of the specified array of the (1) current and (2) previous first dimension data
   int               CurrSize(const int range)  const { return Curr.Size(range); }
   int               PrevSize(const int range)  const { return Prev.Size(range); }
//--- Copy the current data to the previous one
   void              CurrentToPrevious(void)
                       {
                        //--- Copy all integer properties
                        for(int i=0;i<this.Curr.Long().Total();i++)
                           for(int r=0;r<this.Curr.Long().Size(i);r++)
                              this.Prev.Long().Set(i,r,this.Curr.Long().Get(i,r));
                        //--- Copy all real properties
                        for(int i=0;i<this.Curr.Double().Total();i++)
                           for(int r=0;r<this.Curr.Double().Size(i);r++)
                              this.Prev.Double().Set(i,r,this.Curr.Double().Get(i,r));
                        //--- Copy all string properties
                        for(int i=0;i<this.Curr.String().Total();i++)
                           for(int r=0;r<this.Curr.String().Size(i);r++)
                              this.Prev.String().Set(i,r,this.Curr.String().Get(i,r));
                       }
//--- Return the amount of graphical object changes since the start of recording them
   int               TotalChanges(void)   { return this.History.TotalChanges();  }
                       
//--- Constructor
                     CProperties(const int prop_int_total,const int prop_double_total,const int prop_string_total)
                       {
                        //--- Create new objects of the current and previous properties
                        this.Curr=new CDataPropObj(prop_int_total,prop_double_total,prop_string_total);
                        this.Prev=new CDataPropObj(prop_int_total,prop_double_total,prop_string_total);
                        //--- Add newly created objects to the list
                        this.m_list.Add(this.Curr);
                        this.m_list.Add(this.Prev);
                        //--- Create the change history object
                        this.History=new CChangeHistory();
                       }
//--- Destructor
                    ~CProperties()
                       {
                        this.m_list.Clear();
                        this.m_list.Shutdown();
                        if(this.History!=NULL)
                           delete this.History;
                       }
  };
//+------------------------------------------------------------------+
