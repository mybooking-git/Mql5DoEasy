//+------------------------------------------------------------------+
//|                                                    FrameText.mqh |
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
#include "Frame.mqh"
//+------------------------------------------------------------------+
//| Single text animation frame class                                |
//+------------------------------------------------------------------+
class CFrameText : public CFrame
  {
private:

public:
//--- Display the text on the background while saving and restoring the background
   bool              TextOnBG(const string text,const int x,const int y,const ENUM_FRAME_ANCHOR anchor,const color clr,const uchar opacity,bool redraw=false);

//--- Constructors
                     CFrameText() { this.m_type=OBJECT_DE_TYPE_GFRAME_TEXT; }
                     CFrameText(const int id,CGCnvElement *element) : CFrame(id,0,0,"",element) { this.m_type=OBJECT_DE_TYPE_GFRAME_TEXT; }
  };
//+--------------------------------------------------------------------------------+
//| Display the text on the background, while saving and restoring the background  |
//+--------------------------------------------------------------------------------+
bool CFrameText::TextOnBG(const string text,const int x,const int y,const ENUM_FRAME_ANCHOR anchor,const color clr,const uchar opacity,bool redraw=false)
  {
//--- Find out the width and height of the text outlining the rectangle (to be used as the size of the saved area)
   int w=0,h=0;
   this.m_element.TextSize(text,w,h);
//--- Calculate coordinate offsets for the saved area depending on the text anchor point
   int shift_x=0,shift_y=0;
   this.m_element.GetShiftXYbySize(w,h,anchor,shift_x,shift_y);
//--- If the pixel array is not empty, the background under the text has already been saved -
//--- restore the previously saved background (by the previous coordinates and offsets)
   if(::ArraySize(this.m_array)>0)
     {
      if(!CPixelCopier::CopyImgDataToCanvas(int(this.m_x_last+this.m_shift_x_prev),int(this.m_y_last+this.m_shift_y_prev)))
         return false;
     }
//--- If a background area with calculated coordinates and size under the future text is successfully saved
   if(!CPixelCopier::CopyImgDataToArray(x+shift_x,y+shift_y,w,h))
      return false;
//--- Draw the text and update the element
   this.m_element.Text(x,y,text,clr,opacity,anchor);
   this.m_element.Update(redraw);
   this.m_anchor_last=anchor;
   this.m_x_last=x;
   this.m_y_last=y;
   this.m_shift_x_prev=shift_x;
   this.m_shift_y_prev=shift_y;
   return true;
  }
//+------------------------------------------------------------------+
