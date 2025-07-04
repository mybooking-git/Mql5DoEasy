//+------------------------------------------------------------------+
//|                                         MQLSignalsCollection.mqh |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "ListObj.mqh"
#include "..\Services\Select.mqh"
#include "..\Objects\MQLSignalBase\MQLSignal.mqh"
//+------------------------------------------------------------------+
//| MQL5 signal object collection                                    |
//+------------------------------------------------------------------+
class CMQLSignalsCollection : public CBaseObj
  {
private:
   CListObj                m_list;                                   // List of MQL5 signal objects
   int                     m_signals_base_total;                     // Number of signals in the MQL5 signal database
//--- Subscribe to a signal
   bool                    Subscribe(const long signal_id);
//--- Set the flag allowing synchronization without confirmation dialog
   bool                    CurrentSetConfirmationsDisableFlag(const bool flag);
//--- Set the flag of copying Stop Loss and Take Profit
   bool                    CurrentSetSLTPCopyFlag(const bool flag);
//--- Set the flag allowing the copying of signals by subscription
   bool                    CurrentSetSubscriptionEnabledFlag(const bool flag);
public:
//--- Return (1) itself and (2) the DOM series collection list
   CMQLSignalsCollection  *GetObject(void)                              { return &this;                  }
   CArrayObj              *GetList(void)                                { return &this.m_list;           }
   //--- Return the list by selected (1) integer, (2) real and (3) string properties meeting the compared criterion
   CArrayObj              *GetList(ENUM_SIGNAL_MQL5_PROP_INTEGER property,long value,ENUM_COMPARER_TYPE mode=EQUAL)  { return CSelect::ByMQLSignalProperty(this.GetList(),property,value,mode);  }
   CArrayObj              *GetList(ENUM_SIGNAL_MQL5_PROP_DOUBLE property,double value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByMQLSignalProperty(this.GetList(),property,value,mode);  }
   CArrayObj              *GetList(ENUM_SIGNAL_MQL5_PROP_STRING property,string value,ENUM_COMPARER_TYPE mode=EQUAL) { return CSelect::ByMQLSignalProperty(this.GetList(),property,value,mode);  }
//--- Return the number of MQL5 signal objects in the list
   int                     DataTotal(void)                        const { return this.m_list.Total();    }
//--- Return the pointer to the MQL5 signal object (1) by ID, (2) by name and (3) by index in the list
   CMQLSignal             *GetMQLSignal(const long id);
   CMQLSignal             *GetMQLSignal(const string name);
   CMQLSignal             *GetMQLSignal(const int index)                { return this.m_list.At(index);  }

//--- Create the collection list of MQL5 signal objects
   bool                    CreateCollection(void);
//--- Update the collection list of MQL5 signal objects
   void                    Refresh(const bool messages=true);

//--- Display (1) the complete and (2) short collection description in the journal
   virtual void            Print(const bool full_prop=false,const bool dash=false);
   void                    PrintShort(const bool list=false,const bool paid=true,const bool free=true);
   
//--- Constructor
                           CMQLSignalsCollection();
//--- Subscribe to a signal by (1) ID and (2) signal name
   bool                    SubscribeByID(const long signal_id);
   bool                    SubscribeByName(const string signal_name);
   
//+----------------------------------------------------------------------------+
//| Methods of working with the current signal the subscription is active for  |
//+----------------------------------------------------------------------------+
//--- Return the flag allowing working with the signal service
   bool                    ProgramIsAllowed(void)                 { return (bool)::MQLInfoInteger(MQL_SIGNALS_ALLOWED); }
//--- Unsubscribe from the current signal
   bool                    CurrentUnsubscribe(void);

//--- Set the percentage for converting deal volume
   bool                    CurrentSetEquityLimit(const double value);
//--- Set the market order slippage used when synchronizing positions and copying deals
   bool                    CurrentSetSlippage(const double value);
//--- Set deposit limitations (in %)
   bool                    CurrentSetDepositPercent(const int value);

//--- Return the percentage for converting deal volume
   double                  CurrentEquityLimit(void)               { return ::SignalInfoGetDouble(SIGNAL_INFO_EQUITY_LIMIT);                  }
//--- Return the market order slippage used when synchronizing positions and copying deals
   double                  CurrentSlippage(void)                  { return ::SignalInfoGetDouble(SIGNAL_INFO_SLIPPAGE);                      }
//--- Return the flag allowing synchronization without confirmation dialog 
   bool                    CurrentConfirmationsDisableFlag(void)  { return (bool)::SignalInfoGetInteger(SIGNAL_INFO_CONFIRMATIONS_DISABLED); }
//--- Return the flag of copying Stop Loss and Take Profit
   bool                    CurrentSLTPCopyFlag(void)              { return (bool)::SignalInfoGetInteger(SIGNAL_INFO_COPY_SLTP);              }
//--- Return deposit limitations (in %)
   int                     CurrentDepositPercent(void)            { return (int)::SignalInfoGetInteger(SIGNAL_INFO_DEPOSIT_PERCENT);         }
//--- Return the flag allowing the copying of signals by subscription
   bool                    CurrentSubscriptionEnabledFlag(void)   { return (bool)::SignalInfoGetInteger(SIGNAL_INFO_SUBSCRIPTION_ENABLED);   }
//--- Return the limitation by funds for a signal
   double                  CurrentVolumePercent(void)             { return ::SignalInfoGetDouble(SIGNAL_INFO_VOLUME_PERCENT);                }
//--- Return the signal ID
   long                    CurrentID(void)                        { return ::SignalInfoGetInteger(SIGNAL_INFO_ID);                           }
//--- Return the flag of agreeing to the terms of use of the Signals service
   bool                    CurrentTermsAgreeFlag(void)            { return (bool)::SignalInfoGetInteger(SIGNAL_INFO_TERMS_AGREE);            }
//--- Return the signal name
   string                  CurrentName(void)                      { return ::SignalInfoGetString(SIGNAL_INFO_NAME);                          }

//--- Enable synchronization without the confirmation dialog
   bool                    CurrentSetConfirmationsDisableON(void) { return this.CurrentSetConfirmationsDisableFlag(true);                    }
//--- Disable synchronization without the confirmation dialog
   bool                    CurrentSetConfirmationsDisableOFF(void){ return this.CurrentSetConfirmationsDisableFlag(false);                   }
//--- Enable copying Stop Loss and Take Profit
   bool                    CurrentSetSLTPCopyON(void)             { return this.CurrentSetSLTPCopyFlag(true);                                }
//--- Disable copying Stop Loss and Take Profit
   bool                    CurrentSetSLTPCopyOFF(void)            { return this.CurrentSetSLTPCopyFlag(false);                               }
//--- Enable copying deals by subscription
   bool                    CurrentSetSubscriptionEnableON(void)   { return this.CurrentSetSubscriptionEnabledFlag(true);                     }
//--- Disable copying deals by subscription
   bool                    CurrentSetSubscriptionEnableOFF(void)  { return this.CurrentSetSubscriptionEnabledFlag(false);                    }

//--- Return the description of enabling working with signals for the launched program
   string                  ProgramIsAllowedDescription(void);
//--- Return the percentage description for converting the deal volume
   string                  CurrentEquityLimitDescription(void);
//--- Return the description of the market order slippage used when synchronizing positions and copying deals
   string                  CurrentSlippageDescription(void);
//--- Return the description of the limitation by funds for a signal
   string                  CurrentVolumePercentDescription(void);
//--- Return the description of the flag allowing synchronization without confirmation dialog
   string                  CurrentConfirmationsDisableFlagDescription(void);
//--- Return the description of the flag of copying Stop Loss and Take Profit
   string                  CurrentSLTPCopyFlagDescription(void);
//--- Return the description of the deposit limitations (in %)
   string                  CurrentDepositPercentDescription(void);
//--- Return the description of the flag allowing the copying of signals by subscription
   string                  CurrentSubscriptionEnabledFlagDescription(void);
//--- Return the description of the signal ID
   string                  CurrentIDDescription(void);
//--- Return the description of the flag of agreeing to the terms of use of the Signals service
   string                  CurrentTermsAgreeFlagDescription(void);
//--- Return the description of the signal name
   string                  CurrentNameDescription(void);
//--- Display the parameters of signal copying settings in the journal
   void                    CurrentSubscriptionParameters(void);
//---
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CMQLSignalsCollection::CMQLSignalsCollection()
  {
   this.m_type=COLLECTION_MQL5_SIGNALS_ID;
   this.m_list.Clear();
   this.m_list.Sort();
   this.m_list.Type(COLLECTION_MQL5_SIGNALS_ID);
   this.m_signals_base_total=::SignalBaseTotal();
   this.CreateCollection();
  }
//+------------------------------------------------------------------+
//| Update the collection list of MQL5 signal objects                |
//+------------------------------------------------------------------+
void CMQLSignalsCollection::Refresh(const bool messages=true)
  {
   this.m_signals_base_total=::SignalBaseTotal();
   //--- loop through all signals in the signal database
   for(int i=0;i<this.m_signals_base_total;i++) 
     { 
      //--- Select a signal from the signal database by the loop index
      if(!::SignalBaseSelect(i))
         continue;
      //--- Get the current signal ID and
      //--- create a new MQL5 signal object based on it
      long id=::SignalBaseGetInteger(SIGNAL_BASE_ID);
      CMQLSignal *signal=new CMQLSignal(id);
      if(signal==NULL)
         continue;
      //--- Set the sorting flag for the list by signal ID
      this.m_list.Sort(SORT_BY_SIGNAL_MQL5_ID);
      //--- Get the index of the MQL5 signal object in the list
      int index=this.m_list.Search(signal);
      //--- If such an object exists (the index exceeds -1)
      if(index!=WRONG_VALUE)
        {
         //--- Remove the newly created object,
         delete signal;
         //--- get the pointer to such an object in the list
         signal=this.m_list.At(index);
         //--- if the pointer is received, update all signal properties
         if(signal!=NULL)
            signal.SetProperties();
         //--- move on to the next loop iteration
         continue;
        }
      //--- No such object in the collection list yet
      //--- If failed to add a new signal object to the collection list,
      //--- remove the created object and go to the next loop iteration
      if(!this.m_list.InsertSort(signal))
        {
         delete signal;
         continue;
        }
      //--- If an MQL5 signal object is successfully added to the collection
      //--- and the new object message flag is set in the parameters passed to the method,
      //--- display a message about a newly found signal
      else if(messages)
        {
         ::Print(DFUN,CMessage::Text(MSG_MQLSIG_COLLECTION_TEXT_SIGNALS_NEW),":");
         signal.PrintShort(true);
        }
     } 
  }
//+------------------------------------------------------------------+
//| Create the collection list of MQL5 signal objects                |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::CreateCollection(void)
  {
   this.m_list.Clear();
   this.Refresh(false);
   if(m_list.Total()>0)
     {
      ::Print(CMessage::Text(MSG_MQLSIG_COLLECTION_TEXT_MQL5_SIGNAL_COLLECTION)," ",CMessage::Text(MSG_LIB_TEXT_TS_TEXT_CREATED_OK));
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Return the pointer to an MQL5 signal object by an ID             |
//+------------------------------------------------------------------+
CMQLSignal *CMQLSignalsCollection::GetMQLSignal(const long id)
  {
   CArrayObj *list=GetList(SIGNAL_MQL5_PROP_ID,id,EQUAL);
   return(list!=NULL ? list.At(0) : NULL);
  }
//+------------------------------------------------------------------+
//| Return the pointer to an MQL5 signal object by a name            |
//+------------------------------------------------------------------+
CMQLSignal *CMQLSignalsCollection::GetMQLSignal(const string name)
  {
   CArrayObj *list=GetList(SIGNAL_MQL5_PROP_NAME,name,EQUAL);
   return(list!=NULL ? list.At(0) : NULL);
  }
//+------------------------------------------------------------------+
//| Display complete collection description in the journal           |
//+------------------------------------------------------------------+
void CMQLSignalsCollection::Print(const bool full_prop=false,const bool dash=false)
  {
   ::Print(CMessage::Text(MSG_MQLSIG_COLLECTION_TEXT_MQL5_SIGNAL_COLLECTION),":");
   for(int i=0;i<this.m_list.Total();i++)
     {
      CMQLSignal *signal=this.m_list.At(i);
      if(signal==NULL)
         continue;
      signal.Print();
     }
  }
//+------------------------------------------------------------------+
//| Display the short collection description in the journal          |
//+------------------------------------------------------------------+
void CMQLSignalsCollection::PrintShort(const bool list=false,const bool paid=true,const bool free=true)
  {
   //--- Display the header in the journal
   ::Print(CMessage::Text(MSG_MQLSIG_COLLECTION_TEXT_MQL5_SIGNAL_COLLECTION),":");
   //--- If the list is full, display short descriptions of all signals in the collection
   //--- according to the flags indicating the necessity to display paid and free signals
   if(list)
      for(int i=0;i<this.m_list.Total();i++)
        {
         CMQLSignal *signal=this.m_list.At(i);
         if(signal==NULL || (signal.Price()>0 && !paid) || (signal.Price()==0 && !free))
            continue;
         signal.PrintShort(true);
        }
   //--- If not the signal list
   else
     {
      //--- Sort the list by signal price
      this.m_list.Sort(SORT_BY_SIGNAL_MQL5_PRICE);
      //--- Get the list of free signals and their number
      CArrayObj *list_free=this.GetList(SIGNAL_MQL5_PROP_PRICE,0,EQUAL);
      int num_free=(list_free==NULL ? 0 : list_free.Total());
      //--- Sort the list by signal price
      this.m_list.Sort(SORT_BY_SIGNAL_MQL5_PRICE);
      //--- Get the list of paid signals and their number
      CArrayObj *list_paid=this.GetList(SIGNAL_MQL5_PROP_PRICE,0,MORE);
      int num_paid=(list_paid==NULL ? 0 : list_paid.Total());
      //--- Display the number of free and paid signals in the collection in the journal
      ::Print
        (
         "- ",CMessage::Text(MSG_MQLSIG_COLLECTION_TEXT_SIGNALS_FREE),": ",(string)num_free,
         ", ",CMessage::Text(MSG_MQLSIG_COLLECTION_TEXT_SIGNALS_PAID),": ",(string)num_paid
        );
     }
  }
//+------------------------------------------------------------------+
//| Subscribe to a signal by ID                                      |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::SubscribeByID(const long signal_id)
  {
   CMQLSignal *signal=GetMQLSignal(signal_id);
   if(signal==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_MQLSIG_COLLECTION_ERR_FAILED_GET_SIGNAL),": ",signal_id);
      return false;
     }
   return this.Subscribe(signal.ID());
  }
//+------------------------------------------------------------------+
//| Subscribe to a signal by signal name                             |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::SubscribeByName(const string signal_name)
  {
   CMQLSignal *signal=GetMQLSignal(signal_name);
   if(signal==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_MQLSIG_COLLECTION_ERR_FAILED_GET_SIGNAL),": \"",signal_name,"\"");
      return false;
     }
   return this.Subscribe(signal.ID());
  }
//+------------------------------------------------------------------+
//| Subscribe to a signal                                            |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::Subscribe(const long signal_id)
  {
//--- If working with signals is disabled for a program,
//--- display the appropriate message and the recommendation to check the program settings
   if(!this.ProgramIsAllowed())
     {
      ::Print(DFUN,CMessage::Text(MSG_SIGNAL_INFO_ERR_SIGNAL_NOT_ALLOWED));
      ::Print(DFUN,CMessage::Text(MSG_SIGNAL_INFO_TEXT_CHECK_SETTINGS));
      return false;
     }
//--- If failed to subscribe to a signal, display the error message and return 'false'
   ::ResetLastError();
   if(!::SignalSubscribe(signal_id))
     {
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
//--- Subscription successful. Display the successful signal subscription message and return 'true'
   ::Print(CMessage::Text(MSG_SIGNAL_INFO_TEXT_SIGNAL_SUBSCRIBED)," ID ",(string)this.CurrentID()," \"",CurrentName(),"\"");
   return true;
  }
//+------------------------------------------------------------------+
//| Unsubscribe from a subscribed signal                             |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::CurrentUnsubscribe(void)
  {
//--- If working with signals is disabled for a program,
//--- display the appropriate message and the recommendation to check the program settings
   if(!this.ProgramIsAllowed())
     {
      ::Print(DFUN,CMessage::Text(MSG_SIGNAL_INFO_ERR_SIGNAL_NOT_ALLOWED));
      ::Print(DFUN,CMessage::Text(MSG_SIGNAL_INFO_TEXT_CHECK_SETTINGS));
      return false;
     }
//--- Remember an ID and a name of the current signal
   ::ResetLastError();
   long id=this.CurrentID();
   string name=this.CurrentName();
//--- If the ID is zero (no subscription), return 'true'
   if(id==0)
      return true;
//--- If failed to unsubscribe from a signal, display the error message and return 'false'
   if(!::SignalUnsubscribe())
     {
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
//--- Unsubscribed from a signal successfully. Display the message about successfully unsubscribing from a signal and return 'true'
   ::Print(CMessage::Text(MSG_SIGNAL_INFO_TEXT_SIGNAL_UNSUBSCRIBED)," ID ",(string)id," \"",name,"\"");
   return true;
  }
//+------------------------------------------------------------------+
//| Set the percentage for converting a deal volume                  |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::CurrentSetEquityLimit(const double value) 
  {
   ::ResetLastError();
   if(!::SignalInfoSetDouble(SIGNAL_INFO_EQUITY_LIMIT,value))
     {
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Define the slippage used to set                                  |
//| market orders when synchronizing positions and copying deals     |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::CurrentSetSlippage(const double value) 
  {
   ::ResetLastError();
   if(!::SignalInfoSetDouble(SIGNAL_INFO_SLIPPAGE,value))
     {
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Set the flag enabling synchronization                            |
//| without confirmation dialog                                      |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::CurrentSetConfirmationsDisableFlag(const bool flag) 
  {
   ::ResetLastError();
   if(!::SignalInfoSetInteger(SIGNAL_INFO_CONFIRMATIONS_DISABLED,flag))
     {
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Set the flag of copying Stop Loss and Take Profit                |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::CurrentSetSLTPCopyFlag(const bool flag) 
  {
   ::ResetLastError();
   if(!::SignalInfoSetInteger(SIGNAL_INFO_COPY_SLTP,flag))
     {
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Set deposit limitations (in %)                                   |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::CurrentSetDepositPercent(const int value) 
  {
   ::ResetLastError();
   if(!::SignalInfoSetInteger(SIGNAL_INFO_DEPOSIT_PERCENT,value))
     {
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Set the flag allowing the copying of signals by subscription     |
//+------------------------------------------------------------------+
bool CMQLSignalsCollection::CurrentSetSubscriptionEnabledFlag(const bool flag) 
  {
   ::ResetLastError();
   if(!::SignalInfoSetInteger(SIGNAL_INFO_SUBSCRIPTION_ENABLED,flag))
     {
      CMessage::ToLog(DFUN,::GetLastError(),true);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Return the description of the permission to work with signals    |
//| for the currently launched program                               |
//+------------------------------------------------------------------+
string CMQLSignalsCollection::ProgramIsAllowedDescription(void)
  {
   return
     (
      CMessage::Text(MSG_SIGNAL_INFO_SIGNALS_PERMISSION)+": "+
      (this.ProgramIsAllowed() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
     );
  }
//+------------------------------------------------------------------+
//| Return the percentage description for converting the deal volume |
//+------------------------------------------------------------------+
string CMQLSignalsCollection::CurrentEquityLimitDescription(void) 
  {
   return CMessage::Text(MSG_SIGNAL_INFO_EQUITY_LIMIT)+": "+::DoubleToString(this.CurrentEquityLimit(),2)+"%";
  }
//+------------------------------------------------------------------+
//| Return the description of the slippage used to set               |
//| market orders when synchronizing positions and copying deals     |
//+------------------------------------------------------------------+
string CMQLSignalsCollection::CurrentSlippageDescription(void) 
  {
   return CMessage::Text(MSG_SIGNAL_INFO_SLIPPAGE)+": "+CMessage::Text(MSG_LIB_TEXT_BAR_SPREAD)+" * "+::DoubleToString(this.CurrentSlippage(),2);
  }
//+------------------------------------------------------------------+
//| Return the description of the limitation by funds for a signal   |
//+------------------------------------------------------------------+
string CMQLSignalsCollection::CurrentVolumePercentDescription(void)
  {
   return CMessage::Text(MSG_SIGNAL_INFO_VOLUME_PERCENT)+": "+::DoubleToString(this.CurrentVolumePercent(),2)+"%";
  }
//+------------------------------------------------------------------+
//| Return the description of the flag enabling synchronization      |
//| without confirmation dialog                                      |
//+------------------------------------------------------------------+
string CMQLSignalsCollection::CurrentConfirmationsDisableFlagDescription(void) 
  {
   return
     (
      CMessage::Text(MSG_SIGNAL_INFO_CONFIRMATIONS_DISABLED)+": "+
      (this.CurrentConfirmationsDisableFlag() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
     );
  }
//+--------------------------------------------------------------------------+
//| Return the description of the flag of copying Stop Loss and Take Profit  |
//+--------------------------------------------------------------------------+
string CMQLSignalsCollection::CurrentSLTPCopyFlagDescription(void) 
  {
   return
     (
      CMessage::Text(MSG_SIGNAL_INFO_COPY_SLTP)+": "+
      (this.CurrentSLTPCopyFlag() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the deposit limitations (in %)         |
//+------------------------------------------------------------------+
string CMQLSignalsCollection::CurrentDepositPercentDescription(void) 
  {
   return CMessage::Text(MSG_SIGNAL_INFO_DEPOSIT_PERCENT)+": "+(string)this.CurrentDepositPercent()+"%";
  }
//+------------------------------------------------------------------+
//| Return the description of the flag enabling                      |
//| deal copying by subscription                                     |
//+------------------------------------------------------------------+
string CMQLSignalsCollection::CurrentSubscriptionEnabledFlagDescription(void) 
  {
   return
     (
      CMessage::Text(MSG_SIGNAL_INFO_SUBSCRIPTION_ENABLED)+": "+
      (this.CurrentSubscriptionEnabledFlag() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
     );
  }
//+------------------------------------------------------------------+
//| Return the signal ID description                                 |
//+------------------------------------------------------------------+
string CMQLSignalsCollection::CurrentIDDescription(void)
  {
   return CMessage::Text(MSG_SIGNAL_INFO_ID)+": "+(this.CurrentID()>0 ? (string)this.CurrentID() : CMessage::Text(MSG_LIB_PROP_EMPTY));
  }
//+------------------------------------------------------------------+
//| Return the description of the flag indicating                    |
//| consent to the terms of use of the Signals service               |
//+------------------------------------------------------------------+
string CMQLSignalsCollection::CurrentTermsAgreeFlagDescription(void)
  {
   return
     (
      CMessage::Text(MSG_SIGNAL_INFO_TERMS_AGREE)+": "+
      (this.CurrentTermsAgreeFlag() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO))
     );
  }
//+------------------------------------------------------------------+
//| Return the description of the signal name                        |
//+------------------------------------------------------------------+
string CMQLSignalsCollection::CurrentNameDescription(void)
  {
   return CMessage::Text(MSG_SIGNAL_INFO_NAME)+": "+(this.CurrentName()!="" ? this.CurrentName() : CMessage::Text(MSG_LIB_PROP_EMPTY));
  }
//+------------------------------------------------------------------+
//| Display the parameters of signal copying settings in the journal |
//+------------------------------------------------------------------+
void CMQLSignalsCollection::CurrentSubscriptionParameters(void)
  {
   ::Print("============= ",CMessage::Text(MSG_SIGNAL_INFO_PARAMETERS)," =============");
   ::Print(this.ProgramIsAllowedDescription());
   ::Print(this.CurrentTermsAgreeFlagDescription());
   ::Print(this.CurrentSubscriptionEnabledFlagDescription());
   ::Print(this.CurrentConfirmationsDisableFlagDescription());
   ::Print(this.CurrentSLTPCopyFlagDescription());
   ::Print(this.CurrentSlippageDescription());
   ::Print(this.CurrentEquityLimitDescription());
   ::Print(this.CurrentDepositPercentDescription());
   ::Print(this.CurrentVolumePercentDescription());
   ::Print(this.CurrentIDDescription());
   ::Print(this.CurrentNameDescription());
   ::Print("");
  }  
//+------------------------------------------------------------------+


