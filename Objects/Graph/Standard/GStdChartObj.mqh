//+------------------------------------------------------------------+
//|                                                 GStdChartObj.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "GStdGraphObj.mqh"
//+------------------------------------------------------------------+
//| Chart graphical object                                           |
//+------------------------------------------------------------------+
class CGStdChartObj : public CGStdGraphObj
  {
private:
   void              CoordsToTimePrice(void)
                       {
                        int      subwnd;
                        datetime time;
                        double   price;
                        if(::ChartXYToTimePrice(m_chart_id,(int)this.XDistance(),(int)this.YDistance(),subwnd,time,price))
                          {
                           this.SetTime(time,0);
                           this.SetPrice(price,0);
                          }
                       }
public:
   //--- Constructor
                     CGStdChartObj(const long chart_id,const string name,const bool extended) : 
                        CGStdGraphObj(OBJECT_DE_TYPE_GSTD_CHART,(!extended ? GRAPH_ELEMENT_TYPE_STANDARD : GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED),(!extended ? GRAPH_OBJ_BELONG_NO_PROGRAM : GRAPH_OBJ_BELONG_PROGRAM),GRAPH_OBJ_SPECIES_GRAPHICAL,chart_id,1,name)
                          {
                           //--- Get and save the object properties
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_XDISTANCE,0,::ObjectGetInteger(chart_id,name,OBJPROP_XDISTANCE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_YDISTANCE,0,::ObjectGetInteger(chart_id,name,OBJPROP_YDISTANCE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_XSIZE,0,::ObjectGetInteger(chart_id,name,OBJPROP_XSIZE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_YSIZE,0,::ObjectGetInteger(chart_id,name,OBJPROP_YSIZE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_CORNER,0,::ObjectGetInteger(chart_id,name,OBJPROP_CORNER));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_CHART_ID,0,::ObjectGetInteger(chart_id,name,OBJPROP_CHART_ID));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_PERIOD,0,::ObjectGetInteger(chart_id,name,OBJPROP_PERIOD));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_DATE_SCALE,0,::ObjectGetInteger(chart_id,name,OBJPROP_DATE_SCALE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_PRICE_SCALE,0,::ObjectGetInteger(chart_id,name,OBJPROP_PRICE_SCALE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_CHART_SCALE,0,::ObjectGetInteger(chart_id,name,OBJPROP_CHART_SCALE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_CHART_OBJ_SYMBOL,0,::ObjectGetString(chart_id,name,OBJPROP_SYMBOL));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_ANCHOR,0,ANCHOR_LEFT_UPPER);
                           this.CoordsToTimePrice();
                          }
   //--- Supported object properties (1) real, (2) integer
   virtual bool      SupportProperty(ENUM_GRAPH_OBJ_PROP_DOUBLE property);
   virtual bool      SupportProperty(ENUM_GRAPH_OBJ_PROP_INTEGER property);
   virtual bool      SupportProperty(ENUM_GRAPH_OBJ_PROP_STRING property);
//--- Return the graphical object anchor point position
   ENUM_ANCHOR_POINT Anchor(void)            const { return (ENUM_ANCHOR_POINT)this.GetProperty(GRAPH_OBJ_PROP_ANCHOR,0); }
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
//--- Return the object short name
   virtual string    Header(const bool symbol=false);
//--- Return the description of the (ENUM_OBJECT) graphical object type
   virtual string    TypeDescription(void)   const { return StdGraphObjectTypeDescription(OBJ_CHART);        }
//--- Return the description of the graphical object anchor point position
   virtual string    AnchorDescription(void) const { return AnchorForGraphicsObjDescription(this.Anchor()); }

  };
//+------------------------------------------------------------------+
//| Return 'true' if an object supports a passed                     |
//| integer property, otherwise return 'false'                       |
//+------------------------------------------------------------------+
bool CGStdChartObj::SupportProperty(ENUM_GRAPH_OBJ_PROP_INTEGER property)
  {
   switch((int)property)
     {
      //--- Supported properties
      case GRAPH_OBJ_PROP_ID           :
      case GRAPH_OBJ_PROP_BASE_ID      :
      case GRAPH_OBJ_PROP_TYPE                  :
      case GRAPH_OBJ_PROP_ELEMENT_TYPE          : 
      case GRAPH_OBJ_PROP_GROUP                 : 
      case GRAPH_OBJ_PROP_BELONG                :
      case GRAPH_OBJ_PROP_CHART_ID              :
      case GRAPH_OBJ_PROP_WND_NUM               :
      case GRAPH_OBJ_PROP_NUM                   :
      case GRAPH_OBJ_PROP_CREATETIME            :
      case GRAPH_OBJ_PROP_CHANGE_HISTORY         :
      case GRAPH_OBJ_PROP_TIMEFRAMES            :
      case GRAPH_OBJ_PROP_BACK                  :
      case GRAPH_OBJ_PROP_ZORDER                :
      case GRAPH_OBJ_PROP_HIDDEN                :
      case GRAPH_OBJ_PROP_SELECTED              :
      case GRAPH_OBJ_PROP_SELECTABLE            :
      case GRAPH_OBJ_PROP_TIME                  :
      case GRAPH_OBJ_PROP_COLOR                 :
      case GRAPH_OBJ_PROP_CORNER                :
      case GRAPH_OBJ_PROP_XDISTANCE             :
      case GRAPH_OBJ_PROP_YDISTANCE             :
      case GRAPH_OBJ_PROP_XSIZE                 :
      case GRAPH_OBJ_PROP_YSIZE                 :
      case GRAPH_OBJ_PROP_CHART_OBJ_CHART_ID    :
      case GRAPH_OBJ_PROP_CHART_OBJ_DATE_SCALE  :
      case GRAPH_OBJ_PROP_CHART_OBJ_PRICE_SCALE :
      case GRAPH_OBJ_PROP_CHART_OBJ_CHART_SCALE :
      case GRAPH_OBJ_PROP_CHART_OBJ_PERIOD      : return true;
      //--- Other properties are not supported
      //--- Default is 'false'
      default: break;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Return 'true' if an object supports a passed                     |
//| real property, otherwise return 'false'                          |
//+------------------------------------------------------------------+
bool CGStdChartObj::SupportProperty(ENUM_GRAPH_OBJ_PROP_DOUBLE property)
  {
   switch((int)property)
     {
      //--- Supported properties
      case GRAPH_OBJ_PROP_PRICE        : return true;
      //--- Other properties are not supported
      //--- Default is 'false'
      default: break;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Return 'true' if an object supports a passed                     |
//| string property, otherwise return 'false'                        |
//+------------------------------------------------------------------+
bool CGStdChartObj::SupportProperty(ENUM_GRAPH_OBJ_PROP_STRING property)
  {
   switch((int)property)
     {
      //--- Supported properties
      case GRAPH_OBJ_PROP_CHART_OBJ_SYMBOL:
      case GRAPH_OBJ_PROP_NAME            :
      case GRAPH_OBJ_PROP_BASE_NAME       :
      case GRAPH_OBJ_PROP_TEXT            :
      case GRAPH_OBJ_PROP_TOOLTIP         :  return true;
      //--- Other properties are not supported
      //--- Default is 'false'
      default: break;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Return the object short name                                     |
//+------------------------------------------------------------------+
string CGStdChartObj::Header(const bool symbol=false)
  {
   return this.TypeDescription();
  }
//+------------------------------------------------------------------+
//| Display a short description of the object in the journal         |
//+------------------------------------------------------------------+
void CGStdChartObj::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print
     (
      (dash ? " - " : "")+this.Header(symbol)," \"",CGBaseObj::Name(),"\": ID ",(string)this.GetProperty(GRAPH_OBJ_PROP_ID,0),
      ", ",::TimeToString(CGBaseObj::TimeCreate(),TIME_DATE|TIME_MINUTES|TIME_SECONDS)
     );
  }
//+------------------------------------------------------------------+
