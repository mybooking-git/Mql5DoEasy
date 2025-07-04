//+------------------------------------------------------------------+
//|                                         IndicatorsCollection.mqh |
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
#include "..\Objects\Indicators\Standard\IndAC.mqh"
#include "..\Objects\Indicators\Standard\IndAD.mqh"
#include "..\Objects\Indicators\Standard\IndADX.mqh"
#include "..\Objects\Indicators\Standard\IndADXW.mqh"
#include "..\Objects\Indicators\Standard\IndAlligator.mqh"
#include "..\Objects\Indicators\Standard\IndAMA.mqh"
#include "..\Objects\Indicators\Standard\IndAO.mqh"
#include "..\Objects\Indicators\Standard\IndATR.mqh"
#include "..\Objects\Indicators\Standard\IndBands.mqh"
#include "..\Objects\Indicators\Standard\IndBears.mqh"
#include "..\Objects\Indicators\Standard\IndBulls.mqh"
#include "..\Objects\Indicators\Standard\IndBWMFI.mqh"
#include "..\Objects\Indicators\Standard\IndCCI.mqh"
#include "..\Objects\Indicators\Standard\IndChaikin.mqh"
#include "..\Objects\Indicators\Standard\IndCustom.mqh"
#include "..\Objects\Indicators\Standard\IndDEMA.mqh"
#include "..\Objects\Indicators\Standard\IndDeMarker.mqh"
#include "..\Objects\Indicators\Standard\IndEnvelopes.mqh"
#include "..\Objects\Indicators\Standard\IndForce.mqh"
#include "..\Objects\Indicators\Standard\IndFractals.mqh"
#include "..\Objects\Indicators\Standard\IndFRAMA.mqh"
#include "..\Objects\Indicators\Standard\IndGator.mqh"
#include "..\Objects\Indicators\Standard\IndIchimoku.mqh"
#include "..\Objects\Indicators\Standard\IndMA.mqh"
#include "..\Objects\Indicators\Standard\IndMACD.mqh"
#include "..\Objects\Indicators\Standard\IndMFI.mqh"
#include "..\Objects\Indicators\Standard\IndMomentum.mqh"
#include "..\Objects\Indicators\Standard\IndOBV.mqh"
#include "..\Objects\Indicators\Standard\IndOsMA.mqh"
#include "..\Objects\Indicators\Standard\IndRSI.mqh"
#include "..\Objects\Indicators\Standard\IndRVI.mqh"
#include "..\Objects\Indicators\Standard\IndSAR.mqh"
#include "..\Objects\Indicators\Standard\IndStDev.mqh"
#include "..\Objects\Indicators\Standard\IndStoch.mqh"
#include "..\Objects\Indicators\Standard\IndTEMA.mqh"
#include "..\Objects\Indicators\Standard\IndTRIX.mqh"
#include "..\Objects\Indicators\Standard\IndVIDYA.mqh"
#include "..\Objects\Indicators\Standard\IndVolumes.mqh"
#include "..\Objects\Indicators\Standard\IndWPR.mqh"
//+------------------------------------------------------------------+
//| Indicator collection                                             |
//+------------------------------------------------------------------+
class CIndicatorsCollection : public CObject
  {
private:
   CListObj                m_list;                       // List of indicator objects
   MqlParam                m_mql_param[];                // Array of indicator parameters
   int                     m_type;                       // Object type
//--- (1) Create, (2) add to collection list a new indicator object and set an ID for it
   CIndicatorDE           *CreateIndicator(const ENUM_INDICATOR ind_type,MqlParam &mql_param[],const string symbol_name=NULL,const ENUM_TIMEFRAMES period=PERIOD_CURRENT);
   int                     AddIndicatorToList(CIndicatorDE *indicator,const int id,const int buffers_total,const uint required=0);
//--- Return the indicator index in the list
   int                     Index(CIndicatorDE *compared_obj);
//--- Check presence of indicator object with specified id in the list
   bool                    CheckID(const int id);

public:
//--- Return (1) itself, (2) indicator list, (3) list of indicators by type
   CIndicatorsCollection  *GetObject(void)               { return &this;                                       }
   CArrayObj              *GetList(void)                 { return &this.m_list;                                }
//--- Return indicator list by (1) status, (2) type, (3) timeframe, (4) group, (5) symbol, (6) name, (7) short name
   CArrayObj              *GetListIndByStatus(const ENUM_INDICATOR_STATUS status)
                             { return CSelect::ByIndicatorProperty(this.GetList(),INDICATOR_PROP_STATUS,status,EQUAL);        }
   CArrayObj              *GetListIndByType(const ENUM_INDICATOR type)
                             { return CSelect::ByIndicatorProperty(this.GetList(),INDICATOR_PROP_TYPE,type,EQUAL);            }
   CArrayObj              *GetListIndByTimeframe(const ENUM_TIMEFRAMES timeframe)
                             { return CSelect::ByIndicatorProperty(this.GetList(),INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);  }
   CArrayObj              *GetListIndByGroup(const ENUM_INDICATOR_GROUP group)
                             { return CSelect::ByIndicatorProperty(this.GetList(),INDICATOR_PROP_GROUP,group,EQUAL);          }
   CArrayObj              *GetListIndBySymbol(const string symbol)
                             { return CSelect::ByIndicatorProperty(this.GetList(),INDICATOR_PROP_SYMBOL,symbol,EQUAL);        }
   CArrayObj              *GetListIndByName(const string name)
                             { return CSelect::ByIndicatorProperty(this.GetList(),INDICATOR_PROP_NAME,name,EQUAL);            }
   CArrayObj              *GetListIndByShortname(const string shortname)
                             { return CSelect::ByIndicatorProperty(this.GetList(),INDICATOR_PROP_SHORTNAME,shortname,EQUAL);  }
  
//--- Return the list of indicator objects by type of indicator, symbol and timeframe
   CArrayObj              *GetListAC(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListAD(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListADX(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListADXWilder(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListAlligator(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListAMA(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListAO(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListATR(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListBands(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListBearsPower(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListBullsPower(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListChaikin(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListCCI(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListDEMA(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListDeMarker(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListEnvelopes(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListForce(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListFractals(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListFrAMA(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListGator(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListIchimoku(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListBWMFI(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListMomentum(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListMFI(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListMA(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListOsMA(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListMACD(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListOBV(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListSAR(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListRSI(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListRVI(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListStdDev(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListStochastic(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListTEMA(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListTriX(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListWPR(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListVIDYA(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CArrayObj              *GetListVolumes(const string symbol,const ENUM_TIMEFRAMES timeframe);
   
//--- Return the pointer to indicator object in the collection by indicator type and by its parameters
   CIndicatorDE           *GetIndAC(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CIndicatorDE           *GetIndAD(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume);
   CIndicatorDE           *GetIndADX(const string symbol,const ENUM_TIMEFRAMES timeframe,const int adx_period);
   CIndicatorDE           *GetIndADXWilder(const string symbol,const ENUM_TIMEFRAMES timeframe,const int adx_period);
   CIndicatorDE           *GetIndAlligator(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int jaw_period,
                                       const int jaw_shift,
                                       const int teeth_period,
                                       const int teeth_shift,
                                       const int lips_period,
                                       const int lips_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ama_period,
                                       const int fast_ema_period,
                                       const int slow_ema_period,
                                       const int ama_shift,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndAO(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CIndicatorDE           *GetIndATR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period);
   CIndicatorDE           *GetIndBands(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const double deviation,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndBearsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period);
   CIndicatorDE           *GetIndBullsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period);
   CIndicatorDE           *GetIndChaikin(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int fast_ma_period,
                                       const int slow_ma_period,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_VOLUME applied_volume);
   CIndicatorDE           *GetIndCCI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndCustom(const string symbol,const ENUM_TIMEFRAMES timeframe,ENUM_INDICATOR_GROUP group,MqlParam &param[]);
   CIndicatorDE           *GetIndDEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndDeMarker(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period);
   CIndicatorDE           *GetIndEnvelopes(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const double deviation);
   CIndicatorDE           *GetIndForce(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_VOLUME applied_volume);
   CIndicatorDE           *GetIndFractals(const string symbol,const ENUM_TIMEFRAMES timeframe);
   CIndicatorDE           *GetIndFrAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndGator(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int jaw_period,
                                       const int jaw_shift,
                                       const int teeth_period,
                                       const int teeth_shift,
                                       const int lips_period,
                                       const int lips_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndIchimoku(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int tenkan_sen,
                                       const int kijun_sen,
                                       const int senkou_span_b);
   CIndicatorDE           *GetIndBWMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const ENUM_APPLIED_VOLUME applied_volume);
   CIndicatorDE           *GetIndMomentum(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int mom_period,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_VOLUME applied_volume);
   CIndicatorDE           *GetIndMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndOsMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int fast_ema_period,
                                       const int slow_ema_period,
                                       const int signal_period,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndMACD(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int fast_ema_period,
                                       const int slow_ema_period,
                                       const int signal_period,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndOBV(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const ENUM_APPLIED_VOLUME applied_volume);
   CIndicatorDE           *GetIndSAR(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const double step,
                                       const double maximum);
   CIndicatorDE           *GetIndRSI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndRVI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period);
   CIndicatorDE           *GetIndStdDev(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndStochastic(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int Kperiod,
                                       const int Dperiod,
                                       const int slowing,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_STO_PRICE price_field);
   CIndicatorDE           *GetIndTEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndTriX(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndWPR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int calc_period);
   CIndicatorDE           *GetIndVIDYA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int cmo_period,
                                       const int ema_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price);
   CIndicatorDE           *GetIndVolumes(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume);
  
//--- Create a new indicator object by indicator type and places it to collection list
   int                     CreateAC(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id);
   int                     CreateAD(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK);
   int                     CreateADX(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int adx_period=14);
   int                     CreateADXWilder(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int adx_period=14);
   int                     CreateAlligator(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int jaw_period=13,
                                       const int jaw_shift=8,
                                       const int teeth_period=8,
                                       const int teeth_shift=5,
                                       const int lips_period=5,
                                       const int lips_shift=3,
                                       const ENUM_MA_METHOD ma_method=MODE_SMMA,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_MEDIAN);
   int                     CreateAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ama_period=9,
                                       const int fast_ema_period=2,
                                       const int slow_ema_period=30,
                                       const int ama_shift=0,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateAO(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id);
   int                     CreateATR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int ma_period=14);
   int                     CreateBands(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=20,
                                       const int ma_shift=0,
                                       const double deviation=2.000,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateBearsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int ma_period=13);
   int                     CreateBullsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int ma_period=13);
   int                     CreateChaikin(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int fast_ma_period=3,
                                       const int slow_ma_period=10,
                                       const ENUM_MA_METHOD ma_method=MODE_EMA,
                                       const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK);
   int                     CreateCCI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=14,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_TYPICAL);
   int                     CreateCustom(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int buffers_total,
                                       ENUM_INDICATOR_GROUP group,
                                       MqlParam &mql_param[]);
   int                     CreateDEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=14,
                                       const int ma_shift=0,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateDeMarker(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int ma_period=14);
   int                     CreateEnvelopes(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=14,
                                       const int ma_shift=0,
                                       const ENUM_MA_METHOD ma_method=MODE_SMA,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE,
                                       const double deviation=0.1);
   int                     CreateForce(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_VOLUME applied_volume);
   int                     CreateFractals(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id);
   int                     CreateFrAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=14,
                                       const int ma_shift=0,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateGator(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int jaw_period=13,
                                       const int jaw_shift=8,
                                       const int teeth_period=8,
                                       const int teeth_shift=5,
                                       const int lips_period=5,
                                       const int lips_shift=3,
                                       const ENUM_MA_METHOD ma_method=MODE_SMMA,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_MEDIAN);
   int                     CreateIchimoku(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int tenkan_sen=9,
                                       const int kijun_sen=26,
                                       const int senkou_span_b=52);
   int                     CreateBWMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK);
   int                     CreateMomentum(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int mom_period=14,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=14,
                                       const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK);
   int                     CreateMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=10,
                                       const int ma_shift=0,
                                       const ENUM_MA_METHOD ma_method=MODE_SMA,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateOsMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int fast_ema_period=12,
                                       const int slow_ema_period=26,
                                       const int signal_period=9,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateMACD(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int fast_ema_period=12,
                                       const int slow_ema_period=26,
                                       const int signal_period=9,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateOBV(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK);
   int                     CreateSAR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const double step=0.02,
                                       const double maximum=0.2);
   int                     CreateRSI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=14,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateRVI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int ma_period=10);
   int                     CreateStdDev(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=20,
                                       const int ma_shift=0,
                                       const ENUM_MA_METHOD ma_method=MODE_SMA,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateStochastic(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int Kperiod=5,
                                       const int Dperiod=3,
                                       const int slowing=3,
                                       const ENUM_MA_METHOD ma_method=MODE_SMA,
                                       const ENUM_STO_PRICE price_field=STO_LOWHIGH);
   int                     CreateTEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=14,
                                       const int ma_shift=0,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateTriX(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=14,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateWPR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int calc_period=14);
   int                     CreateVIDYA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int cmo_period=9,
                                       const int ema_period=12,
                                       const int ma_shift=0,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE);
   int                     CreateVolumes(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK);

//--- Set ID for the specified indicator
   void                    SetID(CIndicatorDE *indicator,const int id);
   
//--- Return (1) indicator object by its ID, (2) the data object of indicator buffer timeseries by time
   CIndicatorDE           *GetIndByID(const uint id);
   CDataInd               *GetDataIndObj(const uint ind_id,const int buffer_num,const datetime time);

//--- Display (1) the complete and (2) short collection description in the journal
   void                    Print(void);
   void                    PrintShort(void);

//--- Create (1) timeseries of specified indicator data, (2) all timeseries used of all collection indicators
   bool                    SeriesCreate(CIndicatorDE *indicator,const uint required=0);
   bool                    SeriesCreateAll(const uint required=0);
//--- Update buffer data of all indicators
   void                    SeriesRefreshAll(void);
   void                    SeriesRefresh(const int ind_id);
//--- Return by bar (1) time, (2) number the value of the buffer specified by indicator ID and (3) the object type
   double                  GetBufferValue(const uint ind_id,const int buffer_num,const datetime time);
   double                  GetBufferValue(const uint ind_id,const int buffer_num,const uint shift);
   virtual int             Type(void)  const { return this.m_type;   }
//--- Constructor
                           CIndicatorsCollection();

  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CIndicatorsCollection::CIndicatorsCollection()
  {
   this.m_type=COLLECTION_INDICATORS_ID;
   ::ArrayResize(this.m_mql_param,0);
   this.m_list.Clear();
   this.m_list.Sort();
   this.m_list.Type(COLLECTION_INDICATORS_ID);
  }
//+------------------------------------------------------------------+
//| Display complete collection description in the journal           |
//+------------------------------------------------------------------+
void CIndicatorsCollection::Print(void)
  {
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CIndicatorDE *ind=m_list.At(i);
      if(ind==NULL)
         continue;
      ind.Print();
     }
  }
//+------------------------------------------------------------------+
//| Display the short collection description in the journal          |
//+------------------------------------------------------------------+
void CIndicatorsCollection::PrintShort(void)
  {
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CIndicatorDE *ind=m_list.At(i);
      if(ind==NULL)
         continue;
      ind.PrintShort();
     }
  }
//+------------------------------------------------------------------+
//| Return the indicator index in the list                           |
//+------------------------------------------------------------------+
int CIndicatorsCollection::Index(CIndicatorDE *compared_obj)
  {
   int total=this.m_list.Total();
   for(int i=0;i<total;i++)
     {
      CIndicatorDE *indicator=this.m_list.At(i);
      if(indicator==NULL)
         continue;
      if(indicator.IsEqual(compared_obj))
         return i;
     }
   return WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| Create a new indicator object                                    |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::CreateIndicator(const ENUM_INDICATOR ind_type,MqlParam &mql_param[],
                                                     const string symbol_name=NULL,const ENUM_TIMEFRAMES period=PERIOD_CURRENT)
  {
   string symbol=(symbol_name==NULL || symbol_name=="" ? ::Symbol() : symbol_name);
   ENUM_TIMEFRAMES timeframe=(period==PERIOD_CURRENT ? ::Period() : period);
   CIndicatorDE *indicator=NULL;
   switch(ind_type)
     {
      case IND_AC          : indicator=new CIndAC(symbol,timeframe,mql_param);         break;
      case IND_AD          : indicator=new CIndAD(symbol,timeframe,mql_param);         break;
      case IND_ADX         : indicator=new CIndADX(symbol,timeframe,mql_param);        break;
      case IND_ADXW        : indicator=new CIndADXW(symbol,timeframe,mql_param);       break;
      case IND_ALLIGATOR   : indicator=new CIndAlligator(symbol,timeframe,mql_param);  break;
      case IND_AMA         : indicator=new CIndAMA(symbol,timeframe,mql_param);        break;
      case IND_AO          : indicator=new CIndAO(symbol,timeframe,mql_param);         break;
      case IND_ATR         : indicator=new CIndATR(symbol,timeframe,mql_param);        break;
      case IND_BANDS       : indicator=new CIndBands(symbol,timeframe,mql_param);      break;
      case IND_BEARS       : indicator=new CIndBears(symbol,timeframe,mql_param);      break;
      case IND_BULLS       : indicator=new CIndBulls(symbol,timeframe,mql_param);      break;
      case IND_BWMFI       : indicator=new CIndBWMFI(symbol,timeframe,mql_param);      break;
      case IND_CCI         : indicator=new CIndCCI(symbol,timeframe,mql_param);        break;
      case IND_CHAIKIN     : indicator=new CIndCHO(symbol,timeframe,mql_param);        break;
      case IND_DEMA        : indicator=new CIndDEMA(symbol,timeframe,mql_param);       break;
      case IND_DEMARKER    : indicator=new CIndDeMarker(symbol,timeframe,mql_param);   break;
      case IND_ENVELOPES   : indicator=new CIndEnvelopes(symbol,timeframe,mql_param);  break;
      case IND_FORCE       : indicator=new CIndForce(symbol,timeframe,mql_param);      break;
      case IND_FRACTALS    : indicator=new CIndFractals(symbol,timeframe,mql_param);   break;
      case IND_FRAMA       : indicator=new CIndFRAMA(symbol,timeframe,mql_param);      break;
      case IND_GATOR       : indicator=new CIndGator(symbol,timeframe,mql_param);      break;
      case IND_ICHIMOKU    : indicator=new CIndIchimoku(symbol,timeframe,mql_param);   break;
      case IND_MA          : indicator=new CIndMA(symbol,timeframe,mql_param);         break;
      case IND_MACD        : indicator=new CIndMACD(symbol,timeframe,mql_param);       break;
      case IND_MFI         : indicator=new CIndMFI(symbol,timeframe,mql_param);        break;
      case IND_MOMENTUM    : indicator=new CIndMomentum(symbol,timeframe,mql_param);   break;
      case IND_OBV         : indicator=new CIndOBV(symbol,timeframe,mql_param);        break;
      case IND_OSMA        : indicator=new CIndOsMA(symbol,timeframe,mql_param);       break;
      case IND_RSI         : indicator=new CIndRSI(symbol,timeframe,mql_param);        break;
      case IND_RVI         : indicator=new CIndRVI(symbol,timeframe,mql_param);        break;
      case IND_SAR         : indicator=new CIndSAR(symbol,timeframe,mql_param);        break;
      case IND_STDDEV      : indicator=new CIndStDev(symbol,timeframe,mql_param);      break;
      case IND_STOCHASTIC  : indicator=new CIndStoch(symbol,timeframe,mql_param);      break;
      case IND_TEMA        : indicator=new CIndTEMA(symbol,timeframe,mql_param);       break;
      case IND_TRIX        : indicator=new CIndTRIX(symbol,timeframe,mql_param);       break;
      case IND_VIDYA       : indicator=new CIndVIDYA(symbol,timeframe,mql_param);      break;
      case IND_VOLUMES     : indicator=new CIndVolumes(symbol,timeframe,mql_param);    break;
      case IND_WPR         : indicator=new CIndWPR(symbol,timeframe,mql_param);        break;
      case IND_CUSTOM      : indicator=new CIndCustom(symbol,timeframe,mql_param);     break;
      default: break;
     }
   return indicator;
  }
//+------------------------------------------------------------------+
//| Add a new indicator object to collection list                    |
//+------------------------------------------------------------------+
int CIndicatorsCollection::AddIndicatorToList(CIndicatorDE *indicator,const int id,const int buffers_total,const uint required=0)
  {
//--- If invalid indicator is passed to the object - return INVALID_HANDLE
   if(indicator==NULL)
      return INVALID_HANDLE;
//--- If such indicator is already in the list
   int index=this.Index(indicator);
   if(index!=WRONG_VALUE)
     {
      //--- Remove the earlier created object, get indicator object from the list and return indicator handle
      delete indicator;
      indicator=this.m_list.At(index);
     }
//--- If indicator object is not in the list yet
   else
     {
      //--- If failed to add indicator object to the list - display a corresponding message,
      //--- remove object and return INVALID_HANDLE
      if(!this.m_list.Add(indicator))
        {
         ::Print(CMessage::Text(MSG_LIB_SYS_FAILED_ADD_IND_TO_LIST));
         delete indicator;
         return INVALID_HANDLE;
        }
     }
//--- If indicator is successfully added to the list or is already there...
//--- If indicator with specified ID (not -1) is not in the list - set ID
   if(id>WRONG_VALUE && !this.CheckID(id))
      indicator.SetID(id);
//--- Set the total number of buffers and create data timeseries of all indicator buffers
   indicator.SetBuffersTotal(buffers_total);
   this.SeriesCreate(indicator,required);
//--- Return handle of a new indicator added to the list
   return indicator.Handle();
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Accelerator Oscillator             |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateAC(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id)
  {
//--- AC indicator possesses no parameters - resize the array of parameter structures
   ::ArrayResize(this.m_mql_param,0);
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_AC,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Accumulation/Distribution          |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateAD(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=applied_volume;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_AD,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object                                    |
//| Average Directional Movement Index indicator object              |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateADX(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int adx_period=14)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=adx_period;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_ADX,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,3);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object                                    |
//| Average Directional Movement Index Wilder indicator object       |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateADXWilder(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int adx_period=14)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=adx_period;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_ADXW,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,3);
  }
//+------------------------------------------------------------------+
//| Create new indicator object Alligator                            |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateAlligator(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                           const int jaw_period=13,
                                           const int jaw_shift=8,
                                           const int teeth_period=8,
                                           const int teeth_shift=5,
                                           const int lips_period=5,
                                           const int lips_shift=3,
                                           const ENUM_MA_METHOD ma_method=MODE_SMMA,
                                           const ENUM_APPLIED_PRICE applied_price=PRICE_MEDIAN)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,8);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=jaw_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=jaw_shift;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=teeth_period;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=teeth_shift;
   this.m_mql_param[4].type=TYPE_INT;
   this.m_mql_param[4].integer_value=lips_period;
   this.m_mql_param[5].type=TYPE_INT;
   this.m_mql_param[5].integer_value=lips_shift;
   this.m_mql_param[6].type=TYPE_INT;
   this.m_mql_param[6].integer_value=ma_method;
   this.m_mql_param[7].type=TYPE_INT;
   this.m_mql_param[7].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_ALLIGATOR,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,3);
  }
//+------------------------------------------------------------------+
//| Create a new Adaptive Moving Average indicator object            |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                     const int ama_period=9,
                                     const int fast_ema_period=2,
                                     const int slow_ema_period=30,
                                     const int ama_shift=0,
                                     const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,5);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ama_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=fast_ema_period;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=slow_ema_period;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=ama_shift;
   this.m_mql_param[4].type=TYPE_INT;
   this.m_mql_param[4].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_AMA,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Awesome Oscillator                 |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateAO(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id)
  {
//--- AO indicator possesses no parameters - resize the array of parameter structures
   ::ArrayResize(this.m_mql_param,0);
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_AO,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Average True Range                 |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateATR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int ma_period=14)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_ATR,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Bollinger Bands                    |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateBands(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=20,
                                       const int ma_shift=0,
                                       const double deviation=2.000,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,4);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=ma_shift;
   this.m_mql_param[2].type=TYPE_DOUBLE;
   this.m_mql_param[2].double_value=deviation;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_BANDS,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,3);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Bears Power                        |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateBearsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int ma_period=13)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_BEARS,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Bulls Power                        |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateBullsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int ma_period=13)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_BULLS,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Chaikin Oscillator                 |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateChaikin(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                         const int fast_ma_period=3,
                                         const int slow_ma_period=10,
                                         const ENUM_MA_METHOD ma_method=MODE_EMA,
                                         const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,4);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=fast_ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=slow_ma_period;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=ma_method;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=applied_volume;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_CHAIKIN,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Commodity Channel Index            |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateCCI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                     const int ma_period=14,
                                     const ENUM_APPLIED_PRICE applied_price=PRICE_TYPICAL)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,2);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_CCI,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new object - custom indicator                           |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateCustom(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                        const int buffers_total,
                                        ENUM_INDICATOR_GROUP group,
                                        MqlParam &mql_param[])
  {
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_CUSTOM,mql_param,symbol,timeframe);
   if(indicator==NULL)
      return INVALID_HANDLE;
//--- Set a group for indicator object
   indicator.SetGroup(group);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,buffers_total);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Double Exponential Moving Average  |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateDEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                      const int ma_period=14,
                                      const int ma_shift=0,
                                      const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,3);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=ma_shift;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_DEMA,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object DeMarker                           |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateDeMarker(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int ma_period=14)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_DEMARKER,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Envelopes                          |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateEnvelopes(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                           const int ma_period=14,
                                           const int ma_shift=0,
                                           const ENUM_MA_METHOD ma_method=MODE_SMA,
                                           const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE,
                                           const double deviation=0.1)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,5);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=ma_shift;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=ma_method;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=applied_price;
   this.m_mql_param[4].type=TYPE_DOUBLE;
   this.m_mql_param[4].double_value=deviation;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_ENVELOPES,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,2);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Force Index                        |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateForce(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_VOLUME applied_volume)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,3);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=ma_method;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=applied_volume;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_FORCE,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Fractals                           |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateFractals(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id)
  {
//--- Fractals indicator possesses no parameters - resize the array of parameter structures
   ::ArrayResize(this.m_mql_param,0);
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_FRACTALS,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,2);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Fractal Adaptive Moving Average    |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateFrAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int ma_period=14,
                                       const int ma_shift=0,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,3);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=ma_shift;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_FRAMA,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Gator                              |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateGator(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int jaw_period=13,
                                       const int jaw_shift=8,
                                       const int teeth_period=8,
                                       const int teeth_shift=5,
                                       const int lips_period=5,
                                       const int lips_shift=3,
                                       const ENUM_MA_METHOD ma_method=MODE_SMMA,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_MEDIAN)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,8);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=jaw_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=jaw_shift;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=teeth_period;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=teeth_shift;
   this.m_mql_param[4].type=TYPE_INT;
   this.m_mql_param[4].integer_value=lips_period;
   this.m_mql_param[5].type=TYPE_INT;
   this.m_mql_param[5].integer_value=lips_shift;
   this.m_mql_param[6].type=TYPE_INT;
   this.m_mql_param[6].integer_value=ma_method;
   this.m_mql_param[7].type=TYPE_INT;
   this.m_mql_param[7].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_GATOR,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,2);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Ichimoku                           |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateIchimoku(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                          const int tenkan_sen=9,
                                          const int kijun_sen=26,
                                          const int senkou_span_b=52)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,3);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=tenkan_sen;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=kijun_sen;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=senkou_span_b;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_ICHIMOKU,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,5);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Market Facilitation Index          |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateBWMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=applied_volume;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_BWMFI,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Momentum                           |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateMomentum(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                          const int mom_period=14,const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,2);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=mom_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_MOMENTUM,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Money Flow Index                   |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                     const int ma_period=14,const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,2);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=applied_volume;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_MFI,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Moving Average                     |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                    const int ma_period=10,
                                    const int ma_shift=0,
                                    const ENUM_MA_METHOD ma_method=MODE_SMA,
                                    const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,4);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=ma_shift;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=ma_method;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_MA,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Moving Average of Oscillator       |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateOsMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                      const int fast_ema_period=12,
                                      const int slow_ema_period=26,
                                      const int signal_period=9,
                                      const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,4);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=fast_ema_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=slow_ema_period;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=signal_period;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_OSMA,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object MACD                               |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateMACD(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                      const int fast_ema_period=12,
                                      const int slow_ema_period=26,
                                      const int signal_period=9,
                                      const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,4);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=fast_ema_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=slow_ema_period;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=signal_period;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_MACD,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,2);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object On Balance Volume                  |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateOBV(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=applied_volume;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_OBV,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Parabolic SAR                      |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateSAR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const double step=0.02,const double maximum=0.2)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,2);
   this.m_mql_param[0].type=TYPE_DOUBLE;
   this.m_mql_param[0].double_value=step;
   this.m_mql_param[1].type=TYPE_DOUBLE;
   this.m_mql_param[1].double_value=maximum;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_SAR,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Relative Strength Index            |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateRSI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                     const int ma_period=14,const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,2);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_RSI,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Relative Vigor Index               |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateRVI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int ma_period=10)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_RVI,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,2);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Standard Deviation                 |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateStdDev(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                        const int ma_period=20,
                                        const int ma_shift=0,
                                        const ENUM_MA_METHOD ma_method=MODE_SMA,
                                        const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,4);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=ma_shift;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=ma_method;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_STDDEV,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Stochastic Oscillator              |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateStochastic(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                            const int Kperiod=5,
                                            const int Dperiod=3,
                                            const int slowing=3,
                                            const ENUM_MA_METHOD ma_method=MODE_SMA,
                                            const ENUM_STO_PRICE price_field=STO_LOWHIGH)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,5);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=Kperiod;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=Dperiod;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=slowing;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=ma_method;
   this.m_mql_param[4].type=TYPE_INT;
   this.m_mql_param[4].integer_value=price_field;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_STOCHASTIC,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,2);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Triple Exponential Moving Average  |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateTEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                      const int ma_period=14,
                                      const int ma_shift=0,
                                      const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,3);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=ma_shift;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_TEMA,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Triple Exponential Average         |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateTriX(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                      const int ma_period=14,const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,2);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=ma_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_TRIX,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object William's Percent Range            |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateWPR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const int calc_period=14)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=calc_period;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_WPR,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Variable Index Dynamic Average     |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateVIDYA(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,
                                       const int cmo_period=9,
                                       const int ema_period=12,
                                       const int ma_shift=0,
                                       const ENUM_APPLIED_PRICE applied_price=PRICE_CLOSE)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,4);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=cmo_period;
   this.m_mql_param[1].type=TYPE_INT;
   this.m_mql_param[1].integer_value=ema_period;
   this.m_mql_param[2].type=TYPE_INT;
   this.m_mql_param[2].integer_value=ma_shift;
   this.m_mql_param[3].type=TYPE_INT;
   this.m_mql_param[3].integer_value=applied_price;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_VIDYA,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Create a new indicator object Volumes                            |
//| and place it to the collection list                              |
//+------------------------------------------------------------------+
int CIndicatorsCollection::CreateVolumes(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id,const ENUM_APPLIED_VOLUME applied_volume=VOLUME_TICK)
  {
//--- Add required indicator parameters to the array of parameter structures
   ::ArrayResize(this.m_mql_param,1);
   this.m_mql_param[0].type=TYPE_INT;
   this.m_mql_param[0].integer_value=applied_volume;
//--- Create indicator object
   CIndicatorDE *indicator=this.CreateIndicator(IND_VOLUMES,this.m_mql_param,symbol,timeframe);
//--- Return indicator handle received as a result of adding the object to collection list
   return this.AddIndicatorToList(indicator,id,1);
  }
//+------------------------------------------------------------------+
//| Return the list of Accelerator Oscillator indicator objects      |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListAC(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_AC);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of indicator objects  Accumulation/Distribution  |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListAD(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_AD);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of                                               |
//| Average Directional Movement Index indicator object              |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListADX(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_ADX);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of                                               |
//| Average Directional Movement Index Wilder indicator object       |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListADXWilder(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_ADXW);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Alligator indicator objects                   |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListAlligator(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_ALLIGATOR);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Adaptive Moving Average indicator objects     |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListAMA(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_AMA);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Awesome Oscillator indicator objects          |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListAO(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_AO);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Average True Range indicator objects          |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListATR(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_ATR);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Bollinger Bands indicator objects             |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListBands(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_BANDS);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Bears Power indicator objects                 |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListBearsPower(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_BEARS);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Bulls Power indicator objects                 |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListBullsPower(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_BULLS);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Chaikin Oscillator indicator objects          |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListChaikin(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_CHAIKIN);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Commodity Channel Index indicator objects     |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListCCI(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_CCI);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of                                               |
//| Double Exponential Moving Average indicator objects              |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListDEMA(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_DEMA);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of DeMarker indicator objects                    |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListDeMarker(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_DEMARKER);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Envelopes indicator objects                   |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListEnvelopes(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_ENVELOPES);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Force Index indicator objects                 |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListForce(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_FORCE);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Fractals indicator objects                    |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListFractals(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_FRACTALS);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of                                               |
//| Fractal Adaptive Moving Average indicator objects                |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListFrAMA(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_FRAMA);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Gator indicator objects                       |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListGator(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_GATOR);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Ichimoku indicator objects                    |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListIchimoku(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_ICHIMOKU);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Market Facilitation Index indicator objects   |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListBWMFI(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_BWMFI);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Momentum indicator objects                    |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListMomentum(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_MOMENTUM);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Money Flow Index indicator objects            |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListMFI(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_MFI);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Moving Average indicator objects              |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListMA(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_MA);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of                                               |
//| Moving Average of Oscillator indicator objects                   |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListOsMA(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_OSMA);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of MACD indicator objects                        |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListMACD(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_MACD);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of On Balance Volume indicator objects           |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListOBV(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_OBV);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Parabolic SAR indicator objects               |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListSAR(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_SAR);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Relative Strength Index indicator objects     |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListRSI(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_RSI);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Relative Vigor Index indicator objects        |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListRVI(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_RVI);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Standard Deviation indicator objects          |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListStdDev(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_STDDEV);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Stochastic Oscillator indicator objects       |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListStochastic(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_STOCHASTIC);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of                                               |
//| Triple Exponential Moving Average indicator objects              |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListTEMA(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_TEMA);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of                                               |
//| Triple Exponential Average indicator objects                     |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListTriX(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_TRIX);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of William's Percent Range indicator objects     |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListWPR(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_WPR);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of                                               |
//| Variable Index Dynamic Average indicator objects                 |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListVIDYA(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_VIDYA);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the list of Volumes indicator objects                     |
//| by symbol and timeframe                                          |
//+------------------------------------------------------------------+
CArrayObj *CIndicatorsCollection::GetListVolumes(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListIndByType(IND_VOLUMES);
   list=CSelect::ByIndicatorProperty(list,INDICATOR_PROP_SYMBOL,symbol,EQUAL);
   return CSelect::ByIndicatorProperty(list,INDICATOR_PROP_TIMEFRAME,timeframe,EQUAL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Accelerator Oscillator indicator object    |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndAC(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListAC(symbol,timeframe);
   return(list==NULL || list.Total()==0 ? NULL : list.At(0));
  }
//+------------------------------------------------------------------+
//| Return the pointer to                                            |
//| Accumulation/Distribution indicator object                       |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndAD(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=applied_volume;
   CIndicatorDE *tmp=this.CreateIndicator(IND_AD,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to                                            |
//| Average Directional Movement Index indicator object              |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndADX(const string symbol,const ENUM_TIMEFRAMES timeframe,const int adx_period)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=adx_period;
   CIndicatorDE *tmp=this.CreateIndicator(IND_ADX,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to                                            |
//| Average Directional Movement Index Wilder indicator object       |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndADXWilder(const string symbol,const ENUM_TIMEFRAMES timeframe,const int adx_period)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=adx_period;
   CIndicatorDE *tmp=this.CreateIndicator(IND_ADXW,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Alligator indicator object                 |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndAlligator(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                     const int jaw_period,
                                                     const int jaw_shift,
                                                     const int teeth_period,
                                                     const int teeth_shift,
                                                     const int lips_period,
                                                     const int lips_shift,
                                                     const ENUM_MA_METHOD ma_method,
                                                     const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[8];
   param[0].type=TYPE_INT;
   param[0].integer_value=jaw_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=jaw_shift;
   param[2].type=TYPE_INT;
   param[2].integer_value=teeth_period;
   param[3].type=TYPE_INT;
   param[3].integer_value=teeth_shift;
   param[4].type=TYPE_INT;
   param[4].integer_value=lips_period;
   param[5].type=TYPE_INT;
   param[5].integer_value=lips_shift;
   param[6].type=TYPE_INT;
   param[6].integer_value=ma_method;
   param[7].type=TYPE_INT;
   param[7].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_ALLIGATOR,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Adaptive Moving Average indicator object   |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                               const int ama_period,
                                               const int fast_ema_period,
                                               const int slow_ema_period,
                                               const int ama_shift,
                                                ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[5];
   param[0].type=TYPE_INT;
   param[0].integer_value=ama_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=fast_ema_period;
   param[2].type=TYPE_INT;
   param[2].integer_value=slow_ema_period;
   param[3].type=TYPE_INT;
   param[3].integer_value=ama_shift;
   param[4].type=TYPE_INT;
   param[4].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_AMA,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Awesome Oscillator indicator object        |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndAO(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListAO(symbol,timeframe);
   return(list==NULL || list.Total()==0 ? NULL : list.At(0));
  }
//+------------------------------------------------------------------+
//| Return the pointer to Average True Range indicator object        |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndATR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   CIndicatorDE *tmp=this.CreateIndicator(IND_ATR,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Bollinger Bands indicator object           |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndBands(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                 const int ma_period,
                                                 const int ma_shift,
                                                 const double deviation,
                                                 const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[4];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=ma_shift;
   param[2].type=TYPE_DOUBLE;
   param[2].double_value=deviation;
   param[3].type=TYPE_INT;
   param[3].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_BANDS,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Bears Power indicator object               |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndBearsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   CIndicatorDE *tmp=this.CreateIndicator(IND_BEARS,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Bulls Power indicator object               |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndBullsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   CIndicatorDE *tmp=this.CreateIndicator(IND_BULLS,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Chaikin Oscillator indicator object        |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndChaikin(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                   const int fast_ma_period,
                                                   const int slow_ma_period,
                                                   const ENUM_MA_METHOD ma_method,
                                                   const ENUM_APPLIED_VOLUME applied_volume)
  {
   MqlParam param[4];
   param[0].type=TYPE_INT;
   param[0].integer_value=fast_ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=slow_ma_period;
   param[2].type=TYPE_INT;
   param[2].integer_value=ma_method;
   param[3].type=TYPE_INT;
   param[3].integer_value=applied_volume;
   CIndicatorDE *tmp=this.CreateIndicator(IND_CHAIKIN,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Commodity Channel Index indicator object   |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndCCI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                               const int ma_period,
                                               const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[2];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_CCI,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return pointer to object- custom indicator                       |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndCustom(const string symbol,const ENUM_TIMEFRAMES timeframe,ENUM_INDICATOR_GROUP group,MqlParam &param[])
  {
   CIndicatorDE *tmp=new CIndCustom(symbol,timeframe,param);
   if(tmp==NULL)
      return NULL;
   tmp.SetGroup(group);
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to                                            |
//| Double Exponential Moving Average indicator objects              |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndDEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                const int ma_period,
                                                const int ma_shift,
                                                const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[3];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=ma_shift;
   param[2].type=TYPE_INT;
   param[2].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_DEMA,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to DeMarker indicator object                  |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndDeMarker(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   CIndicatorDE *tmp=this.CreateIndicator(IND_DEMARKER,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Envelopes indicator object                 |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndEnvelopes(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                     const int ma_period,
                                                     const int ma_shift,
                                                     const ENUM_MA_METHOD ma_method,
                                                     const ENUM_APPLIED_PRICE applied_price,
                                                     const double deviation)
  {
   MqlParam param[5];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=ma_shift;
   param[2].type=TYPE_INT;
   param[2].integer_value=ma_method;
   param[3].type=TYPE_INT;
   param[3].integer_value=applied_price;
   param[4].type=TYPE_DOUBLE;
   param[4].double_value=deviation;
   CIndicatorDE *tmp=this.CreateIndicator(IND_ENVELOPES,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Force Index indicator object               |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndForce(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                 const int ma_period,
                                                 const ENUM_MA_METHOD ma_method,
                                                 const ENUM_APPLIED_VOLUME applied_volume)
  {
   MqlParam param[3];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=ma_method;
   param[2].type=TYPE_INT;
   param[2].integer_value=applied_volume;
   CIndicatorDE *tmp=this.CreateIndicator(IND_FORCE,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Fractals indicator object                  |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndFractals(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CArrayObj *list=GetListFractals(symbol,timeframe);
   return(list==NULL || list.Total()==0 ? NULL : list.At(0));
  }
//+------------------------------------------------------------------+
//| Return the pointer to                                            |
//| Fractal Adaptive Moving Average indicator objects                |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndFrAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                 const int ma_period,
                                                 const int ma_shift,
                                                 const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[3];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=ma_shift;
   param[2].type=TYPE_INT;
   param[2].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_FRAMA,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Gator indicator object                     |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndGator(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                 const int jaw_period,
                                                 const int jaw_shift,
                                                 const int teeth_period,
                                                 const int teeth_shift,
                                                 const int lips_period,
                                                 const int lips_shift,
                                                 const ENUM_MA_METHOD ma_method,
                                                 const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[8];
   param[0].type=TYPE_INT;
   param[0].integer_value=jaw_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=jaw_shift;
   param[2].type=TYPE_INT;
   param[2].integer_value=teeth_period;
   param[3].type=TYPE_INT;
   param[3].integer_value=teeth_shift;
   param[4].type=TYPE_INT;
   param[4].integer_value=lips_period;
   param[5].type=TYPE_INT;
   param[5].integer_value=lips_shift;
   param[6].type=TYPE_INT;
   param[6].integer_value=ma_method;
   param[7].type=TYPE_INT;
   param[7].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_GATOR,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Ichimoku indicator object                  |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndIchimoku(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                    const int tenkan_sen,
                                                    const int kijun_sen,
                                                    const int senkou_span_b)
  {
   MqlParam param[3];
   param[0].type=TYPE_INT;
   param[0].integer_value=tenkan_sen;
   param[1].type=TYPE_INT;
   param[1].integer_value=kijun_sen;
   param[2].type=TYPE_INT;
   param[2].integer_value=senkou_span_b;
   CIndicatorDE *tmp=this.CreateIndicator(IND_ICHIMOKU,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to                                            |
//| Market Facilitation Index indicator object                       |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndBWMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=applied_volume;
   CIndicatorDE *tmp=this.CreateIndicator(IND_BWMFI,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Momentum indicator object                  |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndMomentum(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                    const int mom_period,
                                                    const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[2];
   param[0].type=TYPE_INT;
   param[0].integer_value=mom_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_MOMENTUM,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Money Flow Index indicator object          |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                               const int ma_period,
                                               const ENUM_APPLIED_VOLUME applied_volume)
  {
   MqlParam param[2];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=applied_volume;
   CIndicatorDE *tmp=this.CreateIndicator(IND_MFI,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Moving Average indicator object            |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                              const int ma_period,
                                              const int ma_shift,
                                              const ENUM_MA_METHOD ma_method,
                                              const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[4];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=ma_shift;
   param[2].type=TYPE_INT;
   param[2].integer_value=ma_method;
   param[3].type=TYPE_INT;
   param[3].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_MA,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to                                            |
//| Moving Average of Oscillator indicator objects                   |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndOsMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                const int fast_ema_period,
                                                const int slow_ema_period,
                                                const int signal_period,
                                                const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[4];
   param[0].type=TYPE_INT;
   param[0].integer_value=fast_ema_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=slow_ema_period;
   param[2].type=TYPE_INT;
   param[2].integer_value=signal_period;
   param[3].type=TYPE_INT;
   param[3].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_OSMA,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to MACD indicator object                      |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndMACD(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                const int fast_ema_period,
                                                const int slow_ema_period,
                                                const int signal_period,
                                                const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[4];
   param[0].type=TYPE_INT;
   param[0].integer_value=fast_ema_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=slow_ema_period;
   param[2].type=TYPE_INT;
   param[2].integer_value=signal_period;
   param[3].type=TYPE_INT;
   param[3].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_MACD,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to On Balance Volume indicator object         |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndOBV(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=applied_volume;
   CIndicatorDE *tmp=this.CreateIndicator(IND_OBV,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Parabolic SAR indicator object             |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndSAR(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                               const double step,
                                               const double maximum)
  {
   MqlParam param[2];
   param[0].type=TYPE_DOUBLE;
   param[0].double_value=step;
   param[1].type=TYPE_DOUBLE;
   param[1].double_value=maximum;
   CIndicatorDE *tmp=this.CreateIndicator(IND_SAR,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Relative Strength Index indicator object   |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndRSI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                               const int ma_period,
                                               const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[2];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_RSI,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Relative Vigor Index indicator object      |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndRVI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   CIndicatorDE *tmp=this.CreateIndicator(IND_RVI,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Standard Deviation indicator object        |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndStdDev(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                  const int ma_period,
                                                  const int ma_shift,
                                                  const ENUM_MA_METHOD ma_method,
                                                  const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[4];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=ma_shift;
   param[2].type=TYPE_INT;
   param[2].integer_value=ma_method;
   param[3].type=TYPE_INT;
   param[3].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_STDDEV,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Stochastic Oscillator indicator object     |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndStochastic(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                      const int Kperiod,
                                                      const int Dperiod,
                                                      const int slowing,
                                                      const ENUM_MA_METHOD ma_method,
                                                      const ENUM_STO_PRICE price_field)
  {
   MqlParam param[5];
   param[0].type=TYPE_INT;
   param[0].integer_value=Kperiod;
   param[1].type=TYPE_INT;
   param[1].integer_value=Dperiod;
   param[2].type=TYPE_INT;
   param[2].integer_value=slowing;
   param[3].type=TYPE_INT;
   param[3].integer_value=ma_method;
   param[4].type=TYPE_INT;
   param[4].integer_value=price_field;
   CIndicatorDE *tmp=this.CreateIndicator(IND_STOCHASTIC,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to                                            |
//| Triple Exponential Moving Average indicator objects              |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndTEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                const int ma_period,
                                                const int ma_shift,
                                                const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[3];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=ma_shift;
   param[2].type=TYPE_INT;
   param[2].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_TEMA,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to                                            |
//| Triple Exponential Average indicator objects                     |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndTriX(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                const int ma_period,
                                                const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[2];
   param[0].type=TYPE_INT;
   param[0].integer_value=ma_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_TRIX,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to William's Percent Range indicator object   |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndWPR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int calc_period)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=calc_period;
   CIndicatorDE *tmp=this.CreateIndicator(IND_WPR,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to                                            |
//| Variable Index Dynamic Average indicator objects                 |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndVIDYA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                                 const int cmo_period,
                                                 const int ema_period,
                                                 const int ma_shift,
                                                 const ENUM_APPLIED_PRICE applied_price)
  {
   MqlParam param[4];
   param[0].type=TYPE_INT;
   param[0].integer_value=cmo_period;
   param[1].type=TYPE_INT;
   param[1].integer_value=ema_period;
   param[2].type=TYPE_INT;
   param[2].integer_value=ma_shift;
   param[3].type=TYPE_INT;
   param[3].integer_value=applied_price;
   CIndicatorDE *tmp=this.CreateIndicator(IND_VIDYA,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to Volumes indicator object                   |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndVolumes(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume)
  {
   MqlParam param[1];
   param[0].type=TYPE_INT;
   param[0].integer_value=applied_volume;
   CIndicatorDE *tmp=this.CreateIndicator(IND_VOLUMES,param,symbol,timeframe);
   if(tmp==NULL)
      return NULL;
   int index=this.Index(tmp);
   delete tmp;
   return(index>WRONG_VALUE ? this.m_list.At(index) : NULL);
  }
//+------------------------------------------------------------------+
//| Check presence of indicator object with specified id in the list |
//+------------------------------------------------------------------+
bool CIndicatorsCollection::CheckID(const int id)
  {
   CArrayObj *list=CSelect::ByIndicatorProperty(this.GetList(),INDICATOR_PROP_ID,id,EQUAL);
   return(list!=NULL && list.Total()!=0);
  }
//+------------------------------------------------------------------+
//| Set ID for the specified indicator                               |
//+------------------------------------------------------------------+
void CIndicatorsCollection::SetID(CIndicatorDE *indicator,const int id)
  {
   if(indicator==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_INVALID_IND_POINTER));
      return;
     }
   if(id>WRONG_VALUE)
     {
      if(CheckID(id))
        {
         ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_IND_ID_EXIST)," #",(string)id);
         return;
        }
     }
   indicator.SetID(id);
  }
//+------------------------------------------------------------------+
//| Return indicator object by its ID                                |
//+------------------------------------------------------------------+
CIndicatorDE *CIndicatorsCollection::GetIndByID(const uint id)
  {
   CArrayObj *list=CSelect::ByIndicatorProperty(this.GetList(),INDICATOR_PROP_ID,id,EQUAL);
   return(list==NULL || list.Total()==0 ? NULL : list.At(list.Total()-1));
  }
//+------------------------------------------------------------------+
//| Return data object of indicator buffer timeseries by time        |
//+------------------------------------------------------------------+
CDataInd *CIndicatorsCollection::GetDataIndObj(const uint ind_id,const int buffer_num,const datetime time)
  {
   CIndicatorDE *indicator=this.GetIndByID(ind_id);
   if(indicator==NULL) return NULL;
   CSeriesDataInd *buffers_data=indicator.GetSeriesData();
   if(buffers_data==NULL) return NULL;
   return buffers_data.GetIndDataByTime(buffer_num,time);
  }
//+------------------------------------------------------------------+
//| Create data timeseries of the specified indicator                |
//+------------------------------------------------------------------+
bool CIndicatorsCollection::SeriesCreate(CIndicatorDE *indicator,const uint required=0)
  {
   if(indicator==NULL)
      return false;
   CSeriesDataInd *buffers_data=indicator.GetSeriesData();
   if(buffers_data!=NULL)
     {
      buffers_data.SetSymbolPeriod(indicator.Symbol(),indicator.Timeframe());
      buffers_data.SetIndHandle(indicator.Handle());
      buffers_data.SetIndID(indicator.ID());
      buffers_data.SetIndBuffersTotal(indicator.BuffersTotal());
      buffers_data.SetRequiredUsedData(required);
     }
   return(buffers_data!=NULL ? buffers_data.Create(required)>0 : false);
  }
//+------------------------------------------------------------------+
//| Create all timeseries used of all collection indicators          |
//+------------------------------------------------------------------+
bool CIndicatorsCollection::SeriesCreateAll(const uint required=0)
  {
   bool res=true;
   for(int i=0;i<m_list.Total();i++)
     {
      CIndicatorDE *indicator=m_list.At(i);
      if(!this.SeriesCreate(indicator,required))
         res&=false;
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Update buffer data of all indicators                             |
//+------------------------------------------------------------------+
void CIndicatorsCollection::SeriesRefreshAll(void)
  {
   for(int i=0;i<m_list.Total();i++)
     {
      CIndicatorDE *indicator=m_list.At(i);
      if(indicator==NULL) continue;
      CSeriesDataInd *buffers_data=indicator.GetSeriesData();
      if(buffers_data==NULL) continue;
      buffers_data.Refresh();
     }
  }
//+------------------------------------------------------------------+
//| Update buffer data of the specified indicator                    |
//+------------------------------------------------------------------+
void CIndicatorsCollection::SeriesRefresh(const int ind_id)
  {
   CIndicatorDE *indicator=this.GetIndByID(ind_id);
   if(indicator==NULL) return;
   CSeriesDataInd *buffers_data=indicator.GetSeriesData();
   if(buffers_data==NULL) return;
   buffers_data.Refresh();
  }
//+------------------------------------------------------------------+
//| Return buffer value by bar time                                  |
//|  specified by indicator ID                                       |
//+------------------------------------------------------------------+
double CIndicatorsCollection::GetBufferValue(const uint ind_id,const int buffer_num,const datetime time)
  {
   CIndicatorDE *indicator=GetIndByID(ind_id);
   if(indicator==NULL) return EMPTY_VALUE;
   CSeriesDataInd *series=indicator.GetSeriesData();
   return(series!=NULL && series.DataTotal()>0 ? series.BufferValue(buffer_num,time) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return by bar number the buffer value                            |
//|  specified by indicator ID                                       |
//+------------------------------------------------------------------+
double CIndicatorsCollection::GetBufferValue(const uint ind_id,const int buffer_num,const uint shift)
  {
   CIndicatorDE *indicator=GetIndByID(ind_id);
   if(indicator==NULL) return EMPTY_VALUE;
   CSeriesDataInd *series=indicator.GetSeriesData();
   return(series!=NULL && series.DataTotal()>0 ? series.BufferValue(buffer_num,shift) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
