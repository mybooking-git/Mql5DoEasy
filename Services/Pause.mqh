//+------------------------------------------------------------------+
//|                                                        Pause.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
#property strict    // Necessary for mql4
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "DELib.mqh"
//+------------------------------------------------------------------+
//| Pause class                                                      |
//+------------------------------------------------------------------+
class CPause
  {
private:
   ulong             m_start;                               // Countdown start
   ulong             m_time_begin;                          // Pause countdown start time
   ulong             m_wait_msc;                            // Pause in milliseconds
//--- Return the number of milliseconds that have elapsed since the system was launched
   ulong             TickCount(void)   const { return(#ifdef __MQL5__ ::GetTickCount64() #else ::GetTickCount() #endif);}
public:
//--- Set the new (1) countdown start time and (2) pause in milliseconds
   void              SetTimeBegin(const ulong time)         { this.m_time_begin=time; this.SetTimeBegin();              }
   void              SetTimeBegin(void)                     { this.m_start=this.TickCount();                            }
   void              SetWaitingMSC(const ulong pause)       { this.m_wait_msc=pause;                                    }

//--- Return (1) the time passed from the countdown start in milliseconds, (2) waiting completion flag,
//--- (3) pause countdown start time, (4) pause in milliseconds
   ulong             Passed(void)                     const { return this.TickCount()-this.m_start;                     }
   bool              IsCompleted(void)                const { return this.Passed()>this.m_wait_msc;                     }
   ulong             TimeBegin(void)                  const { return this.m_time_begin;                                 }
   ulong             TimeWait(void)                   const { return this.m_wait_msc;                                   }

//--- Return the description (1) of the time passed till the countdown starts in milliseconds,
//--- (2) pause countdown start time, (3) pause in milliseconds
   string            PassedDescription(void)          const { return ::TimeToString(this.Passed()/1000,TIME_SECONDS);   }
   string            TimeBeginDescription(void)       const { return ::TimeMSCtoString(this.m_time_begin);              }
   string            WaitingMSCDescription(void)      const { return (string)this.m_wait_msc;                           }
   string            WaitingSECDescription(void)      const { return ::TimeToString(this.m_wait_msc/1000,TIME_SECONDS); }

//--- Return itself
   CPause           *GetObject(void)                        { return &this;   }

//--- Constructor
                     CPause(void) : m_start(this.TickCount()){;}
  };
//+------------------------------------------------------------------+
