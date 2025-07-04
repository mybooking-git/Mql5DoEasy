//+------------------------------------------------------------------+
//|                                                     GBaseObj.mqh |
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
#include "..\..\Services\DELib.mqh"
#include <Graphics\Graphic.mqh>
//+------------------------------------------------------------------+
//| Graphical object event class                                     |
//+------------------------------------------------------------------+
class CGBaseEvent : public CObject
  {
private:
   ushort            m_id;
   long              m_lparam;
   double            m_dparam;
   string            m_sparam;
public:
   void              ID(ushort id)                          { this.m_id=id;         }
   ushort            ID(void)                         const { return this.m_id;     }
   void              LParam(const long value)               { this.m_lparam=value;  }
   long              Lparam(void)                     const { return this.m_lparam; }
   void              DParam(const double value)             { this.m_dparam=value;  }
   double            Dparam(void)                     const { return this.m_dparam; }
   void              SParam(const string value)             { this.m_sparam=value;  }
   string            Sparam(void)                     const { return this.m_sparam; }
   bool              Send(const long chart_id)
                       {
                        ::ResetLastError();
                        return ::EventChartCustom(chart_id,m_id,m_lparam,m_dparam,m_sparam);
                       }
                     CGBaseEvent (const ushort event_id,const long lparam,const double dparam,const string sparam) : 
                        m_id(event_id),m_lparam(lparam),m_dparam(dparam),m_sparam(sparam){}
                    ~CGBaseEvent (void){}
  };
//+------------------------------------------------------------------+
//| Class of the base object of the library graphical objects        |
//+------------------------------------------------------------------+
class CGBaseObj : public CObject
  {
protected:
   CArrayObj         m_list_events;                      // Object event list
   ENUM_OBJECT       m_type_graph_obj;                   // Graphical object type
   ENUM_GRAPH_ELEMENT_TYPE m_type_element;               // Graphical element type
   ENUM_GRAPH_OBJ_BELONG m_belong;                       // Program affiliation
   ENUM_GRAPH_OBJ_SPECIES m_species;                     // Graphical object species
   string            m_name_prefix;                      // Object name prefix
   string            m_name;                             // Object name
   long              m_chart_id;                         // Object chart ID
   long              m_object_id;                        // Object ID
   long              m_zorder;                           // Priority of a graphical object for receiving the mouse click event
   int               m_subwindow;                        // Subwindow index
   int               m_shift_y;                          // Y coordinate shift for the subwindow
   int               m_type;                             // Object type
   int               m_timeframes_visible;               // Visibility of an object on timeframes (a set of flags)
   int               m_digits;                           // Number of decimal places in a quote
   int               m_group;                            // Graphical object group
   bool              m_visible;                          // Object visibility
   bool              m_back;                             // "Background object" flag
   bool              m_selected;                         // "Object selection" flag
   bool              m_selectable;                       // "Object availability" flag
   bool              m_hidden;                           // "Disable displaying the name of a graphical object in the terminal object list" flag
   datetime          m_create_time;                      // Object creation time
   
//--- Create (1) the object structure and (2) the object from the structure
   virtual bool      ObjectToStruct(void)                      { return true; }
   virtual void      StructToObject(void){;}

//--- Return the list of object events
   CArrayObj        *GetListEvents(void)                       { return &this.m_list_events;          }
//--- Create a new object event
   CGBaseEvent      *CreateNewEvent(const ushort event_id,const long lparam,const double dparam,const string sparam)
                       {
                        CGBaseEvent *event=new CGBaseEvent(event_id,lparam,dparam,sparam);
                        return event;
                       }
//--- Create a new object event and add it to the event list
   bool              CreateAndAddNewEvent(const ushort event_id,const long lparam,const double dparam,const string sparam)
                       {
                        return this.AddEvent(new CGBaseEvent(event_id,lparam,dparam,sparam));
                       }
//--- Add an event object to the event list
   bool              AddEvent(CGBaseEvent *event)              { return this.m_list_events.Add(event);}
//--- Clear the event list
   void              ClearEventsList(void)                     { this.m_list_events.Clear();          }
//--- Return the number of events in the list
   int               EventsTotal(void)                         { return this.m_list_events.Total();   }

public:
//--- Return the prefix name
   string            NamePrefix(void)                    const { return this.m_name_prefix;           }
//--- Set the values of the class variables
   void              SetObjectID(const long value)             { this.m_object_id=value;              }
   void              SetBelong(const ENUM_GRAPH_OBJ_BELONG belong){ this.m_belong=belong;             }
   void              SetTypeGraphObject(const ENUM_OBJECT obj) { this.m_type_graph_obj=obj;           }
   void              SetTypeElement(const ENUM_GRAPH_ELEMENT_TYPE type) { this.m_type_element=type;   }
   void              SetSpecies(const ENUM_GRAPH_OBJ_SPECIES species){ this.m_species=species;        }
   void              SetGroup(const int group)                 { this.m_group=group;                  }
   void              SetName(const string name)                { this.m_name=name;                    }
   void              SetChartID(const long chart_id)           { this.m_chart_id=chart_id;            }
   void              SetDigits(const int value)                { this.m_digits=value;                 }
   
//--- Set the "Background object" flag
   bool              SetFlagBack(const bool flag,const bool only_prop)
                       {
                        ::ResetLastError();
                        if((!only_prop && ::ObjectSetInteger(this.m_chart_id,this.m_name,OBJPROP_BACK,flag)) || only_prop)
                          {
                           this.m_back=flag;
                           return true;
                          }
                        else
                           CMessage::ToLog(DFUN,::GetLastError(),true);
                        return false;
                       }
//--- Set the "Object selection" flag
   bool              SetFlagSelected(const bool flag,const bool only_prop)
                       {
                        ::ResetLastError();
                        if((!only_prop && ::ObjectSetInteger(this.m_chart_id,this.m_name,OBJPROP_SELECTED,flag)) || only_prop)
                          {
                           this.m_selected=flag;
                           return true;
                          }
                        else
                           CMessage::ToLog(DFUN,::GetLastError(),true);
                        return false;
                       }
//--- Set the "Object selection" flag
   bool              SetFlagSelectable(const bool flag,const bool only_prop)
                       {
                        ::ResetLastError();
                        if((!only_prop && ::ObjectSetInteger(this.m_chart_id,this.m_name,OBJPROP_SELECTABLE,flag)) || only_prop)
                          {
                           this.m_selectable=flag;
                           return true;
                          }
                        else
                           CMessage::ToLog(DFUN,::GetLastError(),true);
                        return false;
                       }
//--- Set the "Disable displaying the name of a graphical object in the terminal object list" flag
   bool              SetFlagHidden(const bool flag,const bool only_prop)
                       {
                        ::ResetLastError();
                        if((!only_prop && ::ObjectSetInteger(this.m_chart_id,this.m_name,OBJPROP_SELECTABLE,flag)) || only_prop)
                          {
                           this.m_hidden=flag;
                           return true;
                          }
                        else
                           CMessage::ToLog(DFUN,::GetLastError(),true);
                        return false;
                       }
//--- Set the priority of a graphical object for receiving the event of clicking on a chart 
   virtual bool      SetZorder(const long value,const bool only_prop)
                       {
                        ::ResetLastError();
                        if((!only_prop && ::ObjectSetInteger(this.m_chart_id,this.m_name,OBJPROP_ZORDER,value)) || only_prop)
                          {
                           this.m_zorder=value;
                           return true;
                          }
                        else
                           CMessage::ToLog(DFUN,::GetLastError(),true);
                        return false;
                       }
//--- Set object visibility on all timeframes
   bool              SetVisible(const bool flag,const bool only_prop)   
                       {
                        long value=(flag ? OBJ_ALL_PERIODS : OBJ_NO_PERIODS);
                        ::ResetLastError();
                        if((!only_prop && ::ObjectSetInteger(this.m_chart_id,this.m_name,OBJPROP_TIMEFRAMES,value)) || only_prop)
                          {
                           this.m_visible=flag;
                           return true;
                          }
                        else
                           CMessage::ToLog(DFUN,::GetLastError(),true);
                        return false;
                       }
//--- Set visibility flags on timeframes specified as flags
   bool              SetVisibleOnTimeframes(const int flags,const bool only_prop)
                       {
                        ::ResetLastError();
                        if((!only_prop && ::ObjectSetInteger(this.m_chart_id,this.m_name,OBJPROP_TIMEFRAMES,flags)) || only_prop)
                          {
                           this.m_timeframes_visible=flags;
                           return true;
                          }
                        else
                           CMessage::ToLog(DFUN,::GetLastError(),true);
                        return false;
                       }
//--- Add the visibility flag on a specified timeframe
   bool              SetVisibleOnTimeframe(const ENUM_TIMEFRAMES timeframe,const bool only_prop)
                       {
                        int flags=this.m_timeframes_visible;
                        switch(timeframe)
                          {
                           case PERIOD_M1    : flags |= OBJ_PERIOD_M1;  break;
                           case PERIOD_M2    : flags |= OBJ_PERIOD_M2;  break;
                           case PERIOD_M3    : flags |= OBJ_PERIOD_M3;  break;
                           case PERIOD_M4    : flags |= OBJ_PERIOD_M4;  break;
                           case PERIOD_M5    : flags |= OBJ_PERIOD_M5;  break;
                           case PERIOD_M6    : flags |= OBJ_PERIOD_M6;  break;
                           case PERIOD_M10   : flags |= OBJ_PERIOD_M10; break;
                           case PERIOD_M12   : flags |= OBJ_PERIOD_M12; break;
                           case PERIOD_M15   : flags |= OBJ_PERIOD_M15; break;
                           case PERIOD_M20   : flags |= OBJ_PERIOD_M20; break;
                           case PERIOD_M30   : flags |= OBJ_PERIOD_M30; break;
                           case PERIOD_H1    : flags |= OBJ_PERIOD_H1;  break;
                           case PERIOD_H2    : flags |= OBJ_PERIOD_H2;  break;
                           case PERIOD_H3    : flags |= OBJ_PERIOD_H3;  break;
                           case PERIOD_H4    : flags |= OBJ_PERIOD_H4;  break;
                           case PERIOD_H6    : flags |= OBJ_PERIOD_H6;  break;
                           case PERIOD_H8    : flags |= OBJ_PERIOD_H8;  break;
                           case PERIOD_H12   : flags |= OBJ_PERIOD_H12; break;
                           case PERIOD_D1    : flags |= OBJ_PERIOD_D1;  break;
                           case PERIOD_W1    : flags |= OBJ_PERIOD_W1;  break;
                           case PERIOD_MN1   : flags |= OBJ_PERIOD_MN1; break;
                           default           : return true;
                          }
                        ::ResetLastError();
                        if((!only_prop && ::ObjectSetInteger(this.m_chart_id,this.m_name,OBJPROP_TIMEFRAMES,flags)) || only_prop)
                          {
                           this.m_timeframes_visible=flags;
                           return true;
                          }
                        else
                           CMessage::ToLog(DFUN,::GetLastError(),true);
                        return false;
                       }
//--- Set a subwindow index
   bool              SetSubwindow(const long chart_id,const string name)
                       {
                        ::ResetLastError();
                        this.m_subwindow=::ObjectFind(chart_id,name);
                        if(this.m_subwindow<0)
                           CMessage::ToLog(DFUN,MSG_GRAPH_STD_OBJ_ERR_NOT_FIND_SUBWINDOW);
                        return(this.m_subwindow>WRONG_VALUE);
                       }
   bool              SetSubwindow(void)
                       {
                        return this.SetSubwindow(this.m_chart_id,this.m_name);
                       }

//--- Return the values of class variables
   ENUM_GRAPH_ELEMENT_TYPE TypeGraphElement(void)        const { return this.m_type_element;       }
   ENUM_GRAPH_OBJ_BELONG   Belong(void)                  const { return this.m_belong;             }
   ENUM_GRAPH_OBJ_SPECIES  Species(void)                 const { return this.m_species;            }
   ENUM_OBJECT       TypeGraphObject(void)               const { return this.m_type_graph_obj;     }
   datetime          TimeCreate(void)                    const { return this.m_create_time;        }
   string            Name(void)                          const { return this.m_name;               }
   long              ChartID(void)                       const { return this.m_chart_id;           }
   long              ObjectID(void)                      const { return this.m_object_id;          }
   virtual long      Zorder(void)                        const { return this.m_zorder;             }
   int               SubWindow(void)                     const { return this.m_subwindow;          }
   int               ShiftY(void)                        const { return this.m_shift_y;            }
   int               VisibleOnTimeframes(void)           const { return this.m_timeframes_visible; }
   int               Digits(void)                        const { return this.m_digits;             }
   int               Group(void)                         const { return this.m_group;              }
   bool              IsBack(void)                        const { return this.m_back;               }
   bool              IsSelected(void)                    const { return this.m_selected;           }
   bool              IsSelectable(void)                  const { return this.m_selectable;         }
   bool              IsHidden(void)                      const { return this.m_hidden;             }
   bool              IsVisible(void)                     const { return this.m_visible;            }

//--- Return the graphical object type (ENUM_OBJECT) calculated from the object type (ENUM_OBJECT_DE_TYPE) passed to the method
   ENUM_OBJECT       GraphObjectType(const ENUM_OBJECT_DE_TYPE obj_type) const
                       { 
                        return ENUM_OBJECT(obj_type-OBJECT_DE_TYPE_GSTD_OBJ-1);
                       }
   
//--- Return the description of the type of the graphical object (1) type, (2) element, (3) affiliation and (4) species
string               TypeGraphObjectDescription(void);
string               TypeElementDescription(void);
string               BelongDescription(void);
string               SpeciesDescription(void);

//--- The virtual method returning the object type
   virtual int       Type(void)                          const { return this.m_type;               }

//--- Constructor/destructor
                     CGBaseObj();
                    ~CGBaseObj(){;}
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CGBaseObj::CGBaseObj() : m_name_prefix(::MQLInfoString(MQL_PROGRAM_NAME)+"_"),m_belong(GRAPH_OBJ_BELONG_PROGRAM)
  {
   this.m_list_events.Clear();                  // Clear the event list
   this.m_list_events.Sort();                   // Sorted list flag
   this.m_type=OBJECT_DE_TYPE_GBASE;            // Object type
   this.m_type_graph_obj=WRONG_VALUE;           // Graphical object type
   this.m_type_element=WRONG_VALUE;             // Graphical object type
   this.m_belong=WRONG_VALUE;                   // Program/terminal affiliation
   this.m_group=0;                              // Group of graphical objects
   this.m_name="";                              // Object name
   this.m_chart_id=0;                           // Object chart ID
   this.m_object_id=0;                          // Object ID
   this.m_zorder=0;                             // Priority of a graphical object for receiving the mouse click event
   this.m_subwindow=0;                          // Subwindow index
   this.m_shift_y=0;                            // Y coordinate shift for the subwindow
   this.m_timeframes_visible=OBJ_ALL_PERIODS;   // Visibility of an object on timeframes (a set of flags)
   this.m_visible=true;                         // Object visibility
   this.m_back=false;                           // "Background object" flag
   this.m_selected=false;                       // "Object selection" flag
   this.m_selectable=false;                     // "Object availability" flag
   this.m_hidden=true;                          // "Disable displaying the name of a graphical object in the terminal object list" flag
   this.m_create_time=0;                        // Object creation time
  }
//+------------------------------------------------------------------+
//| Return the description of the graphical object type              |
//+------------------------------------------------------------------+
string CGBaseObj::TypeGraphObjectDescription(void)
  {
   if(this.TypeGraphElement()==GRAPH_ELEMENT_TYPE_STANDARD)
      return StdGraphObjectTypeDescription(this.m_type_graph_obj);
   else
      return this.TypeElementDescription();
  }
//+------------------------------------------------------------------+
//| Return the description of the graphical element type             |
//+------------------------------------------------------------------+
string CGBaseObj::TypeElementDescription(void)
  {
   return
     (
      this.TypeGraphElement()==GRAPH_ELEMENT_TYPE_STANDARD           ? CMessage::Text(MSG_GRAPH_ELEMENT_TYPE_STANDARD)           :
      this.TypeGraphElement()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED  ? CMessage::Text(MSG_GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED)  :
      this.TypeGraphElement()==GRAPH_ELEMENT_TYPE_ELEMENT            ? CMessage::Text(MSG_GRAPH_ELEMENT_TYPE_ELEMENT)            :
      this.TypeGraphElement()==GRAPH_ELEMENT_TYPE_SHADOW_OBJ         ? CMessage::Text(MSG_GRAPH_ELEMENT_TYPE_SHADOW_OBJ)         :
      this.TypeGraphElement()==GRAPH_ELEMENT_TYPE_FORM               ? CMessage::Text(MSG_GRAPH_ELEMENT_TYPE_FORM)               :
      this.TypeGraphElement()==GRAPH_ELEMENT_TYPE_WINDOW             ? CMessage::Text(MSG_GRAPH_ELEMENT_TYPE_WINDOW)             :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the graphical object affiliation       |
//+------------------------------------------------------------------+
string CGBaseObj::BelongDescription(void)
  {
   return
     (
      this.Belong()==GRAPH_OBJ_BELONG_PROGRAM      ? CMessage::Text(MSG_GRAPH_OBJ_BELONG_PROGRAM)     :
      this.Belong()==GRAPH_OBJ_BELONG_NO_PROGRAM   ? CMessage::Text(MSG_GRAPH_OBJ_BELONG_NO_PROGRAM)  :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the graphical object group             |
//+------------------------------------------------------------------+
string CGBaseObj::SpeciesDescription(void)
  {
   return
     (
      this.Species()==GRAPH_OBJ_SPECIES_LINES      ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SPECIES_LINES)      :
      this.Species()==GRAPH_OBJ_SPECIES_CHANNELS   ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SPECIES_CHANNELS)   :
      this.Species()==GRAPH_OBJ_SPECIES_GANN       ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SPECIES_GANN)       :
      this.Species()==GRAPH_OBJ_SPECIES_FIBO       ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SPECIES_FIBO)       :
      this.Species()==GRAPH_OBJ_SPECIES_ELLIOTT    ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SPECIES_ELLIOTT)    :
      this.Species()==GRAPH_OBJ_SPECIES_SHAPES     ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SPECIES_SHAPES)     :
      this.Species()==GRAPH_OBJ_SPECIES_ARROWS     ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SPECIES_ARROWS)     :
      this.Species()==GRAPH_OBJ_SPECIES_GRAPHICAL  ?  CMessage::Text(MSG_GRAPH_OBJ_PROP_SPECIES_GRAPHICAL)  :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
