//+------------------------------------------------------------------+
//|                                                     ChartWnd.mqh |
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
#include "..\..\Objects\BaseObj.mqh"
//+------------------------------------------------------------------+
//| Chart window indicator object class                              |
//+------------------------------------------------------------------+
class CWndInd : public CObject
  {
private:
   long              m_chart_id;                         // Chart ID
   string            m_name;                             // Indicator short name
   int               m_index;                            // Indicator index in the list
   int               m_window_num;                       // Indicator subwindow index
   int               m_handle;                           // Indicator handle
public:
//--- Return itself
   CWndInd          *GetObject(void)                     { return &this;               }
//--- Return (1) indicator name, (2) index in the list, (3) indicator handle and (4) subwindow index
   string            Name(void)                    const { return this.m_name;         }
   int               Index(void)                   const { return this.m_index;        }
   int               Handle(void)                  const { return this.m_handle;       }
   int               WindowNum(void)               const { return this.m_window_num;   }
//--- Set (1) subwindow name, (2) window index on the chart, (3) handle, (4) index
   void              SetName(const string name)          { this.m_name=name;           }
   void              SetIndex(const int index)           { this.m_index=index;         }
   void              SetHandle(const int handle)         { this.m_handle=handle;       }
   void              SetWindowNum(const int win_num)     { this.m_window_num=win_num;  }
   
//--- Display the description of object properties in the journal (dash=true - hyphen before the description, false - description only)
   void              Print(const bool dash=false)        { ::Print((dash ? "- " : "")+this.Header());                      }
//--- Return the object short name
   string            Header(void)                  const { return CMessage::Text(MSG_CHART_OBJ_INDICATOR)+" "+this.Name(); }
   
//--- Compare CWndInd objects with each other by the specified property
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Return an object type
   virtual int       Type(void)                    const { return OBJECT_DE_TYPE_CHART_WND_IND;                            }
//--- Constructors
                     CWndInd(void){;}
                     CWndInd(const int handle,const string name,const int index,const int win_num) : m_handle(handle),
                                                                                                     m_name(name),
                                                                                                     m_index(index),
                                                                                                     m_window_num(win_num) {}
  };
//+------------------------------------------------------------------+
//| Compare CWndInd objects with each other by the specified property|
//+------------------------------------------------------------------+
int CWndInd::Compare(const CObject *node,const int mode=0) const
  {
   const CWndInd *obj_compared=node;
   if(mode==CHART_WINDOW_PROP_WINDOW_IND_HANDLE) return(this.Handle()>obj_compared.Handle() ? 1 : this.Handle()<obj_compared.Handle() ? -1 : 0);
   else if(mode==CHART_WINDOW_PROP_WINDOW_IND_INDEX) return(this.Index()>obj_compared.Index() ? 1 : this.Index()<obj_compared.Index() ? -1 : 0);
   return(this.Name()==obj_compared.Name() ? 0 : this.Name()<obj_compared.Name() ? -1 : 1);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Chart window object class                                        |
//+------------------------------------------------------------------+
class CChartWnd : public CBaseObjExt
  {
private:
   CArrayObj         m_list_ind;                                        // Indicator list
   CArrayObj        *m_list_ind_del;                                    // Pointer to the list of indicators removed from the indicator window
   CArrayObj        *m_list_ind_param;                                  // Pointer to the list of changed indicators
   long              m_long_prop[CHART_WINDOW_PROP_INTEGER_TOTAL];      // Integer properties
   double            m_double_prop[CHART_WINDOW_PROP_DOUBLE_TOTAL];     // Real properties
   string            m_string_prop[CHART_WINDOW_PROP_STRING_TOTAL];     // String properties
   int               m_digits;                                          // Symbol's Digits()
   int               m_wnd_coord_x;                                     // The X coordinate for the time on the chart in the window
   int               m_wnd_coord_y;                                     // The Y coordinate for the price on the chart in the window
//--- Return the index of the array the (1) double and (2) string properties are actually located at
   int               IndexProp(ENUM_CHART_WINDOW_PROP_DOUBLE property)  const { return(int)property-CHART_WINDOW_PROP_INTEGER_TOTAL;                                 }
   int               IndexProp(ENUM_CHART_WINDOW_PROP_STRING property)  const { return(int)property-CHART_WINDOW_PROP_INTEGER_TOTAL-CHART_WINDOW_PROP_DOUBLE_TOTAL;  }
//--- Return the flag indicating the presence of an indicator (1) from the list in the window and (2) from the window in the list
   bool              IsPresentInWindow(const CWndInd *ind);
   bool              IsPresentInList(const string name);
//--- Return the indicator object present in the list but not present on the chart
   CWndInd          *GetMissingInd(void);
//--- Remove indicators not present in the window from the list
   void              IndicatorsDelete(void);
//--- Add new indicators to the list
   void              IndicatorsAdd(void);
//--- Check the changes of the parameters of existing indicators
   void              IndicatorsChangeCheck(void);
   
public:
//--- Set object's (1) integer, (2) real and (3) string properties
   void              SetProperty(ENUM_CHART_WINDOW_PROP_INTEGER property,long value)   { this.m_long_prop[property]=value;                      }
   void              SetProperty(ENUM_CHART_WINDOW_PROP_DOUBLE property,double value)  { this.m_double_prop[this.IndexProp(property)]=value;    }
   void              SetProperty(ENUM_CHART_WINDOW_PROP_STRING property,string value)  { this.m_string_prop[this.IndexProp(property)]=value;    }
//--- Return object’s (1) integer, (2) real and (3) string property from the properties array
   long              GetProperty(ENUM_CHART_WINDOW_PROP_INTEGER property)        const { return this.m_long_prop[property];                     }
   double            GetProperty(ENUM_CHART_WINDOW_PROP_DOUBLE property)         const { return this.m_double_prop[this.IndexProp(property)];   }
   string            GetProperty(ENUM_CHART_WINDOW_PROP_STRING property)         const { return this.m_string_prop[this.IndexProp(property)];   }
//--- Return itself
   CChartWnd        *GetObject(void)                                                   { return &this;      }

//--- Return the flag of the object supporting this property
   virtual bool      SupportProperty(ENUM_CHART_WINDOW_PROP_INTEGER property)          { return true;       }
   virtual bool      SupportProperty(ENUM_CHART_WINDOW_PROP_DOUBLE property)           { return true;       }
   virtual bool      SupportProperty(ENUM_CHART_WINDOW_PROP_STRING property)           { return true;       }

//--- Get description of (1) integer, (2) real and (3) string properties
   string            GetPropertyDescription(ENUM_CHART_WINDOW_PROP_INTEGER property);
   string            GetPropertyDescription(ENUM_CHART_WINDOW_PROP_DOUBLE property);
   string            GetPropertyDescription(ENUM_CHART_WINDOW_PROP_STRING property);

//--- Display the description of the object properties in the journal (full_prop=true - all properties, false - supported ones only - implemented in descendant classes)
   virtual void      Print(const bool full_prop=false,const bool dash=false);
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
//--- Return the object short name
   virtual string    Header(void);
   
//--- Create and send the chart event to the control program chart
   void              SendEvent(ENUM_CHART_OBJ_EVENT event);
  
//--- Compare CChartWnd objects by a specified property (to sort the list by an MQL5 signal object)
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Compare CChartWnd objects by all properties (to search for equal MQL5 signal objects)
   bool              IsEqual(CChartWnd* compared_obj) const;
   
//--- Constructors
                     CChartWnd(void){ this.m_type=OBJECT_DE_TYPE_CHART_WND; }
                     CChartWnd(const long chart_id,const int wnd_num,const string symbol,CArrayObj *list_ind_del,CArrayObj *list_ind_param);
//--- Destructor
                    ~CChartWnd(void);

//--- Return the distance in pixels between the window borders
   int               YDistance(void)                              const { return (int)::ChartGetInteger(this.m_chart_id,CHART_WINDOW_YDISTANCE,this.WindowNum());}
//--- (1) Return and (2) set the window height in pixels
   int               HeightInPixels(void)                         const { return (int)::ChartGetInteger(this.m_chart_id,CHART_HEIGHT_IN_PIXELS,this.WindowNum());}
   bool              SetHeightInPixels(const int value,const bool redraw=false);
//--- Return (1) the subwindow index, (2) the number of indicators attached to the window, (3) the name of a symbol chart, as well as (4) the highest and (5) lowest prices
   int               WindowNum(void)                              const { return (int)this.GetProperty(CHART_WINDOW_PROP_WINDOW_NUM);     }
   int               IndicatorsTotal(void)                        const { return this.m_list_ind.Total();                                 }
   string            Symbol(void)                                 const { return this.GetProperty(CHART_WINDOW_PROP_SYMBOL);              }
   double            PriceMax(void)                               const { return this.GetProperty(CHART_WINDOW_PROP_PRICE_MAX);           }
   double            PriceMin(void)                               const { return this.GetProperty(CHART_WINDOW_PROP_PRICE_MIN);           }
//--- Set (1) the subwindow index and (2) the chart symbol
   void              SetWindowNum(const int num)                        { this.SetProperty(CHART_WINDOW_PROP_WINDOW_NUM,num);             }
   void              SetSymbol(const string symbol)                     { this.SetProperty(CHART_WINDOW_PROP_SYMBOL,symbol);              }
   
//--- Return (1) the indicator list, the window indicator object from the list by (2) index in the list and (3) by handle
   CArrayObj        *GetIndicatorsList(void)                            { return &this.m_list_ind;                                        }
   CWndInd          *GetIndicatorByIndex(const int index);
   CWndInd          *GetIndicatorByHandle(const int handle);
//--- Return (1) the last one added to the window, (2) the last one removed from the window and (3) the changed indicator
   CWndInd          *GetLastAddedIndicator(void)                        { return this.m_list_ind.At(this.m_list_ind.Total()-1);           }
   CWndInd          *GetLastDeletedIndicator(void)                      { return this.m_list_ind_del.At(this.m_list_ind_del.Total()-1);   }
   CWndInd          *GetLastChangedIndicator(void)                      { return this.m_list_ind_param.At(this.m_list_ind_param.Total()-1);}
   
//--- Display the description of indicators attached to the chart window in the journal
   void              PrintIndicators(const bool dash=false);
//--- Display the description of the window parameters in the journal
   void              PrintParameters(const bool dash=false);
   
//--- Create the list of indicators attached to the window
   void              IndicatorsListCreate(void);
//--- Update data on attached indicators
   void              Refresh(void);
   
//--- Convert the coordinates of a chart from the time/price representation to the X and Y coordinates
   bool              TimePriceToXY(const datetime time,const double price);
//--- Return X and Y coordinates of the cursor location in the window
   int               XFromTimePrice(void)                         const { return this.m_wnd_coord_x;  }
   int               YFromTimePrice(void)                         const { return this.m_wnd_coord_y;  }
//--- Return the relative Y coordinate of the cursor location in the window
   int               YFromTimePriceRelative(void)  const { return this.m_wnd_coord_y-this.YDistance();}
   
//+------------------------------------------------------------------+
//| Get and set the parameters of tracked property changes           |
//+------------------------------------------------------------------+
//--- Distance in Y axis pixels between the upper frame of the indicator subwindow and the upper frame of the chart main window
//--- set the controlled (1) growth, (2) decrease, (3) reference distance level in pixels by the vertical Y axis between the window frames
//--- get (4) the distance change in pixels by the vertical Y axis between the window frames,
//--- get the distance change flag in pixels by the vertical Y axis between the window frames exceeding the (5) growth and (6) decrease values
   void              SetControlWindowYDistanceInc(const long value)        { this.SetControlledValueINC(CHART_WINDOW_PROP_YDISTANCE,(long)::fabs(value));         }
   void              SetControlWindowYDistanceDec(const long value)        { this.SetControlledValueDEC(CHART_WINDOW_PROP_YDISTANCE,(long)::fabs(value));         }
   void              SetControlWindowYDistanceLevel(const long value)      { this.SetControlledValueLEVEL(CHART_WINDOW_PROP_YDISTANCE,(long)::fabs(value));       }
   long              GetValueChangedWindowYDistance(void)            const { return this.GetPropLongChangedValue(CHART_WINDOW_PROP_YDISTANCE);                    }
   bool              IsIncreasedWindowYDistance(void)                const { return (bool)this.GetPropLongFlagINC(CHART_WINDOW_PROP_YDISTANCE);                   }
   bool              IsDecreasedWindowYDistance(void)                const { return (bool)this.GetPropLongFlagDEC(CHART_WINDOW_PROP_YDISTANCE);                   }
   
//--- Height of the chart in pixels
//--- setting the controlled spread (1) increase, (2) decrease value and (3) reference chart height in pixels
//--- get (4) the chart height change in pixels,
//--- get the flag of the chart height change in pixels exceeding (5) the growth and (6) decrease values
   void              SetControlHeightInPixelsInc(const long value)         { this.SetControlledValueINC(CHART_WINDOW_PROP_HEIGHT_IN_PIXELS,(long)::fabs(value));   }
   void              SetControlHeightInPixelsDec(const long value)         { this.SetControlledValueDEC(CHART_WINDOW_PROP_HEIGHT_IN_PIXELS,(long)::fabs(value));   }
   void              SetControlHeightInPixelsLevel(const long value)       { this.SetControlledValueLEVEL(CHART_WINDOW_PROP_HEIGHT_IN_PIXELS,(long)::fabs(value)); }
   long              GetValueChangedHeightInPixels(void)             const { return this.GetPropLongChangedValue(CHART_WINDOW_PROP_HEIGHT_IN_PIXELS);              }
   bool              IsIncreasedHeightInPixels(void)                 const { return (bool)this.GetPropLongFlagINC(CHART_WINDOW_PROP_HEIGHT_IN_PIXELS);             }
   bool              IsDecreasedHeightInPixels(void)                 const { return (bool)this.GetPropLongFlagDEC(CHART_WINDOW_PROP_HEIGHT_IN_PIXELS);             }
   
  };
//+------------------------------------------------------------------+
//| Parametric constructor                                           |
//+------------------------------------------------------------------+
CChartWnd::CChartWnd(const long chart_id,const int wnd_num,const string symbol,CArrayObj *list_ind_del,CArrayObj *list_ind_param) : m_wnd_coord_x(0),m_wnd_coord_y(0)
  {
   this.m_type=OBJECT_DE_TYPE_CHART_WND;
   this.m_digits=(int)::SymbolInfoInteger(symbol,SYMBOL_DIGITS);
   this.m_list_ind_del=list_ind_del;
   this.m_list_ind_param=list_ind_param;
   CBaseObj::SetChartID(chart_id);
   this.m_type=COLLECTION_CHART_WND_ID;
   
//--- Initialize base object data arrays
   this.SetControlDataArraySizeLong(CHART_WINDOW_PROP_INTEGER_TOTAL);
   this.SetControlDataArraySizeDouble(CHART_WINDOW_PROP_DOUBLE_TOTAL);
   this.ResetChangesParams();
   this.ResetControlsParams();
   
//--- Set object properties
   this.SetProperty(CHART_WINDOW_PROP_WINDOW_NUM,wnd_num);
   this.SetProperty(CHART_WINDOW_PROP_SYMBOL,symbol);
   this.SetProperty(CHART_WINDOW_PROP_ID,chart_id);
   this.SetProperty(CHART_WINDOW_PROP_YDISTANCE,::ChartGetInteger(chart_id,CHART_WINDOW_YDISTANCE,wnd_num));
   this.SetProperty(CHART_WINDOW_PROP_HEIGHT_IN_PIXELS,::ChartGetInteger(chart_id,CHART_HEIGHT_IN_PIXELS,wnd_num));
   this.SetProperty(CHART_WINDOW_PROP_PRICE_MIN,::ChartGetDouble(chart_id,CHART_PRICE_MIN,wnd_num));
   this.SetProperty(CHART_WINDOW_PROP_PRICE_MAX,::ChartGetDouble(chart_id,CHART_PRICE_MAX,wnd_num));
   this.m_name=this.Header();

//--- Fill in the symbol current data
   for(int i=0;i<CHART_WINDOW_PROP_INTEGER_TOTAL;i++)
      this.m_long_prop_event[i][3]=this.m_long_prop[i];
   for(int i=0;i<CHART_WINDOW_PROP_DOUBLE_TOTAL;i++)
      this.m_double_prop_event[i][3]=this.m_double_prop[i];
//--- Update the base object data and search for changes
   CBaseObjExt::Refresh();
   
//--- Create the indicator list
   this.IndicatorsListCreate();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CChartWnd::~CChartWnd(void)
  {
   int total=this.m_list_ind.Total();
   for(int i=total-1;i>WRONG_VALUE;i--)
     {
      CWndInd *ind=this.m_list_ind.At(i);
      if(ind==NULL)
         continue;
      ::IndicatorRelease(ind.Handle());
      this.m_list_ind.Delete(i);
     }
  }
//+------------------------------------------------------------------+
//| Compare CChartWnd objects with each other by a specified property|
//+------------------------------------------------------------------+
int CChartWnd::Compare(const CObject *node,const int mode=0) const
  {
   const CChartWnd *obj_compared=node;
   if(mode==CHART_WINDOW_PROP_YDISTANCE)
      return(this.YDistance()>obj_compared.YDistance() ? 1 : this.YDistance()<obj_compared.YDistance() ? -1 : 0);
   else if(mode==CHART_WINDOW_PROP_HEIGHT_IN_PIXELS)
      return(this.HeightInPixels()>obj_compared.HeightInPixels() ? 1 : this.HeightInPixels()<obj_compared.HeightInPixels() ? -1 : 0);
   else if(mode==CHART_WINDOW_PROP_WINDOW_NUM)
      return(this.WindowNum()>obj_compared.WindowNum() ? 1 : this.WindowNum()<obj_compared.WindowNum() ? -1 : 0);
   else if(mode==CHART_WINDOW_PROP_SYMBOL)
      return(this.Symbol()==obj_compared.Symbol() ? 0 : this.Symbol()>obj_compared.Symbol() ? 1 : -1);
   return -1;
  }
//+------------------------------------------------------------------+
//| Compare the CChartWnd objects by all properties                  |
//+------------------------------------------------------------------+
bool CChartWnd::IsEqual(CChartWnd *compared_obj) const
  {
   int begin=0, end=CHART_WINDOW_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_CHART_WINDOW_PROP_INTEGER prop=(ENUM_CHART_WINDOW_PROP_INTEGER)i;
      if(prop==CHART_WINDOW_PROP_WINDOW_IND_HANDLE || prop==CHART_WINDOW_PROP_WINDOW_IND_INDEX) continue;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false;
     }
   begin=end; end+=CHART_WINDOW_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_CHART_WINDOW_PROP_DOUBLE prop=(ENUM_CHART_WINDOW_PROP_DOUBLE)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=CHART_WINDOW_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_CHART_WINDOW_PROP_STRING prop=(ENUM_CHART_WINDOW_PROP_STRING)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Return description of object's integer property                  |
//+------------------------------------------------------------------+
string CChartWnd::GetPropertyDescription(ENUM_CHART_WINDOW_PROP_INTEGER property)
  {
   return
     (
      property==CHART_WINDOW_PROP_ID  ?  CMessage::Text(MSG_CHART_OBJ_ID)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)CBaseObj::GetChartID()
         )  :
      property==CHART_WINDOW_PROP_WINDOW_NUM  ?  CMessage::Text(MSG_CHART_OBJ_WINDOW_N)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.WindowNum()
         )  :
      property==CHART_WINDOW_PROP_YDISTANCE  ?  CMessage::Text(MSG_CHART_OBJ_WINDOW_YDISTANCE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.YDistance()
         )  :
      property==CHART_WINDOW_PROP_HEIGHT_IN_PIXELS  ?  CMessage::Text(MSG_CHART_OBJ_HEIGHT_IN_PIXELS)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.HeightInPixels()
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of object's real property                     |
//+------------------------------------------------------------------+
string CChartWnd::GetPropertyDescription(ENUM_CHART_WINDOW_PROP_DOUBLE property)
  {
   return
     (
      property==CHART_WINDOW_PROP_PRICE_MIN  ?  CMessage::Text(MSG_CHART_OBJ_PRICE_MIN)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.PriceMin(),this.m_digits)
         )  :
      property==CHART_WINDOW_PROP_PRICE_MAX  ?  CMessage::Text(MSG_CHART_OBJ_PRICE_MAX)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::DoubleToString(this.PriceMax(),this.m_digits)
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of object's string property                   |
//+------------------------------------------------------------------+
string CChartWnd::GetPropertyDescription(ENUM_CHART_WINDOW_PROP_STRING property)
  {
   return
     (
      property==CHART_WINDOW_PROP_SYMBOL  ?  CMessage::Text(MSG_LIB_PROP_SYMBOL)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.Symbol()
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Display object properties in the journal                         |
//+------------------------------------------------------------------+
void CChartWnd::Print(const bool full_prop=false,const bool dash=false)
  {
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_BEG)," (",this.Header(),") =============");
   int begin=0, end=CHART_WINDOW_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_CHART_WINDOW_PROP_INTEGER prop=(ENUM_CHART_WINDOW_PROP_INTEGER)i;
      if(prop==CHART_WINDOW_PROP_WINDOW_IND_HANDLE || prop==CHART_WINDOW_PROP_WINDOW_IND_INDEX) continue;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("------");
   begin=end; end+=CHART_WINDOW_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_CHART_WINDOW_PROP_DOUBLE prop=(ENUM_CHART_WINDOW_PROP_DOUBLE)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   begin=end; end+=CHART_WINDOW_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_CHART_WINDOW_PROP_STRING prop=(ENUM_CHART_WINDOW_PROP_STRING)i;
      if(prop==CHART_WINDOW_PROP_IND_NAME)
        {
         this.PrintIndicators();
         continue;
        }
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("============= ",CMessage::Text(MSG_LIB_PARAMS_LIST_END)," (",this.Header(),") =============\n");
  }
//+------------------------------------------------------------------+
//| Display a short description of the object in the journal         |
//+------------------------------------------------------------------+
void CChartWnd::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print((dash ? "- " : ""),this.Header()," ID: ",(string)this.GetChartID(),", ",CMessage::Text(MSG_CHART_OBJ_INDICATORS_TOTAL),": ",this.IndicatorsTotal());
  }
//+------------------------------------------------------------------+
//| Return the object short name                                     |
//+------------------------------------------------------------------+
string CChartWnd::Header(void)
  {
   return(this.WindowNum()==0 ? CMessage::Text(MSG_CHART_OBJ_CHART_WINDOW) : CMessage::Text(MSG_CHART_OBJ_CHART_SUBWINDOW)+" "+(string)this.WindowNum())+", "+this.Symbol();
  }
//+------------------------------------------------------------------+
//| Display the description of indicators attached to the window     |
//+------------------------------------------------------------------+
void CChartWnd::PrintIndicators(const bool dash=false)
  {
   string header=
     (
      this.WindowNum()==0 ? CMessage::Text(MSG_CHART_OBJ_INDICATORS_MW_NAME_LIST) : 
      CMessage::Text(MSG_CHART_OBJ_INDICATORS_SW_NAME_LIST)+" "+(string)this.WindowNum()
     );
   ::Print(header,":");
   int total=this.IndicatorsTotal();
   if(total==0)
      ::Print("- ",CMessage::Text(MSG_CHART_OBJ_INDICATORS_NONE));
   else for(int i=0;i<total;i++)
     {
      CWndInd *ind=this.m_list_ind.At(i);
      if(ind==NULL)
         continue;
      ind.Print(dash);
     }
  }
//+------------------------------------------------------------------+
//| Display the description of the window parameters in the journal  |
//+------------------------------------------------------------------+
void CChartWnd::PrintParameters(const bool dash=false)
  {
   string header=
     (
      this.WindowNum()==0 ? CMessage::Text(MSG_CHART_OBJ_CHART_WINDOW) : 
      CMessage::Text(MSG_CHART_OBJ_CHART_SUBWINDOW)+" "+(string)this.WindowNum()
     );
   ::Print((dash ? " " : ""),header,":");
   string pref=(dash ? " - " : "");
   if(this.WindowNum()>0)
      ::Print(pref,GetPropertyDescription(CHART_WINDOW_PROP_YDISTANCE));
   ::Print(pref,GetPropertyDescription(CHART_WINDOW_PROP_HEIGHT_IN_PIXELS));
   ::Print(pref,GetPropertyDescription(CHART_WINDOW_PROP_PRICE_MAX));
   ::Print(pref,GetPropertyDescription(CHART_WINDOW_PROP_PRICE_MIN));
  }
//+------------------------------------------------------------------+
//| Create the list of indicators attached to the window             |
//+------------------------------------------------------------------+
void CChartWnd::IndicatorsListCreate(void)
  {
   //--- Clear the indicator lists
   this.m_list_ind.Clear();
   //--- Get the total number of indicators in the window
   int total=::ChartIndicatorsTotal(this.m_chart_id,this.WindowNum());
   //--- In the loop by the number of indicators,
   for(int i=0;i<total;i++)
     {
      //--- obtain and save the short indicator name,
      string name=::ChartIndicatorName(this.m_chart_id,this.WindowNum(),i);
      //--- get and save the indicator handle by its short name
      int handle=::ChartIndicatorGet(this.m_chart_id,this.WindowNum(),name);
      //--- Create the new indicator object in the chart window
      CWndInd *ind=new CWndInd(handle,name,i,this.WindowNum());
      if(ind==NULL)
         continue;
      //--- set the sorted list flag to the list
      this.m_list_ind.Sort();
      //--- If failed to add the object to the list, remove it
      if(!this.m_list_ind.Add(ind))
         delete ind;
     }
  }
//+------------------------------------------------------------------+
//| Add new indicators to the list                                   |
//+------------------------------------------------------------------+
void CChartWnd::IndicatorsAdd(void)
  {
   //--- Get the total number of indicators in the window
   int total=::ChartIndicatorsTotal(this.m_chart_id,this.WindowNum());
   //--- In the loop by the number of indicators,
   for(int i=0;i<total;i++)
     {
      //--- obtain and save the short indicator name,
      string name=::ChartIndicatorName(this.m_chart_id,this.WindowNum(),i);
      //--- get and save the indicator handle by its short name
      int handle=::ChartIndicatorGet(this.m_chart_id,this.WindowNum(),name);
      //--- Create the new indicator object in the chart window
      CWndInd *ind=new CWndInd(handle,name,i,this.WindowNum());
      if(ind==NULL)
         continue;
      //--- set the sorted list flag to the list
      this.m_list_ind.Sort();
      //--- If the object is already in the list or an attempt to add it to the list failed, remove it
      if(this.m_list_ind.Search(ind)>WRONG_VALUE || !this.m_list_ind.Add(ind))
         delete ind;
     }
  }
//+--------------------------------------------------------------------------------------+
//| Return the flag indicating the presence of an indicator from the list in the window  |
//+--------------------------------------------------------------------------------------+
bool CChartWnd::IsPresentInWindow(const CWndInd *ind)
  {
   int total=::ChartIndicatorsTotal(this.m_chart_id,this.WindowNum());
   for(int i=0;i<total;i++)
     {
      string name=::ChartIndicatorName(this.m_chart_id,this.WindowNum(),i);
      int handle=::ChartIndicatorGet(this.m_chart_id,this.WindowNum(),name);
      if(ind.Name()==name && ind.Handle()==handle)
         return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Check the changes of the parameters of existing indicators       |
//+------------------------------------------------------------------+
void CChartWnd::IndicatorsChangeCheck(void)
  {
   //--- Get the total number of indicators in the window
   int total=::ChartIndicatorsTotal(this.m_chart_id,this.WindowNum());
   //--- In the loop by all window indicators,
   for(int i=0;i<total;i++)
     {
      //--- get the indicator name and get its handle by a name
      string name=::ChartIndicatorName(this.m_chart_id,this.WindowNum(),i);
      int handle=::ChartIndicatorGet(this.m_chart_id,this.WindowNum(),name);
      //--- If the indicator with such a name is present in the object indicator list, move on to the next one
      if(this.IsPresentInList(name))
         continue;
      //--- Get the indicator object present in the list but not present in the window
      CWndInd *ind=this.GetMissingInd();
      if(ind==NULL)
         continue;
      //--- If the indicator and the detected object have the same index, this is the indicator with changed parameters
      if(ind.Index()==i)
        {
         //--- Create a new indicator object based on the detected indicator object,
         CWndInd *changed=new CWndInd(ind.Handle(),ind.Name(),ind.Index(),ind.WindowNum());
         if(changed==NULL)
            continue;
         //--- set the sorted list flag to the list of changed indicators
         this.m_list_ind_param.Sort();
         //--- If failed to add a newly created indicator object to the list of changed indicators,
         //--- remove the created object and move on to the next indicator in the window
         if(!this.m_list_ind_param.Add(changed))
           {
            delete changed;
            continue;
           }
         //--- Set the new parameters for the detected "lost" indicator - short name and handle
         ind.SetName(name);
         ind.SetHandle(handle);
         //--- and call the method of sending a custom event to the control program chart
         this.SendEvent(CHART_OBJ_EVENT_CHART_WND_IND_CHANGE);
        }
     }
  }
//+------------------------------------------------------------------+
//| Remove indicators not present in the window from the list        |
//+------------------------------------------------------------------+
void CChartWnd::IndicatorsDelete(void)
  {
   //--- In the loop by the list of window indicator objects,
   int total=this.m_list_ind.Total();
   for(int i=total-1;i>WRONG_VALUE;i--)
     {
      //--- get the next indicator object
      CWndInd *ind=this.m_list_ind.At(i);
      if(ind==NULL)
         continue;
      //--- If such an indicator is present in the chart window, move on to the next object in the list
      if(this.IsPresentInWindow(ind))
         continue;
      //--- Create a copy of a removed indicator
      CWndInd *ind_del=new CWndInd(ind.Handle(),ind.Name(),ind.Index(),ind.WindowNum());
      if(ind_del==NULL)
         continue;
      //--- If failed to place a created object to the list of indicators removed from the window,
      //--- remove it and go to the next object in the list
      if(!this.m_list_ind_del.Add(ind_del))
        {
         delete ind_del;
         continue;
        }
      //--- Remove the indicator, which was deleted from the window, from the list
      this.m_list_ind.Delete(i);
     }
  }
//+------------------------------------------------------------------------------+
//| Return the flag of the presence of an indicator from the window in the list  |
//+------------------------------------------------------------------------------+
bool CChartWnd::IsPresentInList(const string name)
  {
   CWndInd *ind=new CWndInd();
   if(ind==NULL)
      return false;
   ind.SetName(name);
   this.m_list_ind.Sort(SORT_BY_CHART_WINDOW_IND_NAME);
   int index=this.m_list_ind.Search(ind);
   delete ind;
   return(index>WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return the indicator object present in the list                  |
//| but not on the chart                                             |
//+------------------------------------------------------------------+
CWndInd *CChartWnd::GetMissingInd(void)
  {
   for(int i=0;i<this.m_list_ind.Total();i++)
     {
      CWndInd *ind=this.m_list_ind.At(i);
      if(!this.IsPresentInWindow(ind))
         return ind;
     }
   return NULL;
  }
//+------------------------------------------------------------------+
//| Return the indicator object by the index in the window list      |
//+------------------------------------------------------------------+
CWndInd *CChartWnd::GetIndicatorByIndex(const int index)
  {
   CWndInd *ind=new CWndInd();
   if(ind==NULL)
      return NULL;
   ind.SetIndex(index);
   this.m_list_ind.Sort(SORT_BY_CHART_WINDOW_IND_INDEX);
   int n=this.m_list_ind.Search(ind);
   delete ind;
   return this.m_list_ind.At(n);
  }
//+------------------------------------------------------------------+
//| Return the window indicator object from the list by handle       |
//+------------------------------------------------------------------+
CWndInd *CChartWnd::GetIndicatorByHandle(const int handle)
  {
   CWndInd *ind=new CWndInd();
   if(ind==NULL)
      return NULL;
   ind.SetHandle(handle);
   this.m_list_ind.Sort(SORT_BY_CHART_WINDOW_IND_HANDLE);
   int index=this.m_list_ind.Search(ind);
   delete ind;
   return this.m_list_ind.At(index);
  }
//+------------------------------------------------------------------+
//| Set the window height in pixels                                  |
//+------------------------------------------------------------------+
bool CChartWnd::SetHeightInPixels(const int value,const bool redraw=false)
  {
   ::ResetLastError();
   if(!::ChartSetInteger(this.m_chart_id,CHART_HEIGHT_IN_PIXELS,this.WindowNum(),value))
     {
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
   if(redraw)
      ::ChartRedraw(this.m_chart_id);
   return true;
  }
//+------------------------------------------------------------------+
//| Update data on attached indicators                               |
//+------------------------------------------------------------------+
void CChartWnd::Refresh(void)
  {
   //--- Initialize event data
   this.m_is_event=false;
   this.m_hash_sum=0;
   //--- Calculate the change of the indicator number in the "now and during the previous check" window
   int change=::ChartIndicatorsTotal(this.m_chart_id,this.WindowNum())-this.m_list_ind.Total();
   //--- If there is no change in the number of indicators in the window,
   if(change==0)
     {
      //--- check the change of parameters of all indicators and exit
      this.IndicatorsChangeCheck();
      //--- Update integer properties
      this.SetProperty(CHART_WINDOW_PROP_YDISTANCE,::ChartGetInteger(this.m_chart_id,CHART_WINDOW_YDISTANCE,this.WindowNum()));
      this.SetProperty(CHART_WINDOW_PROP_HEIGHT_IN_PIXELS,::ChartGetInteger(this.m_chart_id,CHART_HEIGHT_IN_PIXELS,this.WindowNum()));
      //--- Update real properties
      this.SetProperty(CHART_WINDOW_PROP_PRICE_MIN,::ChartGetDouble(this.m_chart_id,CHART_PRICE_MIN,this.WindowNum()));
      this.SetProperty(CHART_WINDOW_PROP_PRICE_MAX,::ChartGetDouble(this.m_chart_id,CHART_PRICE_MAX,this.WindowNum()));
      //--- Update string properties
      string symbol=::ChartSymbol(this.m_chart_id);
      if(symbol!=NULL)
         this.SetProperty(CHART_WINDOW_PROP_SYMBOL,symbol);
      
      //--- Fill in the symbol current data
      for(int i=0;i<CHART_WINDOW_PROP_INTEGER_TOTAL;i++)
         this.m_long_prop_event[i][3]=this.m_long_prop[i];
      for(int i=0;i<CHART_WINDOW_PROP_DOUBLE_TOTAL;i++)
         this.m_double_prop_event[i][3]=this.m_double_prop[i];
      
      //--- Update the base object data, search for changes and exit
      CBaseObjExt::Refresh();
      this.CheckEvents();
      return;
     }
   //--- If indicators are added
   if(change>0)
     {
      //--- Call the method of adding new indicators to the list
      this.IndicatorsAdd();
      //--- In the loop by the number of indicators added to the window,
      for(int i=0;i<change;i++)
        {
         //--- get the new indicator in the list by the index calculated from the end of the list
         int index=this.m_list_ind.Total()-(1+i);
         //--- and if failed to obtain the object, move on to the next one
         CWndInd *ind=this.m_list_ind.At(index);
         if(ind==NULL)
            continue;
         //--- call the method of sending an event to the control program chart
         this.SendEvent(CHART_OBJ_EVENT_CHART_WND_IND_ADD);
        }
     }
   //--- If there are removed indicators
   if(change<0)
     {
      //--- Call the method of removing unnecessary indicators from the list
      this.IndicatorsDelete();
      //--- In the loop by the number of indicators removed from the window,
      for(int i=0;i<-change;i++)
        {
         //--- get a new removed indicator in the list of removed indicators by index calculated from the end of the list
         int index=this.m_list_ind_del.Total()-(1+i);
         //--- and if failed to obtain the object, move on to the next one
         CWndInd *ind=this.m_list_ind_del.At(index);
         if(ind==NULL)
            continue;
         //--- call the method of sending an event to the control program chart
         this.SendEvent(CHART_OBJ_EVENT_CHART_WND_IND_DEL);
        }
     }
  }
//+------------------------------------------------------------------+
//| Convert chart coordinates from the time/price representation     |
//| to X and Y coordinates                                           |
//+------------------------------------------------------------------+
bool CChartWnd::TimePriceToXY(const datetime time,const double price)
  {
   ::ResetLastError();
   if(!::ChartTimePriceToXY(this.m_chart_id,this.WindowNum(),time,price,this.m_wnd_coord_x,this.m_wnd_coord_y))
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_CONV_TIMEPRICE_COORDS_TO_XY);
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Create and send a chart window event                             |
//| to the control program chart                                     |
//+------------------------------------------------------------------+
void CChartWnd::SendEvent(ENUM_CHART_OBJ_EVENT event)
  {
   //--- If an indicator is added
   if(event==CHART_OBJ_EVENT_CHART_WND_IND_ADD)
     {
      //--- Get the last indicator object added to the list
      CWndInd *ind=this.GetLastAddedIndicator();
      if(ind==NULL)
         return;
      //--- Send the CHART_OBJ_EVENT_CHART_WND_IND_ADD event to the control program chart
      //--- pass the chart ID to lparam,
      //--- pass the chart window index to dparam,
      //--- pass the short name of the added indicator to sparam
      ::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,this.WindowNum(),ind.Name());
     }
   //--- If the indicator is removed
   else if(event==CHART_OBJ_EVENT_CHART_WND_IND_DEL)
     {
      //--- Get the last indicator object added to the list of removed indicators
      CWndInd *ind=this.GetLastDeletedIndicator();
      if(ind==NULL)
         return;
      //--- Send the CHART_OBJ_EVENT_CHART_WND_IND_DEL event to the control program chart
      //--- pass the chart ID to lparam,
      //--- pass the chart window index to dparam,
      //--- pass the short name of a deleted indicator to sparam
      ::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,this.WindowNum(),ind.Name());
     }
   //--- If the indicator has changed
   else if(event==CHART_OBJ_EVENT_CHART_WND_IND_CHANGE)
     {
      //--- Get the last indicator object added to the list of changed indicators
      CWndInd *ind=this.GetLastChangedIndicator();
      if(ind==NULL)
         return;
      //--- Send the CHART_OBJ_EVENT_CHART_WND_IND_CHANGE event to the control program chart
      //--- pass the chart ID to lparam,
      //--- pass the chart window index to dparam,
      //--- pass the short name of a changed indicator to sparam
      ::EventChartCustom(this.m_chart_id_main,(ushort)event,this.m_chart_id,this.WindowNum(),ind.Name());
     }
  }
//+------------------------------------------------------------------+
