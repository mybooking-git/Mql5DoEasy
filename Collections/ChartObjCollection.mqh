//+------------------------------------------------------------------+
//|                                           ChartObjCollection.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "ListObj.mqh"
#include "..\Services\Select.mqh"
#include "..\Objects\Chart\ChartObj.mqh"
//+------------------------------------------------------------------+
//| MQL5 signal object collection                                    |
//+------------------------------------------------------------------+
class CChartObjCollection : public CBaseObjExt
  {
private:
   CListObj                m_list;                                   // List of chart objects
   CListObj                m_list_del;                               // List of deleted chart objects
   CArrayObj               m_list_wnd_del;                           // List of deleted chart window objects
   CArrayObj               m_list_ind_del;                           // List of indicators removed from the indicator window
   CArrayObj               m_list_ind_param;                         // List of changed indicators
   int                     m_charts_total_prev;                      // Previous number of charts in the terminal
   int                     m_last_event;                             // The last event
   //--- Return the number of charts in the terminal
   int                     ChartsTotal(void) const;
   //--- Return the flag indicating the existence of (1) a chart object and (2) a chart
   bool                    IsPresentChartObj(const long chart_id);
   bool                    IsPresentChart(const long chart_id);
   //--- Create a new chart object and add it to the list
   bool                    CreateNewChartObj(const long chart_id,const string source);
   //--- Find the missing chart object, create it and add it to the collection list
   bool                    FindAndCreateMissingChartObj(void);
   //--- Find a chart object not present in the terminal and remove it from the list
   void                    FindAndDeleteExcessChartObj(void);
public:
//--- Return (1) itself, (2) chart object collection list, (3) the list of deleted chart objects, 
//--- the list (4) of deleted window objects, (5) deleted and (6) changed indicators
   CChartObjCollection    *GetObject(void)                                 { return &this;                  }
   CArrayObj              *GetList(void)                                   { return &this.m_list;           }
   CArrayObj              *GetListDeletedCharts(void)                      { return &this.m_list_del;       }
   CArrayObj              *GetListDeletedWindows(void)                     { return &this.m_list_wnd_del;   }
   CArrayObj              *GetListDeletedIndicators(void)                  { return &this.m_list_ind_del;   }
   CArrayObj              *GetListChangedIndicators(void)                  { return &this.m_list_ind_param; }
   //--- Return the list by selected (1) integer, (2) real and (3) string properties meeting the compared criterion
   CArrayObj              *GetList(ENUM_CHART_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode=EQUAL)  { return CSelect::ByChartProperty(this.GetList(),property,value,mode);  }
   CArrayObj              *GetList(ENUM_CHART_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByChartProperty(this.GetList(),property,value,mode);  }
   CArrayObj              *GetList(ENUM_CHART_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByChartProperty(this.GetList(),property,value,mode);  }
//--- Return the number of chart objects in the list
   int                     DataTotal(void)                           const { return this.m_list.Total();    }
//--- Display (1) the complete and (2) short collection description in the journal
   virtual void            Print(const bool full_prop=false,const bool dash=false);
   virtual void            PrintShort(const bool dash=false,const bool symbol=false);
   
//--- Return (1) the flag event, (2) an event of one of the charts and (3) the last event
   bool                    IsEvent(void)                             const { return this.m_is_event;                                   }
   int                     GetLastEventsCode(void)                   const { return this.m_event_code;                                 }
   int                     GetLastEvent(void)                        const { return this.m_last_event;                                 }
   
//--- Constructor
                           CChartObjCollection();

//--- Return the list of chart objects by (1) symbol and (2) timeframe
   CArrayObj              *GetChartsList(const string symbol)              { return this.GetList(CHART_PROP_SYMBOL,symbol,EQUAL);      }
   CArrayObj              *GetChartsList(const ENUM_TIMEFRAMES timeframe)  { return this.GetList(CHART_PROP_TIMEFRAME,timeframe,EQUAL);}
//--- Return the pointer to the chart object (1) by ID and (2) by an index in the list
   CChartObj              *GetChart(const long id);
   CChartObj              *GetChart(const int index)                       { return this.m_list.At(index);                             }
//--- Return (1) the last added chart and (2) the last removed chart
   CChartObj              *GetLastAddedChart(void)                         { return this.m_list.At(this.m_list.Total()-1);             }
   CChartObj              *GetLastDeletedChart(void)                       { return this.m_list_del.At(this.m_list_del.Total()-1);     }
   
//--- Return (1) the last added window on the chart by chart ID and (2) the last removed chart window
   CChartWnd              *GetLastAddedChartWindow(const long chart_id); 
   CChartWnd              *GetLastDeletedChartWindow(void)                 { return this.m_list_wnd_del.At(this.m_list_wnd_del.Total()-1);}
//--- Return the window object (specified by index) of the chart (specified by ID)
   CChartWnd              *GetChartWindow(const long chart_id,const int wnd_num);

//--- Return (1) the last one added to the specified window of the specified chart, (2) the last one removed from the window and (3) the changed indicator
   CWndInd                *GetLastAddedIndicator(const long chart_id,const int win_num);
   CWndInd                *GetLastDeletedIndicator(void)                   { return this.m_list_ind_del.At(this.m_list_ind_del.Total()-1);   }
   CWndInd                *GetLastChangedIndicator(void)                   { return this.m_list_ind_param.At(this.m_list_ind_param.Total()-1);}
//--- Return the indicator by index from the specified window of the specified chart
   CWndInd                *GetIndicator(const long chart_id,const int win_num,const int ind_index);

//--- Return the chart ID with the program
   long                    GetMainChartID(void)                      const { return CBaseObj::GetMainChartID();                        }
//--- Create the collection list of chart objects
   bool                    CreateCollection(void);
//--- Update (1) the chart object collection list and (2) the specified chart object
   void                    Refresh(void);
   void                    Refresh(const long chart_id);

//--- (1) Open a new chart with the specified symbol and period, (2) close the specified chart
   bool                    Open(const string symbol,const ENUM_TIMEFRAMES timeframe);
   bool                    Close(const long chart_id);
   
//--- Create and send the chart event to the control program chart
   void                    SendEvent(ENUM_CHART_OBJ_EVENT event);
  
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CChartObjCollection::CChartObjCollection()
  {
   this.m_list.Clear();
   this.m_list.Sort();
   this.m_list_ind_del.Clear();
   this.m_list_ind_del.Sort();
   this.m_list_ind_param.Clear();
   this.m_list_ind_param.Sort();
   this.m_list_wnd_del.Clear();
   this.m_list_wnd_del.Sort();
   this.m_list_del.Clear();
   this.m_list_del.Sort();
   this.m_list.Type(COLLECTION_CHARTS_ID);
   this.m_charts_total_prev=this.ChartsTotal();
  }
//+------------------------------------------------------------------+
//| Create the collection list of chart objects                      |
//+------------------------------------------------------------------+
bool CChartObjCollection::CreateCollection(void)
  {
   //--- Clear the list and set the flag of sorting by the chart ID
   this.m_list.Clear();
   this.m_list.Sort(SORT_BY_CHART_ID);
   //--- Declare variables to search for charts
   long chart_id=0;
   int i=0;
   while(i<CHARTS_MAX)
     {
      //--- Get the chart ID
      chart_id=::ChartNext(chart_id);
      if(chart_id<0)
         break;
      //--- Create the chart object based on the current chart ID in the loop and add it to the list
      if(!this.CreateNewChartObj(chart_id,DFUN))
         return false;
      i++;
     }
   //--- Filled in the list successfully
   return true;
  }
//+------------------------------------------------------------------+
//| Update the collection list of chart objects                      |
//+------------------------------------------------------------------+
void CChartObjCollection::Refresh(void)
  {
//--- Initialize event data
   this.m_is_event=false;
   this.m_hash_sum=0;
   this.m_list_events.Clear();
   this.m_list_events.Sort();
   //--- In the loop by the number of chart objects in the collection list
   for(int i=0;i<this.m_list.Total();i++)
     {
      //--- get the next chart object and
      CChartObj *chart=this.m_list.At(i);
      if(chart==NULL)
         continue;
      //--- update it
      chart.Refresh();
      //--- If there is no chart event, move on to the next one
      if(!chart.IsEvent())
         continue;
      //--- Get the list of events of a selected chart
      CArrayObj *list=chart.GetListEvents();
      if(list==NULL)
         continue;
      //--- Set the event flag in the chart collection and get the last event code
      this.m_is_event=true;
      this.m_event_code=chart.GetEventCode();
      //--- In the loop by the chart event list,
      int n=list.Total();
      for(int j=0; j<n; j++)
        {
         //--- get the base event object from the chart event list
         CEventBaseObj *event=list.At(j);
         if(event==NULL)
            continue;
         //--- Create the chart event parameters using the base event
         ushort event_id=event.ID();
         this.m_last_event=event_id;
         string sparam=(string)this.GetChartID();
         //--- and, if the chart event is added to the chart event list,
         if(this.EventAdd((ushort)event.ID(),event.LParam(),event.DParam(),sparam))
           {
            //--- send the newly created chart event to the control program chart
            ::EventChartCustom(this.m_chart_id_main,(ushort)event_id,event.LParam(),event.DParam(),sparam);
           }
        }
     }
   
   //--- Get the number of open charts in the terminal and
   int charts_total=this.ChartsTotal();
   //--- calculate the difference between the number of open charts in the terminal
   //--- and chart objects in the collection list. These values are displayed in the chart comment
   int change=charts_total-this.m_list.Total();
   //--- If there are no changes, leave
   if(change==0)
      return;
   //--- If a chart is added in the terminal
   if(change>0)
     {
      //--- Find the missing chart object, create and add it to the collection list
      this.FindAndCreateMissingChartObj();
      //--- Get the current chart and return to it since
      //--- adding a new chart switches the focus to it
      CChartObj *chart=this.GetChart(GetMainChartID());
      if(chart!=NULL)
         chart.SetBringToTopON(true);
      for(int i=0;i<change;i++)
        {
         chart=m_list.At(m_list.Total()-(1+i));
         if(chart==NULL)
            continue;
         this.SendEvent(CHART_OBJ_EVENT_CHART_OPEN);
        }
     }
   //--- If a chart is removed from the terminal
   else if(change<0)
     {
      //--- Find an extra chart object in the collection list and remove it from the list
      this.FindAndDeleteExcessChartObj();
      for(int i=0;i<-change;i++)
        {
         CChartObj *chart=this.m_list_del.At(this.m_list_del.Total()-(1+i));
         if(chart==NULL)
            continue;
         this.SendEvent(CHART_OBJ_EVENT_CHART_CLOSE);
        }
     }
  }
//+------------------------------------------------------------------+
//| Update the specified chart object                                |
//+------------------------------------------------------------------+
void CChartObjCollection::Refresh(const long chart_id)
  {
   CChartObj *chart=this.GetChart(chart_id);
   if(chart==NULL)
      return;
   chart.Refresh();
  }
//+------------------------------------------------------------------+
//| Display complete collection description in the journal           |
//+------------------------------------------------------------------+
void CChartObjCollection::Print(const bool full_prop=false,const bool dash=false)
  {
   //--- Display the header in the journal and print all chart objects in full
   ::Print(CMessage::Text(MSG_CHART_COLLECTION_TEXT_CHART_COLLECTION),":");
   for(int i=0;i<this.m_list.Total();i++)
     {
      CChartObj *chart=this.m_list.At(i);
      if(chart==NULL)
         continue;
      chart.Print();
     }
  }
//+------------------------------------------------------------------+
//| Display the short collection description in the journal          |
//+------------------------------------------------------------------+
void CChartObjCollection::PrintShort(const bool dash=false,const bool symbol=false)
  {
   //--- Display the header in the journal and print short descriptions of chart objects
   ::Print(CMessage::Text(MSG_CHART_COLLECTION_TEXT_CHART_COLLECTION),":");
   for(int i=0;i<this.m_list.Total();i++)
     {
      CChartObj *chart=this.m_list.At(i);
      if(chart==NULL)
         continue;
      chart.PrintShort(true);
     }
  }
//+------------------------------------------------------------------+
//| Return the number of charts in the terminal                      |
//+------------------------------------------------------------------+
int CChartObjCollection::ChartsTotal(void) const
  {
   //--- Declare the variables and get the first chart ID
   long currChart,prevChart=::ChartFirst(); 
   int res=1; // We definitely have one chart - the current one
   //--- In the loop by the total number of terminal charts (not more than 100)
   while(res<CHARTS_MAX)
     { 
      //--- based on the previous one, get the new chart
      currChart=::ChartNext(prevChart);
      //--- When reaching the end of the chart list, complete the loop
      if(currChart<0) break;
      prevChart=currChart;
      res++;
     }
   //--- Return the obtained loop counter
   return res;
  }
//+------------------------------------------------------------------+
//| Create a new chart object and add it to the list                 |
//+------------------------------------------------------------------+
bool CChartObjCollection::CreateNewChartObj(const long chart_id,const string source)
  {
   ::ResetLastError();
   CChartObj *chart_obj=new CChartObj(chart_id,this.GetListDeletedWindows(),this.GetListDeletedIndicators(),this.GetListChangedIndicators());
   if(chart_obj==NULL)
     {
      CMessage::ToLog(source,MSG_CHART_COLLECTION_ERR_FAILED_CREATE_CHART_OBJ,true);
      return false;
     }
   this.m_list.Sort(SORT_BY_CHART_ID);
   if(!this.m_list.InsertSort(chart_obj))
     {
      CMessage::ToLog(source,MSG_CHART_COLLECTION_ERR_FAILED_ADD_CHART,true);
      delete chart_obj;
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Return the pointer to the chart object by ID                     |
//+------------------------------------------------------------------+
CChartObj *CChartObjCollection::GetChart(const long id)
  {
   CArrayObj *list=CSelect::ByChartProperty(GetList(),CHART_PROP_ID,id,EQUAL);
   return(list!=NULL ? list.At(0) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the last added window to the chart by ID                  |
//+------------------------------------------------------------------+
CChartWnd* CChartObjCollection::GetLastAddedChartWindow(const long chart_id)
  {
   CChartObj *chart=this.GetChart(chart_id);
   if(chart==NULL)
      return NULL;
   CArrayObj *list=chart.GetList();
   return(list!=NULL ? list.At(list.Total()-1) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the window object (specified by index)                    |
//| of the chart (specified by ID)                                   |
//+------------------------------------------------------------------+
CChartWnd* CChartObjCollection::GetChartWindow(const long chart_id,const int wnd_num)
  {
   CChartObj *chart=this.GetChart(chart_id);
   if(chart==NULL)
      return NULL;
   return chart.GetWindowByNum(wnd_num);
  }
//+------------------------------------------------------------------+
//| Return the last indicator added                                  |
//| to the specified window of the specified chart                   |
//+------------------------------------------------------------------+
CWndInd* CChartObjCollection::GetLastAddedIndicator(const long chart_id,const int win_num)
  {
   CChartObj *chart=this.GetChart(chart_id);
   return(chart!=NULL ? chart.GetLastAddedIndicator(win_num) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the indicator by index                                    |
//| from the specified window of the specified chart                 |
//+------------------------------------------------------------------+
CWndInd* CChartObjCollection::GetIndicator(const long chart_id,const int win_num,const int ind_index)
  {
   CChartObj *chart=this.GetChart(chart_id);
   return(chart!=NULL ? chart.GetIndicator(win_num,ind_index) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the flag indicating the existence of a chart object       |
//+------------------------------------------------------------------+
bool CChartObjCollection::IsPresentChartObj(const long chart_id)
  {
   return(this.GetChart(chart_id)!=NULL);
  }
//+------------------------------------------------------------------+
//| Return the flag indicating the existence of a chart              |
//+------------------------------------------------------------------+
bool CChartObjCollection::IsPresentChart(const long chart_id)
  {
   ////--- Declare the variables and get the first chart ID
   //long curr_chart,prev_chart=::ChartFirst();
   ////--- If the IDs match, return 'true'
   //if(prev_chart==chart_id)
   //   return true;
   //int i=0; 
   ////--- In the loop by the total number of terminal charts (not more than 100)
   //while(i<CHARTS_MAX)
   //  { 
   //   //--- based on the previous one, get the new chart
   //   curr_chart=::ChartNext(prev_chart);
   //   //--- When reaching the end of the chart list, complete the loop
   //   if(curr_chart<0) break;
   //   //--- If the IDs match, return 'true'
   //   if(curr_chart==chart_id)
   //      return true;
   //   //--- remember the current chart ID for ChartNext() and increase the loop counter
   //   prev_chart=curr_chart;
   //   i++;
   //  }
   //return false;
   
   //--- Declare the variables
   long curr_chart=0;
   int i=0; 
   //--- In the loop by the total number of terminal charts (not more than 100)
   while(i<CHARTS_MAX)
     { 
      //--- get the chart ID
      curr_chart=::ChartNext(curr_chart);
      //--- When reaching the end of the chart list, complete the loop
      if(curr_chart<0) break;
      //--- If the IDs match, return 'true'
      if(curr_chart==chart_id)
         return true;
      i++;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Find a missing chart object,                                     |
//| create it and add to the collection list                         |
//+------------------------------------------------------------------+
bool CChartObjCollection::FindAndCreateMissingChartObj(void)
  {
   //--- Declare the variables
   long curr_chart=0; 
   int i=0; 
   //--- In the loop by the total number of terminal charts (not more than 100), look for the rest of the charts
   while(i<CHARTS_MAX)
     { 
      //--- based on the previous one, get the new chart
      curr_chart=::ChartNext(curr_chart);
      //--- When reaching the end of the chart list, complete the loop
      if(curr_chart<0) break;
      //--- If the object is not in the list, attempt to create and add it to the list
      if(!this.IsPresentChartObj(curr_chart) && !this.CreateNewChartObj(curr_chart,DFUN))
         return false;
      i++;
     }
   return true;
  }
//+-----------------------------------------------------------------------------+
//|Find a chart object not present in the terminal and remove it from the list  |
//+-----------------------------------------------------------------------------+
void CChartObjCollection::FindAndDeleteExcessChartObj(void)
  {
   for(int i=this.m_list.Total()-1;i>WRONG_VALUE;i--)
     {
      CChartObj *chart=this.m_list.At(i);
      if(chart==NULL)
         continue;
      if(!this.IsPresentChart(chart.ID()))
        {
         chart=this.m_list.Detach(i);
         if(chart!=NULL)
           {
            if(!this.m_list_del.Add(chart))
               this.m_list.Delete(i);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Open a new chart with the specified symbol and period            |
//+------------------------------------------------------------------+
bool CChartObjCollection::Open(const string symbol,const ENUM_TIMEFRAMES timeframe)
  {
   if(this.m_list.Total()==CHARTS_MAX)
     {
      ::Print(CMessage::Text(MSG_CHART_COLLECTION_ERR_CHARTS_MAX)," (",(string)CHARTS_MAX,")");
      return false;
     }
   ::ResetLastError();
   long chart_id=::ChartOpen(symbol,timeframe);
   if(chart_id==0)
      CMessage::ToLog(::GetLastError(),true);
   return(chart_id>0);
  }
//+------------------------------------------------------------------+
//| Close a specified chart                                          |
//+------------------------------------------------------------------+
bool CChartObjCollection::Close(const long chart_id)
  {
   ::ResetLastError();
   bool res=::ChartClose(chart_id);
   if(!res)
      CMessage::ToLog(DFUN,::GetLastError(),true);
   return res;
  }
//+------------------------------------------------------------------+
//| Create and send a chart event                                    |
//| to the control program chart                                     |
//+------------------------------------------------------------------+
void CChartObjCollection::SendEvent(ENUM_CHART_OBJ_EVENT event)
  {
   //--- If a chart is added
   if(event==CHART_OBJ_EVENT_CHART_OPEN)
     {
      //--- Get the last chart object added to the list
      CChartObj *chart=this.GetLastAddedChart();
      if(chart==NULL)
         return;
      //--- Send the CHART_OBJ_EVENT_CHART_OPEN event to the control program chart
      //--- pass the chart ID to lparam,
      //--- pass the chart timeframe to dparam,
      //--- pass the chart symbol to sparam
      ::EventChartCustom(this.m_chart_id_main,(ushort)event,chart.ID(),chart.Timeframe(),chart.Symbol());
     }
   //--- If a chart is removed
   else if(event==CHART_OBJ_EVENT_CHART_CLOSE)
     {
      //--- Get the last chart object added to the list of removed charts
      CChartObj *chart=this.GetLastDeletedChart();
      if(chart==NULL)
         return;
      //--- Send the CHART_OBJ_EVENT_CHART_CLOSE event to the control program chart
      //--- pass the chart ID to lparam,
      //--- pass the chart timeframe to dparam,
      //--- pass the chart symbol to sparam
      ::EventChartCustom(this.m_chart_id_main,(ushort)event,chart.ID(),chart.Timeframe(),chart.Symbol());
     }
  }
//+------------------------------------------------------------------+
