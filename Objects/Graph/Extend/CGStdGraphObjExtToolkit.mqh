//+------------------------------------------------------------------+
//|                                      CGStdGraphObjExtToolkit.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
#property version   "1.00"
#property strict    // Necessary for mql4
//+------------------------------------------------------------------+
//| Include files                                                    |
//+------------------------------------------------------------------+
#include "..\..\Graph\Form.mqh"
//+------------------------------------------------------------------+
//| Class of the form for managing pivot points of a graphical object|
//+------------------------------------------------------------------+
class CFormControl : public CForm
  {
private:
   bool              m_drawn;                   // Flag indicating that the pivot point is drawn on the form
   int               m_pivot_point;             // Pivot point managed by the form
public:
//--- (1) Return and (2) set the drawn point flag
   bool              IsControlAlreadyDrawn(void)               const { return this.m_drawn;                       }
   void              SetControlPointDrawnFlag(const bool flag)       { this.m_drawn=flag;                         }
//--- (1) Return and (2) set the pivot point managed by the form
   int               GraphObjPivotPoint(void)                  const { return this.m_pivot_point;                 }
   void              SetGraphObjPivotPoint(const int index)          { this.m_pivot_point=index;                  }
//--- Constructor
                     CFormControl(void)                              { this.m_type=OBJECT_DE_TYPE_GFORM_CONTROL;  }
                     CFormControl(const long chart_id,const int subwindow,const string name,const int pivot_point,const int x,const int y,const int w,const int h) :
                        CForm(chart_id,subwindow,name,x,y,w,h)
                          {
                           this.m_type=OBJECT_DE_TYPE_GFORM_CONTROL;
                           this.m_pivot_point=pivot_point;
                          }
  };
//+------------------------------------------------------------------+
//| Extended standard graphical                                      |
//| object toolkit class                                             |
//+------------------------------------------------------------------+
class CGStdGraphObjExtToolkit : public CObject
  {
private:
   long              m_base_chart_id;           // Base graphical object chart ID
   int               m_base_subwindow;          // Base graphical object chart subwindow
   ENUM_OBJECT       m_base_type;               // Base object type
   string            m_base_name;               // Base object name
   int               m_base_pivots;             // Number of base object reference points
   datetime          m_base_time[];             // Time array of base object reference points
   double            m_base_price[];            // Price array of base object reference points
   int               m_base_x;                  // Base object X coordinate
   int               m_base_y;                  // Base object Y coordinate
   int               m_ctrl_form_size;          // Size of forms for managing reference points
   int               m_shift;                   // Shift coordinates for adjusting the form location
   CArrayObj         m_list_forms;              // List of form objects for managing reference points
//--- Create a form object on a base object reference point
   CFormControl     *CreateNewControlPointForm(const int index);
//--- Return X and Y (1) screen coordinates of the specified reference point of the graphical object
   bool              GetControlPointCoordXY(const int index,int &x,int &y);
//--- Set the parameters of a form object for managing pivot points
   void              SetControlFormParams(CFormControl *form,const int index);
public:
//--- Set the parameters of the base object of a composite graphical object
   void              SetBaseObj(const ENUM_OBJECT base_type,const string base_name,
                                const long base_chart_id,const int base_subwindow,
                                const int base_pivots,const int ctrl_form_size,
                                const int base_x,const int base_y,
                                const datetime &base_time[],const double &base_price[]);
//--- Set the base object (1) time, (2) price, (3) time and price coordinates
   void              SetBaseObjTime(const datetime time,const int index);
   void              SetBaseObjPrice(const double price,const int index);
   void              SetBaseObjTimePrice(const datetime time,const double price,const int index);
//--- Set the base object (1) X, (2) Y, (3) X and Y screen coordinates
   void              SetBaseObjCoordX(const int value)                        { this.m_base_x=value;                          }
   void              SetBaseObjCoordY(const int value)                        { this.m_base_y=value;                          }
   void              SetBaseObjCoordXY(const int value_x,const int value_y)   { this.m_base_x=value_x; this.m_base_y=value_y; }
//--- (1) Set and (2) return the size of the form of pivot point management control points
   void              SetControlFormSize(const int size);
   int               GetControlFormSize(void)                           const { return this.m_ctrl_form_size;                 }
//--- Return the pointer to the pivot point form by (1) index and (2) name
   CFormControl     *GetControlPointForm(const int index)                     { return this.m_list_forms.At(index);           }
   CFormControl     *GetControlPointForm(const string name,int &index);
//--- Return the number of (1) base object pivot points and (2) newly created form objects for managing control points
   int               GetNumPivotsBaseObj(void)                          const { return this.m_base_pivots;                    }
   int               GetNumControlPointForms(void)                      const { return this.m_list_forms.Total();             }
//--- Create form objects on the base object pivot points
   bool              CreateAllControlPointForm(void);
//--- (1) Draw a control point on the form, (2) draw a control point on the form and delete it on all other forms
   void              DrawControlPoint(CFormControl *form,const uchar opacity,const color clr);
   void              DrawOneControlPoint(CFormControl *form,const uchar opacity=255,const color clr=CTRL_POINT_COLOR);
//--- (1) Draw using a default color, (remove) a control point on the form
   void              DrawControlPoint(CFormControl *form)                     { this.DrawControlPoint(form,255,CTRL_POINT_COLOR);}
   void              ClearControlPoint(CFormControl *form)                    { this.DrawControlPoint(form,0,CTRL_POINT_COLOR);  }
//--- Remove all form objects from the list
   void              DeleteAllControlPointForm(void);
   
//--- Event handler
   void              OnChartEvent(const int id,const long& lparam,const double& dparam,const string& sparam);

//--- Constructor/destructor
                     CGStdGraphObjExtToolkit(const ENUM_OBJECT base_type,const string base_name,
                                             const long base_chart_id,const int base_subwindow,
                                             const int base_pivots,const int ctrl_form_size,
                                             const int base_x,const int base_y,
                                             const datetime &base_time[],const double &base_price[])
                       {
                        this.m_list_forms.Clear();
                        this.SetBaseObj(base_type,base_name,base_chart_id,base_subwindow,base_pivots,ctrl_form_size,base_x,base_y,base_time,base_price);
                        this.CreateAllControlPointForm();
                       }
                     CGStdGraphObjExtToolkit(){;}
                    ~CGStdGraphObjExtToolkit(){;}
  };
//+------------------------------------------------------------------+
//| Set the base object parameters of the                            |
//| composite graphical object                                       |
//+------------------------------------------------------------------+
void CGStdGraphObjExtToolkit::SetBaseObj(const ENUM_OBJECT base_type,const string base_name,
                                         const long base_chart_id,const int base_subwindow,
                                         const int base_pivots,const int ctrl_form_size,
                                         const int base_x,const int base_y,
                                         const datetime &base_time[],const double &base_price[])
  {
   this.m_base_chart_id=base_chart_id;       // Base graphical object chart ID
   this.m_base_subwindow=base_subwindow;     // Base graphical object chart subwindow
   this.m_base_type=base_type;               // Base object type
   this.m_base_name=base_name;               // Base object name
   this.m_base_pivots=base_pivots;           // Number of base object reference points
   this.m_base_x=base_x;                     // Base object X coordinate
   this.m_base_y=base_y;                     // Base object Y coordinate
   this.SetControlFormSize(ctrl_form_size);  // Size of forms for managing reference points
   
   if(this.m_base_type==OBJ_LABEL            || this.m_base_type==OBJ_BUTTON  ||
      this.m_base_type==OBJ_BITMAP_LABEL     || this.m_base_type==OBJ_EDIT    ||
      this.m_base_type==OBJ_RECTANGLE_LABEL  || this.m_base_type==OBJ_CHART)
      return;
   
   if(::ArraySize(base_time)==0)
     {
      CMessage::ToLog(DFUN+"base_time: ",MSG_CANV_ELEMENT_ERR_EMPTY_ARRAY);
      return;
     }
   if(::ArraySize(base_price)==0)
     {
      CMessage::ToLog(DFUN+"base_price: ",MSG_CANV_ELEMENT_ERR_EMPTY_ARRAY);
      return;
     }
   if(::ArrayResize(this.m_base_time,this.m_base_pivots)!=this.m_base_pivots)
     {
      CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_EXT_FAILED_ARR_RESIZE_TIME_DATA);
      return;
     }
   if(::ArrayResize(this.m_base_price,this.m_base_pivots)!=this.m_base_pivots)
     {
      CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_EXT_FAILED_ARR_RESIZE_PRICE_DATA);
      return;
     }
   for(int i=0;i<this.m_base_pivots;i++)
     {
      this.m_base_time[i]=base_time[i];      // Time (i) of the base object pivot point
      this.m_base_price[i]=base_price[i];    // Price (i) of the base object pivot point
     }
  }
//+------------------------------------------------------------------+
//|Set the size of reference points for managing pivot points        |
//+------------------------------------------------------------------+
void CGStdGraphObjExtToolkit::SetControlFormSize(const int size)
  {
   this.m_ctrl_form_size=(size>254 ? 255 : size<5 ? 5 : size%2==0 ? size+1 : size);
   this.m_shift=(int)::ceil(this.m_ctrl_form_size/2)+1;
  }
//+------------------------------------------------------------------+
//| Set the time coordinate of the base object                       |
//+------------------------------------------------------------------+
void CGStdGraphObjExtToolkit::SetBaseObjTime(const datetime time,const int index)
  {
   if(index>this.m_base_pivots-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_REQUEST_OUTSIDE_ARRAY);
      return;
     }
   this.m_base_time[index]=time;
  }
//+------------------------------------------------------------------+
//| Set the coordinate of the base object price                      |
//+------------------------------------------------------------------+
void CGStdGraphObjExtToolkit::SetBaseObjPrice(const double price,const int index)
  {
   if(index>this.m_base_pivots-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_REQUEST_OUTSIDE_ARRAY);
      return;
     }
   this.m_base_price[index]=price;
  }
//+------------------------------------------------------------------+
//| Set the time and price coordinates of the base object            |
//+------------------------------------------------------------------+
void CGStdGraphObjExtToolkit::SetBaseObjTimePrice(const datetime time,const double price,const int index)
  {
   if(index>this.m_base_pivots-1)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_REQUEST_OUTSIDE_ARRAY);
      return;
     }
   this.m_base_time[index]=time;
   this.m_base_price[index]=price;
  }
//+------------------------------------------------------------------+
//| Return the X and Y coordinates of the specified pivot point      |
//| of the graphical object in screen coordinates                    |
//+------------------------------------------------------------------+
bool CGStdGraphObjExtToolkit::GetControlPointCoordXY(const int index,int &x,int &y)
  {
//--- Declare form objects, from which we are to receive their screen coordinates
   CFormControl *form0=NULL, *form1=NULL;
//--- Set X and Y to zero - these values will be received in case of a failure
   x=0;
   y=0;
//--- Depending on the graphical object type
   switch(this.m_base_type)
     {
      //--- Objects drawn using screen coordinates
      case OBJ_LABEL             :
      case OBJ_BUTTON            :
      case OBJ_BITMAP_LABEL      :
      case OBJ_EDIT              :
      case OBJ_RECTANGLE_LABEL   :
      case OBJ_CHART             :
        //--- Write object screen coordinates and return 'true'
        x=this.m_base_x;
        y=this.m_base_y;
        return true;
      
      //--- One pivot point (price only)
      case OBJ_HLINE             : break;
      
      //--- One pivot point (time only)
      case OBJ_VLINE             :
      case OBJ_EVENT             : break;
      
      //--- One reference point (time/price)
      case OBJ_TEXT              :
      case OBJ_BITMAP            : break;
      
      //--- Two pivot points and a central one
      //--- Lines
      case OBJ_TREND             :
      case OBJ_TRENDBYANGLE      :
      case OBJ_CYCLES            :
      case OBJ_ARROWED_LINE      :
      //--- Channels
      case OBJ_CHANNEL           :
      case OBJ_STDDEVCHANNEL     :
      case OBJ_REGRESSION        :
      //--- Gann
      case OBJ_GANNLINE          :
      case OBJ_GANNGRID          :
      //--- Fibo
      case OBJ_FIBO              :
      case OBJ_FIBOTIMES         :
      case OBJ_FIBOFAN           :
      case OBJ_FIBOARC           :
      case OBJ_FIBOCHANNEL       :
      case OBJ_EXPANSION         :
        //--- Calculate coordinates for forms on the line pivot points
        if(index<this.m_base_pivots)
           return(::ChartTimePriceToXY(this.m_base_chart_id,this.m_base_subwindow,this.m_base_time[index],this.m_base_price[index],x,y) ? true : false);
        //--- Calculate the coordinates for the central form located between the line pivot points
        else
          {
           form0=this.GetControlPointForm(0);
           form1=this.GetControlPointForm(1);
           if(form0==NULL || form1==NULL)
              return false;
           x=(form0.CoordX()+this.m_shift+form1.CoordX()+this.m_shift)/2;
           y=(form0.CoordY()+this.m_shift+form1.CoordY()+this.m_shift)/2;
           return true;
          }

      //--- Channels
      case OBJ_PITCHFORK         : break;
      
      //--- Gann
      case OBJ_GANNFAN           : break;
      
      //--- Elliott
      case OBJ_ELLIOTWAVE5       : break;
      case OBJ_ELLIOTWAVE3       : break;
      
      //--- Shapes
      case OBJ_RECTANGLE         : break;
      case OBJ_TRIANGLE          : break;
      case OBJ_ELLIPSE           : break;
      
      //--- Arrows
      case OBJ_ARROW_THUMB_UP    : break;
      case OBJ_ARROW_THUMB_DOWN  : break;
      case OBJ_ARROW_UP          : break;
      case OBJ_ARROW_DOWN        : break;
      case OBJ_ARROW_STOP        : break;
      case OBJ_ARROW_CHECK       : break;
      case OBJ_ARROW_LEFT_PRICE  : break;
      case OBJ_ARROW_RIGHT_PRICE : break;
      case OBJ_ARROW_BUY         : break;
      case OBJ_ARROW_SELL        : break;
      case OBJ_ARROW             : break;
      
      //---
      default                    : break;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Return the pointer to the pivot point form by name               |
//+------------------------------------------------------------------+
CFormControl *CGStdGraphObjExtToolkit::GetControlPointForm(const string name,int &index)
  {
   index=WRONG_VALUE;
   for(int i=0;i<this.m_list_forms.Total();i++)
     {
      CFormControl *form=this.m_list_forms.At(i);
      if(form==NULL)
         continue;
      if(form.Name()==name)
        {
         index=i;
         return form;
        }
     }
   return NULL;
  }
//+------------------------------------------------------------------+
//| Create a form object on a base object reference point            |
//+------------------------------------------------------------------+
CFormControl *CGStdGraphObjExtToolkit::CreateNewControlPointForm(const int index)
  {
   string name=this.m_base_name+"_CP_"+(index<this.m_base_pivots ? (string)index : "X");
   CFormControl *form=this.GetControlPointForm(index);
   if(form!=NULL)
      return NULL;
   int x=0, y=0;
   if(!this.GetControlPointCoordXY(index,x,y))
      return NULL;
   form=new CFormControl(this.m_base_chart_id,this.m_base_subwindow,name,index,x-this.m_shift,y-this.m_shift,this.GetControlFormSize(),this.GetControlFormSize());
//--- Set all the necessary properties for the created form object
   if(form!=NULL)
      this.SetControlFormParams(form,index);
   return form;
  }
//+------------------------------------------------------------------+
//| Create form objects on the base object pivot points              |
//+------------------------------------------------------------------+
bool CGStdGraphObjExtToolkit::CreateAllControlPointForm(void)
  {
   bool res=true;
//--- In the loop by the number of base object pivot points
   for(int i=0;i<=this.m_base_pivots;i++)
     {
      //--- Create a new form object on the current pivot point corresponding to the loop index
      CFormControl *form=this.CreateNewControlPointForm(i);
      //--- If failed to create the form, inform of that and add 'false' to the final result
      if(form==NULL)
        {
         CMessage::ToLog(DFUN,MSG_GRAPH_OBJ_EXT_FAILED_CREATE_CTRL_POINT_FORM);
         res &=false;
        }
      //--- If failed to add the form to the list, inform of that, remove the created form and add 'false' to the final result
      if(!this.m_list_forms.Add(form))
        {
         CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST);
         delete form;
         res &=false;
        }
     }
//--- Redraw the chart for displaying changes (if successful) and return the final result
   if(res)
      ::ChartRedraw(this.m_base_chart_id);
   return res;
  }
//+------------------------------------------------------------------+
//| Set the parameters of a form object for managing pivot points    |
//+------------------------------------------------------------------+
void CGStdGraphObjExtToolkit::SetControlFormParams(CFormControl *form,const int index)
  {
   form.SetBelong(GRAPH_OBJ_BELONG_PROGRAM);                // Object is created programmatically
   form.SetActive(true);                                    // Form object is active
   form.SetMovable(true);                                   // Movable object
   int x=(int)::floor((form.Width()-CTRL_POINT_RADIUS*2)/2);// Active area shift from the form edge
   form.SetActiveAreaShift(x,x,x,x);                        // Object active area is located in the center of the form, its size is equal to the two CTRL_POINT_RADIUS values
   form.SetFlagSelected(false,false);                       // Object is not selected
   form.SetFlagSelectable(false,false);                     // Object cannot be selected by mouse
   form.Erase(CLR_CANV_NULL,0);                             // Fill in the form with transparent color and set the full transparency
   //form.DrawRectangle(0,0,form.Width()-1,form.Height()-1,clrSilver);    // Draw an outlining rectangle for visual display of the form location
   //form.DrawRectangle(x,x,form.Width()-x-1,form.Height()-x-1,clrSilver);// Draw an outlining rectangle for visual display of the form active area location
   form.SetID(index+1);                                     // Set the form ID
   form.SetControlPointDrawnFlag(false);                    // Set the flag that the pivot point is not drawn on the form
   form.Done();                                             // Save the initial form object state (its appearance)
  }
//+------------------------------------------------------------------+
//| Draw a reference point on the form                               |
//+------------------------------------------------------------------+
void CGStdGraphObjExtToolkit::DrawControlPoint(CFormControl *form,const uchar opacity,const color clr)
  {
   if(form==NULL)
      return;
   int c=int(::floor(form.Width()/2));                      // Form center (coordinates)
   form.DrawCircle(c,c,CTRL_POINT_RADIUS,clr,opacity);      // Draw a circle at the form center
   form.DrawCircleFill(c,c,2,clr,opacity);                  // Draw a point at the form center
   form.SetControlPointDrawnFlag(opacity>0 ? true : false); // Set the flag that the pivot point is drawn on the form
  }
//+------------------------------------------------------------------+
//| Draw a control point on the form,                                |
//| remove it on all other forms                                     |
//+------------------------------------------------------------------+
void CGStdGraphObjExtToolkit::DrawOneControlPoint(CFormControl *form,const uchar opacity=255,const color clr=CTRL_POINT_COLOR)
  {
   this.DrawControlPoint(form,opacity,clr);
   for(int i=0;i<this.GetNumControlPointForms();i++)
     {
      CFormControl *ctrl=this.GetControlPointForm(i);
      if(ctrl==NULL || ctrl.ID()==form.ID())
         continue;
      this.ClearControlPoint(ctrl);
     }
  }
//+------------------------------------------------------------------+
//| Remove all form objects from the list                            |
//+------------------------------------------------------------------+
void CGStdGraphObjExtToolkit::DeleteAllControlPointForm(void)
  {
   this.m_list_forms.Clear();
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CGStdGraphObjExtToolkit::OnChartEvent(const int id,const long& lparam,const double& dparam,const string& sparam)
  {
   if(id==CHARTEVENT_CHART_CHANGE)
     {
      for(int i=0;i<this.m_list_forms.Total();i++)
        {
         CFormControl *form=this.m_list_forms.At(i);
         if(form==NULL)
            continue;
         int x=0, y=0;
         if(!this.GetControlPointCoordXY(i,x,y))
            continue;
         form.SetCoordX(x-this.m_shift);
         form.SetCoordY(y-this.m_shift);
         form.Update();
        }
      ::ChartRedraw(this.m_base_chart_id);
     }
  }
//+------------------------------------------------------------------+
