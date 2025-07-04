//+------------------------------------------------------------------+
//|                                                 GStdLabelObj.mqh |
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
//| Text label graphical object                                      |
//+------------------------------------------------------------------+
class CGStdLabelObj : public CGStdGraphObj
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
                     CGStdLabelObj(const long chart_id,const string name,const bool extended) : 
                        CGStdGraphObj(OBJECT_DE_TYPE_GSTD_LABEL,(!extended ? GRAPH_ELEMENT_TYPE_STANDARD : GRAPH_ELEMENT_TYPE_STANDARD_EXTENDED),(!extended ? GRAPH_OBJ_BELONG_NO_PROGRAM : GRAPH_OBJ_BELONG_PROGRAM),GRAPH_OBJ_SPECIES_GRAPHICAL,chart_id,1,name)
                          {
                           //--- Get and save the object properties
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_XDISTANCE,0,::ObjectGetInteger(chart_id,name,OBJPROP_XDISTANCE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_YDISTANCE,0,::ObjectGetInteger(chart_id,name,OBJPROP_YDISTANCE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_XSIZE,0,::ObjectGetInteger(chart_id,name,OBJPROP_XSIZE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_YSIZE,0,::ObjectGetInteger(chart_id,name,OBJPROP_YSIZE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_CORNER,0,::ObjectGetInteger(chart_id,name,OBJPROP_CORNER));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_ANCHOR,0,::ObjectGetInteger(chart_id,name,OBJPROP_ANCHOR));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_ANGLE,0,::ObjectGetDouble(chart_id,name,OBJPROP_ANGLE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_FONTSIZE,0,::ObjectGetInteger(chart_id,name,OBJPROP_FONTSIZE));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_FONT,0,::ObjectGetString(chart_id,name,OBJPROP_FONT));
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
//--- Return the (ENUM_OBJECT) type description
   virtual string    TypeDescription(void)   const { return StdGraphObjectTypeDescription(OBJ_LABEL);       }
//--- Return the description of the graphical object anchor point position
   virtual string    AnchorDescription(void) const { return AnchorForGraphicsObjDescription(this.Anchor()); }

  };
//+------------------------------------------------------------------+
//| Return 'true' if an object supports a passed                     |
//| integer property, otherwise return 'false'                       |
//+------------------------------------------------------------------+
bool CGStdLabelObj::SupportProperty(ENUM_GRAPH_OBJ_PROP_INTEGER property)
  {
   switch((int)property)
     {
      //--- Supported properties
      case GRAPH_OBJ_PROP_ID           :
      case GRAPH_OBJ_PROP_BASE_ID      :
      case GRAPH_OBJ_PROP_TYPE         :
      case GRAPH_OBJ_PROP_ELEMENT_TYPE : 
      case GRAPH_OBJ_PROP_GROUP        : 
      case GRAPH_OBJ_PROP_BELONG       :
      case GRAPH_OBJ_PROP_CHART_ID     :
      case GRAPH_OBJ_PROP_WND_NUM      :
      case GRAPH_OBJ_PROP_NUM          :
      case GRAPH_OBJ_PROP_CREATETIME   :
      case GRAPH_OBJ_PROP_CHANGE_HISTORY:
      case GRAPH_OBJ_PROP_TIMEFRAMES   :
      case GRAPH_OBJ_PROP_BACK         :
      case GRAPH_OBJ_PROP_ZORDER       :
      case GRAPH_OBJ_PROP_HIDDEN       :
      case GRAPH_OBJ_PROP_SELECTED     :
      case GRAPH_OBJ_PROP_SELECTABLE   :
      case GRAPH_OBJ_PROP_TIME         :
      case GRAPH_OBJ_PROP_COLOR        :
      case GRAPH_OBJ_PROP_CORNER       :
      case GRAPH_OBJ_PROP_ANCHOR       :
      case GRAPH_OBJ_PROP_XDISTANCE    :
      case GRAPH_OBJ_PROP_YDISTANCE    :
      case GRAPH_OBJ_PROP_XSIZE        :
      case GRAPH_OBJ_PROP_YSIZE        :
      case GRAPH_OBJ_PROP_FONTSIZE     : return true;
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
bool CGStdLabelObj::SupportProperty(ENUM_GRAPH_OBJ_PROP_DOUBLE property)
  {
   switch((int)property)
     {
      //--- Supported properties
      case GRAPH_OBJ_PROP_ANGLE        :
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
bool CGStdLabelObj::SupportProperty(ENUM_GRAPH_OBJ_PROP_STRING property)
  {
   switch((int)property)
     {
      //--- Supported properties
      case GRAPH_OBJ_PROP_NAME            :
      case GRAPH_OBJ_PROP_BASE_NAME       :
      case GRAPH_OBJ_PROP_TEXT            :
      case GRAPH_OBJ_PROP_TOOLTIP         :
      case GRAPH_OBJ_PROP_FONT            :  return true;
      //--- Other properties are not supported
      //--- Default is 'false'
      default: break;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Return the object short name                                     |
//+------------------------------------------------------------------+
string CGStdLabelObj::Header(const bool symbol=false)
  {
   return this.TypeDescription();
  }
//+------------------------------------------------------------------+
//| Display a short description of the object in the journal         |
//+------------------------------------------------------------------+
void CGStdLabelObj::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print
     (
      (dash ? " - " : "")+this.Header(symbol)," \"",CGBaseObj::Name(),"\": ID ",(string)this.GetProperty(GRAPH_OBJ_PROP_ID,0),
      ", ",::TimeToString(CGBaseObj::TimeCreate(),TIME_DATE|TIME_MINUTES|TIME_SECONDS)
     );
  }
//+------------------------------------------------------------------+
