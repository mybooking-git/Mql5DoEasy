//+------------------------------------------------------------------+
//|                                                        Frame.mqh |
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
#include "..\GCnvElement.mqh"
//+------------------------------------------------------------------+
//| Pixel copier class                                               |
//+------------------------------------------------------------------+
class CPixelCopier : public CObject
  {
protected:
   CGCnvElement     *m_element;                             // Pointer to the graphical element
   uint              m_array[];                             // Pixel array
   int               m_id;                                  // ID
   int               m_x;                                   // X coordinate of the upper left corner
   int               m_y;                                   // Y coordinate of the upper left corner
   int               m_w;                                   // Copied image width
   int               m_h;                                   // Copied image height
   int               m_wr;                                  // Calculated copied image width
   int               m_hr;                                  // Calculated copied image height
public:
//--- Compare CPixelCopier objects by a specified property (to sort the list by an object property)
   virtual int       Compare(const CObject *node,const int mode=0) const
                       {
                        const CPixelCopier *obj_compared=node;
                        return(mode==0 ? (this.ID()>obj_compared.ID() ? 1 : this.ID()<obj_compared.ID() ? -1 : 0) : WRONG_VALUE);
                       }
   
//--- Set the properties
   void              SetElement(CGCnvElement *element)         { this.m_element=element;  }
   void              SetID(const int id)                       { this.m_id=id;            }
   void              SetCoordX(const int value)                { this.m_x=value;          }
   void              SetCoordY(const int value)                { this.m_y=value;          }
   void              SetWidth(const int value)                 { this.m_w=value;          }
   void              SetHeight(const int value)                { this.m_h=value;          }
//--- Get the properties
   int               ID(void)                            const { return this.m_id;        }
   int               CoordX(void)                        const { return this.m_x;         }
   int               CoordY(void)                        const { return this.m_y;         }
   int               Width(void)                         const { return this.m_w;         }
   int               Height(void)                        const { return this.m_h;         }
   int               WidthReal(void)                     const { return this.m_wr;        }
   int               HeightReal(void)                    const { return this.m_hr;        }

//--- Copy the part or the entire image to the array
   bool              CopyImgDataToArray(const uint x_coord,const uint y_coord,uint width,uint height);
//--- Copy the part or the entire image from the array to the canvas
   bool              CopyImgDataToCanvas(const int x_coord,const int y_coord);

//--- Constructors
                     CPixelCopier (void){;}
                     CPixelCopier (const int id,
                                   const int x,
                                   const int y,
                                   const int w,
                                   const int h,
                                   CGCnvElement *element) : m_id(id), m_x(x),m_y(y),m_w(w),m_wr(w),m_h(h),m_hr(h) { this.m_element=element; }
                    ~CPixelCopier (void){;}
  };
//+------------------------------------------------------------------+
//| Copy part or all of the image to the array                       |
//+------------------------------------------------------------------+
bool CPixelCopier::CopyImgDataToArray(const uint x_coord,const uint y_coord,uint width,uint height)
  {
//--- Assign coordinate values, passed to the method, to the variables
   int x1=(int)x_coord;
   int y1=(int)y_coord;
//--- If X coordinates goes beyond the form on the right or Y coordinate goes beyond the form at the bottom,
//--- there is nothing to copy, the copied area is outside the form. Return 'false'
   if(x1>this.m_element.Width()-1 || y1>this.m_element.Height()-1)
      return false;
//--- Assign the width and height values of the copied area to the variables
//--- If the passed width and height are equal to zero, assign the form width and height to them
   this.m_wr=int(width==0  ? this.m_element.Width()  : width);
   this.m_hr=int(height==0 ? this.m_element.Height() : height);

//--- Calculate the right X coordinate and lower Y coordinate of the rectangular area
   int x2=int(x1+this.m_wr-1);
   int y2=int(y1+this.m_hr-1);
//--- If the calculated X coordinate goes beyond the form, the right edge of the form will be used as the coordinate
   if(x2>=this.m_element.Width()-1)
      x2=this.m_element.Width()-1;
//--- If the calculated Y coordinate goes beyond the form, the bottom edge of the form will be used as the coordinate
   if(y2>=this.m_element.Height()-1)
      y2=this.m_element.Height()-1;
//--- Calculate the copied width and height
   this.m_wr=x2-x1+1;
   this.m_hr=y2-y1+1;
//--- Define the necessary size of the array, which is to store all image pixels with calculated width and height
   int size=this.m_wr*this.m_hr;
//--- If failed to set the array size, inform of that and return 'false'
   if(::ArrayResize(this.m_array,size)!=size)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_ARRAY_RESIZE,true);
      return false;
     }
//--- Set the index in the array for recording the image pixel
   int n=0;
//--- In a loop by the calculated height of the copied area, starting from the specified Y coordinate
   for(int y=y1;y<y1+this.m_hr;y++)
     {
      //--- in a loop by the calculated width of the copied area, starting from the specified X coordinate
      for(int x=x1;x<x1+this.m_wr;x++)
        {
         //--- Copy the next image pixel to the array and increase the array index
         this.m_array[n]=this.m_element.GetCanvasObj().PixelGet(x,y);
         n++;
        }
     }
//--- Successful - return 'true'
   return true;
  }
//+------------------------------------------------------------------+
//| Copy the part or the entire image from the array to the canvas   |
//+------------------------------------------------------------------+
bool CPixelCopier::CopyImgDataToCanvas(const int x_coord,const int y_coord)
  {
//--- If the array of saved pixels is empty, inform of that and return 'false'
   int size=::ArraySize(this.m_array);
   if(size==0)
     {
      CMessage::ToLog(DFUN,MSG_CANV_ELEMENT_ERR_EMPTY_ARRAY,true);
      return false;
     }
//--- Set the index of the array for reading the image pixel
   int n=0;
//--- In a loop by the previously calculated height of the copied area, starting from the specified Y coordinate
   for(int y=y_coord;y<y_coord+this.m_hr;y++)
     {
      //--- in a loop by the previously calculated width of the copied area, starting from the specified X coordinate
      for(int x=x_coord;x<x_coord+this.m_wr;x++)
        {
         //--- Restore the next image pixel from the array and increase the array index
         this.m_element.GetCanvasObj().PixelSet(x,y,this.m_array[n]);
         n++;
        }
     }
   return true;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Single animation frame class                                     |
//+------------------------------------------------------------------+
class CFrame : public CPixelCopier
  {
protected:
   ENUM_ANIMATION_FRAME_TYPE m_frame_figure_type;           // Type of the figure drawn by the frame
   ENUM_FRAME_ANCHOR m_anchor_last;                         // Last frame anchor point
   double            m_x_last;                              // X coordinate of the upper left corner of the last frame
   double            m_y_last;                              // Y coordinate of the upper left corner of the last frame
   int               m_shift_x_prev;                        // Offset of the X coordinate of the last frame upper left corner
   int               m_shift_y_prev;                        // Offset of the Y coordinate of the last frame upper left corner
   int               m_type;                                // Object type
//--- Set the coordinates and offset of the outlining rectangle as the previous ones
   void              SetLastParams(const double quad_x,const double quad_y,const int shift_x,const int shift_y,const ENUM_FRAME_ANCHOR anchor=FRAME_ANCHOR_LEFT_TOP);
//--- Save and restore the background under the image
   virtual bool      SaveRestoreBG(void)                    { return false;                     }
   
public:
//--- Reset the pixel array
   void              ResetArray(void)                       { ::ArrayResize(this.m_array,0);    }
   
//--- Return the last (1) anchor point, (2) X and (3) Y coordinate,
//--- previous offset by (4) X and (5) Y, (6) type of the figure drawn by the frame
   ENUM_FRAME_ANCHOR LastAnchor(void)                 const { return this.m_anchor_last;        }
   double            LastX(void)                      const { return this.m_x_last;             }
   double            LastY(void)                      const { return this.m_y_last;             }
   int               LastShiftX(void)                 const { return this.m_shift_x_prev;       }
   int               LastShiftY(void)                 const { return this.m_shift_y_prev;       }
   ENUM_ANIMATION_FRAME_TYPE FrameFigureType(void)    const { return this.m_frame_figure_type;  }
//--- Return an object type
   virtual int       Type(void)                       const { return this.m_type;               }
   
//--- Default constructor
                     CFrame(){ this.m_type=OBJECT_DE_TYPE_GFRAME; }
protected:
//--- Text frame constructor
                     CFrame(const int id,
                            const int x,
                            const int y,
                            const string text,
                            CGCnvElement *element);
//--- Rectangular frame constructor
                     CFrame(const int id,
                            const int x,
                            const int y,
                            const int w,
                            const int h,
                            CGCnvElement *element);
//--- Geometric frame constructor
                     CFrame(const int id,
                            const int x,
                            const int y,
                            const int len,
                            CGCnvElement *element);
  };
//+------------------------------------------------------------------+
//| Constructor of rectangular frames                                |
//+------------------------------------------------------------------+
CFrame::CFrame(const int id,const int x,const int y,const int w,const int h,CGCnvElement *element) : CPixelCopier(id,x,y,w,h,element)
  {
   this.m_type=OBJECT_DE_TYPE_GFRAME; 
   this.m_frame_figure_type=ANIMATION_FRAME_TYPE_QUAD;
   this.m_anchor_last=FRAME_ANCHOR_LEFT_TOP;
   this.m_x_last=x;
   this.m_y_last=y;
   this.m_shift_x_prev=0;
   this.m_shift_y_prev=0;
  }
//+------------------------------------------------------------------+
//| The constructor of text frames                                   |
//+------------------------------------------------------------------+
CFrame::CFrame(const int id,
               const int x,
               const int y,
               const string text,
               CGCnvElement *element)
  {
   this.m_type=OBJECT_DE_TYPE_GFRAME; 
   int w=0,h=0;
   this.m_element=element;
   this.m_element.GetCanvasObj().TextSize(text,w,h);
   this.m_anchor_last=this.m_element.TextAnchor();
   this.m_frame_figure_type=ANIMATION_FRAME_TYPE_TEXT;
   this.m_x_last=x;
   this.m_y_last=y;
   this.m_shift_x_prev=0;
   this.m_shift_y_prev=0;
   CPixelCopier::SetID(id);
   CPixelCopier::SetCoordX(x);
   CPixelCopier::SetCoordY(y);
   CPixelCopier::SetWidth(w);
   CPixelCopier::SetHeight(h);
  }
//+------------------------------------------------------------------+
//| Geometric frame constructor                                      |
//+------------------------------------------------------------------+
CFrame::CFrame(const int id,const int x,const int y,const int len,CGCnvElement *element) : CPixelCopier(id,x,y,len,len,element)
  {
   this.m_type=OBJECT_DE_TYPE_GFRAME; 
   this.m_frame_figure_type=ANIMATION_FRAME_TYPE_GEOMETRY;
   this.m_anchor_last=FRAME_ANCHOR_LEFT_TOP;
   this.m_x_last=x;
   this.m_y_last=y;
   this.m_shift_x_prev=0;
   this.m_shift_y_prev=0;
  }
//+------------------------------------------------------------------+
//| Set the coordinates and the offset                               |
//| of the outlining rectangle as the previous ones                  |
//+------------------------------------------------------------------+
void CFrame::SetLastParams(const double quad_x,const double quad_y,const int shift_x,const int shift_y,const ENUM_FRAME_ANCHOR anchor=FRAME_ANCHOR_LEFT_TOP)
  {
   this.m_anchor_last=anchor;
   this.m_x_last=quad_x;
   this.m_y_last=quad_y;
   this.m_shift_x_prev=shift_x;
   this.m_shift_y_prev=shift_y;
  }
//+------------------------------------------------------------------+
