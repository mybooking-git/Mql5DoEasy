//+------------------------------------------------------------------+
//|                                           GStdFiboChannelObj.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "GStdGraphObj.mqh"
//+------------------------------------------------------------------+
//| "Fibo channel" graphical object                                  |
//+------------------------------------------------------------------+
class CGStdFiboChannelObj : public CGStdGraphObj
  {
private:

public:
   //--- Constructor
                     CGStdFiboChannelObj(const long chart_id,const string name) :
                        CGStdGraphObj(OBJECT_DE_TYPE_GSTD_FIBOCHANNEL,GRAPH_OBJ_BELONG_NO_PROGRAM,GRAPH_OBJ_SPECIES_FIBO,chart_id,2,name)
                          {
                           //--- Get and save the object properties
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_RAY_LEFT,0,::ObjectGetInteger(chart_id,name,OBJPROP_RAY_LEFT));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_RAY_RIGHT,0,::ObjectGetInteger(chart_id,name,OBJPROP_RAY_RIGHT));
                           CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_LEVELS,0,::ObjectGetInteger(chart_id,name,OBJPROP_LEVELS));
                           for(int i=0;i<CGStdGraphObj::GetProperty(GRAPH_OBJ_PROP_LEVELS,0);i++)
                             {
                              CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_LEVELCOLOR,i,::ObjectGetInteger(chart_id,name,OBJPROP_LEVELCOLOR,i));
                              CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_LEVELSTYLE,i,::ObjectGetInteger(chart_id,name,OBJPROP_LEVELSTYLE,i));
                              CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_LEVELWIDTH,i,::ObjectGetInteger(chart_id,name,OBJPROP_LEVELWIDTH,i));
                              CGStdGraphObj::SetProperty(GRAPH_OBJ_PROP_LEVELTEXT,i,::ObjectGetString(chart_id,name,OBJPROP_LEVELTEXT,i));
                             }
                          }
   //--- Supported object properties (1) real, (2) integer
   virtual bool      SupportProperty(ENUM_GRAPH_OBJ_PROP_DOUBLE property);
   virtual bool      SupportProperty(ENUM_GRAPH_OBJ_PROP_INTEGER property);
   virtual bool      SupportProperty(ENUM_GRAPH_OBJ_PROP_STRING property);
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
//--- Return the object short name
   virtual string    Header(const bool symbol=false);
//--- Return the description of the (ENUM_OBJECT) graphical object type
   virtual string    TypeDescription(void)   const { return StdGraphObjectTypeDescription(OBJ_FIBOCHANNEL); }
  };
//+------------------------------------------------------------------+
//| Return 'true' if an object supports a passed                     |
//| integer property, otherwise return 'false'                       |
//+------------------------------------------------------------------+
bool CGStdFiboChannelObj::SupportProperty(ENUM_GRAPH_OBJ_PROP_INTEGER property)
  {
   switch((int)property)
     {
      //--- Supported properties
      case GRAPH_OBJ_PROP_ID           :
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
      case GRAPH_OBJ_PROP_STYLE        :
      case GRAPH_OBJ_PROP_WIDTH        :
      case GRAPH_OBJ_PROP_LEVELS       :
      case GRAPH_OBJ_PROP_LEVELCOLOR   :
      case GRAPH_OBJ_PROP_LEVELSTYLE   :
      case GRAPH_OBJ_PROP_LEVELWIDTH   :
      case GRAPH_OBJ_PROP_RAY_LEFT     :
      case GRAPH_OBJ_PROP_RAY_RIGHT    : return true;
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
bool CGStdFiboChannelObj::SupportProperty(ENUM_GRAPH_OBJ_PROP_DOUBLE property)
  {
   switch((int)property)
     {
      //--- Supported properties
      case GRAPH_OBJ_PROP_PRICE        :
      case GRAPH_OBJ_PROP_LEVELVALUE   : return true;
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
bool CGStdFiboChannelObj::SupportProperty(ENUM_GRAPH_OBJ_PROP_STRING property)
  {
   switch((int)property)
     {
      //--- Supported properties
      case GRAPH_OBJ_PROP_NAME            :
      case GRAPH_OBJ_PROP_TEXT            :
      case GRAPH_OBJ_PROP_TOOLTIP         :
      case GRAPH_OBJ_PROP_LEVELTEXT       : return true;
      //--- Other properties are not supported
      //--- Default is 'false'
      default: break;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Return the object short name                                     |
//+------------------------------------------------------------------+
string CGStdFiboChannelObj::Header(const bool symbol=false)
  {
   return this.TypeDescription();
  }
//+------------------------------------------------------------------+
//| Display a short description of the object in the journal         |
//+------------------------------------------------------------------+
void CGStdFiboChannelObj::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print
     (
      this.Header(symbol)," \"",CGBaseObj::Name(),"\": ID ",(string)this.GetProperty(GRAPH_OBJ_PROP_ID,0),
      " ",::TimeToString(CGBaseObj::TimeCreate(),TIME_DATE|TIME_MINUTES|TIME_SECONDS)
     );
  }
//+------------------------------------------------------------------+
