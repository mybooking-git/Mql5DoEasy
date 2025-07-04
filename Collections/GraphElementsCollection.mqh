//+------------------------------------------------------------------+
//|                                      GraphElementsCollection.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "ListObj.mqh"
#include "..\Services\Select.mqh"
#include "..\Objects\Graph\Form.mqh"
#include "..\Objects\Graph\Standard\GStdVLineObj.mqh"
#include "..\Objects\Graph\Standard\GStdHLineObj.mqh"
#include "..\Objects\Graph\Standard\GStdTrendObj.mqh"
#include "..\Objects\Graph\Standard\GStdTrendByAngleObj.mqh"
#include "..\Objects\Graph\Standard\GStdCiclesObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowedLineObj.mqh"
#include "..\Objects\Graph\Standard\GStdChannelObj.mqh"
#include "..\Objects\Graph\Standard\GStdStdDevChannelObj.mqh"
#include "..\Objects\Graph\Standard\GStdRegressionObj.mqh"
#include "..\Objects\Graph\Standard\GStdPitchforkObj.mqh"
#include "..\Objects\Graph\Standard\GStdGannLineObj.mqh"
#include "..\Objects\Graph\Standard\GStdGannFanObj.mqh"
#include "..\Objects\Graph\Standard\GStdGannGridObj.mqh"
#include "..\Objects\Graph\Standard\GStdFiboObj.mqh"
#include "..\Objects\Graph\Standard\GStdFiboTimesObj.mqh"
#include "..\Objects\Graph\Standard\GStdFiboFanObj.mqh"
#include "..\Objects\Graph\Standard\GStdFiboArcObj.mqh"
#include "..\Objects\Graph\Standard\GStdFiboChannelObj.mqh"
#include "..\Objects\Graph\Standard\GStdExpansionObj.mqh"
#include "..\Objects\Graph\Standard\GStdElliotWave5Obj.mqh"
#include "..\Objects\Graph\Standard\GStdElliotWave3Obj.mqh"
#include "..\Objects\Graph\Standard\GStdRectangleObj.mqh"
#include "..\Objects\Graph\Standard\GStdTriangleObj.mqh"
#include "..\Objects\Graph\Standard\GStdEllipseObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowThumbUpObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowThumbDownObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowUpObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowDownObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowStopObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowCheckObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowLeftPriceObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowRightPriceObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowBuyObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowSellObj.mqh"
#include "..\Objects\Graph\Standard\GStdArrowObj.mqh"
#include "..\Objects\Graph\Standard\GStdTextObj.mqh"
#include "..\Objects\Graph\Standard\GStdLabelObj.mqh"
#include "..\Objects\Graph\Standard\GStdButtonObj.mqh"
#include "..\Objects\Graph\Standard\GStdChartObj.mqh"
#include "..\Objects\Graph\Standard\GStdBitmapObj.mqh"
#include "..\Objects\Graph\Standard\GStdBitmapLabelObj.mqh"
#include "..\Objects\Graph\Standard\GStdEditObj.mqh"
#include "..\Objects\Graph\Standard\GStdEventObj.mqh"
#include "..\Objects\Graph\Standard\GStdRectangleLabelObj.mqh"
//+------------------------------------------------------------------+
//| Chart object management class                                    |
//+------------------------------------------------------------------+
class CChartObjectsControl : public CObject
  {
private:
   CArrayObj         m_list_new_graph_obj;      // List of added graphical objects
   ENUM_TIMEFRAMES   m_chart_timeframe;         // Chart timeframe
   long              m_chart_id;                // Chart ID
   long              m_chart_id_main;           // Control program chart ID
   string            m_chart_symbol;            // Chart symbol
   bool              m_is_graph_obj_event;      // Event flag in the list of graphical objects
   int               m_total_objects;           // Number of graphical objects
   int               m_last_objects;            // Number of graphical objects during the previous check
   int               m_delta_graph_obj;         // Difference in the number of graphical objects compared to the previous check
   int               m_handle_ind;              // Event controller indicator handle
   string            m_name_ind;                // Short name of the event controller indicator
   string            m_name_program;            // Program name
   
//--- Return the name of the last graphical object added to the chart
   string            LastAddedGraphObjName(void);
//--- Set the permission to track mouse events and graphical objects
   void              SetMouseEvent(void);

public:
//--- Return the variable values
   ENUM_TIMEFRAMES   Timeframe(void)                           const { return this.m_chart_timeframe;    }
   long              ChartID(void)                             const { return this.m_chart_id;           }
   string            Symbol(void)                              const { return this.m_chart_symbol;       }
   bool              IsEvent(void)                             const { return this.m_is_graph_obj_event; }
   int               TotalObjects(void)                        const { return this.m_total_objects;      }
   int               Delta(void)                               const { return this.m_delta_graph_obj;    }
//--- Set the flags of scrolling the chart with the mouse, context menu and crosshairs tool for the chart
   void              SetChartTools(const bool flag);
   void              SetChartTools(const bool mouse_scroll,const bool context_menu,const bool crosshair_tool);
//--- Create a new standard (or extended) graphical object
   CGStdGraphObj    *CreateNewGraphObj(const ENUM_OBJECT obj_type,const string name,const bool extended);
//--- Return the list of newly added objects
   CArrayObj        *GetListNewAddedObj(void)                        { return &this.m_list_new_graph_obj;}
//--- Create the event control indicator
   bool              CreateEventControlInd(const long chart_id_main);
//--- Add the event control indicator to the chart
   bool              AddEventControlInd(void);
//--- Check the chart objects
   void              Refresh(void);
//--- Constructors
                     CChartObjectsControl(void)
                       { 
                        this.m_name_program=::MQLInfoString(MQL_PROGRAM_NAME);
                        this.m_chart_id=::ChartID();
                        this.m_chart_timeframe=(ENUM_TIMEFRAMES)::ChartPeriod(this.m_chart_id);
                        this.m_chart_symbol=::ChartSymbol(this.m_chart_id);
                        this.m_chart_id_main=::ChartID();
                        this.m_list_new_graph_obj.Clear();
                        this.m_list_new_graph_obj.Sort();
                        this.m_is_graph_obj_event=false;
                        this.m_total_objects=0;
                        this.m_last_objects=0;
                        this.m_delta_graph_obj=0;
                        this.m_name_ind="";
                        this.m_handle_ind=INVALID_HANDLE;
                        this.SetMouseEvent();
                       }
                     CChartObjectsControl(const long chart_id)
                       { 
                        this.m_name_program=::MQLInfoString(MQL_PROGRAM_NAME);
                        this.m_chart_timeframe=(ENUM_TIMEFRAMES)::ChartPeriod(chart_id);
                        this.m_chart_symbol=::ChartSymbol(chart_id);
                        this.m_chart_id_main=::ChartID();
                        this.m_list_new_graph_obj.Clear();
                        this.m_list_new_graph_obj.Sort();
                        this.m_chart_id=chart_id;
                        this.m_is_graph_obj_event=false;
                        this.m_total_objects=0;
                        this.m_last_objects=0;
                        this.m_delta_graph_obj=0;
                        this.m_name_ind="";
                        this.m_handle_ind=INVALID_HANDLE;
                        this.SetMouseEvent();
                       }
//--- Destructor
                     ~CChartObjectsControl()
                       {
                        ::ChartIndicatorDelete(this.ChartID(),0,this.m_name_ind);
                        ::IndicatorRelease(this.m_handle_ind);
                       }
                     
//--- Compare CChartObjectsControl objects by a chart ID (for sorting the list by an object property)
   virtual int       Compare(const CObject *node,const int mode=0) const
                       {
                        const CChartObjectsControl *obj_compared=node;
                        return(this.ChartID()>obj_compared.ChartID() ? 1 : this.ChartID()<obj_compared.ChartID() ? -1 : 0);
                       }

//--- Event handler
   void              OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam);

  };
//+------------------------------------------------------------------+
//| CChartObjectsControl: Set the permission for a chart             |
//| to track mouse and graphical object events for the chart         |
//+------------------------------------------------------------------+
void CChartObjectsControl::SetMouseEvent(void)
  {
   ::ChartSetInteger(this.ChartID(),CHART_EVENT_MOUSE_MOVE,true);
   ::ChartSetInteger(this.ChartID(),CHART_EVENT_MOUSE_WHEEL,true);
   ::ChartSetInteger(this.ChartID(),CHART_EVENT_OBJECT_CREATE,true);
   ::ChartSetInteger(this.ChartID(),CHART_EVENT_OBJECT_DELETE,true);
  }
//+------------------------------------------------------------------+
//| CChartObjectsControl: Set the flags of mouse wheel scrolling,    |
//| context menu and crosshairs tool                                 |
//+------------------------------------------------------------------+
void CChartObjectsControl::SetChartTools(const bool flag)
  {
   ::ChartSetInteger(this.ChartID(),CHART_MOUSE_SCROLL,flag);
   ::ChartSetInteger(this.ChartID(),CHART_CONTEXT_MENU,flag);
   ::ChartSetInteger(this.ChartID(),CHART_CROSSHAIR_TOOL,flag);
  }
//+------------------------------------------------------------------+
//| CChartObjectsControl: Set the flags of mouse wheel scrolling,    |
//| context menu and crosshairs tool                                 |
//+------------------------------------------------------------------+
void CChartObjectsControl::SetChartTools(const bool mouse_scroll,const bool context_menu,const bool crosshair_tool)
  {
   ::ChartSetInteger(this.ChartID(),CHART_MOUSE_SCROLL,mouse_scroll);
   ::ChartSetInteger(this.ChartID(),CHART_CONTEXT_MENU,context_menu);
   ::ChartSetInteger(this.ChartID(),CHART_CROSSHAIR_TOOL,crosshair_tool);
  }
//+------------------------------------------------------------------+
//| CChartObjectsControl: Check objects on a chart                   |
//+------------------------------------------------------------------+
void CChartObjectsControl::Refresh(void)
  {
//--- Clear the list of newly added objects
   this.m_list_new_graph_obj.Clear();
//--- Calculate the number of new objects on the chart
   this.m_total_objects=::ObjectsTotal(this.ChartID());
   this.m_delta_graph_obj=this.m_total_objects-this.m_last_objects;
   //--- If an object is added to the chart
   if(this.m_delta_graph_obj>0)
     {
      //--- Create the list of added graphical objects
      for(int i=0;i<this.m_delta_graph_obj;i++)
        {
         //--- Get the name of the last added object (if a single new object is added),
         //--- or a name from the terminal object list by index (if several objects have been added)
         string name=(this.m_delta_graph_obj==1 ? this.LastAddedGraphObjName() : ::ObjectName(this.m_chart_id,i));
         //--- Handle only non-programmatically created objects
         if(name==NULL || ::StringFind(name,this.m_name_program)>WRONG_VALUE)
            continue;
         //--- Create the object of the graphical object class corresponding to the added graphical object type
         ENUM_OBJECT type=(ENUM_OBJECT)::ObjectGetInteger(this.ChartID(),name,OBJPROP_TYPE);
         ENUM_OBJECT_DE_TYPE obj_type=ENUM_OBJECT_DE_TYPE(type+OBJECT_DE_TYPE_GSTD_OBJ+1);
         CGStdGraphObj *obj=this.CreateNewGraphObj(type,name,false);
         //--- If failed to create an object, inform of that and move on to the new iteration
         if(obj==NULL)
           {
            CMessage::ToLog(DFUN,MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ);
            continue;
           }
         //--- Set the object affiliation and add the created object to the list of new objects
         obj.SetBelong(GRAPH_OBJ_BELONG_NO_PROGRAM); 
         //--- If failed to add the object to the list, inform of that, remove the object and move on to the next iteration
         if(!this.m_list_new_graph_obj.Add(obj))
           {
            CMessage::ToLog(DFUN_ERR_LINE,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
            delete obj;
            continue;
           }
        }
      //--- Send events to the control program chart from the created list
      for(int i=0;i<this.m_list_new_graph_obj.Total();i++)
        {
         CGStdGraphObj *obj=this.m_list_new_graph_obj.At(i);
         if(obj==NULL)
            continue;
         //--- Send an event to the control program chart
         ::EventChartCustom(this.m_chart_id_main,GRAPH_OBJ_EVENT_CREATE,this.ChartID(),obj.TimeCreate(),obj.Name());
        }
     }
//--- save the index of the last added graphical object and the difference with the last check
   this.m_last_objects=this.m_total_objects;
   this.m_is_graph_obj_event=(bool)this.m_delta_graph_obj;
  }
//+------------------------------------------------------------------+
//| CChartObjectsControl:                                            |
//| Create a new standard graphical object                           |
//+------------------------------------------------------------------+
CGStdGraphObj *CChartObjectsControl::CreateNewGraphObj(const ENUM_OBJECT obj_type,const string name,const bool extended)
  {
   switch((int)obj_type)
     {
      //--- Lines
      case OBJ_VLINE             : return new CGStdVLineObj(this.ChartID(),name,extended);
      case OBJ_HLINE             : return new CGStdHLineObj(this.ChartID(),name,extended);
      case OBJ_TREND             : return new CGStdTrendObj(this.ChartID(),name,extended);
      case OBJ_TRENDBYANGLE      : return new CGStdTrendByAngleObj(this.ChartID(),name,extended);
      case OBJ_CYCLES            : return new CGStdCyclesObj(this.ChartID(),name,extended);
      case OBJ_ARROWED_LINE      : return new CGStdArrowedLineObj(this.ChartID(),name,extended);
      //--- Channels
      case OBJ_CHANNEL           : return new CGStdChannelObj(this.ChartID(),name,extended);
      case OBJ_STDDEVCHANNEL     : return new CGStdStdDevChannelObj(this.ChartID(),name,extended);
      case OBJ_REGRESSION        : return new CGStdRegressionObj(this.ChartID(),name,extended);
      case OBJ_PITCHFORK         : return new CGStdPitchforkObj(this.ChartID(),name,extended);
      //--- Gann
      case OBJ_GANNLINE          : return new CGStdGannLineObj(this.ChartID(),name,extended);
      case OBJ_GANNFAN           : return new CGStdGannFanObj(this.ChartID(),name,extended);
      case OBJ_GANNGRID          : return new CGStdGannGridObj(this.ChartID(),name,extended);
      //--- Fibo
      case OBJ_FIBO              : return new CGStdFiboObj(this.ChartID(),name,extended);
      case OBJ_FIBOTIMES         : return new CGStdFiboTimesObj(this.ChartID(),name,extended);
      case OBJ_FIBOFAN           : return new CGStdFiboFanObj(this.ChartID(),name,extended);
      case OBJ_FIBOARC           : return new CGStdFiboArcObj(this.ChartID(),name,extended);
      case OBJ_FIBOCHANNEL       : return new CGStdFiboChannelObj(this.ChartID(),name,extended);
      case OBJ_EXPANSION         : return new CGStdExpansionObj(this.ChartID(),name,extended);
      //--- Elliott
      case OBJ_ELLIOTWAVE5       : return new CGStdElliotWave5Obj(this.ChartID(),name,extended);
      case OBJ_ELLIOTWAVE3       : return new CGStdElliotWave3Obj(this.ChartID(),name,extended);
      //--- Shapes
      case OBJ_RECTANGLE         : return new CGStdRectangleObj(this.ChartID(),name,extended);
      case OBJ_TRIANGLE          : return new CGStdTriangleObj(this.ChartID(),name,extended);
      case OBJ_ELLIPSE           : return new CGStdEllipseObj(this.ChartID(),name,extended);
      //--- Arrows
      case OBJ_ARROW_THUMB_UP    : return new CGStdArrowThumbUpObj(this.ChartID(),name,extended);
      case OBJ_ARROW_THUMB_DOWN  : return new CGStdArrowThumbDownObj(this.ChartID(),name,extended);
      case OBJ_ARROW_UP          : return new CGStdArrowUpObj(this.ChartID(),name,extended);
      case OBJ_ARROW_DOWN        : return new CGStdArrowDownObj(this.ChartID(),name,extended);
      case OBJ_ARROW_STOP        : return new CGStdArrowStopObj(this.ChartID(),name,extended);
      case OBJ_ARROW_CHECK       : return new CGStdArrowCheckObj(this.ChartID(),name,extended);
      case OBJ_ARROW_LEFT_PRICE  : return new CGStdArrowLeftPriceObj(this.ChartID(),name,extended);
      case OBJ_ARROW_RIGHT_PRICE : return new CGStdArrowRightPriceObj(this.ChartID(),name,extended);
      case OBJ_ARROW_BUY         : return new CGStdArrowBuyObj(this.ChartID(),name,extended);
      case OBJ_ARROW_SELL        : return new CGStdArrowSellObj(this.ChartID(),name,extended);
      case OBJ_ARROW             : return new CGStdArrowObj(this.ChartID(),name,extended);
      //--- Graphical objects
      case OBJ_TEXT              : return new CGStdTextObj(this.ChartID(),name,extended);
      case OBJ_LABEL             : return new CGStdLabelObj(this.ChartID(),name,extended);
      case OBJ_BUTTON            : return new CGStdButtonObj(this.ChartID(),name,extended);
      case OBJ_CHART             : return new CGStdChartObj(this.ChartID(),name,extended);
      case OBJ_BITMAP            : return new CGStdBitmapObj(this.ChartID(),name,extended);
      case OBJ_BITMAP_LABEL      : return new CGStdBitmapLabelObj(this.ChartID(),name,extended);
      case OBJ_EDIT              : return new CGStdEditObj(this.ChartID(),name,extended);
      case OBJ_EVENT             : return new CGStdEventObj(this.ChartID(),name,extended);
      case OBJ_RECTANGLE_LABEL   : return new CGStdRectangleLabelObj(this.ChartID(),name,extended);
      default                    : return NULL;
     }
  }
//+------------------------------------------------------------------+
//| CChartObjectsControl:                                            |
//| Return the name of the last graphical object                     |
//| added to the chart (th object becomes selected)                  |
//+------------------------------------------------------------------+
string CChartObjectsControl::LastAddedGraphObjName(void)
  {
   int index=0;
   datetime time=0;
   for(int i=0;i<this.m_total_objects;i++)
     {
      string name=::ObjectName(this.ChartID(),i);
      datetime tm=(datetime)::ObjectGetInteger(this.ChartID(),name,OBJPROP_CREATETIME);
      if(tm>time)
        {
         time=tm;
         index=i;
        }
     }
   return ::ObjectName(this.ChartID(),index);
  }
//+------------------------------------------------------------------+
//| CChartObjectsControl: Create the event control indicator         |
//+------------------------------------------------------------------+
bool CChartObjectsControl::CreateEventControlInd(const long chart_id_main)
  {
   this.m_chart_id_main=chart_id_main;
   string name="::"+PATH_TO_EVENT_CTRL_IND;
   ::ResetLastError();
   this.m_handle_ind=::iCustom(this.Symbol(),this.Timeframe(),name,this.ChartID(),this.m_chart_id_main);
   if(this.m_handle_ind==INVALID_HANDLE)
     {
      CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_CREATE_EVN_CTRL_INDICATOR);
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
   this.m_name_ind="EventSend_From#"+(string)this.ChartID()+"_To#"+(string)this.m_chart_id_main;
   ::Print
     (
      DFUN,this.Symbol()," ",TimeframeDescription(this.Timeframe()),": ",
      CMessage::Text(MSG_GRAPH_OBJ_CREATE_EVN_CTRL_INDICATOR)," \"",this.m_name_ind,"\""
     );
   return true;
  }
//+------------------------------------------------------------------+
//|CChartObjectsControl: Add the event control indicator to the chart|
//+------------------------------------------------------------------+
bool CChartObjectsControl::AddEventControlInd(void)
  {
   if(this.m_handle_ind==INVALID_HANDLE)
      return false;
   ::ResetLastError();
   string shortname="EventSend_From#"+(string)this.ChartID()+"_To#"+(string)this.m_chart_id_main;
   int total=::ChartIndicatorsTotal(this.ChartID(),0);
   for(int i=0;i<total;i++)
      if(::ChartIndicatorName(this.ChartID(),0,i)==shortname)
        {
         CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_ALREADY_EXIST_EVN_CTRL_INDICATOR);
         return true;
        }
   return ::ChartIndicatorAdd(this.ChartID(),0,this.m_handle_ind);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Collection of graphical objects                                  |
//+------------------------------------------------------------------+
#resource "\\"+PATH_TO_EVENT_CTRL_IND;          // Indicator for controlling graphical object events packed into the program resources
class CGraphElementsCollection : public CBaseObj
  {
private:
   //--- Pivot point data structure
   struct SDataPivotPoint
     {
      public:
         int         X;                         // Pivot point X coordinate
         int         Y;                         // Pivot point Y coordinate
         int         ShiftX;                    // Pivot point X coordinate shift from the central one
         int         ShiftY;                    // Pivot point Y coordinate shift from the central one
     };
   SDataPivotPoint   m_data_pivot_point[];      // Pivot point data structure array
   CArrayObj         m_list_charts_control;     // List of chart management objects
   CListObj          m_list_all_canv_elm_obj;   // List of all graphical elements on canvas
   CListObj          m_list_all_graph_obj;      // List of all graphical objects
   CArrayObj         m_list_deleted_obj;        // List of removed graphical objects
   CMouseState       m_mouse;                   // "Mouse status" class object
   bool              m_is_graph_obj_event;      // Event flag in the list of graphical objects
   int               m_total_objects;           // Number of graphical objects
   int               m_delta_graph_obj;         // Difference in the number of graphical objects compared to the previous check
   
//--- Return the flag indicating the graphical element class object presence in the collection list of graphical elements
   bool              IsPresentCanvElmInList(const long chart_id,const string name);
//--- Return the flag indicating the presence of the graphical object class in the graphical object collection list
   bool              IsPresentGraphObjInList(const long chart_id,const string name);
//--- Return the flag indicating the presence of a graphical object on a chart by name
   bool              IsPresentGraphObjOnChart(const long chart_id,const string name);
//--- Return the pointer to the object of managing objects of the specified chart
   CChartObjectsControl *GetChartObjectCtrlObj(const long chart_id);
//--- Create a new object of managing graphical objects of a specified chart and add it to the list
   CChartObjectsControl *CreateChartObjectCtrlObj(const long chart_id);
//--- Update the list of graphical objects by chart ID
   CChartObjectsControl *RefreshByChartID(const long chart_id);
//--- Check if the chart window is present
   bool              IsPresentChartWindow(const long chart_id);
//--- Handle removing the chart window
   void              RefreshForExtraObjects(void);
//--- Return the first free ID of the graphical (1) object and (2) element on canvas
   long              GetFreeGraphObjID(bool program_object);
   long              GetFreeCanvElmID(void);
//--- Add (1) the standard graphical object and (2) the graphical element on canvas to the collection
   bool              AddGraphObjToCollection(const string source,CChartObjectsControl *obj_control);
//--- Return the pointer to the form located under the cursor
   CForm            *GetFormUnderCursor(const int id, 
                                        const long &lparam, 
                                        const double &dparam, 
                                        const string &sparam,
                                        ENUM_MOUSE_FORM_STATE &mouse_state,
                                        long &obj_ext_id,
                                        int &form_index);
//--- Reset all interaction flags for all forms except the specified one
   void              ResetAllInteractionExeptOne(CForm *form);
public:
   bool              AddCanvElmToCollection(CGCnvElement *element);
   
private:
//--- Find an object present in the collection but not on a chart
   CGStdGraphObj    *FindMissingObj(const long chart_id);
   CGStdGraphObj    *FindMissingObj(const long chart_id,int &index);
//--- Find the graphical object present on a chart but not in the collection
   string            FindExtraObj(const long chart_id);
//--- Remove the graphical object class object from the graphical object collection list: (1) specified object, (2) by chart ID
   bool              DeleteGraphObjFromList(CGStdGraphObj *obj);
   void              DeleteGraphObjectsFromList(const long chart_id);
//--- Move the graphical object class object to the list of removed graphical objects: (1) specified object, (2) by index
   bool              MoveGraphObjToDeletedObjList(CGStdGraphObj *obj);
   bool              MoveGraphObjToDeletedObjList(const int index);
//--- Move all objects by chart ID to the list of removed graphical objects
   void              MoveGraphObjectsToDeletedObjList(const long chart_id);
//--- Remove the object of managing charts from the list
   bool              DeleteGraphObjCtrlObjFromList(CChartObjectsControl *obj);
//--- Set the flags of scrolling the chart with the mouse, context menu and crosshairs tool for the specified chart
   void              SetChartTools(const long chart_id,const bool flag);
//--- Return the screen coordinates of each pivot point of the graphical object
   bool              GetPivotPointCoordsAll(CGStdGraphObj *obj,SDataPivotPoint &array_pivots[]);
public:
//--- Return itself
   CGraphElementsCollection *GetObject(void)                                                             { return &this;                        }
//--- Return the full collection list of standard graphical objects "as is"
   CArrayObj        *GetListGraphObj(void)                                                               { return &this.m_list_all_graph_obj;   }
//--- Return the full collection list of graphical elements on canvas "as is"
   CArrayObj        *GetListCanvElm(void)                                                                { return &this.m_list_all_canv_elm_obj;}
//--- Return the list of graphical elements by a selected (1) integer, (2) real and (3) string properties meeting the compared criterion
   CArrayObj        *GetList(ENUM_CANV_ELEMENT_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode=EQUAL)             { return CSelect::ByGraphCanvElementProperty(this.GetListCanvElm(),property,value,mode);           }
   CArrayObj        *GetList(ENUM_CANV_ELEMENT_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode=EQUAL)            { return CSelect::ByGraphCanvElementProperty(this.GetListCanvElm(),property,value,mode);           }
   CArrayObj        *GetList(ENUM_CANV_ELEMENT_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode=EQUAL)            { return CSelect::ByGraphCanvElementProperty(this.GetListCanvElm(),property,value,mode);           }
//--- Return the list of existing graphical objects by a selected (1) integer, (2) real and (3) string properties meeting the compared criterion
   CArrayObj        *GetList(ENUM_GRAPH_OBJ_PROP_INTEGER property,int index,long value,ENUM_COMPARER_TYPE mode=EQUAL)      { return CSelect::ByGraphicStdObjectProperty(this.GetListGraphObj(),property,index,value,mode);    }
   CArrayObj        *GetList(ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index,double value,ENUM_COMPARER_TYPE mode=EQUAL)     { return CSelect::ByGraphicStdObjectProperty(this.GetListGraphObj(),property,index,value,mode);    }
   CArrayObj        *GetList(ENUM_GRAPH_OBJ_PROP_STRING property,int index,string value,ENUM_COMPARER_TYPE mode=EQUAL)     { return CSelect::ByGraphicStdObjectProperty(this.GetListGraphObj(),property,index,value,mode);    }
//--- Return the list of removed graphical objects by a selected (1) integer, (2) real and (3) string properties meeting the compared criterion
   CArrayObj        *GetListDel(ENUM_GRAPH_OBJ_PROP_INTEGER property,int index,long value,ENUM_COMPARER_TYPE mode=EQUAL)   { return CSelect::ByGraphicStdObjectProperty(this.GetListDeletedObj(),property,index,value,mode);  }
   CArrayObj        *GetListDel(ENUM_GRAPH_OBJ_PROP_DOUBLE property,int index,double value,ENUM_COMPARER_TYPE mode=EQUAL)  { return CSelect::ByGraphicStdObjectProperty(this.GetListDeletedObj(),property,index,value,mode);  }
   CArrayObj        *GetListDel(ENUM_GRAPH_OBJ_PROP_STRING property,int index,string value,ENUM_COMPARER_TYPE mode=EQUAL)  { return CSelect::ByGraphicStdObjectProperty(this.GetListDeletedObj(),property,index,value,mode);  }
//--- Return the number of new graphical objects, (3) the flag of the occurred change in the list of graphical objects
   int               NewObjects(void)   const                                                            { return this.m_delta_graph_obj;       }
   bool              IsEvent(void) const                                                                 { return this.m_is_graph_obj_event;    }
//--- Return an (1) existing and (2) removed graphical object by chart name and ID
   CGStdGraphObj    *GetStdGraphObject(const string name,const long chart_id);
   CGStdGraphObj    *GetStdDelGraphObject(const string name,const long chart_id);
//--- Return the existing (1) extended and (2) standard graphical object by its ID
   CGStdGraphObj    *GetStdGraphObjectExt(const long id,const long chart_id);
   CGStdGraphObj    *GetStdGraphObject(const long id,const long chart_id);
//--- Return the list of (1) chart management objects and (2) removed graphical objects
   CArrayObj        *GetListChartsControl(void)                                                          { return &this.m_list_charts_control;  }
   CArrayObj        *GetListDeletedObj(void)                                                             { return &this.m_list_deleted_obj;     }
//--- Return the list of (1) standard and (2) extended graphical objects
   CArrayObj        *GetListStdGraphObject(void)                              { return CSelect::ByGraphicStdObjectProperty(this.GetListGraphObj(),GRAPH_OBJ_PROP_ELEMENT_TYPE,0,GRAPH_ELEMENT_TYPE_STANDARD,EQUAL);           }
   CArrayObj        *GetListStdGraphObjectExt(void)                           { return CSelect::ByGraphicStdObjectProperty(this.GetListGraphObj(),GRAPH_OBJ_PROP_ELEMENT_TYPE,0,GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED,EQUAL);  }
//--- Return (1) the last removed graphical object and (2) the array size of graphical object properties
   CGStdGraphObj    *GetLastDeletedGraphObj(void)                 const { return this.m_list_deleted_obj.At(this.m_list_deleted_obj.Total()-1); }
   int               GetSizeProperty(const string name,const long chart_id,const int prop)
                       {
                        CGStdGraphObj *obj=this.GetStdGraphObject(name,chart_id);
                        return(obj!=NULL ? obj.Properties().CurrSize(prop) : 0);
                       }
//--- Return the list of objects by chart ID and group
   CArrayObj        *GetListStdGraphObjByGroup(const long chart_id,const int group)
                       {
                        CArrayObj *list=GetList(GRAPH_OBJ_PROP_CHART_ID,0,chart_id,EQUAL);
                        return CSelect::ByGraphicStdObjectProperty(list,GRAPH_OBJ_PROP_GROUP,0,group,EQUAL);
                       }
   
//--- Constructor
                     CGraphElementsCollection();
//--- Display the description of the object properties in the journal (full_prop=true - all properties, false - supported ones only - implemented in descendant classes)
   virtual void      Print(const bool full_prop=false,const bool dash=false);
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
//--- Display the history of renaming the object to the journal
   void              PrintRenameHistory(const string name,const long chart_id);

//--- Create the list of chart management objects and return the number of charts
   int               CreateChartControlList(void);
//--- Update the list of (1) all graphical objects, (2) on the specified chart, fill in the data on the number of new ones and set the event flag
   void              Refresh(void);
   void              Refresh(const long chart_id);
//--- Event handler
   void              OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam);

private:
//--- Move all objects on canvas to the foreground
   void              BringToTopAllCanvElm(void);
//--- (1) Return the maximum ZOrder of all CCanvas elements,
//--- (2) Set ZOrde to the specified element and adjust it in all the remaining elements
   long              GetZOrderMax(void);
   bool              SetZOrderMAX(CGCnvElement *obj);
//--- Handle the removal of extended graphical objects
   void              DeleteExtendedObj(CGStdGraphObj *obj);
//--- Create a new graphical object, return the pointer to the chart management object
   CChartObjectsControl *CreateNewStdGraphObjectAndGetCtrlObj(const long chart_id,
                                                              const string name,
                                                              int subwindow,
                                                              const ENUM_OBJECT type_object,
                                                              const datetime time1,
                                                              const double price1,
                                                              const datetime time2=0,
                                                              const double price2=0,
                                                              const datetime time3=0,
                                                              const double price3=0,
                                                              const datetime time4=0,
                                                              const double price4=0,
                                                              const datetime time5=0,
                                                              const double price5=0)
                       {
                        //--- If an object with a chart ID and name is already present in the collection, inform of that and return NULL
                        if(this.IsPresentGraphObjInList(chart_id,name))
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_ELM_COLLECTION_ERR_GR_OBJ_ALREADY_EXISTS)," ChartID ",(string)chart_id,", ",name);
                           return NULL;
                          }
                        //--- If failed to create a new standard graphical object, inform of that and return NULL
                        if(!CreateNewStdGraphObject(chart_id,name,type_object,subwindow,time1,price1,time2,price2,time3,price3,time4,price4,time5,price5))
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_STD_GRAPH_OBJ),StdGraphObjectTypeDescription(type_object));
                           CMessage::ToLog(::GetLastError(),true);
                           return NULL;
                          }
                        //--- If failed to get a chart management object, inform of that
                        CChartObjectsControl *ctrl=this.GetChartObjectCtrlObj(chart_id);
                        if(ctrl==NULL)
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_ELM_COLLECTION_ERR_FAILED_GET_CTRL_OBJ),(string)chart_id);
                        //--- Return the pointer to a chart management object or NULL in case of a failed attempt to get it
                        return ctrl;
                       }
//--- Add a newly created standard graphical object to the list
   bool              AddCreatedObjToList(const string source,const long chart_id,const string name,CGStdGraphObj *obj)
                       {
                        if(!this.m_list_all_graph_obj.Add(obj))
                          {
                           CMessage::ToLog(source,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
                           ::ObjectDelete(chart_id,name);
                           delete obj;
                           return false;
                          }
                        //--- Move all the forms above the created object on the chart and redraw the chart
                        this.BringToTopAllCanvElm();
                        ::ChartRedraw(chart_id);
                        return true;
                       }
public:
//--- Create the "Vertical line" graphical object
   bool              CreateLineVertical(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time)
                       {
                        //--- Set the name and type of a created object
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_VLINE;
                        //--- Create a new graphical object and get the pointer to the chart management object
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,0);
                        if(ctrl==NULL)
                           return false;
                        //--- Create a new class object corresponding to the newly created graphical object
                        CGStdVLineObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Horizontal line" graphical object
   bool              CreateLineHorizontal(const long chart_id,const string name,const int subwindow,const bool extended,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_HLINE;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,0,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdHLineObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }
 
//--- Create the "Trend line" graphical object
   bool              CreateLineTrend(const long chart_id,const string name,const int subwindow,const bool extended,
                                     const datetime time1,const double price1,const datetime time2,const double price2)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_TREND;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdTrendObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }
//--- Create the "Trend line by angle" graphical object
   bool              CreateLineTrendByAngle(const long chart_id,const string name,const int subwindow,const bool extended,
                                            const datetime time1,const double price1,const datetime time2,const double price2,const double angle)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_TRENDBYANGLE;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdTrendByAngleObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetAngle(angle);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Cyclic lines" graphical object
   bool              CreateLineCycle(const long chart_id,const string name,const int subwindow,const bool extended,
                                     const datetime time1,const double price1,const datetime time2,const double price2)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_CYCLES;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdCyclesObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Arrowed line" graphical object
   bool              CreateLineArrowed(const long chart_id,const string name,const int subwindow,const bool extended,
                                       const datetime time1,const double price1,const datetime time2,const double price2)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROWED_LINE;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowedLineObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Equidistant channel" graphical object
   bool              CreateChannel(const long chart_id,const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,double price2,const datetime time3,const double price3)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_CHANNEL;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2,time3,price3);
                        if(ctrl==NULL)
                           return false;
                        CGStdChannelObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Standard deviation channel" graphical object
   bool              CreateChannelStdDeviation(const long chart_id,const string name,const int subwindow,const bool extended,
                                               const datetime time1,const double price1,const datetime time2,const double price2,const double deviation=1.5)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_STDDEVCHANNEL;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdStdDevChannelObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetDeviation(deviation);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Linear regression channel" graphical object
   bool              CreateChannelRegression(const long chart_id,const string name,const int subwindow,const bool extended,
                                             const datetime time1,const double price1,const datetime time2,const double price2)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_REGRESSION;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdRegressionObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Andrews' Pitchfork" graphical object
   bool              CreatePitchforkAndrews(const long chart_id,const string name,const int subwindow,const bool extended,
                                            const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_PITCHFORK;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2,time3,price3);
                        if(ctrl==NULL)
                           return false;
                        CGStdPitchforkObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Gann line" graphical object
   bool              CreateGannLine(const long chart_id,const string name,const int subwindow,const bool extended,
                                    const datetime time1,const double price1,const datetime time2,const double price2,const double angle)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_GANNLINE;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdGannLineObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetAngle(angle);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Gann fan" graphical object
   bool              CreateGannFan(const long chart_id,const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,
                                   const ENUM_GANN_DIRECTION direction,const double scale)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_GANNFAN;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdGannFanObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetDirection(direction);
                        obj.SetScale(scale);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Gann grid" graphical object
   bool              CreateGannGrid(const long chart_id,const string name,const int subwindow,const bool extended,
                                    const datetime time1,const double price1,const datetime time2,const ENUM_GANN_DIRECTION direction,const double scale)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_GANNGRID;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2);
                        if(ctrl==NULL)
                           return false;
                        CGStdGannGridObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetDirection(direction);
                        obj.SetScale(scale);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Fibo levels" graphical object
   bool              CreateFiboLevels(const long chart_id,const string name,const int subwindow,const bool extended,
                                      const datetime time1,const double price1,const datetime time2,const double price2)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_FIBO;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdFiboObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Fibo Time Zones" graphical object
   bool              CreateFiboTimeZones(const long chart_id,const string name,const int subwindow,const bool extended,
                                         const datetime time1,const double price1,const datetime time2,const double price2)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_FIBOTIMES;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdFiboTimesObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Fibo fan" graphical object
   bool              CreateFiboFan(const long chart_id,const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_FIBOFAN;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdFiboFanObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Fibo arc" graphical object
   bool              CreateFiboArc(const long chart_id,const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,
                                   const double scale,const bool ellipse)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_FIBOARC;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdFiboArcObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetScale(scale);
                        obj.SetFlagEllipse(ellipse);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Fibo channel" graphical object
   bool              CreateFiboChannel(const long chart_id,const string name,const int subwindow,const bool extended,
                                       const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_FIBOCHANNEL;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2,time3,price3);
                        if(ctrl==NULL)
                           return false;
                        CGStdFiboChannelObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }
//--- Create the "Fibo extension" graphical object
   bool              CreateFiboExpansion(const long chart_id,const string name,const int subwindow,const bool extended,
                                         const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_EXPANSION;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2,time3,price3);
                        if(ctrl==NULL)
                           return false;
                        CGStdExpansionObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Elliott 5 waves" graphical object
   bool              CreateElliothWave5(const long chart_id,const string name,const int subwindow,const bool extended,
                                        const datetime time1,const double price1,const datetime time2,const double price2,
                                        const datetime time3,const double price3,const datetime time4,const double price4,
                                        const datetime time5,const double price5,const ENUM_ELLIOT_WAVE_DEGREE degree,
                                        const bool draw_lines)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ELLIOTWAVE5;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2,time3,price3,time4,price4,time5,price5);
                        if(ctrl==NULL)
                           return false;
                        CGStdElliotWave5Obj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetDegree(degree);
                        obj.SetFlagDrawLines(draw_lines);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Elliott 3 waves" graphical object
   bool              CreateElliothWave3(const long chart_id,const string name,const int subwindow,const bool extended,
                                        const datetime time1,const double price1,const datetime time2,const double price2,
                                        const datetime time3,const double price3,const ENUM_ELLIOT_WAVE_DEGREE degree,const bool draw_lines)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ELLIOTWAVE3;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2,time3,price3);
                        if(ctrl==NULL)
                           return false;
                        CGStdElliotWave3Obj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetDegree(degree);
                        obj.SetFlagDrawLines(draw_lines);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the Rectangle graphical object
   bool              CreateRectangle(const long chart_id,const string name,const int subwindow,const bool extended,
                                     const datetime time1,const double price1,const datetime time2,const double price2)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_RECTANGLE;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2);
                        if(ctrl==NULL)
                           return false;
                        CGStdRectangleObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the Triangle graphical object
   bool              CreateTriangle(const long chart_id,const string name,const int subwindow,const bool extended,
                                    const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_TRIANGLE;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2,time3,price3);
                        if(ctrl==NULL)
                           return false;
                        CGStdTriangleObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the Ellipse graphical object
   bool              CreateEllipse(const long chart_id,const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ELLIPSE;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time1,price1,time2,price2,time3,price3);
                        if(ctrl==NULL)
                           return false;
                        CGStdEllipseObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Thumb up" graphical object
   bool              CreateThumbUp(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW_THUMB_UP;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowThumbUpObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Thumb down" graphical object
   bool              CreateThumbDown(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW_THUMB_DOWN;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowThumbDownObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Arrow up" graphical object
   bool              CreateArrowUp(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW_UP;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowUpObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Arrow down" graphical object
   bool              CreateArrowDown(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW_DOWN;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowDownObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the Stop graphical object
   bool              CreateSignalStop(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW_STOP;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowStopObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Check mark" graphical object
   bool              CreateSignalCheck(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW_CHECK;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowCheckObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Left price label" graphical object
   bool              CreatePriceLabelLeft(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW_LEFT_PRICE;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowLeftPriceObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Right price label" graphical object
   bool              CreatePriceLabelRight(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW_RIGHT_PRICE;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowRightPriceObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the Buy graphical object
   bool              CreateSignalBuy(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW_BUY;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowBuyObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the Sell graphical object
   bool              CreateSignalSell(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW_SELL;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowSellObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the Arrow graphical object
   bool              CreateArrow(const long chart_id,const string name,const int subwindow,const bool extended,
                                 const datetime time,const double price,const uchar arrow_code,const ENUM_ARROW_ANCHOR anchor)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_ARROW;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdArrowObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetArrowCode(arrow_code);
                        obj.SetAnchor(anchor);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }
//--- Create the Text graphical object
   bool              CreateText(const long chart_id,const string name,const int subwindow,const bool extended,
                                const datetime time,const double price,const string text,const int size,const ENUM_ANCHOR_POINT anchor_point,const double angle)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_TEXT;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdTextObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetText(text);
                        obj.SetFontSize(size);
                        obj.SetAnchor(anchor_point);
                        obj.SetAngle(angle);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Text label" graphical object
   bool              CreateTextLabel(const long chart_id,const string name,const int subwindow,const bool extended,
                                     const int x,const int y,
                                     const string text,const int size,const ENUM_BASE_CORNER corner,
                                     const ENUM_ANCHOR_POINT anchor_point,const double angle)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_LABEL;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,0,0);
                        if(ctrl==NULL)
                           return false;
                        CGStdLabelObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetXDistance(x);
                        obj.SetYDistance(y);
                        obj.SetText(text);
                        obj.SetFontSize(size);
                        obj.SetCorner(corner);
                        obj.SetAnchor(anchor_point);
                        obj.SetAngle(angle);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the Button graphical object
   bool              CreateButton(const long chart_id,const string name,const int subwindow,const bool extended,
                                  const int x,const int y,const int w,const int h,const ENUM_BASE_CORNER corner,const int font_size,const bool button_state)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_BUTTON;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,0,0);
                        if(ctrl==NULL)
                           return false;
                        CGStdButtonObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetXDistance(x);
                        obj.SetYDistance(y);
                        obj.SetXSize(w);
                        obj.SetYSize(h);
                        obj.SetCorner(corner);
                        obj.SetFontSize(font_size);
                        obj.SetFlagState(button_state);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the Chart graphical object
   bool              CreateChart(const long chart_id,const string name,const int subwindow,const bool extended,
                                 const int x,const int y,const int w,const int h,
                                 const ENUM_BASE_CORNER corner,const int scale,const string symbol,const ENUM_TIMEFRAMES timeframe)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_CHART;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,0,0);
                        if(ctrl==NULL)
                           return false;
                        CGStdChartObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        obj.SetXDistance(x);
                        obj.SetYDistance(y);
                        obj.SetXSize(w);
                        obj.SetYSize(h);
                        obj.SetCorner(corner);
                        obj.SetChartObjChartScale(scale);
                        obj.SetChartObjSymbol(symbol);
                        obj.SetChartObjPeriod(timeframe);
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the Bitmap graphical object
   bool              CreateBitmap(const long chart_id,const string name,const int subwindow,const bool extended,
                                  const datetime time,const double price,const string image1,const string image2,const ENUM_ANCHOR_POINT anchor)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_BITMAP;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,price);
                        if(ctrl==NULL)
                           return false;
                        CGStdBitmapObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetAnchor(anchor);
                        obj.SetBMPFile(image1,0);
                        obj.SetBMPFile(image2,1);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Bitmap label" graphical object
   bool              CreateBitmapLabel(const long chart_id,const string name,const int subwindow,const bool extended,
                                       const int x,const int y,const int w,const int h,
                                       const string image1,const string image2,const ENUM_BASE_CORNER corner,const ENUM_ANCHOR_POINT anchor,const bool state)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_BITMAP_LABEL;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,0,0);
                        if(ctrl==NULL)
                           return false;
                        CGStdBitmapLabelObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetXDistance(x);
                        obj.SetYDistance(y);
                        obj.SetXSize(w);
                        obj.SetYSize(h);
                        obj.SetCorner(corner);
                        obj.SetAnchor(anchor);
                        obj.SetBMPFile(image1,0);
                        obj.SetBMPFile(image2,1);
                        obj.SetFlagState(state);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Input field" graphical object
   bool              CreateEditField(const long chart_id,const string name,const int subwindow,const bool extended,
                                     const int x,const int y,const int w,const int h,
                                     const int font_size,const ENUM_BASE_CORNER corner,const ENUM_ALIGN_MODE align,const bool readonly)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_EDIT;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,0,0);
                        if(ctrl==NULL)
                           return false;
                        CGStdEditObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetXDistance(x);
                        obj.SetYDistance(y);
                        obj.SetXSize(w);
                        obj.SetYSize(h);
                        obj.SetFontSize(font_size);
                        obj.SetCorner(corner);
                        obj.SetAlign(align);
                        obj.SetFlagReadOnly(readonly);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Economic calendar event" graphical object
   bool              CreateCalendarEvent(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_EVENT;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,time,0);
                        if(ctrl==NULL)
                           return false;
                        CGStdEventObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }

//--- Create the "Rectangular label" graphical object
   bool              CreateRectangleLabel(const long chart_id,const string name,const int subwindow,const bool extended,
                                          const int x,const int y,const int w,const int h,const ENUM_BASE_CORNER corner,const ENUM_BORDER_TYPE border)
                       {
                        string nm=this.m_name_program+"_"+name;
                        ENUM_OBJECT type_object=OBJ_RECTANGLE_LABEL;
                        CChartObjectsControl *ctrl=this.CreateNewStdGraphObjectAndGetCtrlObj(chart_id,nm,subwindow,type_object,0,0);
                        if(ctrl==NULL)
                           return false;
                        CGStdRectangleLabelObj *obj=ctrl.CreateNewGraphObj(type_object,nm,extended);
                        if(obj==NULL)
                          {
                           ::Print(DFUN,CMessage::Text(MSG_GRAPH_STD_OBJ_ERR_FAILED_CREATE_CLASS_OBJ),StdGraphObjectTypeDescription(type_object));
                           return false;
                          }
                        //--- Set the necessary minimal parameters for an object
                        obj.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);
                        obj.SetFlagSelected(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : obj.Selected(),false);
                        obj.SetFlagSelectable(obj.GraphElementType()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED ? false : true,false);
                        obj.SetObjectID(this.GetFreeGraphObjID(true));
                        obj.SetXDistance(x);
                        obj.SetYDistance(y);
                        obj.SetXSize(w);
                        obj.SetYSize(h);
                        obj.SetCorner(corner);
                        obj.SetBorderType(border);
                        obj.PropertiesCopyToPrevData();
                        //--- Return the result of adding the object to the list
                        return this.AddCreatedObjToList(DFUN,chart_id,nm,obj);
                       }
 
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CGraphElementsCollection::CGraphElementsCollection()
  {
   this.m_type=COLLECTION_GRAPH_OBJ_ID;
   ::ChartSetInteger(::ChartID(),CHART_EVENT_MOUSE_MOVE,true);
   ::ChartSetInteger(::ChartID(),CHART_EVENT_MOUSE_WHEEL,true);
   this.m_list_all_graph_obj.Type(COLLECTION_GRAPH_OBJ_ID);
   this.m_list_all_graph_obj.Sort(SORT_BY_CANV_ELEMENT_ID);
   this.m_list_all_graph_obj.Clear();
   this.m_list_charts_control.Sort();
   this.m_list_charts_control.Clear();
   this.m_total_objects=0;
   this.m_is_graph_obj_event=false;
   this.m_list_deleted_obj.Clear();
   this.m_list_deleted_obj.Sort();
  }
//+------------------------------------------------------------------+
//| Create a new graphical object management object                  |
//| for a specified and add it to the list                           |
//+------------------------------------------------------------------+
CChartObjectsControl *CGraphElementsCollection::CreateChartObjectCtrlObj(const long chart_id)
  {
//--- Create a new object for managing chart objects by ID
   CChartObjectsControl *obj=new CChartObjectsControl(chart_id);
//--- If the object is not created, inform of the error and return NULL
   if(obj==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_GRAPH_ELM_COLLECTION_ERR_FAILED_CREATE_CTRL_OBJ),(string)chart_id);
      return NULL;
     }
//--- If failed to add the object to the list, inform of the error, remove the object and return NULL
   if(!this.m_list_charts_control.Add(obj))
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
      delete obj;
      return NULL;
     }
   if(obj.ChartID()!=CBaseObj::GetMainChartID() && obj.CreateEventControlInd(CBaseObj::GetMainChartID()))
      if(!obj.AddEventControlInd())
        {
         CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_ADD_EVN_CTRL_INDICATOR);
         CMessage::ToLog(DFUN,::GetLastError(),true);
        }
      else
         ::Print(DFUN,CMessage::Text(MSG_GRAPH_OBJ_ADDED_EVN_CTRL_INDICATOR),obj.Symbol()," #",obj.ChartID());
//--- Return the pointer to the object that was created and added to the list
   return obj;
  }
//+------------------------------------------------------------------+
//| Return the pointer to the object                                 |
//| for managing objects of a specified chart                        |
//+------------------------------------------------------------------+
CChartObjectsControl *CGraphElementsCollection::GetChartObjectCtrlObj(const long chart_id)
  {
//--- In the loop by the total number of objects in the list
   for(int i=0;i<this.m_list_charts_control.Total();i++)
     {
      //--- Get the pointer to the next object
      CChartObjectsControl *obj=this.m_list_charts_control.At(i);
      //--- If failed to get the pointer, move on to the next one
      if(obj==NULL)
         continue;
      //--- If the object chart ID is equal to the required one, return the pointer to the object in the list
      if(obj.ChartID()==chart_id)
         return obj;
     }
//--- Failed to find the object - return NULL
   return NULL;
  }
//+------------------------------------------------------------------+
//| Create the list of chart management objects                      |
//+------------------------------------------------------------------+
int CGraphElementsCollection::CreateChartControlList(void)
  {
   //--- Clear the list of chart management objects and set the sorted list flag to it
   this.m_list_charts_control.Clear();
   this.m_list_charts_control.Sort();
   //--- Declare variables to search for charts
   long chart_id=0;
   int i=0;
//--- In the loop by all open charts in the terminal (no more than 100)
   while(i<CHARTS_MAX)
     {
      //--- Get the chart ID
      chart_id=::ChartNext(chart_id);
      if(chart_id<0)
         break;
      //--- Create the object for managing chart objects based on the current chart ID in the loop and add it to the list
      CChartObjectsControl *chart_control=new CChartObjectsControl(chart_id);
      if(chart_control==NULL)
         continue;
      //--- If such an object is already present in the list, inform of that, delete the object and move on to the next chart
      if(this.m_list_charts_control.Search(chart_control)>WRONG_VALUE)
        {
         ::Print(DFUN,CMessage::Text(MSG_GRAPH_ELM_COLLECTION_ERR_OBJ_ALREADY_EXISTS),(string)chart_id);
         delete chart_control;
         continue;
        }
      //--- If failed to add the object to the list, inform of that, remove the object and move on to the next chart
      if(!this.m_list_charts_control.Add(chart_control))
        {
         CMessage::ToLog(DFUN_ERR_LINE,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
         delete chart_control;
         continue;
        }
      //--- Increase the loop index
      i++;
     }
   //--- The list filled in successfully - return the number of its elements
   return this.m_list_charts_control.Total();
  }
//+------------------------------------------------------------------+
//| Update the list of graphical objects by chart ID                 |
//+------------------------------------------------------------------+
CChartObjectsControl *CGraphElementsCollection::RefreshByChartID(const long chart_id)
  {
//--- Get the pointer to the object for managing graphical objects
   CChartObjectsControl *obj=GetChartObjectCtrlObj(chart_id);
//--- If there is no such an object in the list, create a new one and add it to the list
   if(obj==NULL)
      obj=this.CreateChartObjectCtrlObj(chart_id);
//--- If the pointer to the object is not valid, leave the method
   if(obj==NULL)
      return NULL;
//--- Update the list of graphical objects on a specified chart
   obj.Refresh();
   return obj;
  }
//+------------------------------------------------------------------+
//| Update the list of graphical objects on a specified chart        |
//+------------------------------------------------------------------+
void CGraphElementsCollection::Refresh(const long chart_id)
  {
//--- Get the pointer to the object for managing graphical objects
   CChartObjectsControl *obj=GetChartObjectCtrlObj(chart_id);
//--- If failed to get the pointer, exit the method
   if(obj==NULL)
      return;
//--- Update the list of graphical objects on a specified chart
   obj.Refresh();
  }
//+------------------------------------------------------------------+
//| Update the list of all graphical objects                         |
//+------------------------------------------------------------------+
void CGraphElementsCollection::Refresh(void)
  {
   this.RefreshForExtraObjects();
//--- Declare variables to search for charts
   long chart_id=0;
   int i=0;
//--- In the loop by all open charts in the terminal (no more than 100)
   while(i<CHARTS_MAX)
     {
      //--- Get the chart ID
      chart_id=::ChartNext(chart_id);
      if(chart_id<0)
         break;
      //--- Get the pointer to the object for managing graphical objects
      //--- and update the list of graphical objects by chart ID
      CChartObjectsControl *obj_ctrl=this.RefreshByChartID(chart_id);
      //--- If failed to get the pointer, move on to the next chart
      if(obj_ctrl==NULL)
         continue;
      //--- If the number of objects on the chart changes
      if(obj_ctrl.IsEvent())
        {
         //--- If a graphical object is added to the chart
         if(obj_ctrl.Delta()>0)
           {
            //--- Get the list of added graphical objects and move them to the collection list
            //--- (if failed to move the object to the collection, move on to the next object)
            if(!this.AddGraphObjToCollection(DFUN_ERR_LINE,obj_ctrl))
               continue;
            //--- Move all the forms above the created object on the chart and redraw the chart
            this.BringToTopAllCanvElm();
            ::ChartRedraw(obj_ctrl.ChartID());
           }
         //--- If the graphical object has been removed
         else if(obj_ctrl.Delta()<0)
           {
            int index=WRONG_VALUE;
            //--- In the loop by the number of removed graphical objects
            for(int j=0;j<-obj_ctrl.Delta();j++)
              {
               // Find an extra object in the list
               CGStdGraphObj *obj=this.FindMissingObj(chart_id,index);
               if(obj!=NULL)
                 {
                  //--- Get the removed object parameters
                  long   lparam=obj.ChartID();
                  string sparam=obj.Name();
                  double dparam=(double)obj.TimeCreate();
                  //--- If this is an extended graphical object
                  if(obj.TypeGraphElement()==GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED)
                    {
                     this.DeleteExtendedObj(obj);
                    }
                  //--- Move the graphical object class object to the list of removed objects
                  //--- and send the event to the control program chart
                  if(this.MoveGraphObjToDeletedObjList(index))
                     ::EventChartCustom(this.m_chart_id_main,GRAPH_OBJ_EVENT_DELETE,lparam,dparam,sparam);
                 }
              }
           }
        }
      //--- Increase the loop index
      i++;
     }
  }
//+------------------------------------------------------------------+
//| Move all objects on canvas to the foreground                     |
//+------------------------------------------------------------------+
void CGraphElementsCollection::BringToTopAllCanvElm(void)
  {
//--- Create a new list, reset the flag of managing memory and sort by ZOrder
   CArrayObj *list=new CArrayObj();
   list.FreeMode(false);
   list.Sort(SORT_BY_CANV_ELEMENT_ZORDER);
//--- Declare the graphical element object
   CGCnvElement *obj=NULL;
//--- In the loop by the total number of all graphical elements,
   for(int i=0;i<this.m_list_all_canv_elm_obj.Total();i++)
     {
      //--- get the next object
      obj=this.m_list_all_canv_elm_obj.At(i);
      if(obj==NULL)
         continue;
      //--- and insert it to the list in the order of sorting by ZOrder
      list.InsertSort(obj);
     }
//--- In a loop by the created list sorted by ZOrder,
   for(int i=0;i<list.Total();i++)
     {
      //--- get the next object
      obj=list.At(i);
      if(obj==NULL)
         continue;
      //--- and move it to the foreground
      obj.BringToTop();
     }
//--- Remove the list sorted by 'new'
   delete list;
  }
//+------------------------------------------------------------------+
//| Handle the removal of extended graphical objects                 |
//+------------------------------------------------------------------+
void CGraphElementsCollection::DeleteExtendedObj(CGStdGraphObj *obj)
  {
   if(obj==NULL)
      return;
   //--- Save the ID of the graphical object chart and the number of subordinate objects in its list
   long chart_id=obj.ChartID();
   int total=obj.GetNumDependentObj();
   //--- If the list of subordinate objects is not empty (this is the base object)
   if(total>0)
     {
      CGStdGraphObjExtToolkit *toolkit=obj.GetExtToolkit();
      if(toolkit!=NULL)
        {
         toolkit.DeleteAllControlPointForm();
        }
      //--- In the loop, move along all dependent objects and remove them
      for(int n=total-1;n>WRONG_VALUE;n--)
        {
         //--- Get the next graphical object
         CGStdGraphObj *dep=obj.GetDependentObj(n);
         if(dep==NULL)
            continue;
         //--- If failed to remove it from the chart, display the appropriate message in the journal
         if(!::ObjectDelete(dep.ChartID(),dep.Name()))
            CMessage::ToLog(DFUN+dep.Name()+": ",MSG_GRAPH_OBJ_FAILED_DELETE_OBJ_FROM_CHART);
        }
      //--- Upon the loop completion, update the chart to display the changes and exit the method
      ::ChartRedraw(chart_id);
      return;
     }
   //--- If this is a subordinate object
   else if(obj.BaseObjectID()>0)
     {
      //--- Get the base object name and its ID
      string base_name=obj.BaseName();
      long base_id=obj.BaseObjectID();
      //--- Get the base object from the graphical object collection list
      CGStdGraphObj *base=GetStdGraphObject(base_name,chart_id);
      if(base==NULL)
         return;
      //--- get the number of dependent objects in its list
      int count=base.GetNumDependentObj();
      //--- In the loop, move along all its dependent objects and remove them
      for(int n=count-1;n>WRONG_VALUE;n--)
        {
         //--- Get the next graphical object
         CGStdGraphObj *dep=base.GetDependentObj(n);
         //--- If failed to get the pointer or the object has already been removed from the chart, move on to the next one
         if(dep==NULL || !this.IsPresentGraphObjOnChart(dep.ChartID(),dep.Name()))
            continue;
         //--- If failed to delete the graphical object from the chart,
         //--- display the appropriate message in the journal and move on to the next one
         if(!::ObjectDelete(dep.ChartID(),dep.Name()))
           {
            CMessage::ToLog(DFUN+dep.Name()+": ",MSG_GRAPH_OBJ_FAILED_DELETE_OBJ_FROM_CHART);
            continue;
           }
        }
      //--- Remove the base object from the chart and from the list
      if(!::ObjectDelete(base.ChartID(),base.Name()))
         CMessage::ToLog(DFUN+base.Name()+": ",MSG_GRAPH_OBJ_FAILED_DELETE_OBJ_FROM_CHART);
     }
   //--- Update the chart for displaying the changes
   ::ChartRedraw(chart_id);
  }
//+------------------------------------------------------------------+
//| Check if the chart window is present                             |
//+------------------------------------------------------------------+
bool CGraphElementsCollection::IsPresentChartWindow(const long chart_id)
  {
   long chart=0;
   int i=0;
//--- In the loop by all open charts in the terminal (no more than 100)
   while(i<CHARTS_MAX)
     {
      //--- Get the chart ID
      chart=::ChartNext(chart);
      if(chart<0)
         break;
      if(chart==chart_id)
         return true;
      //--- Increase the loop index
      i++;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Handle removing the chart window                                 |
//+------------------------------------------------------------------+
void CGraphElementsCollection::RefreshForExtraObjects(void)
  {
   for(int i=this.m_list_charts_control.Total()-1;i>WRONG_VALUE;i--)
     {
      CChartObjectsControl *obj_ctrl=this.m_list_charts_control.At(i);
      if(obj_ctrl==NULL)
         continue;
      if(!this.IsPresentChartWindow(obj_ctrl.ChartID()))
        {
         long chart_id=obj_ctrl.ChartID();
         string chart_symb=obj_ctrl.Symbol();
         int total_ctrl=this.m_list_charts_control.Total();
         this.DeleteGraphObjCtrlObjFromList(obj_ctrl);
         int total_obj=this.m_list_all_graph_obj.Total();
         this.MoveGraphObjectsToDeletedObjList(chart_id);
         int del_ctrl=total_ctrl-this.m_list_charts_control.Total();
         int del_obj=total_obj-this.m_list_all_graph_obj.Total();
         ::EventChartCustom(this.m_chart_id_main,GRAPH_OBJ_EVENT_DEL_CHART,chart_id,del_obj,chart_symb);
        }
     }
  }
//+------------------------------------------------------------------+
//| Return the first free graphical object ID                        |
//+------------------------------------------------------------------+
long CGraphElementsCollection::GetFreeGraphObjID(bool program_object)
  {
   CArrayObj *list=NULL;
   int index=WRONG_VALUE;
   if(program_object)
      list=CSelect::ByGraphicStdObjectProperty(this.GetListGraphObj(),GRAPH_OBJ_PROP_ID,0,PROGRAM_OBJ_MAX_ID,EQUAL_OR_LESS);
   else
      list=CSelect::ByGraphicStdObjectProperty(this.GetListGraphObj(),GRAPH_OBJ_PROP_ID,0,PROGRAM_OBJ_MAX_ID,MORE);
   index=CSelect::FindGraphicStdObjectMax(list,GRAPH_OBJ_PROP_ID,0);
   CGStdGraphObj *obj=list.At(index);
   int first_id=(program_object ? 1 : PROGRAM_OBJ_MAX_ID+1);
   return(obj!=NULL ? obj.ObjectID()+1 : first_id);
  }
//+------------------------------------------------------------------+
//| Return the first free ID                                         |
//| of the graphical element on canvas                               |
//+------------------------------------------------------------------+
long CGraphElementsCollection::GetFreeCanvElmID(void)
  {
   int index=CSelect::FindGraphCanvElementMax(this.GetListCanvElm(),CANV_ELEMENT_PROP_ID);
   CGCnvElement *obj=this.m_list_all_canv_elm_obj.At(index);
   return(obj!=NULL ? obj.ID()+1 : 1);
  }
//+------------------------------------------------------------------+
//| Add a graphical object to the collection                         |
//+------------------------------------------------------------------+
bool CGraphElementsCollection::AddGraphObjToCollection(const string source,CChartObjectsControl *obj_control)
  {
   //--- Get the list of the last added graphical objects from the class for managing graphical objects
   CArrayObj *list=obj_control.GetListNewAddedObj();
   //--- If failed to obtain the list, inform of that and return 'false'
   if(list==NULL)
     {
      CMessage::ToLog(DFUN_ERR_LINE,MSG_GRAPH_OBJ_FAILED_GET_ADDED_OBJ_LIST);
      return false;
     }
   //--- If the list is empty, return 'false'
   if(list.Total()==0)
      return false;
   //--- Declare the variable for storing the result
   bool res=true;
   //--- In the loop by the list of newly added standard graphical objects,
   for(int i=0;i<list.Total();i++)
     {
      //--- retrieve the next object from the list and
      CGStdGraphObj *obj=list.Detach(i);
      //--- if failed to retrieve the object, inform of that, add 'false' to the resulting variable and move on to the next one
      if(obj==NULL)
        {
         CMessage::ToLog(source,MSG_GRAPH_OBJ_FAILED_DETACH_OBJ_FROM_LIST);
         res &=false;
         continue;
        }
      //--- if failed to add the object to the collection list, inform of that,
      //--- remove the object, add 'false' to the resulting variable and move on to the next one
      if(!this.m_list_all_graph_obj.Add(obj))
        {
         CMessage::ToLog(source,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
         delete obj;
         res &=false;
         continue;
        }
      //--- The object has been successfully retrieved from the list of newly added graphical objects and introduced into the collection -
      //--- find the next free object ID, write it to the object property
      else
        {
         bool program_object=(::StringFind(obj.Name(),this.m_name_program)==0);
         obj.SetObjectID(this.GetFreeGraphObjID(program_object));
        }
     }
   //--- Return the result of adding the object to the collection
   return res;
  }
//+------------------------------------------------------------------+
//| Add the graphical element on canvas to the collection            |
//+------------------------------------------------------------------+
bool CGraphElementsCollection::AddCanvElmToCollection(CGCnvElement *element)
  {
   if(element==NULL)
      return false;
   if(this.IsPresentCanvElmInList(element.ChartID(),element.Name()))
     {
      CMessage::ToLog(DFUN+element.Name()+": ",MSG_LIB_SYS_OBJ_ALREADY_IN_LIST);
      return false;
     }
   if(!this.m_list_all_canv_elm_obj.Add(element))
     {
      CMessage::ToLog(DFUN+element.Name()+": ",MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//|Find an object present in the collection but not on a chart       |
//| Return the pointer to the object.                                |
//+------------------------------------------------------------------+
CGStdGraphObj *CGraphElementsCollection::FindMissingObj(const long chart_id)
  {
   CArrayObj *list=CSelect::ByGraphicStdObjectProperty(this.GetListGraphObj(),GRAPH_OBJ_PROP_CHART_ID,0,chart_id,EQUAL);
   if(list==NULL)
      return NULL;
   for(int i=0;i<list.Total();i++)
     {
      CGStdGraphObj *obj=list.At(i);
      if(obj==NULL)
         continue;
      if(!this.IsPresentGraphObjOnChart(obj.ChartID(),obj.Name()))
         return obj;
     }
   return NULL;
  }
//+------------------------------------------------------------------+
//|Find an object present in the collection but not on a chart       |
//| Return the pointer to the object and its index in the list.      |
//+------------------------------------------------------------------+
CGStdGraphObj *CGraphElementsCollection::FindMissingObj(const long chart_id,int &index)
  {
   CArrayObj *list=CSelect::ByGraphicStdObjectProperty(this.GetListGraphObj(),GRAPH_OBJ_PROP_CHART_ID,0,chart_id,EQUAL);
   if(list==NULL)
      return NULL;
   index=WRONG_VALUE;
   for(int i=0;i<list.Total();i++)
     {
      CGStdGraphObj *obj=list.At(i);
      if(obj==NULL)
         continue;
      if(!this.IsPresentGraphObjOnChart(obj.ChartID(),obj.Name()))
        {
         index=i;
         return obj;
        }
     }
   return NULL;
  }
//+------------------------------------------------------------------+
//|Find an object present on a chart but not in the collection       |
//+------------------------------------------------------------------+
string CGraphElementsCollection::FindExtraObj(const long chart_id)
  {
   int total=::ObjectsTotal(chart_id);
   for(int i=0;i<total;i++)
     {
      string name=::ObjectName(chart_id,i);
      if(!this.IsPresentGraphObjInList(chart_id,name))
         return name;
     }
   return NULL;
  }
//+-----------------------------------------------------------------------------+
//| Return the flag indicating the presence of the graphical object class object|
//| in the graphical object collection list                                     |
//+-----------------------------------------------------------------------------+
bool CGraphElementsCollection::IsPresentGraphObjInList(const long chart_id,const string name)
  {
   CArrayObj *list=CSelect::ByGraphicStdObjectProperty(this.GetListGraphObj(),GRAPH_OBJ_PROP_CHART_ID,0,chart_id,EQUAL);
   list=CSelect::ByGraphicStdObjectProperty(list,GRAPH_OBJ_PROP_NAME,0,name,EQUAL);
   return(list==NULL || list.Total()==0 ? false : true);
  }
//+--------------------------------------------------------------------------------+
//| Return the flag indicating the presence of the graphical element class object  |
//| in the graphical element collection list                                       |
//+--------------------------------------------------------------------------------+
bool CGraphElementsCollection::IsPresentCanvElmInList(const long chart_id,const string name)
  {
   CArrayObj *list=CSelect::ByGraphCanvElementProperty(this.GetListCanvElm(),CANV_ELEMENT_PROP_CHART_ID,chart_id,EQUAL);
   list=CSelect::ByGraphCanvElementProperty(list,CANV_ELEMENT_PROP_NAME_OBJ,name,EQUAL);
   return(list==NULL || list.Total()==0 ? false : true);
  }
//+----------------------------------------------------------------------------------+
//| Return the flag indicating the presence of a graphical object on a chart by name |
//+----------------------------------------------------------------------------------+
bool CGraphElementsCollection::IsPresentGraphObjOnChart(const long chart_id,const string name)
  {
   int total=::ObjectsTotal(chart_id);
   for(int i=0;i<total;i++)
      if(::ObjectName(chart_id,i)==name)
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Remove the specified graphical object                            |
//| from the graphical object collection list                        |
//+------------------------------------------------------------------+
bool CGraphElementsCollection::DeleteGraphObjFromList(CGStdGraphObj *obj)
  {
   this.m_list_all_graph_obj.Sort();
   int index=this.m_list_all_graph_obj.Search(obj);
   return(index==WRONG_VALUE ? false : this.m_list_all_graph_obj.Delete(index));
  }
//+------------------------------------------------------------------+
//| Remove graphical objects by a chart ID                           |
//| from the graphical object collection list                        |
//+------------------------------------------------------------------+
void CGraphElementsCollection::DeleteGraphObjectsFromList(const long chart_id)
  {
   CArrayObj *list=CSelect::ByGraphicStdObjectProperty(GetListGraphObj(),GRAPH_OBJ_PROP_CHART_ID,0,chart_id,EQUAL);
   if(list==NULL)
      return;
   for(int i=list.Total()-1;i>WRONG_VALUE;i--)
     {
      CGStdGraphObj *obj=list.At(i);
      if(obj==NULL)
         continue;
      this.DeleteGraphObjFromList(obj);
     }
  }
//+------------------------------------------------------------------+
//| Move all objects (by chart ID)                                   |
//| to the list of removed graphical objects                         |
//+------------------------------------------------------------------+
void CGraphElementsCollection::MoveGraphObjectsToDeletedObjList(const long chart_id)
  {
   CArrayObj *list=GetList(GRAPH_OBJ_PROP_CHART_ID,0,chart_id,EQUAL);
   if(list==NULL)
      return;
   for(int i=list.Total()-1;i>WRONG_VALUE;i--)
     {
      CGStdGraphObj *obj=list.At(i);
      if(obj==NULL)
         continue;
      this.MoveGraphObjToDeletedObjList(obj);
     }
  }
//+------------------------------------------------------------------+
//| Move the class object of the graphical object by index           |
//| to the list of removed graphical objects                         |
//+------------------------------------------------------------------+
bool CGraphElementsCollection::MoveGraphObjToDeletedObjList(const int index)
  {
   CGStdGraphObj *obj=this.m_list_all_graph_obj.Detach(index);
   if(obj==NULL)
     {
      CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_DETACH_OBJ_FROM_LIST);
      return false;
     }
   if(!this.m_list_deleted_obj.Add(obj))
     {
      CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_ADD_OBJ_TO_DEL_LIST);
      delete obj;
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Move the specified graphical object class object                 |
//| to the list of removed graphical objects                         |
//+------------------------------------------------------------------+
bool CGraphElementsCollection::MoveGraphObjToDeletedObjList(CGStdGraphObj *obj)
  {
   this.m_list_all_graph_obj.Sort();
   int index=this.m_list_all_graph_obj.Search(obj);
   return this.MoveGraphObjToDeletedObjList(index);
  }
//+------------------------------------------------------------------+
//| Remove the object of managing charts from the list               |
//+------------------------------------------------------------------+
bool CGraphElementsCollection::DeleteGraphObjCtrlObjFromList(CChartObjectsControl *obj)
  {
   this.m_list_charts_control.Sort();
   int index=this.m_list_charts_control.Search(obj);
   return(index==WRONG_VALUE ? false : m_list_charts_control.Delete(index));
  }
//+------------------------------------------------------------------+
//| Return an existing graphical object                              |
//| by chart name and ID                                             |
//+------------------------------------------------------------------+
CGStdGraphObj *CGraphElementsCollection::GetStdGraphObject(const string name,const long chart_id)
  {
   CArrayObj *list=this.GetList(GRAPH_OBJ_PROP_CHART_ID,0,chart_id);
   list=CSelect::ByGraphicStdObjectProperty(list,GRAPH_OBJ_PROP_NAME,0,name,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(0) : NULL);
  }
//+------------------------------------------------------------------+
//| Return a removed graphical object                                |
//| by chart name and ID                                             |
//+------------------------------------------------------------------+
CGStdGraphObj *CGraphElementsCollection::GetStdDelGraphObject(const string name,const long chart_id)
  {
   CArrayObj *list=this.GetListDel(GRAPH_OBJ_PROP_CHART_ID,0,chart_id);
   list=CSelect::ByGraphicStdObjectProperty(list,GRAPH_OBJ_PROP_NAME,0,name,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(0) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the existing extended standard                            |
//| graphical object by its ID                                       |
//+------------------------------------------------------------------+
CGStdGraphObj *CGraphElementsCollection::GetStdGraphObjectExt(const long id,const long chart_id)
  {
   CArrayObj *list=this.GetListStdGraphObjectExt();
   list=CSelect::ByGraphicStdObjectProperty(list,GRAPH_OBJ_PROP_CHART_ID,0,chart_id,EQUAL);
   list=CSelect::ByGraphicStdObjectProperty(list,GRAPH_OBJ_PROP_ID,0,id,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(0) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the existing standard                                     |
//| graphical object by its ID                                       |
//+------------------------------------------------------------------+
CGStdGraphObj *CGraphElementsCollection::GetStdGraphObject(const long id,const long chart_id)
  {
   CArrayObj *list=this.GetList(GRAPH_OBJ_PROP_CHART_ID,0,chart_id);
   list=CSelect::ByGraphicStdObjectProperty(list,GRAPH_OBJ_PROP_ELEMENT_TYPE,0,GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED,NO_EQUAL);
   list=CSelect::ByGraphicStdObjectProperty(list,GRAPH_OBJ_PROP_ID,0,id,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(0) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to the form located under the cursor          |
//+------------------------------------------------------------------+
CForm *CGraphElementsCollection::GetFormUnderCursor(const int id, 
                                                    const long &lparam, 
                                                    const double &dparam, 
                                                    const string &sparam,
                                                    ENUM_MOUSE_FORM_STATE &mouse_state,
                                                    long &obj_ext_id,
                                                    int &form_index)
  {
//--- Set the ID of the extended standard graphical object to -1 
//--- and the index of the anchor point managed by the form to -1
   obj_ext_id=WRONG_VALUE;
   form_index=WRONG_VALUE;
//--- Initialize the mouse status relative to the form
   mouse_state=MOUSE_FORM_STATE_NONE;
//--- Declare the pointers to graphical element collection class objects
   CGCnvElement *elm=NULL;
   CForm *form=NULL;
//--- Get the list of objects the interaction flag is set for (there should be only one object)
   CArrayObj *list=CSelect::ByGraphCanvElementProperty(GetListCanvElm(),CANV_ELEMENT_PROP_INTERACTION,true,EQUAL);
//--- If managed to obtain the list and it is not empty,
   if(list!=NULL && list.Total()>0)
     {
      //--- Get the only graphical element there
      elm=list.At(0);
      //--- If it is a form object
      if(elm.TypeGraphElement()==GRAPH_ELEMENT_TYPE_FORM)
        {
         //--- Assign the pointer to the element for the form object pointer
         form=elm;
         //--- Get the mouse status relative to the form
         mouse_state=form.MouseFormState(id,lparam,dparam,sparam);
         //--- If the cursor is within the form, return the pointer to the form
         if(mouse_state>MOUSE_FORM_STATE_OUTSIDE_FORM_WHEEL)
            return form;
        }
     }
//--- If there is no a single form object with a specified interaction flag,
//--- in the loop by all graphical element collection class objects
   int total=this.m_list_all_canv_elm_obj.Total();
   for(int i=0;i<total;i++)
     {
      //--- get the next element
      elm=this.m_list_all_canv_elm_obj.At(i);
      if(elm==NULL)
         continue;
      //--- if the obtained element is a form object
      if(elm.TypeGraphElement()==GRAPH_ELEMENT_TYPE_FORM)
        {
         //--- Assign the pointer to the element for the form object pointer
         form=elm;
         //--- Get the mouse status relative to the form
         mouse_state=form.MouseFormState(id,lparam,dparam,sparam);
         //--- If the cursor is within the form, return the pointer to the form
         if(mouse_state>MOUSE_FORM_STATE_OUTSIDE_FORM_WHEEL)
            return form;
        }
     }
//--- If there is no a single form object from the collection list
//--- Get the list of extended standard graphical objects
   list=this.GetListStdGraphObjectExt();
   if(list!=NULL)
     {
      //--- in the loop by all extended standard graphical objects
      for(int i=0;i<list.Total();i++)
        {
         //--- get the next graphical object,
         CGStdGraphObj *obj_ext=list.At(i);
         if(obj_ext==NULL)
            continue;
         //--- get the object of its toolkit,
         CGStdGraphObjExtToolkit *toolkit=obj_ext.GetExtToolkit();
         if(toolkit==NULL)
            continue;
         //--- handle the event of changing the chart for the current graphical object
         obj_ext.OnChartEvent(CHARTEVENT_CHART_CHANGE,lparam,dparam,sparam);
         //--- Get the total number of form objects created for the current graphical object
         total=toolkit.GetNumControlPointForms();
         //--- In the loop by all form objects
         for(int j=0;j<total;j++)
           {
            //--- get the next form object,
            form=toolkit.GetControlPointForm(j);
            if(form==NULL)
               continue;
            //--- get the mouse status relative to the form
            mouse_state=form.MouseFormState(id,lparam,dparam,sparam);
            //--- If the cursor is inside the form,
            if(mouse_state>MOUSE_FORM_STATE_OUTSIDE_FORM_WHEEL)
              {
               //--- set the object ID and form index
               //--- and return the pointer to the form
               obj_ext_id=obj_ext.ObjectID();
               form_index=j;
               return form;
              }
           }
        }
     }
//--- Nothing is found - return NULL
   return NULL;
  }
//+--------------------------------------------------------------------+
//| Reset all interaction flags for all forms except the specified one |
//+--------------------------------------------------------------------+
void CGraphElementsCollection::ResetAllInteractionExeptOne(CForm *form_exept)
  {
   //--- In the loop by all graphical element collection class objects
   int total=this.m_list_all_canv_elm_obj.Total();
   for(int i=0;i<total;i++)
     {
      //--- get the pointer to a form object
      CForm *form=this.m_list_all_canv_elm_obj.At(i);
      //--- if failed to receive the pointer, or it is not a form, or it is not a form whose pointer has been passed to the method, move on
      if(form==NULL || form.TypeGraphElement()!=GRAPH_ELEMENT_TYPE_FORM || (form.Name()==form_exept.Name() && form.ChartID()==form_exept.ChartID()))
         continue;
      //--- Reset the interaction flag for the current form in the loop
      form.SetInteraction(false);
     }
  }
//+------------------------------------------------------------------+
//| Return the maximum ZOrder of all CCanvas elements                |
//+------------------------------------------------------------------+
long CGraphElementsCollection::GetZOrderMax(void)
  {
   this.m_list_all_canv_elm_obj.Sort(SORT_BY_CANV_ELEMENT_ZORDER);
   int index=CSelect::FindGraphCanvElementMax(this.GetListCanvElm(),CANV_ELEMENT_PROP_ZORDER);
   CGCnvElement *obj=this.m_list_all_canv_elm_obj.At(index);
   return(obj!=NULL ? obj.Zorder() : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Set ZOrde to the specified element                               |
//| and adjust it in other elements                                  |
//+------------------------------------------------------------------+
bool CGraphElementsCollection::SetZOrderMAX(CGCnvElement *obj)
  {
//--- Get the maximum ZOrder of all graphical elements
   long max=this.GetZOrderMax();
//--- If an invalid pointer to the object has been passed or the maximum ZOrder has not been received, return 'false'
   if(obj==NULL || max<0)
      return false;
//--- Declare the variable for storing the method result
   bool res=true;
//--- If the maximum ZOrder is zero, ZOrder is equal to 1,
//--- if the maximum ZOrder is less than (the total number of graphical elements)-1, ZOrder will exceed it by 1,
//--- otherwise, ZOrder will be equal to (the total number of graphical elements)-1
   long value=(max==0 ? 1 : max<this.m_list_all_canv_elm_obj.Total()-1 ? max+1 : this.m_list_all_canv_elm_obj.Total()-1);
//--- If failed to set ZOrder for an object passed to the method, return 'false'
   if(!obj.SetZorder(value,false))
      return false;
//--- Temporarily declare a form object for drawing a text for visually displaying its ZOrder
   CForm *form=obj;
//--- and draw a text specifying ZOrder on the form
   form.TextOnBG(0,TextByLanguage("Тест: ID ","Test. ID ")+(string)form.ID()+", ZOrder "+(string)form.Zorder(),form.Width()/2,form.Height()/2,FRAME_ANCHOR_CENTER,C'211,233,149',255,true,true);
//--- Sort the list of graphical elements by an element ID
   this.m_list_all_canv_elm_obj.Sort(SORT_BY_CANV_ELEMENT_ID);
//--- Get the list of graphical elements without an object whose ID is equal to the ID of the object passed to the method
   CArrayObj *list=CSelect::ByGraphCanvElementProperty(this.GetListCanvElm(),CANV_ELEMENT_PROP_ID,obj.ID(),NO_EQUAL);
//--- If failed to obtain the list and the list size exceeds one,
//--- which indicates the presence of other objects in it in addition to the one sorted by ID, return 'false'
   if(list==NULL && this.m_list_all_canv_elm_obj.Total()>1)
      return false;
//--- In the loop by the obtained list of remaining graphical element objects
   for(int i=0;i<list.Total();i++)
     {
      //--- get the next object
      CGCnvElement *elm=list.At(i);
      //--- If failed to get the object or if this is a control form for managing pivot points of an extended standard graphical object
      //--- or, if the object's ZOrder is zero, skip the object since there is no need in changing its ZOrder as it is the bottom one
      if(elm==NULL || elm.Type()==OBJECT_DE_TYPE_GFORM_CONTROL || elm.Zorder()==0)
         continue;
      //--- If failed to set the object's ZOrder to 1 less than it already is (decreasing ZOrder by 1), add 'false' to the 'res' value
      if(!elm.SetZorder(elm.Zorder()-1,false))
         res &=false;
      //--- Temporarily (for the test purpose), if the element is a form,
      if(elm.Type()==OBJECT_DE_TYPE_GFORM)
        {
         //--- assign the pointer to the element for the form and draw a text specifying ZOrder on the form 
         form=elm;
         form.TextOnBG(0,TextByLanguage("Тест: ID ","Test. ID ")+(string)form.ID()+", ZOrder "+(string)form.Zorder(),form.Width()/2,form.Height()/2,FRAME_ANCHOR_CENTER,C'211,233,149',255,true,true);
        }
     }
//--- Upon the loop completion, return the result set in 'res'
   return res;
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CGraphElementsCollection::OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
  {
   CGStdGraphObj *obj_std=NULL;  // Pointer to the standard graphical object
   CGCnvElement  *obj_cnv=NULL;  // Pointer to the graphical element object on canvas
   ushort idx=ushort(id-CHARTEVENT_CUSTOM);
   if(id==CHARTEVENT_OBJECT_CHANGE  || id==CHARTEVENT_OBJECT_DRAG    || id==CHARTEVENT_OBJECT_CLICK   ||
      idx==CHARTEVENT_OBJECT_CHANGE || idx==CHARTEVENT_OBJECT_DRAG   || idx==CHARTEVENT_OBJECT_CLICK)
     {
      //--- Calculate the chart ID
      //--- If the event ID corresponds to an event from the current chart, the chart ID is received from ChartID
      //--- If the event ID corresponds to a user event, the chart ID is received from lparam
      //--- Otherwise, the chart ID is assigned to -1
      long param=(id==CHARTEVENT_OBJECT_CLICK ? ::ChartID() : idx==CHARTEVENT_OBJECT_CLICK ? lparam : WRONG_VALUE);
      long chart_id=(param==WRONG_VALUE ? (lparam==0 ? ::ChartID() : lparam) : param);
      //--- Get the object, whose properties were changed or which was relocated,
      //--- from the collection list by its name set in sparam
      obj_std=this.GetStdGraphObject(sparam,chart_id);
      //--- If failed to get the object by its name, it is not on the list,
      //--- which means its name has been changed
      if(obj_std==NULL)
        {
         //--- Let's search the list for the object that is not on the chart
         obj_std=this.FindMissingObj(chart_id);
         //--- If failed to find the object here as well, exit
         if(obj_std==NULL)
            return;
         //--- Get the name of the renamed graphical object on the chart, which is not in the collection list
         string name_new=this.FindExtraObj(chart_id);
         //--- set a new name for the collection list object, which does not correspond to any graphical object on the chart,
         //--- and send an event with the new name of the object to the control program chart
         if(obj_std.SetNamePrev(obj_std.Name()) && obj_std.SetName(name_new))
            ::EventChartCustom(this.m_chart_id_main,GRAPH_OBJ_EVENT_RENAME,obj_std.ChartID(),obj_std.TimeCreate(),obj_std.Name());
        }
      //--- Update the properties of the obtained object
      //--- and check their change
      obj_std.PropertiesRefresh();
      obj_std.PropertiesCheckChanged();
     }

//--- Handle standard graphical object events in the collection list
   for(int i=0;i<this.m_list_all_graph_obj.Total();i++)
     {
      //--- Get the next graphical object and
      obj_std=this.m_list_all_graph_obj.At(i);
      if(obj_std==NULL)
         continue;
      //--- call its event handler
      obj_std.OnChartEvent((id<CHARTEVENT_CUSTOM ? id : idx),lparam,dparam,sparam);
     }

//--- Handle chart changes for extended standard objects
   if(id==CHARTEVENT_CHART_CHANGE || idx==CHARTEVENT_CHART_CHANGE)
     {
      CArrayObj *list=this.GetListStdGraphObjectExt();
      if(list!=NULL)
        {
         for(int i=0;i<list.Total();i++)
           {
            obj_std=list.At(i);
            if(obj_std==NULL)
               continue;
            obj_std.OnChartEvent(CHARTEVENT_CHART_CHANGE,lparam,dparam,sparam);
           }
        }
     }
//--- Handling mouse events of graphical objects on canvas
//--- If the event is not a chart change
   else
     {
      //--- Check whether the mouse button is pressed
      bool pressed=(this.m_mouse.ButtonKeyState(id,lparam,dparam,sparam)==MOUSE_BUTT_KEY_STATE_LEFT ? true : false);
      ENUM_MOUSE_FORM_STATE mouse_state=MOUSE_FORM_STATE_NONE;
      //--- Declare static variables for the active form and status flags
      static CForm *form=NULL;
      static bool pressed_chart=false;
      static bool pressed_form=false;
      static bool move=false;
      //--- Declare static variables for the index of the form for managing an extended standard graphical object and its ID
      static int  form_index=WRONG_VALUE;
      static long graph_obj_id=WRONG_VALUE;
      
      //--- If the button is not pressed on the chart and the movement flag is not set, get the form, above which the cursor is located
      if(!pressed_chart && !move)
         form=this.GetFormUnderCursor(id,lparam,dparam,sparam,mouse_state,graph_obj_id,form_index);
      
      //--- If the button is not pressed, reset all flags and enable the chart tools 
      if(!pressed)
        {
         pressed_chart=false;
         pressed_form=false;
         move=false;
         this.SetChartTools(::ChartID(),true);
        }
      
      //--- If this is a mouse movement event and the movement flag is active, move the form, above which the cursor is located (if the pointer to it is valid)
      if(id==CHARTEVENT_MOUSE_MOVE && move)
        {
         if(form!=NULL)
           {
            //--- calculate the cursor movement relative to the form coordinate origin
            int x=this.m_mouse.CoordX()-form.OffsetX();
            int y=this.m_mouse.CoordY()-form.OffsetY();
            //--- get the width and height of the chart the form is located at
            int chart_width=(int)::ChartGetInteger(form.ChartID(),CHART_WIDTH_IN_PIXELS,form.SubWindow());
            int chart_height=(int)::ChartGetInteger(form.ChartID(),CHART_HEIGHT_IN_PIXELS,form.SubWindow());
            //--- If the form is not within an extended standard graphical object
            if(form_index==WRONG_VALUE)
              {
               //--- Adjust the calculated form coordinates if the form is out of the chart range
               if(x<0) x=0;
               if(x>chart_width-form.Width()) x=chart_width-form.Width();
               if(y<0) y=0;
               if(y>chart_height-form.Height()) y=chart_height-form.Height();
               //--- If the one-click trading panel is not present on the chart,
               if(!::ChartGetInteger(form.ChartID(),CHART_SHOW_ONE_CLICK))
                 {
                  //--- calculate the form coordinates so that the form does not overlap with the one-click trading panel button
                  if(y<17 && x<41)
                     y=17;
                 }
               //--- If the one-click trading panel is on the chart,
               else
                 {
                  //--- calculate the form coordinates so that the form does not overlap with the one-click trading panel
                  if(y<80 && x<192)
                     y=80;
                 }
              }
            //--- If the form is included into the extended standard graphical object
            else
              {
               if(graph_obj_id>WRONG_VALUE)
                 {
                  //--- Get the list of objects by object ID (there should be one object)
                  CArrayObj *list_ext=CSelect::ByGraphicStdObjectProperty(GetListStdGraphObjectExt(),GRAPH_OBJ_PROP_ID,0,graph_obj_id,EQUAL);
                  //--- If managed to obtain the list and it is not empty,
                  if(list_ext!=NULL && list_ext.Total()>0)
                    {
                     //--- get the graphical object from the list
                     CGStdGraphObj *ext=list_ext.At(0);
                     //--- If the pointer to the object has been received,
                     if(ext!=NULL)
                       {
                        //--- get the object type
                        ENUM_OBJECT type=ext.GraphObjectType();
                        //--- If the object is built using screen coordinates, set the coordinates to the object
                        if(type==OBJ_LABEL || type==OBJ_BUTTON || type==OBJ_BITMAP_LABEL || type==OBJ_EDIT || type==OBJ_RECTANGLE_LABEL)
                          {
                           ext.SetXDistance(x);
                           ext.SetYDistance(y);
                          }
                        //--- otherwise, if the object is built based on time/price coordinates,
                        else
                          {
                           //--- calculate the shift from the form coordinate origin to its center
                           int shift=(int)::ceil(form.Width()/2)+1;
                           //--- If the form is located on one of the graphical object pivot points,
                           if(form_index<ext.Pivots())
                             {
                              //--- limit the form coordinates so that they do not move beyond the chart borders
                              if(x+shift<0)
                                 x=-shift;
                              if(x+shift>chart_width)
                                 x=chart_width-shift;
                              if(y+shift<0)
                                 y=-shift;
                              if(y+shift>chart_height)
                                 y=chart_height-shift;
                              //--- set the calculated coordinates to the object
                              ext.ChangeCoordsExtendedObj(x+shift,y+shift,form_index);
                             }
                           //--- If the form is central for managing all pivot points of a graphical object
                           else
                             {
                              //--- Get screen coordinates of all object pivot points and write them to the m_data_pivot_point structure
                              if(this.GetPivotPointCoordsAll(ext,m_data_pivot_point))
                                {
                                 //--- In the loop by the number of object pivot points,
                                 for(int i=0;i<(int)this.m_data_pivot_point.Size();i++)
                                   {
                                    //--- limit the screen coordinates of the current pivot point so that they do not move beyond the chart borders
                                    //--- By X coordinate
                                    if(x+shift-::fabs(this.m_data_pivot_point[i].ShiftX)<0)
                                       x=-shift+::fabs(m_data_pivot_point[i].ShiftX);
                                    if(x+shift+::fabs(this.m_data_pivot_point[i].ShiftX)>chart_width)
                                       x=chart_width-shift-::fabs(this.m_data_pivot_point[i].ShiftX);
                                    //--- By Y coordinate
                                    if(y+shift-::fabs(this.m_data_pivot_point[i].ShiftY)<0)
                                       y=-shift+::fabs(this.m_data_pivot_point[i].ShiftY);
                                    if(y+shift+::fabs(this.m_data_pivot_point[i].ShiftY)>chart_height)
                                       y=chart_height-shift-::fabs(this.m_data_pivot_point[i].ShiftY);
                                    //--- set the calculated coordinates to the current object pivot point
                                    ext.ChangeCoordsExtendedObj(x+shift+this.m_data_pivot_point[i].ShiftX,y+shift+this.m_data_pivot_point[i].ShiftY,i);
                                   }
                                }
                                
                              //--- Display debugging comments on the chart
                              if(m_data_pivot_point.Size()>=2)
                                {
                                 int max_x,min_x,max_y,min_y;
                                 if(ext.GetMinCoordXY(min_x,min_y) && ext.GetMaxCoordXY(max_x,max_y))
                                    Comment
                                      (
                                       "MinX=",min_x,", MaxX=",max_x,"\n",
                                       "MaxY=",min_y,", MaxY=",max_y
                                      );
                                }
                                
                             }
                          }
                       }
                    }
                 }
              }
            //--- Move the form by the obtained coordinates
            form.Move(x,y,true);
           }
        }
   
      //--- Display debugging comments on the chart
//      if(m_data_pivot_point.Size()>=2)
//        {
//         Comment
//           (
//            //(form!=NULL ? form.Name()+":" : ""),"\n",
//            //EnumToString((ENUM_CHART_EVENT)id),"\n",
//            //EnumToString(this.m_mouse.ButtonKeyState(id,lparam,dparam,sparam)),
//            //"\n",EnumToString(mouse_state),
//            //"\npressed=",pressed,", move=",move,(form!=NULL ? ", Interaction="+(string)form.Interaction() : ""),
//            //"\npressed_chart=",pressed_chart,", pressed_form=",pressed_form,
//            //"\nform_index=",form_index,", graph_obj_id=",graph_obj_id
//            
//            "Shift X0=",m_data_pivot_point[0].ShiftX,"\n",
//            "Shift X1=",m_data_pivot_point[1].ShiftX,"\n",
//            
//            "Shift Y0=",m_data_pivot_point[0].ShiftY,"\n",
//            "Shift Y1=",m_data_pivot_point[1].ShiftY
//           );
//        }
      
      //--- If the cursor is not above the form
      if(form==NULL)
        {
         //--- If the mouse button is pressed
         if(pressed)
           {
            //--- If the button is still pressed and held on the form, exit
            if(pressed_form)
              {
               return;
              }
            //--- If the button hold flag is not enabled yet, set the flags and enable chart tools
            if(!pressed_chart)
              {
               pressed_chart=true;  // Button is held on the chart
               pressed_form=false;  // Cursor is not above the form
               move=false;          // movement disabled
               this.SetChartTools(::ChartID(),true);
              }
           }
         //--- If the mouse button is not pressed
         else
           {
            //--- Get the list of extended standard graphical objects
            CArrayObj *list_ext=GetListStdGraphObjectExt();
            //--- In the loop by all extended graphical objects,
            int total=list_ext.Total();
            for(int i=0;i<total;i++)
              {
               //--- get the next graphical object
               CGStdGraphObj *obj=list_ext.At(i);
               if(obj==NULL)
                  continue;
               //--- and redraw it without a point and a circle
               obj.RedrawControlPointForms(0,CTRL_POINT_COLOR);
              }
           }
        }
      //--- If the cursor is above the form
      else
        {
         //--- If the button is still pressed and held on the chart, exit
         if(pressed_chart)
           {
            return;
           }
         
         //--- If the flag of holding the button on the form is not set yet
         if(!pressed_form)
           {
            pressed_chart=false;    // The button is not pressed on the chart
            this.SetChartTools(::ChartID(),false);
            
            //--- 'The cursor is inside the form, no mouse buttons are clicked' event handler
            if(mouse_state==MOUSE_FORM_STATE_INSIDE_FORM_NOT_PRESSED)
              {
               //--- If the cursor is above the form for managing the pivot point of an extended graphical object,
               if(graph_obj_id>WRONG_VALUE)
                 {
                  //--- get the object by its ID and by the chart ID
                  CGStdGraphObj *graph_obj=this.GetStdGraphObjectExt(graph_obj_id,form.ChartID());
                  if(graph_obj!=NULL)
                    {
                     //--- Get the toolkit of an extended standard graphical object
                     CGStdGraphObjExtToolkit *toolkit=graph_obj.GetExtToolkit();
                     if(toolkit!=NULL)
                       {
                        //--- Draw a point with a circle on the form and delete it on all other forms
                        toolkit.DrawOneControlPoint(form);
                       }
                    }
                 }
              }
            //--- 'The cursor is inside the form, a mouse button is clicked (any)' event handler
            if(mouse_state==MOUSE_FORM_STATE_INSIDE_FORM_PRESSED)
              {
               this.SetChartTools(::ChartID(),false);
               //--- If the flag of holding the form is not set yet
               if(!pressed_form)
                 {
                  pressed_form=true;      // set the flag of pressing on the form
                  pressed_chart=false;    // remove the flag of pressing on the chart
                 }
              }
            //--- 'The cursor is inside the form, the mouse wheel is being scrolled' event handler workpiece
            if(mouse_state==MOUSE_FORM_STATE_INSIDE_FORM_WHEEL)
              {
               
              }
            
            
            //--- 'The cursor is inside the active area, the mouse buttons are not clicked' event handler
            if(mouse_state==MOUSE_FORM_STATE_INSIDE_ACTIVE_AREA_NOT_PRESSED)
              {
               //--- Set the cursor shift relative to the form initial coordinates
               form.SetOffsetX(this.m_mouse.CoordX()-form.CoordX());
               form.SetOffsetY(this.m_mouse.CoordY()-form.CoordY());
               //--- If the cursor is above the active area of the form for managing the pivot point of an extended graphical object,
               if(graph_obj_id>WRONG_VALUE)
                 {
                  //--- get the object by its ID and by the chart ID
                  CGStdGraphObj *graph_obj=this.GetStdGraphObjectExt(graph_obj_id,form.ChartID());
                  if(graph_obj!=NULL)
                    {
                     //--- Get the toolkit of an extended standard graphical object
                     CGStdGraphObjExtToolkit *toolkit=graph_obj.GetExtToolkit();
                     if(toolkit!=NULL)
                       {
                        //--- Draw a point with a circle on the form and delete it on all other forms
                        toolkit.DrawOneControlPoint(form);
                       }
                    }
                 }
              }
            //--- 'The cursor is inside the active area,  any mouse button is clicked' event handler
            if(mouse_state==MOUSE_FORM_STATE_INSIDE_ACTIVE_AREA_PRESSED && !move)
              {
               pressed_form=true;   // the flag of holding the mouse button on the form
               //--- If the left mouse button is pressed
               if(this.m_mouse.IsPressedButtonLeft())
                 {
                  //--- Set flags and form parameters
                  move=true;                                            // movement flag
                  form.SetInteraction(true);                            // flag of the form interaction with the environment
                  form.BringToTop();                                    // form on the background - above all others
                  form.SetOffsetX(this.m_mouse.CoordX()-form.CoordX()); // Cursor shift relative to the X coordinate
                  form.SetOffsetY(this.m_mouse.CoordY()-form.CoordY()); // Cursor shift relative to the Y coordinate
                  this.ResetAllInteractionExeptOne(form);               // Reset interaction flags for all forms except the current one
                  
                  //--- Get the maximum ZOrder
                  long zmax=this.GetZOrderMax();
                  //--- If the maximum ZOrder has been received and the form's ZOrder is less than the maximum one or the maximum ZOrder of all forms is equal to zero
                  if(zmax>WRONG_VALUE && (form.Zorder()<zmax || zmax==0))
                    {
                     //--- If the form is not a control point for managing an extended standard graphical object,
                     //--- set the form's ZOrder above all others
                     if(form.Type()!=OBJECT_DE_TYPE_GFORM_CONTROL)
                        this.SetZOrderMAX(form);
                    }
                 }
              }
            //--- 'The cursor is inside the active area, the mouse wheel is being scrolled' event handler workpiece
            if(mouse_state==MOUSE_FORM_STATE_INSIDE_ACTIVE_AREA_WHEEL)
              {
               
              }
            
            
            //--- 'The cursor is inside the window scrolling area, no mouse buttons are clicked' event handler workpiece
            if(mouse_state==MOUSE_FORM_STATE_INSIDE_SCROLL_AREA_NOT_PRESSED)
              {
               
              }
            //--- 'The cursor is inside the window scrolling area, a mouse button is clicked (any)' event handler workpiece
            if(mouse_state==MOUSE_FORM_STATE_INSIDE_SCROLL_AREA_PRESSED)
              {
               
              }
            //--- 'The cursor is inside the window scrolling area, the mouse wheel is being scrolled' event handler workpiece
            if(mouse_state==MOUSE_FORM_STATE_INSIDE_SCROLL_AREA_WHEEL)
              {
               
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Display the history of renaming the object to the journal        |
//+------------------------------------------------------------------+
void CGraphElementsCollection::PrintRenameHistory(const string name,const long chart_id)
  {
   CGStdGraphObj *obj=this.GetStdGraphObject(name,chart_id);
   if(obj==NULL)
      return;
   obj.PrintRenameHistory();
  }
//+------------------------------------------------------------------+
//| Set the flags of scrolling a chart                               |
//| context menu and crosshairs for the chart                        |
//+------------------------------------------------------------------+
void CGraphElementsCollection::SetChartTools(const long chart_id,const bool flag)
  {
   ::ChartSetInteger(chart_id,CHART_MOUSE_SCROLL,flag);
   ::ChartSetInteger(chart_id,CHART_CONTEXT_MENU,flag);
   ::ChartSetInteger(chart_id,CHART_CROSSHAIR_TOOL,flag);
  }
//+------------------------------------------------------------------+
//| Return screen coordinates                                        |
//| of each graphical object pivot point                             |
//+------------------------------------------------------------------+
bool CGraphElementsCollection::GetPivotPointCoordsAll(CGStdGraphObj *obj,SDataPivotPoint &array_pivots[])
  {
//--- Central point coordinates
   int xc=0, yc=0;
//--- If failed to increase the array of structures to match the number of pivot points,
//--- inform of that in the journal and return 'false'
   if(::ArrayResize(array_pivots,obj.Pivots())!=obj.Pivots())
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_ARRAY_RESIZE);
      return false;
     }
//--- In the loop by the number of graphical object pivot points
   for(int i=0;i<obj.Pivots();i++)
     {
      //--- Convert the object coordinates into screen ones. If failed, inform of that and return 'false'
      if(!::ChartTimePriceToXY(obj.ChartID(),obj.SubWindow(),obj.Time(i),obj.Price(i),array_pivots[i].X,array_pivots[i].Y))
        {
         CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_CONV_GRAPH_OBJ_COORDS_TO_XY);
         return false;
        }
     }
//--- Depending on the graphical object type
   switch(obj.TypeGraphObject())
     {
      //--- One pivot point in screen coordinates
      case OBJ_LABEL             :
      case OBJ_BUTTON            :
      case OBJ_BITMAP_LABEL      :
      case OBJ_EDIT              :
      case OBJ_RECTANGLE_LABEL   :
      case OBJ_CHART             : break;
      
      //--- One pivot point (price only)
      case OBJ_HLINE             : break;
      
      //--- One pivot point (time only)
      case OBJ_VLINE             :
      case OBJ_EVENT             : break;
      
      //--- Two pivot points and a central one
      //--- Lines
      case OBJ_TREND             :
      case OBJ_TRENDBYANGLE      :
      case OBJ_CYCLES            :
      case OBJ_ARROWED_LINE      :
      //--- Channels
      case OBJ_CHANNEL           :
      case OBJ_STDDEVCHANNEL     :
      case OBJ_REGRESSION        :
      //--- Gann
      case OBJ_GANNLINE          :
      case OBJ_GANNGRID          :
      //--- Fibo
      case OBJ_FIBO              :
      case OBJ_FIBOTIMES         :
      case OBJ_FIBOFAN           :
      case OBJ_FIBOARC           :
      case OBJ_FIBOCHANNEL       :
      case OBJ_EXPANSION         :
        //--- Calculate the central point coordinates
        xc=(array_pivots[0].X+array_pivots[1].X)/2;
        yc=(array_pivots[0].Y+array_pivots[1].Y)/2;
        //--- Calculate the shifts of all pivot points from the central one and write them to the structure array
        array_pivots[0].ShiftX=array_pivots[0].X-xc;  // X shift from 0 to the central point
        array_pivots[1].ShiftX=array_pivots[1].X-xc;  // X shift from 1 to the central point
        array_pivots[0].ShiftY=array_pivots[0].Y-yc;  // Y shift from 0 to the central point
        array_pivots[1].ShiftY=array_pivots[1].Y-yc;  // Y shift from 1 to the central point
        return true;

      //--- Channels
      case OBJ_PITCHFORK         : break;
      //--- Gann
      case OBJ_GANNFAN           : break;
      //--- Elliott
      case OBJ_ELLIOTWAVE5       : break;
      case OBJ_ELLIOTWAVE3       : break;
      //--- Shapes
      case OBJ_RECTANGLE         : break;
      case OBJ_TRIANGLE          : break;
      case OBJ_ELLIPSE           : break;
      //--- Arrows
      case OBJ_ARROW_THUMB_UP    : break;
      case OBJ_ARROW_THUMB_DOWN  : break;
      case OBJ_ARROW_UP          : break;
      case OBJ_ARROW_DOWN        : break;
      case OBJ_ARROW_STOP        : break;
      case OBJ_ARROW_CHECK       : break;
      case OBJ_ARROW_LEFT_PRICE  : break;
      case OBJ_ARROW_RIGHT_PRICE : break;
      case OBJ_ARROW_BUY         : break;
      case OBJ_ARROW_SELL        : break;
      case OBJ_ARROW             : break;
      
      //--- Graphical objects with time/price coordinates
      case OBJ_TEXT              : break;
      case OBJ_BITMAP            : break;
      //---
      default: break;
     }
   return false;
  }
//+------------------------------------------------------------------+
