//+------------------------------------------------------------------+
//|                                            BuffersCollection.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "ListObj.mqh"
#include "..\Objects\Indicators\BufferArrow.mqh"
#include "..\Objects\Indicators\BufferLine.mqh"
#include "..\Objects\Indicators\BufferSection.mqh"
#include "..\Objects\Indicators\BufferHistogram.mqh"
#include "..\Objects\Indicators\BufferHistogram2.mqh"
#include "..\Objects\Indicators\BufferZigZag.mqh"
#include "..\Objects\Indicators\BufferFilling.mqh"
#include "..\Objects\Indicators\BufferBars.mqh"
#include "..\Objects\Indicators\BufferCandles.mqh"
#include "..\Objects\Indicators\BufferCalculate.mqh"
#include "TimeSeriesCollection.mqh"
#include "IndicatorsCollection.mqh"
//+------------------------------------------------------------------+
//| Collection of indicator buffers                                  |
//+------------------------------------------------------------------+
class CBuffersCollection : public CObject
  {
private:
   CListObj                m_list;                       // Buffer object list
   CTimeSeriesCollection  *m_timeseries;                 // Pointer to the timeseries collection object
   CIndicatorsCollection  *m_indicators;                 // Pointer to collection object of indicators
   MqlParam                m_mql_param[];                // Array of indicator parameters
   int                     m_type;                       // Object type
//--- Return the index of the (1) last, (2) next drawn and (3) basic buffer
   int                     GetIndexLastPlot(void);
   int                     GetIndexNextPlot(void);
   int                     GetIndexNextBase(void);
//--- Create a new buffer object and place it to the collection list
   bool                    CreateBuffer(ENUM_BUFFER_STATUS status);
//--- Get data of the necessary timeseries and bars for working with a single buffer bar, and return the number of bars
   int                     GetBarsData(CBuffer *buffer,const int series_index,int &index_bar_period);

public:
//--- Return (1) itself, (2) timeseries list, (3) indicator buffer list (featuring the ID of belonging to an indicator)
   CBuffersCollection     *GetObject(void)               { return &this;                                       }
   CArrayObj              *GetList(void)                 { return &this.m_list;                                }
   CArrayObj              *GetListBuffersWithID(void);
//--- Return the number of (1) drawn buffers, (2) all arrays used to build all buffers in the collection
   int                     PropertyPlotsTotal(void);
   int                     PropertyBuffersTotal(void);
   
//--- Create the new buffer (1) "Drawing with arrows", (2) "Line", (3) "Sections", (4) "Histogram from the zero line", 
//--- (5) "Histogram on two indicator buffers", (6) "Zigzag", (7) "Color filling between two levels",
//--- (8) "Display as bars", (9) "Display as candles", calculated buffer
   bool                    CreateArrow(void)             { return this.CreateBuffer(BUFFER_STATUS_ARROW);      }
   bool                    CreateLine(void)              { return this.CreateBuffer(BUFFER_STATUS_LINE);       }
   bool                    CreateSection(void)           { return this.CreateBuffer(BUFFER_STATUS_SECTION);    }
   bool                    CreateHistogram(void)         { return this.CreateBuffer(BUFFER_STATUS_HISTOGRAM);  }
   bool                    CreateHistogram2(void)        { return this.CreateBuffer(BUFFER_STATUS_HISTOGRAM2); }
   bool                    CreateZigZag(void)            { return this.CreateBuffer(BUFFER_STATUS_ZIGZAG);     }
   bool                    CreateFilling(void)           { return this.CreateBuffer(BUFFER_STATUS_FILLING);    }
   bool                    CreateBars(void)              { return this.CreateBuffer(BUFFER_STATUS_BARS);       }
   bool                    CreateCandles(void)           { return this.CreateBuffer(BUFFER_STATUS_CANDLES);    }
   bool                    CreateCalculate(void)         { return this.CreateBuffer(BUFFER_STATUS_NONE);       }

//--- Create a multi-symbol multi-period indicator
   int                     CreateAC(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id=WRONG_VALUE);
   int                     CreateAD(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume,const int id=WRONG_VALUE);
   int                     CreateADX(const string symbol,const ENUM_TIMEFRAMES timeframe,const int adx_period,const int id=WRONG_VALUE);
   int                     CreateADXWilder(const string symbol,const ENUM_TIMEFRAMES timeframe,const int adx_period,const int id=WRONG_VALUE);
   int                     CreateAlligator(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int jaw_period,
                                       const int jaw_shift,
                                       const int teeth_period,
                                       const int teeth_shift,
                                       const int lips_period,
                                       const int lips_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ama_period,
                                       const int fast_ema_period,
                                       const int slow_ema_period,
                                       const int ama_shift,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateAO(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id=WRONG_VALUE);
   int                     CreateATR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id=WRONG_VALUE);
   int                     CreateBands(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const double deviation,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateBearsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id=WRONG_VALUE);
   int                     CreateBullsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id=WRONG_VALUE);
   int                     CreateChaikin(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int fast_ma_period,
                                       const int slow_ma_period,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_VOLUME applied_volume,
                                       const int id=WRONG_VALUE);
   int                     CreateCCI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateDEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateDeMarker(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id=WRONG_VALUE);
   int                     CreateEnvelopes(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const double deviation,
                                       const int id=WRONG_VALUE);
   int                     CreateForce(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_VOLUME applied_volume,
                                       const int id=WRONG_VALUE);
   int                     CreateFractals(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id=WRONG_VALUE);
   int                     CreateFrAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateGator(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int jaw_period,
                                       const int jaw_shift,
                                       const int teeth_period,
                                       const int teeth_shift,
                                       const int lips_period,
                                       const int lips_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateIchimoku(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int tenkan_sen,
                                       const int kijun_sen,
                                       const int senkou_span_b,
                                       const int id=WRONG_VALUE);
   int                     CreateBWMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const ENUM_APPLIED_VOLUME applied_volume,
                                       const int id=WRONG_VALUE);
   int                     CreateMomentum(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int mom_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_VOLUME applied_volume,
                                       const int id=WRONG_VALUE);
   int                     CreateMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateOsMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int fast_ema_period,
                                       const int slow_ema_period,
                                       const int signal_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateMACD(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int fast_ema_period,
                                       const int slow_ema_period,
                                       const int signal_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateOBV(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const ENUM_APPLIED_VOLUME applied_volume,
                                       const int id=WRONG_VALUE);
   int                     CreateSAR(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const double step,
                                       const double maximum,
                                       const int id=WRONG_VALUE);
   int                     CreateRSI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateRVI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id=WRONG_VALUE);
   int                     CreateStdDev(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateStochastic(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int Kperiod,
                                       const int Dperiod,
                                       const int slowing,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_STO_PRICE price_field,
                                       const int id=WRONG_VALUE);
   int                     CreateTEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateTriX(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateWPR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int calc_period,const int id=WRONG_VALUE);
   int                     CreateVIDYA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int cmo_period,
                                       const int ema_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE);
   int                     CreateVolumes(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume,const int id=WRONG_VALUE);
   
//--- Prepare calculated buffer data of (1) the specified standard indicator and (2) all created standard indicators
   int                     PreparingDataBufferStdInd(const ENUM_INDICATOR std_ind,const int id,const int total_copy);
   bool                    PreparingDataAllBuffersStdInd(void);
//--- Clear buffer data (1) of the specified standard indicator and (2) all created standard indicators by the timeseries index
   void                    ClearDataBufferStdInd(const ENUM_INDICATOR std_ind,const int id,const int series_index);
   void                    ClearDataAllBuffersStdInd(int series_index);
//--- Set values for the current chart to buffers of the specified standard indicator by the timeseries index in accordance with buffer object symbol/period
   bool                    SetDataBufferStdInd(const ENUM_INDICATOR std_ind,const int id,const int series_index,const datetime series_time,const char color_index=WRONG_VALUE);
private:
//--- Prepare data of the specified standard indicator for setting values on the current symbol chart
   int                     PreparingSetDataStdInd(CBuffer *buffer_data0,CBuffer *buffer_data1,CBuffer *buffer_data2,CBuffer *buffer_data3,CBuffer *buffer_data4,
                                                  CBuffer *buffer_calc0,CBuffer *buffer_calc1,CBuffer *buffer_calc2,CBuffer *buffer_calc3,CBuffer *buffer_calc4,
                                                  const ENUM_INDICATOR ind_type,
                                                  const int series_index,
                                                  const datetime series_time,
                                                  int &index_period,
                                                  int &num_bars,
                                                  double &value00,
                                                  double &value01,
                                                  double &value10,
                                                  double &value11,
                                                  double &value20,
                                                  double &value21,
                                                  double &value30,
                                                  double &value31,
                                                  double &value40,
                                                  double &value41);
public:

//--- Return the buffer (1) by the graphical series name, (2) by timeframe,
//--- (3) by Plot index, (4) by object index in the collection list, (5) the last created one,
//--- (6) standard indicator buffer by indicator type, its ID and line
   CBuffer                *GetBufferByLabel(const string plot_label);
   CBuffer                *GetBufferByTimeframe(const ENUM_TIMEFRAMES timeframe);
   CBuffer                *GetBufferByPlot(const int plot_index);
   CBuffer                *GetBufferByListIndex(const int index_list);
   CBuffer                *GetLastCreateBuffer(void);
   CBuffer                *GetBufferStdInd(const ENUM_INDICATOR indicator_type,const int id,const ENUM_INDICATOR_LINE_MODE line_mode,const char additional_id=WRONG_VALUE);
//--- Return buffer list (1) by ID, (2) standard indicator type, (3) type and ID
   CArrayObj              *GetListBufferByID(const int id);
   CArrayObj              *GetListBufferByIndType(const ENUM_INDICATOR indicator_type);
   CArrayObj              *GetListBufferByTypeID(const ENUM_INDICATOR indicator_type,const int id);
//--- Return buffers by their status by the specified serial number
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   CBufferArrow           *GetBufferArrow(const int number);
   CBufferLine            *GetBufferLine(const int number);
   CBufferSection         *GetBufferSection(const int number);
   CBufferHistogram       *GetBufferHistogram(const int number);
   CBufferHistogram2      *GetBufferHistogram2(const int number);
   CBufferZigZag          *GetBufferZigZag(const int number);
   CBufferFilling         *GetBufferFilling(const int number);
   CBufferBars            *GetBufferBars(const int number);
   CBufferCandles         *GetBufferCandles(const int number);
   CBufferCalculate       *GetBufferCalculate(const int number);
   
//--- Initialize all drawn buffers by a (1) specified value, (2) empty value set for the buffer object
   void                    InitializePlots(const double value,const uchar color_index);
   void                    InitializePlots(void);
//--- Initialize all calculated buffers by a (1) specified value, (2) empty value set for the buffer object
   void                    InitializeCalculates(const double value);
   void                    InitializeCalculates(void);
//--- Set color values from the passed color array for all indicator buffers within the collection
   void                    SetColors(const color &array_colors[]);
   
//--- Set the value by the timeseries index for the (1) arrow, (2) line, (3) section, (4) zero line histogram,
//--- (5) two buffer histogram, (6) zigzag, (7) filling, (8) bar, (9) candle, (10) calculated buffer
   void                    SetBufferArrowValue(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false);
   void                    SetBufferLineValue(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false);
   void                    SetBufferSectionValue(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false);
   void                    SetBufferHistogramValue(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false);
   void                    SetBufferHistogram2Value(const int number,const int series_index,const double value1,const double value2,const uchar color_index,bool as_current=false);
   void                    SetBufferZigZagValue(const int number,const int series_index,const double value1,const double value2,const uchar color_index,bool as_current=false);
   void                    SetBufferFillingValue(const int number,const int series_index,const double value1,const double value2,bool as_current=false);
   void                    SetBufferBarsValue(const int number,const int series_index,const double open,const double high,const double low,const double close,const uchar color_index,bool as_current=false);
   void                    SetBufferCandlesValue(const int number,const int series_index,const double open,const double high,const double low,const double close,const uchar color_index,bool as_current=false);
   void                    SetBufferCalculateValue(const int number,const int series_index,const double value);
   
//--- Set the color index to the color buffer by its serial number of
//--- (1) arrows, (2) lines, (3) sections, (4) zero histogram buffer
//--- (5) histogram on two buffers, (6) zigzag, (7) filling, (8) bars and (9) candles
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   void                    SetBufferArrowColorIndex(const int number,const int series_index,const uchar color_index);
   void                    SetBufferLineColorIndex(const int number,const int series_index,const uchar color_index);
   void                    SetBufferSectionColorIndex(const int number,const int series_index,const uchar color_index);
   void                    SetBufferHistogramColorIndex(const int number,const int series_index,const uchar color_index);
   void                    SetBufferHistogram2ColorIndex(const int number,const int series_index,const uchar color_index);
   void                    SetBufferZigZagColorIndex(const int number,const int series_index,const uchar color_index);
   void                    SetBufferFillingColorIndex(const int number,const int series_index,const uchar color_index);
   void                    SetBufferBarsColorIndex(const int number,const int series_index,const uchar color_index);
   void                    SetBufferCandlesColorIndex(const int number,const int series_index,const uchar color_index);
   
//--- Clear buffer data by its index in the list in the specified timeseries bar
   void                    Clear(const int buffer_list_index,const int series_index);
//--- Clear data by the timeseries index for the (1) arrow, (2) line, (3) section, (4) zero line histogram,
//--- (5) histogram on two buffers, (6) zigzag, (7) filling, (8) bars and (9) candles
   void                    ClearBufferArrow(const int number,const int series_index);
   void                    ClearBufferLine(const int number,const int series_index);
   void                    ClearBufferSection(const int number,const int series_index);
   void                    ClearBufferHistogram(const int number,const int series_index);
   void                    ClearBufferHistogram2(const int number,const int series_index);
   void                    ClearBufferZigZag(const int number,const int series_index);
   void                    ClearBufferFilling(const int number,const int series_index);
   void                    ClearBufferBars(const int number,const int series_index);
   void                    ClearBufferCandles(const int number,const int series_index);
   
//--- Return the standard indicator buffer description by type and ID
   string                  GetLabelByTypeID(const ENUM_INDICATOR ind_type,const int id,const ENUM_INDICATOR_LINE_MODE line_mode=INDICATOR_LINE_MODE_MAIN);
//--- Return (1) the standard indicator short name by type and ID and (2) object type
   string                  GetIndicatorShortNameByTypeID(const ENUM_INDICATOR ind_type,const int id);
   virtual int             Type(void)  const { return this.m_type;   }

//--- Constructor
                           CBuffersCollection();
//--- Get pointers to collections of timeseries and indicators (the method is called in CollectionOnInit() method of the CEngine object)
   void                    OnInit(CTimeSeriesCollection *timeseries,CIndicatorsCollection *indicators)
                             { this.m_timeseries=timeseries; this.m_indicators=indicators;   }
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CBuffersCollection::CBuffersCollection()
  {
   this.m_type=COLLECTION_BUFFERS_ID;
   this.m_list.Clear();
   this.m_list.Sort();
   this.m_list.Type(COLLECTION_BUFFERS_ID);
  }
//+------------------------------------------------------------------+
//| Initialize all drawn buffers by a specified empty value          |
//+------------------------------------------------------------------+
void CBuffersCollection::InitializePlots(const double value,const uchar color_index)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_TYPE,BUFFER_TYPE_DATA,EQUAL);
   if(list==NULL || list.Total()==0)
      return;
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CBuffer *buff=list.At(i);
      if(buff==NULL)
         continue;
      buff.InitializeAll(value,color_index);
     }
  }
//+------------------------------------------------------------------+
//| Initialize all drawn buffers using                               |
//| the empty value set for the buffer object                        |
//+------------------------------------------------------------------+
void CBuffersCollection::InitializePlots(void)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_TYPE,BUFFER_TYPE_DATA,EQUAL);
   if(list==NULL || list.Total()==0)
      return;
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CBuffer *buff=list.At(i);
      if(buff==NULL)
         continue;
      buff.InitializeAll();
     }
  }  
//+------------------------------------------------------------------+
//| Initialize all calculated buffers by a specified empty value     |
//+------------------------------------------------------------------+
void CBuffersCollection::InitializeCalculates(const double value)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_TYPE,BUFFER_TYPE_CALCULATE,EQUAL);
   if(list==NULL || list.Total()==0)
      return;
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CBuffer *buff=list.At(i);
      if(buff==NULL)
         continue;
      buff.InitializeAll(value,0);
     }
  }
//+------------------------------------------------------------------+
//| Initialize all calculated buffers using                          |
//| the empty value set for the buffer object                        |
//+------------------------------------------------------------------+
void CBuffersCollection::InitializeCalculates(void)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_TYPE,BUFFER_TYPE_CALCULATE,EQUAL);
   if(list==NULL || list.Total()==0)
      return;
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CBuffer *buff=list.At(i);
      if(buff==NULL)
         continue;
      buff.InitializeAll();
     }
  }
//+------------------------------------------------------------------+
//| Set color values from the passed color array                     |
//| for all collection indicator buffers                             |
//+------------------------------------------------------------------+
void CBuffersCollection::SetColors(const color &array_colors[])
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_TYPE,BUFFER_TYPE_DATA,EQUAL);
   if(list==NULL || list.Total()==0)
      return;
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CBuffer *buff=list.At(i);
      if(buff==NULL)
         continue;
      buff.SetColors(array_colors);
     }
  }
//+------------------------------------------------------------------+
//| Clear buffer data by its index in the list                       |
//| in the specified timeseries bar                                  |
//+------------------------------------------------------------------+
void CBuffersCollection::Clear(const int buffer_list_index,const int series_index)
  {
   CBuffer *buff=this.GetBufferByListIndex(buffer_list_index);
   if(buff==NULL)
      return;
   buff.ClearData(series_index);
  }
//+------------------------------------------------------------------+
//| Return the index of the last drawn buffer                        |
//+------------------------------------------------------------------+
int CBuffersCollection::GetIndexLastPlot(void)
  {
//--- Return the pointer to the list. If the list is not created for some reason, return -1
   CArrayObj *list=this.GetList();
   if(list==NULL)
      return WRONG_VALUE;
//--- Get the index of the drawn buffer with the highest value. If the FindBufferMax() method returns -1,
//--- the list is empty, return index 0 for the very first buffer in the list
   int index=CSelect::FindBufferMax(list,BUFFER_PROP_INDEX_PLOT);
   if(index==WRONG_VALUE)
      return 0;
//--- if the index is not -1,
//--- get the buffer object from the list by its index
   CBuffer *buffer=this.m_list.At(index);
   if(buffer==NULL)
      return WRONG_VALUE;
//--- Return the Plot index of the buffer object
   return buffer.IndexPlot();
  }
//+------------------------------------------------------------------+
//| Return the index of the next drawn buffer                        |
//+------------------------------------------------------------------+
int CBuffersCollection::GetIndexNextPlot(void)
  {
//--- Return the pointer to the list. If the list is not created for some reason, return -1
   CArrayObj *list=this.GetList();
   if(list==NULL)
      return WRONG_VALUE;
//--- Get the index of the drawn buffer with the highest value. If the FindBufferMax() method returns -1,
//--- the list is empty, return index 0 for the very first buffer in the list
   int index=CSelect::FindBufferMax(list,BUFFER_PROP_INDEX_NEXT_PLOT);
   if(index==WRONG_VALUE)
      index=0;
//--- if the index is not -1,
   else
     {
      //--- get the buffer object from the list by its index
      CBuffer *buffer=this.m_list.At(index);
      if(buffer==NULL)
         return WRONG_VALUE;
      //--- Return the Plot value of the next buffer from the buffer object properties
      index=buffer.IndexNextPlotBuffer();
     }
//--- Return the index value
   return index;
  }
//+------------------------------------------------------------------+
//| Return the index of the next basic buffer                        |
//+------------------------------------------------------------------+
int CBuffersCollection::GetIndexNextBase(void)
  {
//--- Return the pointer to the list. If the list is not created for some reason, return -1
   CArrayObj *list=this.GetList();
   if(list==NULL)
      return WRONG_VALUE;
//--- Get the highest index of the next array that can be assigned as an indicator buffer,
//--- if the FindBufferMax() method returns -1,
//--- the list is empty, return index 0 for the very first buffer in the list
   int index=CSelect::FindBufferMax(list,BUFFER_PROP_INDEX_NEXT_BASE);
   if(index==WRONG_VALUE)
      index=0;
//--- if the index is not -1,
   else
     {
      //--- get the buffer object from the list by its index
      CBuffer *buffer=this.m_list.At(index);
      if(buffer==NULL)
         return WRONG_VALUE;
      //--- Return the index of the next array from the buffer object properties
      index=buffer.IndexNextBaseBuffer();
     }
//--- Return the index value
   return index;
  }
//+------------------------------------------------------------------+
//| Create a new buffer object and place it to the collection list   |
//+------------------------------------------------------------------+
bool CBuffersCollection::CreateBuffer(ENUM_BUFFER_STATUS status)
  {
//--- Get the drawn buffer index and the index used to assign the first buffer array as an indicator one
   int index_plot=(status>BUFFER_STATUS_NONE ? this.GetIndexNextPlot() : this.GetIndexLastPlot());
   int index_base=this.GetIndexNextBase();
//--- If any of the indices is not received, return 'false'
   if(index_plot==WRONG_VALUE || index_base==WRONG_VALUE)
      return false;
//--- If the maximum possible number of indicator buffers has already been reached, inform about it and return 'false'
   if(this.m_list.Total()==IND_BUFFERS_MAX)
     {
      ::Print(CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_MAX_BUFFERS_REACHED));
      return false;
     }
//--- Create the buffer drawing style description
   string descript=::StringSubstr(::EnumToString(status),14);
//--- Declare the abstract buffer object
   CBuffer *buffer=NULL;
//--- Create a buffer object depending on the status passed to the method (drawing style)
   switch(status)
     {
      case BUFFER_STATUS_ARROW      : buffer=new CBufferArrow(index_plot,index_base);        break;
      case BUFFER_STATUS_LINE       : buffer=new CBufferLine(index_plot,index_base);         break;
      case BUFFER_STATUS_SECTION    : buffer=new CBufferSection(index_plot,index_base);      break;
      case BUFFER_STATUS_HISTOGRAM  : buffer=new CBufferHistogram(index_plot,index_base);    break;
      case BUFFER_STATUS_HISTOGRAM2 : buffer=new CBufferHistogram2(index_plot,index_base);   break;
      case BUFFER_STATUS_ZIGZAG     : buffer=new CBufferZigZag(index_plot,index_base);       break;
      case BUFFER_STATUS_FILLING    : buffer=new CBufferFilling(index_plot,index_base);      break;
      case BUFFER_STATUS_BARS       : buffer=new CBufferBars(index_plot,index_base);         break;
      case BUFFER_STATUS_CANDLES    : buffer=new CBufferCandles(index_plot,index_base);      break;
      case BUFFER_STATUS_NONE       : buffer=new CBufferCalculate(index_plot,index_base);    break;
      default: break;
     }
//--- Failed to create a buffer, inform of that and return 'false'
   if(buffer==NULL)
     {
      ::Print(CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_BUFFER_OBJ)," ",descript);
      return false;
     }
//--- If failed to add a buffer object to the collection list for some reason,
//--- inform of that, remove the created buffer object and return 'false'
   if(!this.m_list.Add(buffer))
     {
      ::Print(CMessage::Text(MSG_LIB_SYS_FAILED_ADD_BUFFER));
      delete buffer;
      return false;
     }
//--- Set a name for the buffer object and return 'true'
   buffer.SetName("Buffer"+descript+"("+(string)buffer.IndexPlot()+")");
   return true;
  }
//+------------------------------------------------------------------+
//| Return the buffer by the graphical series name                   |
//+------------------------------------------------------------------+
CBuffer *CBuffersCollection::GetBufferByLabel(const string plot_label)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_LABEL,plot_label,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(list.Total()-1) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the buffer by timeframe                                   |
//+------------------------------------------------------------------+
CBuffer *CBuffersCollection::GetBufferByTimeframe(const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_TIMEFRAME,timeframe,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(list.Total()-1) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the buffer by the Plot index                              |
//+------------------------------------------------------------------+
CBuffer *CBuffersCollection::GetBufferByPlot(const int plot_index)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_INDEX_PLOT,plot_index,EQUAL);
   return(list!=NULL && list.Total()==1 ? list.At(0) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the buffer by the collection list index                   |
//+------------------------------------------------------------------+
CBuffer *CBuffersCollection::GetBufferByListIndex(const int index_list)
  {
   return this.m_list.At(index_list);
  }
//+------------------------------------------------------------------+
//| Return the last created buffer                                   |
//+------------------------------------------------------------------+
CBuffer *CBuffersCollection::GetLastCreateBuffer(void)
  {
   return this.m_list.At(this.m_list.Total()-1);
  }
//+------------------------------------------------------------------+
//| Return standard indicator buffer                                 |
//| by indicator type, its ID and line                               |
//+------------------------------------------------------------------+
CBuffer *CBuffersCollection::GetBufferStdInd(const ENUM_INDICATOR indicator_type,const int id,const ENUM_INDICATOR_LINE_MODE line_mode,const char additional_id=WRONG_VALUE)
  {
   CArrayObj *list=this.GetListBufferByTypeID(indicator_type,id);
   list=CSelect::ByBufferProperty(list,BUFFER_PROP_IND_LINE_MODE,line_mode,EQUAL);
   list=CSelect::ByBufferProperty(list,BUFFER_PROP_IND_LINE_ADDITIONAL_NUM,additional_id,EQUAL);
   if(list==NULL)
      return NULL;
   return list.At(0);
  }
//+------------------------------------------------------------------+
//| Return the list of buffers by ID                                 |
//+------------------------------------------------------------------+
CArrayObj *CBuffersCollection::GetListBufferByID(const int id)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_ID,id,EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of buffers by the standard indicator type        |
//+------------------------------------------------------------------+
CArrayObj *CBuffersCollection::GetListBufferByIndType(const ENUM_INDICATOR indicator_type)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_IND_TYPE,indicator_type,EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of buffers by type and ID                        |
//+------------------------------------------------------------------+
CArrayObj *CBuffersCollection::GetListBufferByTypeID(const ENUM_INDICATOR indicator_type,const int id)
  {
   CArrayObj *list=this.GetListBufferByIndType(indicator_type);
   list=CSelect::ByBufferProperty(list,BUFFER_PROP_ID,id,EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//| Return the "Drawing by arrows" buffer by a serial number         |
//| (0 - the very first arrow buffer, 1,2,N - subsequent ones)       |
//+------------------------------------------------------------------+
CBufferArrow *CBuffersCollection::GetBufferArrow(const int number)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_STATUS,BUFFER_STATUS_ARROW,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(number) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the Line buffer by a serial number                        |
//| (0 - the very first line buffer, 1,2,N - subsequent ones)        |
//+------------------------------------------------------------------+
CBufferLine *CBuffersCollection::GetBufferLine(const int number)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_STATUS,BUFFER_STATUS_LINE,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(number) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the Sections buffer by a serial number                    |
//| (0 - the very first sections buffer, 1,2,N - subsequent ones)    |
//+------------------------------------------------------------------+
CBufferSection *CBuffersCollection::GetBufferSection(const int number)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_STATUS,BUFFER_STATUS_SECTION,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(number) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the "Histogram from the zero line" buffer by number       |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
CBufferHistogram *CBuffersCollection::GetBufferHistogram(const int number)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_STATUS,BUFFER_STATUS_HISTOGRAM,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(number) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the "Histogram on two buffers" buffer by number           |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
CBufferHistogram2 *CBuffersCollection::GetBufferHistogram2(const int number)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_STATUS,BUFFER_STATUS_HISTOGRAM2,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(number) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the ZigZag buffer by a serial number                      |
//| (0 - the very first zigzag buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
CBufferZigZag *CBuffersCollection::GetBufferZigZag(const int number)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_STATUS,BUFFER_STATUS_ZIGZAG,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(number) : NULL);
  }
//+------------------------------------------------------------------+
//|Return the "Color filling between two levels" buffer by number    |
//| (0 - the very first filling buffer, 1,2,N - subsequent ones)     |
//+------------------------------------------------------------------+
CBufferFilling *CBuffersCollection::GetBufferFilling(const int number)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_STATUS,BUFFER_STATUS_FILLING,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(number) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the "Display as bars" buffer by a serial number           |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
CBufferBars *CBuffersCollection::GetBufferBars(const int number)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_STATUS,BUFFER_STATUS_BARS,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(number) : NULL);
  }
//+------------------------------------------------------------------+
//|Return the "Display as candles" buffer by a serial number         |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
CBufferCandles *CBuffersCollection::GetBufferCandles(const int number)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_STATUS,BUFFER_STATUS_CANDLES,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(number) : NULL);
  }
//+------------------------------------------------------------------+
//|Return the calculated buffer by serial number                     |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
CBufferCalculate *CBuffersCollection::GetBufferCalculate(const int number)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_TYPE,BUFFER_TYPE_CALCULATE,EQUAL);
   return(list!=NULL && list.Total()>0 ? list.At(number) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the number of drawn buffers                               |
//+------------------------------------------------------------------+
int CBuffersCollection::PropertyPlotsTotal(void)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_TYPE,BUFFER_TYPE_DATA,EQUAL);
   return(list!=NULL ? list.Total() : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return the number of all indicator arrays                        |
//+------------------------------------------------------------------+
int CBuffersCollection::PropertyBuffersTotal(void)
  {
   int index=CSelect::FindBufferMax(this.GetList(),BUFFER_PROP_INDEX_NEXT_BASE);
   CBuffer *buffer=this.m_list.At(index);
   return(buffer!=NULL ? buffer.IndexNextBaseBuffer() : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Get data of the necessary timeseries and bars                    |
//| for working with a single bar of the buffer                      |
//+------------------------------------------------------------------+
int CBuffersCollection::GetBarsData(CBuffer *buffer,const int series_index,int &index_bar_period)
  {
//--- Get timeseries of the current chart and the chart of the buffer timeframe
   CSeriesDE *series_current=this.m_timeseries.GetSeries(Symbol(),PERIOD_CURRENT);
   CSeriesDE *series_period=this.m_timeseries.GetSeries(buffer.Symbol(),buffer.Timeframe());
   if(series_current==NULL || series_period==NULL)
      return WRONG_VALUE;
//--- Get the bar object of the current timeseries corresponding to the required timeseries index
   CBar *bar_current=series_current.GetBar(series_index);
   if(bar_current==NULL)
      return WRONG_VALUE;
//--- Get the timeseries bar object of the buffer chart period corresponding to the time the timeseries bar of the current chart falls into
   CBar *bar_period=m_timeseries.GetBarSeriesFirstFromSeriesSecond(NULL,PERIOD_CURRENT,bar_current.Time(),buffer.Symbol(),series_period.Timeframe());
   if(bar_period==NULL)
      return WRONG_VALUE;
//--- Write down the bar index on the current timeframe which falls into the bar start time of the buffer object chart
   index_bar_period=bar_period.Index(PERIOD_CURRENT);
//--- Calculate the amount of bars of the current timeframe included into one bar of the buffer object chart period
//--- and return this value (1 if the result is 0)
   int num_bars=::PeriodSeconds(bar_period.Timeframe())/::PeriodSeconds(bar_current.Timeframe());
   return(num_bars>0 ? num_bars : 1);
  }
//+------------------------------------------------------------------+
//| Set the value to the arrow buffer by the timeseries index        |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferArrowValue(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false)
  {
//--- Get the arrow buffer object
   CBufferArrow *buff=this.GetBufferArrow(number);
   if(buff==NULL)
      return;
//--- If the buffer usage flag is set only as for the current timeframe,
//--- write the passed value to the current buffer bar and exit (the color is not used)
   if(as_current)
     {
      buff.SetBufferValue(0,series_index,value);
      return;
     }
//--- Get data on the necessary timeseries and bars, and calculate the amount of bars of the current timeframe included into one bar of the buffer object chart period
   int index_bar_period=series_index;
   int num_bars=this.GetBarsData(buff,series_index,index_bar_period);
   if(num_bars==WRONG_VALUE)
      return;
//--- Calculate the index of the next bar for the current chart in the loop by the number of bars and
//--- set the value and color passed to the method by the calculated index
   for(int i=0;i<num_bars;i++)
     {
      int index=index_bar_period-i;
      if(index<0)
         break;
      buff.SetBufferValue(0,index,value);
      buff.SetBufferColorIndex(index,color_index);
     }
  }  
//+------------------------------------------------------------------+
//| Set the value to the line buffer by the timeseries index         |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferLineValue(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false)
  {
   CBufferLine *buff=this.GetBufferLine(number);
   if(buff==NULL)
      return;
//--- If the buffer usage flag is set only as for the current timeframe,
//--- write the passed value to the current buffer bar and exit (the color is not used)
   if(as_current)
     {
      buff.SetBufferValue(0,series_index,value);
      return;
     }
//--- Get data on the necessary timeseries and bars, and calculate the amount of bars of the current timeframe included into one bar of the buffer object chart period
   int index_bar_period=series_index;
   int num_bars=this.GetBarsData(buff,series_index,index_bar_period);
   if(num_bars==WRONG_VALUE)
      return;
//--- Calculate the index of the next bar for the current chart in the loop by the number of bars and
//--- set the value and color passed to the method by the calculated index
   for(int i=0;i<num_bars;i++)
     {
      int index=index_bar_period-i;
      if(index<0)
         break;
      buff.SetBufferValue(0,index,value);
      buff.SetBufferColorIndex(index,color_index);
     }
  }  
//+------------------------------------------------------------------+
//| Set the value to the section buffer by the timeseries index      |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferSectionValue(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false)
  {
   CBufferSection *buff=this.GetBufferSection(number);
   if(buff==NULL)
      return;
//--- If the buffer usage flag is set only as for the current timeframe,
//--- write the passed value to the current buffer bar and exit (the color is not used)
   if(as_current)
     {
      buff.SetBufferValue(0,series_index,value);
      return;
     }
//--- Get data on the necessary timeseries and bars, and calculate the amount of bars of the current timeframe included into one bar of the buffer object chart period
   int index_bar_period=series_index;
   int num_bars=this.GetBarsData(buff,series_index,index_bar_period);
   if(num_bars==WRONG_VALUE)
      return;
//--- Calculate the index of the next bar for the current chart in the loop by the number of bars and
//--- set the value and color passed to the method by the calculated index
   for(int i=0;i<num_bars;i++)
     {
      int index=index_bar_period-i;
      if(index<0)
         break;
      buff.SetBufferValue(0,index,value);
      buff.SetBufferColorIndex(index,color_index);
     }
  }  
//+------------------------------------------------------------------+
//| Set the value of the histogram buffer from the zero line         |
//| by the timeseries index                                          |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferHistogramValue(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false)
  {
   CBufferHistogram *buff=this.GetBufferHistogram(number);
   if(buff==NULL)
      return;
//--- If the buffer usage flag is set only as for the current timeframe,
//--- write the passed value to the current buffer bar and exit (the color is not used)
   if(as_current)
     {
      buff.SetBufferValue(0,series_index,value);
      return;
     }
//--- Get data on the necessary timeseries and bars, and calculate the amount of bars of the current timeframe included into one bar of the buffer object chart period
   int index_bar_period=series_index;
   int num_bars=this.GetBarsData(buff,series_index,index_bar_period);
   if(num_bars==WRONG_VALUE)
      return;
//--- Calculate the index of the next bar for the current chart in the loop by the number of bars and
//--- set the value and color passed to the method by the calculated index
   for(int i=0;i<num_bars;i++)
     {
      int index=index_bar_period-i;
      if(index<0)
         break;
      buff.SetBufferValue(0,index,value);
      buff.SetBufferColorIndex(index,color_index);
     }
  }  
//+------------------------------------------------------------------+
//| Set the value of the histogram buffer on two buffers             |
//| by the timeseries index                                          |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferHistogram2Value(const int number,const int series_index,const double value1,const double value2,const uchar color_index,bool as_current=false)
  {
   CBufferHistogram2 *buff=this.GetBufferHistogram2(number);
   if(buff==NULL)
      return;
//--- If the buffer usage flag is set only as for the current timeframe,
//--- write the passed value to the current buffer bar and exit (the color is not used)
   if(as_current)
     {
      buff.SetBufferValue(0,series_index,value1);
      buff.SetBufferValue(1,series_index,value2);
      return;
     }
//--- Get data on the necessary timeseries and bars, and calculate the amount of bars of the current timeframe included into one bar of the buffer object chart period
   int index_bar_period=series_index;
   int num_bars=this.GetBarsData(buff,series_index,index_bar_period);
   if(num_bars==WRONG_VALUE)
      return;
//--- Calculate the index of the next bar for the current chart in the loop by the number of bars and
//--- set the value and color passed to the method by the calculated index
   for(int i=0;i<num_bars;i++)
     {
      int index=index_bar_period-i;
      if(index<0)
         break;
      buff.SetBufferValue(0,index,value1);
      buff.SetBufferValue(1,index,value2);
      buff.SetBufferColorIndex(index,color_index);
     }
  }  
//+------------------------------------------------------------------+
//| Set the value to the zigzag buffer by the timeseries index       |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferZigZagValue(const int number,const int series_index,const double value1,const double value2,const uchar color_index,bool as_current=false)
  {
   CBufferZigZag *buff=this.GetBufferZigZag(number);
   if(buff==NULL)
      return;
//--- If the buffer usage flag is set only as for the current timeframe,
//--- write the passed value to the current buffer bar and exit (the color is not used)
   if(as_current)
     {
      buff.SetBufferValue(0,series_index,value1);
      buff.SetBufferValue(1,series_index,value2);
      return;
     }
//--- Get data on the necessary timeseries and bars, and calculate the amount of bars of the current timeframe included into one bar of the buffer object chart period
   int index_bar_period=series_index;
   int num_bars=this.GetBarsData(buff,series_index,index_bar_period);
   if(num_bars==WRONG_VALUE)
      return;
//--- Calculate the index of the next bar for the current chart in the loop by the number of bars and
//--- set the value and color passed to the method by the calculated index
   for(int i=0;i<num_bars;i++)
     {
      int index=index_bar_period-i;
      if(index<0)
         break;
      buff.SetBufferValue(0,index,value1);
      buff.SetBufferValue(1,index,value2);
      buff.SetBufferColorIndex(index,color_index);
     }
  }  
//+------------------------------------------------------------------+
//| Set the value to the filling buffer by the timeseries index      |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferFillingValue(const int number,const int series_index,const double value1,const double value2,bool as_current=false)
  {
   CBufferFilling *buff=this.GetBufferFilling(number);
   if(buff==NULL)
      return;
//--- If the buffer usage flag is set only as for the current timeframe,
//--- write the passed value to the current buffer bar and exit (the color is not used)
   if(as_current)
     {
      buff.SetBufferValue(0,series_index,value1);
      buff.SetBufferValue(1,series_index,value2);
      return;
     }
//--- Get data on the necessary timeseries and bars, and calculate the amount of bars of the current timeframe included into one bar of the buffer object chart period
   int index_bar_period=series_index;
   int num_bars=this.GetBarsData(buff,series_index,index_bar_period);
   if(num_bars==WRONG_VALUE)
      return;
//--- Calculate the index of the next bar for the current chart in the loop by the number of bars and
//--- set the value and color passed to the method by the calculated index
   for(int i=0;i<num_bars;i++)
     {
      int index=index_bar_period-i;
      if(index<0)
         break;
      buff.SetBufferValue(0,index,value1);
      buff.SetBufferValue(1,index,value2);
     }
  }  
//+------------------------------------------------------------------+
//| Set the value to the bar buffer by the timeseries index          |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferBarsValue(const int number,const int series_index,const double open,const double high,const double low,const double close,const uchar color_index,bool as_current=false)
  {
   CBufferBars *buff=this.GetBufferBars(number);
   if(buff==NULL)
      return;
//--- If the buffer usage flag is set only as for the current timeframe,
//--- write the passed value to the current buffer bar and exit (the color is not used)
   if(as_current)
     {
      buff.SetBufferValue(0,series_index,open);
      buff.SetBufferValue(1,series_index,high);
      buff.SetBufferValue(2,series_index,low);
      buff.SetBufferValue(3,series_index,close);
      return;
     }
//--- Get data on the necessary timeseries and bars, and calculate the amount of bars of the current timeframe included into one bar of the buffer object chart period
   int index_bar_period=series_index;
   int num_bars=this.GetBarsData(buff,series_index,index_bar_period);
   if(num_bars==WRONG_VALUE)
      return;
//--- Calculate the index of the next bar for the current chart in the loop by the number of bars and
//--- set the value and color passed to the method by the calculated index
   for(int i=0;i<num_bars;i++)
     {
      int index=index_bar_period-i;
      if(index<0)
         break;
      buff.SetBufferValue(0,index,open);
      buff.SetBufferValue(1,index,high);
      buff.SetBufferValue(2,index,low);
      buff.SetBufferValue(3,index,close);
      buff.SetBufferColorIndex(index,color_index);
     }
  }  
//+------------------------------------------------------------------+
//| Set the value to the candle buffer by the timeseries index       |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferCandlesValue(const int number,const int series_index,const double open,const double high,const double low,const double close,const uchar color_index,bool as_current=false)
  {
   CBufferCandles *buff=this.GetBufferCandles(number);
   if(buff==NULL)
      return;
//--- If the buffer usage flag is set only as for the current timeframe,
//--- write the passed value to the current buffer bar and exit (the color is not used)
   if(as_current)
     {
      buff.SetBufferValue(0,series_index,open);
      buff.SetBufferValue(1,series_index,high);
      buff.SetBufferValue(2,series_index,low);
      buff.SetBufferValue(3,series_index,close);
      return;
     }
//--- Get data on the necessary timeseries and bars, and calculate the amount of bars of the current timeframe included into one bar of the buffer object chart period
   int index_bar_period=series_index;
   int num_bars=this.GetBarsData(buff,series_index,index_bar_period);
   if(num_bars==WRONG_VALUE)
      return;
//--- Calculate the index of the next bar for the current chart in the loop by the number of bars and
//--- set the value and color passed to the method by the calculated index
   for(int i=0;i<num_bars;i++)
     {
      int index=index_bar_period-i;
      if(index<0)
         break;
      buff.SetBufferValue(0,index,open);
      buff.SetBufferValue(1,index,high);
      buff.SetBufferValue(2,index,low);
      buff.SetBufferValue(3,index,close);
      buff.SetBufferColorIndex(index,color_index);
     }
  }  
//+------------------------------------------------------------------+
//| Set the value to the calculated buffer by the timeseries index   |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferCalculateValue(const int number,const int series_index,const double value)
  {
   CBufferCalculate *buff=this.GetBufferCalculate(number);
   if(buff==NULL)
      return;
   buff.SetBufferValue(0,series_index,value);
  }  
//+------------------------------------------------------------------+
//| Set the color index to the color buffer                          |
//| of the arrow buffer by the timeseries index                      |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferArrowColorIndex(const int number,const int series_index,const uchar color_index)
  {
   CBufferArrow *buff=this.GetBufferArrow(number);
   if(buff==NULL)
      return;
   buff.SetBufferColorIndex(series_index,color_index);
  }
//+------------------------------------------------------------------+
//| Set the color index to the color buffer                          |
//| of the line buffer by the timeseries index                       |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferLineColorIndex(const int number,const int series_index,const uchar color_index)
  {
   CBufferLine *buff=this.GetBufferLine(number);
   if(buff==NULL)
      return;
   buff.SetBufferColorIndex(series_index,color_index);
  }
//+------------------------------------------------------------------+
//| Set the color index to the color buffer                          |
//| of the section buffer by the timeseries index                    |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferSectionColorIndex(const int number,const int series_index,const uchar color_index)
  {
   CBufferSection *buff=this.GetBufferSection(number);
   if(buff==NULL)
      return;
   buff.SetBufferColorIndex(series_index,color_index);
  }
//+--------------------------------------------------------------------+
//| Set the color index to the color buffer                            |
//| of the histogram buffer from the zero line by the timeseries index |
//+--------------------------------------------------------------------+
void CBuffersCollection::SetBufferHistogramColorIndex(const int number,const int series_index,const uchar color_index)
  {
   CBufferHistogram *buff=this.GetBufferHistogram(number);
   if(buff==NULL)
      return;
   buff.SetBufferColorIndex(series_index,color_index);
  }
//+------------------------------------------------------------------+
//| Set the color index to the color buffer                          |
//| of the histogram buffer on two buffers by the timeseries index   |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferHistogram2ColorIndex(const int number,const int series_index,const uchar color_index)
  {
   CBufferHistogram2 *buff=this.GetBufferHistogram2(number);
   if(buff==NULL)
      return;
   buff.SetBufferColorIndex(series_index,color_index);
  }
//+------------------------------------------------------------------+
//| Set the color index to the color buffer                          |
//| of the zigzag buffer by the timeseries index                     |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferZigZagColorIndex(const int number,const int series_index,const uchar color_index)
  {
   CBufferZigZag *buff=this.GetBufferZigZag(number);
   if(buff==NULL)
      return;
   buff.SetBufferColorIndex(series_index,color_index);
  }
//+------------------------------------------------------------------+
//| Set the color index to the color buffer                          |
//| of the filling buffer by the timeseries index                    |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferFillingColorIndex(const int number,const int series_index,const uchar color_index)
  {
   CBufferFilling *buff=this.GetBufferFilling(number);
   if(buff==NULL)
      return;
   buff.SetBufferColorIndex(series_index,color_index);
  }
//+------------------------------------------------------------------+
//| Set the color index to the color buffer                          |
//| of the bar buffer by the timeseries index                        |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferBarsColorIndex(const int number,const int series_index,const uchar color_index)
  {
   CBufferBars *buff=this.GetBufferBars(number);
   if(buff==NULL)
      return;
   buff.SetBufferColorIndex(series_index,color_index);
  }
//+------------------------------------------------------------------+
//| Set the color index to the color buffer                          |
//| of the candle buffer by the timeseries index                     |
//+------------------------------------------------------------------+
void CBuffersCollection::SetBufferCandlesColorIndex(const int number,const int series_index,const uchar color_index)
  {
   CBufferCandles *buff=this.GetBufferCandles(number);
   if(buff==NULL)
      return;
   buff.SetBufferColorIndex(series_index,color_index);
  }
//+------------------------------------------------------------------+
//| Clear the arrow buffer data by the timeseries index              |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearBufferArrow(const int number,const int series_index)
  {
   CBufferArrow *buff=this.GetBufferArrow(number);
   if(buff==NULL)
      return;
   buff.SetBufferValue(0,series_index,buff.EmptyValue());
  }
//+------------------------------------------------------------------+
//| Clear the line buffer data by the timeseries index               |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearBufferLine(const int number,const int series_index)
  {
   CBufferLine *buff=this.GetBufferLine(number);
   if(buff==NULL)
      return;
   buff.SetBufferValue(0,series_index,buff.EmptyValue());
  }
//+------------------------------------------------------------------+
//| Clear the section buffer data by the timeseries index            |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearBufferSection(const int number,const int series_index)
  {
   CBufferSection *buff=this.GetBufferSection(number);
   if(buff==NULL)
      return;
   buff.SetBufferValue(0,series_index,buff.EmptyValue());
  }
//+------------------------------------------------------------------+
//| Clear the data of the histogram buffer from the zero line        |
//| by the timeseries index                                          |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearBufferHistogram(const int number,const int series_index)
  {
   CBufferHistogram *buff=this.GetBufferHistogram(number);
   if(buff==NULL)
      return;
   buff.SetBufferValue(0,series_index,buff.EmptyValue());
  }
//+------------------------------------------------------------------+
//| Clear the data of the histogram buffer on two buffers            |
//| by the timeseries index                                          |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearBufferHistogram2(const int number,const int series_index)
  {
   CBufferHistogram2 *buff=this.GetBufferHistogram2(number);
   if(buff==NULL)
      return;
   buff.SetBufferValue(0,series_index,buff.EmptyValue());
   buff.SetBufferValue(1,series_index,buff.EmptyValue());
  }
//+------------------------------------------------------------------+
//| Clear the zigzag buffer data by the timeseries index             |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearBufferZigZag(const int number,const int series_index)
  {
   CBufferZigZag *buff=this.GetBufferZigZag(number);
   if(buff==NULL)
      return;
   buff.SetBufferValue(0,series_index,buff.EmptyValue());
   buff.SetBufferValue(1,series_index,buff.EmptyValue());
  }
//+------------------------------------------------------------------+
//| Clear the filling buffer data by the timeseries index            |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearBufferFilling(const int number,const int series_index)
  {
   CBufferFilling *buff=this.GetBufferFilling(number);
   if(buff==NULL)
      return;
   buff.SetBufferValue(0,series_index,buff.EmptyValue());
   buff.SetBufferValue(1,series_index,buff.EmptyValue());
  }
//+------------------------------------------------------------------+
//| Clear the bar buffer data by the timeseries index                |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearBufferBars(const int number,const int series_index)
  {
   CBufferBars *buff=this.GetBufferBars(number);
   if(buff==NULL)
      return;
   buff.SetBufferValue(0,series_index,buff.EmptyValue());
   buff.SetBufferValue(1,series_index,buff.EmptyValue());
   buff.SetBufferValue(2,series_index,buff.EmptyValue());
   buff.SetBufferValue(3,series_index,buff.EmptyValue());
  }
//+------------------------------------------------------------------+
//| Clear the candle buffer data by the timeseries index             |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearBufferCandles(const int number,const int series_index)
  {
   CBufferCandles *buff=this.GetBufferCandles(number);
   if(buff==NULL)
      return;
   buff.SetBufferValue(0,series_index,buff.EmptyValue());
   buff.SetBufferValue(1,series_index,buff.EmptyValue());
   buff.SetBufferValue(2,series_index,buff.EmptyValue());
   buff.SetBufferValue(3,series_index,buff.EmptyValue());
  }
//+------------------------------------------------------------------+
//| Return the list of indicator buffers                             |
//| (featuring the ID of belonging to an indicator)                  |
//+------------------------------------------------------------------+
CArrayObj *CBuffersCollection::GetListBuffersWithID(void)
  {
   CArrayObj *list=CSelect::ByBufferProperty(this.GetList(),BUFFER_PROP_ID,WRONG_VALUE,NO_EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period AC                              |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateAC(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iAC(symbol,timeframe) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_AC : id);
   color array_colors[3]={clrGreen,clrRed,clrGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create histogram buffer from the zero line
      this.CreateHistogram();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_AC);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("AC("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Accelerator Oscillator");
      buff.SetIndicatorShortName("AC("+symbol+","+TimeframeDescription(timeframe)+")");
      #ifdef __MQL5__ 
         buff.SetColors(array_colors); 
      #else 
         buff.SetColor(array_colors[0]); 
         buff.SetIndicatorLineAdditionalNumber(0);
      #endif 

      //--- MQL5
      #ifdef __MQL5__
         //--- Create a calculated buffer storing standard indicator data
         this.CreateCalculate();
         //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
         buff=this.GetLastCreateBuffer();
         if(buff==NULL)
            return INVALID_HANDLE;
         buff.SetSymbol(symbol);
         buff.SetTimeframe(timeframe);
         buff.SetID(identifier);
         buff.SetIndicatorHandle(handle);
         buff.SetIndicatorType(IND_AC);
         buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
         buff.SetEmptyValue(EMPTY_VALUE);
         buff.SetLabel("AC("+symbol+","+TimeframeDescription(timeframe)+")");
         buff.SetIndicatorName("Accelerator Oscillator");
         buff.SetIndicatorShortName("AC("+symbol+","+TimeframeDescription(timeframe)+")");
      
      //--- MQL4
      #else 
         //--- Create histogram buffer from the zero line for buffer of the second color
         this.CreateHistogram();
         //--- Get the last created buffer object (drawn) and set to it all necessary parameters
         buff=this.GetLastCreateBuffer();
         if(buff==NULL)
            return INVALID_HANDLE;
         buff.SetSymbol(symbol);
         buff.SetTimeframe(timeframe);
         buff.SetID(identifier);
         buff.SetIndicatorHandle(handle);
         buff.SetIndicatorType(IND_AC);
         buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
         buff.SetShowData(true);
         buff.SetLabel("AC("+symbol+","+TimeframeDescription(timeframe)+")");
         buff.SetIndicatorName("Accelerator Oscillator");
         buff.SetIndicatorShortName("AC("+symbol+","+TimeframeDescription(timeframe)+")");
         #ifdef __MQL5__ 
            buff.SetColors(array_colors); 
         #else 
            buff.SetColor(array_colors[1]); 
            buff.SetIndicatorLineAdditionalNumber(1);
         #endif 
      #endif 
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period AD                              |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateAD(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iAD(symbol,timeframe,applied_volume) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_AD : id);
   color array_colors[1]={clrLightSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_AD);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("A/D("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Accumulation/Distribution");
      buff.SetIndicatorShortName("A/D("+symbol+","+TimeframeDescription(timeframe)+")");
      #ifdef __MQL5__ buff.SetColors(array_colors); #else buff.SetColor(array_colors[0]); #endif 

      //--- MQL5
      #ifdef __MQL5__
         //--- Create a calculated buffer storing standard indicator data
         this.CreateCalculate();
         //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
         buff=this.GetLastCreateBuffer();
         if(buff==NULL)
            return INVALID_HANDLE;
         buff.SetSymbol(symbol);
         buff.SetTimeframe(timeframe);
         buff.SetID(identifier);
         buff.SetIndicatorHandle(handle);
         buff.SetIndicatorType(IND_AD);
         buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
         buff.SetEmptyValue(EMPTY_VALUE);
         buff.SetLabel("A/D("+symbol+","+TimeframeDescription(timeframe)+")");
         buff.SetIndicatorName("Accumulation/Distribution");
         buff.SetIndicatorShortName("A/D("+symbol+","+TimeframeDescription(timeframe)+")");
      #endif 
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period ADX                             |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateADX(const string symbol,const ENUM_TIMEFRAMES timeframe,const int adx_period,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ iADX(symbol,timeframe,adx_period) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_ADX : id);
   color array_colors[1]={clrLightSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary ADX line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADX);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);     // This is the main indicator line
      buff.SetShowData(true);
      buff.SetIndicatorName("Average Directional Movement Index");
      buff.SetIndicatorShortName("ADX("+symbol+","+TimeframeDescription(timeframe)+": "+(string)adx_period+")");
      buff.SetLabel(buff.IndicatorShortName());
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary +DI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADX);
      buff.SetLineMode(INDICATOR_LINE_MODE_DI_PLUS);  // This is a +DI line
      buff.SetShowData(true);
      buff.SetIndicatorName("Average Directional Movement Index");
      buff.SetIndicatorShortName("ADX("+symbol+","+TimeframeDescription(timeframe)+": "+(string)adx_period+")");
      buff.SetLabel("+DI");
      array_colors[0]=clrYellowGreen;
      buff.SetColors(array_colors);
      buff.SetStyle(STYLE_DOT);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary -DI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADX);
      buff.SetLineMode(INDICATOR_LINE_MODE_DI_MINUS); // This is a -DI line
      buff.SetShowData(true);
      buff.SetIndicatorName("Average Directional Movement Index");
      buff.SetIndicatorShortName("ADX("+symbol+","+TimeframeDescription(timeframe)+": "+(string)adx_period+")");
      buff.SetLabel("-DI");
      array_colors[0]=clrWheat;
      buff.SetColors(array_colors);
      buff.SetStyle(STYLE_DOT);
      
      //--- Create a calculated ADX line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary ADX line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADX);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetIndicatorName("Average Directional Movement Index");
      buff.SetLabel("ADX("+symbol+","+TimeframeDescription(timeframe)+": "+(string)adx_period+")");
      
      //--- Create a calculated +DI line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary +DI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADX);
      buff.SetLineMode(INDICATOR_LINE_MODE_DI_PLUS);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetIndicatorName("Average Directional Movement Index");
      buff.SetLabel("+DI");
      
      //--- Create a calculated -DI line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary -DI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADX);
      buff.SetLineMode(INDICATOR_LINE_MODE_DI_MINUS);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetIndicatorName("Average Directional Movement Index");
      buff.SetLabel("-DI");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period ADX Wilder                      |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateADXWilder(const string symbol,const ENUM_TIMEFRAMES timeframe,const int adx_period,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iADXWilder(symbol,timeframe,adx_period) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_ADXW : id);
   color array_colors[1]={clrLightSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary ADXW line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADXW);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetIndicatorName("Average Directional Movement Index Wilder");
      buff.SetIndicatorShortName("ADX Wilder("+symbol+","+TimeframeDescription(timeframe)+": "+(string)adx_period+")");
      buff.SetLabel(buff.IndicatorShortName());
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary +DI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADXW);
      buff.SetLineMode(INDICATOR_LINE_MODE_DI_PLUS);
      buff.SetShowData(true);
      buff.SetIndicatorName("Average Directional Movement Index Wilder");
      buff.SetIndicatorShortName("ADX Wilder("+symbol+","+TimeframeDescription(timeframe)+": "+(string)adx_period+")");
      buff.SetLabel("+DI");
      array_colors[0]=clrYellowGreen;
      buff.SetColors(array_colors);
      buff.SetStyle(STYLE_DOT);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary -DI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADXW);
      buff.SetLineMode(INDICATOR_LINE_MODE_DI_MINUS);
      buff.SetShowData(true);
      buff.SetIndicatorName("Average Directional Movement Index Wilder");
      buff.SetIndicatorShortName("ADX Wilder("+symbol+","+TimeframeDescription(timeframe)+": "+(string)adx_period+")");
      buff.SetLabel("-DI");
      array_colors[0]=clrWheat;
      buff.SetColors(array_colors);
      buff.SetStyle(STYLE_DOT);
      
      //--- Create a calculated ADXW line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary ADXW line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADXW);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetIndicatorName("Average Directional Movement Index Wilder");
      buff.SetLabel("ADX Wilder("+symbol+","+TimeframeDescription(timeframe)+": "+(string)adx_period+")");
      
      //--- Create a calculated +DI line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary +DI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADXW);
      buff.SetLineMode(INDICATOR_LINE_MODE_DI_PLUS);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetIndicatorName("Average Directional Movement Index Wilder");
      buff.SetLabel("+DI");
      
      //--- Create a calculated -DI line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary -DI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ADXW);
      buff.SetLineMode(INDICATOR_LINE_MODE_DI_MINUS);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetIndicatorName("Average Directional Movement Index Wilder");
      buff.SetLabel("-DI");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Alligator                       |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateAlligator(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                        const int jaw_period,
                                        const int jaw_shift,
                                        const int teeth_period,
                                        const int teeth_shift,
                                        const int lips_period,
                                        const int lips_shift,
                                        const ENUM_MA_METHOD ma_method,
                                        const ENUM_APPLIED_PRICE applied_price,
                                        const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift_jaw=jaw_shift*num_bars;
   int shift_teeth=teeth_shift*num_bars;
   int shift_lips=lips_shift*num_bars;
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iAlligator(symbol,timeframe,jaw_period,shift_jaw,teeth_period,shift_teeth,lips_period,shift_lips,ma_method,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_ALLIGATOR : id);
   color array_colors[1]={clrBlue};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Jaws line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift_jaw);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ALLIGATOR);
      buff.SetShowData(true);
      buff.SetLineMode(INDICATOR_LINE_MODE_JAWS);
      buff.SetIndicatorName("Alligator");
      buff.SetIndicatorShortName("Alligator("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+","+(string)teeth_period+","+(string)lips_period+")");
      buff.SetLabel("Jaws("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+")");
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Teeth line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift_teeth);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ALLIGATOR);
      buff.SetShowData(true);
      buff.SetLineMode(INDICATOR_LINE_MODE_TEETH);
      buff.SetIndicatorName("Alligator");
      buff.SetIndicatorShortName("Alligator("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+","+(string)teeth_period+","+(string)lips_period+")");
      buff.SetLabel("Teeth("+symbol+","+TimeframeDescription(timeframe)+": "+(string)teeth_period+")");
      array_colors[0]=clrRed;
      buff.SetColors(array_colors);

      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Lips line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift_lips);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ALLIGATOR);
      buff.SetShowData(true);
      buff.SetLineMode(INDICATOR_LINE_MODE_LIPS);
      buff.SetIndicatorName("Alligator");
      buff.SetIndicatorShortName("Alligator("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+","+(string)teeth_period+","+(string)lips_period+")");
      buff.SetLabel("Lips("+symbol+","+TimeframeDescription(timeframe)+": "+(string)lips_period+")");
      array_colors[0]=clrLime;
      buff.SetColors(array_colors);
      
      //--- Create a calculated Jaws line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Jaws line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift_jaw);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ALLIGATOR);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLineMode(INDICATOR_LINE_MODE_JAWS);
      buff.SetIndicatorName("Alligator");
      buff.SetLabel("Jaws("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+")");
      
      //--- Create a calculated Teeth line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Teeth line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift_teeth);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ALLIGATOR);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLineMode(INDICATOR_LINE_MODE_TEETH);
      buff.SetIndicatorName("Alligator");
      buff.SetLabel("Teeth("+symbol+","+TimeframeDescription(timeframe)+": "+(string)teeth_period+")");
      
      //--- Create a calculated Lips line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Lips line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift_lips);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ALLIGATOR);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLineMode(INDICATOR_LINE_MODE_LIPS);
      buff.SetIndicatorName("Alligator");
      buff.SetLabel("Lips("+symbol+","+TimeframeDescription(timeframe)+": "+(string)lips_period+")");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period AMA                             |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                  const int ama_period,
                                  const int fast_ema_period,
                                  const int slow_ema_period,
                                  const int ama_shift,
                                  const ENUM_APPLIED_PRICE applied_price,
                                  const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift=ama_shift*num_bars;
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iAMA(symbol,timeframe,ama_period,fast_ema_period,slow_ema_period,shift,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_AMA : id);
   color array_colors[1]={clrRed};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_AMA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("AMA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ama_period+","+(string)fast_ema_period+","+(string)slow_ema_period+")");
      buff.SetIndicatorName("Adaptive Moving Average");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_AMA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("AMA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ama_period+","+(string)fast_ema_period+","+(string)slow_ema_period+")");
      buff.SetIndicatorName("Adaptive Moving Average");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period AO                              |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateAO(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iAO(symbol,timeframe) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_AO : id);
   color array_colors[3]={clrGreen,clrRed,clrGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create histogram buffer from the zero line
      this.CreateHistogram();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_AO);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("AO("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Awesome Oscillator");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_AO);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("AO("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Awesome Oscillator");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period ATR                             |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateATR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iATR(symbol,timeframe,ma_period) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_ATR : id);
   color array_colors[1]={clrLightSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ATR);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("ATR("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Average True Range");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ATR);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("ATR("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Average True Range");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Bands                           |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateBands(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                    const int ma_period,
                                    const int ma_shift,
                                    const double deviation,
                                    const ENUM_APPLIED_PRICE applied_price,
                                    const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift=ma_shift*num_bars;
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iBands(symbol,timeframe,ma_period,shift,deviation,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_BANDS : id);
   color array_colors[1]={clrMediumSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Upper line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BANDS);
      buff.SetLineMode(INDICATOR_LINE_MODE_UPPER);
      buff.SetShowData(true);
      buff.SetIndicatorName("Bollinger Bands");
      buff.SetIndicatorShortName("Bands("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetLabel(buff.IndicatorShortName()+" Upper");
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Lower line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BANDS);
      buff.SetLineMode(INDICATOR_LINE_MODE_LOWER);
      buff.SetShowData(true);
      buff.SetIndicatorName("Bollinger Bands");
      buff.SetIndicatorShortName("Bands("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetLabel(buff.IndicatorShortName()+" Lower");
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Middle line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BANDS);
      buff.SetLineMode(INDICATOR_LINE_MODE_MIDDLE);
      buff.SetShowData(true);
      buff.SetIndicatorName("Bollinger Bands");
      buff.SetIndicatorShortName("Bands("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetLabel(buff.IndicatorShortName()+" Middle");
      buff.SetColors(array_colors);
      
      //--- Create a calculated Upper line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Upper line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BANDS);
      buff.SetLineMode(INDICATOR_LINE_MODE_UPPER);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Bands("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+") Upper");
      buff.SetIndicatorName("Bollinger Bands");
      
      //--- Create a calculated Lower line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Lower line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BANDS);
      buff.SetLineMode(INDICATOR_LINE_MODE_LOWER);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Bands("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+") Lower");
      buff.SetIndicatorName("Bollinger Bands");
      
      //--- Create a calculated Middle line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Middle line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BANDS);
      buff.SetLineMode(INDICATOR_LINE_MODE_MIDDLE);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Bands("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+") Middle");
      buff.SetIndicatorName("Bollinger Bands");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Bears Power                     |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateBearsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iBearsPower(symbol,timeframe,ma_period) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_BEARS : id);
   color array_colors[1]={clrSilver};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create histogram buffer from the zero line
      this.CreateHistogram();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BEARS);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("Bears("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Bears Power");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BEARS);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Bears("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Bears Power");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Bulls Power                     |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateBullsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iBullsPower(symbol,timeframe,ma_period) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_BULLS : id);
   color array_colors[1]={clrSilver};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create histogram buffer from the zero line
      this.CreateHistogram();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BULLS);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("Bulls("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Bulls Power");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BULLS);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Bulls("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Bulls Power");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period CHO                             |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateChaikin(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                      const int fast_ma_period,
                                      const int slow_ma_period,
                                      const ENUM_MA_METHOD ma_method,
                                      const ENUM_APPLIED_VOLUME applied_volume,
                                      const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iChaikin(symbol,timeframe,fast_ma_period,slow_ma_period,ma_method,applied_volume) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_CHAIKIN : id);
   color array_colors[1]={clrLightSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_CHAIKIN);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("CHO("+symbol+","+TimeframeDescription(timeframe)+": "+(string)slow_ma_period+","+(string)fast_ma_period+")");
      buff.SetIndicatorName("Chaikin Oscillator");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_CHAIKIN);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("CHO("+symbol+","+TimeframeDescription(timeframe)+": "+(string)slow_ma_period+","+(string)fast_ma_period+")");
      buff.SetIndicatorName("Chaikin Oscillator");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period CCI                             |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateCCI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                  const int ma_period,
                                  const ENUM_APPLIED_PRICE applied_price,
                                  const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iCCI(symbol,timeframe,ma_period,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_CCI : id);
   color array_colors[1]={clrLightSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_CCI);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("CCI("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Commodity Channel Index");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_CCI);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("CCI("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Commodity Channel Index");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period DEMA                            |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateDEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                   const int ma_period,
                                   const int ma_shift,
                                   const ENUM_APPLIED_PRICE applied_price,
                                   const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift=ma_shift*num_bars;
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iDEMA(symbol,timeframe,ma_period,shift,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_DEMA : id);
   color array_colors[1]={clrRed};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_DEMA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("DEMA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Double Exponential Moving Average");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_DEMA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("DEMA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Double Exponential Moving Average");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period DeMarker                        |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateDeMarker(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iDeMarker(symbol,timeframe,ma_period) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_DEMARKER : id);
   color array_colors[1]={clrLightSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_DEMARKER);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("DeM("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("DeMarker");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_DEMARKER);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("DeM("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("DeMarker");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Envelopes                       |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateEnvelopes(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                        const int ma_period,
                                        const int ma_shift,
                                        const ENUM_MA_METHOD ma_method,
                                        const ENUM_APPLIED_PRICE applied_price,
                                        const double deviation,
                                        const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift=ma_shift*num_bars;
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iEnvelopes(symbol,timeframe,ma_period,shift,ma_method,applied_price,deviation) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_ENVELOPES : id);
   color array_colors[1]={clrBlue};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Upper line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ENVELOPES);
      buff.SetLineMode(INDICATOR_LINE_MODE_UPPER);
      buff.SetShowData(true);
      buff.SetIndicatorName("Envelopes");
      buff.SetIndicatorShortName("Envelopes("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetLabel(buff.IndicatorShortName()+" Upper");
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Lower line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ENVELOPES);
      buff.SetLineMode(INDICATOR_LINE_MODE_LOWER);
      buff.SetShowData(true);
      buff.SetIndicatorName("Envelopes");
      buff.SetIndicatorShortName("Envelopes("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetLabel(buff.IndicatorShortName()+" Lower");
      array_colors[0]=clrRed;
      buff.SetColors(array_colors);
      
      //--- Create a calculated Upper line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Upper line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ENVELOPES);
      buff.SetLineMode(INDICATOR_LINE_MODE_UPPER);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Envelopes("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+") Upper");
      buff.SetIndicatorName("Envelopes");
      
      //--- Create a calculated Lower line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Lower line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ENVELOPES);
      buff.SetLineMode(INDICATOR_LINE_MODE_LOWER);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Envelopes("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+") Lower");
      buff.SetIndicatorName("Envelopes");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Force                           |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateForce(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                    const int ma_period,
                                    const ENUM_MA_METHOD ma_method,
                                    const ENUM_APPLIED_VOLUME applied_volume,
                                    const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iForce(symbol,timeframe,ma_period,ma_method,applied_volume) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_FORCE : id);
   color array_colors[1]={clrLightSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_FORCE);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("Force("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Force Index");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_FORCE);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Force("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Force Index");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Fractals                        |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateFractals(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iFractals(symbol,timeframe) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_FRACTALS : id);
   color array_colors[1]={clrGray};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create the arrows buffer
      this.CreateArrow();
      //--- Get the last created (drawn) buffer object and set all the necessary Upper line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_FRACTALS);
      buff.SetLineMode(INDICATOR_LINE_MODE_UPPER);
      buff.SetShowData(true);
      buff.SetIndicatorName("Fractals");
      buff.SetIndicatorShortName("Fractals("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetLabel(buff.IndicatorShortName()+" Up");
      buff.SetColors(array_colors);
      
      //--- Create the arrows buffer
      this.CreateArrow();
      //--- Get the last created (drawn) buffer object and set all the necessary Lower line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_FRACTALS);
      buff.SetLineMode(INDICATOR_LINE_MODE_LOWER);
      buff.SetShowData(true);
      buff.SetIndicatorName("Fractals");
      buff.SetIndicatorShortName("Fractals("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetLabel(buff.IndicatorShortName()+" Down");
      buff.SetColors(array_colors);
      
      //--- Create calculated buffer of Up, in which standard indicator data will be stored
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Upper line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_FRACTALS);
      buff.SetLineMode(INDICATOR_LINE_MODE_UPPER);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel(buff.IndicatorShortName()+" Up");
      buff.SetIndicatorName("Fractals");
      
      //--- Create a calculated Down line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Lower line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_FRACTALS);
      buff.SetLineMode(INDICATOR_LINE_MODE_LOWER);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel(buff.IndicatorShortName()+" Down");
      buff.SetIndicatorName("Fractals");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period FrAMA                           |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateFrAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                    const int ma_period,
                                    const int ma_shift,
                                    const ENUM_APPLIED_PRICE applied_price,
                                    const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift=ma_shift*num_bars;
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iFrAMA(symbol,timeframe,ma_period,shift,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_FRAMA : id);
   color array_colors[1]={clrBlue};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_FRAMA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("FRAMA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Fractal Adaptive Moving Average");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_FRAMA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("FRAMA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Fractal Adaptive Moving Average");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Gator                           |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateGator(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                    const int jaw_period,
                                    const int jaw_shift,
                                    const int teeth_period,
                                    const int teeth_shift,
                                    const int lips_period,
                                    const int lips_shift,
                                    const ENUM_MA_METHOD ma_method,
                                    const ENUM_APPLIED_PRICE applied_price,
                                    const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift=::fmin(jaw_shift,teeth_shift);
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iGator(symbol,timeframe,jaw_period,jaw_shift,teeth_period,teeth_shift,lips_period,lips_shift,ma_method,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_GATOR : id);
   color array_colors[3]={clrGreen,clrRed,clrGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create histogram buffer from the zero line
      this.CreateHistogram();
      //--- Get the last created buffer object (drawn) and set to it all the necessary parameters of Up
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift*num_bars);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_GATOR);
      buff.SetShowData(true);
      buff.SetLineMode(INDICATOR_LINE_MODE_UPPER);
      buff.SetIndicatorName("Gator Oscillator");
      buff.SetIndicatorShortName("Gator("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+","+(string)teeth_period+","+(string)lips_period+")");
      buff.SetLabel("Gator("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+","+(string)teeth_period+","+(string)lips_period+","+") Up");
      buff.SetColors(array_colors);
      
      //--- Create histogram buffer from the zero line
      this.CreateHistogram();
      //--- Get the last created buffer object (drawn) and set to it all the necessary parameters of Down
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift*num_bars);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_GATOR);
      buff.SetShowData(true);
      buff.SetLineMode(INDICATOR_LINE_MODE_LOWER);
      buff.SetIndicatorName("Gator Oscillator");
      buff.SetIndicatorShortName("Gator("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+","+(string)teeth_period+","+(string)lips_period+")");
      buff.SetLabel("Gator("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+","+(string)teeth_period+","+(string)lips_period+","+") Down");
      buff.SetColors(array_colors);
      
      //--- Create calculated buffer of Up, in which standard indicator data will be stored
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters of Up
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_GATOR);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLineMode(INDICATOR_LINE_MODE_UPPER);
      buff.SetIndicatorName("Gator Oscillator");
      buff.SetLabel("Gator("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+","+(string)teeth_period+","+(string)lips_period+","+") Up");
      
      //--- Create a calculated Teeth line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Teeth line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_GATOR);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLineMode(INDICATOR_LINE_MODE_LOWER);
      buff.SetIndicatorName("Gator Oscillator");
      buff.SetLabel("Gator("+symbol+","+TimeframeDescription(timeframe)+": "+(string)jaw_period+","+(string)teeth_period+","+(string)lips_period+","+") Down");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Ichimoku                        |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateIchimoku(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int tenkan_sen,
                                       const int kijun_sen,
                                       const int senkou_span_b,
                                       const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iIchimoku(symbol,timeframe,tenkan_sen,kijun_sen,senkou_span_b) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_ICHIMOKU : id);
   color array_colors[1]={clrRed};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all the necessary parameters of Tenkan-Sen
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_TENKAN_SEN);
      buff.SetShowData(true);
      buff.SetLabel("Tenkan-Sen("+symbol+","+TimeframeDescription(timeframe)+": "+(string)tenkan_sen+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all the necessary parameters of Kijun-Sen
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_KIJUN_SEN);
      buff.SetShowData(true);
      buff.SetLabel("Kijun-Sen("+symbol+","+TimeframeDescription(timeframe)+": "+(string)kijun_sen+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      array_colors[0]=clrBlue;
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all the necessary parameters of Senkou Span A
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(kijun_sen*num_bars);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_SENKOU_SPANA);
      buff.SetShowData(true);
      buff.SetLabel("Senkou Span A("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      array_colors[0]=clrSandyBrown;
      buff.SetColors(array_colors);
      buff.SetStyle(STYLE_DOT);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all the necessary parameters of Senkou Span B
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(kijun_sen*num_bars);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_SENKOU_SPANB);
      buff.SetShowData(true);
      buff.SetLabel("Senkou Span B("+symbol+","+TimeframeDescription(timeframe)+": "+(string)senkou_span_b+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      array_colors[0]=clrThistle;
      buff.SetColors(array_colors);
      buff.SetStyle(STYLE_DOT);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all the necessary parameters of Chikou Span
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_CHIKOU_SPAN);
      buff.SetShowData(true);
      buff.SetLabel("Chikou Span("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      array_colors[0]=clrLime;
      buff.SetColors(array_colors);
      
      //--- Create histogram buffer on two lines for displaying the histogram of Senkou Span A
      this.CreateHistogram2();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(kijun_sen*num_bars);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_ADDITIONAL);
      buff.SetShowData(false);
      buff.SetLabel("Senkou Span A("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorLineAdditionalNumber(0);
      //--- Get buffer data of Senkou Span A and set values of line color, width and style to the histogram
      CBuffer *tmp=GetBufferStdInd(IND_ICHIMOKU,identifier,INDICATOR_LINE_MODE_SENKOU_SPANA);
      array_colors[0]=(tmp!=NULL ? tmp.Color() : clrSandyBrown);
      buff.SetColors(array_colors);
      buff.SetWidth(tmp!=NULL ? tmp.LineWidth() : 1);
      buff.SetStyle(tmp!=NULL ? tmp.LineStyle() : STYLE_DOT);
      
      //--- Create histogram buffer on two lines for displaying the histogram of Senkou Span B
      this.CreateHistogram2();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(kijun_sen*num_bars);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_ADDITIONAL);
      buff.SetShowData(false);
      buff.SetLabel("Senkou Span B("+symbol+","+TimeframeDescription(timeframe)+": "+(string)senkou_span_b+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorLineAdditionalNumber(1);
      //--- Get buffer data of Senkou Span B and set values of line color, width and style to the histogram
      tmp=GetBufferStdInd(IND_ICHIMOKU,identifier,INDICATOR_LINE_MODE_SENKOU_SPANB);
      array_colors[0]=(tmp!=NULL ? tmp.Color() : clrThistle);
      buff.SetColors(array_colors);
      buff.SetWidth(tmp!=NULL ? tmp.LineWidth() : 1);
      buff.SetStyle(tmp!=NULL ? tmp.LineStyle() : STYLE_DOT);
      
      //--- Create calculated buffer in which data of Tenkan-Sen line will be stored
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_TENKAN_SEN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Tenkan-Sen("+symbol+","+TimeframeDescription(timeframe)+": "+(string)tenkan_sen+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      
      //--- Create calculated buffer in which data of Kijun-Sen line will be stored
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_KIJUN_SEN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Kijun-Sen("+symbol+","+TimeframeDescription(timeframe)+": "+(string)kijun_sen+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      
      //--- Create calculated buffer in which data of Senkou Span A line will be stored
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(kijun_sen);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_SENKOU_SPANA);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Senkou Span A("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      
      //--- Create calculated buffer in which data of Senkou Span B line will be stored
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(kijun_sen);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_SENKOU_SPANB);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Senkou Span B("+symbol+","+TimeframeDescription(timeframe)+": "+(string)senkou_span_b+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
      
      //--- Create calculated buffer in which data of Chikou Span line will be stored
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_ICHIMOKU);
      buff.SetLineMode(INDICATOR_LINE_MODE_CHIKOU_SPAN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Chikou Span("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Ichimoku Kinko Hyo");
      buff.SetIndicatorShortName("Ichimoku("+symbol+","+TimeframeDescription(timeframe)+")");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period BW MFI                          |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateBWMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                    const ENUM_APPLIED_VOLUME applied_volume,
                                    const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iBWMFI(symbol,timeframe,applied_volume) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_BWMFI : id);
   color array_colors[5]={clrLime,clrSaddleBrown,clrBlue,clrPink,clrGray};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create histogram buffer from the zero line
      this.CreateHistogram();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BWMFI);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("BW MFI("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Market Facilitation Index");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing BW MFI standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_BWMFI);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("BW MFI("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Market Facilitation Index");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Momentum                        |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateMomentum(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int mom_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iMomentum(symbol,timeframe,mom_period,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_MOMENTUM : id);
   color array_colors[1]={clrDodgerBlue};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_MOMENTUM);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("Momentum("+symbol+","+TimeframeDescription(timeframe)+": "+(string)mom_period+")");
      buff.SetIndicatorName("Momentum");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_MOMENTUM);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Momentum("+symbol+","+TimeframeDescription(timeframe)+": "+(string)mom_period+")");
      buff.SetIndicatorName("Momentum");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period MFI                             |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                  const int ma_period,
                                  const ENUM_APPLIED_VOLUME applied_volume,
                                  const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iMFI(symbol,timeframe,ma_period,applied_volume) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_MFI : id);
   color array_colors[1]={clrDodgerBlue};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_MFI);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("MFI("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Money Flow Index");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_MFI);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("MFI("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Money Flow Index");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period MA                              |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                 const int ma_period,
                                 const int ma_shift,
                                 const ENUM_MA_METHOD ma_method,
                                 const ENUM_APPLIED_PRICE applied_price,
                                 const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift=ma_shift*num_bars;
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iMA(symbol,timeframe,ma_period,shift,ma_method,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_MA : id);
   color array_colors[1]={clrRed};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_MA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("MA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Moving Average");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_MA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("MA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Moving Average");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period OsMA                            |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateOsMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                   const int fast_ema_period,
                                   const int slow_ema_period,
                                   const int signal_period,
                                   const ENUM_APPLIED_PRICE applied_price,
                                   const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iOsMA(symbol,timeframe,fast_ema_period,slow_ema_period,signal_period,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_OSMA : id);
   color array_colors[1]={clrSilver};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create histogram buffer from the zero line
      this.CreateHistogram();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_OSMA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("OsMA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)fast_ema_period+","+(string)slow_ema_period+","+(string)signal_period+")");
      buff.SetIndicatorName("Moving Average of Oscillator");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_OSMA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("OsMA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)fast_ema_period+","+(string)slow_ema_period+","+(string)signal_period+")");
      buff.SetIndicatorName("Moving Average of Oscillator");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period MACD                            |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateMACD(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                   const int fast_ema_period,
                                   const int slow_ema_period,
                                   const int signal_period,
                                   const ENUM_APPLIED_PRICE applied_price,
                                   const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iMACD(symbol,timeframe,fast_ema_period,slow_ema_period,signal_period,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_MACD : id);
   color array_colors[1]={clrSilver};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create histogram buffer from the zero line
      this.CreateHistogram();
      //--- Get the last created (drawn) buffer object and set all the necessary MACD line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_MACD);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetIndicatorName("Moving Average Convergence/Divergence");
      buff.SetIndicatorShortName("MACD("+symbol+","+TimeframeDescription(timeframe)+": "+(string)fast_ema_period+","+(string)slow_ema_period+","+(string)signal_period+")");
      buff.SetLabel(buff.IndicatorShortName()+" Main");
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Signal line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_MACD);
      buff.SetLineMode(INDICATOR_LINE_MODE_SIGNAL);
      buff.SetShowData(true);
      buff.SetIndicatorName("Moving Average Convergence/Divergence");
      buff.SetIndicatorShortName("MACD("+symbol+","+TimeframeDescription(timeframe)+": "+(string)fast_ema_period+","+(string)slow_ema_period+","+(string)signal_period+")");
      buff.SetLabel("Signal");
      array_colors[0]=clrRed;
      buff.SetColors(array_colors);
      buff.SetStyle(STYLE_DOT);
      
      //--- Create a calculated MACD line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary MACD line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_MACD);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel(buff.IndicatorShortName()+" Main");
      buff.SetIndicatorName("Moving Average Convergence/Divergence");
      
      //--- Create a calculated Lower line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Lower line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_MACD);
      buff.SetLineMode(INDICATOR_LINE_MODE_SIGNAL);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Signal");
      buff.SetIndicatorName("Moving Average Convergence/Divergence");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period OBV                             |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateOBV(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                  const ENUM_APPLIED_VOLUME applied_volume,
                                  const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iOBV(symbol,timeframe,applied_volume) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_OBV : id);
   color array_colors[1]={clrLightSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_OBV);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("OBV("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("On Balance Volume");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_OBV);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("OBV("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("On Balance Volume");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Parabolic SAR                   |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateSAR(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                  const double step,
                                  const double maximum,
                                  const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iSAR(symbol,timeframe,step,maximum) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_SAR : id);
   color array_colors[1]={clrLime};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create the arrows buffer
      this.CreateArrow();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_SAR);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("SAR("+symbol+","+TimeframeDescription(timeframe)+": "+::DoubleToString(step,2)+","+::DoubleToString(maximum,2)+")");
      buff.SetIndicatorName("Parabolic SAR");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_SAR);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("SAR("+symbol+","+TimeframeDescription(timeframe)+": "+::DoubleToString(step,2)+","+::DoubleToString(maximum,2)+")");
      buff.SetIndicatorName("Parabolic SAR");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period RSI                             |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateRSI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                  const int ma_period,
                                  const ENUM_APPLIED_PRICE applied_price,
                                  const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iRSI(symbol,timeframe,ma_period,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_RSI : id);
   color array_colors[1]={clrDodgerBlue};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_RSI);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("RSI("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Relative Strength Index");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_RSI);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("RSI("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Relative Strength Index");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period RVI                             |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateRVI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iRVI(symbol,timeframe,ma_period) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_RVI : id);
   color array_colors[1]={clrGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary RVI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_RVI);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetIndicatorName("Relative Vigor Index");
      buff.SetIndicatorShortName("RVI("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetLabel(buff.IndicatorShortName());
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Signal line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_RVI);
      buff.SetLineMode(INDICATOR_LINE_MODE_SIGNAL);
      buff.SetShowData(true);
      buff.SetIndicatorName("Relative Vigor Index");
      buff.SetIndicatorShortName("RVI("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetLabel("Signal");
      array_colors[0]=clrRed;
      buff.SetColors(array_colors);
      
      //--- Create a calculated RVI line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary RVI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_RVI);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetIndicatorName("Relative Vigor Index");
      buff.SetLabel("RVI("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period);
      
      //--- Create a calculated Signal line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Signal line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_RVI);
      buff.SetLineMode(INDICATOR_LINE_MODE_SIGNAL);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetIndicatorName("Relative Vigor Index");
      buff.SetLabel("Signal");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period StdDev                          |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateStdDev(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                     const int ma_period,
                                     const int ma_shift,
                                     const ENUM_MA_METHOD ma_method,
                                     const ENUM_APPLIED_PRICE applied_price,
                                     const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift=ma_shift*num_bars;
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iStdDev(symbol,timeframe,ma_period,shift,ma_method,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_STDDEV : id);
   color array_colors[1]={clrMediumSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_STDDEV);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("StdDev("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Standard Deviation");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_STDDEV);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("StdDev("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Standard Deviation");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Stochastic                      |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateStochastic(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                         const int Kperiod,
                                         const int Dperiod,
                                         const int slowing,
                                         const ENUM_MA_METHOD ma_method,
                                         const ENUM_STO_PRICE price_field,
                                         const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iStochastic(symbol,timeframe,Kperiod,Dperiod,slowing,ma_method,price_field) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_STOCHASTIC : id);
   color array_colors[1]={clrLightSeaGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary RVI line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_STOCHASTIC);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetIndicatorName("Stochastic Oscillator");
      buff.SetIndicatorShortName("Stoch("+symbol+","+TimeframeDescription(timeframe)+": "+(string)Kperiod+","+(string)Dperiod+","+(string)slowing+")");
      buff.SetLabel(buff.IndicatorShortName());
      buff.SetColors(array_colors);
      
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created (drawn) buffer object and set all the necessary Signal line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_STOCHASTIC);
      buff.SetLineMode(INDICATOR_LINE_MODE_SIGNAL);
      buff.SetShowData(true);
      buff.SetIndicatorName("Stochastic Oscillator");
      buff.SetIndicatorShortName("Stoch("+symbol+","+TimeframeDescription(timeframe)+": "+(string)Kperiod+","+(string)Dperiod+","+(string)slowing+")");
      buff.SetLabel("Signal");
      array_colors[0]=clrRed;
      buff.SetColors(array_colors);
      buff.SetStyle(STYLE_DOT);
      
      //--- Create a calculated Stoch line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Stoch line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_STOCHASTIC);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetIndicatorName("Stochastic Oscillator");
      buff.SetLabel("Stoch("+symbol+","+TimeframeDescription(timeframe)+": "+(string)Kperiod+","+(string)Dperiod+","+(string)slowing+")");
      
      //--- Create a calculated Signal line buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created (calculated) buffer object and set all the necessary Signal line parameters to it
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_STOCHASTIC);
      buff.SetLineMode(INDICATOR_LINE_MODE_SIGNAL);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetIndicatorName("Stochastic Oscillator");
      buff.SetLabel("Signal");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period TEMA                            |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateTEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                   const int ma_period,
                                   const int ma_shift,
                                   const ENUM_APPLIED_PRICE applied_price,
                                   const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift=ma_shift*num_bars;
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iTEMA(symbol,timeframe,ma_period,shift,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_TEMA : id);
   color array_colors[1]={clrRed};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_TEMA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("TEMA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Triple Exponential Moving Average");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_TEMA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("TEMA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Triple Exponential Moving Average");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period TriX                            |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateTriX(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                   const int ma_period,
                                   const ENUM_APPLIED_PRICE applied_price,
                                   const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iTriX(symbol,timeframe,ma_period,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_TRIX : id);
   color array_colors[1]={clrRed};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_TRIX);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("TRIX("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Triple Exponential Average");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_TRIX);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("TRIX("+symbol+","+TimeframeDescription(timeframe)+": "+(string)ma_period+")");
      buff.SetIndicatorName("Triple Exponential Average");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period WPR                             |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateWPR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int calc_period,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iWPR(symbol,timeframe,calc_period) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_WPR : id);
   color array_colors[1]={clrAqua};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_WPR);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("%R("+symbol+","+TimeframeDescription(timeframe)+": "+(string)calc_period+")");
      buff.SetIndicatorName("William's Percent Range");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_WPR);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("%R("+symbol+","+TimeframeDescription(timeframe)+": "+(string)calc_period+")");
      buff.SetIndicatorName("William's Percent Range");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period VIDYA                           |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateVIDYA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                    const int cmo_period,
                                    const int ema_period,
                                    const int ma_shift,
                                    const ENUM_APPLIED_PRICE applied_price,
                                    const int id=WRONG_VALUE)
  {
//--- Calculate and set the number of line shift bars
   int num_bars=::PeriodSeconds(timeframe)/::PeriodSeconds(PERIOD_CURRENT);
   int shift=ma_shift*num_bars;
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iVIDyA(symbol,timeframe,cmo_period,ema_period,shift,applied_price) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_VIDYA : id);
   color array_colors[1]={clrRed};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create line buffer
      this.CreateLine();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_VIDYA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("VIDYA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)cmo_period+","+(string)ema_period+")");
      buff.SetIndicatorName("Variable Index Dynamic Average");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetShift(shift);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_VIDYA);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("VIDYA("+symbol+","+TimeframeDescription(timeframe)+": "+(string)cmo_period+","+(string)ema_period+")");
      buff.SetIndicatorName("Variable Index Dynamic Average");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Create multi-symbol multi-period Volumes                         |
//+------------------------------------------------------------------+
int CBuffersCollection::CreateVolumes(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume,const int id=WRONG_VALUE)
  {
//--- Create indicator handle and set default ID
   int handle= #ifdef __MQL5__ ::iVolumes(symbol,timeframe,applied_volume) #else 0 #endif ;
   int identifier=(id==WRONG_VALUE ? IND_VOLUMES : id);
   color array_colors[3]={clrGreen,clrRed,clrGreen};
   CBuffer *buff=NULL;
   if(handle!=INVALID_HANDLE)
     {
      //--- Create histogram buffer from the zero line
      this.CreateHistogram();
      //--- Get the last created buffer object (drawn) and set to it all necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_VOLUMES);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetShowData(true);
      buff.SetLabel("Volumes("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Volumes");
      buff.SetColors(array_colors);
      
      //--- Create a calculated buffer storing standard indicator data
      this.CreateCalculate();
      //--- Get the last created buffer object (calculated) and set to it all the necessary parameters
      buff=this.GetLastCreateBuffer();
      if(buff==NULL)
         return INVALID_HANDLE;
      buff.SetSymbol(symbol);
      buff.SetTimeframe(timeframe);
      buff.SetID(identifier);
      buff.SetIndicatorHandle(handle);
      buff.SetIndicatorType(IND_VOLUMES);
      buff.SetLineMode(INDICATOR_LINE_MODE_MAIN);
      buff.SetEmptyValue(EMPTY_VALUE);
      buff.SetLabel("Volumes("+symbol+","+TimeframeDescription(timeframe)+")");
      buff.SetIndicatorName("Volumes");
     }
   return handle;
  }
//+------------------------------------------------------------------+
//| Prepare the calculated buffer data                               |
//| of all created standard indicators                               |
//+------------------------------------------------------------------+
bool CBuffersCollection::PreparingDataAllBuffersStdInd(void)
  {
   CArrayObj *list=this.GetListBuffersWithID();
   if(list==NULL || list.Total()==0)
     {
      ::Print(DFUN_ERR_LINE,CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_NO_BUFFER_OBJ));
      return false;
     }
   bool res=true;
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CBuffer *buff=list.At(i);
      if(buff==NULL || buff.TypeBuffer()==BUFFER_TYPE_DATA || buff.IndicatorType()==WRONG_VALUE)
         continue;
      CSeriesDE *series=this.m_timeseries.GetSeries(buff.Symbol(),buff.Timeframe());
      if(series==NULL)
         continue;
      int used_data=(int)series.AvailableUsedData();
      int copied=this.PreparingDataBufferStdInd(buff.IndicatorType(),buff.ID(),used_data);
      if(copied<used_data)
         res &=false;
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Clear the calculated buffer data of all created                  |
//| standard indicators by the timeseries index                      |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearDataAllBuffersStdInd(int series_index)
  {
   CArrayObj *list=this.GetListBuffersWithID();
   if(list==NULL || list.Total()==0)
     {
      ::Print(DFUN_ERR_LINE,CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_NO_BUFFER_OBJ));
      return;
     }
   int total=list.Total();
   for(int i=0;i<total;i++)
     {
      CBuffer *buff=list.At(i);
      if(buff==NULL || buff.TypeBuffer()==BUFFER_TYPE_CALCULATE || buff.IndicatorType()==WRONG_VALUE)
         continue;
      this.ClearDataBufferStdInd(buff.IndicatorType(),buff.ID(),series_index);
     }
  }
//+------------------------------------------------------------------+
//| Return the standard indicator buffer description                 |
//| by type and ID                                                   |
//+------------------------------------------------------------------+
string CBuffersCollection::GetLabelByTypeID(const ENUM_INDICATOR ind_type,const int id,const ENUM_INDICATOR_LINE_MODE line_mode=INDICATOR_LINE_MODE_MAIN)
  {
   CArrayObj *list=this.GetListBufferByTypeID(ind_type,id);
   list=CSelect::ByBufferProperty(list,BUFFER_PROP_IND_LINE_MODE,line_mode,EQUAL);
   if(list==NULL || list.Total()==0)
      return "";
   CBuffer *buff=list.At(0);
   if(buff==NULL)
      return "";
   return buff.Label();
  }
//+------------------------------------------------------------------+
//| Return the standard indicator short name                         |
//| by type and ID                                                   |
//+------------------------------------------------------------------+
string CBuffersCollection::GetIndicatorShortNameByTypeID(const ENUM_INDICATOR ind_type,const int id)
  {
   CArrayObj *list=this.GetListBufferByTypeID(ind_type,id);
   if(list==NULL || list.Total()==0)
      return "";
   CBuffer *buff=list.At(0);
   if(buff==NULL)
      return "";
   return buff.IndicatorShortName();
  }
//+------------------------------------------------------------------+
//| Prepare the calculated buffer data                               |
//| of the specified standard indicator                              |
//+------------------------------------------------------------------+
int CBuffersCollection::PreparingDataBufferStdInd(const ENUM_INDICATOR std_ind,const int id,const int total_copy)
  {
   CArrayObj *list_ind=this.GetListBufferByTypeID(std_ind,id);
   CArrayObj *list;
   list_ind=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_TYPE,BUFFER_TYPE_CALCULATE,EQUAL);
   if(list_ind==NULL || list_ind.Total()==0)
     {
      ::Print(DFUN_ERR_LINE,CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_NO_BUFFER_OBJ));
      return 0;
     }
   CBufferCalculate *buffer=NULL;
   int copied=WRONG_VALUE;
   int idx0=0,idx1=1,idx2=2;
   switch((int)std_ind)
     {
   //--- Single-buffer standard indicators
      case IND_AC          :
      case IND_AD          :
      case IND_AMA         :
      case IND_AO          :
      case IND_ATR         :
      case IND_BEARS       :
      case IND_BULLS       :
      case IND_BWMFI       :
      case IND_CCI         :
      case IND_CHAIKIN     :
      case IND_DEMA        :
      case IND_DEMARKER    :
      case IND_FORCE       :
      case IND_FRAMA       :
      case IND_MA          :
      case IND_MFI         :
      case IND_MOMENTUM    :
      case IND_OBV         :
      case IND_OSMA        :
      case IND_RSI         :
      case IND_SAR         :
      case IND_STDDEV      :
      case IND_TEMA        :
      case IND_TRIX        :
      case IND_VIDYA       :
      case IND_VOLUMES     :
      case IND_WPR         :
      
        buffer=list_ind.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),0,buffer.Shift(),total_copy);
        return copied;
      
   //--- Multi-buffer standard indicators
      case IND_ENVELOPES   :
      case IND_FRACTALS    :
      case IND_MACD        :
      case IND_RVI         :
      case IND_STOCHASTIC  :
      case IND_GATOR       :
        if(std_ind==IND_GATOR)
          {
           idx0=0;
           idx1=2;
          }
        else
          {
           idx0=0;
           idx1=1;
          }
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),idx0,buffer.Shift(),total_copy);
        if(copied<total_copy) return 0;
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,1,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),idx1,buffer.Shift(),total_copy);
        if(copied<total_copy) return 0;
        return copied;
      
      case IND_ALLIGATOR   :
      case IND_ADX         :
      case IND_ADXW        :
      case IND_BANDS       :
        if(std_ind==IND_BANDS)
          {
           idx0=1;
           idx1=2;
           idx2=0;
          }
        else
          {
           idx0=0;
           idx1=1;
           idx2=2;
          }
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),idx0,buffer.Shift(),total_copy);
        if(copied<total_copy) return 0;
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,1,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),idx1,buffer.Shift(),total_copy);
        if(copied<total_copy) return 0;
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,2,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),idx2,buffer.Shift(),total_copy);
        if(copied<total_copy) return 0;
        return copied;
      
      case IND_ICHIMOKU    :
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_TENKAN_SEN,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),TENKANSEN_LINE,buffer.Shift(),total_copy);
        if(copied<total_copy) return 0;
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_KIJUN_SEN,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),KIJUNSEN_LINE,buffer.Shift(),total_copy);
        if(copied<total_copy) return 0;
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_SENKOU_SPANA,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),SENKOUSPANA_LINE,buffer.Shift(),total_copy);
        if(copied<total_copy) return 0;
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_SENKOU_SPANB,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),SENKOUSPANB_LINE,buffer.Shift(),total_copy);
        if(copied<total_copy) return 0;
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_CHIKOU_SPAN,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return 0;
        copied=buffer.FillAsSeries(buffer.IndicatorHandle(),CHIKOUSPAN_LINE,buffer.Shift(),total_copy);
        if(copied<total_copy) return 0;
        return copied;
      
      default:
        break;
     }
   return 0;
  }
//+------------------------------------------------------------------+
//| Clear buffer data of the specified standard indicator            |
//| by the timeseries index                                          |
//+------------------------------------------------------------------+
void CBuffersCollection::ClearDataBufferStdInd(const ENUM_INDICATOR std_ind,const int id,const int series_index)
  {
//--- Get the list of buffer objects by type and ID
   CArrayObj *list_ind=this.GetListBufferByTypeID(std_ind,id);
   CArrayObj *list=NULL;
   if(list_ind==NULL || list_ind.Total()==0)
      return;
   list_ind=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_TYPE,BUFFER_TYPE_DATA,EQUAL);
   if(list_ind.Total()==0)
      return;
   CBuffer *buffer=NULL;
   switch((int)std_ind)
     {
   //--- Single-buffer standard indicators
      case IND_AC          :
      case IND_AD          :
      case IND_AMA         :
      case IND_AO          :
      case IND_ATR         :
      case IND_BEARS       :
      case IND_BULLS       :
      case IND_BWMFI       :
      case IND_CCI         :
      case IND_CHAIKIN     :
      case IND_DEMA        :
      case IND_DEMARKER    :
      case IND_FORCE       :
      case IND_FRAMA       :
      case IND_MA          :
      case IND_MFI         :
      case IND_MOMENTUM    :
      case IND_OBV         :
      case IND_OSMA        :
      case IND_RSI         :
      case IND_SAR         :
      case IND_STDDEV      :
      case IND_TEMA        :
      case IND_TRIX        :
      case IND_VIDYA       :
      case IND_VOLUMES     :
      case IND_WPR         :
        buffer=list_ind.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        break;
      
   //--- Multi-buffer standard indicators
      case IND_ENVELOPES   :
      case IND_FRACTALS    :
      case IND_MACD        :
      case IND_RVI         :
      case IND_STOCHASTIC  :
      case IND_GATOR       :
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,1,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        break;

      case IND_ALLIGATOR   :
      case IND_ADX         :
      case IND_ADXW        :
      case IND_BANDS       :
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,1,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,2,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        break;
      
      case IND_ICHIMOKU :
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_TENKAN_SEN,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_KIJUN_SEN,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_SENKOU_SPANA,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_SENKOU_SPANB,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_CHIKOU_SPAN,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_ADDITIONAL,EQUAL);
        list=CSelect::ByBufferProperty(list,BUFFER_PROP_IND_LINE_ADDITIONAL_NUM,0,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        
        list=CSelect::ByBufferProperty(list_ind,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_ADDITIONAL,EQUAL);
        list=CSelect::ByBufferProperty(list,BUFFER_PROP_IND_LINE_ADDITIONAL_NUM,1,EQUAL);
        buffer=list.At(0);
        if(buffer==NULL) return;
        buffer.SetBufferValue(0,series_index,buffer.EmptyValue());
        break;
      
      default:
        break;
     }
  }
//+------------------------------------------------------------------+
//| Prepare data of the specified standard indicator                 |
//| for setting values on the current symbol chart                   |
//+------------------------------------------------------------------+
int CBuffersCollection::PreparingSetDataStdInd(CBuffer *buffer_data0,CBuffer *buffer_data1,CBuffer *buffer_data2,CBuffer *buffer_data3,CBuffer *buffer_data4,
                                               CBuffer *buffer_calc0,CBuffer *buffer_calc1,CBuffer *buffer_calc2,CBuffer *buffer_calc3,CBuffer *buffer_calc4,
                                               const ENUM_INDICATOR ind_type,
                                               const int series_index,
                                               const datetime series_time,
                                               int &index_period,
                                               int &num_bars,
                                               double &value00,
                                               double &value01,
                                               double &value10,
                                               double &value11,
                                               double &value20,
                                               double &value21,
                                               double &value30,
                                               double &value31,
                                               double &value40,
                                               double &value41)
  {
     //--- Find the bar index corresponding to the current bar start time
     index_period=::iBarShift(buffer_data0.Symbol(),buffer_data0.Timeframe(),series_time,true);
     if(index_period==WRONG_VALUE || #ifdef __MQL5__ index_period>buffer_calc0.GetDataTotal()-1 #else index_period>buffer_data0.GetDataTotal()-1 #endif )
        return WRONG_VALUE;
     
     //--- For MQL5
     #ifdef __MQL5__
        //--- Get the value by this index from indicator buffer
        if(buffer_calc0!=NULL)
           value00=buffer_calc0.GetDataBufferValue(0,index_period);
        if(buffer_calc1!=NULL)
           value10=buffer_calc1.GetDataBufferValue(0,index_period);
        if(buffer_calc2!=NULL)
           value20=buffer_calc2.GetDataBufferValue(0,index_period);
        if(buffer_calc3!=NULL)
           value30=buffer_calc3.GetDataBufferValue(0,index_period);
        if(buffer_calc4!=NULL)
           value40=buffer_calc4.GetDataBufferValue(0,index_period);
     
     //--- for MQL4
     #else 
        switch((int)ind_type)
          {
           //--- Single-buffer standard indicators
           case IND_AC           :  value00=::iAC(buffer_data0.Symbol(),buffer_data0.Timeframe(),index_period);      break;
           case IND_AD           :  value00=::iAD(buffer_data0.Symbol(),buffer_data0.Timeframe(),index_period);      break;
           case IND_AMA          :  break;
           case IND_AO           :  value00=::iAO(buffer_data0.Symbol(),buffer_data0.Timeframe(),index_period);      break;
           case IND_ATR          :  break;
           case IND_BEARS        :  break;
           case IND_BULLS        :  break;
           case IND_BWMFI        :  value00=::iBWMFI(buffer_data0.Symbol(),buffer_data0.Timeframe(),index_period);   break;
           case IND_CCI          :  break;
           case IND_CHAIKIN      :  break;
           case IND_DEMA         :  break;
           case IND_DEMARKER     :  break;
           case IND_FORCE        :  break;
           case IND_FRAMA        :  break;
           case IND_MA           :  break;
           case IND_MFI          :  break;
           case IND_MOMENTUM     :  break;
           case IND_OBV          :  break;
           case IND_OSMA         :  break;
           case IND_RSI          :  break;
           case IND_SAR          :  break;
           case IND_STDDEV       :  break;
           case IND_TEMA         :  break;
           case IND_TRIX         :  break;
           case IND_VIDYA        :  break;
           case IND_VOLUMES      :  value00=(double)::iVolume(buffer_data0.Symbol(),buffer_data0.Timeframe(),index_period);  break;
           case IND_WPR          :  break;
            
           //--- Multi-buffer standard indicators
           case IND_ENVELOPES    :  break;
           case IND_FRACTALS     :  break;
           
           case IND_ADX          :  break;
           case IND_ADXW         :  break;
           case IND_BANDS        :  break;
           case IND_MACD         :  break;
           case IND_RVI          :  break;
           case IND_STOCHASTIC   :  break;
           case IND_ALLIGATOR    :  break;
           
           case IND_ICHIMOKU     :  break;
           case IND_GATOR        :  break;
           
           default:
             break;
          }
     #endif 
     
     int series_index_start=series_index;
     //--- The current chart requires no calculation of the number of handled bars since there is only one bar
     if(buffer_data0.Symbol()==::Symbol() && buffer_data0.Timeframe()==::Period())
       {
        series_index_start=series_index;
        num_bars=1;
       }
     else
       {
        //--- Get the bar time which the bar with index_period index falls into on a period and symbol of calculated buffer
        datetime time_period=::iTime(buffer_data0.Symbol(),buffer_data0.Timeframe(),index_period);
        if(time_period==0) return false;
        //--- Get the current chart bar which corresponds to the time
        series_index_start=::iBarShift(::Symbol(),::Period(),time_period,true);
        if(series_index_start==WRONG_VALUE) return WRONG_VALUE;
        //--- Calculate the number of bars on the current chart which are to be filled in with calculated buffer data
        num_bars=::PeriodSeconds(buffer_data0.Timeframe())/::PeriodSeconds(PERIOD_CURRENT);
        if(num_bars==0) num_bars=1;
       }
     //--- Set values to calculate colors
     if(buffer_data0!=NULL)
        value01=(series_index_start+num_bars>buffer_data0.GetDataTotal()-1 ? value00 : buffer_data0.GetDataBufferValue(0,series_index_start+num_bars));
     if(buffer_data1!=NULL)
        value11=(series_index_start+num_bars>buffer_data1.GetDataTotal()-1 ? value10 : buffer_data1.GetDataBufferValue(0,series_index_start+num_bars));
     if(buffer_data2!=NULL)
        value21=(series_index_start+num_bars>buffer_data2.GetDataTotal()-1 ? value20 : buffer_data2.GetDataBufferValue(0,series_index_start+num_bars));
     if(buffer_data3!=NULL)
        value31=(series_index_start+num_bars>buffer_data3.GetDataTotal()-1 ? value30 : buffer_data3.GetDataBufferValue(0,series_index_start+num_bars));
     if(buffer_data4!=NULL)
        value41=(series_index_start+num_bars>buffer_data4.GetDataTotal()-1 ? value40 : buffer_data4.GetDataBufferValue(0,series_index_start+num_bars));
   
   return series_index_start;
  }
//+------------------------------------------------------------------+
//| Set values for the current chart to the buffers of the specified |
//| standard indicator by the timeseries index according to          |
//| the buffer object symbol/period                                  |
//+------------------------------------------------------------------+
bool CBuffersCollection::SetDataBufferStdInd(const ENUM_INDICATOR ind_type,const int id,const int series_index,const datetime series_time,const char color_index=WRONG_VALUE)
  {
//--- Get the list of buffer objects by type and ID
   CArrayObj *list=this.GetListBufferByTypeID(ind_type,id);
   if(list==NULL || list.Total()==0)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_NO_BUFFER_OBJ));
      return false;
     }
     
//--- Get the list of drawn objects with ID
   CArrayObj *list_data=CSelect::ByBufferProperty(list,BUFFER_PROP_TYPE,BUFFER_TYPE_DATA,EQUAL);
   list_data=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_TYPE,ind_type,EQUAL);
//--- Get the list of calculated buffers with ID
   CArrayObj *list_calc=CSelect::ByBufferProperty(list,BUFFER_PROP_TYPE,BUFFER_TYPE_CALCULATE,EQUAL);
   list_calc=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_TYPE,ind_type,EQUAL);
 
//--- Exit if any of the lists is empty
   if(list_data.Total()==0 #ifdef __MQL5__ || list_calc.Total()==0 #endif )
      return false;
  
//--- Declare necessary objects and variables
   CBuffer *buffer_data0=NULL,*buffer_data1=NULL,*buffer_data2=NULL,*buffer_data3=NULL,*buffer_data4=NULL,*buffer_tmp0=NULL,*buffer_tmp1=NULL;
   CBuffer *buffer_calc0=NULL,*buffer_calc1=NULL,*buffer_calc2=NULL,*buffer_calc3=NULL,*buffer_calc4=NULL;
   #ifdef __MQL4__ CBuffer *buff_add=NULL; #endif 

   double value00=EMPTY_VALUE, value01=EMPTY_VALUE;
   double value10=EMPTY_VALUE, value11=EMPTY_VALUE;
   double value20=EMPTY_VALUE, value21=EMPTY_VALUE;
   double value30=EMPTY_VALUE, value31=EMPTY_VALUE;
   double value40=EMPTY_VALUE, value41=EMPTY_VALUE;
   double value_tmp0=EMPTY_VALUE,value_tmp1=EMPTY_VALUE;
   long vol0=0,vol1=0;
   int series_index_start=series_index,index_period=0, index=0,num_bars=1;
   uchar clr=0;
//--- Depending on standard indicator type

   switch((int)ind_type)
     {
   //--- Single-buffer standard indicators
      case IND_AC       :
      case IND_AD       :
      case IND_AMA      :
      case IND_AO       :
      case IND_ATR      :
      case IND_BEARS    :
      case IND_BULLS    :
      case IND_BWMFI    :
      case IND_CCI      :
      case IND_CHAIKIN  :
      case IND_DEMA     :
      case IND_DEMARKER :
      case IND_FORCE    :
      case IND_FRAMA    :
      case IND_MA       :
      case IND_MFI      :
      case IND_MOMENTUM :
      case IND_OBV      :
      case IND_OSMA     :
      case IND_RSI      :
      case IND_SAR      :
      case IND_STDDEV   :
      case IND_TEMA     :
      case IND_TRIX     :
      case IND_VIDYA    :
      case IND_VOLUMES  :
      case IND_WPR      :
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer_data0=list.At(0);
      #ifdef __MQL5__
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer_calc0=list.At(0);
      #endif 
        
        if(buffer_data0==NULL #ifdef __MQL5__ || buffer_calc0==NULL || buffer_calc0.GetDataTotal(0)==0 #endif )
           return false;

        series_index_start=PreparingSetDataStdInd(buffer_data0,buffer_data1,buffer_data2,buffer_data3,buffer_data4,
                                                  buffer_calc0,buffer_calc1,buffer_calc2,buffer_calc3,buffer_calc4,
                                                  ind_type,series_index,series_time,index_period,num_bars,
                                                  value00,value01,value10,value11,value20,value21,value30,value31,value40,value41);

        if(series_index_start==WRONG_VALUE)
           return false;
        //--- In a loop, by the number of bars in  num_bars fill in the drawn buffer with a value from the calculated buffer taken by index_period index
        //--- and set the color of the drawn buffer depending on the value00 and value01 values ratio
        for(int i=0;i<num_bars;i++)
          {
           index=series_index_start-i;
           buffer_data0.SetBufferValue(0,index,value00);
           if(ind_type!=IND_BWMFI)
              clr=(color_index==WRONG_VALUE ? uchar(value00>value01 ? 0 : value00<value01 ? 1 : 2) : color_index);
           else
             {
              vol0=::iVolume(buffer_data0.Symbol(),buffer_data0.Timeframe(),index_period);
              vol1=::iVolume(buffer_data0.Symbol(),buffer_data0.Timeframe(),index_period+1);
              clr=
                (
                 value00>value01 && vol0>vol1 ? 0 :
                 value00<value01 && vol0<vol1 ? 1 :
                 value00>value01 && vol0<vol1 ? 2 :
                 value00<value01 && vol0>vol1 ? 3 : 4
                );
             }
           #ifdef __MQL5__
              buffer_data0.SetBufferColorIndex(index,clr);
           #else 
              
           #endif 
          }
        return true;
      
   //--- Multi-buffer standard indicators
      case IND_ENVELOPES :
      case IND_FRACTALS  :
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer_data0=list.At(0);
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,1,EQUAL);
        buffer_data1=list.At(0);
           
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer_calc0=list.At(0);
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,1,EQUAL);
        buffer_calc1=list.At(0);
           
        if(buffer_calc0==NULL || buffer_data0==NULL || buffer_calc0.GetDataTotal(0)==0)
           return false;
        if(buffer_calc1==NULL || buffer_data1==NULL || buffer_calc1.GetDataTotal(0)==0)
           return false;
        
        series_index_start=PreparingSetDataStdInd(buffer_data0,buffer_data1,buffer_data2,buffer_data3,buffer_data4,
                                                  buffer_calc0,buffer_calc1,buffer_calc2,buffer_calc3,buffer_calc4,
                                                  ind_type,series_index,series_time,index_period,num_bars,
                                                  value00,value01,value10,value11,value20,value21,value30,value31,value40,value41);
        if(series_index_start==WRONG_VALUE)
           return false;
        //--- In a loop, by the number of bars in  num_bars fill in the drawn buffer with a value from the calculated buffer taken by index_period index
        //--- and set the color of the drawn buffer depending on the value00 and value01 values ratio
        for(int i=0;i<num_bars;i++)
          {
           index=series_index_start-i;
           buffer_data0.SetBufferValue(0,index,value00);
           buffer_data1.SetBufferValue(1,index,value10);
           buffer_data0.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value00>value01 ? 0 : value00<value01 ? 1 : 2) : color_index);
           buffer_data1.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value10>value11 ? 0 : value10<value11 ? 1 : 2) : color_index);
          }
        return true;
      
      case IND_ADX         :
      case IND_ADXW        :
      case IND_BANDS       :
      case IND_MACD        :
      case IND_RVI         :
      case IND_STOCHASTIC  :
      case IND_ALLIGATOR   :
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer_data0=list.At(0);
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,1,EQUAL);
        buffer_data1=list.At(0);
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,2,EQUAL);
        buffer_data2=list.At(0);
        
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer_calc0=list.At(0);
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,1,EQUAL);
        buffer_calc1=list.At(0);
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,2,EQUAL);
        buffer_calc2=list.At(0);
        
        if(buffer_calc0==NULL || buffer_data0==NULL || buffer_calc0.GetDataTotal(0)==0)
           return false;
        if(buffer_calc1==NULL || buffer_data1==NULL || buffer_calc1.GetDataTotal(0)==0)
           return false;
        if(buffer_calc2==NULL || buffer_data2==NULL || buffer_calc2.GetDataTotal(0)==0)
           return false;
        
        series_index_start=PreparingSetDataStdInd(buffer_data0,buffer_data1,buffer_data2,buffer_data3,buffer_data4,
                                                  buffer_calc0,buffer_calc1,buffer_calc2,buffer_calc3,buffer_calc4,
                                                  ind_type,series_index,series_time,index_period,num_bars,
                                                  value00,value01,value10,value11,value20,value21,value30,value31,value40,value41);
        if(series_index_start==WRONG_VALUE)
           return false;
        //--- In a loop, by the number of bars in  num_bars fill in the drawn buffer with a value from the calculated buffer taken by index_period index
        //--- and set the color of the drawn buffer depending on the value00 and value01 values ratio
        for(int i=0;i<num_bars;i++)
          {
           index=series_index_start-i;
           buffer_data0.SetBufferValue(0,index,value00);
           buffer_data1.SetBufferValue(0,index,value10);
           buffer_data2.SetBufferValue(0,index,value20);
           buffer_data0.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value00>value01 ? 0 : value00<value01 ? 1 : 2) : color_index);
           buffer_data1.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value10>value11 ? 0 : value10<value11 ? 1 : 2) : color_index);
           buffer_data2.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value20>value21 ? 0 : value20<value21 ? 1 : 2) : color_index);
          }
        return true;
      
      case IND_ICHIMOKU :
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_TENKAN_SEN,EQUAL);
        buffer_data0=list.At(0);
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_KIJUN_SEN,EQUAL);
        buffer_data1=list.At(0);
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_SENKOU_SPANA,EQUAL);
        buffer_data2=list.At(0);
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_SENKOU_SPANB,EQUAL);
        buffer_data3=list.At(0);
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_CHIKOU_SPAN,EQUAL);
        buffer_data4=list.At(0);
        
        //--- Get the list of buffer objects which have ID of auxiliary line, and from it - buffer object with line number as 0
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_ADDITIONAL,EQUAL);
        list=CSelect::ByBufferProperty(list,BUFFER_PROP_IND_LINE_ADDITIONAL_NUM,0,EQUAL);
        buffer_tmp0=list.At(0);
        //--- Get the list of buffer objects which have ID of auxiliary line, and from it - buffer object with line number as 1
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_ADDITIONAL,EQUAL);
        list=CSelect::ByBufferProperty(list,BUFFER_PROP_IND_LINE_ADDITIONAL_NUM,1,EQUAL);
        buffer_tmp1=list.At(0);
        
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_TENKAN_SEN,EQUAL);
        buffer_calc0=list.At(0);
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_KIJUN_SEN,EQUAL);
        buffer_calc1=list.At(0);
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_SENKOU_SPANA,EQUAL);
        buffer_calc2=list.At(0);
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_SENKOU_SPANB,EQUAL);
        buffer_calc3=list.At(0);
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,INDICATOR_LINE_MODE_CHIKOU_SPAN,EQUAL);
        buffer_calc4=list.At(0);
        
        if(buffer_calc0==NULL || buffer_data0==NULL || buffer_calc0.GetDataTotal(0)==0)
           return false;
        if(buffer_calc1==NULL || buffer_data1==NULL || buffer_calc1.GetDataTotal(0)==0)
           return false;
        if(buffer_calc2==NULL || buffer_data2==NULL || buffer_calc2.GetDataTotal(0)==0)
           return false;
        if(buffer_calc3==NULL || buffer_data3==NULL || buffer_calc3.GetDataTotal(0)==0)
           return false;
        if(buffer_calc4==NULL || buffer_data4==NULL || buffer_calc4.GetDataTotal(0)==0)
           return false;
        
        series_index_start=PreparingSetDataStdInd(buffer_data0,buffer_data1,buffer_data2,buffer_data3,buffer_data4,
                                                  buffer_calc0,buffer_calc1,buffer_calc2,buffer_calc3,buffer_calc4,
                                                  ind_type,series_index,series_time,index_period,num_bars,
                                                  value00,value01,value10,value11,value20,value21,value30,value31,value40,value41);
        if(series_index_start==WRONG_VALUE)
           return false;
        //--- In a loop, by the number of bars in  num_bars fill in the drawn buffer with a value from the calculated buffer taken by index_period index
        //--- and set the color of the drawn buffer depending on the value00 and value01 values ratio
        for(int i=0;i<num_bars;i++)
          {
           index=series_index_start-i;
           buffer_data0.SetBufferValue(0,index,value00);
           buffer_data1.SetBufferValue(0,index,value10);
           buffer_data2.SetBufferValue(0,index,value20);
           buffer_data3.SetBufferValue(0,index,value30);
           buffer_data4.SetBufferValue(0,index,value40);
           buffer_data0.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value00>value01 ? 0 : value00<value01 ? 1 : 2) : color_index);
           buffer_data1.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value10>value11 ? 0 : value10<value11 ? 1 : 2) : color_index);
           buffer_data2.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value20>value21 ? 0 : value20<value21 ? 1 : 2) : color_index);
           buffer_data3.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value30>value31 ? 0 : value30<value31 ? 1 : 2) : color_index);
           buffer_data4.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value40>value41 ? 0 : value40<value41 ? 1 : 2) : color_index);
           
           //--- Set values for indicator auxiliary lines depending on mutual position of  Senkou Span A and Senkou Span B lines
           value_tmp0=buffer_data2.GetDataBufferValue(0,index);
           value_tmp1=buffer_data3.GetDataBufferValue(0,index);
           if(value_tmp0<value_tmp1)
             {
              buffer_tmp0.SetBufferValue(0,index,buffer_tmp0.EmptyValue());
              buffer_tmp0.SetBufferValue(1,index,buffer_tmp0.EmptyValue());
              
              buffer_tmp1.SetBufferValue(0,index,value_tmp0);
              buffer_tmp1.SetBufferValue(1,index,value_tmp1);
             }
           else
             {
              buffer_tmp0.SetBufferValue(0,index,value_tmp0);
              buffer_tmp0.SetBufferValue(1,index,value_tmp1);
              
              buffer_tmp1.SetBufferValue(0,index,buffer_tmp1.EmptyValue());
              buffer_tmp1.SetBufferValue(1,index,buffer_tmp1.EmptyValue());
             }
           
          }
        return true;
      
      case IND_GATOR    :
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer_data0=list.At(0);
        list=CSelect::ByBufferProperty(list_data,BUFFER_PROP_IND_LINE_MODE,1,EQUAL);
        buffer_data1=list.At(0);
           
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,0,EQUAL);
        buffer_calc0=list.At(0);
        list=CSelect::ByBufferProperty(list_calc,BUFFER_PROP_IND_LINE_MODE,1,EQUAL);
        buffer_calc1=list.At(0);
           
        if(buffer_calc0==NULL || buffer_data0==NULL || buffer_calc0.GetDataTotal(0)==0)
           return false;
        if(buffer_calc1==NULL || buffer_data1==NULL || buffer_calc1.GetDataTotal(0)==0)
           return false;
        
        series_index_start=PreparingSetDataStdInd(buffer_data0,buffer_data1,buffer_data2,buffer_data3,buffer_data4,
                                                  buffer_calc0,buffer_calc1,buffer_calc2,buffer_calc3,buffer_calc4,
                                                  ind_type,series_index,series_time,index_period,num_bars,
                                                  value00,value01,value10,value11,value20,value21,value30,value31,value40,value41);
        if(series_index_start==WRONG_VALUE)
           return false;
        //--- In a loop, by the number of bars in  num_bars fill in the drawn buffer with a value from the calculated buffer taken by index_period index
        //--- and set the color of the drawn buffer depending on the value00 and value01 values ratio
        for(int i=0;i<num_bars;i++)
          {
           index=series_index_start-i;
           buffer_data0.SetBufferValue(0,index,value00);
           buffer_data1.SetBufferValue(1,index,value10);
           buffer_data0.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value00>value01 ? 0 : value00<value01 ? 1 : 2) : color_index);
           buffer_data1.SetBufferColorIndex(index,color_index==WRONG_VALUE ? uchar(value10<value11 ? 0 : value10>value11 ? 1 : 2) : color_index);
          }
        return true;
      
      default:
        break;
     }
   return false;
  }
//+------------------------------------------------------------------+
