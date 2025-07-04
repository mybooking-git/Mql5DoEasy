//+------------------------------------------------------------------+
//|                                              GraphElmControl.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
#property strict    // Necessary for mql4
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include <Arrays\ArrayObj.mqh>
#include "..\..\Services\DELib.mqh"
#include "Form.mqh"
//+------------------------------------------------------------------+
//| Class for managing graphical elements                            |
//+------------------------------------------------------------------+
class CGraphElmControl : public CObject
  {
private:
   int               m_type;                          // Object type
   int               m_type_node;                     // Type of the object the graphics is constructed for
public:
//--- Return itself
   CGraphElmControl *GetObject(void)                  { return &this;               }
//--- Set a type of the object the graphics is constructed for
   void              SetTypeNode(const int type_node) { this.m_type_node=type_node; }
   
//--- Create a form object
   CForm            *CreateForm(const int form_id,const long chart_id,const int wnd,const string name,const int x,const int y,const int w,const int h);
   CForm            *CreateForm(const int form_id,const int wnd,const string name,const int x,const int y,const int w,const int h);
   CForm            *CreateForm(const int form_id,const string name,const int x,const int y,const int w,const int h);

//--- Constructors
                     CGraphElmControl(){ this.m_type=OBJECT_DE_TYPE_GELEMENT_CONTROL; }
                     CGraphElmControl(int type_node);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CGraphElmControl::CGraphElmControl(int type_node)
  {
   this.m_type=OBJECT_DE_TYPE_GELEMENT_CONTROL; 
   this.m_type_node=m_type_node;
  }
//+-----------------------------------------------------------------------+
//| Create the form object on a specified chart in a specified subwindow  |
//+-----------------------------------------------------------------------+
CForm *CGraphElmControl::CreateForm(const int form_id,const long chart_id,const int wnd,const string name,const int x,const int y,const int w,const int h)
  {
   CForm *form=new CForm(chart_id,wnd,name,x,y,w,h);
   if(form==NULL)
      return NULL;
   form.SetID(form_id);
   form.SetNumber(0);
   return form;
  }
//+-----------------------------------------------------------------------+
//| Create the form object on the current chart in a specified subwindow  |
//+-----------------------------------------------------------------------+
CForm *CGraphElmControl::CreateForm(const int form_id,const int wnd,const string name,const int x,const int y,const int w,const int h)
  {
   return this.CreateForm(form_id,::ChartID(),wnd,name,x,y,w,h);
  }
//+-----------------------------------------------------------------------+
//| Create the form object on the current chart in the chart main window  |
//+-----------------------------------------------------------------------+
CForm *CGraphElmControl::CreateForm(const int form_id,const string name,const int x,const int y,const int w,const int h)
  {
   return this.CreateForm(form_id,::ChartID(),0,name,x,y,w,h);
  }
//+------------------------------------------------------------------+
