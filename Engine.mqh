//+------------------------------------------------------------------+
//|                                                       Engine.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "Services\TimerCounter.mqh"
#include "Collections\HistoryCollection.mqh"
#include "Collections\MarketCollection.mqh"
#include "Collections\EventsCollection.mqh"
#include "Collections\AccountsCollection.mqh"
#include "Collections\SymbolsCollection.mqh"
#include "Collections\ResourceCollection.mqh"
#include "Collections\TimeSeriesCollection.mqh"
#include "Collections\BuffersCollection.mqh"
#include "Collections\IndicatorsCollection.mqh"
#include "Collections\TickSeriesCollection.mqh"
#include "Collections\BookSeriesCollection.mqh"
#include "Collections\MQLSignalsCollection.mqh"
#include "Collections\ChartObjCollection.mqh"
#include "Collections\GraphElementsCollection.mqh"
#include "TradingControl.mqh"
//+------------------------------------------------------------------+
//| Library basis class                                              |
//+------------------------------------------------------------------+
class CEngine
  {
private:
   CHistoryCollection   m_history;                       // Collection of historical orders and deals
   CMarketCollection    m_market;                        // Collection of market orders and deals
   CEventsCollection    m_events;                        // Collection of events
   CAccountsCollection  m_accounts;                      // Account collection
   CSymbolsCollection   m_symbols;                       // Symbol collection
   CTimeSeriesCollection m_time_series;                  // Timeseries collection
   CBuffersCollection   m_buffers;                       // Collection of indicator buffers
   CIndicatorsCollection m_indicators;                   // Indicator collection
   CTickSeriesCollection m_tick_series;                  // Collection of tick series
   CMBookSeriesCollection m_book_series;                 // Collection of DOM series
   CMQLSignalsCollection m_signals_mql5;                 // Collection of MQL5.com Signals service signals
   CChartObjCollection  m_charts;                        // Chart collection
   CGraphElementsCollection m_graph_objects;             // Collection of graphical objects
   CResourceCollection  m_resource;                      // Resource list
   CTradingControl      m_trading;                       // Trading management object
   CPause               m_pause;                         // Pause object
   CArrayObj            m_list_counters;                 // List of timer counters
   int                  m_global_error;                  // Global error code
   bool                 m_first_start;                   // First launch flag
   bool                 m_is_hedge;                      // Hedge account flag
   bool                 m_is_tester;                     // Flag of working in the tester
   bool                 m_is_market_trade_event;         // Account trading event flag
   bool                 m_is_history_trade_event;        // Account history trading event flag
   bool                 m_is_account_event;              // Account change event flag
   bool                 m_is_symbol_event;               // Symbol change event flag
   bool                 m_is_graph_obj_event;            // Event flag in the list of graphical objects
   ENUM_TRADE_EVENT     m_last_trade_event;              // Last account trading event
   int                  m_last_account_event;            // Last event in the account properties
   int                  m_last_symbol_event;             // Last event in the symbol properties
   ENUM_PROGRAM_TYPE    m_program;                       // Program type
   string               m_name;                          // Program name
//--- Return the counter index by id
   int                  CounterIndex(const int id) const;
//--- Return the first launch flag
   bool                 IsFirstStart(void);
//--- Handling events of (1) orders, deals and positions, (2) accounts and (3) graphical objects
   void                 TradeEventsControl(void);
   void                 AccountEventsControl(void);
   void                 GraphObjEventsControl(void);
//--- (1) Working with a symbol collection and (2) symbol list events in the market watch window
   void                 SymbolEventsControl(void);
   void                 MarketWatchEventsControl(void);
//--- Return the last (1) market pending order, (2) market order, (3) last position, (4) position by ticket
   COrder              *GetLastMarketPending(void);
   COrder              *GetLastMarketOrder(void);
   COrder              *GetLastPosition(void);
   COrder              *GetPosition(const ulong ticket);
//--- Return the last (1) removed pending order, (2) historical market order, (3) historical order (market or pending one) by its ticket
   COrder              *GetLastHistoryPending(void);
   COrder              *GetLastHistoryOrder(void);
   COrder              *GetHistoryOrder(const ulong ticket);
//--- Return the (1) first and the (2) last historical market orders from the list of all position orders, (3) the last deal
   COrder              *GetFirstOrderPosition(const ulong position_id);
   COrder              *GetLastOrderPosition(const ulong position_id);
   COrder              *GetLastDeal(void);
//--- Retrieve a necessary 'ushort' number from the packed 'long' value
   ushort               LongToUshortFromByte(const long source_value,const uchar index) const;
   
public:
//--- Return the list of market (1) positions, (2) pending orders and (3) market orders
   CArrayObj           *GetListMarketPosition(void);
   CArrayObj           *GetListMarketPendings(void);
   CArrayObj           *GetListMarketOrders(void);
//--- Return the list of historical (1) orders, (2) removed pending orders, (3) deals,
//--- (4) all market orders of a position by its ID, (5) description of the last trading event
   CArrayObj           *GetListHistoryOrders(void);
   CArrayObj           *GetListHistoryPendings(void);
   CArrayObj           *GetListDeals(void);
   CArrayObj           *GetListAllOrdersByPosID(const ulong position_id);
   string               GetLastTradeEventDescription(void);

//--- Return the list of (1) accounts, (2) account events, (3) account change event by its index in the list
//--- (4) the current account, (5) event description
   CArrayObj           *GetListAllAccounts(void)                        { return this.m_accounts.GetList();                   }
   CArrayObj           *GetListAccountEvents(void)                      { return this.m_accounts.GetListEvents();             }
   int                  GetAccountEventByIndex(const int index=-1)      { return this.m_accounts.GetEventID(index);           }
   CAccount            *GetAccountCurrent(void);
   
//--- Return the list of (1) used symbols, (2) symbol events, (3) the last symbol change event
//--- (4) the current symbol, (5) symbol event description, (6) Market Watch event description
   CArrayObj           *GetListAllUsedSymbols(void)                     { return this.m_symbols.GetList();                    }
   CArrayObj           *GetListSymbolsEvents(void)                      { return this.m_symbols.GetListEvents();              }
   int                  GetLastSymbolsEvent()                           { return this.m_symbols.GetLastEvent();               }
   CSymbol             *GetSymbolCurrent(void)                          { return this.m_symbols.GetSymbolObjByName(::Symbol());}
   string               GetMWEventDescription(ENUM_MW_EVENT event)      { return this.m_symbols.EventMWDescription(event);    }
   string               ModeSymbolsListDescription(void)                { return this.m_symbols.ModeSymbolsListDescription(); }
   
//--- Return (1) the list of order, deal and position events, (2) base trading event object by index and the (3) number of new trading events
   CArrayObj           *GetListAllOrdersEvents(void)                    { return this.m_events.GetList();                     }
   CEventBaseObj       *GetTradeEventByIndex(const int index)           { return this.m_events.GetTradeEventByIndex(index);   }
   int                  GetTradeEventsTotal(void)                 const { return this.m_events.GetTradeEventsTotal();         }
//--- Reset the last trading event
   void                 ResetLastTradeEvent(void)                       { this.m_events.ResetLastTradeEvent();                }
//--- Return the (1) last trading event, (2) the last event in the account properties and (3) the last event in symbol properties
   ENUM_TRADE_EVENT     LastTradeEvent(void)                      const { return this.m_last_trade_event;                     }
   int                  LastAccountEvent(void)                    const { return this.m_last_account_event;                   }
   int                  LastSymbolsEvent(void)                    const { return this.m_last_symbol_event;                    }
//--- Return the (1) hedge account, (2) working in the tester, (3) account event, (4) symbol event and (5) trading event flag
   bool                 IsHedge(void)                             const { return this.m_is_hedge;                             }
   bool                 IsTester(void)                            const { return this.m_is_tester;                            }
   bool                 IsAccountsEvent(void)                     const { return this.m_accounts.IsEvent();                   }
   bool                 IsSymbolsEvent(void)                      const { return this.m_symbols.IsEvent();                    }
   bool                 IsTradeEvent(void)                        const { return this.m_events.IsEvent();                     }
   bool                 IsSeriesEvent(void)                       const { return this.m_time_series.IsEvent();                }
//--- Return the (1) symbol object by name, as well as the code of the last event of (2) an account and (3) a symbol
   CSymbol             *GetSymbolObjByName(const string name)           { return this.m_symbols.GetSymbolObjByName(name);     }
   int                  GetAccountEventsCode(void)                const { return this.m_accounts.GetEventCode();              }
   int                  GetSymbolsEventsCode(void)                const { return this.m_symbols.GetLastEventsCode();          }
//--- Return the number of (1) symbols, (2) events in the symbol collection
   int                  GetSymbolsCollectionTotal(void)           const { return this.m_symbols.GetSymbolsCollectionTotal();  }
   int                  GetSymbolsCollectionEventsTotal(void)     const { return this.m_symbols.GetEventsTotal();             }
//--- Return CEngine global error code
   int                  GetError(void)                            const { return this.m_global_error;                         }
//--- Create the timer counter
   void                 CreateCounter(const int id,const ulong frequency,const ulong pause);
//--- (1) Timer, event handler (2) NewTick, (3) Calculate, (4) BookEvent, (4) Deinit
   void                 OnTimer(SDataCalculate &data_calculate);
   void                 OnTick(SDataCalculate &data_calculate,const uint required=0);
   int                  OnCalculate(SDataCalculate &data_calculate,const uint required=0);
   bool                 OnBookEvent(const string &symbol);
   void                 OnDeinit(void);
   
//--- Set the list of used symbols in the symbol collection and create the collection of symbol timeseries
   bool                 SetUsedSymbols(const string &array_symbols[],const uint required_ticks=0,const uint required_books=0);
private:
//--- Write all used symbols and timeframes to the ArrayUsedSymbols and ArrayUsedTimeframes arrays
   void                 WriteSymbolsPeriodsToArrays(void);
//--- Check the presence of a (1) symbol in the ArrayUsedSymbols array, (2) the presence of a timeframe in the ArrayUsedTimeframes array
   bool                 IsExistSymbol(const string symbol);
   bool                 IsExistTimeframe(const ENUM_TIMEFRAMES timeframe);
public:
//--- Create a resource file
   bool                 CreateFile(const ENUM_FILE_TYPE file_type,const string file_name,const string descript,const uchar &file_data_array[])
                          {
                           return this.m_resource.CreateFile(file_type,file_name,descript,file_data_array);
                          }
//--- Return (1) the list of references to resources, (2) resource object index by its description
   CArrayObj           *GetListResource(void)                                 { return this.m_resource.GetList();                               }
   int                  GetIndexResObjByDescription(const string file_name)   { return this.m_resource.GetIndexResObjByDescription(file_name);  }

//--- Return the list of pending requests
   CArrayObj           *GetListPendingRequests(void)                          { return this.m_trading.GetListRequests();                        }

//--- Return (1) the timeseries collection and (2) the list of timeseries from the timeseries collection and (3) the list of timeseries events
   CTimeSeriesCollection *GetTimeSeriesCollection(void)                       { return &this.m_time_series;                                     }
   CArrayObj           *GetListTimeSeries(void)                               { return this.m_time_series.GetList();                            }
   CArrayObj           *GetListSeriesEvents(void)                             { return this.m_time_series.GetListEvents();                      }
//--- Set the flag of using (1) the specified timeseries of the specified symbol, (2) the specified timeseries of all symbols
//--- (3) all timeseries of the specified symbol and (4) all timeseries of all symbols
   void                 SeriesSetAvailable(const string symbol,const ENUM_TIMEFRAMES timeframe,const bool flag=true)
                          { this.m_time_series.SetAvailable(symbol,timeframe,flag);}
   void                 SeriesSetAvailable(const ENUM_TIMEFRAMES timeframe,const bool flag=true)
                          { this.m_time_series.SetAvailable(timeframe,flag);  }
   void                 SeriesSetAvailable(const string symbol,const bool flag=true)
                          { this.m_time_series.SetAvailable(symbol,flag);     }
   void                 SeriesSetAvailable(const bool flag=true)              
                          { this.m_time_series.SetAvailable(flag);            }
//--- Set the history depth of (1) the specified timeseries of the specified symbol, (2) the specified timeseries of all symbols
//--- (3) all timeseries of the specified symbol and (4) all timeseries of all symbols
   bool                 SeriesSetRequiredUsedData(const string symbol,const ENUM_TIMEFRAMES timeframe,const uint required,const int rates_total)
                          { return this.m_time_series.SetRequiredUsedData(symbol,timeframe,required,rates_total); }
   bool                 SeriesSetRequiredUsedData(const ENUM_TIMEFRAMES timeframe,const uint required,const int rates_total)
                          { return this.m_time_series.SetRequiredUsedData(timeframe,required,rates_total);        }
   bool                 SeriesSetRequiredUsedData(const string symbol,const uint required,const int rates_total)
                          { return this.m_time_series.SetRequiredUsedData(symbol,required,rates_total);           }
   bool                 SeriesSetRequiredUsedData(const uint required,const int rates_total)
                          { return this.m_time_series.SetRequiredUsedData(required,rates_total);                  }
//--- Return the flag of data synchronization with the server data of the (1) specified timeseries of the specified symbol,
//--- (2) the specified timeseries of all symbols, (3) all timeseries of the specified symbol and (4) all timeseries of all symbols
   bool                 SeriesSyncData(const string symbol,const ENUM_TIMEFRAMES timeframe,const int rates_total,const uint required=0)
                          { return this.m_time_series.SyncData(symbol,timeframe,required,rates_total);            }
   bool                 SeriesSyncData(const ENUM_TIMEFRAMES timeframe,const int rates_total,const uint required=0)
                          { return this.m_time_series.SyncData(timeframe,required,rates_total);                   }
   bool                 SeriesSyncData(const string symbol,const int rates_total,const uint required=0)
                          { return this.m_time_series.SyncData(symbol,required,rates_total);                      }
   bool                 SeriesSyncData(const int rates_total,const uint required=0)
                          { return this.m_time_series.SyncData(required,rates_total);                             }

//--- Create (1) the specified timeseries of the specified symbol and (2) all used timeseries of all used symbols
   bool                 SeriesCreate(const string symbol,const ENUM_TIMEFRAMES timeframe,const int rates_total=0,const uint required=0)
                          { return this.m_time_series.CreateSeries(symbol,timeframe,rates_total,required);        }
   bool                 SeriesCreateAll(const string &array_periods[],const int rates_total=0,const uint required=0);
//--- Re-create (1) the specified timeseries of the specified symbol, (2) all collection timeseries
   bool                 SeriesReCreate(const string symbol,const ENUM_TIMEFRAMES timeframe,const int rates_total=0,const uint required=0)
                          { return this.m_time_series.ReCreateSeries(symbol,timeframe,rates_total,required);      }
   bool                 SeriesReCreateAll(const int rates_total=0,const uint required=0)
                          { return this.m_time_series.ReCreateSeriesAll(rates_total,required);                    }
//--- Synchronize timeseries data with the server
   bool                 SeriesSync(SDataCalculate &data_calculate,const uint required=0);

//--- Return the bar object of the specified timeseries of the specified symbol of the specified position (1) by index, (2) by time
   CBar                *SeriesGetBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index,const bool from_series=true)
                          { return this.m_time_series.GetBar(symbol,timeframe,index,from_series);                 }
   CBar                *SeriesGetBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
                          { return this.m_time_series.GetBar(symbol,timeframe,time);                              }
//--- Return the bar object of the first timeseries corresponding to the bar open time on the second timeseries (1) by index, (2) by time
   CBar                *SeriesGetBarSeriesFirstFromSeriesSecond(const string symbol_first,const ENUM_TIMEFRAMES timeframe_first,const int index,
                                                                const string symbol_second=NULL,const ENUM_TIMEFRAMES timeframe_second=PERIOD_CURRENT)
                          { return this.m_time_series.GetBarSeriesFirstFromSeriesSecond(symbol_first,timeframe_first,index,symbol_second,timeframe_second); }
   
   CBar                *SeriesGetBarSeriesFirstFromSeriesSecond(const string symbol_first,const ENUM_TIMEFRAMES timeframe_first,const datetime time,
                                                                const string symbol_second=NULL,const ENUM_TIMEFRAMES timeframe_second=PERIOD_CURRENT)
                          { return this.m_time_series.GetBarSeriesFirstFromSeriesSecond(symbol_first,timeframe_first,time,symbol_second,timeframe_second); }

//--- Return the flag of opening a new bar of the specified timeseries of the specified symbol
   bool                 SeriesIsNewBar(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time=0)
                          { return this.m_time_series.IsNewBar(symbol,timeframe,time);                            }

//--- Update (1) the specified timeseries of the specified symbol, (2) all timeseries of a specified symbol,
//--- (3) all timeseries of all symbols, (4) all timeseries except the current one
   void                 SeriesRefresh(const string symbol,const ENUM_TIMEFRAMES timeframe,SDataCalculate &data_calculate)
                          { this.m_time_series.Refresh(symbol,timeframe,data_calculate);                          }
   void                 SeriesRefresh(const string symbol,SDataCalculate &data_calculate)
                          { this.m_time_series.Refresh(symbol,data_calculate);                                    }
   void                 SeriesRefresh(SDataCalculate &data_calculate)
                          { this.m_time_series.Refresh(data_calculate);                                           }
protected:
   void                 SeriesRefreshAllExceptCurrent(SDataCalculate &data_calculate)
                          { this.m_time_series.RefreshAllExceptCurrent(data_calculate);                           }
public:   
//--- Return (1) the timeseries object of the specified symbol and (2) the timeseries object of the specified symbol/period
   CTimeSeriesDE       *SeriesGetTimeseries(const string symbol)
                          { return this.m_time_series.GetTimeseries(symbol);                                      }
   CSeriesDE           *SeriesGetSeries(const string symbol,const ENUM_TIMEFRAMES timeframe)
                          { return this.m_time_series.GetSeries(symbol,timeframe);                                }
//--- Return (1) an empty, (2) partially filled timeseries
   CSeriesDE           *SeriesGetSeriesEmpty(void)       { return this.m_time_series.GetSeriesEmpty();            }
   CSeriesDE           *SeriesGetSeriesIncompleted(void) { return this.m_time_series.GetSeriesIncompleted();      }
//--- Return the umber of bars of the timeseries of the specified symbol/period
   int                  SeriesGetBarsTotal(const string symbol,const ENUM_TIMEFRAMES timeframe);

//--- Return (1) Open, (2) High, (3) Low, (4) Close, (5) Time, (6) TickVolume,
//--- (7) RealVolume, (8) Spread of the bar, specified by index, of the specified symbol of the specified timeframe
   double               SeriesOpen(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index);
   double               SeriesHigh(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index);
   double               SeriesLow(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index);
   double               SeriesClose(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index);
   datetime             SeriesTime(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index);
   long                 SeriesTickVolume(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index);
   long                 SeriesRealVolume(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index);
   int                  SeriesSpread(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index);
   
//--- Return (1) Open, (2) High, (3) Low, (4) Close, (5) Time, (6) TickVolume,
//--- (7) RealVolume, (8) Spread of the bar, specified by time, of the specified symbol of the specified timeframe
   double               SeriesOpen(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);
   double               SeriesHigh(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);
   double               SeriesLow(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);
   double               SeriesClose(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);
   datetime             SeriesTime(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);
   long                 SeriesTickVolume(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);
   long                 SeriesRealVolume(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);
   int                  SeriesSpread(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);
   
//--- Return the bar type of the specified timeframe's symbol by (1) index and (2) time
   ENUM_BAR_BODY_TYPE   SeriesBarType(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index);
   ENUM_BAR_BODY_TYPE   SeriesBarType(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time);

//--- Copy the specified double property of the specified timeseries of the specified symbol to the array
//--- Regardless of the array indexing direction, copying is performed the same way as copying to a timeseries array
   bool                 SeriesCopyToBufferAsSeries(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_BAR_PROP_DOUBLE property,
                                                   double &array[],const double empty=EMPTY_VALUE)
                          { return this.m_time_series.CopyToBufferAsSeries(symbol,timeframe,property,array,empty);}

//--- Return (1) the tick series collection, (2) the list of tick series from the tick series collection
   CTickSeriesCollection *GetTickSeriesCollection(void)                                { return &this.m_tick_series;                                  }
   CArrayObj           *GetListTickSeries(void)                                        { return this.m_tick_series.GetList();                         }

//--- Create (1) a specified tick series and (2) all tick series
   bool                 TickSeriesCreate(const string symbol,const uint required=0)    { return this.m_tick_series.CreateTickSeries(symbol,required); }
   bool                 TickSeriesCreateAll(const uint required=0)                     { return this.m_tick_series.CreateTickSeriesAll(required);     }

//--- Update (1) a tick series of a specified symbol, (2) all symbols and (3) all symbols except the current one
   void                 TickSeriesRefresh(const string symbol)                         { this.m_tick_series.Refresh(symbol);                          }
   void                 TickSeriesRefreshAll(void)                                     { this.m_tick_series.Refresh();                                }
   void                 TickSeriesRefreshAllExceptCurrent(void)                        { this.m_tick_series.RefreshExpectCurrent();                   }

//--- Return (1) the DOM series collection and (2) the list of DOM series from the DOM series collection
   CMBookSeriesCollection *GetMBookSeriesCollection(void)                              { return &this.m_book_series;                         }
   CArrayObj           *GetListMBookSeries(void)                                       { return this.m_book_series.GetList();                }

//--- Update the DOM series of a specified symbol
   void                 MBookSeriesRefresh(const string symbol,const long time_msc)    { this.m_book_series.Refresh(symbol,time_msc);        }

//--- Return (1) the DOM series of a specified symbol, the DOM (2) by index and (3) by time in milliseconds
   CMBookSeries        *GetMBookSeries(const string symbol)                            { return this.m_book_series.GetMBookseries(symbol);   }
   CMBookSnapshot      *GetMBook(const string symbol,const int index)                  { return this.m_book_series.GetMBook(symbol,index);   }
   CMBookSnapshot      *GetMBook(const string symbol,const long time_msc)              { return this.m_book_series.GetMBook(symbol,time_msc);}
   
//--- Return the volume of a (1) buy and (2) sell DOM specified by symbol and index
   long                 MBookVolumeBuy(const string symbol,const int index);
   long                 MBookVolumeSell(const string symbol,const int index);
//--- Return the increased precision volume of a (1) buy and (2) sell DOM specified by symbol and index
   double               MBookVolumeBuyReal(const string symbol,const int index);
   double               MBookVolumeSellReal(const string symbol,const int index);
//--- Return the volume of a (1) buy and (2) sell DOM specified by symbol and time in milliseconds
   long                 MBookVolumeBuy(const string symbol,const long time_msc);
   long                 MBookVolumeSell(const string symbol,const long time_msc);
//--- Return the increased precision volume of a (1) buy and (2) sell DOM specified by symbol and time in milliseconds
   double               MBookVolumeBuyReal(const string symbol,const long time_msc);
   double               MBookVolumeSellReal(const string symbol,const long time_msc);
   
//--- Return (1) the collection of mql5.com Signals service signals and (2) the list of signals from the mql5.com Signals service signal collection
   CMQLSignalsCollection *GetSignalsMQL5Collection(void)                               { return &this.m_signals_mql5;                        }
   CArrayObj           *GetListSignalsMQL5(void)                                       { return this.m_signals_mql5.GetList();               }
//--- Return the list of (1) paid and (2) free signals
   CArrayObj           *GetListSignalsMQL5Paid(void)                    { return this.m_signals_mql5.GetList(SIGNAL_MQL5_PROP_PRICE,0,MORE); }
   CArrayObj           *GetListSignalsMQL5Free(void)                    { return this.m_signals_mql5.GetList(SIGNAL_MQL5_PROP_PRICE,0,EQUAL);}

//--- (1) Create and (2) update the collection of mql5.com Signals service signals
   bool                 SignalsMQL5Create(void)                                        { return this.m_signals_mql5.CreateCollection();      } 
   void                 SignalsMQL5Refresh(void)                                       { this.m_signals_mql5.Refresh();                      }
//--- Subscribe to a signal by (1) ID and (2) signal name
   bool                 SignalsMQL5Subscribe(const long signal_id)                     { return this.m_signals_mql5.SubscribeByID(signal_id);}
   bool                 SignalsMQL5Subscribe(const string signal_name)                 { return this.m_signals_mql5.SubscribeByName(signal_name);}
//--- Unsubscribe from the current signal
   bool                 SignalsMQL5Unsubscribe(void)                                   { return this.m_signals_mql5.CurrentUnsubscribe();    }
//--- Return (1) ID and (2) the name of the current signal subscription is performed to
   long                 SignalsMQL5CurrentID(void)                                     { return this.m_signals_mql5.CurrentID();             }
   string               SignalsMQL5CurrentName(void)                                   { return this.m_signals_mql5.CurrentName();           }
   
//--- Set the percentage for converting deal volume
   bool                 SignalsMQL5CurrentSetEquityLimit(const double value)  { return this.m_signals_mql5.CurrentSetEquityLimit(value);     }
//--- Set the market order slippage used when synchronizing positions and copying deals
   bool                 SignalsMQL5CurrentSetSlippage(const double value)     { return this.m_signals_mql5.CurrentSetSlippage(value);        }
//--- Set deposit limitations (in %)
   bool                 SignalsMQL5CurrentSetDepositPercent(const int value)  { return this.m_signals_mql5.CurrentSetDepositPercent(value);  }
//--- Enable synchronization without the confirmation dialog
   bool                 SignalsMQL5CurrentSetConfirmationsDisableON(void)     { return this.m_signals_mql5.CurrentSetConfirmationsDisableON();}
//--- Disable synchronization without the confirmation dialog
   bool                 SignalsMQL5CurrentSetConfirmationsDisableOFF(void)    { return this.m_signals_mql5.CurrentSetConfirmationsDisableOFF();}
//--- Enable copying Stop Loss and Take Profit
   bool                 SignalsMQL5CurrentSetSLTPCopyON(void)                 { return this.m_signals_mql5.CurrentSetSLTPCopyON();           }
//--- Disable copying Stop Loss and Take Profit
   bool                 SignalsMQL5CurrentSetSLTPCopyOFF(void)                { return this.m_signals_mql5.CurrentSetSLTPCopyOFF();          }
//--- Enable copying deals by subscription
   bool                 SignalsMQL5CurrentSetSubscriptionEnableON(void)       { return this.m_signals_mql5.CurrentSetSubscriptionEnableON(); }
//--- Disable copying deals by subscription
   bool                 SignalsMQL5CurrentSetSubscriptionEnableOFF(void)      { return this.m_signals_mql5.CurrentSetSubscriptionEnableOFF();}
   
//--- Display (1) the complete, (2) short collection description in the journal and (3) parameters of the signal copying settings
   void                 SignalsMQL5Print(void)                                         { m_signals_mql5.Print();                             }
   void                 SignalsMQL5PrintShort(const bool list=false,const bool paid=true,const bool free=true)
                                                                                       { m_signals_mql5.PrintShort(list,paid,free);          }
   void                 SignalsMQL5CurrentSubscriptionParameters(void)                 { this.m_signals_mql5.CurrentSubscriptionParameters();}
   
//--- Current the chart collection
   bool                 ChartCreateCollection(void)                                    { return this.m_charts.CreateCollection();            }
//--- Return (1) the chart collection and (2) the list of charts from the chart collection
   CChartObjCollection *GetChartObjCollection(void)                                    { return &this.m_charts;                              }
   CArrayObj           *GetListCharts(void)                                            { return this.m_charts.GetList();                     }
//--- Return the list of chart objects by (1) symbol and (2) timeframe
   CArrayObj           *GetListCharts(const string symbol)                             { return this.m_charts.GetChartsList(symbol);         }
   CArrayObj           *GetListCharts(const ENUM_TIMEFRAMES timeframe)                 { return this.m_charts.GetChartsList(timeframe);      }
//--- Return the list of removed (1) chart objects, (2) chart windows, (3) indicators in the chart window and (4) changed indicators in the chart window
   CArrayObj           *GetListChartsClosed(void)                                      { return this.m_charts.GetListDeletedCharts();        }
   CArrayObj           *GetListChartWindowsDeleted(void)                               { return this.m_charts.GetListDeletedWindows();       }
   CArrayObj           *GetListChartWindowsIndicatorsDeleted(void)                     { return this.m_charts.GetListDeletedIndicators();    }
   CArrayObj           *GetListChartWindowsIndicatorsChanged(void)                     { return this.m_charts.GetListChangedIndicators();    }

//--- Return (1) the specified chart object and (2) the chart object with the program
   CChartObj           *ChartGetChartObj(const long chart_id)                          { return this.m_charts.GetChart(chart_id);            }
   CChartObj           *ChartGetMainChart(void)                                        { return this.m_charts.GetChart(this.m_charts.GetMainChartID());}
//--- Reutrn the chart object of the last (1) open and (2) closed chart
   CChartObj           *ChartGetLastOpenedChart(void)                                  { return this.m_charts.GetLastAddedChart();           }
   CChartObj           *ChartGetLastClosedChart(void)                                  { return this.m_charts.GetLastDeletedChart();         }

//--- Return the object (1) of the last added window of the specified chart and (2) the last removed chart window
   CChartWnd           *ChartGetLastAddedChartWindow(const long chart_id)              { return this.m_charts.GetLastAddedChartWindow(chart_id);}
   CChartWnd           *ChartGetLastDeletedChartWindow(void)                           { return this.m_charts.GetLastDeletedChartWindow();   }
//--- Return the window object (specified by index) of the chart (specified by ID)
   CChartWnd           *ChartGetChartWindow(const long chart_id,const int wnd_num)     { return this.m_charts.GetChartWindow(chart_id,wnd_num);}
   
   
//--- Return (1) the last one added to the specified window of the specified chart, (2) the last one removed from the window and (3) the changed indicator
   CWndInd             *ChartGetLastAddedIndicator(const long id,const int win)        { return m_charts.GetLastAddedIndicator(id,win);      }
   CWndInd             *ChartGetLastDeletedIndicator(void)                             { return this.m_charts.GetLastDeletedIndicator();     }
   CWndInd             *ChartGetLastChangedIndicator(void)                             { return this.m_charts.GetLastChangedIndicator();     }
//--- Return the indicator by index from the specified window of the specified chart
   CWndInd             *ChartGetIndicator(const long chart_id,const int win_num,const int ind_index)
                          {
                           return m_charts.GetIndicator(chart_id,win_num,ind_index);
                          }

//--- Return the number of charts in the collection list
   int                  ChartsTotal(void)                                              { return this.m_charts.DataTotal();                   }

//--- Update (1) the chart specified by ID and (2) all charts
   void                 ChartRefresh(const long chart_id)                              { this.m_charts.Refresh(chart_id);                    }
   void                 ChartsRefreshAll(void)                                         { this.m_charts.Refresh();                            }

//--- (1) Open and (2) close the specified chart
   bool                 ChartOpen(const string symbol,const ENUM_TIMEFRAMES timeframe) { return this.m_charts.Open(symbol,timeframe);        }
   bool                 ChartClose(const long chart_id)                                { return this.m_charts.Close(chart_id);               }
   
//--- Return (1) the buffer collection and (2) the buffer list from the collection 
   CBuffersCollection  *GetBuffersCollection(void)                                     { return &this.m_buffers;                                }
   CArrayObj           *GetListBuffers(void)                                           { return this.m_buffers.GetList();                       }
//--- Return the buffer by (1) the graphical series name, (2) timeframe, (3) Plot index, (4) collection list and (5) the last one in the list
   CBuffer             *GetBufferByLabel(const string plot_label)                      { return this.m_buffers.GetBufferByLabel(plot_label);    }
   CBuffer             *GetBufferByTimeframe(const ENUM_TIMEFRAMES timeframe)          { return this.m_buffers.GetBufferByTimeframe(timeframe); }
   CBuffer             *GetBufferByPlot(const int plot_index)                          { return this.m_buffers.GetBufferByPlot(plot_index);     }
   CBuffer             *GetBufferByListIndex(const int index_list)                     { return this.m_buffers.GetBufferByListIndex(index_list);}
   CBuffer             *GetLastCreateBuffer(void)                                      { return this.m_buffers.GetLastCreateBuffer();           }
//--- Return buffers by drawing style by a serial number
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   CBufferArrow        *GetBufferArrow(const int number)                               { return this.m_buffers.GetBufferArrow(number);       }
   CBufferLine         *GetBufferLine(const int number)                                { return this.m_buffers.GetBufferLine(number);        }
   CBufferSection      *GetBufferSection(const int number)                             { return this.m_buffers.GetBufferSection(number);     }
   CBufferHistogram    *GetBufferHistogram(const int number)                           { return this.m_buffers.GetBufferHistogram(number);   }
   CBufferHistogram2   *GetBufferHistogram2(const int number)                          { return this.m_buffers.GetBufferHistogram2(number);  }
   CBufferZigZag       *GetBufferZigZag(const int number)                              { return this.m_buffers.GetBufferZigZag(number);      }
   CBufferFilling      *GetBufferFilling(const int number)                             { return this.m_buffers.GetBufferFilling(number);     }
   CBufferBars         *GetBufferBars(const int number)                                { return this.m_buffers.GetBufferBars(number);        }
   CBufferCandles      *GetBufferCandles(const int number)                             { return this.m_buffers.GetBufferCandles(number);     }
   CBufferCalculate    *GetBufferCalculate(const int number)                           { return this.m_buffers.GetBufferCalculate(number);   }
   
//--- Return the number of (1) drawn buffers and (2) all indicator arrays
   int                  BuffersPropertyPlotsTotal(void)                                { return this.m_buffers.PropertyPlotsTotal();         }
   int                  BuffersPropertyBuffersTotal(void)                              { return this.m_buffers.PropertyBuffersTotal();       }

//--- Create the new buffer (1) "Drawing with arrows", (2) "Line", (3) "Sections", (4) "Histogram from the zero line", 
//--- (5) "Histogram on two indicator buffers", (6) "Zigzag", (7) "Color filling between two levels",
//--- (8) "Display as bars", (9) "Display as candles", calculated buffer
   bool                 BufferCreateArrow(void)                                        { return this.m_buffers.CreateArrow();                }
   bool                 BufferCreateLine(void)                                         { return this.m_buffers.CreateLine();                 }
   bool                 BufferCreateSection(void)                                      { return this.m_buffers.CreateSection();              }
   bool                 BufferCreateHistogram(void)                                    { return this.m_buffers.CreateHistogram();            }
   bool                 BufferCreateHistogram2(void)                                   { return this.m_buffers.CreateHistogram2();           }
   bool                 BufferCreateZigZag(void)                                       { return this.m_buffers.CreateZigZag();               }
   bool                 BufferCreateFilling(void)                                      { return this.m_buffers.CreateFilling();              }
   bool                 BufferCreateBars(void)                                         { return this.m_buffers.CreateBars();                 }
   bool                 BufferCreateCandles(void)                                      { return this.m_buffers.CreateCandles();              }
   bool                 BufferCreateCalculate(void)                                    { return this.m_buffers.CreateCalculate();            }

//--- The methods of creating standard indicators and buffer objects for them
//--- Create the standard Accelerator Oscillator indicator
   bool                 BufferCreateAC(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id)
                          { return(this.m_buffers.CreateAC(symbol,timeframe,id)!=INVALID_HANDLE);                    }
//--- Create the standard Accumulation/Distribution indicator
   bool                 BufferCreateAD(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume,const int id)
                          { return(this.m_buffers.CreateAD(symbol,timeframe,applied_volume,id)!=INVALID_HANDLE);     }
//--- Create the standard Average Directional Movement Index indicator
   bool                 BufferCreateADX(const string symbol,const ENUM_TIMEFRAMES timeframe,const int adx_period,const int id)
                          { return(this.m_buffers.CreateADX(symbol,timeframe,adx_period,id)!=INVALID_HANDLE);        }
//--- Create the standard Average Directional Movement Index Wilder indicator
   bool                 BufferCreateADXWilder(const string symbol,const ENUM_TIMEFRAMES timeframe,const int adx_period,const int id)
                          { return(this.m_buffers.CreateADXWilder(symbol,timeframe,adx_period,id)!=INVALID_HANDLE);  }
//--- Create the standard Alligator indicator
   bool                 BufferCreateAlligator(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                              const int jaw_period,const int jaw_shift,
                                              const int teeth_period,const int teeth_shift,
                                              const int lips_period,const int lips_shift,
                                              const ENUM_MA_METHOD ma_method,const ENUM_APPLIED_PRICE applied_price,const int id)
                          {
                           return(this.m_buffers.CreateAlligator(symbol,timeframe,
                                                                 jaw_period,jaw_shift,
                                                                 teeth_period,teeth_shift,
                                                                 lips_period,lips_shift,
                                                                 ma_method,applied_price,id)!=INVALID_HANDLE);
                          }
//--- Create the standard Adaptive Moving Average indicator
   bool                 BufferCreateAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                        const int ama_period,
                                        const int fast_ema_period,
                                        const int slow_ema_period,
                                        const int ama_shift,
                                        const ENUM_APPLIED_PRICE applied_price,
                                        const int id)
                          { 
                           return(this.m_buffers.CreateAMA(symbol,timeframe,
                                                           ama_period,
                                                           fast_ema_period,slow_ema_period,
                                                           ama_shift,applied_price,id)!=INVALID_HANDLE);
                          }
//--- Create the standard Awesome Oscillator indicator
   bool                 BufferCreateAO(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id)
                          { return(this.m_buffers.CreateAO(symbol,timeframe,id)!=INVALID_HANDLE);  }
//--- Create the standard Average True Range indicator
   bool                 BufferCreateATR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id)
                          { return(this.m_buffers.CreateATR(symbol,timeframe,ma_period,id)!=INVALID_HANDLE);  }
//--- Create the standard Bollinger Bands indicator
   bool                 BufferCreateBands(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                          const int bands_period,
                                          const int bands_shift,
                                          const double deviation,
                                          const ENUM_APPLIED_PRICE applied_price,
                                          const int id)
                          {
                           return(this.m_buffers.CreateBands(symbol,timeframe,
                                                             bands_period,bands_shift,
                                                             deviation,applied_price,id)!=INVALID_HANDLE);
                          }
//--- Create the standard Bears Power indicator
   bool                 BufferCreateBearsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id)
                          { return(this.m_buffers.CreateBearsPower(symbol,timeframe,ma_period,id)!=INVALID_HANDLE);  }
//--- Create the standard Bulls Power indicator
   bool                 BufferCreateBullsPower(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id)
                          { return(this.m_buffers.CreateBullsPower(symbol,timeframe,ma_period,id)!=INVALID_HANDLE);  }
//--- Create the standard Chaikin Oscillator indicator
   bool                 BufferCreateChaikin(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int fast_ma_period,
                                       const int slow_ma_period,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_VOLUME applied_volume,
                                       const int id)
                          {
                           return(this.m_buffers.CreateChaikin(symbol,timeframe,
                                                                fast_ma_period,slow_ma_period,
                                                                ma_method,applied_volume,id)!=INVALID_HANDLE);
                          }
//--- Create the standard Commodity Channel Index indicator
   bool                 BufferCreateCCI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateCCI(symbol,timeframe,ma_period,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard Double Exponential Moving Average indicator
   bool                 BufferCreateDEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateDEMA(symbol,timeframe,ma_period,ma_shift,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard DeMarker indicator
   bool                 BufferCreateDeMarker(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id)
                          { return(this.m_buffers.CreateDeMarker(symbol,timeframe,ma_period,id)!=INVALID_HANDLE);  }
//--- Create the standard Envelopes indicator
   bool                 BufferCreateEnvelopes(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const double deviation,
                                       const int id)
                          {
                           return(this.m_buffers.CreateEnvelopes(symbol,timeframe,
                                                                  ma_period,ma_shift,ma_method,
                                                                  applied_price,deviation,id)!=INVALID_HANDLE);
                          }
//--- Create the standard Force Index indicator
   bool                 BufferCreateForce(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_VOLUME applied_volume,
                                       const int id)
                          { return(this.m_buffers.CreateForce(symbol,timeframe,ma_period,ma_method,applied_volume,id)!=INVALID_HANDLE);  }
//--- Create the standard Fractals indicator
   bool                 BufferCreateFractals(const string symbol,const ENUM_TIMEFRAMES timeframe,const int id)
                          { return(this.m_buffers.CreateFractals(symbol,timeframe,id)!=INVALID_HANDLE);  }
//--- Create the standard Fractal Adaptive Moving Average indicator
   bool                 BufferCreateFrAMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateFrAMA(symbol,timeframe,ma_period,ma_shift,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard Gator indicator
   bool                 BufferCreateGator(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int jaw_period,
                                       const int jaw_shift,
                                       const int teeth_period,
                                       const int teeth_shift,
                                       const int lips_period,
                                       const int lips_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          {
                           return(this.m_buffers.CreateGator(symbol,timeframe,
                                                              jaw_period,jaw_shift,
                                                              teeth_period,teeth_shift,
                                                              lips_period,lips_shift,
                                                              ma_method,applied_price,id)!=INVALID_HANDLE);
                          }
//--- Create the standard Ichimoku indicator
   bool                 BufferCreateIchimoku(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int tenkan_sen,
                                       const int kijun_sen,
                                       const int senkou_span_b,
                                       const int id)
                          { return(this.m_buffers.CreateIchimoku(symbol,timeframe,tenkan_sen,kijun_sen,senkou_span_b,id)!=INVALID_HANDLE);  }
//--- Create the standard Market Facilitation Index indicator
   bool                 BufferCreateBWMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const ENUM_APPLIED_VOLUME applied_volume,
                                       const int id)
                          { return(this.m_buffers.CreateBWMFI(symbol,timeframe,applied_volume,id)!=INVALID_HANDLE);  }
//--- Create the standard Momentum indicator
   bool                 BufferCreateMomentum(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int mom_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateMomentum(symbol,timeframe,mom_period,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard Money Flow Index indicator
   bool                 BufferCreateMFI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_VOLUME applied_volume,
                                       const int id)
                          { return(this.m_buffers.CreateMFI(symbol,timeframe,ma_period,applied_volume,id)!=INVALID_HANDLE);  }
//--- Create the standard Moving Average indicator
   bool                 BufferCreateMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateMA(symbol,timeframe,ma_period,ma_shift,ma_method,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard Moving Average of Oscillator indicator
   bool                 BufferCreateOsMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int fast_ema_period,
                                       const int slow_ema_period,
                                       const int signal_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateOsMA(symbol,timeframe,fast_ema_period,slow_ema_period,signal_period,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard MACD indicator
   bool                 BufferCreateMACD(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int fast_ema_period,
                                       const int slow_ema_period,
                                       const int signal_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateMACD(symbol,timeframe,fast_ema_period,slow_ema_period,signal_period,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard On Balance Volume indicator
   bool                 BufferCreateOBV(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const ENUM_APPLIED_VOLUME applied_volume,
                                       const int id)
                          { return(this.m_buffers.CreateOBV(symbol,timeframe,applied_volume,id)!=INVALID_HANDLE);  }
//--- Create the standard Parabolic SAR indicator
   bool                 BufferCreateSAR(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const double step,
                                       const double maximum,
                                       const int id)
                          { return(this.m_buffers.CreateSAR(symbol,timeframe,step,maximum,id)!=INVALID_HANDLE);  }
//--- Create the standard Relative Strength Index indicator
   bool                 BufferCreateRSI(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateRSI(symbol,timeframe,ma_period,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard Relative Vigor Index indicator
   bool                 BufferCreateRVI(const string symbol,const ENUM_TIMEFRAMES timeframe,const int ma_period,const int id)
                          { return(this.m_buffers.CreateRVI(symbol,timeframe,ma_period,id)!=INVALID_HANDLE);  }
//--- Create the Standard Deviation indicator
   bool                 BufferCreateStdDev(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateStdDev(symbol,timeframe,ma_period,ma_shift,ma_method,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard Stochastic Oscillator indicator
   bool                 BufferCreateStochastic(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int Kperiod,
                                       const int Dperiod,
                                       const int slowing,
                                       const ENUM_MA_METHOD ma_method,
                                       const ENUM_STO_PRICE price_field,
                                       const int id)
                          { return(this.m_buffers.CreateStochastic(symbol,timeframe,Kperiod,Dperiod,slowing,ma_method,price_field,id)!=INVALID_HANDLE);  }
//--- Create the standard Triple Exponential Moving Average indicator
   bool                 BufferCreateTEMA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateTEMA(symbol,timeframe,ma_period,ma_shift,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard Triple Exponential Average indicator
   bool                 BufferCreateTriX(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int ma_period,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateTriX(symbol,timeframe,ma_period,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard William's Percent Range indicator
   bool                 BufferCreateWPR(const string symbol,const ENUM_TIMEFRAMES timeframe,const int calc_period,const int id)
                          { return(this.m_buffers.CreateWPR(symbol,timeframe,calc_period,id)!=INVALID_HANDLE);  }
//--- Create the standard Variable Index Dynamic Average indicator
   bool                 BufferCreateVIDYA(const string symbol,const ENUM_TIMEFRAMES timeframe,
                                       const int cmo_period,
                                       const int ema_period,
                                       const int ma_shift,
                                       const ENUM_APPLIED_PRICE applied_price,
                                       const int id)
                          { return(this.m_buffers.CreateVIDYA(symbol,timeframe,cmo_period,ema_period,ma_shift,applied_price,id)!=INVALID_HANDLE);  }
//--- Create the standard Volumes indicator
   bool                 BufferCreateVolumes(const string symbol,const ENUM_TIMEFRAMES timeframe,const ENUM_APPLIED_VOLUME applied_volume,const int id)
                          { return(this.m_buffers.CreateVolumes(symbol,timeframe,applied_volume,id)!=INVALID_HANDLE);  }
                          
//--- Initialize all drawn buffers by a (1) specified value, (2) empty value set for the buffer object
   void                 BuffersInitPlots(const double value,const uchar color_index)   { this.m_buffers.InitializePlots(value,color_index);  }
   void                 BuffersInitPlots(void)                                         { this.m_buffers.InitializePlots();                   }
//--- Initialize all calculated buffers by a (1) specified value, (2) empty value set for the buffer object
   void                 BuffersInitCalculates(const double value)                      { this.m_buffers.InitializeCalculates(value);         }
   void                 BuffersInitCalculates(void)                                    { this.m_buffers.InitializeCalculates();              }

//--- Return buffer data by its serial number of (1) arrows, (2) line, (3) sections and (4) histogram from zero
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   double               BufferDataArrow(const int number,const int series_index);
   double               BufferDataLine(const int number,const int series_index);
   double               BufferDataSection(const int number,const int series_index);
   double               BufferDataHistogram(const int number,const int series_index);
//--- Return buffer data by its serial number of (1) the zero and (2) the first histogram buffer on two buffers
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   double               BufferDataHistogram20(const int number,const int series_index);
   double               BufferDataHistogram21(const int number,const int series_index);
//--- Return buffer data by its serial number of (1) the zero and (2) the first zigzag buffer
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   double               BufferDataZigZag0(const int number,const int series_index);
   double               BufferDataZigZag1(const int number,const int series_index);
//--- Return buffer data by its serial number of (1) the zero and (2) the first filling buffer
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   double               BufferDataFilling0(const int number,const int series_index);
   double               BufferDataFilling1(const int number,const int series_index);
//--- Return buffer data by its serial number of (1) Open, (2) High, (3) Low and (4) Close bar buffers
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   double               BufferDataBarsOpen(const int number,const int series_index);
   double               BufferDataBarsHigh(const int number,const int series_index);
   double               BufferDataBarsLow(const int number,const int series_index);
   double               BufferDataBarsClose(const int number,const int series_index);
//--- Return buffer data by its serial number of (1) Open, (2) High, (3) Low and (4) Close candle buffers
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   double               BufferDataCandlesOpen(const int number,const int series_index);
   double               BufferDataCandlesHigh(const int number,const int series_index);
   double               BufferDataCandlesLow(const int number,const int series_index);
   double               BufferDataCandlesClose(const int number,const int series_index);

//--- Set buffer data by its serial number of (1) arrows, (2) line, (3) sections, (4) histogram from zero and the (5) calculated buffer
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   void                 BufferSetDataArrow(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false);
   void                 BufferSetDataLine(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false);
   void                 BufferSetDataSection(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false);
   void                 BufferSetDataHistogram(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false);
   void                 BufferSetDataCalculate(const int number,const int series_index,const double value);
//--- Set data of the (1) zero, (2) first and (3) all histogram buffers on two buffers by a serial number of a created buffer
//--- (0 - the very first created buffer with the HISTOGRAM2 drawing style, 1,2,N - subsequent ones)
   void                 BufferSetDataHistogram20(const int number,const int series_index,const double value);
   void                 BufferSetDataHistogram21(const int number,const int series_index,const double value);
   void                 BufferSetDataHistogram2(const int number,const int series_index,const double value0,const double value1,const uchar color_index,bool as_current=false);
//--- Set data of the (1) zero, (2) first and (3) all zigzag buffers by a serial number of a created buffer
//--- (0 - the very first created buffer with the ZIGZAG drawing style, 1,2,N - subsequent ones)
   void                 BufferSetDataZigZag0(const int number,const int series_index,const double value);
   void                 BufferSetDataZigZag1(const int number,const int series_index,const double value);
   void                 BufferSetDataZigZag(const int number,const int series_index,const double value0,const double value1,const uchar color_index,bool as_current=false);
//--- Set data of the (1) zero, (2) first and (3) all filling buffers by a serial number of a created buffer
//--- (0 - the very first created buffer with the FILLING drawing style, 1,2,N - subsequent ones)
   void                 BufferSetDataFilling0(const int number,const int series_index,const double value);
   void                 BufferSetDataFilling1(const int number,const int series_index,const double value);
   void                 BufferSetDataFilling(const int number,const int series_index,const double value0,const double value1,bool as_current=false);
//--- Set data of the (1) Open, (2) High, (3) Low, (4) Close and (5) all bar buffers by a serial number of a created buffer
//--- (0 - the very first created buffer with the BARS drawing style, 1,2,N - subsequent ones)
   void                 BufferSetDataBarsOpen(const int number,const int series_index,const double value);
   void                 BufferSetDataBarsHigh(const int number,const int series_index,const double value);
   void                 BufferSetDataBarsLow(const int number,const int series_index,const double value);
   void                 BufferSetDataBarsClose(const int number,const int series_index,const double value);
   void                 BufferSetDataBars(const int number,const int series_index,const double open,const double high,const double low,const double close,const uchar color_index,bool as_current=false);
//--- Set data of the (1) Open, (2) High, (3) Low, (4) Close and (5) all candle buffers by a serial number of a created buffer
//--- (0 - the very first created buffer with the CANDLES drawing style, 1,2,N - subsequent ones)
   void                 BufferSetDataCandlesOpen(const int number,const int series_index,const double value);
   void                 BufferSetDataCandlesHigh(const int number,const int series_index,const double value);
   void                 BufferSetDataCandlesLow(const int number,const int series_index,const double value);
   void                 BufferSetDataCandlesClose(const int number,const int series_index,const double value);
   void                 BufferSetDataCandles(const int number,const int series_index,const double open,const double high,const double low,const double close,const uchar color_index,bool as_current=false);
   
//--- Return buffer color by its serial number of (1) arrows, (2) line, (3) sections, (4) histogram from zero
//--- (5) histogram on two buffers, (6) zigzag, (7) filling, (8) bars and (9) candles
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   color                BufferArrowColor(const int number,const int series_index);
   color                BufferLineColor(const int number,const int series_index);
   color                BufferSectionColor(const int number,const int series_index);
   color                BufferHistogramColor(const int number,const int series_index);
   color                BufferHistogram2Color(const int number,const int series_index);
   color                BufferZigZagColor(const int number,const int series_index);
   color                BufferFillingColor(const int number,const int series_index);
   color                BufferBarsColor(const int number,const int series_index);
   color                BufferCandlesColor(const int number,const int series_index);
   
//--- Return buffer color index by its serial number of (1) arrows, (2) line, (3) sections, (4) histogram from zero
//--- (5) histogram on two buffers, (6) zigzag, (7) filling, (8) bars and (9) candles
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   int                  BufferArrowColorIndex(const int number,const int series_index);
   int                  BufferLineColorIndex(const int number,const int series_index);
   int                  BufferSectionColorIndex(const int number,const int series_index);
   int                  BufferHistogramColorIndex(const int number,const int series_index);
   int                  BufferHistogram2ColorIndex(const int number,const int series_index);
   int                  BufferZigZagColorIndex(const int number,const int series_index);
   int                  BufferFillingColorIndex(const int number,const int series_index);
   int                  BufferBarsColorIndex(const int number,const int series_index);
   int                  BufferCandlesColorIndex(const int number,const int series_index);

//--- Set color values from the passed color array for all indicator buffers within the collection
   void                 BuffersSetColors(const color &array_colors[])                     { this.m_buffers.SetColors(array_colors);                   } 
//--- Set the color index to the color buffer by its serial number of (1) arrows, (2) line, (3) sections, (4) histogram from zero
//--- (5) histogram on two buffers, (6) zigzag, (7) filling, (8) bars and (9) candles
//--- (0 - the very first created buffer with the ХХХ drawing style, 1,2,N - subsequent ones)
   void                 BufferArrowSetColorIndex(const int number,const int series_index,const uchar color_index)
                          { this.m_buffers.SetBufferArrowColorIndex(number,series_index,color_index);       }
   void                 BufferLineSetColorIndex(const int number,const int series_index,const uchar color_index)
                          { this.m_buffers.SetBufferLineColorIndex(number,series_index,color_index);        }
   void                 BufferSectionSetColorIndex(const int number,const int series_index,const uchar color_index)
                          { this.m_buffers.SetBufferSectionColorIndex(number,series_index,color_index);     }
   void                 BufferHistogramSetColorIndex(const int number,const int series_index,const uchar color_index)
                          { this.m_buffers.SetBufferHistogramColorIndex(number,series_index,color_index);   }
   void                 BufferHistogram2SetColorIndex(const int number,const int series_index,const uchar color_index)
                          { this.m_buffers.SetBufferHistogram2ColorIndex(number,series_index,color_index);  }
   void                 BufferZigZagSetColorIndex(const int number,const int series_index,const uchar color_index)
                          { this.m_buffers.SetBufferZigZagColorIndex(number,series_index,color_index);      }
   void                 BufferFillingSetColorIndex(const int number,const int series_index,const uchar color_index)
                          { this.m_buffers.SetBufferFillingColorIndex(number,series_index,color_index);     }
   void                 BufferBarsSetColorIndex(const int number,const int series_index,const uchar color_index)
                          { this.m_buffers.SetBufferBarsColorIndex(number,series_index,color_index);        }
   void                 BufferCandlesSetColorIndex(const int number,const int series_index,const uchar color_index)
                          { this.m_buffers.SetBufferCandlesColorIndex(number,series_index,color_index);     }

//--- Clear buffer data by its index in the list in the specified timeseries bar
   void                 BufferClear(const int buffer_list_index,const int series_index)   { this.m_buffers.Clear(buffer_list_index,series_index);     }
//--- Clear data by the timeseries index for the (1) arrow, (2) line, (3) section, (4) zero line histogram,
//--- (5) histogram on two buffers, (6) zigzag, (7) filling, (8) bars and (9) candles
   void                 BufferArrowClear(const int number,const int series_index)         { this.m_buffers.ClearBufferArrow(number,series_index);     }
   void                 BufferLineClear(const int number,const int series_index)          { this.m_buffers.ClearBufferLine(number,series_index);      }
   void                 BufferSectionClear(const int number,const int series_index)       { this.m_buffers.ClearBufferSection(number,series_index);   }
   void                 BufferHistogramClear(const int number,const int series_index)     { this.m_buffers.ClearBufferHistogram(number,series_index); }
   void                 BufferHistogram2Clear(const int number,const int series_index)    { this.m_buffers.ClearBufferHistogram2(number,series_index);}
   void                 BufferZigZagClear(const int number,const int series_index)        { this.m_buffers.ClearBufferZigZag(number,series_index);    }
   void                 BufferFillingClear(const int number,const int series_index)       { this.m_buffers.ClearBufferFilling(number,series_index);   }
   void                 BufferBarsClear(const int number,const int series_index)          { this.m_buffers.ClearBufferBars(number,series_index);      }
   void                 BufferCandlesClear(const int number,const int series_index)       { this.m_buffers.ClearBufferCandles(number,series_index);   }

//--- Prepare data of the calculated buffer of all created standard indicators
   bool                 BufferPreparingDataAllBuffersStdInd(void)                         { return this.m_buffers.PreparingDataAllBuffersStdInd();    }

//--- Return the standard indicator buffer description by type and ID
   string               BufferGetLabelByTypeID(const ENUM_INDICATOR ind_type,const int id,const ENUM_INDICATOR_LINE_MODE line_mode)
                          { return this.m_buffers.GetLabelByTypeID(ind_type,id,line_mode);                        }
//--- Return the standard indicator short name by type and ID
   string               BufferGetIndicatorShortNameByTypeID(const ENUM_INDICATOR ind_type,const int id)
                          { return this.m_buffers.GetIndicatorShortNameByTypeID(ind_type,id);                     }

//--- Display short description of all indicator buffers of the buffer collection
   void                 BuffersPrintShort(void);

//--- Specify the required number of buffers for indicators
   void                 CheckIndicatorsBuffers(const int buffers,const int plots #ifdef __MQL4__ =1 #endif );
 
//--- Return the bar index on the specified timeframe chart by the current chart's bar index
   int                  IndexBarPeriodByBarCurrent(const int series_index,const string symbol,const ENUM_TIMEFRAMES timeframe)
                          { return this.m_time_series.IndexBarPeriodByBarCurrent(series_index,symbol,timeframe);  }
                          
//--- Return (1) the indicator collection, (2) the indicator list from the collection 
   CIndicatorsCollection *GetIndicatorsCollection(void)                                { return &this.m_indicators;              }
   CArrayObj           *GetListIndicators(void)                                        { return this.m_indicators.GetList();     }
   
//--- Create all timeseries used of all collection indicators
   bool                 IndicatorSeriesCreateAll(void)                                 { return this.m_indicators.SeriesCreateAll();}
//--- Update buffer data of all indicators
   void                 IndicatorSeriesRefreshAll(void)                                { this.m_indicators.SeriesRefreshAll();   }
   void                 IndicatorSeriesRefresh(const int ind_id)                       { this.m_indicators.SeriesRefresh(ind_id);}
   
//--- Return the value of the specified buffer by (1) time, (2) number of the bar specified by indicator ID
   double               IndicatorGetBufferValue(const uint ind_id,const int buffer_num,const datetime time)
                          { return this.m_indicators.GetBufferValue(ind_id,buffer_num,time); }
   double               IndicatorGetBufferValue(const uint ind_id,const int buffer_num,const uint shift)
                          { return this.m_indicators.GetBufferValue(ind_id,buffer_num,shift); }
   
//--- Set the following for the trading classes:
//--- (1) correct filling policy, (2) filling policy,
//--- (3) correct order expiration type, (4) order expiration type,
//--- (5) magic number, (6) comment, (7) slippage, (8) volume, (9) order expiration date,
//--- (10) the flag of asynchronous sending of a trading request, (11) logging level, (12) number of trading attempts
   void                 TradingSetCorrectTypeFilling(const ENUM_ORDER_TYPE_FILLING type=ORDER_FILLING_FOK,const string symbol_name=NULL);
   void                 TradingSetTypeFilling(const ENUM_ORDER_TYPE_FILLING type=ORDER_FILLING_FOK,const string symbol_name=NULL);
   void                 TradingSetCorrectTypeExpiration(const ENUM_ORDER_TYPE_TIME type=ORDER_TIME_GTC,const string symbol_name=NULL);
   void                 TradingSetTypeExpiration(const ENUM_ORDER_TYPE_TIME type=ORDER_TIME_GTC,const string symbol_name=NULL);
   void                 TradingSetMagic(const uint magic,const string symbol_name=NULL);
   void                 TradingSetComment(const string comment,const string symbol_name=NULL);
   void                 TradingSetDeviation(const ulong deviation,const string symbol_name=NULL);
   void                 TradingSetVolume(const double volume=0,const string symbol_name=NULL);
   void                 TradingSetExpiration(const datetime expiration=0,const string symbol_name=NULL);
   void                 TradingSetAsyncMode(const bool async_mode=false,const string symbol_name=NULL);
   void                 TradingSetLogLevel(const ENUM_LOG_LEVEL log_level=LOG_LEVEL_ERROR_MSG,const string symbol_name=NULL);
   void                 TradingSetTotalTry(const uchar attempts)                       { this.m_trading.SetTotalTry(attempts);                     }
   
//--- Return the logging level of a trading class symbol trading object
   ENUM_LOG_LEVEL       TradingGetLogLevel(const string symbol_name)                   { return this.m_trading.GetTradeObjLogLevel(symbol_name);   }
   
//--- Set standard sounds (symbol==NULL) for a symbol trading object, (symbol!=NULL) for trading objects of all symbols
   void                 SetSoundsStandard(const string symbol=NULL)
                          {
                           this.m_trading.SetSoundsStandard(symbol);
                          }
//--- Set the flag of using sounds
   void                 SetUseSounds(const bool flag) { this.m_trading.SetUseSounds(flag);   }
//--- Set a sound for a specified order/position type and symbol. 'mode' specifies an event a sound is set for
//--- (symbol=NULL) for trading objects of all symbols, (symbol!=NULL) for a trading object of a specified symbol
   void                 SetSound(const ENUM_MODE_SET_SOUND mode,const ENUM_ORDER_TYPE action,const string sound,const string symbol=NULL)
                          {
                           this.m_trading.SetSound(mode,action,sound,symbol);
                          }
//--- Play a sound by its description
   bool                 PlaySoundByDescription(const string sound_description);

//--- Pass the pointers to all the necessary collections to the trading class and the indicator buffer collection class
   void                 CollectionOnInit(void)
                          {
                           this.m_trading.OnInit(this.GetAccountCurrent(),this.m_symbols.GetObject(),this.m_market.GetObject(),this.m_history.GetObject(),this.m_events.GetObject());
                           this.m_buffers.OnInit(this.m_time_series.GetObject(),this.m_indicators.GetObject());
                          }
//--- Set the spread multiplier for symbol trading objects in the symbol collection
   void                 SetSpreadMultiplier(const uint value=1,const string symbol=NULL)  { this.m_trading.SetSpreadMultiplier(value,symbol);   }

//--- Open (1) Buy, (2) Sell position
   template<typename SL,typename TP>
   bool                 OpenBuy(const double volume,
                                 const string symbol,
                                 const ulong magic=ULONG_MAX,
                                 SL sl=0,
                                 TP tp=0,
                                 const string comment=NULL,
                                 const ulong deviation=ULONG_MAX,
                                 const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
   template<typename SL,typename TP>
   bool                 OpenSell(const double volume,
                                 const string symbol,
                                 const ulong magic=ULONG_MAX,
                                 SL sl=0,
                                 TP tp=0,
                                 const string comment=NULL,
                                 const ulong deviation=ULONG_MAX,
                                 const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
//--- Modify a position
   template<typename SL,typename TP>
   bool                 ModifyPosition(const ulong ticket,const SL sl=WRONG_VALUE,const TP tp=WRONG_VALUE);
//--- Close a position (1) fully, (2) partially, (3) by an opposite one
   bool                 ClosePosition(const ulong ticket,const string comment=NULL,const ulong deviation=ULONG_MAX);
   bool                 ClosePositionPartially(const ulong ticket,const double volume,const string comment=NULL,const ulong deviation=ULONG_MAX);
   bool                 ClosePositionBy(const ulong ticket,const ulong ticket_by);
//--- Set (1) BuyStop, (2) BuyLimit, (3) BuyStopLimit pending order
   template<typename PR,typename SL,typename TP>
   bool                 PlaceBuyStop(const double volume,
                                     const string symbol,
                                     const PR price,
                                     const SL sl=0,
                                     const TP tp=0,
                                     const ulong magic=ULONG_MAX,
                                     const string comment=NULL,
                                     const datetime expiration=0,
                                     const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                     const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
   template<typename PR,typename SL,typename TP>
   bool                 PlaceBuyLimit(const double volume,
                                     const string symbol,
                                     const PR price,
                                     const SL sl=0,
                                     const TP tp=0,
                                     const ulong magic=ULONG_MAX,
                                     const string comment=NULL,
                                     const datetime expiration=0,
                                     const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                     const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
   template<typename PS,typename PL,typename SL,typename TP>
   bool                 PlaceBuyStopLimit(const double volume,
                                     const string symbol,
                                     const PS price_stop,
                                     const PL price_limit,
                                     const SL sl=0,
                                     const TP tp=0,
                                     const ulong magic=ULONG_MAX,
                                     const string comment=NULL,
                                     const datetime expiration=0,
                                     const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                     const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
//--- Set (1) SellStop, (2) SellLimit, (3) SellStopLimit pending order
   template<typename PR,typename SL,typename TP>
   bool                 PlaceSellStop(const double volume,
                                     const string symbol,
                                     const PR price,
                                     const SL sl=0,
                                     const TP tp=0,
                                     const ulong magic=ULONG_MAX,
                                     const string comment=NULL,
                                     const datetime expiration=0,
                                     const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                     const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
   template<typename PR,typename SL,typename TP>
   bool                 PlaceSellLimit(const double volume,
                                     const string symbol,
                                     const PR price,
                                     const SL sl=0,
                                     const TP tp=0,
                                     const ulong magic=ULONG_MAX,
                                     const string comment=NULL,
                                     const datetime expiration=0,
                                     const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                     const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
   template<typename PS,typename PL,typename SL,typename TP>
   bool                 PlaceSellStopLimit(const double volume,
                                     const string symbol,
                                     const PS price_stop,
                                     const PL price_limit,
                                     const SL sl=0,
                                     const TP tp=0,
                                     const ulong magic=ULONG_MAX,
                                     const string comment=NULL,
                                     const datetime expiration=0,
                                     const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                     const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
//--- Modify a pending order
   template<typename PR,typename SL,typename TP,typename PL>
   bool                 ModifyOrder(const ulong ticket,
                                    const PR price=WRONG_VALUE,
                                    const SL sl=WRONG_VALUE,
                                    const TP tp=WRONG_VALUE,
                                    const PL stoplimit=WRONG_VALUE,
                                    datetime expiration=WRONG_VALUE,
                                    const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                    const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
//--- Remove a pending order
   bool                 DeleteOrder(const ulong ticket);
   
//--- Create a pending request (1) to open Buy and (2) Sell positions
   template<typename SL,typename TP> 
   int                  OpenBuyPending(const double volume,
                                       const string symbol,
                                       const ulong magic=ULONG_MAX,
                                       const SL sl=0,
                                       const TP tp=0,
                                       const uchar group_id1=0,
                                       const uchar group_id2=0,
                                       const string comment=NULL,
                                       const ulong deviation=ULONG_MAX,
                                       const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
   template<typename SL,typename TP> 
   int                  OpenSellPending(const double volume,
                                       const string symbol,
                                       const ulong magic=ULONG_MAX,
                                       const SL sl=0,
                                       const TP tp=0,
                                       const uchar group_id1=0,
                                       const uchar group_id2=0,
                                       const string comment=NULL,
                                       const ulong deviation=ULONG_MAX,
                                       const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
                                       
//--- Create a pending request for closing a position (1) fully, (2) partially, (3) by an opposite one, (4) for removing an order
   int                  ClosePositionPending(const ulong ticket,const string comment=NULL,const ulong deviation=ULONG_MAX);
   int                  ClosePositionPartiallyPending(const ulong ticket,const double volume,const string comment=NULL,const ulong deviation=ULONG_MAX);
   int                  ClosePositionByPending(const ulong ticket,const ulong ticket_by);
   int                  DeleteOrderPending(const ulong ticket);

//--- Create a pending request to modify (1) a position, (2) an order
   template<typename SL,typename TP> 
   int                  ModifyPositionPending(const ulong ticket,const SL sl=WRONG_VALUE,const TP tp=WRONG_VALUE,const string comment=NULL);
   template<typename PR,typename SL,typename TP,typename PL>
   int                  ModifyOrderPending(const ulong ticket,
                                           const PR price=WRONG_VALUE,
                                           const SL sl=WRONG_VALUE,
                                           const TP tp=WRONG_VALUE,
                                           const PL stoplimit=WRONG_VALUE,
                                           datetime expiration=WRONG_VALUE,
                                           const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                           const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
                                   
//--- Create a pending request to place a (1) BuyLimit, (2) BuyStop and (3) BuyStopLimit order
   template<typename PR,typename SL,typename TP>
   int                  PlaceBuyLimitPending(const double volume,
                                             const string symbol,
                                             const PR price_set,
                                             const SL sl=0,
                                             const TP tp=0,
                                             const ulong magic=ULONG_MAX,
                                             const uchar group_id1=0,
                                             const uchar group_id2=0,
                                             const string comment=NULL,
                                             const datetime expiration=0,
                                             const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                             const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
   template<typename PR,typename SL,typename TP>
   int                  PlaceBuyStopPending( const double volume,
                                             const string symbol,
                                             const PR price_set,
                                             const SL sl=0,
                                             const TP tp=0,
                                             const ulong magic=ULONG_MAX,
                                             const uchar group_id1=0,
                                             const uchar group_id2=0,
                                             const string comment=NULL,
                                             const datetime expiration=0,
                                             const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                             const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
   template<typename PS,typename PL,typename SL,typename TP>
   int                  PlaceBuyStopLimitPending(const double volume,
                                             const string symbol,
                                             const PS price_stop,
                                             const PL price_limit,
                                             const SL sl=0,
                                             const TP tp=0,
                                             const ulong magic=ULONG_MAX,
                                             const uchar group_id1=0,
                                             const uchar group_id2=0,
                                             const string comment=NULL,
                                             const datetime expiration=0,
                                             const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                             const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);

//--- Create a pending request to place a (1) SellLimit, (2) SellStop, (3) SellStopLimit order
   template<typename PR,typename SL,typename TP>
   int                  PlaceSellLimitPending(const double volume,
                                             const string symbol,
                                             const PR price_set,
                                             const SL sl=0,
                                             const TP tp=0,
                                             const ulong magic=ULONG_MAX,
                                             const uchar group_id1=0,
                                             const uchar group_id2=0,
                                             const string comment=NULL,
                                             const datetime expiration=0,
                                             const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                             const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
   template<typename PR,typename SL,typename TP>
   int                  PlaceSellStopPending(const double volume,
                                             const string symbol,
                                             const PR price_set,
                                             const SL sl=0,
                                             const TP tp=0,
                                             const ulong magic=ULONG_MAX,
                                             const uchar group_id1=0,
                                             const uchar group_id2=0,
                                             const string comment=NULL,
                                             const datetime expiration=0,
                                             const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                             const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);
   template<typename PS,typename PL,typename SL,typename TP>
   int                  PlaceSellStopLimitPending(const double volume,
                                             const string symbol,
                                             const PS price_stop,
                                             const PL price_limit,
                                             const SL sl=0,
                                             const TP tp=0,
                                             const ulong magic=ULONG_MAX,
                                             const uchar group_id1=0,
                                             const uchar group_id2=0,
                                             const string comment=NULL,
                                             const datetime expiration=0,
                                             const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                             const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE);

//--- Set pending request activation criteria
   bool                 SetNewActivationProperties(const uchar id,
                                                   const ENUM_PEND_REQ_ACTIVATION_SOURCE source,
                                                   const int property,
                                                   const double control_value,
                                                   const ENUM_COMPARER_TYPE comparer_type,
                                                   const double actual_value);
                                                
//--- Return the pointer to the request object by its ID in the list
   CPendRequest        *GetPendRequestByID(const uchar id)              { return this.m_trading.GetPendRequestByID(id);       }

//--- Return event (1) milliseconds, (2) reason and (3) source from its 'long' value
   ushort               EventMSC(const long lparam)               const { return this.LongToUshortFromByte(lparam,0);         }
   ushort               EventReason(const long lparam)            const { return this.LongToUshortFromByte(lparam,1);         }
   ushort               EventSource(const long lparam)            const { return this.LongToUshortFromByte(lparam,2);         }

//--- Return the program name
   string               ProgramName(void)                         const { return this.m_name;                                 }

//--- Set the new (1) pause countdown start time and (2) pause in milliseconds
   void                 PauseSetTimeBegin(const ulong time)             { this.m_pause.SetTimeBegin(time);                    }
   void                 PauseSetWaitingMSC(const ulong pause)           { this.m_pause.SetWaitingMSC(pause);                  }
//--- Return (1) the time passed from the pause countdown start in milliseconds, (2) waiting completion flag,
//--- (3) pause countdown start time, (4) pause in milliseconds
   ulong                PausePassed(void)                         const { return this.m_pause.Passed();                       }
   bool                 PauseIsCompleted(void)                    const { return this.m_pause.IsCompleted();                  }
   ulong                PauseTimeBegin(void)                      const { return this.m_pause.TimeBegin();                    }
   ulong                PauseTimeWait(void)                       const { return this.m_pause.TimeWait();                     }
//--- Return the description (1) of the time passed till the countdown starts in milliseconds,
//--- (2) pause countdown start time, (3) pause in milliseconds
   string               PausePassedDescription(void)              const { return this.m_pause.PassedDescription();            }
   string               PauseTimeBeginDescription(void)           const { return this.m_pause.TimeBeginDescription();         }
   string               PauseWaitingMSCDescription(void)          const { return this.m_pause.WaitingMSCDescription();        }
   string               PauseWaitingSECDescription(void)          const { return this.m_pause.WaitingSECDescription();        }
//--- Launch the new pause countdown
   void                 Pause(const ulong pause_msc,const datetime time_start=0)
                          {
                           this.PauseSetWaitingMSC(pause_msc);
                           this.PauseSetTimeBegin(time_start*1000);
                           while(!this.PauseIsCompleted() && !::IsStopped()){}
                          }

//--- Return the (1) collection of graphical objects, the list of (2) existing and (3) removed graphical objects
   CGraphElementsCollection *GetGraphicObjCollection(void)              { return &this.m_graph_objects;                       }
   CArrayObj           *GetListStdGraphObj(void)                        { return this.m_graph_objects.GetListGraphObj();      }
   CArrayObj           *GetListDeletedObj(void)                         { return this.m_graph_objects.GetListDeletedObj();    }
//--- Return (1) the number of removed graphical objects and (2) the size of the property array
   int                  TotalDeletedGraphObjects(void)                  { return this.GetListDeletedObj().Total();            }
   int                  GraphGetSizeProperty(const string name,const long chart_id,const int prop)
                          {
                           return this.m_graph_objects.GetSizeProperty(name,chart_id,prop);
                          }
//--- Return the class of the object of the standard graphical object by chart name and ID
   CGStdGraphObj       *GraphGetStdGraphObject(const string name,const long chart_id)
                          {
                           CGStdGraphObj *obj=this.m_graph_objects.GetStdGraphObject(name,chart_id);
                           if(obj==NULL)
                              obj=this.m_graph_objects.GetStdGraphObject(this.ProgramName()+"_"+name,chart_id);
                           return obj;
                          }
//--- Return the class of the object of the extended standard graphical object by chart name and ID
   CGStdGraphObj       *GraphGetStdGraphObjectExt(const string name,const long chart_id)
                          {
                           CArrayObj *list=this.m_graph_objects.GetListStdGraphObjectExt();
                           string nm=(::StringFind(name,this.ProgramName()+"_")==WRONG_VALUE ? this.ProgramName()+"_"+name : name);
                           list=CSelect::ByGraphicStdObjectProperty(list,GRAPH_OBJ_PROP_NAME,0,nm,EQUAL);
                           return(list!=NULL ? list.At(0) : NULL);
                          }

//--- Return the list of graphical elements on canvas
   CArrayObj           *GetListCanvElement(void)                           { return this.m_graph_objects.GetListCanvElm();                }
//--- Add the graphical element on canvas to the collection
   bool                 GraphAddCanvElmToCollection(CGCnvElement *element) { return this.m_graph_objects.AddCanvElmToCollection(element); }
   
//--- Fill in the array with IDs of the charts opened in the terminal
   void              GraphGetArrayChartsID(long &array_charts_id[])
                       {
                        CArrayObj *list=this.m_graph_objects.GetListChartsControl();
                        if(list==NULL)
                           return;
                        ::ArrayResize(array_charts_id,list.Total());
                        ::ArrayInitialize(array_charts_id,WRONG_VALUE);
                        for(int i=0;i<list.Total();i++)
                          {
                           CChartObjectsControl *obj=list.At(i);
                           if(obj==NULL)
                              continue;
                           array_charts_id[i]=obj.ChartID();
                          }
                       }

//--- Create the "Vertical line" graphical object
   bool              CreateLineVertical(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time)
                       { return this.m_graph_objects.CreateLineVertical(chart_id,name,subwindow,extended,time); }
   bool              CreateLineVertical(const string name,const int subwindow,const bool extended,const datetime time)
                       { return this.m_graph_objects.CreateLineVertical(::ChartID(),name,subwindow,extended,time); }

//--- Create the "Horizontal line" graphical object
   bool              CreateLineHorizontal(const long chart_id,const string name,const int subwindow,const bool extended,const double price)
                       { return this.m_graph_objects.CreateLineHorizontal(chart_id,name,subwindow,extended,price); }
   bool              CreateLineHorizontal(const string name,const int subwindow,const bool extended,const double price)
                       { return this.m_graph_objects.CreateLineHorizontal(::ChartID(),name,subwindow,extended,price); }
 
//--- Create the "Trend line" graphical object
   bool              CreateLineTrend(const long chart_id,const string name,const int subwindow,const bool extended,
                                     const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateLineTrend(chart_id,name,subwindow,extended,time1,price1,time2,price2); }
   bool              CreateLineTrend(const string name,const int subwindow,const bool extended,
                                     const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateLineTrend(::ChartID(),name,subwindow,extended,time1,price1,time2,price2); }

//--- Create the "Trend line by angle" graphical object
   bool              CreateLineTrendByAngle(const long chart_id,const string name,const int subwindow,const bool extended,
                                            const datetime time1,const double price1,const datetime time2,const double price2,
                                            const double angle)
                       { return this.m_graph_objects.CreateLineTrendByAngle(chart_id,name,subwindow,extended,time1,price1,time2,price2,angle); }
   bool              CreateLineTrendByAngle(const string name,const int subwindow,const bool extended,
                                            const datetime time1,const double price1,const datetime time2,const double price2,
                                            const double angle)
                       { return this.m_graph_objects.CreateLineTrendByAngle(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,angle); }

//--- Create the "Cyclic lines" graphical object
   bool              CreateLineCycle(const long chart_id,const string name,const int subwindow,const bool extended,
                                     const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateLineCycle(chart_id,name,subwindow,extended,time1,price1,time2,price2); }
   bool              CreateLineCycle(const string name,const int subwindow,const bool extended,
                                     const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateLineCycle(::ChartID(),name,subwindow,extended,time1,price1,time2,price2); }

//--- Create the "Arrowed line" graphical object
   bool              CreateLineArrowed(const long chart_id,const string name,const int subwindow,const bool extended,
                                       const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateLineArrowed(chart_id,name,subwindow,extended,time1,price1,time2,price2); }
   bool              CreateLineArrowed(const string name,const int subwindow,const bool extended,
                                       const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateLineArrowed(::ChartID(),name,subwindow,extended,time1,price1,time2,price2); }

//--- Create the "Equidistant channel" graphical object
   bool              CreateChannel(const long chart_id,const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,
                                   const datetime time3,const double price3)
                       { return this.m_graph_objects.CreateChannel(chart_id,name,subwindow,extended,time1,price1,time2,price2,time3,price3); }
   bool              CreateChannel(const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,
                                   const datetime time3,const double price3)
                       { return this.m_graph_objects.CreateChannel(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,time3,price3); }

//--- Create the "Standard deviation channel" graphical object
   bool              CreateChannelStdDeviation(const long chart_id,const string name,const int subwindow,const bool extended,
                                               const datetime time1,const double price1,const datetime time2,const double price2,
                                               const double deviation=1.5)
                       { return this.m_graph_objects.CreateChannelStdDeviation(chart_id,name,subwindow,extended,time1,price1,time2,price2,deviation); }
   bool              CreateChannelStdDeviation(const string name,const int subwindow,const bool extended,
                                               const datetime time1,const double price1,const datetime time2,const double price2,
                                               const double deviation=1.5)
                       { return this.m_graph_objects.CreateChannelStdDeviation(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,deviation); }

//--- Create the "Linear regression channel" graphical object
   bool              CreateChannelRegression(const long chart_id,const string name,const int subwindow,const bool extended,
                                             const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateChannelRegression(chart_id,name,subwindow,extended,time1,price1,time2,price2); }
   bool              CreateChannelRegression(const string name,const int subwindow,const bool extended,
                                             const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateChannelRegression(::ChartID(),name,subwindow,extended,time1,price1,time2,price2); }

//--- Create the "Andrews' Pitchfork" graphical object
   bool              CreatePitchforkAndrews(const long chart_id,const string name,const int subwindow,const bool extended,
                                            const datetime time1,const double price1,const datetime time2,const double price2,
                                            const datetime time3,const double price3)
                       { return this.m_graph_objects.CreatePitchforkAndrews(chart_id,name,subwindow,extended,time1,price1,time2,price2,time3,price3); }
   bool              CreatePitchforkAndrews(const string name,const int subwindow,const bool extended,
                                            const datetime time1,const double price1,const datetime time2,const double price2,
                                            const datetime time3,const double price3)
                       { return this.m_graph_objects.CreatePitchforkAndrews(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,time3,price3); }

//--- Create the "Gann line" graphical object
   bool              CreateGannLine(const long chart_id,const string name,const int subwindow,const bool extended,
                                    const datetime time1,const double price1,const datetime time2,const double price2,const double angle)
                       { return this.m_graph_objects.CreateGannLine(chart_id,name,subwindow,extended,time1,price1,time2,price2,angle); }
   bool              CreateGannLine(const string name,const int subwindow,const bool extended,
                                    const datetime time1,const double price1,const datetime time2,const double price2,const double angle)
                       { return this.m_graph_objects.CreateGannLine(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,angle); }

//--- Create the "Gann fan" graphical object
   bool              CreateGannFan(const long chart_id,const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,
                                   const ENUM_GANN_DIRECTION direction,const double scale)
                       { return this.m_graph_objects.CreateGannFan(chart_id,name,subwindow,extended,time1,price1,time2,price2,direction,scale); }
   bool              CreateGannFan(const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,
                                   const ENUM_GANN_DIRECTION direction,const double scale)
                       { return this.m_graph_objects.CreateGannFan(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,direction,scale); }

//--- Create the "Gann grid" graphical object
   bool              CreateGannGrid(const long chart_id,const string name,const int subwindow,const bool extended,
                                    const datetime time1,const double price1,const datetime time2,
                                    const ENUM_GANN_DIRECTION direction,const double scale)
                       { return this.m_graph_objects.CreateGannGrid(chart_id,name,subwindow,extended,time1,price1,time2,direction,scale); }
   bool              CreateGannGrid(const string name,const int subwindow,const bool extended,
                                    const datetime time1,const double price1,const datetime time2,
                                    const ENUM_GANN_DIRECTION direction,const double scale)
                       { return this.m_graph_objects.CreateGannGrid(::ChartID(),name,subwindow,extended,time1,price1,time2,direction,scale); }

//--- Create the "Fibo levels" graphical object
   bool              CreateFiboLevels(const long chart_id,const string name,const int subwindow,const bool extended,
                                      const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateFiboLevels(chart_id,name,subwindow,extended,time1,price1,time2,price2); }
   bool              CreateFiboLevels(const string name,const int subwindow,const bool extended,
                                      const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateFiboLevels(::ChartID(),name,subwindow,extended,time1,price1,time2,price2); }

//--- Create the "Fibo Time Zones" graphical object
   bool              CreateFiboTimeZones(const long chart_id,const string name,const int subwindow,const bool extended,
                                         const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateFiboTimeZones(chart_id,name,subwindow,extended,time1,price1,time2,price2); }
   bool              CreateFiboTimeZones(const string name,const int subwindow,const bool extended,
                                         const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateFiboTimeZones(::ChartID(),name,subwindow,extended,time1,price1,time2,price2); }

//--- Create the "Fibo fan" graphical object
   bool              CreateFiboFan(const long chart_id,const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateFiboFan(chart_id,name,subwindow,extended,time1,price1,time2,price2); }
   bool              CreateFiboFan(const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateFiboFan(::ChartID(),name,subwindow,extended,time1,price1,time2,price2); }

//--- Create the "Fibo arc" graphical object
   bool              CreateFiboArc(const long chart_id,const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,
                                   const double scale,const bool ellipse)
                       { return this.m_graph_objects.CreateFiboArc(chart_id,name,subwindow,extended,time1,price1,time2,price2,scale,ellipse); }
   bool              CreateFiboArc(const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,
                                   const double scale,const bool ellipse)
                       { return this.m_graph_objects.CreateFiboArc(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,scale,ellipse); }

//--- Create the "Fibo channel" graphical object
   bool              CreateFiboChannel(const long chart_id,const string name,const int subwindow,const bool extended,
                                       const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       { return this.m_graph_objects.CreateFiboChannel(chart_id,name,subwindow,extended,time1,price1,time2,price2,time3,price3); }
   bool              CreateFiboChannel(const string name,const int subwindow,const bool extended,
                                       const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       { return this.m_graph_objects.CreateFiboChannel(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,time3,price3); }

//--- Create the "Fibo extension" graphical object
   bool              CreateFiboExpansion(const long chart_id,const string name,const int subwindow,const bool extended,
                                         const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       { return this.m_graph_objects.CreateFiboExpansion(chart_id,name,subwindow,extended,time1,price1,time2,price2,time3,price3); }
   bool              CreateFiboExpansion(const string name,const int subwindow,const bool extended,
                                         const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       { return this.m_graph_objects.CreateFiboExpansion(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,time3,price3); }

//--- Create the "Elliott 5 waves" graphical object
   bool              CreateElliothWave5(const long chart_id,const string name,const int subwindow,const bool extended,
                                        const datetime time1,const double price1,const datetime time2,const double price2,
                                        const datetime time3,const double price3,const datetime time4,const double price4,
                                        const datetime time5,const double price5,const ENUM_ELLIOT_WAVE_DEGREE degree,
                                        const bool draw_lines)
                       { return this.m_graph_objects.CreateElliothWave5(chart_id,name,subwindow,extended,time1,price1,time2,price2,time3,price3,time4,price4,time5,price5,degree,draw_lines); }
   bool              CreateElliothWave5(const string name,const int subwindow,const bool extended,
                                        const datetime time1,const double price1,const datetime time2,const double price2,
                                        const datetime time3,const double price3,const datetime time4,const double price4,
                                        const datetime time5,const double price5,const ENUM_ELLIOT_WAVE_DEGREE degree,
                                        const bool draw_lines)
                       { return this.m_graph_objects.CreateElliothWave5(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,time3,price3,time4,price4,time5,price5,degree,draw_lines); }

//--- Create the "Elliott 3 waves" graphical object
   bool              CreateElliothWave3(const long chart_id,const string name,const int subwindow,const bool extended,
                                        const datetime time1,const double price1,const datetime time2,
                                        const double price2,const datetime time3,const double price3,
                                        const ENUM_ELLIOT_WAVE_DEGREE degree,const bool draw_lines)
                       { return this.m_graph_objects.CreateElliothWave3(chart_id,name,subwindow,extended,time1,price1,time2,price2,time3,price3,degree,draw_lines); }
   bool              CreateElliothWave3(const string name,const int subwindow,const bool extended,
                                        const datetime time1,const double price1,const datetime time2,
                                        const double price2,const datetime time3,const double price3,
                                        const ENUM_ELLIOT_WAVE_DEGREE degree,const bool draw_lines)
                       { return this.m_graph_objects.CreateElliothWave3(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,time3,price3,degree,draw_lines); }

//--- Create the Rectangle graphical object
   bool              CreateRectangle(const long chart_id,const string name,const int subwindow,const bool extended,
                                     const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateRectangle(chart_id,name,subwindow,extended,time1,price1,time2,price2); }
   bool              CreateRectangle(const string name,const int subwindow,const bool extended,
                                     const datetime time1,const double price1,const datetime time2,const double price2)
                       { return this.m_graph_objects.CreateRectangle(::ChartID(),name,subwindow,extended,time1,price1,time2,price2); }

//--- Create the Triangle graphical object
   bool              CreateTriangle(const long chart_id,const string name,const int subwindow,const bool extended,
                                    const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       { return this.m_graph_objects.CreateTriangle(chart_id,name,subwindow,extended,time1,price1,time2,price2,time3,price3); }
   bool              CreateTriangle(const string name,const int subwindow,const bool extended,
                                    const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       { return this.m_graph_objects.CreateTriangle(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,time3,price3); }

//--- Create the Ellipse graphical object
   bool              CreateEllipse(const long chart_id,const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       { return this.m_graph_objects.CreateEllipse(chart_id,name,subwindow,extended,time1,price1,time2,price2,time3,price3); }
   bool              CreateEllipse(const string name,const int subwindow,const bool extended,
                                   const datetime time1,const double price1,const datetime time2,const double price2,const datetime time3,const double price3)
                       { return this.m_graph_objects.CreateEllipse(::ChartID(),name,subwindow,extended,time1,price1,time2,price2,time3,price3); }

//--- Create the "Thumb up" graphical object
   bool              CreateThumbUp(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateThumbUp(chart_id,name,subwindow,extended,time,price); }
   bool              CreateThumbUp(const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateThumbUp(::ChartID(),name,subwindow,extended,time,price); }

//--- Create the "Thumb down" graphical object
   bool              CreateThumbDown(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateThumbDown(chart_id,name,subwindow,extended,time,price); }
   bool              CreateThumbDown(const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateThumbDown(::ChartID(),name,subwindow,extended,time,price); }

//--- Create the "Arrow up" graphical object
   bool              CreateArrowUp(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateArrowUp(chart_id,name,subwindow,extended,time,price); }
   bool              CreateArrowUp(const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateArrowUp(::ChartID(),name,subwindow,extended,time,price); }

//--- Create the "Arrow down" graphical object
   bool              CreateArrowDown(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateArrowDown(chart_id,name,subwindow,extended,time,price); }
   bool              CreateArrowDown(const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateArrowDown(::ChartID(),name,subwindow,extended,time,price); }

//--- Create the Stop graphical object
   bool              CreateSignalStop(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateSignalStop(chart_id,name,subwindow,extended,time,price); }
   bool              CreateSignalStop(const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateSignalStop(::ChartID(),name,subwindow,extended,time,price); }

//--- Create the "Check mark" graphical object
   bool              CreateSignalCheck(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateSignalCheck(chart_id,name,subwindow,extended,time,price); }
   bool              CreateSignalCheck(const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateSignalCheck(::ChartID(),name,subwindow,extended,time,price); }

//--- Create the "Left price label" graphical object
   bool              CreatePriceLabelLeft(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreatePriceLabelLeft(chart_id,name,subwindow,extended,time,price); }
   bool              CreatePriceLabelLeft(const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreatePriceLabelLeft(::ChartID(),name,subwindow,extended,time,price); }

//--- Create the "Right price label" graphical object
   bool              CreatePriceLabelRight(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreatePriceLabelRight(chart_id,name,subwindow,extended,time,price); }
   bool              CreatePriceLabelRight(const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreatePriceLabelRight(::ChartID(),name,subwindow,extended,time,price); }

//--- Create the Buy graphical object
   bool              CreateSignalBuy(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateSignalBuy(chart_id,name,subwindow,extended,time,price); }
   bool              CreateSignalBuy(const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateSignalBuy(::ChartID(),name,subwindow,extended,time,price); }

//--- Create the Sell graphical object
   bool              CreateSignalSell(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateSignalSell(chart_id,name,subwindow,extended,time,price); }
   bool              CreateSignalSell(const string name,const int subwindow,const bool extended,const datetime time,const double price)
                       { return this.m_graph_objects.CreateSignalSell(::ChartID(),name,subwindow,extended,time,price); }

//--- Create the Arrow graphical object
   bool              CreateArrow(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price,
                                 const uchar arrow_code,const ENUM_ARROW_ANCHOR anchor)
                       { return this.m_graph_objects.CreateArrow(chart_id,name,subwindow,extended,time,price,arrow_code,anchor); }
   bool              CreateArrow(const string name,const int subwindow,const bool extended,const datetime time,const double price,
                                 const uchar arrow_code,const ENUM_ARROW_ANCHOR anchor)
                       { return this.m_graph_objects.CreateArrow(::ChartID(),name,subwindow,extended,time,price,arrow_code,anchor); }

//--- Create the Text graphical object
   bool              CreateText(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price,
                                const string text,const int size,const ENUM_ANCHOR_POINT anchor_point,const double angle)
                       { return this.m_graph_objects.CreateText(chart_id,name,subwindow,extended,time,price,text,size,anchor_point,angle); }
   bool              CreateText(const string name,const int subwindow,const bool extended,const datetime time,const double price,
                                const string text,const int size,const ENUM_ANCHOR_POINT anchor_point,const double angle)
                       { return this.m_graph_objects.CreateText(::ChartID(),name,subwindow,extended,time,price,text,size,anchor_point,angle); }

//--- Create the "Text label" graphical object
   bool              CreateTextLabel(const long chart_id,const string name,const int subwindow,const bool extended,const int x,const int y,
                                     const string text,const int size,const ENUM_BASE_CORNER corner,
                                     const ENUM_ANCHOR_POINT anchor_point,const double angle)
                       { return this.m_graph_objects.CreateTextLabel(chart_id,name,subwindow,extended,x,y,text,size,corner,anchor_point,angle); }
   bool              CreateTextLabel(const string name,const int subwindow,const bool extended,const int x,const int y,
                                     const string text,const int size,const ENUM_BASE_CORNER corner,
                                     const ENUM_ANCHOR_POINT anchor_point,const double angle)
                       { return this.m_graph_objects.CreateTextLabel(::ChartID(),name,subwindow,extended,x,y,text,size,corner,anchor_point,angle); }

//--- Create the Button graphical object
   bool              CreateButton(const long chart_id,const string name,const int subwindow,const bool extended,const int x,const int y,const int w,const int h,
                                  const ENUM_BASE_CORNER corner,const int font_size,const bool button_state)
                       { return this.m_graph_objects.CreateButton(chart_id,name,subwindow,extended,x,y,w,h,corner,font_size,button_state); }
   bool              CreateButton(const string name,const int subwindow,const bool extended,const int x,const int y,const int w,const int h,
                                  const ENUM_BASE_CORNER corner,const int font_size,const bool button_state)
                       { return this.m_graph_objects.CreateButton(::ChartID(),name,subwindow,extended,x,y,w,h,corner,font_size,button_state); }

//--- Create the Chart graphical object
   bool              CreateChart(const long chart_id,const string name,const int subwindow,const bool extended,const int x,const int y,const int w,const int h,
                                 const ENUM_BASE_CORNER corner,const int scale,const string symbol,const ENUM_TIMEFRAMES timeframe)
                       { return this.m_graph_objects.CreateChart(chart_id,name,subwindow,extended,x,y,w,h,corner,scale,symbol,timeframe); }
   bool              CreateChart(const string name,const int subwindow,const bool extended,const int x,const int y,const int w,const int h,
                                 const ENUM_BASE_CORNER corner,const int scale,const string symbol,const ENUM_TIMEFRAMES timeframe)
                       { return this.m_graph_objects.CreateChart(::ChartID(),name,subwindow,extended,x,y,w,h,corner,scale,symbol,timeframe); }

//--- Create the Bitmap graphical object
   bool              CreateBitmap(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time,const double price,
                                  const string image1,const string image2,const ENUM_ANCHOR_POINT anchor)
                       { return this.m_graph_objects.CreateBitmap(chart_id,name,subwindow,extended,time,price,image1,image2,anchor); }
   bool              CreateBitmap(const string name,const int subwindow,const bool extended,const datetime time,const double price,
                                  const string image1,const string image2,const ENUM_ANCHOR_POINT anchor)
                       { return this.m_graph_objects.CreateBitmap(::ChartID(),name,subwindow,extended,time,price,image1,image2,anchor); }

//--- Create the "Bitmap label" graphical object
   bool              CreateBitmapLabel(const long chart_id,const string name,const int subwindow,const bool extended,const int x,const int y,const int w,const int h,
                                       const string image1,const string image2,const ENUM_BASE_CORNER corner,const ENUM_ANCHOR_POINT anchor,
                                       const bool state)
                       { return this.m_graph_objects.CreateBitmapLabel(chart_id,name,subwindow,extended,x,y,w,h,image1,image2,corner,anchor,state); }
   bool              CreateBitmapLabel(const string name,const int subwindow,const bool extended,const int x,const int y,const int w,const int h,
                                       const string image1,const string image2,const ENUM_BASE_CORNER corner,const ENUM_ANCHOR_POINT anchor,
                                       const bool state)
                       { return this.m_graph_objects.CreateBitmapLabel(::ChartID(),name,subwindow,extended,x,y,w,h,image1,image2,corner,anchor,state); }

//--- Create the "Input field" graphical object
   bool              CreateEditField(const long chart_id,const string name,const int subwindow,const bool extended,const int x,const int y,const int w,const int h,
                                     const int font_size,const ENUM_BASE_CORNER corner,const ENUM_ALIGN_MODE align,const bool readonly)
                       { return this.m_graph_objects.CreateEditField(chart_id,name,subwindow,extended,x,y,w,h,font_size,corner,align,readonly); }
   bool              CreateEditField(const string name,const int subwindow,const bool extended,const int x,const int y,const int w,const int h,
                                     const int font_size,const ENUM_BASE_CORNER corner,const ENUM_ALIGN_MODE align,const bool readonly)
                       { return this.m_graph_objects.CreateEditField(::ChartID(),name,subwindow,extended,x,y,w,h,font_size,corner,align,readonly); }

//--- Create the "Economic calendar event" graphical object
   bool              CreateCalendarEvent(const long chart_id,const string name,const int subwindow,const bool extended,const datetime time)
                       { return this.m_graph_objects.CreateCalendarEvent(chart_id,name,subwindow,extended,time); }
   bool              CreateCalendarEvent(const string name,const int subwindow,const bool extended,const datetime time)
                       { return this.m_graph_objects.CreateCalendarEvent(::ChartID(),name,subwindow,extended,time); }

//--- Create the "Rectangular label" graphical object
   bool              CreateRectangleLabel(const long chart_id,const string name,const int subwindow,const bool extended,const int x,const int y,const int w,const int h,
                                          const ENUM_BASE_CORNER corner,const ENUM_BORDER_TYPE border)
                       { return this.m_graph_objects.CreateRectangleLabel(chart_id,name,subwindow,extended,x,y,w,h,corner,border); }
   bool              CreateRectangleLabel(const string name,const int subwindow,const bool extended,const int x,const int y,const int w,const int h,
                                          const ENUM_BASE_CORNER corner,const ENUM_BORDER_TYPE border)
                       { return this.m_graph_objects.CreateRectangleLabel(::ChartID(),name,subwindow,extended,x,y,w,h,corner,border); }

//--- Constructor/destructor
                        CEngine();
                       ~CEngine();

private:
//--- Convert the value of 0 - 15 into the necessary uchar number bits (0 - lower, 1 - upper ones)
   uchar                ConvToXX(const uchar number,const uchar index)  const { return((number>15 ? 15 : number)<<(4*(index>1 ? 1 : index)));   }

public:
//--- Create and return the composite magic number from the specified magic number value, the first and second group IDs and the pending request ID
   uint                 SetCompositeMagicNumber(ushort magic_id,const uchar group_id1=0,const uchar group_id2=0,const uchar pending_req_id=0);

//--- Handling DoEasy library events
void                    OnDoEasyEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
//--- Working with events in the tester
void                    EventsHandling(void);

  };
//+------------------------------------------------------------------+
//| CEngine constructor                                              |
//+------------------------------------------------------------------+
CEngine::CEngine() : m_first_start(true),
                     m_last_trade_event(TRADE_EVENT_NO_EVENT),
                     m_last_account_event(WRONG_VALUE),
                     m_last_symbol_event(WRONG_VALUE),
                     m_global_error(ERR_SUCCESS)
  {
   this.m_is_hedge=#ifdef __MQL4__ true #else bool(::AccountInfoInteger(ACCOUNT_MARGIN_MODE)==ACCOUNT_MARGIN_MODE_RETAIL_HEDGING) #endif;
   this.m_is_tester=::MQLInfoInteger(MQL_TESTER);
   this.m_program=(ENUM_PROGRAM_TYPE)::MQLInfoInteger(MQL_PROGRAM_TYPE);
   this.m_name=::MQLInfoString(MQL_PROGRAM_NAME);
   
   this.m_list_counters.Sort();
   this.m_list_counters.Clear();
   this.CreateCounter(COLLECTION_ORD_COUNTER_ID,COLLECTION_ORD_COUNTER_STEP,COLLECTION_ORD_PAUSE);
   this.CreateCounter(COLLECTION_ACC_COUNTER_ID,COLLECTION_ACC_COUNTER_STEP,COLLECTION_ACC_PAUSE);
   this.CreateCounter(COLLECTION_SYM_COUNTER_ID1,COLLECTION_SYM_COUNTER_STEP1,COLLECTION_SYM_PAUSE1);
   this.CreateCounter(COLLECTION_SYM_COUNTER_ID2,COLLECTION_SYM_COUNTER_STEP2,COLLECTION_SYM_PAUSE2);
   this.CreateCounter(COLLECTION_REQ_COUNTER_ID,COLLECTION_REQ_COUNTER_STEP,COLLECTION_REQ_PAUSE);
   this.CreateCounter(COLLECTION_TS_COUNTER_ID,COLLECTION_TS_COUNTER_STEP,COLLECTION_TS_PAUSE);
   this.CreateCounter(COLLECTION_IND_TS_COUNTER_ID,COLLECTION_IND_TS_COUNTER_STEP,COLLECTION_IND_TS_PAUSE);
   this.CreateCounter(COLLECTION_TICKS_COUNTER_ID,COLLECTION_TICKS_COUNTER_STEP,COLLECTION_TICKS_PAUSE);
   this.CreateCounter(COLLECTION_CHARTS_COUNTER_ID,COLLECTION_CHARTS_COUNTER_STEP,COLLECTION_CHARTS_PAUSE);
   this.CreateCounter(COLLECTION_GRAPH_OBJ_COUNTER_ID,COLLECTION_GRAPH_OBJ_COUNTER_STEP,COLLECTION_GRAPH_OBJ_PAUSE);
   
   ::ResetLastError();
   #ifdef __MQL5__
      if(!::EventSetMillisecondTimer(TIMER_FREQUENCY))
        {
         ::Print(DFUN_ERR_LINE,CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_TIMER),(string)::GetLastError());
         this.m_global_error=::GetLastError();
        }
   //---__MQL4__
   #else 
      if(!this.IsTester() && !::EventSetMillisecondTimer(TIMER_FREQUENCY))
        {
         ::Print(DFUN_ERR_LINE,CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_TIMER),(string)::GetLastError());
         this.m_global_error=::GetLastError();
        }
   #endif 
   //---
  }
//+------------------------------------------------------------------+
//| CEngine destructor                                               |
//+------------------------------------------------------------------+
CEngine::~CEngine()
  {
   ::EventKillTimer();
   ::Comment("");
  }
//+------------------------------------------------------------------+
//| CEngine timer                                                    |
//+------------------------------------------------------------------+
void CEngine::OnTimer(SDataCalculate &data_calculate)
  {
//--- If this is not a tester, work with collection events by timer
   if(!this.IsTester())
     {
   //--- Timer of the collections of historical orders and deals, as well as of market orders and positions
      int index=this.CounterIndex(COLLECTION_ORD_COUNTER_ID);
      CTimerCounter* cnt1=this.m_list_counters.At(index);
      if(cnt1!=NULL)
        {
         //--- If unpaused, work with the order, deal and position collections events
         if(cnt1.IsTimeDone())
            this.TradeEventsControl();
        }
   //--- Account collection timer
      index=this.CounterIndex(COLLECTION_ACC_COUNTER_ID);
      CTimerCounter* cnt2=this.m_list_counters.At(index);
      if(cnt2!=NULL)
        {
         //--- If unpaused, work with the account collection events
         if(cnt2.IsTimeDone())
            this.AccountEventsControl();
        }
   //--- Timer 1 of the symbol collection (updating symbol quote data in the collection)
      index=this.CounterIndex(COLLECTION_SYM_COUNTER_ID1);
      CTimerCounter* cnt3=this.m_list_counters.At(index);
      if(cnt3!=NULL)
        {
         //--- If the pause is over, update quote data of all symbols in the collection
         if(cnt3.IsTimeDone())
            this.m_symbols.RefreshRates();
        }
   //--- Timer 2 of the symbol collection (updating all data of all symbols in the collection and tracking symbl and symbol search events in the market watch window)
      index=this.CounterIndex(COLLECTION_SYM_COUNTER_ID2);
      CTimerCounter* cnt4=this.m_list_counters.At(index);
      if(cnt4!=NULL)
        {
         //--- If the pause is over
         if(cnt4.IsTimeDone())
           {
            //--- update data and work with events of all symbols in the collection
            this.SymbolEventsControl();
            //--- When working with the market watch list, check the market watch window events
            if(this.m_symbols.ModeSymbolsList()==SYMBOLS_MODE_MARKET_WATCH)
               this.MarketWatchEventsControl();
           }
        }
   //--- Trading class timer
      index=this.CounterIndex(COLLECTION_REQ_COUNTER_ID);
      CTimerCounter* cnt5=this.m_list_counters.At(index);
      if(cnt5!=NULL)
        {
         //--- If unpaused, work with the list of pending requests
         if(cnt5.IsTimeDone())
            this.m_trading.OnTimer();
        }
   //--- Timeseries collection timer
      index=this.CounterIndex(COLLECTION_TS_COUNTER_ID);
      CTimerCounter* cnt6=this.m_list_counters.At(index);
      if(cnt6!=NULL)
        {
         //--- If the pause is over, work with the timeseries list (update all except the current one)
         if(cnt6.IsTimeDone())
            this.SeriesRefreshAllExceptCurrent(data_calculate);
        }
        
   //--- Timer of timeseries collection of indicator buffer data
      index=this.CounterIndex(COLLECTION_IND_TS_COUNTER_ID);
      CTimerCounter* cnt7=this.m_list_counters.At(index);
      if(cnt7!=NULL)
        {
         //--- If the pause is over, work with the timeseries list of indicator data (update all except for the current one)
         if(cnt7.IsTimeDone()) 
            this.IndicatorSeriesRefreshAll();
        }
   //--- Tick series collection timer
      index=this.CounterIndex(COLLECTION_TICKS_COUNTER_ID);
      CTimerCounter* cnt8=this.m_list_counters.At(index);
      if(cnt8!=NULL)
        {
         //--- If the pause is over, work with the tick series list (update all except the current one)
         if(cnt8.IsTimeDone())
            this.TickSeriesRefreshAllExceptCurrent();
        }
   //--- Chart collection timer
      index=this.CounterIndex(COLLECTION_CHARTS_COUNTER_ID);
      CTimerCounter* cnt9=this.m_list_counters.At(index);
      if(cnt9!=NULL)
        {
         //--- If unpaused, work with the chart list
         if(cnt9.IsTimeDone())
            this.ChartsRefreshAll();
        }
        
   //--- Graphical objects collection timer
      index=this.CounterIndex(COLLECTION_GRAPH_OBJ_COUNTER_ID);
      CTimerCounter* cnt10=this.m_list_counters.At(index);
      if(cnt10!=NULL)
        {
         //--- If unpaused, work with the list of graphical objects
         if(cnt10.IsTimeDone())
            this.GraphObjEventsControl();
        }
        
     }
//--- If this is a tester, work with collection events by tick
   else
     {
      //--- work with events of collections of orders, deals and positions by tick
      this.TradeEventsControl();
      //--- work with events of collections of accounts by tick
      this.AccountEventsControl();
      //--- update quote data of all collection symbols by tick
      this.m_symbols.RefreshRates();
      //--- work with events of all symbols in the collection by tick
      this.SymbolEventsControl();
      //--- work with the list of pending orders by tick
      this.m_trading.OnTimer();
      //--- work with the timeseries list by tick
      this.SeriesRefresh(data_calculate);
      //--- work with the timeseries list of indicator buffers by tick
      this.IndicatorSeriesRefreshAll();
      //--- work with the list of tick series by tick
      this.TickSeriesRefreshAll();
      //--- work with the list of graphical objects by tick
      this.GraphObjEventsControl();
     }
  }
//+------------------------------------------------------------------+
//| NewTick event handler                                            |
//+------------------------------------------------------------------+
void CEngine::OnTick(SDataCalculate &data_calculate,const uint required=0)
  {
//--- If this is not a EA, exit
   if(this.m_program!=PROGRAM_EXPERT)
      return;
//--- Re-create empty timeseries and update the current symbol timeseries
   this.SeriesSync(data_calculate,required);
   this.SeriesRefresh(NULL,data_calculate);
   this.TickSeriesRefresh(NULL);
//--- end
  }
//+------------------------------------------------------------------+
//| Calculate event handler                                          |
//+------------------------------------------------------------------+
int CEngine::OnCalculate(SDataCalculate &data_calculate,const uint required=0)
  {
//--- If this is not an indicator, exit
   if(this.m_program!=PROGRAM_INDICATOR)
      return 0;
//--- Re-create empty timeseries
//--- If at least one of the timeseries is not synchronized, return zero
   if(!this.SeriesSync(data_calculate,required))
      return 0;
//--- Update the timeseries of the current symbol (not in the tester) and
//--- return either 0 (in case there are empty timeseries), or rates_total
   if(!this.IsTester())
      this.SeriesRefresh(NULL,data_calculate);
   int res=(this.SeriesGetSeriesEmpty()==NULL ? data_calculate.rates_total : 0);
   
//--- Check the amount of calculated standard indicator data
   CArrayObj *list=m_buffers.GetListBuffersWithID();
   if(list!=NULL)
     {
      //--- In a loop by the number of buffers having an ID
      int total=list.Total();
      for(int i=0;i<total;i++)
        {
         //--- get the next calculated buffer using the standard indicator
         CBuffer *buff=list.At(i);
         if(buff==NULL || buff.TypeBuffer()==BUFFER_TYPE_DATA || buff.IndicatorHandle()==INVALID_HANDLE)
            continue;
         //--- if the indicator data is not calculated yet, return zero
         if(buff.IndicatorBarsCalculated()==WRONG_VALUE)
            return 0;
        }
     }
   return res;
  }
//+------------------------------------------------------------------+
//| BookEvent event handler                                          |
//+------------------------------------------------------------------+
bool CEngine::OnBookEvent(const string &symbol)
  {
   CSymbol *sym=this.m_symbols.GetSymbolObjByName(symbol);
   if(sym==NULL)
      return false;
   return this.m_book_series.Refresh(sym.Name(),sym.Time());
  }
//+------------------------------------------------------------------+
//| Synchronize timeseries data with the server                      |
//+------------------------------------------------------------------+
bool CEngine::SeriesSync(SDataCalculate &data_calculate,const uint required=0)
  {
//--- If the timeseries data is not calculated, try re-creating the timeseries
   static bool clear=true;
//--- Get the pointer to the empty timeseries
   CSeriesDE *series=this.SeriesGetSeriesEmpty();
//--- If there is an empty timeseries
   if(series!=NULL)
     {
      //--- Display the empty timeseries data as a chart comment and try synchronizing the timeseries with the server data
      ::Comment(series.Header(),": ",CMessage::Text(MSG_LIB_TEXT_TS_TEXT_WAIT_FOR_SYNC));
      ::ChartRedraw(::ChartID());
      //--- if the data has been synchronized
      if(series.SyncData(required,data_calculate.rates_total))
        {
         //--- if managed to re-create the timeseries
         if(this.m_time_series.ReCreateSeries(series.Symbol(),series.Timeframe(),data_calculate.rates_total))
           {
            //--- display the chart comment and the journal entry with the re-created timeseries data
            ::Comment(series.Header(),": OK");
            ::ChartRedraw(::ChartID());
            Print(series.Header()," ",CMessage::Text(MSG_LIB_TEXT_TS_TEXT_CREATED_OK),":");
            series.PrintShort();
            return true;
           }
        }
      //--- Data is not yet synchronized or failed to re-create the timeseries
      return false;
     }
//--- There are no empty timeseries - all is synchronized, delete all comments
   else
     {
      if(clear)
        {
         ::Comment("");
         ::ChartRedraw(::ChartID());
         clear=false;
        }
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Create the timer counter                                         |
//+------------------------------------------------------------------+
void CEngine::CreateCounter(const int id,const ulong step,const ulong pause)
  {
   if(this.CounterIndex(id)>WRONG_VALUE)
     {
      ::Print(CMessage::Text(MSG_LIB_SYS_ERROR_ALREADY_CREATED_COUNTER),(string)id);
      return;
     }
   m_list_counters.Sort();
   CTimerCounter* counter=new CTimerCounter(id);
   if(counter==NULL)
      ::Print(CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_COUNTER),(string)id);
   counter.SetParams(step,pause);
   if(this.m_list_counters.Search(counter)==WRONG_VALUE)
      this.m_list_counters.Add(counter);
   else
     {
      string t1=CMessage::Text(MSG_LIB_TEXT_ERROR_COUNTER_WITN_ID)+(string)id;
      string t2=CMessage::Text(MSG_LIB_TEXT_STEP)+(string)step;
      string t3=CMessage::Text(MSG_LIB_TEXT_AND_PAUSE)+(string)pause;
      ::Print(t1+t2+t3+CMessage::Text(MSG_LIB_TEXT_ALREADY_EXISTS));
      delete counter;
     }
  }
//+------------------------------------------------------------------+
//| Return the counter index by ID                                   |
//+------------------------------------------------------------------+
int CEngine::CounterIndex(const int id) const
  {
   int total=this.m_list_counters.Total();
   for(int i=0;i<total;i++)
     {
      CTimerCounter* counter=this.m_list_counters.At(i);
      if(counter==NULL) continue;
      if(counter.Type()==id) 
         return i;
     }
   return WRONG_VALUE;
  }
//+------------------------------------------------------------------+
//| Return the first launch flag, reset the flag                     |
//+------------------------------------------------------------------+
bool CEngine::IsFirstStart(void)
  {
   if(this.m_first_start)
     {
      this.m_first_start=false;
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Check trading events                                             |
//+------------------------------------------------------------------+
void CEngine::TradeEventsControl(void)
  {
//--- Initialize trading events' flags
   this.m_is_market_trade_event=false;
   this.m_is_history_trade_event=false;
   this.m_events.SetEventFlag(false);
//--- Update the lists 
   this.m_market.Refresh();
   this.m_history.Refresh();
//--- First launch actions
   if(this.IsFirstStart())
     {
      this.m_last_trade_event=TRADE_EVENT_NO_EVENT;
      return;
     }
//--- Check the changes in the market status and account history 
   this.m_is_market_trade_event=this.m_market.IsTradeEvent();
   this.m_is_history_trade_event=this.m_history.IsTradeEvent();

//--- If there is any event, send the lists, the flags and the number of new orders and deals to the event collection, and update it
   int change_total=0;
   CArrayObj* list_changes=this.m_market.GetListChanges();
   if(list_changes!=NULL)
      change_total=list_changes.Total();
   if(this.m_is_history_trade_event || this.m_is_market_trade_event || change_total>0)
     {
      this.m_events.Refresh(this.m_history.GetList(),this.m_market.GetList(),list_changes,this.m_market.GetListControl(),
                            this.m_is_history_trade_event,this.m_is_market_trade_event,
                            this.m_history.NewOrders(),this.m_market.NewPendingOrders(),
                            this.m_market.NewPositions(),this.m_history.NewDeals(),
                            this.m_market.ChangedVolumeValue());
      //--- Receive the last account trading event
      this.m_last_trade_event=this.m_events.GetLastTradeEvent();
     }
  }
//+------------------------------------------------------------------+
//| Check account events                                             |
//+------------------------------------------------------------------+
void CEngine::AccountEventsControl(void)
  {
//--- Check account property changes and set the flag of the account change events
   this.m_accounts.RefreshAndEventsControl();
   this.m_is_account_event=this.m_accounts.IsEvent();
//--- If there are account property changes
   if(this.m_is_account_event)
     {
      //--- Get the last event of the account property change
      this.m_last_account_event=this.m_accounts.GetEventID();
     }
  }
//+------------------------------------------------------------------+
//| Check the events of graphical objects                            |
//+------------------------------------------------------------------+
void CEngine::GraphObjEventsControl(void)
  {
//--- Check the changes in the list of graphical objects and set the flag of their events
   this.m_graph_objects.Refresh();
   this.m_is_graph_obj_event=this.m_graph_objects.IsEvent();
//--- If there are changes in the list of graphical objects
   if(this.m_is_graph_obj_event)
     {
      Print(DFUN,"Graph obj is event. NewObjects: ",m_graph_objects.NewObjects());
      //--- Get the last event of the graphical object property change
      // ...
     }
  }
//+------------------------------------------------------------------+
//| Set the list of used symbols in the symbol collection            |
//| and create the collections of timeseries, tick series            |
//| and symbol DOM series                                            |
//+------------------------------------------------------------------+
bool CEngine::SetUsedSymbols(const string &array_symbols[],const uint required_ticks=0,const uint required_books=0)
  {
   bool res=this.m_symbols.SetUsedSymbols(array_symbols);
   CArrayObj *list=this.GetListAllUsedSymbols();
   if(list==NULL)
      return false;
   res&=this.m_time_series.CreateCollection(list);
   res&=this.m_tick_series.CreateCollection(list,required_ticks);
   res&=this.m_book_series.CreateCollection(list,required_books);
   return res;
  }
//+------------------------------------------------------------------+
//| Write all used symbols and timeframes                            |
//| to the ArrayUsedSymbols and ArrayUsedTimeframes arrays           |
//+------------------------------------------------------------------+
void CEngine::WriteSymbolsPeriodsToArrays(void)
  {
//--- Get the list of all created timeseries (created by the number of used symbols)
   CArrayObj *list_timeseries=this.GetListTimeSeries();
   if(list_timeseries==NULL)
      return;
//--- Get the total number of created timeseries
   int total_timeseries=list_timeseries.Total();
   if(total_timeseries==0)
      return;
//--- Set the size of the array of used symbols equal to the number of created timeseries, while
//--- the size of the array of used timeframes is set equal to the maximum possible number of timeframes in the terminal
   if(::ArrayResize(ArrayUsedSymbols,total_timeseries,SYMBOLS_COMMON_TOTAL)!=total_timeseries || ::ArrayResize(ArrayUsedTimeframes,21,21)!=21)
      return;
//--- Set both arrays to zero
   ::ZeroMemory(ArrayUsedSymbols);
   ::ZeroMemory(ArrayUsedTimeframes);
//--- Reset the number of added symbols and timeframes to zero and,
//--- in a loop by the total number of timeseries,
   int num_symbols=0,num_periods=0;
   for(int i=0;i<total_timeseries;i++)
     {
      //--- get the next object of all timeseries of a single symbol
      CTimeSeriesDE *timeseries=list_timeseries.At(i);
      if(timeseries==NULL || this.IsExistSymbol(timeseries.Symbol()))
         continue;
      //--- increase the number of used symbols and (num_symbols variable), and
      //--- write the timeseries symbol name to the array of used symbols by the num_symbols-1 index
      num_symbols++;
      ArrayUsedSymbols[num_symbols-1]=timeseries.Symbol();
      //--- Get the list of all its timeseries from the object of all symbol timeseries
      CArrayObj *list_series=timeseries.GetListSeries();
      if(list_series==NULL)
         continue;
      //--- In the loop by the total number of symbol timeseries,
      int total_series=list_series.Total();
      for(int j=0;j<total_series;j++)
        {
         //--- get the next timeseries object
         CSeriesDE *series=list_series.At(j);
         if(series==NULL || this.IsExistTimeframe(series.Timeframe()))
            continue;
         //--- increase the number of used timeframes and (num_periods variable), and
         //--- write the timeseries timeframe value to the array of used timeframes by num_periods-1 index
         num_periods++;
         ArrayUsedTimeframes[num_periods-1]=series.Timeframe();
        }
     }
//--- Upon the loop completion, change the size of both arrays to match the exact number of added symbols and timeframes
   ::ArrayResize(ArrayUsedSymbols,num_symbols,SYMBOLS_COMMON_TOTAL);
   ::ArrayResize(ArrayUsedTimeframes,num_periods,21);
  }
//+------------------------------------------------------------------+
//| Check if a symbol is present in the array                        |
//+------------------------------------------------------------------+
bool CEngine::IsExistSymbol(const string symbol)
  {
   int total=::ArraySize(ArrayUsedSymbols);
   for(int i=0;i<total;i++)
      if(ArrayUsedSymbols[i]==symbol)
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Check if a timeframe is present in the array                     |
//+------------------------------------------------------------------+
bool CEngine::IsExistTimeframe(const ENUM_TIMEFRAMES timeframe)
  {
   int total=::ArraySize(ArrayUsedTimeframes);
   for(int i=0;i<total;i++)
      if(ArrayUsedTimeframes[i]==timeframe)
         return true;
   return false;
  }
//+------------------------------------------------------------------+
//| Working with symbol collection events                            |
//+------------------------------------------------------------------+
void CEngine::SymbolEventsControl(void)
  {
   this.m_symbols.RefreshAndEventsControl();
   this.m_is_symbol_event=this.m_symbols.IsEvent();
//--- If there are changes in symbol properties
   if(this.m_is_symbol_event)
     {
      //--- Get the last event of the symbol property change
      this.m_last_symbol_event=this.m_symbols.GetLastEvent();
     }
  }
//+------------------------------------------------------------------+
//| Working with symbol list events in the market watch window       |
//+------------------------------------------------------------------+
void CEngine::MarketWatchEventsControl(void)
  {
   if(this.IsTester())
      return;
   this.m_symbols.MarketWatchEventsControl();
  }
//+------------------------------------------------------------------+
//| Return the list of market positions                              |
//+------------------------------------------------------------------+
CArrayObj* CEngine::GetListMarketPosition(void)
  {
   CArrayObj* list=this.m_market.GetList();
   list=CSelect::ByOrderProperty(list,ORDER_PROP_STATUS,ORDER_STATUS_MARKET_POSITION,EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of market pending orders                         |
//+------------------------------------------------------------------+
CArrayObj* CEngine::GetListMarketPendings(void)
  {
   CArrayObj* list=this.m_market.GetList();
   list=CSelect::ByOrderProperty(list,ORDER_PROP_STATUS,ORDER_STATUS_MARKET_PENDING,EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of market orders                                 |
//+------------------------------------------------------------------+
CArrayObj* CEngine::GetListMarketOrders(void)
  {
   CArrayObj* list=this.m_market.GetList();
   list=CSelect::ByOrderProperty(list,ORDER_PROP_STATUS,ORDER_STATUS_MARKET_ORDER,EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of historical orders                             |
//+------------------------------------------------------------------+
CArrayObj* CEngine::GetListHistoryOrders(void)
  {
   CArrayObj* list=this.m_history.GetList();
   list=CSelect::ByOrderProperty(list,ORDER_PROP_STATUS,ORDER_STATUS_HISTORY_ORDER,EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of removed pending orders                        |
//+------------------------------------------------------------------+
CArrayObj* CEngine::GetListHistoryPendings(void)
  {
   CArrayObj* list=this.m_history.GetList();
   list=CSelect::ByOrderProperty(list,ORDER_PROP_STATUS,ORDER_STATUS_HISTORY_PENDING,EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//| Return the list of deals                                         |
//+------------------------------------------------------------------+
CArrayObj* CEngine::GetListDeals(void)
  {
   CArrayObj* list=this.m_history.GetList();
   list=CSelect::ByOrderProperty(list,ORDER_PROP_STATUS,ORDER_STATUS_DEAL,EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//|  Return the list of all position orders                          |
//+------------------------------------------------------------------+
CArrayObj* CEngine::GetListAllOrdersByPosID(const ulong position_id)
  {
   CArrayObj* list=this.GetListHistoryOrders();
   list=CSelect::ByOrderProperty(list,ORDER_PROP_POSITION_ID,position_id,EQUAL);
   return list;
  }
//+------------------------------------------------------------------+
//| Return the last position                                         |
//+------------------------------------------------------------------+
COrder* CEngine::GetLastPosition(void)
  {
   CArrayObj* list=this.GetListMarketPosition();
   if(list==NULL) return NULL;
   list.Sort(SORT_BY_ORDER_TIME_OPEN);
   COrder* order=list.At(list.Total()-1);
   return(order!=NULL ? order : NULL);
  }
//+------------------------------------------------------------------+
//| Return position by ticket                                        |
//+------------------------------------------------------------------+
COrder* CEngine::GetPosition(const ulong ticket)
  {
   CArrayObj* list=this.GetListMarketPosition();
   list=CSelect::ByOrderProperty(list,ORDER_PROP_TICKET,ticket,EQUAL);
   if(list==NULL) return NULL;
   list.Sort(SORT_BY_ORDER_TICKET);
   COrder* order=list.At(list.Total()-1);
   return(order!=NULL ? order : NULL);
  }
//+------------------------------------------------------------------+
//| Return the last deal                                             |
//+------------------------------------------------------------------+
COrder* CEngine::GetLastDeal(void)
  {
   CArrayObj* list=this.GetListDeals();
   if(list==NULL) return NULL;
   list.Sort(SORT_BY_ORDER_TIME_OPEN);
   COrder* order=list.At(list.Total()-1);
   return(order!=NULL ? order : NULL);
  }
//+------------------------------------------------------------------+
//| Return the last market pending order                             |
//+------------------------------------------------------------------+
COrder* CEngine::GetLastMarketPending(void)
  {
   CArrayObj* list=this.GetListMarketPendings();
   if(list==NULL) return NULL;
   list.Sort(SORT_BY_ORDER_TIME_OPEN);
   COrder* order=list.At(list.Total()-1);
   return(order!=NULL ? order : NULL);
  }
//+------------------------------------------------------------------+
//| Return the last historical pending order                         |
//+------------------------------------------------------------------+
COrder* CEngine::GetLastHistoryPending(void)
  {
   CArrayObj* list=this.GetListHistoryPendings();
   if(list==NULL) return NULL;
   list.Sort(#ifdef __MQL5__ SORT_BY_ORDER_TIME_OPEN #else SORT_BY_ORDER_TIME_CLOSE #endif);
   COrder* order=list.At(list.Total()-1);
   return(order!=NULL ? order : NULL);
  }
//+------------------------------------------------------------------+
//| Return the last market order                                     |
//+------------------------------------------------------------------+
COrder* CEngine::GetLastMarketOrder(void)
  {
   CArrayObj* list=this.GetListMarketOrders();
   if(list==NULL) return NULL;
   list.Sort(SORT_BY_ORDER_TIME_OPEN);
   COrder* order=list.At(list.Total()-1);
   return(order!=NULL ? order : NULL);
  }
//+------------------------------------------------------------------+
//| Return the last historical market order                          |
//+------------------------------------------------------------------+
COrder* CEngine::GetLastHistoryOrder(void)
  {
   CArrayObj* list=this.GetListHistoryOrders();
   if(list==NULL) return NULL;
   list.Sort(SORT_BY_ORDER_TIME_OPEN);
   COrder* order=list.At(list.Total()-1);
   return(order!=NULL ? order : NULL);
  }
//+------------------------------------------------------------------+
//| Return historical order by its ticket                            |
//+------------------------------------------------------------------+
COrder* CEngine::GetHistoryOrder(const ulong ticket)
  {
   CArrayObj* list=this.GetListHistoryOrders();
   list=CSelect::ByOrderProperty(list,ORDER_PROP_TICKET,(long)ticket,EQUAL);
   if(list==NULL || list.Total()==0)
     {
      list=this.GetListHistoryPendings();
      list=CSelect::ByOrderProperty(list,ORDER_PROP_TICKET,(long)ticket,EQUAL);
      if(list==NULL) return NULL;
     }
   COrder* order=list.At(0);
   return(order!=NULL ? order : NULL);
  }
//+------------------------------------------------------------------+
//| Return the first historical market order                         |
//| from the list of all position orders                             |
//+------------------------------------------------------------------+
COrder* CEngine::GetFirstOrderPosition(const ulong position_id)
  {
   CArrayObj* list=this.GetListAllOrdersByPosID(position_id);
   if(list==NULL) return NULL;
   list.Sort(SORT_BY_ORDER_TIME_OPEN);
   COrder* order=list.At(0);
   return(order!=NULL ? order : NULL);
  }
//+------------------------------------------------------------------+
//| Return the last historical market order                          |
//| from the list of all position orders                             |
//+------------------------------------------------------------------+
COrder* CEngine::GetLastOrderPosition(const ulong position_id)
  {
   CArrayObj* list=this.GetListAllOrdersByPosID(position_id);
   if(list==NULL) return NULL;
   list.Sort(SORT_BY_ORDER_TIME_OPEN);
   COrder* order=list.At(list.Total()-1);
   return(order!=NULL ? order : NULL);
  }
//+------------------------------------------------------------------+
//| Return the current account                                       |
//+------------------------------------------------------------------+
CAccount* CEngine::GetAccountCurrent(void)
  {
   int index=this.m_accounts.IndexCurrentAccount();
   if(index==WRONG_VALUE)
      return NULL;
   CArrayObj* list=this.m_accounts.GetList();
   return(list!=NULL ? (list.At(index)!=NULL ? list.At(index) : NULL) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the description of the last trading event                 |
//+------------------------------------------------------------------+
string CEngine::GetLastTradeEventDescription(void)
  {
   CArrayObj *list=this.m_events.GetList();
   if(list!=NULL)
     {
      if(list.Total()==0)
         return CMessage::Text(MSG_ENG_NO_TRADE_EVENTS);
      CEvent *event=list.At(list.Total()-1);
      if(event!=NULL)
         return event.TypeEventDescription();
     }
   return DFUN_ERR_LINE+CMessage::Text(MSG_ENG_FAILED_GET_LAST_TRADE_EVENT_DESCR);
  }
//+------------------------------------------------------------------+
//| Retrieve a necessary 'ushort' number from the packed 'long' value|
//+------------------------------------------------------------------+
ushort CEngine::LongToUshortFromByte(const long source_value,const uchar index) const
  {
   if(index>3)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_ERROR_INDEX));
      return 0;
     }
   long res=source_value>>(16*index);
   return ushort(res &=0xFFFF);
  }
//+------------------------------------------------------------------+
//| Open Buy position                                                |
//+------------------------------------------------------------------+
template<typename SL,typename TP>
bool CEngine::OpenBuy(const double volume,
                      const string symbol,
                      const ulong magic=ULONG_MAX,
                      SL sl=0,TP tp=0,
                      const string comment=NULL,
                      const ulong deviation=ULONG_MAX,
                      const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.OpenBuy(volume,symbol,magic,sl,tp,comment,deviation,type_filling);
  }
//+------------------------------------------------------------------+
//| Open Sell position                                               |
//+------------------------------------------------------------------+
template<typename SL,typename TP>
bool CEngine::OpenSell(const double volume,
                       const string symbol,
                       const ulong magic=ULONG_MAX,
                       SL sl=0,TP tp=0,
                       const string comment=NULL,
                       const ulong deviation=ULONG_MAX,
                       const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.OpenSell(volume,symbol,magic,sl,tp,comment,deviation,type_filling);
  }
//+------------------------------------------------------------------+
//| Modify a position                                                |
//+------------------------------------------------------------------+
template<typename SL,typename TP>
bool CEngine::ModifyPosition(const ulong ticket,const SL sl=WRONG_VALUE,const TP tp=WRONG_VALUE)
  {
   return this.m_trading.ModifyPosition(ticket,sl,tp);
  }
//+------------------------------------------------------------------+
//| Close a position in full                                         |
//+------------------------------------------------------------------+
bool CEngine::ClosePosition(const ulong ticket,const string comment=NULL,const ulong deviation=ULONG_MAX)
  {
   return this.m_trading.ClosePosition(ticket,WRONG_VALUE,comment,deviation);
  }
//+------------------------------------------------------------------+
//| Close a position partially                                       |
//+------------------------------------------------------------------+
bool CEngine::ClosePositionPartially(const ulong ticket,const double volume,const string comment=NULL,const ulong deviation=ULONG_MAX)
  {
   return this.m_trading.ClosePositionPartially(ticket,volume,comment,deviation);
  }
//+------------------------------------------------------------------+
//| Close a position by an opposite one                              |
//+------------------------------------------------------------------+
bool CEngine::ClosePositionBy(const ulong ticket,const ulong ticket_by)
  {
   return this.m_trading.ClosePositionBy(ticket,ticket_by);
  }
//+------------------------------------------------------------------+
//| Place BuyStop pending order                                      |
//+------------------------------------------------------------------+
template<typename PR,typename SL,typename TP>
bool CEngine::PlaceBuyStop(const double volume,
                           const string symbol,
                           const PR price,
                           const SL sl=0,
                           const TP tp=0,
                           const ulong magic=WRONG_VALUE,
                           const string comment=NULL,
                           const datetime expiration=0,
                           const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                           const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.PlaceBuyStop(volume,symbol,price,sl,tp,magic,comment,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Place BuyLimit pending order                                     |
//+------------------------------------------------------------------+
template<typename PR,typename SL,typename TP>
bool CEngine::PlaceBuyLimit(const double volume,
                            const string symbol,
                            const PR price,
                            const SL sl=0,
                            const TP tp=0,
                            const ulong magic=WRONG_VALUE,
                            const string comment=NULL,
                            const datetime expiration=0,
                            const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                            const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.PlaceBuyLimit(volume,symbol,price,sl,tp,magic,comment,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Place BuyStopLimit pending order                                 |
//+------------------------------------------------------------------+
template<typename PS,typename PL,typename SL,typename TP>
bool CEngine::PlaceBuyStopLimit(const double volume,
                                const string symbol,
                                const PS price_stop,
                                const PL price_limit,
                                const SL sl=0,
                                const TP tp=0,
                                const ulong magic=WRONG_VALUE,
                                const string comment=NULL,
                                const datetime expiration=0,
                                const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.PlaceBuyStopLimit(volume,symbol,price_stop,price_limit,sl,tp,magic,comment,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Place SellStop pending order                                     |
//+------------------------------------------------------------------+
template<typename PR,typename SL,typename TP>
bool CEngine::PlaceSellStop(const double volume,
                            const string symbol,
                            const PR price,
                            const SL sl=0,
                            const TP tp=0,
                            const ulong magic=WRONG_VALUE,
                            const string comment=NULL,
                            const datetime expiration=0,
                            const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                            const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.PlaceSellStop(volume,symbol,price,sl,tp,magic,comment,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Place SellLimit pending order                                    |
//+------------------------------------------------------------------+
template<typename PR,typename SL,typename TP>
bool CEngine::PlaceSellLimit(const double volume,
                             const string symbol,
                             const PR price,
                             const SL sl=0,
                             const TP tp=0,
                             const ulong magic=WRONG_VALUE,
                             const string comment=NULL,
                             const datetime expiration=0,
                             const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                             const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.PlaceSellLimit(volume,symbol,price,sl,tp,magic,comment,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Place SellStopLimit pending order                                |
//+------------------------------------------------------------------+
template<typename PS,typename PL,typename SL,typename TP>
bool CEngine::PlaceSellStopLimit(const double volume,
                                 const string symbol,
                                 const PS price_stop,
                                 const PL price_limit,
                                 const SL sl=0,
                                 const TP tp=0,
                                 const ulong magic=WRONG_VALUE,
                                 const string comment=NULL,
                                 const datetime expiration=0,
                                 const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                 const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.PlaceSellStopLimit(volume,symbol,price_stop,price_limit,sl,tp,magic,comment,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Modify a pending order                                           |
//+------------------------------------------------------------------+
template<typename PR,typename SL,typename TP,typename PL>
bool CEngine::ModifyOrder(const ulong ticket,
                          const PR price=WRONG_VALUE,
                          const SL sl=WRONG_VALUE,
                          const TP tp=WRONG_VALUE,
                          const PL stoplimit=WRONG_VALUE,
                          datetime expiration=WRONG_VALUE,
                          const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                          const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.ModifyOrder(ticket,price,sl,tp,stoplimit,expiration,type_time);
  }
//+------------------------------------------------------------------+
//| Remove a pending order                                           |
//+------------------------------------------------------------------+
bool CEngine::DeleteOrder(const ulong ticket)
  {
   return this.m_trading.DeleteOrder(ticket);
  }
//+------------------------------------------------------------------+
//| Create a pending request for opening a Buy position              |
//+------------------------------------------------------------------+
template<typename SL,typename TP> 
int CEngine::OpenBuyPending(const double volume,
                            const string symbol,
                            const ulong magic=ULONG_MAX,
                            const SL sl=0,
                            const TP tp=0,
                            const uchar group_id1=0,
                            const uchar group_id2=0,
                            const string comment=NULL,
                            const ulong deviation=ULONG_MAX,
                            const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.CreatePReqPosition(POSITION_TYPE_BUY,volume,symbol,magic,sl,tp,group_id1,group_id2,comment,deviation,type_filling);
  }
//+------------------------------------------------------------------+
//| Create a pending request for opening a Sell position             |
//+------------------------------------------------------------------+
template<typename SL,typename TP> 
int CEngine::OpenSellPending(const double volume,
                            const string symbol,
                            const ulong magic=ULONG_MAX,
                            const SL sl=0,
                            const TP tp=0,
                            const uchar group_id1=0,
                            const uchar group_id2=0,
                            const string comment=NULL,
                            const ulong deviation=ULONG_MAX,
                            const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.CreatePReqPosition(POSITION_TYPE_SELL,volume,symbol,magic,sl,tp,group_id1,group_id2,comment,deviation,type_filling);
  }
//+------------------------------------------------------------------+
//| Create a pending request for closing a position in full          |
//+------------------------------------------------------------------+
int CEngine::ClosePositionPending(const ulong ticket,const string comment=NULL,const ulong deviation=WRONG_VALUE)
  {
   return this.m_trading.CreatePReqClose(ticket,WRONG_VALUE,comment,deviation);
  }
//+------------------------------------------------------------------+
//| Create a pending request for closing a position partially        |
//+------------------------------------------------------------------+
int CEngine::ClosePositionPartiallyPending(const ulong ticket,const double volume,const string comment=NULL,const ulong deviation=WRONG_VALUE)
  {
   return this.m_trading.CreatePReqClose(ticket,volume,comment,deviation);
  }
//+--------------------------------------------------------------------+
//| Create a pending request for closing a position by an opposite one |
//+--------------------------------------------------------------------+
int CEngine::ClosePositionByPending(const ulong ticket,const ulong ticket_by)
  {
   return this.m_trading.CreatePReqCloseBy(ticket,ticket_by);
  }
//+------------------------------------------------------------------+
//| Create a pending request to remove a pending order               |
//+------------------------------------------------------------------+
int CEngine::DeleteOrderPending(const ulong ticket)
  {
   return this.m_trading.CreatePreqDelete(ticket);
  }
//+------------------------------------------------------------------+
//| Create a pending request to modify a position                    |
//+------------------------------------------------------------------+
template<typename SL,typename TP>
int CEngine::ModifyPositionPending(const ulong ticket,const SL sl=WRONG_VALUE,const TP tp=WRONG_VALUE,const string comment=NULL)
  {
   return this.m_trading.CreatePReqModifyPosition(ticket,sl,tp);
  }
//+------------------------------------------------------------------+
//| Create a pending request to modify an order                      |
//+------------------------------------------------------------------+
template<typename PR,typename SL,typename TP,typename PL>
int CEngine::ModifyOrderPending(const ulong ticket,
                                const PR price=WRONG_VALUE,
                                const SL sl=WRONG_VALUE,
                                const TP tp=WRONG_VALUE,
                                const PL stoplimit=WRONG_VALUE,
                                datetime expiration=WRONG_VALUE,
                                const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.CreatePReqModifyOrder(ticket,price,sl,tp,stoplimit,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Create a pending request to place a BuyLimit order               |
//+------------------------------------------------------------------+
template<typename PR,typename SL,typename TP>
int CEngine::PlaceBuyLimitPending(const double volume,
                                  const string symbol,
                                  const PR price_set,
                                  const SL sl=0,
                                  const TP tp=0,
                                  const ulong magic=ULONG_MAX,
                                  const uchar group_id1=0,
                                  const uchar group_id2=0,
                                  const string comment=NULL,
                                  const datetime expiration=0,
                                  const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                  const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.CreatePReqOrder(ORDER_TYPE_BUY_LIMIT,volume,symbol,price_set,0,sl,tp,magic,group_id1,group_id2,comment,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Create a pending request to place a BuyStop order                |
//+------------------------------------------------------------------+
template<typename PR,typename SL,typename TP>
int CEngine::PlaceBuyStopPending(const double volume,
                                 const string symbol,
                                 const PR price_set,
                                 const SL sl=0,
                                 const TP tp=0,
                                 const ulong magic=ULONG_MAX,
                                 const uchar group_id1=0,
                                 const uchar group_id2=0,
                                 const string comment=NULL,
                                 const datetime expiration=0,
                                 const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                 const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.CreatePReqOrder(ORDER_TYPE_BUY_STOP,volume,symbol,price_set,0,sl,tp,magic,group_id1,group_id2,comment,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Create a pending request to place a BuyStopLimit order           |
//+------------------------------------------------------------------+
template<typename PS,typename PL,typename SL,typename TP>
int CEngine::PlaceBuyStopLimitPending(const double volume,
                                      const string symbol,
                                      const PS price_stop,
                                      const PL price_limit,
                                      const SL sl=0,
                                      const TP tp=0,
                                      const ulong magic=ULONG_MAX,
                                      const uchar group_id1=0,
                                      const uchar group_id2=0,
                                      const string comment=NULL,
                                      const datetime expiration=0,
                                      const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                      const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return
     (
      #ifdef __MQL4__ WRONG_VALUE #else 
      this.m_trading.CreatePReqOrder(ORDER_TYPE_BUY_STOP_LIMIT,volume,symbol,price_stop,price_limit,sl,tp,magic,group_id1,group_id2,comment,expiration,type_time,type_filling)
      #endif 
     ); 
  }
//+------------------------------------------------------------------+
//| Create a pending request to place a SellLimit order              |
//+------------------------------------------------------------------+
template<typename PR,typename SL,typename TP>
int CEngine::PlaceSellLimitPending(const double volume,
                                   const string symbol,
                                   const PR price_set,
                                   const SL sl=0,
                                   const TP tp=0,
                                   const ulong magic=ULONG_MAX,
                                   const uchar group_id1=0,
                                   const uchar group_id2=0,
                                   const string comment=NULL,
                                   const datetime expiration=0,
                                   const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                   const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.CreatePReqOrder(ORDER_TYPE_SELL_LIMIT,volume,symbol,price_set,0,sl,tp,magic,group_id1,group_id2,comment,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Create a pending request to place a SellStop order               |
//+------------------------------------------------------------------+
template<typename PR,typename SL,typename TP>
int CEngine::PlaceSellStopPending(const double volume,
                                  const string symbol,
                                  const PR price_set,
                                  const SL sl=0,
                                  const TP tp=0,
                                  const ulong magic=ULONG_MAX,
                                  const uchar group_id1=0,
                                  const uchar group_id2=0,
                                  const string comment=NULL,
                                  const datetime expiration=0,
                                  const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                  const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return this.m_trading.CreatePReqOrder(ORDER_TYPE_SELL_STOP,volume,symbol,price_set,0,sl,tp,magic,group_id1,group_id2,comment,expiration,type_time,type_filling);
  }
//+------------------------------------------------------------------+
//| Create a pending request to place a SellStopLimit order          |
//+------------------------------------------------------------------+
template<typename PS,typename PL,typename SL,typename TP>
int CEngine::PlaceSellStopLimitPending(const double volume,
                                       const string symbol,
                                       const PS price_stop,
                                       const PL price_limit,
                                       const SL sl=0,
                                       const TP tp=0,
                                       const ulong magic=ULONG_MAX,
                                       const uchar group_id1=0,
                                       const uchar group_id2=0,
                                       const string comment=NULL,
                                       const datetime expiration=0,
                                       const ENUM_ORDER_TYPE_TIME type_time=WRONG_VALUE,
                                       const ENUM_ORDER_TYPE_FILLING type_filling=WRONG_VALUE)
  {
   return
     (
      #ifdef __MQL4__ WRONG_VALUE #else 
      this.m_trading.CreatePReqOrder(ORDER_TYPE_SELL_STOP_LIMIT,volume,symbol,price_stop,price_limit,sl,tp,magic,group_id1,group_id2,comment,expiration,type_time,type_filling)
      #endif 
     );
  }
//+------------------------------------------------------------------+
//| Set pending request activation criteria                          |
//+------------------------------------------------------------------+
bool CEngine::SetNewActivationProperties(const uchar id,
                                         const ENUM_PEND_REQ_ACTIVATION_SOURCE source,
                                         const int property,
                                         const double control_value,
                                         const ENUM_COMPARER_TYPE comparer_type,
                                         const double actual_value)
  {
   return this.m_trading.SetNewActivationProperties(id,source,property,control_value,comparer_type,actual_value);
  }
//+------------------------------------------------------------------+
//| Set the valid filling policy                                     |
//| for trading objects of all symbols                               |
//+------------------------------------------------------------------+
void CEngine::TradingSetCorrectTypeFilling(const ENUM_ORDER_TYPE_FILLING type=ORDER_FILLING_FOK,const string symbol_name=NULL)
  {
   this.m_trading.SetCorrectTypeFilling(type,symbol_name);
  }
//+------------------------------------------------------------------+
//| Set the filling policy                                           |
//| for trading objects of all symbols                               |
//+------------------------------------------------------------------+
void CEngine::TradingSetTypeFilling(const ENUM_ORDER_TYPE_FILLING type=ORDER_FILLING_FOK,const string symbol_name=NULL)
  {
   this.m_trading.SetTypeFilling(type,symbol_name);
  }
//+------------------------------------------------------------------+
//| Set a correct order expiration type                              |
//| for trading objects of all symbols                               |
//+------------------------------------------------------------------+
void CEngine::TradingSetCorrectTypeExpiration(const ENUM_ORDER_TYPE_TIME type=ORDER_TIME_GTC,const string symbol_name=NULL)
  {
   this.m_trading.SetCorrectTypeExpiration(type,symbol_name);
  }
//+------------------------------------------------------------------+
//| Set an order expiration type                                     |
//| for trading objects of all symbols                               |
//+------------------------------------------------------------------+
void CEngine::TradingSetTypeExpiration(const ENUM_ORDER_TYPE_TIME type=ORDER_TIME_GTC,const string symbol_name=NULL)
  {
   this.m_trading.SetTypeExpiration(type,symbol_name);
  }
//+------------------------------------------------------------------+
//| Set a magic number for trading objects of all symbols            |
//+------------------------------------------------------------------+
void CEngine::TradingSetMagic(const uint magic,const string symbol_name=NULL)
  {
   this.m_trading.SetMagic(magic,symbol_name);
  }
//+------------------------------------------------------------------+
//| Set a comment for trading objects of all symbols                 |
//+------------------------------------------------------------------+
void CEngine::TradingSetComment(const string comment,const string symbol_name=NULL)
  {
   this.m_trading.SetComment(comment,symbol_name);
  }
//+------------------------------------------------------------------+
//| Set a slippage                                                   |
//| for trading objects of all symbols                               |
//+------------------------------------------------------------------+
void CEngine::TradingSetDeviation(const ulong deviation,const string symbol_name=NULL)
  {
   this.m_trading.SetDeviation(deviation,symbol_name);
  }
//+------------------------------------------------------------------+
//| Set a volume for trading objects of all symbols                  |
//+------------------------------------------------------------------+
void CEngine::TradingSetVolume(const double volume=0,const string symbol_name=NULL)
  {
   this.m_trading.SetVolume(volume,symbol_name);
  }
//+------------------------------------------------------------------+
//| Set an order expiration date                                     |
//| for trading objects of all symbols                               |
//+------------------------------------------------------------------+
void CEngine::TradingSetExpiration(const datetime expiration=0,const string symbol_name=NULL)
  {
   this.m_trading.SetExpiration(expiration,symbol_name);
  }
//+------------------------------------------------------------------+
//| Set the flag of asynchronous sending of trading requests         |
//| for trading objects of all symbols                               |
//+------------------------------------------------------------------+
void CEngine::TradingSetAsyncMode(const bool async_mode=false,const string symbol_name=NULL)
  {
   this.m_trading.SetAsyncMode(async_mode,symbol_name);
  }
//+------------------------------------------------------------------+
//| Set a logging level of trading requests                          |
//| for trading objects of all symbols                               |
//+------------------------------------------------------------------+
void CEngine::TradingSetLogLevel(const ENUM_LOG_LEVEL log_level=LOG_LEVEL_ERROR_MSG,const string symbol_name=NULL)
  {
   this.m_trading.SetLogLevel(log_level,symbol_name);
  }
//+------------------------------------------------------------------+
//| Play a sound by its description                                  |
//+------------------------------------------------------------------+
bool CEngine::PlaySoundByDescription(const string sound_description)
  {
   string file_name=NULL;
   //--- Get the list of resources
   CArrayObj* list=this.GetListResource();
   if(list==NULL)
      return false;
   //--- Get an index of a resource object by its description
   int index=this.m_resource.GetIndexResObjByDescription(sound_description);
   //--- If a resource object with a specified description is found in the list
   if(index>WRONG_VALUE)
     {
      //--- Get a resource object by its index in the list
      CResObj *res_obj=list.At(index);
      if(res_obj==NULL)
         return false;
      //--- Get a resource object file name
      file_name=res_obj.FileName();
     }
   //--- If there is no resource object with a specified description in the list, attempt to play the file by the name written in its description
   //--- To do this, make sure that either a standard audio file (macro substitution of its name),
   //--- or a name of a new *.wav audio file is passed as a description
   else if(::StringFind(sound_description,"SND_")==0 || StringSubstr(sound_description,StringLen(sound_description)-4)==".wav")
      file_name=sound_description;
   //--- Return the file playing result
   return(file_name!=NULL ? CMessage::PlaySound(file_name) : false);
  }
//+------------------------------------------------------------------+
//| Create and return the composite magic number                     |
//| from the specified magic number value,                           |
//| first and seconf group IDs and                                   |
//| the pending request ID                                           |
//+------------------------------------------------------------------+
uint CEngine::SetCompositeMagicNumber(ushort magic_id,const uchar group_id1=0,const uchar group_id2=0,const uchar pending_req_id=0)
  {
   uint magic=magic_id;
   this.m_trading.SetGroupID1(group_id1,magic);
   this.m_trading.SetGroupID2(group_id2,magic);
   this.m_trading.SetPendReqID(pending_req_id,magic);
   return magic;
  }
//+------------------------------------------------------------------+
//| Create all applied timeseries of all used symbols                |
//+------------------------------------------------------------------+
bool CEngine::SeriesCreateAll(const string &array_periods[],const int rates_total=0,const uint required=0)
  {
//--- Set the flag of successful creation of all timeseries of all symbols
   bool res=true;
//--- Get the list of all used symbols
   CArrayObj* list_symbols=this.GetListAllUsedSymbols();
   if(list_symbols==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_FAILED_GET_SYMBOLS_ARRAY));
      return false;
     }
   //--- In the loop by the total number of symbols
   for(int i=0;i<list_symbols.Total();i++)
     {
      //--- get the next symbol object
      CSymbol *symbol=list_symbols.At(i);
      if(symbol==NULL)
        {
         ::Print(DFUN,"index ",i,": ",CMessage::Text(MSG_LIB_SYS_ERROR_FAILED_GET_SYM_OBJ));
         continue;
        }
      //--- In the loop by the total number of used timeframes,
      int total_periods=::ArraySize(array_periods);
      for(int j=0;j<total_periods;j++)
        {
         //--- create the timeseries object of the next symbol.
         //--- Add the timeseries creation result to the res variable
         ENUM_TIMEFRAMES timeframe=TimeframeByDescription(array_periods[j]);
         res &=this.SeriesCreate(symbol.Name(),timeframe,rates_total,required);
        }
     }
//--- Add the timeseries of the current symbol and chart to the collection
   this.SeriesCreate(::Symbol(),(ENUM_TIMEFRAMES)::Period(),rates_total,required);
//--- Write all used symbols and timeframes to the ArrayUsedSymbols and ArrayUsedTimeframes arrays
   this.WriteSymbolsPeriodsToArrays();
//--- Return the result of creating all timeseries for all symbols
   return res;
  }
//+---------------------------------------------------------------------------+
//| Return the umber of bars of the timeseries of the specified symbol/period |
//+---------------------------------------------------------------------------+
int CEngine::SeriesGetBarsTotal(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   CSeriesDE *series=this.SeriesGetSeries(symbol,timeframe);
   if(series==NULL)
      return WRONG_VALUE;
   return (int)series.Bars();
  }
//+------------------------------------------------------------------+
//| Return Open of the specified bar by index                        |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
double CEngine::SeriesOpen(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,index);
   return(bar!=NULL ? bar.Open() : 0);
  }
//+------------------------------------------------------------------+
//| Return High of the specified bar by index                        |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
double CEngine::SeriesHigh(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,index);
   return(bar!=NULL ? bar.High() : 0);
  }
//+------------------------------------------------------------------+
//| Return Low of the specified bar by index                         |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
double CEngine::SeriesLow(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,index);
   return(bar!=NULL ? bar.Low() : 0);
  }
//+------------------------------------------------------------------+
//| Return Close of the specified bar by index                       |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
double CEngine::SeriesClose(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,index);
   return(bar!=NULL ? bar.Close() : 0);
  }
//+------------------------------------------------------------------+
//| Return Time of the specified bar by index                        |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
datetime CEngine::SeriesTime(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,index);
   return(bar!=NULL ? bar.Time() : 0);
  }
//+------------------------------------------------------------------+
//| Return TickVolume of the specified bar by index                  |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
long CEngine::SeriesTickVolume(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,index);
   return(bar!=NULL ? bar.VolumeTick() : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return RealVolume of the specified bar by index                  |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
long CEngine::SeriesRealVolume(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,index);
   return(bar!=NULL ? bar.VolumeReal() : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return Spread of the specified bar by index                      |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
int CEngine::SeriesSpread(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,index);
   return(bar!=NULL ? bar.Spread() : INT_MIN);
  }
//+------------------------------------------------------------------+
//| Return Open of the specified bar by time                         |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
double CEngine::SeriesOpen(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,time);
   return(bar!=NULL ? bar.Open() : 0);
  }
//+------------------------------------------------------------------+
//| Return High of the specified bar by time                         |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
double CEngine::SeriesHigh(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,time);
   return(bar!=NULL ? bar.High() : 0);
  }
//+------------------------------------------------------------------+
//| Return Low of the specified bar by time                          |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
double CEngine::SeriesLow(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,time);
   return(bar!=NULL ? bar.Low() : 0);
  }
//+------------------------------------------------------------------+
//| Return Close of the specified bar by time                        |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
double CEngine::SeriesClose(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,time);
   return(bar!=NULL ? bar.Close() : 0);
  }
//+------------------------------------------------------------------+
//| Return Time of the specified bar by time                         |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
datetime CEngine::SeriesTime(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,time);
   return(bar!=NULL ? bar.Time() : 0);
  }
//+------------------------------------------------------------------+
//| Return TickVolume of the specified bar by time                   |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
long CEngine::SeriesTickVolume(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,time);
   return(bar!=NULL ? bar.VolumeTick() : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return RealVolume of the specified bar by time                   |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
long CEngine::SeriesRealVolume(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,time);
   return(bar!=NULL ? bar.VolumeReal() : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return Spread of the specified bar by time                       |
//| of the specified symbol of the specified timeframe               |
//+------------------------------------------------------------------+
int CEngine::SeriesSpread(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,time);
   return(bar!=NULL ? bar.Spread() : INT_MIN);
  }
//+------------------------------------------------------------------+
//| Return the bar type of the specified symbol                      |
//| of the specified timeframe by index                              |
//+------------------------------------------------------------------+
ENUM_BAR_BODY_TYPE CEngine::SeriesBarType(const string symbol,const ENUM_TIMEFRAMES timeframe,const int index)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,index);
   return(bar!=NULL ? bar.TypeBody() : (ENUM_BAR_BODY_TYPE)WRONG_VALUE);
  }  
//+------------------------------------------------------------------+
//| Return the bar type of the specified symbol                      |
//| of the specified timeframe by time                               |
//+------------------------------------------------------------------+
ENUM_BAR_BODY_TYPE CEngine::SeriesBarType(const string symbol,const ENUM_TIMEFRAMES timeframe,const datetime time)
  {
   CBar *bar=this.m_time_series.GetBar(symbol,timeframe,time);
   return(bar!=NULL ? bar.TypeBody() : (ENUM_BAR_BODY_TYPE)WRONG_VALUE);
  }  
//+------------------------------------------------------------------+
//| Return arrow buffer data by its serial number                    |
//| (0 - the very first arrow buffer, 1,2,N - subsequent ones)       |
//+------------------------------------------------------------------+
double CEngine::BufferDataArrow(const int number,const int series_index)
  {
   CBufferArrow *buff=this.m_buffers.GetBufferArrow(number);
   return(buff!=NULL ? buff.GetData(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return line buffer data by its serial number                     |
//| (0 - the very first line buffer, 1,2,N - subsequent ones)        |
//+------------------------------------------------------------------+
double CEngine::BufferDataLine(const int number,const int series_index)
  {
   CBufferLine *buff=this.m_buffers.GetBufferLine(number);
   return(buff!=NULL ? buff.GetData(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return section buffer data by its serial number                  |
//| (0 - the very first sections buffer, 1,2,N - subsequent ones)    |
//+------------------------------------------------------------------+
double CEngine::BufferDataSection(const int number,const int series_index)
  {
   CBufferSection *buff=this.m_buffers.GetBufferSection(number);
   return(buff!=NULL ? buff.GetData(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return histogram buffer data from zero                           |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
double CEngine::BufferDataHistogram(const int number,const int series_index)
  {
   CBufferHistogram *buff=this.m_buffers.GetBufferHistogram(number);
   return(buff!=NULL ? buff.GetData(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return histogram zero buffer data on two buffers                 |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
double CEngine::BufferDataHistogram20(const int number,const int series_index)
  {
   CBufferHistogram2 *buff=this.m_buffers.GetBufferHistogram2(number);
   return(buff!=NULL ? buff.GetData0(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return histogram first buffer data on two buffers                |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
double CEngine::BufferDataHistogram21(const int number,const int series_index)
  {
   CBufferHistogram2 *buff=this.m_buffers.GetBufferHistogram2(number);
   return(buff!=NULL ? buff.GetData1(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return zigzag zero buffer data                                   |
//| by its serial number                                             |
//| (0 - the very first zigzag buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
double CEngine::BufferDataZigZag0(const int number,const int series_index)
  {
   CBufferZigZag *buff=this.m_buffers.GetBufferZigZag(number);
   return(buff!=NULL ? buff.GetData0(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return zigzag first buffer data                                  |
//| by its serial number                                             |
//| (0 - the very first zigzag buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
double CEngine::BufferDataZigZag1(const int number,const int series_index)
  {
   CBufferZigZag *buff=this.m_buffers.GetBufferZigZag(number);
   return(buff!=NULL ? buff.GetData1(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return filling zero buffer data                                  |
//| by its serial number                                             |
//| (0 - the very first filling buffer, 1,2,N - subsequent ones)     |
//+------------------------------------------------------------------+
double CEngine::BufferDataFilling0(const int number,const int series_index)
  {
   CBufferFilling *buff=this.m_buffers.GetBufferFilling(number);
   return(buff!=NULL ? buff.GetData0(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return filling first buffer data                                 |
//| by its serial number                                             |
//| (0 - the very first filling buffer, 1,2,N - subsequent ones)     |
//+------------------------------------------------------------------+
double CEngine::BufferDataFilling1(const int number,const int series_index)
  {
   CBufferFilling *buff=this.m_buffers.GetBufferFilling(number);
   return(buff!=NULL ? buff.GetData1(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return Open data of the bar buffer by its serial number          |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
double CEngine::BufferDataBarsOpen(const int number,const int series_index)
  {
   CBufferBars *buff=this.m_buffers.GetBufferBars(number);
   return(buff!=NULL ? buff.GetDataOpen(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return High data of the bar buffer by its serial number          |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
double CEngine::BufferDataBarsHigh(const int number,const int series_index)
  {
   CBufferBars *buff=this.m_buffers.GetBufferBars(number);
   return(buff!=NULL ? buff.GetDataHigh(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return Low data of the bar buffer by its serial number           |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
double CEngine::BufferDataBarsLow(const int number,const int series_index)
  {
   CBufferBars *buff=this.m_buffers.GetBufferBars(number);
   return(buff!=NULL ? buff.GetDataLow(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return Close data of the bar buffer by its serial number         |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
double CEngine::BufferDataBarsClose(const int number,const int series_index)
  {
   CBufferBars *buff=this.m_buffers.GetBufferBars(number);
   return(buff!=NULL ? buff.GetDataClose(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return Open data of the candle buffer by its serial number       |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
double CEngine::BufferDataCandlesOpen(const int number,const int series_index)
  {
   CBufferCandles *buff=this.m_buffers.GetBufferCandles(number);
   return(buff!=NULL ? buff.GetDataOpen(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return High data of the candle buffer by its serial number       |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
double CEngine::BufferDataCandlesHigh(const int number,const int series_index)
  {
   CBufferCandles *buff=this.m_buffers.GetBufferCandles(number);
   return(buff!=NULL ? buff.GetDataHigh(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return Low data of the candle buffer by its serial number        |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
double CEngine::BufferDataCandlesLow(const int number,const int series_index)
  {
   CBufferCandles *buff=this.m_buffers.GetBufferCandles(number);
   return(buff!=NULL ? buff.GetDataLow(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Return Close data of the candle buffer by its serial number      |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
double CEngine::BufferDataCandlesClose(const int number,const int series_index)
  {
   CBufferCandles *buff=this.m_buffers.GetBufferCandles(number);
   return(buff!=NULL ? buff.GetDataClose(series_index) : EMPTY_VALUE);
  }
//+------------------------------------------------------------------+
//| Set arrow buffer data by its serial number                       |
//| (0 - the very first arrow buffer, 1,2,N - subsequent ones)       |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataArrow(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false)
  {
   this.m_buffers.SetBufferArrowValue(number,series_index,value,color_index,as_current);
  }
//+------------------------------------------------------------------+
//| Set line buffer data by its serial number                        |
//| (0 - the very first line buffer, 1,2,N - subsequent ones)        |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataLine(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false)
  {
   this.m_buffers.SetBufferLineValue(number,series_index,value,color_index,as_current);
  }
//+------------------------------------------------------------------+
//| Set section buffer data by its serial number                     |
//| (0 - the very first sections buffer, 1,2,N - subsequent ones)    |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataSection(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false)
  {
   this.m_buffers.SetBufferSectionValue(number,series_index,value,color_index,as_current);
  }
//+------------------------------------------------------------------+
//| Set histogram buffer data from zero                              |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataHistogram(const int number,const int series_index,const double value,const uchar color_index,bool as_current=false)
  {
   this.m_buffers.SetBufferHistogramValue(number,series_index,value,color_index,as_current);
  }
//+------------------------------------------------------------------+
//| Set the calculated buffer data by its serial number              |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataCalculate(const int number,const int series_index,const double value)
  {
   this.m_buffers.SetBufferCalculateValue(number,series_index,value);
  }
//+------------------------------------------------------------------+
//| Set histogram zero buffer data on two buffers                    |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataHistogram20(const int number,const int series_index,const double value)
  {
   CBufferHistogram2 *buff=this.m_buffers.GetBufferHistogram2(number);
   if(buff==NULL)
      return;
   buff.SetData0(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set histogram first buffer data on two buffers                   |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataHistogram21(const int number,const int series_index,const double value)
  {
   CBufferHistogram2 *buff=this.m_buffers.GetBufferHistogram2(number);
   if(buff==NULL)
      return;
   buff.SetData1(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set data of all histogram buffers on two buffers                 |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataHistogram2(const int number,const int series_index,const double value1,const double value2,const uchar color_index,bool as_current=false)
  {
   this.m_buffers.SetBufferHistogram2Value(number,series_index,value1,value2,color_index,as_current);
  }
//+------------------------------------------------------------------+
//| Set zigzag zero buffer data                                      |
//| by its serial number                                             |
//| (0 - the very first zigzag buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataZigZag0(const int number,const int series_index,const double value)
  {
   CBufferZigZag *buff=this.m_buffers.GetBufferZigZag(number);
   if(buff==NULL)
      return;
   buff.SetData0(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set zigzag first buffer data                                     |
//| by its serial number                                             |
//| (0 - the very first zigzag buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataZigZag1(const int number,const int series_index,const double value)
  {
   CBufferZigZag *buff=this.m_buffers.GetBufferZigZag(number);
   if(buff==NULL)
      return;
   buff.SetData1(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set data of all zizag buffers                                    |
//| by its serial number                                             |
//| (0 - the very first zigzag buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataZigZag(const int number,const int series_index,const double value1,const double value2,const uchar color_index,bool as_current=false)
  {
   this.m_buffers.SetBufferZigZagValue(number,series_index,value1,value2,color_index,as_current);
  }
//+------------------------------------------------------------------+
//| Set filling zero buffer data                                     |
//| by its serial number                                             |
//| (0 - the very first filling buffer, 1,2,N - subsequent ones)     |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataFilling0(const int number,const int series_index,const double value)
  {
   CBufferFilling *buff=this.m_buffers.GetBufferFilling(number);
   if(buff==NULL)
      return;
   buff.SetData0(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set filling first buffer data                                    |
//| by its serial number                                             |
//| (0 - the very first filling buffer, 1,2,N - subsequent ones)     |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataFilling1(const int number,const int series_index,const double value)
  {
   CBufferFilling *buff=this.m_buffers.GetBufferFilling(number);
   if(buff==NULL)
      return;
   buff.SetData1(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set data of all filling buffers                                  |
//| by its serial number                                             |
//| (0 - the very first filling buffer, 1,2,N - subsequent ones)     |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataFilling(const int number,const int series_index,const double value1,const double value2,bool as_current=false)
  {
   this.m_buffers.SetBufferFillingValue(number,series_index,value1,value2,as_current);
  }
//+------------------------------------------------------------------+
//| Set buffer data of Open bars                                     |
//| by its serial number                                             |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataBarsOpen(const int number,const int series_index,const double value)
  {
   CBufferBars *buff=this.m_buffers.GetBufferBars(number);
   if(buff==NULL)
      return;
   buff.SetDataOpen(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set buffer data of High bars                                     |
//| by its serial number                                             |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataBarsHigh(const int number,const int series_index,const double value)
  {
   CBufferBars *buff=this.m_buffers.GetBufferBars(number);
   if(buff==NULL)
      return;
   buff.SetDataHigh(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set buffer data of Low bars                                      |
//| by its serial number                                             |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataBarsLow(const int number,const int series_index,const double value)
  {
   CBufferBars *buff=this.m_buffers.GetBufferBars(number);
   if(buff==NULL)
      return;
   buff.SetDataLow(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set buffer data of Close bars                                    |
//| by its serial number                                             |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataBarsClose(const int number,const int series_index,const double value)
  {
   CBufferBars *buff=this.m_buffers.GetBufferBars(number);
   if(buff==NULL)
      return;
   buff.SetDataClose(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set data of all bar buffers                                      |
//| by its serial number                                             |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataBars(const int number,const int series_index,const double open,const double high,const double low,const double close,const uchar color_index,bool as_current=false)
  {
   this.m_buffers.SetBufferBarsValue(number,series_index,open,high,low,close,color_index,as_current);
  }
//+------------------------------------------------------------------+
//| Set buffer data of Open candles                                  |
//| by its serial number                                             |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataCandlesOpen(const int number,const int series_index,const double value)
  {
   CBufferCandles *buff=this.m_buffers.GetBufferCandles(number);
   if(buff==NULL)
      return;
   buff.SetDataOpen(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set buffer data of High candles                                  |
//| by its serial number                                             |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataCandlesHigh(const int number,const int series_index,const double value)
  {
   CBufferCandles *buff=this.m_buffers.GetBufferCandles(number);
   if(buff==NULL)
      return;
   buff.SetDataHigh(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set buffer data of Low candles                                   |
//| by its serial number                                             |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataCandlesLow(const int number,const int series_index,const double value)
  {
   CBufferCandles *buff=this.m_buffers.GetBufferCandles(number);
   if(buff==NULL)
      return;
   buff.SetDataLow(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set buffer data of Close candles                                 |
//| by its serial number                                             |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataCandlesClose(const int number,const int series_index,const double value)
  {
   CBufferCandles *buff=this.m_buffers.GetBufferCandles(number);
   if(buff==NULL)
      return;
   buff.SetDataClose(series_index,value);
  }
//+------------------------------------------------------------------+
//| Set data of all candle buffers                                   |
//| by its serial number                                             |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
void CEngine::BufferSetDataCandles(const int number,const int series_index,const double open,const double high,const double low,const double close,const uchar color_index,bool as_current=false)
  {
   this.m_buffers.SetBufferCandlesValue(number,series_index,open,high,low,close,color_index,as_current);
  }
//+------------------------------------------------------------------+
//| Return the arrow buffer color by its serial number               |
//| (0 - the very first arrow buffer, 1,2,N - subsequent ones)       |
//+------------------------------------------------------------------+
color CEngine::BufferArrowColor(const int number,const int series_index)
  {
   CBufferArrow *buff=this.m_buffers.GetBufferArrow(number);
   return(buff!=NULL ? buff.GetColorBufferValueColor(series_index) : clrNONE);
  }
//+------------------------------------------------------------------+
//| Return the line buffer color by its serial number                |
//| (0 - the very first candle line, 1,2,N - subsequent ones)        |
//+------------------------------------------------------------------+
color CEngine::BufferLineColor(const int number,const int series_index)
  {
   CBufferLine *buff=this.m_buffers.GetBufferLine(number);
   return(buff!=NULL ? buff.GetColorBufferValueColor(series_index) : clrNONE);
  }
//+------------------------------------------------------------------+
//| Return the section buffer color by its serial number             |
//| (0 - the very first sections buffer, 1,2,N - subsequent ones)    |
//+------------------------------------------------------------------+
color CEngine::BufferSectionColor(const int number,const int series_index)
  {
   CBufferSection *buff=this.m_buffers.GetBufferSection(number);
   return(buff!=NULL ? buff.GetColorBufferValueColor(series_index) : clrNONE);
  }
//+------------------------------------------------------------------+
//| Return histogram buffer color from zero                          |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
color CEngine::BufferHistogramColor(const int number,const int series_index)
  {
   CBufferHistogram *buff=this.m_buffers.GetBufferHistogram(number);
   return(buff!=NULL ? buff.GetColorBufferValueColor(series_index) : clrNONE);
  }
//+------------------------------------------------------------------+
//| Return histogram buffer color on two buffers                     |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
color CEngine::BufferHistogram2Color(const int number,const int series_index)
  {
   CBufferHistogram2 *buff=this.m_buffers.GetBufferHistogram2(number);
   return(buff!=NULL ? buff.GetColorBufferValueColor(series_index) : clrNONE);
  }
//+------------------------------------------------------------------+
//| Return the zigzag buffer color by its serial number              |
//| (0 - the very first zigzag buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
color CEngine::BufferZigZagColor(const int number,const int series_index)
  {
   CBufferZigZag *buff=this.m_buffers.GetBufferZigZag(number);
   return(buff!=NULL ? buff.GetColorBufferValueColor(series_index) : clrNONE);
  }
//+------------------------------------------------------------------+
//| Return the filling buffer color by its serial number             |
//| (0 - the very first filling buffer, 1,2,N - subsequent ones)     |
//+------------------------------------------------------------------+
color CEngine::BufferFillingColor(const int number,const int series_index)
  {
   CBufferFilling *buff=this.m_buffers.GetBufferFilling(number);
   return(buff!=NULL ? buff.GetColorBufferValueColor(series_index) : clrNONE);
  }
//+------------------------------------------------------------------+
//| Return the bar buffer color by its serial number                 |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
color CEngine::BufferBarsColor(const int number,const int series_index)
  {
   CBufferBars *buff=this.m_buffers.GetBufferBars(number);
   return(buff!=NULL ? buff.GetColorBufferValueColor(series_index) : clrNONE);
  }
//+------------------------------------------------------------------+
//| Return the candle buffer color by its serial number              |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
color CEngine::BufferCandlesColor(const int number,const int series_index)
  {
   CBufferCandles *buff=this.m_buffers.GetBufferCandles(number);
   return(buff!=NULL ? buff.GetColorBufferValueColor(series_index) : clrNONE);
  }
//+------------------------------------------------------------------+
//| Return the arrow buffer color index by its serial number         |
//| (0 - the very first arrow buffer, 1,2,N - subsequent ones)       |
//+------------------------------------------------------------------+
int CEngine::BufferArrowColorIndex(const int number,const int series_index)
  {
   CBufferArrow *buff=this.m_buffers.GetBufferArrow(number);
   return(buff!=NULL ? buff.GetColorBufferValueIndex(series_index) : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return the line buffer color index by its serial number          |
//| (0 - the very first candle line, 1,2,N - subsequent ones)        |
//+------------------------------------------------------------------+
int CEngine::BufferLineColorIndex(const int number,const int series_index)
  {
   CBufferLine *buff=this.m_buffers.GetBufferLine(number);
   return(buff!=NULL ? buff.GetColorBufferValueIndex(series_index) : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return the section buffer color index by its serial number       |
//| (0 - the very first sections buffer, 1,2,N - subsequent ones)    |
//+------------------------------------------------------------------+
int CEngine::BufferSectionColorIndex(const int number,const int series_index)
  {
   CBufferSection *buff=this.m_buffers.GetBufferSection(number);
   return(buff!=NULL ? buff.GetColorBufferValueIndex(series_index) : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return histogram buffer color index from zero                    |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
int CEngine::BufferHistogramColorIndex(const int number,const int series_index)
  {
   CBufferHistogram *buff=this.m_buffers.GetBufferHistogram(number);
   return(buff!=NULL ? buff.GetColorBufferValueIndex(series_index) : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return histogram buffer color index on two buffers               |
//| by its serial number                                             |
//| (0 - the very first buffer, 1,2,N - subsequent ones)             |
//+------------------------------------------------------------------+
int CEngine::BufferHistogram2ColorIndex(const int number,const int series_index)
  {
   CBufferHistogram2 *buff=this.m_buffers.GetBufferHistogram2(number);
   return(buff!=NULL ? buff.GetColorBufferValueIndex(series_index) : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return the zigzag buffer color index by its serial number        |
//| (0 - the very first zigzag buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
int CEngine::BufferZigZagColorIndex(const int number,const int series_index)
  {
   CBufferZigZag *buff=this.m_buffers.GetBufferZigZag(number);
   return(buff!=NULL ? buff.GetColorBufferValueIndex(series_index) : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return the filling buffer color index by its serial number       |
//| (0 - the very first filling buffer, 1,2,N - subsequent ones)     |
//+------------------------------------------------------------------+
int CEngine::BufferFillingColorIndex(const int number,const int series_index)
  {
   CBufferFilling *buff=this.m_buffers.GetBufferFilling(number);
   return(buff!=NULL ? buff.GetColorBufferValueIndex(series_index) : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return the bar buffer color index by its serial number           |
//| (0 - the very first bar buffer, 1,2,N - subsequent ones)         |
//+------------------------------------------------------------------+
int CEngine::BufferBarsColorIndex(const int number,const int series_index)
  {
   CBufferBars *buff=this.m_buffers.GetBufferBars(number);
   return(buff!=NULL ? buff.GetColorBufferValueIndex(series_index) : WRONG_VALUE);
  }
//+------------------------------------------------------------------+
//| Return the candle buffer color index by its serial number        |
//| (0 - the very first candle buffer, 1,2,N - subsequent ones)      |
//+------------------------------------------------------------------+
int CEngine::BufferCandlesColorIndex(const int number,const int series_index)
  {
   CBufferCandles *buff=this.m_buffers.GetBufferCandles(number);
   return(buff!=NULL ? buff.GetColorBufferValueIndex(series_index) : WRONG_VALUE);
  }
//+---------------------------------------------------------------------------+
//| Display short description of all indicator buffers within the collection  |
//+---------------------------------------------------------------------------+
void CEngine::BuffersPrintShort(void)
  {
//--- Get the pointer to the collection list of buffer objects
   CArrayObj *list=this.GetListBuffers();
   if(list==NULL)
      return;
   int total=list.Total();
//--- In a loop by the number of buffers in the list,
//--- get the next buffer and display its brief description in the journal
   for(int i=0;i<total;i++)
     {
      CBuffer *buff=list.At(i);
      if(buff==NULL)
         continue;
      buff.PrintShort();
     }
  }
//+------------------------------------------------------------------+
//| Return the buy volume of a DOM                                   |
//| specified by symbol and index                                    |
//+------------------------------------------------------------------+
long CEngine::MBookVolumeBuy(const string symbol,const int index)
  {
   CMBookSnapshot *mbook=this.GetMBook(symbol,index);
   return(mbook!=NULL ? mbook.VolumeBuy() : 0);
  }
//+------------------------------------------------------------------+
//| Return the sell volume of a DOM                                  |
//| specified by symbol and index                                    |
//+------------------------------------------------------------------+
long CEngine::MBookVolumeSell(const string symbol,const int index)
  {
   CMBookSnapshot *mbook=this.GetMBook(symbol,index);
   return(mbook!=NULL ? mbook.VolumeSell() : 0);
  }
//+------------------------------------------------------------------+
//| Return the extended accuracy buy volume                          |
//| of a DOM specified by symbol and index                           |
//+------------------------------------------------------------------+
double CEngine::MBookVolumeBuyReal(const string symbol,const int index)
  {
   CMBookSnapshot *mbook=this.GetMBook(symbol,index);
   return(mbook!=NULL ? mbook.VolumeBuyReal() : 0);
  }
//+------------------------------------------------------------------+
//| Return the extended accuracy sell volume                         |
//| of a DOM specified by symbol and index                           |
//+------------------------------------------------------------------+
double CEngine::MBookVolumeSellReal(const string symbol,const int index)
  {
   CMBookSnapshot *mbook=this.GetMBook(symbol,index);
   return(mbook!=NULL ? mbook.VolumeSellReal() : 0);
  }
//+------------------------------------------------------------------+
//| Return the buy volume of a DOM                                   |
//| specified by symbol and time in milliseconds                     |
//+------------------------------------------------------------------+
long CEngine::MBookVolumeBuy(const string symbol,const long time_msc)
  {
   CMBookSnapshot *mbook=this.GetMBook(symbol,time_msc);
   return(mbook!=NULL ? mbook.VolumeBuy() : 0);
  }
//+------------------------------------------------------------------+
//| Return the sell volume of a DOM                                  |
//| specified by symbol and time in milliseconds                     |
//+------------------------------------------------------------------+
long CEngine::MBookVolumeSell(const string symbol,const long time_msc)
  {
   CMBookSnapshot *mbook=this.GetMBook(symbol,time_msc);
   return(mbook!=NULL ? mbook.VolumeSell() : 0);
  }
//+------------------------------------------------------------------+
//| Return the extended accuracy buy volume                          |
//| of a DOM specified by symbol and time in milliseconds            |
//+------------------------------------------------------------------+
double CEngine::MBookVolumeBuyReal(const string symbol,const long time_msc)
  {
   CMBookSnapshot *mbook=this.GetMBook(symbol,time_msc);
   return(mbook!=NULL ? mbook.VolumeBuyReal() : 0);
  }
//+------------------------------------------------------------------+
//| Return the extended accuracy sell volume                         |
//| of a DOM specified by symbol and time in milliseconds            |
//+------------------------------------------------------------------+
double CEngine::MBookVolumeSellReal(const string symbol,const long time_msc)
  {
   CMBookSnapshot *mbook=this.GetMBook(symbol,time_msc);
   return(mbook!=NULL ? mbook.VolumeSellReal() : 0);
  }
//+------------------------------------------------------------------+
//| Deinitialize library                                             |
//+------------------------------------------------------------------+
void CEngine::OnDeinit(void)
  {
   this.m_indicators.GetList().Clear();
  }
//+------------------------------------------------------------------+
//| Handling DoEasy library events                                   |
//+------------------------------------------------------------------+
void CEngine::OnDoEasyEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
   int idx=id-CHARTEVENT_CUSTOM;
//--- Retrieve (1) event time milliseconds, (2) reason and (3) source from lparam, as well as (4) set the exact event time
   ushort msc=this.EventMSC(lparam);
   ushort reason=this.EventReason(lparam);
   ushort source=this.EventSource(lparam);
   long time=::TimeCurrent()*1000+msc;
   
//--- Handling symbol events
   if(source==COLLECTION_SYMBOLS_ID)
     {
      CSymbol *symbol=this.GetSymbolObjByName(sparam);
      if(symbol==NULL)
         return;
      //--- Number of decimal places in the event value - in case of a 'long' event, it is 0, otherwise - Digits() of a symbol
      int digits=(idx<SYMBOL_PROP_INTEGER_TOTAL ? 0 : symbol.Digits());
      //--- Event text description
      string id_descr=(idx<SYMBOL_PROP_INTEGER_TOTAL ? symbol.GetPropertyDescription((ENUM_SYMBOL_PROP_INTEGER)idx) : symbol.GetPropertyDescription((ENUM_SYMBOL_PROP_DOUBLE)idx));
      //--- Property change text value
      string value=::DoubleToString(dparam,digits);
      
      //--- Check event reasons and display its description in the journal
      if(reason==BASE_EVENT_REASON_INC)
        {
         ::Print(DFUN,symbol.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_DEC)
        {
         ::Print(DFUN,symbol.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_MORE_THEN)
        {
         ::Print(DFUN,symbol.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_LESS_THEN)
        {
         ::Print(DFUN,symbol.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_EQUALS)
        {
         ::Print(DFUN,symbol.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
     }   
     
//--- Handling account events
   else if(source==COLLECTION_ACCOUNT_ID)
     {
      CAccount *account=this.GetAccountCurrent();
      if(account==NULL)
         return;
      //--- Number of decimal places in the event value - in case of a 'long' event, it is 0, otherwise - Digits() of a symbol
      int digits=int(idx<ACCOUNT_PROP_INTEGER_TOTAL ? 0 : account.CurrencyDigits());
      //--- Event text description
      string id_descr=(idx<ACCOUNT_PROP_INTEGER_TOTAL ? account.GetPropertyDescription((ENUM_ACCOUNT_PROP_INTEGER)idx) : account.GetPropertyDescription((ENUM_ACCOUNT_PROP_DOUBLE)idx));
      //--- Property change text value
      string value=::DoubleToString(dparam,digits);
      
      //--- Checking event reasons and handling the increase of funds by a specified value,
      
      //--- Display an event in the journal
      if(reason==BASE_EVENT_REASON_INC)
        {
         ::Print(DFUN,account.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_DEC)
        {
         ::Print(DFUN,account.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_MORE_THEN)
        {
         ::Print(DFUN,account.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_LESS_THEN)
        {
         ::Print(DFUN,account.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
      if(reason==BASE_EVENT_REASON_EQUALS)
        {
         ::Print(DFUN,account.EventDescription(idx,(ENUM_BASE_EVENT_REASON)reason,source,value,id_descr,digits));
        }
     } 
     
//--- Handling market watch window events
   else if(idx>MARKET_WATCH_EVENT_NO_EVENT && idx<SYMBOL_EVENTS_NEXT_CODE)
     {
      //--- Market Watch window event
      string descr=this.GetMWEventDescription((ENUM_MW_EVENT)idx);
      string name=(idx==MARKET_WATCH_EVENT_SYMBOL_SORT ? "" : ": "+sparam);
      Print(TimeMSCtoString(lparam)," ",descr,name);
     }
     
//--- Handling timeseries events
   else if(idx>SERIES_EVENTS_NO_EVENT && idx<SERIES_EVENTS_NEXT_CODE)
     {
      //--- "New bar" event
      if(idx==SERIES_EVENTS_NEW_BAR)
        {
         ::Print(DFUN,TextByLanguage("Новый бар на ","New Bar on "),sparam," ",TimeframeDescription((ENUM_TIMEFRAMES)dparam),": ",TimeToString(lparam));
         CArrayObj *list=this.m_buffers.GetListBuffersWithID();
         if(list!=NULL)
           {
            int total=list.Total();
            for(int i=0;i<total;i++)
              {
               CBuffer *buff=list.At(i);
               if(buff==NULL)
                  continue;
               string symbol=sparam;
               ENUM_TIMEFRAMES timeframe=(ENUM_TIMEFRAMES)dparam;
               if(buff.TypeBuffer()==BUFFER_TYPE_DATA || buff.IndicatorType()==WRONG_VALUE)
                  continue;
               if(buff.Symbol()==symbol && buff.Timeframe()==timeframe )
                 {
                  CSeriesDE *series=this.SeriesGetSeries(symbol,timeframe);
                  if(series==NULL)
                     continue;
                  int count=::fmin((int)series.AvailableUsedData(),::fmin(buff.GetDataTotal(),buff.IndicatorBarsCalculated()));
                  this.m_buffers.PreparingDataBufferStdInd(buff.IndicatorType(),buff.ID(),count);
                 }
              }
           }
        }
      //--- "Bars skipped" event
      if(idx==SERIES_EVENTS_MISSING_BARS)
        {
         ::Print(DFUN,TextByLanguage("Пропущены бары на ","Missed bars on "),sparam," ",TimeframeDescription((ENUM_TIMEFRAMES)dparam),": ",(string)lparam);
        }
     }
     
//--- Handling trading events
   else if(idx>TRADE_EVENT_NO_EVENT && idx<TRADE_EVENTS_NEXT_CODE)
     {
      //--- Get the list of trading events
      CArrayObj *list=this.GetListAllOrdersEvents();
      if(list==NULL)
         return;
      //--- get the event index shift relative to the end of the list
      //--- in the tester, the shift is passed by the lparam parameter to the event handler
      //--- outside the tester, events are sent one by one and handled in OnChartEvent()
      int shift=(this.IsTester() ? (int)lparam : 0);
      CEvent *event=list.At(list.Total()-1-shift);
      if(event==NULL)
      return;
      //--- Accrue the credit
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_CREDIT)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Additional charges
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_CHARGE)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Correction
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_CORRECTION)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Enumerate bonuses
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_BONUS)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Additional commissions
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_COMISSION)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Daily commission
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_COMISSION_DAILY)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Monthly commission
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_COMISSION_MONTHLY)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Daily agent commission
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_COMISSION_AGENT_DAILY)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Monthly agent commission
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_COMISSION_AGENT_MONTHLY)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Interest rate
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_INTEREST)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Canceled buy deal
      if(event.TypeEvent()==TRADE_EVENT_BUY_CANCELLED)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Canceled sell deal
      if(event.TypeEvent()==TRADE_EVENT_SELL_CANCELLED)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Dividend operations
      if(event.TypeEvent()==TRADE_EVENT_DIVIDENT)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Accrual of franked dividend
      if(event.TypeEvent()==TRADE_EVENT_DIVIDENT_FRANKED)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Tax charges
      if(event.TypeEvent()==TRADE_EVENT_TAX)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Replenishing account balance
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_BALANCE_REFILL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Withdrawing funds from balance
      if(event.TypeEvent()==TRADE_EVENT_ACCOUNT_BALANCE_WITHDRAWAL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      
      //--- Pending order placed
      if(event.TypeEvent()==TRADE_EVENT_PENDING_ORDER_PLASED)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Pending order removed
      if(event.TypeEvent()==TRADE_EVENT_PENDING_ORDER_REMOVED)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Pending order activated by price
      if(event.TypeEvent()==TRADE_EVENT_PENDING_ORDER_ACTIVATED)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Pending order partially activated by price
      if(event.TypeEvent()==TRADE_EVENT_PENDING_ORDER_ACTIVATED_PARTIAL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position opened
      if(event.TypeEvent()==TRADE_EVENT_POSITION_OPENED)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position opened partially
      if(event.TypeEvent()==TRADE_EVENT_POSITION_OPENED_PARTIAL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed by an opposite one
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_BY_POS)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed by StopLoss
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_BY_SL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed by TakeProfit
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_BY_TP)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position reversal by a new deal (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_REVERSED_BY_MARKET)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position reversal by activating a pending order (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_REVERSED_BY_PENDING)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position reversal by partial market order execution (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_REVERSED_BY_MARKET_PARTIAL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position reversal by activating a pending order (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_REVERSED_BY_PENDING_PARTIAL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Added volume to a position by a new deal (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_VOLUME_ADD_BY_MARKET)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Added volume to a position by partial execution of a market order (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_VOLUME_ADD_BY_MARKET_PARTIAL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Added volume to a position by activating a pending order (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_VOLUME_ADD_BY_PENDING)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Added volume to a position by partial activation of a pending order (netting)
      if(event.TypeEvent()==TRADE_EVENT_POSITION_VOLUME_ADD_BY_PENDING_PARTIAL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed partially
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_PARTIAL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position partially closed by an opposite one
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_PARTIAL_BY_POS)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed partially by StopLoss
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_PARTIAL_BY_SL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Position closed partially by TakeProfit
      if(event.TypeEvent()==TRADE_EVENT_POSITION_CLOSED_PARTIAL_BY_TP)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- StopLimit order activation
      if(event.TypeEvent()==TRADE_EVENT_TRIGGERED_STOP_LIMIT_ORDER)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order price
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_PRICE)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order and StopLoss price
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_PRICE_SL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order and TakeProfit price
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_PRICE_TP)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order, StopLoss and TakeProfit price
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_PRICE_SL_TP)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order's StopLoss and TakeProfit price
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_SL_TP)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order's StopLoss
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_SL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing order's TakeProfit
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_ORDER_TP)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing position's StopLoss and TakeProfit
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_POSITION_SL_TP)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing position StopLoss
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_POSITION_SL)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
      //--- Changing position TakeProfit
      if(event.TypeEvent()==TRADE_EVENT_MODIFY_POSITION_TP)
        {
         ::Print(DFUN,event.TypeEventDescription());
        }
     }
  }
//+------------------------------------------------------------------+
//| Working with events in the tester                                |
//+------------------------------------------------------------------+
void CEngine::EventsHandling(void)
  {
//--- If a trading event is present
   if(this.IsTradeEvent())
     {
      //--- Number of trading events occurred simultaneously
      int total=this.GetTradeEventsTotal();
      for(int i=0;i<total;i++)
        {
         //--- Get the next event from the list of simultaneously occurred events by index
         CEventBaseObj *event=this.GetTradeEventByIndex(i);
         if(event==NULL)
            continue;
         long   lparam=i;
         double dparam=event.DParam();
         string sparam=event.SParam();
         this.OnDoEasyEvent(CHARTEVENT_CUSTOM+event.ID(),lparam,dparam,sparam);
        }
     }
//--- If there is an account event
   if(this.IsAccountsEvent())
     {
      //--- Get the list of all account events occurred simultaneously
      CArrayObj* list=this.GetListAccountEvents();
      if(list!=NULL)
        {
         //--- Get the next event in a loop
         int total=list.Total();
         for(int i=0;i<total;i++)
           {
            //--- take an event from the list
            CEventBaseObj *event=list.At(i);
            if(event==NULL)
               continue;
            //--- Send an event to the event handler
            long lparam=event.LParam();
            double dparam=event.DParam();
            string sparam=event.SParam();
            this.OnDoEasyEvent(CHARTEVENT_CUSTOM+event.ID(),lparam,dparam,sparam);
           }
        }
     }
//--- If there is a symbol collection event
   if(this.IsSymbolsEvent())
     {
      //--- Get the list of all symbol events occurred simultaneously
      CArrayObj* list=this.GetListSymbolsEvents();
      if(list!=NULL)
        {
         //--- Get the next event in a loop
         int total=list.Total();
         for(int i=0;i<total;i++)
           {
            //--- take an event from the list
            CEventBaseObj *event=list.At(i);
            if(event==NULL)
               continue;
            //--- Send an event to the event handler
            long lparam=event.LParam();
            double dparam=event.DParam();
            string sparam=event.SParam();
            this.OnDoEasyEvent(CHARTEVENT_CUSTOM+event.ID(),lparam,dparam,sparam);
           }
        }
     }
//--- If there is a timeseries collection event
   if(this.IsSeriesEvent())
     {
      //--- Get the list of all timeseries events occurred simultaneously
      CArrayObj* list=this.GetListSeriesEvents();
      if(list!=NULL)
        {
         //--- Get the next event in a loop
         int total=list.Total();
         for(int i=0;i<total;i++)
           {
            //--- take an event from the list
            CEventBaseObj *event=list.At(i);
            if(event==NULL)
               continue;
            //--- Send an event to the event handler
            long lparam=event.LParam();
            double dparam=event.DParam();
            string sparam=event.SParam();
            this.OnDoEasyEvent(CHARTEVENT_CUSTOM+event.ID(),lparam,dparam,sparam);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Specify the required number of buffers for indicators            |
//+------------------------------------------------------------------+
void CEngine::CheckIndicatorsBuffers(const int buffers,const int plots #ifdef __MQL4__ =1 #endif )
  {
   #ifdef __MQL5__
      if(this.BuffersPropertyPlotsTotal()!=plots)
         ::Alert(CMessage::Text(MSG_ENG_ERR_VALUE_PLOTS),this.BuffersPropertyPlotsTotal());
      if(this.BuffersPropertyBuffersTotal()!=buffers)
         ::Alert(CMessage::Text(MSG_ENG_ERR_VALUE_ORDERS),this.BuffersPropertyBuffersTotal());
   #else 
      if(buffers!=this.BuffersPropertyPlotsTotal())
         ::Alert(CMessage::Text(MSG_ENG_ERR_VALUE_ORDERS),this.BuffersPropertyPlotsTotal());
      ::IndicatorBuffers(this.BuffersPropertyBuffersTotal());
   #endif 
  }
//+------------------------------------------------------------------+

