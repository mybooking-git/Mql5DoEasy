//+------------------------------------------------------------------+
//|                                                  BufferArrow.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "Buffer.mqh"
//+------------------------------------------------------------------+
//| Buffer with the "Drawing with arrows" drawing style              |
//+------------------------------------------------------------------+
class CBufferArrow : public CBuffer
  {
private:

public:
//--- Constructor
                     CBufferArrow(const uint index_plot,const uint index_base_array) :
                        CBuffer(BUFFER_STATUS_ARROW,BUFFER_TYPE_DATA,index_plot,index_base_array,1,2,1,"Arrows")
                           { this.m_type=OBJECT_DE_TYPE_IND_BUFFER_ARROW; }
//--- Supported integer properties of a buffer
   virtual bool      SupportProperty(ENUM_BUFFER_PROP_INTEGER property);
//--- Supported real properties of a buffer
   virtual bool      SupportProperty(ENUM_BUFFER_PROP_DOUBLE property);
//--- Supported string properties of a buffer
   virtual bool      SupportProperty(ENUM_BUFFER_PROP_STRING property);
//--- Display a short buffer description in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
   
   
//--- Set (1) the arrow code, (2) vertical shift of arrows
   virtual void      SetArrowCode(const uchar code);
   virtual void      SetArrowShift(const int shift);
   
//--- Set the value to the data buffer array
   void              SetData(const uint series_index,const double value)               { this.SetBufferValue(0,series_index,value);       }
//--- Return the value from the data buffer array
   double            GetData(const uint series_index)                            const { return this.GetDataBufferValue(0,series_index);  }
   
  };
//+------------------------------------------------------------------+
//| Return 'true' if a buffer supports a passed                      |
//| integer property, otherwise return 'false'                       |
//+------------------------------------------------------------------+
bool CBufferArrow::SupportProperty(ENUM_BUFFER_PROP_INTEGER property)
  {
   if(property==BUFFER_PROP_LINE_STYLE || 
      (
       this.TypeBuffer()==BUFFER_TYPE_CALCULATE && 
       property!=BUFFER_PROP_TYPE && 
       property!=BUFFER_PROP_INDEX_NEXT_BASE &&
       property!=BUFFER_PROP_IND_LINE_MODE && 
       property!=BUFFER_PROP_IND_HANDLE &&
       property!=BUFFER_PROP_IND_TYPE &&
       property!=BUFFER_PROP_IND_LINE_ADDITIONAL_NUM &&
       property!=BUFFER_PROP_ID
      )
     )
      return false;
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if a buffer supports a passed                      |
//| real property, otherwise return 'false'                          |
//+------------------------------------------------------------------+
bool CBufferArrow::SupportProperty(ENUM_BUFFER_PROP_DOUBLE property)
  {
   if(this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return false;
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if a buffer supports a passed                      |
//| string property, otherwise return 'false'                        |
//+------------------------------------------------------------------+
bool CBufferArrow::SupportProperty(ENUM_BUFFER_PROP_STRING property)
  {
   if(this.TypeBuffer()==BUFFER_TYPE_CALCULATE && property!=BUFFER_PROP_IND_NAME_SHORT)
      return false;
   return true;
  }
//+------------------------------------------------------------------+
//| Display short buffer description in the journal                  |
//+------------------------------------------------------------------+
void CBufferArrow::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print
     (
      CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_BUFFER),"(P",(string)this.IndexPlot(),"/B",(string)this.IndexBase(),"/C",(string)this.IndexColor(),"): ",
      this.GetStatusDescription(true)," ",this.Symbol()," ",TimeframeDescription(this.Timeframe())
     );
  }
//+------------------------------------------------------------------+
//| Set the arrow code                                               |
//+------------------------------------------------------------------+
void CBufferArrow::SetArrowCode(const uchar code)
  {
   this.SetProperty(BUFFER_PROP_ARROW_CODE,code);
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_ARROW,code);
  }
//+------------------------------------------------------------------+
//| Set the vertical shift of the arrows                             |
//+------------------------------------------------------------------+
void CBufferArrow::SetArrowShift(const int shift)
  {
   this.SetProperty(BUFFER_PROP_ARROW_SHIFT,shift);
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_ARROW_SHIFT,shift);
  }
//+------------------------------------------------------------------+
