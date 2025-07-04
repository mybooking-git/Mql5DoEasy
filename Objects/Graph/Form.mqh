//+------------------------------------------------------------------+
//|                                                         Form.mqh |
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
#include "GCnvElement.mqh"
#include "ShadowObj.mqh"
#include "Animations\Animations.mqh"
#include "..\..\Services\MouseState.mqh"
//+------------------------------------------------------------------+
//| Form object class                                                |
//+------------------------------------------------------------------+
class CForm : public CGCnvElement
  {
private:
   CArrayObj         m_list_elements;                          // List of attached elements
   CAnimations      *m_animations;                             // Pointer to the animation object
   CShadowObj       *m_shadow_obj;                             // Pointer to the shadow object
   CMouseState       m_mouse;                                  // "Mouse status" class object
   ENUM_MOUSE_FORM_STATE m_mouse_form_state;                   // Mouse status relative to the form
   ushort            m_mouse_state_flags;                      // Mouse status flags
   color             m_color_frame;                            // Form frame color
   int               m_frame_width_left;                       // Form frame width to the left
   int               m_frame_width_right;                      // Form frame width to the right
   int               m_frame_width_top;                        // Form frame width at the top
   int               m_frame_width_bottom;                     // Form frame width at the bottom
   int               m_offset_x;                               // Offset of the X coordinate relative to the cursor
   int               m_offset_y;                               // Offset of the Y coordinate relative to the cursor
   
//--- Initialize the variables
   void              Initialize(void);
//--- Reset the array size of (1) text, (2) rectangular and (3) geometric animation frames
   void              ResetArrayFrameT(void);
   void              ResetArrayFrameQ(void);
   void              ResetArrayFrameG(void);
   
//--- Return the name of the dependent object
   string            CreateNameDependentObject(const string base_name)  const
                       { return ::StringSubstr(this.NameObj(),::StringLen(::MQLInfoString(MQL_PROGRAM_NAME))+1)+"_"+base_name;   }
  
//--- Create a new graphical object
   CGCnvElement     *CreateNewGObject(const ENUM_GRAPH_ELEMENT_TYPE type,
                                      const int element_num,
                                      const string name,
                                      const int x,
                                      const int y,
                                      const int w,
                                      const int h,
                                      const color colour,
                                      const uchar opacity,
                                      const bool movable,
                                      const bool activity);

//--- Create a shadow object
   void              CreateShadowObj(const color colour,const uchar opacity);
   
public:
//--- Return (1) the mouse status relative to the form, as well as (2) X and (3) Y coordinate of the cursor
   ENUM_MOUSE_FORM_STATE MouseFormState(const int id,const long lparam,const double dparam,const string sparam);
   int               MouseCursorX(void)            const { return this.m_mouse.CoordX();  }
   int               MouseCursorY(void)            const { return this.m_mouse.CoordY();  }
//--- Set the flags of mouse scrolling, context menu and the crosshairs tool for the chart
   void              SetChartTools(const bool flag);
//--- (1) Set and (2) return the shift of X and Y coordinates relative to the cursor
   void              SetOffsetX(const int value)         { this.m_offset_x=value;         }
   void              SetOffsetY(const int value)         { this.m_offset_y=value;         }
   int               OffsetX(void)                 const { return this.m_offset_x;        }
   int               OffsetY(void)                 const { return this.m_offset_y;        }
   
//--- Event handler
   virtual void      OnChartEvent(const int id,const long& lparam,const double& dparam,const string& sparam);
//--- Constructors
                     CForm(const long chart_id,
                           const int subwindow,
                           const string name,
                           const int x,
                           const int y,
                           const int w,
                           const int h);
                     CForm(const int subwindow,
                           const string name,
                           const int x,
                           const int y,
                           const int w,
                           const int h);
                     CForm(const string name,
                           const int x,
                           const int y,
                           const int w,
                           const int h);
                     CForm() { this.m_type=OBJECT_DE_TYPE_GFORM; this.Initialize(); }
//--- Destructor
                    ~CForm();
                           
//--- Supported form properties (1) integer and (2) string ones
   virtual bool      SupportProperty(ENUM_CANV_ELEMENT_PROP_INTEGER property) { return true;                   }
   virtual bool      SupportProperty(ENUM_CANV_ELEMENT_PROP_STRING property)  { return true;                   }
   
//--- Return (1) the list of attached objects and (2) the shadow object
   CForm            *GetObject(void)                                          { return &this;                  }
   CArrayObj        *GetList(void)                                            { return &this.m_list_elements;  }
   CGCnvElement     *GetShadowObj(void)                                       { return this.m_shadow_obj;      }
//--- Return the pointer to (1) the animation object, the list of (2) text and (3) rectangular animation frames
   CAnimations      *GetAnimationsObj(void)                                   { return this.m_animations;      }
   CArrayObj        *GetListFramesText(void)
                       { return(this.m_animations!=NULL ? this.m_animations.GetListFramesText() : NULL);       }
   CArrayObj        *GetListFramesQuad(void)
                       { return(this.m_animations!=NULL ? this.m_animations.GetListFramesQuad() : NULL);       }

//--- Set the form (1) color scheme and (2) style
   virtual void      SetColorTheme(const ENUM_COLOR_THEMES theme,const uchar opacity);
   virtual void      SetFormStyle(const ENUM_FORM_STYLE style,
                                  const ENUM_COLOR_THEMES theme,
                                  const uchar opacity,
                                  const bool shadow=false,
                                  const bool use_bg_color=true,
                                  const bool redraw=false);
   
//--- Create a new attached element
   bool              CreateNewElement(const int element_num,
                                      const string name,
                                      const int x,
                                      const int y,
                                      const int w,
                                      const int h,
                                      const color colour,
                                      const uchar opacity,
                                      const bool movable,
                                      const bool activity);

//--- Draw an object shadow
   void              DrawShadow(const int shift_x,const int shift_y,const color colour,const uchar opacity=127,const uchar blur=4);

//--- Draw the form frame
   void              DrawFormFrame(const int wd_top,                          // Frame upper segment width
                                   const int wd_bottom,                       // Frame lower segment width
                                   const int wd_left,                         // Frame left segment width
                                   const int wd_right,                        // Frame right segment width
                                   const color colour,                        // Frame color
                                   const uchar opacity,                       // Frame opacity
                                   const ENUM_FRAME_STYLE style);             // Frame style
//--- Draw a simple frame
   void              DrawFrameSimple(const int x,                             // X coordinate relative to the form
                                     const int y,                             // Y coordinate relative to the form
                                     const int width,                         // Frame width
                                     const int height,                        // Frame height
                                     const int wd_top,                        // Frame upper segment width
                                     const int wd_bottom,                     // Frame lower segment width
                                     const int wd_left,                       // Frame left segment width
                                     const int wd_right,                      // Frame right segment width
                                     const color colour,                      // Frame color
                                     const uchar opacity);                    // Frame opacity
//--- Draw a flat frame
   void              DrawFrameFlat(const int x,                               // X coordinate relative to the form
                                   const int y,                               // Y coordinate relative to the form
                                   const int width,                           // Frame width
                                   const int height,                          // Frame height
                                   const int wd_top,                          // Frame upper segment width
                                   const int wd_bottom,                       // Frame lower segment width
                                   const int wd_left,                         // Frame left segment width
                                   const int wd_right,                        // Frame right segment width
                                   const color colour,                        // Frame color
                                   const uchar opacity);                      // Frame opacity

//--- Draw an embossed (convex) frame
   void              DrawFrameBevel(const int x,                              // X coordinate relative to the form
                                    const int y,                              // Y coordinate relative to the form
                                    const int width,                          // Frame width
                                    const int height,                         // Frame height
                                    const int wd_top,                         // Frame upper segment width
                                    const int wd_bottom,                      // Frame lower segment width
                                    const int wd_left,                        // Frame left segment width
                                    const int wd_right,                       // Frame right segment width
                                    const color colour,                       // Frame color
                                    const uchar opacity);                     // Frame opacity

//--- Draw an embossed (concave) frame
   void              DrawFrameStamp(const int x,                              // X coordinate relative to the form
                                    const int y,                              // Y coordinate relative to the form
                                    const int width,                          // Frame width
                                    const int height,                         // Frame height
                                    const int wd_top,                         // Frame upper segment width
                                    const int wd_bottom,                      // Frame lower segment width
                                    const int wd_left,                        // Frame left segment width
                                    const int wd_right,                       // Frame right segment width
                                    const color colour,                       // Frame color
                                    const uchar opacity);                     // Frame opacity

//--- Draw a simple field
   void              DrawFieldFlat(const int x,                               // X coordinate relative to the form
                                   const int y,                               // Y coordinate relative to the form
                                   const int width,                           // Field width
                                   const int height,                          // Field height
                                   const color colour,                        // Field color
                                   const uchar opacity);                      // Field opacity

//--- Draw an embossed (convex) field
   void              DrawFieldBevel(const int x,                              // X coordinate relative to the form
                                    const int y,                              // Y coordinate relative to the form
                                    const int width,                          // Field width
                                    const int height,                         // Field height
                                    const color colour,                       // Field color
                                    const uchar opacity);                     // Field opacity

//--- Draw an embossed (concave) field
   void              DrawFieldStamp(const int x,                              // X coordinate relative to the form
                                    const int y,                              // Y coordinate relative to the form
                                    const int width,                          // Field width
                                    const int height,                         // Field height
                                    const color colour,                       // Field color
                                    const uchar opacity);                     // Field opacity

//--- Capture the appearance of the created form
   void              Done(void)     { CGCnvElement::CanvasUpdate(false); CGCnvElement::ResourceStamp(DFUN);                   }
//--- Restore the resource from the array
   virtual bool      Reset(void);

//+------------------------------------------------------------------+
//| Methods of working with image pixels                             |
//+------------------------------------------------------------------+
//--- Create a new (1) rectangular and (2) text animation frame object
   bool              CreateNewFrameText(const int id,const int x_coord,const int y_coord,const string text)
                       { return(this.m_animations!=NULL ? this.m_animations.CreateNewFrameText(id)!=NULL : false);            }
                       
   bool              CreateNewFrameQuad(const int id,const int x_coord,const int y_coord,const int width,const int height)
                       { return(this.m_animations!=NULL ? this.m_animations.CreateNewFrameQuad(id)!=NULL : false);            }
                       
//--- Return the frame object of the (1) text and (2) rectangular animation by ID
   CFrame           *GetFrameText(const int id)
                       { return(this.m_animations!=NULL ? this.m_animations.GetFrame(ANIMATION_FRAME_TYPE_TEXT,id) : NULL);   }
                       
   CFrame           *GetFrameQuad(const int id)
                       { return(this.m_animations!=NULL ? this.m_animations.GetFrame(ANIMATION_FRAME_TYPE_QUAD,id) : NULL);   }
                       
//--- Display the text on the background while saving and restoring the background
   bool              TextOnBG(const int id,
                              const string text,
                              const int x,
                              const int y,
                              const ENUM_FRAME_ANCHOR anchor,
                              const color clr,
                              const uchar opacity=255,
                              const bool create_new=true,
                              const bool redraw=false)
                       { return(this.m_animations!=NULL ? this.m_animations.TextOnBG(id,text,x,y,anchor,clr,opacity,create_new,redraw) : false);  }

//--- Set the color of the point with the specified coordinates while saving and restoring the background
   bool              SetPixelOnBG(const int id,const int x,const int y,const color clr,const uchar opacity=255,const bool create_new=true,const bool redraw=false)
                       { return(this.m_animations!=NULL ? this.m_animations.SetPixelOnBG(id,x,y,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a segment of a vertical line
   bool              DrawLineVerticalOnBG(const int id,                 // Frame ID
                              const int   x,                            // Segment X coordinate
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawLineVerticalOnBG(id,x,y1,y2,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a segment of a horizontal line while saving and restoring the background
   bool              DrawLineHorizontalOnBG(const int id,               // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y,                            // Segment Y coordinate
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawLineHorizontalOnBG(id,x1,x2,y,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a segment of a freehand line while saving and restoring the background
   bool              DrawLineOnBG(const int id,                         // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawLineOnBG(id,x1,y1,x2,y2,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a polyline while saving and restoring the background
   bool              DrawPolylineOnBG(const int id,                     // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polyline points
                              int         &array_y[],                   // Array with the Y coordinates of polyline points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolylineOnBG(id,array_x,array_y,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a polygon while saving and restoring the background
   bool              DrawPolygonOnBG(const int id,                      // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolygonOnBG(id,array_x,array_y,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a rectangle by two points while saving and restoring the background
   bool              DrawRectangleOnBG(const int id,                    // Frame ID
                              const int   x1,                           // X coordinate of the first point defining the rectangle
                              const int   y1,                           // Y coordinate of the first point defining the rectangle
                              const int   x2,                           // X coordinate of the second point defining the rectangle
                              const int   y2,                           // Y coordinate of the second point defining the rectangle
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawRectangleOnBG(id,x1,y1,x2,y2,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a circle while saving and restoring the background
   bool              DrawCircleOnBG(const int id,                       // Frame ID
                              const int   x,                            // X coordinate of the circle center
                              const int   y,                            // Y coordinate of the circle center
                              const int   r,                            // Circle radius
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawCircleOnBG(id,x,y,r,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a triangle while saving and restoring the background
   bool              DrawTriangleOnBG(const int id,                     // Frame ID
                              const int   x1,                           // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawTriangleOnBG(id,x1,y1,x2,y2,x3,y3,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw an ellipse by two points while saving and restoring the background
   bool              DrawEllipseOnBG(const int id,                      // Frame ID
                              const int   x1,                           // X coordinate of the first point defining the ellipse
                              const int   y1,                           // Y coordinate of the first point defining the ellipse
                              const int   x2,                           // X coordinate of the second point defining the ellipse
                              const int   y2,                           // Y coordinate of the second point defining the ellipse
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawEllipseOnBG(id,x1,y1,x2,y2,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw an arc of an ellipse inscribed in a rectangle with corners at (x1,y1) and (x2,y2) while saving and restoring the background.
//--- The arc boundaries are clipped by lines from the center of the ellipse, which extend to two points with coordinates (x3,y3) and (x4,y4)
   bool              DrawArcOnBG(const int id,                          // Frame ID
                              const int   x1,                           // X coordinate of the top left corner forming the rectangle
                              const int   y1,                           // Y coordinate of the top left corner forming the rectangle
                              const int   x2,                           // X coordinate of the bottom right corner forming the rectangle
                              const int   y2,                           // Y coordinate of the bottom right corner forming the rectangle
                              const int   x3,                           // X coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const int   y3,                           // Y coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const int   x4,                           // X coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const int   y4,                           // Y coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawArcOnBG(id,x1,y1,x2,y2,x3,y3,x4,y4,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a filled sector of an ellipse inscribed in a rectangle with corners at (x1,y1) and (x2,y2) while saving and restoring the background.
//--- The sector boundaries are clipped by lines from the center of the ellipse, which extend to two points with coordinates (x3,y3) and (x4,y4)
   bool              DrawPieOnBG(const int id,                          // Frame ID
                              const int   x1,                           // X coordinate of the upper left corner of the rectangle
                              const int   y1,                           // Y coordinate of the upper left corner of the rectangle
                              const int   x2,                           // X coordinate of the bottom right corner of the rectangle
                              const int   y2,                           // Y coordinate of the bottom right corner of the rectangle
                              const int   x3,                           // X coordinate of the first point to find the arc boundaries
                              const int   y3,                           // Y coordinate of the first point to find the arc boundaries
                              const int   x4,                           // X coordinate of the second point to find the arc boundaries
                              const int   y4,                           // Y coordinate of the second point to find the arc boundaries
                              const color clr,                          // Color
                              const color fill_clr,                     // Fill color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPieOnBG(id,x1,y1,x2,y2,x3,y3,x4,y4,clr,fill_clr,opacity,create_new,redraw) : false);  }
                       
//--- Fill the area while saving and restoring the background
   bool              FillOnBG(const int   id,                           // Frame ID
                              const int   x,                            // X coordinate of the filling start point
                              const int   y,                            // Y coordinate of the filling start point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const uint  threshould=0,                 // Threshold
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.FillOnBG(id,x,y,clr,opacity,threshould,create_new,redraw) : false);  }
                       
//--- Draw a filled rectangle while saving and restoring the background
   bool              DrawRectangleFillOnBG(const int id,                // Frame ID
                              const int   x1,                           // X coordinate of the first point defining the rectangle
                              const int   y1,                           // Y coordinate of the first point defining the rectangle
                              const int   x2,                           // X coordinate of the second point defining the rectangle
                              const int   y2,                           // Y coordinate of the second point defining the rectangle
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawRectangleFillOnBG(id,x1,y1,x2,y2,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a filled circle while saving and restoring the background
   bool              DrawCircleFillOnBG(const int id,                   // Frame ID
                              const int   x,                            // X coordinate of the circle center
                              const int   y,                            // Y coordinate of the circle center
                              const int   r,                            // Circle radius
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawCircleFillOnBG(id,x,y,r,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a filled triangle while saving and restoring the background
   bool              DrawTriangleFillOnBG(const int id,                 // Frame ID
                              const int   x1,                           // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawTriangleFillOnBG(id,x1,y1,x2,y2,x3,y3,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a filled polygon while saving and restoring the background
   bool              DrawPolygonFillOnBG(const int id,                  // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolygonFillOnBG(id,array_x,array_y,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a filled ellipse inscribed in a rectangle with the specified coordinates while saving and restoring the background
   bool              DrawEllipseFillOnBG(const int id,                  // Frame ID
                              const int   x1,                           // X coordinate of the top left corner forming the rectangle
                              const int   y1,                           // Y coordinate of the top left corner forming the rectangle
                              const int   x2,                           // X coordinate of the bottom right corner forming the rectangle
                              const int   y2,                           // Y coordinate of the bottom right corner forming the rectangle
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false)                 // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawEllipseFillOnBG(id,x1,y1,x2,y2,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a point using AntiAliasing algorithm while saving and restoring the background
   bool              SetPixelAAOnBG(const int id,                       // Frame ID
                              const double x,                           // Point X coordinate
                              const double y,                           // Pixel Y coordinate
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false)                // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.SetPixelAAOnBG(id,x,y,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a segment of a freehand line using AntiAliasing algorithm while saving and restoring the background
   bool              DrawLineAAOnBG(const int id,                       // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawLineAAOnBG(id,x1,y1,x2,y2,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a segment of a freehand line using Wu algorithm while saving and restoring the background
   bool              DrawLineWuOnBG(const int id,                       // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawLineWuOnBG(id,x1,y1,x2,y2,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration while saving and restoring the background
   bool              DrawLineThickOnBG(const int id,                    // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y2,                           // Y coordinate of the segment second point
                              const int   size,                         // Line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              ENUM_LINE_END end_style=LINE_END_ROUND)   // Line style is one of the ENUM_LINE_END enumeration values
                       { return(this.m_animations!=NULL ? this.m_animations.DrawLineThickOnBG(id,x1,y1,x2,y2,size,clr,opacity,create_new,redraw,style,end_style) : false);  }
                       
//--- Draw a vertical segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration while saving and restoring the background
   bool              DrawLineThickVerticalOnBG(const int id,            // Frame ID
                              const int   x,                            // Segment X coordinate
                              const int   y1,                           // Y coordinate of the segment first point
                              const int   y2,                           // Y coordinate of the segment second point
                              const int   size,                         // line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND) // Line style is one of the ENUM_LINE_END enumeration values
                       { return(this.m_animations!=NULL ? this.m_animations.DrawLineThickVerticalOnBG(id,x,y1,y2,size,clr,opacity,create_new,redraw,style,end_style) : false);  }
                       
//--- Draw a horizontal segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration while saving and restoring the background
   bool              DrawLineThickHorizontalOnBG(const int id,          // Frame ID
                              const int   x1,                           // X coordinate of the segment first point
                              const int   x2,                           // X coordinate of the segment second point
                              const int   y,                            // Segment Y coordinate
                              const int   size,                         // line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND) // Line style is one of the ENUM_LINE_END enumeration values
                       { return(this.m_animations!=NULL ? this.m_animations.DrawLineThickHorizontalOnBG(id,x1,x2,y,size,clr,opacity,create_new,redraw,style,end_style) : false);  }
                       
//--- Draw a polyline using AntiAliasing algorithm while saving and restoring the background
   bool              DrawPolylineAAOnBG(const int id,                   // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polyline points
                              int         &array_y[],                   // Array with the Y coordinates of polyline points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolylineAAOnBG(id,array_x,array_y,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a polyline using Wu algorithm while saving and restoring the background
   bool              DrawPolylineWuOnBG(const int id,                   // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polyline points
                              int         &array_y[],                   // Array with the Y coordinates of polyline points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolylineWuOnBG(id,array_x,array_y,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a polyline with a specified width consecutively using two smoothing algorithms while saving and restoring the background.
//--- First, individual line segments are smoothed based on Bezier curves.
//--- Then, the raster antialiasing algorithm is applied to the polyline built from these segments to improve the rendering quality
   bool              DrawPolylineSmoothOnBG(const int id,               // Frame ID
                              const int    &array_x[],                  // Array with the X coordinates of polyline points
                              const int    &array_y[],                  // Array with the Y coordinates of polyline points
                              const int    size,                        // Line width
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const double tension=0.5,                 // Smoothing parameter value
                              const double step=10,                     // Approximation step
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolylineSmoothOnBG(id,array_x,array_y,size,clr,opacity,tension,step,create_new,redraw,style,end_style) : false);  }
                       
//--- Draw a polyline having a specified width using smoothing algorithm with the preliminary filtration while saving and restoring the background
   bool              DrawPolylineThickOnBG(const int id,                // Frame ID
                              const int     &array_x[],                 // Array with the X coordinates of polyline points
                              const int     &array_y[],                 // Array with the Y coordinates of polyline points
                              const int     size,                       // Line width
                              const color   clr,                        // Color
                              const uchar   opacity=255,                // Opacity
                              const bool    create_new=true,            // New object creation flag
                              const bool    redraw=false,               // Chart redraw flag
                              const uint    style=STYLE_SOLID,          // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              ENUM_LINE_END end_style=LINE_END_ROUND)   // Line style is one of the ENUM_LINE_END enumeration values
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolylineThickOnBG(id,array_x,array_y,size,clr,opacity,create_new,redraw,style,end_style) : false);  }
                       
//--- Draw a polygon using AntiAliasing algorithm while saving and restoring the background
   bool              DrawPolygonAAOnBG(const int id,                    // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolygonAAOnBG(id,array_x,array_y,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a polygon using Wu algorithm while saving and restoring the background
   bool              DrawPolygonWuOnBG(const int id,                    // Frame ID
                              int         &array_x[],                   // Array with the X coordinates of polygon points
                              int         &array_y[],                   // Array with the Y coordinates of polygon points
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolygonWuOnBG(id,array_x,array_y,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a polygon with a specified width consecutively using two smoothing algorithms while saving and restoring the background.
//--- First, individual segments are smoothed based on Bezier curves.
//--- Then, the raster smoothing algorithm is applied to the polygon built from these segments to improve the rendering quality. 
   bool              DrawPolygonSmoothOnBG(const int id,                // Frame ID
                              int          &array_x[],                  // Array with the X coordinates of polyline points
                              int          &array_y[],                  // Array with the Y coordinates of polyline points
                              const int    size,                        // Line width
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const double tension=0.5,                 // Smoothing parameter value
                              const double step=10,                     // Approximation step
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolygonSmoothOnBG(id,array_x,array_y,size,clr,opacity,tension,step,create_new,redraw,style,end_style) : false);  }
                       
//--- Draw a polygon of a specified width using a smoothing algorithm with the preliminary filtration while saving and restoring the background
   bool              DrawPolygonThickOnBG(const int id,                 // Frame ID
                              const int   &array_x[],                   // array with the X coordinates of polygon points
                              const int   &array_y[],                   // array with the Y coordinates of polygon points
                              const int   size,                         // line width
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=STYLE_SOLID,            // line style
                              ENUM_LINE_END end_style=LINE_END_ROUND)   // line ends style
                       { return(this.m_animations!=NULL ? this.m_animations.DrawPolygonThickOnBG(id,array_x,array_y,size,clr,opacity,create_new,redraw,style,end_style) : false);  }
                       
//--- Draw a triangle using AntiAliasing algorithm while saving and restoring the background
   bool              DrawTriangleAAOnBG(const int id,                   // Frame ID
                              const int   x1,                           // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawTriangleAAOnBG(id,x1,y1,x2,y2,x3,y3,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a triangle using Wu algorithm while saving and restoring the background
   bool              DrawTriangleWuOnBG(const int id,                   // Frame ID
                              const int   x1,                           // X coordinate of the triangle first vertex
                              const int   y1,                           // Y coordinate of the triangle first vertex
                              const int   x2,                           // X coordinate of the triangle second vertex
                              const int   y2,                           // Y coordinate of the triangle second vertex
                              const int   x3,                           // X coordinate of the triangle third vertex
                              const int   y3,                           // Y coordinate of the triangle third vertex
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawTriangleWuOnBG(id,x1,y1,x2,y2,x3,y3,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a circle using AntiAliasing algorithm while saving and restoring the background
   bool              DrawCircleAAOnBG(const int id,                     // Frame ID
                              const int    x,                           // X coordinate of the circle center
                              const int    y,                           // Y coordinate of the circle center
                              const double r,                           // Circle radius
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX)              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawCircleAAOnBG(id,x,y,r,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a circle using Wu algorithm while saving and restoring the background
   bool              DrawCircleWuOnBG(const int id,                     // Frame ID
                              const int    x,                           // X coordinate of the circle center
                              const int    y,                           // Y coordinate of the circle center
                              const double r,                           // Circle radius
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX)              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawCircleWuOnBG(id,x,y,r,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw an ellipse by two points using AntiAliasing algorithm while saving and restoring the background
   bool              DrawEllipseAAOnBG(const int id,                    // Frame ID
                              const double x1,                          // X coordinate of the first point defining the ellipse
                              const double y1,                          // Y coordinate of the first point defining the ellipse
                              const double x2,                          // X coordinate of the second point defining the ellipse
                              const double y2,                          // Y coordinate of the second point defining the ellipse
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX)              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawEllipseAAOnBG(id,x1,y1,x2,y2,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw an ellipse by two points using Wu algorithm while saving and restoring the background
   bool              DrawEllipseWuOnBG(const int id,                    // Frame ID
                              const int   x1,                           // X coordinate of the first point defining the ellipse
                              const int   y1,                           // Y coordinate of the first point defining the ellipse
                              const int   x2,                           // X coordinate of the second point defining the ellipse
                              const int   y2,                           // Y coordinate of the second point defining the ellipse
                              const color clr,                          // Color
                              const uchar opacity=255,                  // Opacity
                              const bool  create_new=true,              // New object creation flag
                              const bool  redraw=false,                 // Chart redraw flag
                              const uint  style=UINT_MAX)               // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawEllipseWuOnBG(id,x1,y1,x2,y2,clr,opacity,create_new,redraw,style) : false);  }
                
//--- Draw a regular polygon without smoothing
   bool              DrawNgonOnBG(const int id,                         // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false)                // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawNgonOnBG(id,N,coord_x,coord_y,len,angle,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a regular filled polygon
   bool              DrawNgonFillOnBG(const int id,                     // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false)                // Chart redraw flag
                       { return(this.m_animations!=NULL ? this.m_animations.DrawNgonFillOnBG(id,N,coord_x,coord_y,len,angle,clr,opacity,create_new,redraw) : false);  }
                       
//--- Draw a regular polygon using AntiAliasing algorithm
   bool              DrawNgonAAOnBG(const int id,                       // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX)              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawNgonAAOnBG(id,N,coord_x,coord_y,len,angle,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a regular polygon using Wu algorithm
   bool              DrawNgonWuOnBG(const int id,                       // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=UINT_MAX)              // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { return(this.m_animations!=NULL ? this.m_animations.DrawNgonWuOnBG(id,N,coord_x,coord_y,len,angle,clr,opacity,create_new,redraw,style) : false);  }
                       
//--- Draw a regular polygon with a specified width consecutively using two smoothing algorithms.
//--- First, individual segments are smoothed based on Bezier curves.
//--- Then, the raster smoothing algorithm is applied to the polygon built from these segments to improve the rendering quality. 
   bool              DrawNgonSmoothOnBG(const int id,                   // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const int    size,                        // Line width
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const double tension=0.5,                 // Smoothing parameter value
                              const double step=10,                     // Approximation step
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const ENUM_LINE_STYLE style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                              const ENUM_LINE_END end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
                       { return(this.m_animations!=NULL ? this.m_animations.DrawNgonSmoothOnBG(id,N,coord_x,coord_y,len,angle,size,clr,opacity,tension,step,create_new,redraw,style,end_style) : false);  }
                       
//--- Draw a regular polygon having a specified width using smoothing algorithm with the preliminary filtration
   bool              DrawNgonThickOnBG(const int id,                    // Frame ID
                              const int    N,                           // Number of polygon vertices
                              const int    coord_x,                     // X coordinate of the upper-left frame angle
                              const int    coord_y,                     // Y coordinate of the upper-left frame angle
                              const int    len,                         // Frame sides length
                              const double angle,                       // Polygon rotation angle
                              const int    size,                        // line width
                              const color  clr,                         // Color
                              const uchar  opacity=255,                 // Opacity
                              const bool   create_new=true,             // New object creation flag
                              const bool   redraw=false,                // Chart redraw flag
                              const uint   style=STYLE_SOLID,           // line style
                              ENUM_LINE_END end_style=LINE_END_ROUND)   // line ends style
                       { return(this.m_animations!=NULL ? this.m_animations.DrawNgonThickOnBG(id,N,coord_x,coord_y,len,angle,size,clr,opacity,create_new,redraw,style,end_style) : false);  }
                       
//+------------------------------------------------------------------+
//| Visual design methods                                            |
//+------------------------------------------------------------------+
//--- (1) Show and (2) hide the form
   virtual void      Show(void);
   virtual void      Hide(void);

//+------------------------------------------------------------------+
//| Methods of simplified access to object properties                |
//+------------------------------------------------------------------+
//--- (1) Set and (2) get the form frame color
   void              SetColorFrame(const color colour)                        { this.m_color_frame=colour;     }
   color             ColorFrame(void)                                   const { return this.m_color_frame;     }
//--- (1) Set and (2) return the form shadow color
   void              SetColorShadow(const color colour);
   color             ColorShadow(void) const;
//--- (1) Set and (2) return the form shadow opacity
   void              SetOpacityShadow(const uchar opacity);
   uchar             OpacityShadow(void) const;

  };
//+------------------------------------------------------------------+
//| Constructor indicating the chart and subwindow ID                |
//+------------------------------------------------------------------+
CForm::CForm(const long chart_id,
             const int subwindow,
             const string name,
             const int x,
             const int y,
             const int w,
             const int h) : CGCnvElement(GRAPH_ELEMENT_TYPE_FORM,chart_id,subwindow,name,x,y,w,h)
  {
   this.m_type=OBJECT_DE_TYPE_GFORM; 
   this.Initialize();
  }
//+------------------------------------------------------------------+
//| Current chart constructor specifying the subwindow               |
//+------------------------------------------------------------------+
CForm::CForm(const int subwindow,
             const string name,
             const int x,
             const int y,
             const int w,
             const int h) : CGCnvElement(GRAPH_ELEMENT_TYPE_FORM,::ChartID(),subwindow,name,x,y,w,h)
  {
   this.m_type=OBJECT_DE_TYPE_GFORM; 
   this.Initialize();
  }
//+------------------------------------------------------------------+
//| Constructor on the current chart in the main chart window        |
//+------------------------------------------------------------------+
CForm::CForm(const string name,
             const int x,
             const int y,
             const int w,
             const int h) : CGCnvElement(GRAPH_ELEMENT_TYPE_FORM,::ChartID(),0,name,x,y,w,h)
  {
   this.m_type=OBJECT_DE_TYPE_GFORM; 
   this.Initialize();
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CForm::~CForm()
  {
   if(this.m_shadow_obj!=NULL)
      delete this.m_shadow_obj;
   if(this.m_animations!=NULL)
      delete this.m_animations;
  }
//+------------------------------------------------------------------+
//| Initialize the variables                                         |
//+------------------------------------------------------------------+
void CForm::Initialize(void)
  {
   this.m_list_elements.Clear();
   this.m_list_elements.Sort();
   this.m_shadow_obj=NULL;
   this.m_shadow=false;
   this.m_frame_width_right=2;
   this.m_frame_width_left=2;
   this.m_frame_width_top=2;
   this.m_frame_width_bottom=2;
   this.m_mouse_state_flags=0;
   this.m_offset_x=0;
   this.m_offset_y=0;
   CGCnvElement::SetInteraction(false);
   this.m_animations=new CAnimations(CGCnvElement::GetObject());
  }
//+------------------------------------------------------------------+
//| Create a new graphical object                                    |
//+------------------------------------------------------------------+
CGCnvElement *CForm::CreateNewGObject(const ENUM_GRAPH_ELEMENT_TYPE type,
                                      const int obj_num,
                                      const string obj_name,
                                      const int x,
                                      const int y,
                                      const int w,
                                      const int h,
                                      const color colour,
                                      const uchar opacity,
                                      const bool movable,
                                      const bool activity)
  {
   string name=this.CreateNameDependentObject(obj_name);
   CGCnvElement *element=new CGCnvElement(type,this.ID(),obj_num,this.ChartID(),this.SubWindow(),name,x,y,w,h,colour,opacity,movable,activity);
   if(element==NULL)
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_ELM_OBJ),": ",name);
   return element;
  }
//+------------------------------------------------------------------+
//| Create a new attached element                                    |
//+------------------------------------------------------------------+
bool CForm::CreateNewElement(const int element_num,
                             const string element_name,
                             const int x,
                             const int y,
                             const int w,
                             const int h,
                             const color colour,
                             const uchar opacity,
                             const bool movable,
                             const bool activity)
  {
   CGCnvElement *obj=this.CreateNewGObject(GRAPH_ELEMENT_TYPE_ELEMENT,element_num,element_name,x,y,w,h,colour,opacity,movable,activity);
   if(obj==NULL)
      return false;
   this.m_list_elements.Sort(SORT_BY_CANV_ELEMENT_NAME_OBJ);
   int index=this.m_list_elements.Search(obj);
   if(index>WRONG_VALUE)
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_OBJ_ALREADY_IN_LIST),": ",obj.NameObj());
      delete obj;
      return false;
     }
   if(!this.m_list_elements.Add(obj))
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_FAILED_OBJ_ADD_TO_LIST),": ",obj.NameObj());
      delete obj;
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Create the shadow object                                         |
//+------------------------------------------------------------------+
void CForm::CreateShadowObj(const color colour,const uchar opacity)
  {
//--- If the shadow flag is disabled or the shadow object already exists, exit
   if(!this.m_shadow || this.m_shadow_obj!=NULL)
      return;
//--- Calculate the shadow object coordinates according to the offset from the top and left
   int x=this.CoordX()-OUTER_AREA_SIZE;
   int y=this.CoordY()-OUTER_AREA_SIZE;
//--- Calculate the width and height in accordance with the top, bottom, left and right offsets
   int w=this.Width()+OUTER_AREA_SIZE*2;
   int h=this.Height()+OUTER_AREA_SIZE*2;
//--- Create a new shadow object and set the pointer to it in the variable
   this.m_shadow_obj=new CShadowObj(this.ChartID(),this.SubWindow(),this.CreateNameDependentObject("Shadow"),x,y,w,h);
   if(this.m_shadow_obj==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_ERR_FAILED_CREATE_SHADOW_OBJ));
      return;
     }
//--- Set the properties for the created shadow object
   this.m_shadow_obj.SetID(this.ID());
   this.m_shadow_obj.SetNumber(-1);
   this.m_shadow_obj.SetOpacityShadow(opacity);
   this.m_shadow_obj.SetColorShadow(colour);
   this.m_shadow_obj.SetMovable(true);
   this.m_shadow_obj.SetActive(false);
   this.m_shadow_obj.SetVisible(false,false);
//--- Move the form object to the foreground
   this.BringToTop();
  }
//+------------------------------------------------------------------+
//| Draw the shadow                                                  |
//+------------------------------------------------------------------+
void CForm::DrawShadow(const int shift_x,const int shift_y,const color colour,const uchar opacity=127,const uchar blur=4)
  {
//--- If the shadow flag is disabled, exit
   if(!this.m_shadow)
      return;
//--- If there is no shadow object, create it
   if(this.m_shadow_obj==NULL)
      this.CreateShadowObj(colour,opacity);
//--- If the shadow object exists, draw the shadow on it,
//--- set the shadow object visibility flag and
//--- move the form object to the foreground
   if(this.m_shadow_obj!=NULL)
     {
      this.m_shadow_obj.DrawShadow(shift_x,shift_y,blur);
      this.m_shadow_obj.SetVisible(true,false);
      this.BringToTop();
     }
  }
//+------------------------------------------------------------------+
//| Set a color scheme                                               |
//+------------------------------------------------------------------+
void CForm::SetColorTheme(const ENUM_COLOR_THEMES theme,const uchar opacity)
  {
   this.SetOpacity(opacity);
   this.SetColorBackground(array_color_themes[theme][COLOR_THEME_COLOR_FORM_BG]);
   this.SetColorFrame(array_color_themes[theme][COLOR_THEME_COLOR_FORM_FRAME]);
   if(this.m_shadow && this.m_shadow_obj!=NULL)
      this.SetColorShadow(array_color_themes[theme][COLOR_THEME_COLOR_FORM_SHADOW]);
  }
//+------------------------------------------------------------------+
//| Set the form style                                               |
//+------------------------------------------------------------------+
void CForm::SetFormStyle(const ENUM_FORM_STYLE style,
                         const ENUM_COLOR_THEMES theme,
                         const uchar opacity,
                         const bool shadow=false,
                         const bool use_bg_color=true,
                         const bool redraw=false)
  {
//--- Set opacity parameters and the size of the form frame side
   this.m_shadow=shadow;
   this.m_frame_width_top=array_form_style[style][FORM_STYLE_FRAME_WIDTH_TOP];
   this.m_frame_width_bottom=array_form_style[style][FORM_STYLE_FRAME_WIDTH_BOTTOM];
   this.m_frame_width_left=array_form_style[style][FORM_STYLE_FRAME_WIDTH_LEFT];
   this.m_frame_width_right=array_form_style[style][FORM_STYLE_FRAME_WIDTH_RIGHT];
   
//--- Create the shadow object
   this.CreateShadowObj(clrNONE,(uchar)array_form_style[style][FORM_STYLE_FRAME_SHADOW_OPACITY]);
   
//--- Set a color scheme
   this.SetColorTheme(theme,opacity);
//--- Calculate a shadow color with color darkening
   color clr=array_color_themes[theme][COLOR_THEME_COLOR_FORM_SHADOW];
   color gray=CGCnvElement::ChangeColorSaturation(ChartColorBackground(),-100);
   color color_shadow=CGCnvElement::ChangeColorLightness((use_bg_color ? gray : clr),-fabs(array_form_style[style][FORM_STYLE_DARKENING_COLOR_FOR_SHADOW]));
   this.SetColorShadow(color_shadow);
   
//--- Draw a rectangular shadow
   int shift_x=array_form_style[style][FORM_STYLE_FRAME_SHADOW_X_SHIFT];
   int shift_y=array_form_style[style][FORM_STYLE_FRAME_SHADOW_Y_SHIFT];
   this.DrawShadow(shift_x,shift_y,color_shadow,this.OpacityShadow(),(uchar)array_form_style[style][FORM_STYLE_FRAME_SHADOW_BLUR]);
   
//--- Fill in the form background with color and opacity
   this.Erase(this.ColorBackground(),this.Opacity());
//--- Depending on the selected form style, draw the corresponding form frame and the outer bounding frame
   switch(style)
     {
      case FORM_STYLE_BEVEL   :
        this.DrawFormFrame(this.m_frame_width_top,this.m_frame_width_bottom,this.m_frame_width_left,this.m_frame_width_right,this.ColorFrame(),this.Opacity(),FRAME_STYLE_BEVEL);
        break;
      //---FORM_STYLE_FLAT
      default:
        this.DrawFormFrame(this.m_frame_width_top,this.m_frame_width_bottom,this.m_frame_width_left,this.m_frame_width_right,this.ColorFrame(),this.Opacity(),FRAME_STYLE_FLAT);
        break;
     }
   this.DrawRectangle(0,0,Width()-1,Height()-1,array_color_themes[theme][COLOR_THEME_COLOR_FORM_RECT_OUTER],this.Opacity());
  }
//+------------------------------------------------------------------+
//| Draw the form frame                                              |
//+------------------------------------------------------------------+
void CForm::DrawFormFrame(const int wd_top,              // Frame upper segment width
                          const int wd_bottom,           // Frame lower segment width
                          const int wd_left,             // Frame left segment width
                          const int wd_right,            // Frame right segment width
                          const color colour,            // Frame color
                          const uchar opacity,           // Frame opacity
                          const ENUM_FRAME_STYLE style)  // Frame style
  {
//--- Depending on the passed frame style
   switch(style)
     {
      //--- draw a dimensional (convex) frame
      case FRAME_STYLE_BEVEL :
         DrawFrameBevel(0,0,Width(),Height(),wd_top,wd_bottom,wd_left,wd_right,colour,opacity);
        break;
      //--- draw a dimensional (concave) frame
      case FRAME_STYLE_STAMP :
         DrawFrameStamp(0,0,Width(),Height(),wd_top,wd_bottom,wd_left,wd_right,colour,opacity);
        break;
      //--- draw a flat frame
      case FRAME_STYLE_FLAT :
         DrawFrameFlat(0,0,Width(),Height(),wd_top,wd_bottom,wd_left,wd_right,colour,opacity);
        break;
      //--- draw a simple frame
      default:
        //---FRAME_STYLE_SIMPLE
         DrawFrameSimple(0,0,Width(),Height(),wd_top,wd_bottom,wd_left,wd_right,colour,opacity);
        break;
     }
  }
//+------------------------------------------------------------------+
//| Draw a simple frame                                              |
//+------------------------------------------------------------------+
void CForm::DrawFrameSimple(const int x,           // X coordinate relative to the form
                            const int y,           // Y coordinate relative to the form
                            const int width,       // Frame width
                            const int height,      // Frame height
                            const int wd_top,      // Frame upper segment width
                            const int wd_bottom,   // Frame lower segment width
                            const int wd_left,     // Frame left segment width
                            const int wd_right,    // Frame right segment width
                            const color colour,    // Frame color
                            const uchar opacity)   // Frame opacity
  {
//--- Set rectangle coordinates
   int x1=x, y1=y;
   int x2=x1+width-1;
   int y2=y1+height-1;
//--- Draw the first rectangle
   CGCnvElement::DrawRectangle(x1,y1,x2,y2,colour,opacity);
//--- If the frame width exceeds 1 on all sides, draw the second rectangle
   if(wd_left>1 || wd_right>1 || wd_top>1 || wd_bottom>1)
      CGCnvElement::DrawRectangle(x1+wd_left-1,y1+wd_top-1,x2-wd_right+1,y2-wd_bottom+1,colour,opacity);
//--- Search for "voids" between the lines of two rectangles and fill them with color
   if(wd_left>2 && wd_right>2 && wd_top>2 && wd_bottom>2)
      this.Fill(x1+1,y1+1,colour,opacity);
   else if(wd_left>2 && wd_top>2)
      this.Fill(x1+1,y1+1,colour,opacity);
   else if(wd_right>2 && wd_bottom>2)
      this.Fill(x2-1,y2-1,colour,opacity);
   else if(wd_left<3 && wd_right<3)
     {
      if(wd_top>2)
         this.Fill(x1+1,y1+1,colour,opacity);
      if(wd_bottom>2)
         this.Fill(x1+1,y2-1,colour,opacity);
     }
   else if(wd_top<3 && wd_bottom<3)
     {
      if(wd_left>2)
         this.Fill(x1+1,y1+1,colour,opacity);
      if(wd_right>2)
         this.Fill(x2-1,y1+1,colour,opacity);
     }
  }
//+------------------------------------------------------------------+
//| Draw a flat frame                                                |
//+------------------------------------------------------------------+
void CForm::DrawFrameFlat(const int x,
                          const int y,
                          const int width,
                          const int height,
                          const int wd_top,
                          const int wd_bottom,
                          const int wd_left,
                          const int wd_right,
                          const color colour,
                          const uchar opacity)
  {
//--- Draw a simple frame
   this.DrawFrameSimple(x,y,width,height,wd_top,wd_bottom,wd_left,wd_right,colour,opacity);
//--- If the width of the frame top and bottom exceeds one pixel
   if(wd_top>1 && wd_bottom>1)
     {
      //--- Darken the horizontal sides of the frame
      for(int i=0;i<width;i++)
        {
         this.m_canvas.PixelSet(x+i,y,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y),-5));
         this.m_canvas.PixelSet(x+i,y+height-1,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y+height-1),-7));
        }
     }
//--- If the width of the frame left and right sides exceeds one pixel
   if(wd_left>1 && wd_right>1)
     {
      //--- Darken the vertical sides of the frame
      for(int i=1;i<height-1;i++)
        {
         this.m_canvas.PixelSet(x,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x,y+1),-1));
         this.m_canvas.PixelSet(x+width-1,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x+width-1,y+1),-2));
        }
     }
  }
//+------------------------------------------------------------------+
//| Draw an embossed (convex) frame                                  |
//+------------------------------------------------------------------+
void CForm::DrawFrameBevel(const int x,
                           const int y,
                           const int width,
                           const int height,
                           const int wd_top,
                           const int wd_bottom,
                           const int wd_left,
                           const int wd_right,
                           const color colour,
                           const uchar opacity)
  {
//--- Draw a simple frame
   this.DrawFrameSimple(x,y,width,height,wd_top,wd_bottom,wd_left,wd_right,colour,opacity);
//--- If the width of the frame top and bottom exceeds one pixel
   if(wd_top>1 && wd_bottom>1)
     {
      //--- Lighten and darken the required sides of the frame edges
      for(int i=0;i<width;i++)
        {
         this.m_canvas.PixelSet(x+i,y,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y),25));
         this.m_canvas.PixelSet(x+i,y+height-1,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y+height-1),-20));
        }
      for(int i=wd_left;i<width-wd_right;i++)
        {
         this.m_canvas.PixelSet(x+i,y+wd_top-1,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y+wd_top-1),-20));
         this.m_canvas.PixelSet(x+i,y+height-wd_bottom,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y+height-wd_bottom),10));
        }
     }
//--- If the width of the frame left and right sides exceeds one pixel
   if(wd_left>1 && wd_right>1)
     {
      //--- Lighten and darken the required sides of the frame edges
      for(int i=1;i<height-1;i++)
        {
         this.m_canvas.PixelSet(x,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x,y+i),10));
         this.m_canvas.PixelSet(x+width-1,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x+width-1,y+i),-10));
        }
      for(int i=wd_top;i<height-wd_bottom;i++)
        {
         this.m_canvas.PixelSet(x+wd_left-1,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x+wd_left-1,y+i),-10));
         this.m_canvas.PixelSet(x+width-wd_right,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x+width-wd_right,y+i),10));
        }
     }
  }
//+------------------------------------------------------------------+
//| Draw an embossed (concave) frame                                 |
//+------------------------------------------------------------------+
void CForm::DrawFrameStamp(const int x,
                           const int y,
                           const int width,
                           const int height,
                           const int wd_top,
                           const int wd_bottom,
                           const int wd_left,
                           const int wd_right,
                           const color colour,
                           const uchar opacity)
  {
//--- Draw a simple frame
   this.DrawFrameSimple(x,y,width,height,wd_top,wd_bottom,wd_left,wd_right,colour,opacity);
//--- If the width of the frame top and bottom exceeds one pixel
   if(wd_top>1 && wd_bottom>1)
     {
      //--- Lighten and darken the required sides of the frame edges
      for(int i=0;i<width;i++)
        {
         this.m_canvas.PixelSet(x+i,y,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y),-25));
         this.m_canvas.PixelSet(x+i,y+height-1,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y+height-1),20));
        }
      for(int i=wd_left;i<width-wd_right;i++)
        {
         this.m_canvas.PixelSet(x+i,y+wd_top-1,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y+wd_top-1),20));
         this.m_canvas.PixelSet(x+i,y+height-wd_bottom,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y+height-wd_bottom),-25));
        }
     }
//--- If the width of the frame left and right sides exceeds one pixel
   if(wd_left>1 && wd_right>1)
     {
      //--- Lighten and darken the required sides of the frame edges
      for(int i=1;i<height-1;i++)
        {
         this.m_canvas.PixelSet(x,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x,y+i),-10));
         this.m_canvas.PixelSet(x+width-1,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x+width-1,y+i),20));
        }
      for(int i=wd_top;i<height-wd_bottom;i++)
        {
         this.m_canvas.PixelSet(x+wd_left-1,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x+wd_left-1,y+i),20));
         this.m_canvas.PixelSet(x+width-wd_right,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x+width-wd_right,y+i),-20));
        }
     }
  }
//+------------------------------------------------------------------+
//| Draw a simple field                                              |
//+------------------------------------------------------------------+
void CForm::DrawFieldFlat(const int x,const int y,const int width,const int height,const color colour,const uchar opacity)
  {
//--- Draw a filled rectangle
   CGCnvElement::DrawRectangleFill(x,y,x+width-1,y+height-1,colour,opacity);
//--- Darken all its edges
   for(int i=0;i<width;i++)
     {
      this.m_canvas.PixelSet(x+i,y,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y),-5));
      this.m_canvas.PixelSet(x+i,y+height-1,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y+height-1),-5));
     }
   for(int i=1;i<height-1;i++)
     {
      this.m_canvas.PixelSet(x,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x,y+1),-5));
      this.m_canvas.PixelSet(x+width-1,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x+width-1,y+1),-5));
     }
  }
//+------------------------------------------------------------------+
//| Draw an embossed (convex) field                                  |
//+------------------------------------------------------------------+
void CForm::DrawFieldBevel(const int x,const int y,const int width,const int height,const color colour,const uchar opacity)
  {
//--- Draw a filled rectangle
   CGCnvElement::DrawRectangleFill(x,y,x+width-1,y+height-1,colour,opacity);
//--- Lighten its top and left and darken its bottom and right
   for(int i=0;i<width;i++)
     {
      this.m_canvas.PixelSet(x+i,y,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y),10));
      this.m_canvas.PixelSet(x+i,y+height-1,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y+height-1),-10));
     }
   for(int i=1;i<height-1;i++)
     {
      this.m_canvas.PixelSet(x,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x,y+1),5));
      this.m_canvas.PixelSet(x+width-1,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x+width-1,y+1),-5));
     }
  }
//+------------------------------------------------------------------+
//| Draw an embossed (concave) field                                 |
//+------------------------------------------------------------------+
void CForm::DrawFieldStamp(const int x,const int y,const int width,const int height,const color colour,const uchar opacity)
  {
//--- Draw a filled rectangle
   CGCnvElement::DrawRectangleFill(x,y,x+width-1,y+height-1,colour,opacity);
//--- Darken its top and left and lighten its bottom and right
   for(int i=0;i<width;i++)
     {
      this.m_canvas.PixelSet(x+i,y,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y),-10));
      this.m_canvas.PixelSet(x+i,y+height-1,CGCnvElement::ChangeColorLightness(this.GetPixel(x+i,y+height-1),10));
     }
   for(int i=1;i<height-1;i++)
     {
      this.m_canvas.PixelSet(x,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x,y+1),-5));
      this.m_canvas.PixelSet(x+width-1,y+i,CGCnvElement::ChangeColorLightness(this.GetPixel(x+width-1,y+1),5));
     }
  }
//+------------------------------------------------------------------+
//| Set the form shadow color                                        |
//+------------------------------------------------------------------+
void CForm::SetColorShadow(const color colour)
  {
   if(this.m_shadow_obj==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_TEXT_NO_SHADOW_OBJ_FIRST_CREATE_IT));
      return;
     }
   this.m_shadow_obj.SetColorShadow(colour);
  }
//+------------------------------------------------------------------+
//| Return the form shadow color                                     |
//+------------------------------------------------------------------+
color CForm::ColorShadow(void) const
  {
   if(this.m_shadow_obj==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_TEXT_NO_SHADOW_OBJ_FIRST_CREATE_IT));
      return clrNONE;
     }
   return this.m_shadow_obj.ColorShadow();
  }
//+------------------------------------------------------------------+
//| Set the form shadow opacity                                      |
//+------------------------------------------------------------------+
void CForm::SetOpacityShadow(const uchar opacity)
  {
   if(this.m_shadow_obj==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_TEXT_NO_SHADOW_OBJ_FIRST_CREATE_IT));
      return;
     }
   this.m_shadow_obj.SetOpacityShadow(opacity);
  }
//+------------------------------------------------------------------+
//| Return the form shadow opacity                                   |
//+------------------------------------------------------------------+
uchar CForm::OpacityShadow(void) const
  {
   if(this.m_shadow_obj==NULL)
     {
      ::Print(DFUN,CMessage::Text(MSG_FORM_OBJECT_TEXT_NO_SHADOW_OBJ_FIRST_CREATE_IT));
      return 0;
     }
   return this.m_shadow_obj.OpacityShadow();
  }
//+------------------------------------------------------------------+
//| Reset the array size of the text animation frames                |
//+------------------------------------------------------------------+
void CForm::ResetArrayFrameT(void)
  {
   if(this.m_animations==NULL)
      return;
   CArrayObj *list=this.m_animations.GetListFramesText();
   if(list==NULL)
      return;
   for(int i=0;i<list.Total();i++)
     {
      CFrameText *frame=list.At(i);
      if(frame==NULL)
         continue;
      frame.ResetArray();
     }
  }
//+------------------------------------------------------------------+
//| Reset the size of the rectangular animation frame array          |
//+------------------------------------------------------------------+
void CForm::ResetArrayFrameQ(void)
  {
   if(this.m_animations==NULL)
      return;
   CArrayObj *list=this.m_animations.GetListFramesQuad();
   if(list==NULL)
      return;
   for(int i=0;i<list.Total();i++)
     {
      CFrameQuad *frame=list.At(i);
      if(frame==NULL)
         continue;
      frame.ResetArray();
     }
  }
//+------------------------------------------------------------------+
//| Reset the size of the geometric animation frame array            |
//+------------------------------------------------------------------+
void CForm::ResetArrayFrameG(void)
  {
   if(this.m_animations==NULL)
      return;
   CArrayObj *list=this.m_animations.GetListFramesGeometry();
   if(list==NULL)
      return;
   for(int i=0;i<list.Total();i++)
     {
      CFrameGeometry *frame=list.At(i);
      if(frame==NULL)
         continue;
      frame.ResetArray();
     }
  }
//+------------------------------------------------------------------+
//| Restore the resource from the array                              |
//+------------------------------------------------------------------+
bool CForm::Reset(void)
  {
   CGCnvElement::Reset();
   this.ResetArrayFrameQ();
   this.ResetArrayFrameT();
   this.ResetArrayFrameG();
   return true;
  }
//+------------------------------------------------------------------+
//| Show the form                                                    |
//+------------------------------------------------------------------+
void CForm::Show(void)
  {
//--- If the object has a shadow, display it
   if(this.m_shadow_obj!=NULL)
      this.m_shadow_obj.Show();
//--- Display the main form
   CGCnvElement::Show();
//--- In the loop by all bound graphical objects,
   for(int i=0;i<this.m_list_elements.Total();i++)
     {
      //--- get the next graphical element
      CGCnvElement *elment=this.m_list_elements.At(i);
      if(elment==NULL)
         continue;
      //--- and display it
      elment.Show();
     }
//--- Update the form
   CGCnvElement::Update();
  }
//+------------------------------------------------------------------+
//| Hide the form                                                    |
//+------------------------------------------------------------------+
void CForm::Hide(void)
  {
//--- If the object has a shadow, hide it
   if(this.m_shadow_obj!=NULL)
      this.m_shadow_obj.Hide();
//--- In the loop by all bound graphical objects,
   for(int i=0;i<this.m_list_elements.Total();i++)
     {
      //--- get the next graphical element
      CGCnvElement *elment=this.m_list_elements.At(i);
      if(elment==NULL)
         continue;
      //--- and hide it
      elment.Hide();
     }
//--- Hide the main form and update the object
   CGCnvElement::Hide();
   CGCnvElement::Update();
  }
//+------------------------------------------------------------------+
//| Return the mouse status relative to the form                     |
//+------------------------------------------------------------------+
ENUM_MOUSE_FORM_STATE CForm::MouseFormState(const int id,const long lparam,const double dparam,const string sparam)
  {
//--- Get the mouse status relative to the form, as well as the states of mouse buttons and Shift/Ctrl keys
   ENUM_MOUSE_FORM_STATE form_state=MOUSE_FORM_STATE_OUTSIDE_FORM_NOT_PRESSED;
   ENUM_MOUSE_BUTT_KEY_STATE state=this.m_mouse.ButtonKeyState(id,lparam,dparam,sparam);
//--- Get the mouse status flags from the CMouseState class object and save them in the variable
   this.m_mouse_state_flags=this.m_mouse.GetMouseFlags();
//--- If the cursor is inside the form
   if(CGCnvElement::CursorInsideElement(m_mouse.CoordX(),m_mouse.CoordY()))
     {
      //--- Set bit 8 responsible for the "cursor inside the form" flag
      this.m_mouse_state_flags |= (0x0001<<8);
      //--- If the cursor is inside the active area, set bit 9 "cursor inside the active area"
      if(CGCnvElement::CursorInsideActiveArea(m_mouse.CoordX(),m_mouse.CoordY()))
         this.m_mouse_state_flags |= (0x0001<<9);
      //--- otherwise, release the bit "cursor inside the active area"
      else this.m_mouse_state_flags &=0xFDFF;
      //--- If one of the mouse buttons is clicked, check the cursor location in the active area and
      //--- return the appropriate value of the pressed key (in the active area or the form area)
      if((this.m_mouse_state_flags & 0x0001)!=0 || (this.m_mouse_state_flags & 0x0002)!=0 || (this.m_mouse_state_flags & 0x0010)!=0)
         form_state=((this.m_mouse_state_flags & 0x0200)!=0 ? MOUSE_FORM_STATE_INSIDE_ACTIVE_AREA_PRESSED : MOUSE_FORM_STATE_INSIDE_FORM_PRESSED);
      //--- otherwise, if not a single mouse button is pressed
      else
        {
         //--- if the mouse wheel is scrolled, return the appropriate wheel scrolling value (in the active area or the form area)
         if((this.m_mouse_state_flags & 0x0080)!=0)
            form_state=((this.m_mouse_state_flags & 0x0200)!=0 ? MOUSE_FORM_STATE_INSIDE_ACTIVE_AREA_WHEEL : MOUSE_FORM_STATE_INSIDE_FORM_WHEEL);
         //--- otherwise, return the appropriate value of the unpressed key (in the active area or the form area)
         else
            form_state=((this.m_mouse_state_flags & 0x0200)!=0 ? MOUSE_FORM_STATE_INSIDE_ACTIVE_AREA_NOT_PRESSED : MOUSE_FORM_STATE_INSIDE_FORM_NOT_PRESSED);
        } 
     }
//--- If the cursor is outside the form
   else
     {
      //--- return the appropriate button value in an inactive area
      form_state=
        (
         ((this.m_mouse_state_flags & 0x0001)!=0 || (this.m_mouse_state_flags & 0x0002)!=0 || (this.m_mouse_state_flags & 0x0010)!=0) ? 
          MOUSE_FORM_STATE_OUTSIDE_FORM_PRESSED : MOUSE_FORM_STATE_OUTSIDE_FORM_NOT_PRESSED
        );
     }
   return form_state;
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CForm::OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Adjust subwindow Y shift
   CGCnvElement::OnChartEvent(id,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+
//| Set the flags of mouse scrolling,                                |
//| context menu and crosshairs for the chart                        |
//+------------------------------------------------------------------+
void CForm::SetChartTools(const bool flag)
  {
   ::ChartSetInteger(this.ChartID(),CHART_MOUSE_SCROLL,flag);
   ::ChartSetInteger(this.ChartID(),CHART_CONTEXT_MENU,flag);
   ::ChartSetInteger(this.ChartID(),CHART_CROSSHAIR_TOOL,flag);
  }
//+------------------------------------------------------------------+
