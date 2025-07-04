//+------------------------------------------------------------------+
//|                                              StdGraphObjComp.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
//#include "ListObj.mqh"
//#include "..\Services\Select.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdVLineObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdHLineObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdTrendObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdTrendByAngleObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdCiclesObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowedLineObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdChannelObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdStdDevChannelObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdRegressionObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdPitchforkObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdGannLineObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdGannFanObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdGannGridObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdFiboObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdFiboTimesObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdFiboFanObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdFiboArcObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdFiboChannelObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdExpansionObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdElliotWave5Obj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdElliotWave3Obj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdRectangleObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdTriangleObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdEllipseObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowThumbUpObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowThumbDownObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowUpObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowDownObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowStopObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowCheckObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowLeftPriceObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowRightPriceObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowBuyObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowSellObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdArrowObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdTextObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdLabelObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdButtonObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdChartObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdBitmapObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdBitmapLabelObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdEditObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdEventObj.mqh"
#include "..\..\..\Objects\Graph\Standard\GStdRectangleLabelObj.mqh"
//+------------------------------------------------------------------+
//| Class of the bound graphical object pivot point                  |
//+------------------------------------------------------------------+
class CLinkedPivotPoint
  {
private:
   
public:
                     CLinkedPivotPoint(void);
                    ~CLinkedPivotPoint(void);
  };
//+------------------------------------------------------------------+
//| Container class of the composite graphical object data           |
//+------------------------------------------------------------------+
class CCompObjData : public CObject
  {
private:
   int               m_coord_x;
public:
                     CCompObjData (void);
                    ~CCompObjData (void);
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Composite standard graphical object class                        |
//+------------------------------------------------------------------+
class CGStdGraphObjExt
  {
private:
   CArrayObj         m_list;                       // List of dependent graphical objects
   CGStdGraphObj    *m_base_obj;                   // Pointer to the base graphical object
   long              m_chart_id;                   // Chart ID
   string            m_name_base;                  // Base graphical object name
//--- Create a new object of the specified graphical object class
   CGStdGraphObj    *CreateNewGraphObj(const ENUM_OBJECT obj_type,const string name);
public:
//--- Return (1) the list of dependent objects, (2) base, (3) dependent graphical object by index
   CArrayObj        *List(void)                       { return &this.m_list;                             }
   CGStdGraphObj    *GetBaseObject(void)              { return this.m_list.At(0);                        }
   CGStdGraphObj    *GetDependentObj(const int index) { return(index>0 ? this.m_list.At(index) : NULL);  }
//--- Return the name of the (1) base and (2) subordinate graphical object by index
   string            Name(void)                       { return this.m_name_base;                         }
   string            Name(const int index);
//--- Add subordinate graphical object
   bool              AddDependentObj(const ENUM_OBJECT obj_type,const string name);
//--- Return the chart ID
   long              ChartID(void)              const { return this.m_chart_id;  }
//--- Constructor/destructor
                     CGStdGraphObjExt(const long chart_id,const ENUM_OBJECT base_obj_type,const string name);
                    ~CGStdGraphObjExt();
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CGStdGraphObjExt::CGStdGraphObjExt(const long chart_id,const ENUM_OBJECT base_obj_type,const string name)
  {
   this.m_chart_id=chart_id;
   m_name_base=name;
   this.m_base_obj=this.CreateNewGraphObj(base_obj_type,name);
   if(m_base_obj==NULL)
     {
      CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_CREATE_NEW_BASE_COMP_OBJ);
      return;
     }
   if(!this.m_list.Add(this.m_base_obj))
     {
      CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_ADD_BASE_COMP_OBJ_TO_LIST);
      delete this.m_base_obj;
      return;
     }
   this.m_base_obj.SetNumber(0);
   this.m_base_obj.SetTypeElement(GRAPH_ELEMENT_TYPE_COMPOSITE);
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CGStdGraphObjExt::~CGStdGraphObjExt()
  {
   
  }
//+------------------------------------------------------------------+
//| Create a new object of the specified graphical object class      |
//+------------------------------------------------------------------+
CGStdGraphObj *CGStdGraphObjExt::CreateNewGraphObj(const ENUM_OBJECT obj_type,const string name)
  {
   switch((int)obj_type)
     {
      //--- Lines
      case OBJ_VLINE             : return new CGStdVLineObj(this.ChartID(),name);
      case OBJ_HLINE             : return new CGStdHLineObj(this.ChartID(),name);
      case OBJ_TREND             : return new CGStdTrendObj(this.ChartID(),name);
      case OBJ_TRENDBYANGLE      : return new CGStdTrendByAngleObj(this.ChartID(),name);
      case OBJ_CYCLES            : return new CGStdCyclesObj(this.ChartID(),name);
      case OBJ_ARROWED_LINE      : return new CGStdArrowedLineObj(this.ChartID(),name);
      //--- Channels
      case OBJ_CHANNEL           : return new CGStdChannelObj(this.ChartID(),name);
      case OBJ_STDDEVCHANNEL     : return new CGStdStdDevChannelObj(this.ChartID(),name);
      case OBJ_REGRESSION        : return new CGStdRegressionObj(this.ChartID(),name);
      case OBJ_PITCHFORK         : return new CGStdPitchforkObj(this.ChartID(),name);
      //--- Gann
      case OBJ_GANNLINE          : return new CGStdGannLineObj(this.ChartID(),name);
      case OBJ_GANNFAN           : return new CGStdGannFanObj(this.ChartID(),name);
      case OBJ_GANNGRID          : return new CGStdGannGridObj(this.ChartID(),name);
      //--- Fibo
      case OBJ_FIBO              : return new CGStdFiboObj(this.ChartID(),name);
      case OBJ_FIBOTIMES         : return new CGStdFiboTimesObj(this.ChartID(),name);
      case OBJ_FIBOFAN           : return new CGStdFiboFanObj(this.ChartID(),name);
      case OBJ_FIBOARC           : return new CGStdFiboArcObj(this.ChartID(),name);
      case OBJ_FIBOCHANNEL       : return new CGStdFiboChannelObj(this.ChartID(),name);
      case OBJ_EXPANSION         : return new CGStdExpansionObj(this.ChartID(),name);
      //--- Elliott
      case OBJ_ELLIOTWAVE5       : return new CGStdElliotWave5Obj(this.ChartID(),name);
      case OBJ_ELLIOTWAVE3       : return new CGStdElliotWave3Obj(this.ChartID(),name);
      //--- Shapes
      case OBJ_RECTANGLE         : return new CGStdRectangleObj(this.ChartID(),name);
      case OBJ_TRIANGLE          : return new CGStdTriangleObj(this.ChartID(),name);
      case OBJ_ELLIPSE           : return new CGStdEllipseObj(this.ChartID(),name);
      //--- Arrows
      case OBJ_ARROW_THUMB_UP    : return new CGStdArrowThumbUpObj(this.ChartID(),name);
      case OBJ_ARROW_THUMB_DOWN  : return new CGStdArrowThumbDownObj(this.ChartID(),name);
      case OBJ_ARROW_UP          : return new CGStdArrowUpObj(this.ChartID(),name);
      case OBJ_ARROW_DOWN        : return new CGStdArrowDownObj(this.ChartID(),name);
      case OBJ_ARROW_STOP        : return new CGStdArrowStopObj(this.ChartID(),name);
      case OBJ_ARROW_CHECK       : return new CGStdArrowCheckObj(this.ChartID(),name);
      case OBJ_ARROW_LEFT_PRICE  : return new CGStdArrowLeftPriceObj(this.ChartID(),name);
      case OBJ_ARROW_RIGHT_PRICE : return new CGStdArrowRightPriceObj(this.ChartID(),name);
      case OBJ_ARROW_BUY         : return new CGStdArrowBuyObj(this.ChartID(),name);
      case OBJ_ARROW_SELL        : return new CGStdArrowSellObj(this.ChartID(),name);
      case OBJ_ARROW             : return new CGStdArrowObj(this.ChartID(),name);
      //--- Graphical objects
      case OBJ_TEXT              : return new CGStdTextObj(this.ChartID(),name);
      case OBJ_LABEL             : return new CGStdLabelObj(this.ChartID(),name);
      case OBJ_BUTTON            : return new CGStdButtonObj(this.ChartID(),name);
      case OBJ_CHART             : return new CGStdChartObj(this.ChartID(),name);
      case OBJ_BITMAP            : return new CGStdBitmapObj(this.ChartID(),name);
      case OBJ_BITMAP_LABEL      : return new CGStdBitmapLabelObj(this.ChartID(),name);
      case OBJ_EDIT              : return new CGStdEditObj(this.ChartID(),name);
      case OBJ_EVENT             : return new CGStdEventObj(this.ChartID(),name);
      case OBJ_RECTANGLE_LABEL   : return new CGStdRectangleLabelObj(this.ChartID(),name);
      default                    : return NULL;
     }
  }
//+------------------------------------------------------------------+
//| Return the name of a subordinate graphical object by index       |
//+------------------------------------------------------------------+
string CGStdGraphObjExt::Name(const int index)
  {
   CGStdGraphObj *obj=this.GetDependentObj(index);
   return(obj!=NULL ? obj.Name() : "");
  }
//+------------------------------------------------------------------+
//| Add subordinate graphical object                                 |
//+------------------------------------------------------------------+
bool CGStdGraphObjExt::AddDependentObj(const ENUM_OBJECT obj_type,const string name)
  {
   CGStdGraphObj *obj=this.CreateNewGraphObj(obj_type,name);
   if(obj==NULL)
     {
      CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_CREATE_NEW_DEP_COMP_OBJ);
      return false;
     }
   if(!m_list.Add(obj))
     {
      CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_FAILED_ADD_DEP_COMP_OBJ_TO_LIST);
      delete obj;
      return false;
     }
   obj.SetNumber(this.m_list.Total()-1);
   return true;
  }
//+------------------------------------------------------------------+
