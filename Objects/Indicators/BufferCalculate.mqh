//+------------------------------------------------------------------+
//|                                              BufferCalculate.mqh |
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
//| Calculated buffer                                                |
//+------------------------------------------------------------------+
class CBufferCalculate : public CBuffer
  {
private:

public:
//--- Constructor
                     CBufferCalculate(const uint index_plot,const uint index_array) :
                        CBuffer(BUFFER_STATUS_NONE,BUFFER_TYPE_CALCULATE,index_plot,index_array,1,1,0,"Calculate")
                           { this.m_type=OBJECT_DE_TYPE_IND_BUFFER_CALCULATE; }
//--- Supported integer properties of a buffer
   virtual bool      SupportProperty(ENUM_BUFFER_PROP_INTEGER property);
//--- Supported real properties of a buffer
   virtual bool      SupportProperty(ENUM_BUFFER_PROP_DOUBLE property);
//--- Supported string properties of a buffer
   virtual bool      SupportProperty(ENUM_BUFFER_PROP_STRING property);
//--- Display a short buffer description in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
   
//--- Set the value to the data buffer array
   void              SetData(const uint series_index,const double value)               { this.SetBufferValue(0,series_index,value);       }
//--- Return the value from the data buffer array
   double            GetData(const uint series_index)                            const { return this.GetDataBufferValue(0,series_index);  }
   
//--- Copy data of the specified indicator to the buffer object array
   int               FillAsSeries(const int indicator_handle,const int buffer_num,const int start_pos,const int count);
   int               FillAsSeries(const int indicator_handle,const int buffer_num,const datetime start_time,const int count);
   int               FillAsSeries(const int indicator_handle,const int buffer_num,const datetime start_time,const datetime stop_time);
   
  };
//+------------------------------------------------------------------+
//| Return 'true' if a buffer supports a passed                      |
//| integer property, otherwise return 'false'                       |
//+------------------------------------------------------------------+
bool CBufferCalculate::SupportProperty(ENUM_BUFFER_PROP_INTEGER property)
  {
   if(
      property==BUFFER_PROP_INDEX_PLOT       || 
      property==BUFFER_PROP_STATUS           ||  
      property==BUFFER_PROP_TYPE             || 
      property==BUFFER_PROP_INDEX_BASE       || 
      property==BUFFER_PROP_ID               || 
      property==BUFFER_PROP_IND_LINE_MODE    || 
      property==BUFFER_PROP_IND_HANDLE       || 
      property==BUFFER_PROP_IND_TYPE         || 
      property==BUFFER_PROP_INDEX_NEXT_BASE
     ) return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Return 'true' if a buffer supports a passed                      |
//| real property, otherwise return 'false'                          |
//+------------------------------------------------------------------+
bool CBufferCalculate::SupportProperty(ENUM_BUFFER_PROP_DOUBLE property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Return 'true' if a buffer supports a passed                      |
//| string property, otherwise return 'false'                        |
//+------------------------------------------------------------------+
bool CBufferCalculate::SupportProperty(ENUM_BUFFER_PROP_STRING property)
  {
   return true;
  }
//+------------------------------------------------------------------+
//| Display short buffer description in the journal                  |
//+------------------------------------------------------------------+
void CBufferCalculate::PrintShort(const bool dash=false,const bool symbol=false)
  {
   ::Print
     (
      CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_BUFFER),"[P",(string)this.IndexPlot(),"/B",(string)this.IndexBase(),"/C",(string)this.IndexColor(),"]: ",
      this.GetTypeBufferDescription()
     );
  }
//+------------------------------------------------------------------+
//| Copy data of the specified indicator to the buffer object array  |
//+------------------------------------------------------------------+
int CBufferCalculate::FillAsSeries(const int indicator_handle,const int buffer_num,const int start_pos,const int count)
  {
   return(#ifdef __MQL5__ ::CopyBuffer(indicator_handle,buffer_num,-start_pos,count,this.DataBuffer[0].Array) #else count #endif );
  }
//+------------------------------------------------------------------+
int CBufferCalculate::FillAsSeries(const int indicator_handle,const int buffer_num,const datetime start_time,const int count)
  {
   return(#ifdef __MQL5__ ::CopyBuffer(indicator_handle,buffer_num,start_time,count,this.DataBuffer[0].Array) #else count #endif );
  }
//+------------------------------------------------------------------+
int CBufferCalculate::FillAsSeries(const int indicator_handle,const int buffer_num,const datetime start_time,const datetime stop_time)
  {
   return
     (
      #ifdef __MQL5__ ::CopyBuffer(indicator_handle,buffer_num,start_time,stop_time,this.DataBuffer[0].Array) 
      #else int(::fabs(start_time-stop_time)/::PeriodSeconds(this.Timeframe())+1) 
      #endif 
     );
  }
//+------------------------------------------------------------------+
