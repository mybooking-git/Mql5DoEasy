//+------------------------------------------------------------------+
//|                                                  GCnvElement.mqh |
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
#include "GBaseObj.mqh"
//+------------------------------------------------------------------+
//| Class of the graphical element object                            |
//+------------------------------------------------------------------+
class CGCnvElement : public CGBaseObj
  {
protected:
   CCanvas           m_canvas;                                 // CCanvas class object
   CPause            m_pause;                                  // Pause class object
   bool              m_shadow;                                 // Shadow presence
   color             m_chart_color_bg;                         // Chart background color
   uint              m_duplicate_res[];                        // Array for storing resource data copy

//--- Create (1) the object structure and (2) the object from the structure
   virtual bool      ObjectToStruct(void);
   virtual void      StructToObject(void);
   
private:
   struct SData
     {
      //--- Object integer properties
      int            id;                                       // Element ID
      int            type;                                     // Graphical element type
      int            number;                                   // Element index in the list
      long           chart_id;                                 // Chart ID
      int            subwindow;                                // Chart subwindow index
      int            coord_x;                                  // Form's X coordinate on the chart
      int            coord_y;                                  // Form's Y coordinate on the chart
      int            width;                                    // Element width
      int            height;                                   // Element height
      int            edge_right;                               // Element right border
      int            edge_bottom;                              // Element bottom border
      int            act_shift_left;                           // Active area offset from the left edge of the element
      int            act_shift_top;                            // Active area offset from the top edge of the element
      int            act_shift_right;                          // Active area offset from the right edge of the element
      int            act_shift_bottom;                         // Active area offset from the bottom edge of the element
      uchar          opacity;                                  // Element opacity
      color          color_bg;                                 // Element background color
      bool           movable;                                  // Element moveability flag
      bool           active;                                   // Element activity flag
      bool           interaction;                              // Flag of interaction with the outside environment
      int            coord_act_x;                              // X coordinate of the element active area
      int            coord_act_y;                              // Y coordinate of the element active area
      int            coord_act_right;                          // Right border of the element active area
      int            coord_act_bottom;                         // Bottom border of the element active area
      long           zorder;                                   // Priority of a graphical object for receiving the event of clicking on a chart
      //--- Object real properties

      //--- Object string properties
      uchar          name_obj[64];                             // Graphical element object name
      uchar          name_res[64];                             // Graphical resource name
     };
   SData             m_struct_obj;                             // Object structure
   uchar             m_uchar_array[];                          // uchar array of the object structure
   
   long              m_long_prop[ORDER_PROP_INTEGER_TOTAL];    // Integer properties
   double            m_double_prop[ORDER_PROP_DOUBLE_TOTAL];   // Real properties
   string            m_string_prop[ORDER_PROP_STRING_TOTAL];   // String properties
   
   ENUM_FRAME_ANCHOR m_text_anchor;                            // Current text alignment
   int               m_text_x;                                 // Text last X coordinate
   int               m_text_y;                                 // Text last Y coordinate
   color             m_color_bg;                               // Element background color
   uchar             m_opacity;                                // Element opacity
   
//--- Return the index of the array the order's (1) double and (2) string properties are located at
   int               IndexProp(ENUM_CANV_ELEMENT_PROP_DOUBLE property)  const { return(int)property-CANV_ELEMENT_PROP_INTEGER_TOTAL;                                 }
   int               IndexProp(ENUM_CANV_ELEMENT_PROP_STRING property)  const { return(int)property-CANV_ELEMENT_PROP_INTEGER_TOTAL-CANV_ELEMENT_PROP_DOUBLE_TOTAL;  }

public:
//--- Set object's (1) integer, (2) real and (3) string properties
   void              SetProperty(ENUM_CANV_ELEMENT_PROP_INTEGER property,long value)   { this.m_long_prop[property]=value;                   }
   void              SetProperty(ENUM_CANV_ELEMENT_PROP_DOUBLE property,double value)  { this.m_double_prop[this.IndexProp(property)]=value; }
   void              SetProperty(ENUM_CANV_ELEMENT_PROP_STRING property,string value)  { this.m_string_prop[this.IndexProp(property)]=value; }
//--- Return object’s (1) integer, (2) real and (3) string property from the properties array
   long              GetProperty(ENUM_CANV_ELEMENT_PROP_INTEGER property)        const { return this.m_long_prop[property];                  }
   double            GetProperty(ENUM_CANV_ELEMENT_PROP_DOUBLE property)         const { return this.m_double_prop[this.IndexProp(property)];}
   string            GetProperty(ENUM_CANV_ELEMENT_PROP_STRING property)         const { return this.m_string_prop[this.IndexProp(property)];}

//--- Return the flag of the object supporting this property
   virtual bool      SupportProperty(ENUM_CANV_ELEMENT_PROP_INTEGER property)          { return true;    }
   virtual bool      SupportProperty(ENUM_CANV_ELEMENT_PROP_DOUBLE property)           { return false;   }
   virtual bool      SupportProperty(ENUM_CANV_ELEMENT_PROP_STRING property)           { return true;    }

//--- Return itself
   CGCnvElement     *GetObject(void)                                                   { return &this;   }

//--- Compare CGCnvElement objects with each other by all possible properties (for sorting the lists by a specified object property)
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Compare CGCnvElement objects with each other by all properties (to search equal objects)
   bool              IsEqual(CGCnvElement* compared_obj) const;

//--- (1) Save the object to file and (2) upload the object from the file
   virtual bool      Save(const int file_handle);
   virtual bool      Load(const int file_handle);

//--- (1) Save the graphical resource to the array and (2) restore the resource from the array
   bool              ResourceStamp(const string source);
   virtual bool      Reset(void);
   
//--- Return the cursor position relative to the (1) entire element and (2) the element's active area
   bool              CursorInsideElement(const int x,const int y);
   bool              CursorInsideActiveArea(const int x,const int y);

//--- Create the element
   bool              Create(const long chart_id,
                            const int wnd_num,
                            const string name,
                            const int x,
                            const int y,
                            const int w,
                            const int h,
                            const color colour,
                            const uchar opacity,
                            const bool redraw=false);
                                
//--- Return the pointer to a canvas object
   CCanvas          *GetCanvasObj(void)                                                { return &this.m_canvas;                     }
//--- Set the canvas update frequency
   void              SetFrequency(const ulong value)                                   { this.m_pause.SetWaitingMSC(value);         }
//--- Update the canvas
   void              CanvasUpdate(const bool redraw=false)                             { this.m_canvas.Update(redraw);              }
//--- Return the size of the graphical resource copy array
   uint              DuplicateResArraySize(void)                                       { return ::ArraySize(this.m_duplicate_res);  }
   
//--- Update the coordinates (shift the canvas)
   bool              Move(const int x,const int y,const bool redraw=false);

//--- Save an image to the array
   bool              ImageCopy(const string source,uint &array[]);
   
//--- Change the lightness of (1) ARGB and (2) COLOR by a specified amount
   uint              ChangeColorLightness(const uint clr,const double change_value);
   color             ChangeColorLightness(const color colour,const double change_value);
//--- Change the saturation of (1) ARGB and (2) COLOR by a specified amount
   uint              ChangeColorSaturation(const uint clr,const double change_value);
   color             ChangeColorSaturation(const color colour,const double change_value);
   
protected:
//--- Protected constructor
                     CGCnvElement(const ENUM_GRAPH_ELEMENT_TYPE element_type,
                                  const long    chart_id,
                                  const int     wnd_num,
                                  const string  name,
                                  const int     x,
                                  const int     y,
                                  const int     w,
                                  const int     h);
public:
//--- Event handler
   virtual void      OnChartEvent(const int id,const long& lparam,const double& dparam,const string& sparam);
//--- Parametric constructor
                     CGCnvElement(const ENUM_GRAPH_ELEMENT_TYPE element_type,
                                  const int     element_id,
                                  const int     element_num,
                                  const long    chart_id,
                                  const int     wnd_num,
                                  const string  name,
                                  const int     x,
                                  const int     y,
                                  const int     w,
                                  const int     h,
                                  const color   colour,
                                  const uchar   opacity,
                                  const bool    movable=true,
                                  const bool    activity=true,
                                  const bool    redraw=false);
//--- Default constructor/Destructor
                     CGCnvElement() : m_shadow(false),m_chart_color_bg((color)::ChartGetInteger(::ChartID(),CHART_COLOR_BACKGROUND))
                        { this.m_type=OBJECT_DE_TYPE_GELEMENT; }
                    ~CGCnvElement()
                        { this.m_canvas.Destroy();             }
     
//+------------------------------------------------------------------+
//| Methods of simplified access to object properties                |
//+------------------------------------------------------------------+
//--- Set the (1) X, (2) Y coordinates, (3) element width, (4) height, (5) right (6) and bottom edge,
   bool              SetCoordX(const int coord_x);
   bool              SetCoordY(const int coord_y);
   bool              SetWidth(const int width);
   bool              SetHeight(const int height);
   void              SetRightEdge(void)                        { this.SetProperty(CANV_ELEMENT_PROP_RIGHT,this.RightEdge());           }
   void              SetBottomEdge(void)                       { this.SetProperty(CANV_ELEMENT_PROP_BOTTOM,this.BottomEdge());         }
//--- Set the shift of the (1) left, (2) top, (3) right, (4) bottom edge of the active area relative to the element,
//--- (5) all shifts of the active area edges relative to the element, (6) the element background color and (7) the element opacity
   void              SetActiveAreaLeftShift(const int value)   { this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_LEFT,fabs(value));       }
   void              SetActiveAreaRightShift(const int value)  { this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_RIGHT,fabs(value));      }
   void              SetActiveAreaTopShift(const int value)    { this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_TOP,fabs(value));        }
   void              SetActiveAreaBottomShift(const int value) { this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_BOTTOM,fabs(value));     }
   void              SetActiveAreaShift(const int left_shift,const int bottom_shift,const int right_shift,const int top_shift);
   void              SetColorBackground(const color colour)    { this.m_color_bg=colour;                                               }
   void              SetOpacity(const uchar value,const bool redraw=false);

//--- Set the flag of (1) object moveability, (2) activity, (3) element ID, (4) element index in the list and (5) shadow presence
   void              SetMovable(const bool flag)               { this.SetProperty(CANV_ELEMENT_PROP_MOVABLE,flag);                     }
   void              SetActive(const bool flag)                { this.SetProperty(CANV_ELEMENT_PROP_ACTIVE,flag);                      }
   void              SetInteraction(const bool flag)           { this.SetProperty(CANV_ELEMENT_PROP_INTERACTION,flag);                 }
   void              SetID(const int id)                       { this.SetProperty(CANV_ELEMENT_PROP_ID,id);                            }
   void              SetNumber(const int number)               { this.SetProperty(CANV_ELEMENT_PROP_NUM,number);                       }
   void              SetShadow(const bool flag)                { this.m_shadow=flag;                                                   }
   
//--- Return the shift (1) of the left, (2) right, (3) top and (4) bottom edge of the element active area
   int               ActiveAreaLeftShift(void)           const { return (int)this.GetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_LEFT);       }
   int               ActiveAreaRightShift(void)          const { return (int)this.GetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_RIGHT);      }
   int               ActiveAreaTopShift(void)            const { return (int)this.GetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_TOP);        }
   int               ActiveAreaBottomShift(void)         const { return (int)this.GetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_BOTTOM);     }
//--- Return the coordinate (1) of the left, (2) right, (3) top and (4) bottom edge of the element active area
   int               ActiveAreaLeft(void)                const { return int(this.CoordX()+this.ActiveAreaLeftShift());                 }
   int               ActiveAreaRight(void)               const { return int(this.RightEdge()-this.ActiveAreaRightShift());             }
   int               ActiveAreaTop(void)                 const { return int(this.CoordY()+this.ActiveAreaTopShift());                  }
   int               ActiveAreaBottom(void)              const { return int(this.BottomEdge()-this.ActiveAreaBottomShift());           }
//--- Return (1) the background color, (2) the opacity, coordinate (3) of the right and (4) bottom element edge
   color             ColorBackground(void)               const { return this.m_color_bg;                                               }
   uchar             Opacity(void)                       const { return this.m_opacity;                                                }
   int               RightEdge(void)                     const { return this.CoordX()+this.m_canvas.Width();                           }
   int               BottomEdge(void)                    const { return this.CoordY()+this.m_canvas.Height();                          }
//--- Return the (1) X, (2) Y coordinates, (3) element width and (4) height,
   int               CoordX(void)                        const { return (int)this.GetProperty(CANV_ELEMENT_PROP_COORD_X);              }
   int               CoordY(void)                        const { return (int)this.GetProperty(CANV_ELEMENT_PROP_COORD_Y);              }
   int               Width(void)                         const { return (int)this.GetProperty(CANV_ELEMENT_PROP_WIDTH);                }
   int               Height(void)                        const { return (int)this.GetProperty(CANV_ELEMENT_PROP_HEIGHT);               }
//--- Return the element (1) moveability and (2) activity flag
   bool              Movable(void)                       const { return (bool)this.GetProperty(CANV_ELEMENT_PROP_MOVABLE);             }
   bool              Active(void)                        const { return (bool)this.GetProperty(CANV_ELEMENT_PROP_ACTIVE);              }
   bool              Interaction(void)                   const { return (bool)this.GetProperty(CANV_ELEMENT_PROP_INTERACTION);         }
//--- Return (1) the object name, (2) the graphical resource name, (3) the chart ID and (4) the chart subwindow index
   string            NameObj(void)                       const { return this.GetProperty(CANV_ELEMENT_PROP_NAME_OBJ);                  }
   string            NameRes(void)                       const { return this.GetProperty(CANV_ELEMENT_PROP_NAME_RES);                  }
   long              ChartID(void)                       const { return this.GetProperty(CANV_ELEMENT_PROP_CHART_ID);                  }
   int               WindowNum(void)                     const { return (int)this.GetProperty(CANV_ELEMENT_PROP_WND_NUM);              }
//--- Return (1) the element ID, (2) element index in the list, (3) flag of the form shadow presence and (4) the chart background color
   int               ID(void)                            const { return (int)this.GetProperty(CANV_ELEMENT_PROP_ID);                   }
   int               Number(void)                        const { return (int)this.GetProperty(CANV_ELEMENT_PROP_NUM);                  }
   bool              IsShadow(void)                      const { return this.m_shadow;                                                 }
   color             ChartColorBackground(void)          const { return this.m_chart_color_bg;                                         }
//--- Set the object above all
   void              BringToTop(void)                          { CGBaseObj::SetVisible(false,false); CGBaseObj::SetVisible(true,false);}
//--- (1) Show and (2) hide the element
   virtual void      Show(void)                                { CGBaseObj::SetVisible(true,false);                                    }
   virtual void      Hide(void)                                { CGBaseObj::SetVisible(false,false);                                   }
   
//--- Priority of a graphical object for receiving the event of clicking on a chart
   virtual long      Zorder(void)                        const { return this.GetProperty(CANV_ELEMENT_PROP_ZORDER);                    }
   virtual bool      SetZorder(const long value,const bool only_prop)
                       {
                        if(!CGBaseObj::SetZorder(value,only_prop))
                           return false;
                        this.SetProperty(CANV_ELEMENT_PROP_ZORDER,value);
                        return true;
                       }
//+------------------------------------------------------------------+
//| The methods of receiving raster data                             |
//+------------------------------------------------------------------+
//--- Get a color of the dot with the specified coordinates
   uint              GetPixel(const int x,const int y)   const { return this.m_canvas.PixelGet(x,y);                                   }

//+------------------------------------------------------------------+
//| The methods of filling, clearing and updating raster data        |
//+------------------------------------------------------------------+
//--- Clear the element filling it with color and opacity
   void              Erase(const color colour,const uchar opacity,const bool redraw=false);
//--- Clear the element with a gradient fill
   void              Erase(color &colors[],const uchar opacity,const bool vgradient=true,const bool cycle=false,const bool redraw=false);
//--- Clear the element completely
   void              Erase(const bool redraw=false);
//--- Update the element
   void              Update(const bool redraw=false)           { this.m_canvas.Update(redraw);                                         }
   
//+------------------------------------------------------------------+
//| The methods of drawing primitives without smoothing              |
//+------------------------------------------------------------------+
//--- Set the color of the dot with the specified coordinates
   void              SetPixel(const int x,const int y,const color clr,const uchar opacity=255)
                       { this.m_canvas.PixelSet(x,y,::ColorToARGB(clr,opacity));                                                       }
                       
//--- Draw a segment of a vertical line
   void              DrawLineVertical(const int x,                // X coordinate of the segment
                                      const int y1,               // Y coordinate of the segment first point
                                      const int y2,               // Y coordinate of the segment second point
                                      const color clr,            // Color
                                      const uchar opacity=255)    // Opacity
                       { this.m_canvas.LineVertical(x,y1,y2,::ColorToARGB(clr,opacity));                                               }
                       
//--- Draw a segment of a horizontal line
   void              DrawLineHorizontal(const int x1,             // X coordinate of the segment's first point
                                        const int x2,             // X coordinate of the segment second point
                                        const int y,              // Segment Y coordinate
                                        const color clr,          // Color
                                        const uchar opacity=255)  // Opacity
                       { this.m_canvas.LineHorizontal(x1,x2,y,::ColorToARGB(clr,opacity));                                             }
                       
//--- Draw a segment of a freehand line
   void              DrawLine(const int x1,                       // X coordinate of the segment's first point
                              const int y1,                       // Y coordinate of the segment first point
                              const int x2,                       // X coordinate of the segment second point
                              const int y2,                       // Y coordinate of the segment second point
                              const color clr,                    // Color
                              const uchar opacity=255)            // Opacity
                       { this.m_canvas.Line(x1,y1,x2,y2,::ColorToARGB(clr,opacity));                                                   }
                       
//--- Draw a polyline
   void              DrawPolyline(int &array_x[],                 // Array with the X coordinates of polyline points
                                  int & array_y[],                // Array with the Y coordinates of polyline points
                                  const color clr,                // Color
                                  const uchar opacity=255)        // Opacity
                       { this.m_canvas.Polyline(array_x,array_y,::ColorToARGB(clr,opacity));                                           }
                       
//--- Draw a polygon
   void              DrawPolygon(int &array_x[],                  // Array with the X coordinates of polygon points
                                 int &array_y[],                  // Array with the Y coordinates of polygon points
                                 const color clr,                 // Color
                                 const uchar opacity=255)         // Opacity
                       { this.m_canvas.Polygon(array_x,array_y,::ColorToARGB(clr,opacity));                                            }
                       
//--- Draw a rectangle using two points
   void              DrawRectangle(const int x1,                  // X coordinate of the first point defining the rectangle
                                   const int y1,                  // Y coordinate of the first point defining the rectangle
                                   const int x2,                  // X coordinate of the second point defining the rectangle
                                   const int y2,                  // Y coordinate of the second point defining the rectangle
                                   const color clr,               // color
                                   const uchar opacity=255)       // Opacity
                       { this.m_canvas.Rectangle(x1,y1,x2,y2,::ColorToARGB(clr,opacity));                                              }
                       
//--- Draw a circle
   void              DrawCircle(const int x,                      // X coordinate of the circle center
                                const int y,                      // Y coordinate of the circle center
                                const int r,                      // Circle radius
                                const color clr,                  // Color
                                const uchar opacity=255)          // Opacity
                       { this.m_canvas.Circle(x,y,r,::ColorToARGB(clr,opacity));                                                       }
                       
//--- Draw a triangle
   void              DrawTriangle(const int x1,                   // X coordinate of the triangle first vertex
                                  const int y1,                   // Y coordinate of the triangle first vertex
                                  const int x2,                   // X coordinate of the triangle second vertex
                                  const int y2,                   // Y coordinate of the triangle second vertex
                                  const int x3,                   // X coordinate of the triangle third vertex
                                  const int y3,                   // Y coordinate of the triangle third vertex
                                  const color clr,                // Color
                                  const uchar opacity=255)        // Opacity
                       { m_canvas.Triangle(x1,y1,x2,y2,x3,y3,::ColorToARGB(clr,opacity));                                              }
                       
//--- Draw an ellipse using two points
   void              DrawEllipse(const int x1,                    // X coordinate of the first point defining the ellipse
                                 const int y1,                    // Y coordinate of the first point defining the ellipse
                                 const int x2,                    // X coordinate of the second point defining the ellipse
                                 const int y2,                    // Y coordinate of the second point defining the ellipse
                                 const color clr,                 // Color
                                 const uchar opacity=255)         // Opacity
                       { this.m_canvas.Ellipse(x1,y1,x2,y2,::ColorToARGB(clr,opacity));                                                }
                       
//--- Draw an arc of an ellipse inscribed in a rectangle with corners at (x1,y1) and (x2,y2).
//--- The arc boundaries are clipped by lines from the center of the ellipse, which extend to two points with coordinates (x3,y3) and (x4,y4)
   void              DrawArc(const int x1,                        // X coordinate of the top left corner forming the rectangle
                             const int y1,                        // Y coordinate of the top left corner forming the rectangle
                             const int x2,                        // X coordinate of the bottom right corner forming the rectangle
                             const int y2,                        // Y coordinate of the bottom right corner forming the rectangle
                             const int x3,                        // X coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                             const int y3,                        // Y coordinate of the first point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                             const int x4,                        // X coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                             const int y4,                        // Y coordinate of the second point, to which a line from the rectangle center is drawn in order to obtain the arc boundary
                             const color clr,                     // Color
                             const uchar opacity=255)             // Opacity
                       { m_canvas.Arc(x1,y1,x2,y2,x3,y3,x4,y4,::ColorToARGB(clr,opacity));                                             }
                       
//--- Draw a filled sector of an ellipse inscribed in a rectangle with corners at (x1,y1) and (x2,y2).
//--- The sector boundaries are clipped by lines from the center of the ellipse, which extend to two points with coordinates (x3,y3) and (x4,y4)
   void              DrawPie(const int x1,                        // X coordinate of the upper left corner of the rectangle
                             const int y1,                        // Y coordinate of the upper left corner of the rectangle
                             const int x2,                        // X coordinate of the bottom right corner of the rectangle
                             const int y2,                        // Y coordinate of the bottom right corner of the rectangle
                             const int x3,                        // X coordinate of the first point to find the arc boundaries
                             const int y3,                        // Y coordinate of the first point to find the arc boundaries
                             const int x4,                        // X coordinate of the second point to find the arc boundaries
                             const int y4,                        // Y coordinate of the second point to find the arc boundaries
                             const color clr,                     // Line color
                             const color fill_clr,                // Fill color
                             const uchar opacity=255)             // Opacity
                       { this.m_canvas.Pie(x1,y1,x2,y2,x3,y3,x4,y4,::ColorToARGB(clr,opacity),ColorToARGB(fill_clr,opacity));          }
                       
//+------------------------------------------------------------------+
//| The methods of drawing filled primitives without smoothing       |
//+------------------------------------------------------------------+
//--- Fill in the area
   void              Fill(const int x,                            // X coordinate of the filling start point
                          const int y,                            // Y coordinate of the filling start point
                          const color clr,                        // Color
                          const uchar opacity=255,                // Opacity
                          const uint threshould=0)                // Threshold
                       { this.m_canvas.Fill(x,y,::ColorToARGB(clr,opacity),threshould);                                                }
                       
//--- Draw a filled rectangle
   void              DrawRectangleFill(const int x1,              // X coordinate of the first point defining the rectangle
                                       const int y1,              // Y coordinate of the first point defining the rectangle
                                       const int x2,              // X coordinate of the second point defining the rectangle
                                       const int y2,              // Y coordinate of the second point defining the rectangle
                                       const color clr,           // Color
                                       const uchar opacity=255)   // Opacity
                       { this.m_canvas.FillRectangle(x1,y1,x2,y2,::ColorToARGB(clr,opacity));                                          }

//--- Draw a filled circle
   void              DrawCircleFill(const int x,                  // X coordinate of the circle center
                                    const int y,                  // Y coordinate of the circle center
                                    const int r,                  // Circle radius
                                    const color clr,              // Color
                                    const uchar opacity=255)      // Opacity
                       { this.m_canvas.FillCircle(x,y,r,::ColorToARGB(clr,opacity));                                                   }
                       
//--- Draw a filled triangle
   void              DrawTriangleFill(const int         x1,      // X coordinate of the triangle first vertex
                                      const int         y1,      // Y coordinate of the triangle first vertex
                                      const int         x2,      // X coordinate of the triangle second vertex
                                      const int         y2,      // Y coordinate of the triangle second vertex
                                      const int         x3,      // X coordinate of the triangle third vertex
                                      const int         y3,      // Y coordinate of the triangle third vertex
                                      const color clr,           // Color
                                      const uchar opacity=255)   // Opacity
                       { this.m_canvas.FillTriangle(x1,y1,x2,y2,x3,y3,::ColorToARGB(clr,opacity));                                     }
                       
//--- Draw a filled polygon
   void              DrawPolygonFill(int &array_x[],              // Array with the X coordinates of polygon points
                                     int &array_y[],              // Array with the Y coordinates of polygon points
                                     const color clr,             // Color
                                     const uchar opacity=255)     // Opacity
                       { this.m_canvas.FillPolygon(array_x,array_y,::ColorToARGB(clr,opacity));                                        }
                       
//--- Draw a filled ellipse inscribed in a rectangle with the specified coordinates
   void              DrawEllipseFill(const int x1,                // X coordinate of the top left corner forming the rectangle
                                     const int y1,                // Y coordinate of the top left corner forming the rectangle
                                     const int x2,                // X coordinate of the bottom right corner forming the rectangle
                                     const int y2,                // Y coordinate of the bottom right corner forming the rectangle
                                     const color clr,             // Color
                                     const uchar opacity=255)     // Opacity
                       { this.m_canvas.FillEllipse(x1,y1,x2,y2,::ColorToARGB(clr,opacity));                                            }
                       
//+------------------------------------------------------------------+
//| The methods of drawing primitives using smoothing                |
//+------------------------------------------------------------------+
//--- Draw a point using AntiAliasing algorithm
   void              SetPixelAA(const double x,                   // Pixel X coordinate
                                const double y,                   // Pixel Y coordinate
                                const color clr,                  // Color
                                const uchar opacity=255)          // Opacity
                       { this.m_canvas.PixelSetAA(x,y,::ColorToARGB(clr,opacity));                                                     }
                       
//--- Draw a segment of a freehand line using AntiAliasing algorithm
   void              DrawLineAA(const int   x1,                   // X coordinate of the segment first point
                                const int   y1,                   // Y coordinate of the segment first point
                                const int   x2,                   // X coordinate of the segment second point
                                const int   y2,                   // Y coordinate of the segment second point
                                const color clr,                  // Color
                                const uchar opacity=255,          // Opacity
                                const uint  style=UINT_MAX)       // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { this.m_canvas.LineAA(x1,y1,x2,y2,::ColorToARGB(clr,opacity),style);                                           }
                       
//--- Draw a segment of a freehand line using Wu algorithm
   void              DrawLineWu(const int   x1,                   // X coordinate of the segment's first point
                                const int   y1,                   // Y coordinate of the segment first point
                                const int   x2,                   // X coordinate of the segment second point
                                const int   y2,                   // Y coordinate of the segment second point
                                const color clr,                  // Color
                                const uchar opacity=255,          // Opacity
                                const uint  style=UINT_MAX)       // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { this.m_canvas.LineWu(x1,y1,x2,y2,::ColorToARGB(clr,opacity),style);                                           }
                       
//--- Draws a segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration
   void              DrawLineThick(const int   x1,                // X coordinate of the segment first point
                                   const int   y1,                // Y coordinate of the segment first point
                                   const int   x2,                // X coordinate of the segment second point
                                   const int   y2,                // Y coordinate of the segment second point
                                   const int   size,              // Line width
                                   const color clr,               // Color
                                   const uchar opacity=255,       // Opacity
                                   const uint  style=STYLE_SOLID, // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                                   ENUM_LINE_END end_style=LINE_END_ROUND) // Line style is one of the ENUM_LINE_END enumeration's values
                       { this.m_canvas.LineThick(x1,y1,x2,y2,::ColorToARGB(clr,opacity),size,style,end_style);                         }
 
//--- Draw a vertical segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration
   void              DrawLineThickVertical(const int   x,         // X coordinate of the segment
                                           const int   y1,        // Y coordinate of the segment first point
                                           const int   y2,        // Y coordinate of the segment second point
                                           const int   size,      // Line width
                                           const color clr,       // Color
                                           const uchar opacity=255,// Opacity
                                           const uint  style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                                           const ENUM_LINE_END end_style=LINE_END_ROUND)  // Line style is one of the ENUM_LINE_END enumeration's values
                       { this.m_canvas.LineThickVertical(x,y1,y2,::ColorToARGB(clr,opacity),size,style,end_style);                     }
                       
//--- Draw a horizontal segment of a freehand line having a specified width using smoothing algorithm with the preliminary filtration
   void              DrawLineThickHorizontal(const int   x1,      // X coordinate of the segment first point
                                             const int   x2,      // X coordinate of the segment second point
                                             const int   y,       // Segment Y coordinate
                                             const int   size,    // Line width
                                             const color clr,     // Color
                                             const uchar opacity=255,// Opacity
                                             const uint  style=STYLE_SOLID,  // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                                             const ENUM_LINE_END end_style=LINE_END_ROUND)  // Line style is one of the ENUM_LINE_END enumeration's values
                       { this.m_canvas.LineThickHorizontal(x1,x2,y,::ColorToARGB(clr,opacity),size,style,end_style);                   }

//--- Draws a polyline using AntiAliasing algorithm
   void              DrawPolylineAA(int        &array_x[],        // Array with the X coordinates of polyline points
                                    int        &array_y[],        // Array with the Y coordinates of polyline points
                                    const color clr,              // Color
                                    const uchar opacity=255,      // Opacity
                                    const uint  style=UINT_MAX)   // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { this.m_canvas.PolylineAA(array_x,array_y,::ColorToARGB(clr,opacity),style);                                   }
                       
//--- Draws a polyline using Wu algorithm
   void              DrawPolylineWu(int        &array_x[],        // Array with the X coordinates of polyline points
                                    int        &array_y[],        // Array with the Y coordinates of polyline points
                                    const color clr,              // Color
                                    const uchar opacity=255,      // Opacity
                                    const uint  style=UINT_MAX)   // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { this.m_canvas.PolylineWu(array_x,array_y,::ColorToARGB(clr,opacity),style);                                   }
                       
//--- Draw a polyline with a specified width consecutively using two antialiasing algorithms.
//--- First, individual line segments are smoothed based on Bezier curves.
//--- Then, the raster antialiasing algorithm is applied to the polyline built from these segments to improve the rendering quality
   void              DrawPolylineSmooth(const int   &array_x[],   // Array with the X coordinates of polyline points
                                        const int   &array_y[],   // Array with the Y coordinates of polyline points
                                        const int    size,        // Line width
                                        const color  clr,         // Color
                                        const uchar  opacity=255, // Opacity
                                        const double tension=0.5, // Smoothing parameter value
                                        const double step=10,     // Approximation step
                                        const ENUM_LINE_STYLE style=STYLE_SOLID,// Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                                        const ENUM_LINE_END   end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
                       { this.m_canvas.PolylineSmooth(array_x,array_y,::ColorToARGB(clr,opacity),size,style,end_style,tension,step);   }
                       
//--- Draw a polyline having a specified width using smoothing algorithm with the preliminary filtration
   void              DrawPolylineThick(const int     &array_x[],  // Array with the X coordinates of polyline points
                                       const int     &array_y[],  // Array with the Y coordinates of polyline points
                                       const int      size,       // Line width
                                       const color    clr,        // Color
                                       const uchar    opacity=255,// Opacity
                                       const uint     style=STYLE_SOLID,         // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                                       ENUM_LINE_END  end_style=LINE_END_ROUND)  // Line style is one of the ENUM_LINE_END enumeration values
                       { this.m_canvas.PolylineThick(array_x,array_y,::ColorToARGB(clr,opacity),size,style,end_style);                 }
                       
//--- Draw a polygon using AntiAliasing algorithm
   void              DrawPolygonAA(int        &array_x[],         // Array with the X coordinates of polygon points
                                   int        &array_y[],         // Array with the Y coordinates of polygon points
                                   const color clr,               // Color
                                   const uchar opacity=255,       // Opacity
                                   const uint  style=UINT_MAX)    // Line style is one of the ENUM_LINE_STYLE enumeration values or a custom value
                       { this.m_canvas.PolygonAA(array_x,array_y,::ColorToARGB(clr,opacity),style);                                    }
                       
//--- Draw a polygon using Wu algorithm
   void              DrawPolygonWu(int        &array_x[],         // Array with the X coordinates of polygon points
                                   int        &array_y[],         // Array with the Y coordinates of polygon points
                                   const color clr,               // Color
                                   const uchar opacity=255,       // Opacity
                                   const uint  style=UINT_MAX)    // Line style is one of the ENUM_LINE_STYLE enumeration values or a custom value
                       { this.m_canvas.PolygonWu(array_x,array_y,::ColorToARGB(clr,opacity),style);                                    }
                       
//--- Draw a polygon with a specified width consecutively using two smoothing algorithms.
//--- First, individual segments are smoothed based on Bezier curves.
//--- Then, the raster smoothing algorithm is applied to the polygon built from these segments to improve the rendering quality. 
   void              DrawPolygonSmooth(int         &array_x[],    // Array with the X coordinates of polyline points
                                       int         &array_y[],    // Array with the Y coordinates of polyline points
                                       const int    size,         // Line width
                                       const color  clr,          // Color
                                       const uchar  opacity=255,  // Opacity
                                       const double tension=0.5,  // Smoothing parameter value
                                       const double step=10,      // Approximation step
                                       const ENUM_LINE_STYLE style=STYLE_SOLID,// Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                                       const ENUM_LINE_END   end_style=LINE_END_ROUND)// Line style is one of the ENUM_LINE_END enumeration values
                       { this.m_canvas.PolygonSmooth(array_x,array_y,::ColorToARGB(clr,opacity),size,style,end_style,tension,step);    }
                       
//--- Draw a polygon having a specified width using smoothing algorithm with the preliminary filtration
   void              DrawPolygonThick(const int  &array_x[],      // array with the X coordinates of polygon points
                                      const int  &array_y[],      // array with the Y coordinates of polygon points
                                      const int   size,           // Line width
                                      const color clr,            // Color
                                      const uchar opacity=255,    // Opacity
                                      const uint  style=STYLE_SOLID,// line style
                                      ENUM_LINE_END end_style=LINE_END_ROUND) // line ends style
                       { this.m_canvas.PolygonThick(array_x,array_y,::ColorToARGB(clr,opacity),size,style,end_style);                  }
                       
//--- Draw a triangle using AntiAliasing algorithm
   void              DrawTriangleAA(const int   x1,               // X coordinate of the triangle first vertex
                                    const int   y1,               // Y coordinate of the triangle first vertex
                                    const int   x2,               // X coordinate of the triangle second vertex
                                    const int   y2,               // Y coordinate of the triangle second vertex
                                    const int   x3,               // X coordinate of the triangle third vertex
                                    const int   y3,               // Y coordinate of the triangle third vertex
                                    const color clr,              // Color
                                    const uchar opacity=255,      // Opacity
                                    const uint  style=UINT_MAX)   // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { this.m_canvas.TriangleAA(x1,y1,x2,y2,x3,y3,::ColorToARGB(clr,opacity),style);                                 }
                       
//--- Draw a triangle using Wu algorithm
   void              DrawTriangleWu(const int   x1,               // X coordinate of the triangle first vertex
                                    const int   y1,               // Y coordinate of the triangle first vertex
                                    const int   x2,               // X coordinate of the triangle second vertex
                                    const int   y2,               // Y coordinate of the triangle second vertex
                                    const int   x3,               // X coordinate of the triangle third vertex
                                    const int   y3,               // Y coordinate of the triangle third vertex
                                    const color clr,              // Color
                                    const uchar opacity=255,      // Opacity
                                    const uint  style=UINT_MAX)   // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { this.m_canvas.TriangleWu(x1,y1,x2,y2,x3,y3,::ColorToARGB(clr,opacity),style);                                 }
                       
//--- Draw a circle using AntiAliasing algorithm
   void              DrawCircleAA(const int    x,                 // X coordinate of the circle center
                                  const int    y,                 // Y coordinate of the circle center
                                  const double r,                 // Circle radius
                                  const color  clr,               // Color
                                  const uchar opacity=255,        // Opacity
                                  const uint  style=UINT_MAX)     // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { this.m_canvas.CircleAA(x,y,r,::ColorToARGB(clr,opacity),style);                                               }
                       
//--- Draw a circle using Wu algorithm
   void              DrawCircleWu(const int    x,                 // X coordinate of the circle center
                                  const int    y,                 // Y coordinate of the circle center
                                  const double r,                 // Circle radius
                                  const color  clr,               // Color
                                  const uchar opacity=255,        // Opacity
                                  const uint  style=UINT_MAX)     // Line style is one of the ENUM_LINE_STYLE enumeration's values or a custom value
                       { this.m_canvas.CircleWu(x,y,r,::ColorToARGB(clr,opacity),style);                                               }
                       
//--- Draw an ellipse by two points using AntiAliasing algorithm
   void              DrawEllipseAA(const double x1,               // X coordinate of the first point defining the ellipse
                                   const double y1,               // Y coordinate of the first point defining the ellipse
                                   const double x2,               // X coordinate of the second point defining the ellipse
                                   const double y2,               // Y coordinate of the second point defining the ellipse
                                   const color  clr,              // Color
                                   const uchar opacity=255,       // Opacity
                                   const uint  style=UINT_MAX)    // Line style is one of the ENUM_LINE_STYLE enumeration values or a custom value
                       { this.m_canvas.EllipseAA(x1,y1,x2,y2,::ColorToARGB(clr,opacity),style);                                        }
                       
//--- Draw an ellipse by two points using Wu algorithm
   void              DrawEllipseWu(const int   x1,                // X coordinate of the first point defining the ellipse
                                   const int   y1,                // Y coordinate of the first point defining the ellipse
                                   const int   x2,                // X coordinate of the second point defining the ellipse
                                   const int   y2,                // Y coordinate of the second point defining the ellipse
                                   const color clr,               // Color
                                   const uchar opacity=255,       // Opacity
                                   const uint  style=UINT_MAX)    // Line style is one of the ENUM_LINE_STYLE enumeration values or a custom value
                       { this.m_canvas.EllipseWu(x1,y1,x2,y2,::ColorToARGB(clr,opacity),style);                                        }

//+------------------------------------------------------------------+
//| The methods of working with text                                 |
//+------------------------------------------------------------------+
//--- Return (1) alignment type (anchor method), the last (2) X and (3) Y text coordinate
   ENUM_FRAME_ANCHOR TextAnchor(void)                       const { return this.m_text_anchor;                                         }
   int               TextLastX(void)                        const { return this.m_text_x;                                              }
   int               TextLastY(void)                        const { return this.m_text_y;                                              }
//--- Set the current font
   bool              SetFont(const string name,                   // Font name. For example, "Arial"
                             const int    size,                   // Font size
                             const uint   flags=0,                // Font creation flags
                             const uint   angle=0,                // Font slope angle in tenths of a degree
                             const bool   relative=true)          // Relative font size flag
                       { return this.m_canvas.FontSet(name,(relative ? size*-10 : size),flags,angle);                                  }

//--- Set a font name
   bool              SetFontName(const string name)               // Font name. For example, "Arial"
                       { return this.m_canvas.FontNameSet(name);                                                                       }

//--- Set a font size
   bool              SetFontSize(const int size,                  // Font size
                                 const bool relative=true)        // Relative font size flag
                       { return this.m_canvas.FontSizeSet(relative ? size*-10 : size);                                                 }

//--- Set font flags
//--- FONT_ITALIC - Italic, FONT_UNDERLINE - Underline, FONT_STRIKEOUT - Strikeout
   bool              SetFontFlags(const uint flags)               // Font creation flags
                       { return this.m_canvas.FontFlagsSet(flags);                                                                     }

//--- Set a font slope angle
   bool              SetFontAngle(const float angle)              // Font slope angle in tenths of a degree
                       { return this.m_canvas.FontAngleSet(uint(angle*10));                                                            }

//--- Set the font anchor angle (alignment type)
   void              SetTextAnchor(const uint flags=0)      { this.m_text_anchor=(ENUM_FRAME_ANCHOR)flags;                             }

//--- Gets the current font parameters and write them to variables
   void              GetFont(string &name,                        // The reference to the variable for returning a font name
                             int    &size,                        // Reference to the variable for returning a font size
                             uint   &flags,                       // Reference to the variable for returning font flags
                             uint   &angle)                       // Reference to the variable for returning a font slope angle
                       { this.m_canvas.FontGet(name,size,flags,angle);                                                                 }

//--- Return (1) the font name, (2) size, (3) flags and (4) slope angle
   string            FontName(void)                         const { return this.m_canvas.FontNameGet();                                }
   int               FontSize(void)                         const { return this.m_canvas.FontSizeGet();                                }
   int               FontSizeRelative(void)                 const { return(this.FontSize()<0 ? -this.FontSize()/10 : this.FontSize()); }
   uint              FontFlags(void)                        const { return this.m_canvas.FontFlagsGet();                               }
   uint              FontAngle(void)                        const { return this.m_canvas.FontAngleGet();                               }

//--- Return the text (1) width, (2) height and (3) all sizes (the current font is used to measure the text)
   int               TextWidth(const string text)                 { return this.m_canvas.TextWidth(text);                              }
   int               TextHeight(const string text)                { return this.m_canvas.TextHeight(text);                             }
   void              TextSize(const string text,                  // Text for measurement
                              int         &width,                 // Reference to the variable for returning a text width
                              int         &height)                // Reference to the variable for returning a text height
                       { this.m_canvas.TextSize(text,width,height);                                                                    }

//--- Display the text in the current font
   void              Text(int         x,                          // X coordinate of the text anchor point
                          int         y,                          // Y coordinate of the text anchor point
                          string      text,                       // Display text
                          const color clr,                        // Color
                          const uchar opacity=255,                // Opacity
                          uint        alignment=0)                // Text anchoring method
                       { 
                        this.m_text_anchor=(ENUM_FRAME_ANCHOR)alignment;
                        this.m_text_x=x;
                        this.m_text_y=y;
                        this.m_canvas.TextOut(x,y,text,::ColorToARGB(clr,opacity),alignment);
                       }
//--- Return coordinate offsets relative to the text anchor point by text
   void              GetShiftXYbyText(const string text,             // Text for calculating the size of its outlining rectangle
                                      const ENUM_FRAME_ANCHOR anchor,// Text anchor point, relative to which the offsets are calculated
                                      int &shift_x,                  // X coordinate of the rectangle upper left corner
                                      int &shift_y);                 // Y coordinate of the rectangle upper left corner
//--- Return coordinate offsets relative to the rectangle anchor point by size
   void              GetShiftXYbySize(const int width,               // Rectangle size by width
                                      const int height,              // Rectangle size by height
                                      const ENUM_FRAME_ANCHOR anchor,// Rectangle anchor point, relative to which the offsets are calculated
                                      int &shift_x,                  // X coordinate of the rectangle upper left corner
                                      int &shift_y);                 // Y coordinate of the rectangle upper left corner

  };
//+------------------------------------------------------------------+
//| Parametric constructor                                           |
//+------------------------------------------------------------------+
CGCnvElement::CGCnvElement(const ENUM_GRAPH_ELEMENT_TYPE element_type,
                           const int      element_id,
                           const int      element_num,
                           const long     chart_id,
                           const int      wnd_num,
                           const string   name,
                           const int      x,
                           const int      y,
                           const int      w,
                           const int      h,
                           const color    colour,
                           const uchar    opacity,
                           const bool     movable=true,
                           const bool     activity=true,
                           const bool     redraw=false) : m_shadow(false)
  {
   this.m_type=OBJECT_DE_TYPE_GELEMENT; 
   this.m_chart_color_bg=(color)::ChartGetInteger(chart_id,CHART_COLOR_BACKGROUND);
   this.m_name=(::StringFind(name,this.m_name_prefix)<0 ? this.m_name_prefix : "")+name;
   this.m_chart_id=chart_id;
   this.m_subwindow=wnd_num;
   this.m_type_element=element_type;
   this.SetFont("Calibri",8);
   this.m_text_anchor=0;
   this.m_text_x=0;
   this.m_text_y=0;
   this.m_color_bg=colour;
   this.m_opacity=opacity;
   if(this.Create(chart_id,wnd_num,this.m_name,x,y,w,h,colour,opacity,redraw))
     {
      this.SetProperty(CANV_ELEMENT_PROP_NAME_RES,this.m_canvas.ResourceName()); // Graphical resource name
      this.SetProperty(CANV_ELEMENT_PROP_CHART_ID,CGBaseObj::ChartID());         // Chart ID
      this.SetProperty(CANV_ELEMENT_PROP_WND_NUM,CGBaseObj::SubWindow());        // Chart subwindow index
      this.SetProperty(CANV_ELEMENT_PROP_NAME_OBJ,CGBaseObj::Name());            // Element object name
      this.SetProperty(CANV_ELEMENT_PROP_TYPE,element_type);                     // Graphical element type
      this.SetProperty(CANV_ELEMENT_PROP_ID,element_id);                         // Element ID
      this.SetProperty(CANV_ELEMENT_PROP_NUM,element_num);                       // Element index in the list
      this.SetProperty(CANV_ELEMENT_PROP_COORD_X,x);                             // Element's X coordinate on the chart
      this.SetProperty(CANV_ELEMENT_PROP_COORD_Y,y);                             // Element's Y coordinate on the chart
      this.SetProperty(CANV_ELEMENT_PROP_WIDTH,w);                               // Element width
      this.SetProperty(CANV_ELEMENT_PROP_HEIGHT,h);                              // Element height
      this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_LEFT,0);                      // Active area offset from the left edge of the element
      this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_TOP,0);                       // Active area offset from the upper edge of the element
      this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_RIGHT,0);                     // Active area offset from the right edge of the element
      this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_BOTTOM,0);                    // Active area offset from the bottom edge of the element
      this.SetProperty(CANV_ELEMENT_PROP_MOVABLE,movable);                       // Element moveability flag
      this.SetProperty(CANV_ELEMENT_PROP_ACTIVE,activity);                       // Element activity flag
      this.SetProperty(CANV_ELEMENT_PROP_INTERACTION,false);                     // Flag of interaction with the outside environment
      this.SetProperty(CANV_ELEMENT_PROP_RIGHT,this.RightEdge());                // Element right border
      this.SetProperty(CANV_ELEMENT_PROP_BOTTOM,this.BottomEdge());              // Element bottom border
      this.SetProperty(CANV_ELEMENT_PROP_COORD_ACT_X,this.ActiveAreaLeft());     // X coordinate of the element active area
      this.SetProperty(CANV_ELEMENT_PROP_COORD_ACT_Y,this.ActiveAreaTop());      // Y coordinate of the element active area
      this.SetProperty(CANV_ELEMENT_PROP_ACT_RIGHT,this.ActiveAreaRight());      // Right border of the element active area
      this.SetProperty(CANV_ELEMENT_PROP_ACT_BOTTOM,this.ActiveAreaBottom());    // Bottom border of the element active area
     }
   else
     {
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_ELM_OBJ),": ",this.m_name);
     }
  }
//+------------------------------------------------------------------+
//| Protected constructor                                            |
//+------------------------------------------------------------------+
CGCnvElement::CGCnvElement(const ENUM_GRAPH_ELEMENT_TYPE element_type,
                           const long    chart_id,
                           const int     wnd_num,
                           const string  name,
                           const int     x,
                           const int     y,
                           const int     w,
                           const int     h) : m_shadow(false)
  {
   this.m_type=OBJECT_DE_TYPE_GELEMENT; 
   this.m_chart_color_bg=(color)::ChartGetInteger(chart_id,CHART_COLOR_BACKGROUND);
   this.m_name=(::StringFind(name,this.m_name_prefix)<0 ? this.m_name_prefix : "")+name;
   this.m_chart_id=chart_id;
   this.m_subwindow=wnd_num;
   this.m_type_element=element_type;
   this.SetFont("Calibri",8);
   this.m_text_anchor=0;
   this.m_text_x=0;
   this.m_text_y=0;
   this.m_color_bg=CLR_CANV_NULL;
   this.m_opacity=0;
   if(this.Create(chart_id,wnd_num,this.m_name,x,y,w,h,this.m_color_bg,this.m_opacity,false))
     {
      this.SetProperty(CANV_ELEMENT_PROP_NAME_RES,this.m_canvas.ResourceName()); // Graphical resource name
      this.SetProperty(CANV_ELEMENT_PROP_CHART_ID,CGBaseObj::ChartID());         // Chart ID
      this.SetProperty(CANV_ELEMENT_PROP_WND_NUM,CGBaseObj::SubWindow());        // Chart subwindow index
      this.SetProperty(CANV_ELEMENT_PROP_NAME_OBJ,CGBaseObj::Name());            // Element object name
      this.SetProperty(CANV_ELEMENT_PROP_TYPE,element_type);                     // Graphical element type
      this.SetProperty(CANV_ELEMENT_PROP_ID,0);                                  // Element ID
      this.SetProperty(CANV_ELEMENT_PROP_NUM,0);                                 // Element index in the list
      this.SetProperty(CANV_ELEMENT_PROP_COORD_X,x);                             // Element's X coordinate on the chart
      this.SetProperty(CANV_ELEMENT_PROP_COORD_Y,y);                             // Element's Y coordinate on the chart
      this.SetProperty(CANV_ELEMENT_PROP_WIDTH,w);                               // Element width
      this.SetProperty(CANV_ELEMENT_PROP_HEIGHT,h);                              // Element height
      this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_LEFT,0);                      // Active area offset from the left edge of the element
      this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_TOP,0);                       // Active area offset from the upper edge of the element
      this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_RIGHT,0);                     // Active area offset from the right edge of the element
      this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_BOTTOM,0);                    // Active area offset from the bottom edge of the element
      this.SetProperty(CANV_ELEMENT_PROP_MOVABLE,false);                         // Element moveability flag
      this.SetProperty(CANV_ELEMENT_PROP_ACTIVE,false);                          // Element activity flag
      this.SetProperty(CANV_ELEMENT_PROP_INTERACTION,false);                     // Flag of interaction with the outside environment
      this.SetProperty(CANV_ELEMENT_PROP_RIGHT,this.RightEdge());                // Element right border
      this.SetProperty(CANV_ELEMENT_PROP_BOTTOM,this.BottomEdge());              // Element bottom border
      this.SetProperty(CANV_ELEMENT_PROP_COORD_ACT_X,this.ActiveAreaLeft());     // X coordinate of the element active area
      this.SetProperty(CANV_ELEMENT_PROP_COORD_ACT_Y,this.ActiveAreaTop());      // Y coordinate of the element active area
      this.SetProperty(CANV_ELEMENT_PROP_ACT_RIGHT,this.ActiveAreaRight());      // Right border of the element active area
      this.SetProperty(CANV_ELEMENT_PROP_ACT_BOTTOM,this.ActiveAreaBottom());    // Bottom border of the element active area
     }
   else
     {
      ::Print(CMessage::Text(MSG_LIB_SYS_FAILED_CREATE_ELM_OBJ),this.m_name);
     }
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
//CGCnvElement::~CGCnvElement()
//  {
//   this.m_canvas.Destroy();
//  }
//+----------------------------------------------------------------------+
//|Compare CGCnvElement objects with each other by the specified property|
//+----------------------------------------------------------------------+
int CGCnvElement::Compare(const CObject *node,const int mode=0) const
  {
   const CGCnvElement *obj_compared=node;
//--- compare integer properties of two objects
   if(mode<CANV_ELEMENT_PROP_INTEGER_TOTAL)
     {
      long value_compared=obj_compared.GetProperty((ENUM_CANV_ELEMENT_PROP_INTEGER)mode);
      long value_current=this.GetProperty((ENUM_CANV_ELEMENT_PROP_INTEGER)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare real properties of two objects
   else if(mode<CANV_ELEMENT_PROP_DOUBLE_TOTAL+CANV_ELEMENT_PROP_INTEGER_TOTAL)
     {
      double value_compared=obj_compared.GetProperty((ENUM_CANV_ELEMENT_PROP_DOUBLE)mode);
      double value_current=this.GetProperty((ENUM_CANV_ELEMENT_PROP_DOUBLE)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare string properties of two objects
   else if(mode<CANV_ELEMENT_PROP_DOUBLE_TOTAL+CANV_ELEMENT_PROP_INTEGER_TOTAL+CANV_ELEMENT_PROP_STRING_TOTAL)
     {
      string value_compared=obj_compared.GetProperty((ENUM_CANV_ELEMENT_PROP_STRING)mode);
      string value_current=this.GetProperty((ENUM_CANV_ELEMENT_PROP_STRING)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//| Compare CGCnvElement objects with each other by all properties   |
//+------------------------------------------------------------------+
bool CGCnvElement::IsEqual(CGCnvElement *compared_obj) const
  {
   int begin=0, end=CANV_ELEMENT_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_CANV_ELEMENT_PROP_INTEGER prop=(ENUM_CANV_ELEMENT_PROP_INTEGER)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=CANV_ELEMENT_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_CANV_ELEMENT_PROP_DOUBLE prop=(ENUM_CANV_ELEMENT_PROP_DOUBLE)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=CANV_ELEMENT_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_CANV_ELEMENT_PROP_STRING prop=(ENUM_CANV_ELEMENT_PROP_STRING)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Create the object structure                                      |
//+------------------------------------------------------------------+
bool CGCnvElement::ObjectToStruct(void)
  {
//--- Save integer properties
   this.m_struct_obj.id=(int)this.GetProperty(CANV_ELEMENT_PROP_ID);                            // Element ID
   this.m_struct_obj.type=(int)this.GetProperty(CANV_ELEMENT_PROP_TYPE);                        // Graphical element type
   this.m_struct_obj.number=(int)this.GetProperty(CANV_ELEMENT_PROP_NUM);                       // Element index in the list
   this.m_struct_obj.chart_id=this.GetProperty(CANV_ELEMENT_PROP_CHART_ID);                     // Chart ID
   this.m_struct_obj.subwindow=(int)this.GetProperty(CANV_ELEMENT_PROP_WND_NUM);                // Chart subwindow index
   this.m_struct_obj.coord_x=(int)this.GetProperty(CANV_ELEMENT_PROP_COORD_X);                  // Form's X coordinate on the chart
   this.m_struct_obj.coord_y=(int)this.GetProperty(CANV_ELEMENT_PROP_COORD_Y);                  // Form's Y coordinate on the chart
   this.m_struct_obj.width=(int)this.GetProperty(CANV_ELEMENT_PROP_WIDTH);                      // Element width
   this.m_struct_obj.height=(int)this.GetProperty(CANV_ELEMENT_PROP_HEIGHT);                    // Element height
   this.m_struct_obj.edge_right=(int)this.GetProperty(CANV_ELEMENT_PROP_RIGHT);                 // Element right border
   this.m_struct_obj.edge_bottom=(int)this.GetProperty(CANV_ELEMENT_PROP_BOTTOM);               // Element bottom border
   this.m_struct_obj.act_shift_left=(int)this.GetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_LEFT);    // Active area offset from the left edge of the element
   this.m_struct_obj.act_shift_top=(int)this.GetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_TOP);      // Active area offset from the top edge of the element
   this.m_struct_obj.act_shift_right=(int)this.GetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_RIGHT);  // Active area offset from the right edge of the element
   this.m_struct_obj.act_shift_bottom=(int)this.GetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_BOTTOM);// Active area offset from the bottom edge of the element
   this.m_struct_obj.movable=(bool)this.GetProperty(CANV_ELEMENT_PROP_MOVABLE);                 // Element moveability flag
   this.m_struct_obj.active=(bool)this.GetProperty(CANV_ELEMENT_PROP_ACTIVE);                   // Element activity flag
   this.m_struct_obj.interaction=(bool)this.GetProperty(CANV_ELEMENT_PROP_INTERACTION);         // Flag of interaction with the outside environment
   this.m_struct_obj.coord_act_x=(int)this.GetProperty(CANV_ELEMENT_PROP_COORD_ACT_X);          // X coordinate of the element active area
   this.m_struct_obj.coord_act_y=(int)this.GetProperty(CANV_ELEMENT_PROP_COORD_ACT_Y);          // Y coordinate of the element active area
   this.m_struct_obj.coord_act_right=(int)this.GetProperty(CANV_ELEMENT_PROP_ACT_RIGHT);        // Right border of the element active area
   this.m_struct_obj.coord_act_bottom=(int)this.GetProperty(CANV_ELEMENT_PROP_ACT_BOTTOM);      // Bottom border of the element active area
   this.m_struct_obj.color_bg=this.m_color_bg;                                                  // Element background color
   this.m_struct_obj.opacity=this.m_opacity;                                                    // Element opacity
   this.m_struct_obj.zorder=this.m_zorder;                                                      // Graphical object priority in case of receiving an on-chart mouse click event
//--- Save real properties

//--- Save string properties
   ::StringToCharArray(this.GetProperty(CANV_ELEMENT_PROP_NAME_OBJ),this.m_struct_obj.name_obj);// Graphical element object name
   ::StringToCharArray(this.GetProperty(CANV_ELEMENT_PROP_NAME_RES),this.m_struct_obj.name_res);// Graphical resource name
   //--- Save the structure to the uchar array
   ::ResetLastError();
   if(!::StructToCharArray(this.m_struct_obj,this.m_uchar_array))
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_SAVE_OBJ_STRUCT_TO_UARRAY,true);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Create the object from the structure                             |
//+------------------------------------------------------------------+
void CGCnvElement::StructToObject(void)
  {
//--- Save integer properties
   this.SetProperty(CANV_ELEMENT_PROP_ID,this.m_struct_obj.id);                                 // Element ID
   this.SetProperty(CANV_ELEMENT_PROP_TYPE,this.m_struct_obj.type);                             // Graphical element type
   this.SetProperty(CANV_ELEMENT_PROP_NUM,this.m_struct_obj.number);                            // Element index in the list
   this.SetProperty(CANV_ELEMENT_PROP_CHART_ID,this.m_struct_obj.chart_id);                     // Chart ID
   this.SetProperty(CANV_ELEMENT_PROP_WND_NUM,this.m_struct_obj.subwindow);                     // Chart subwindow index
   this.SetProperty(CANV_ELEMENT_PROP_COORD_X,this.m_struct_obj.coord_x);                       // Form's X coordinate on the chart
   this.SetProperty(CANV_ELEMENT_PROP_COORD_Y,this.m_struct_obj.coord_y);                       // Form's Y coordinate on the chart
   this.SetProperty(CANV_ELEMENT_PROP_WIDTH,this.m_struct_obj.width);                           // Element width
   this.SetProperty(CANV_ELEMENT_PROP_HEIGHT,this.m_struct_obj.height);                         // Element height
   this.SetProperty(CANV_ELEMENT_PROP_RIGHT,this.m_struct_obj.edge_right);                      // Element right border
   this.SetProperty(CANV_ELEMENT_PROP_BOTTOM,this.m_struct_obj.edge_bottom);                    // Element bottom border
   this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_LEFT,this.m_struct_obj.act_shift_left);         // Active area offset from the left edge of the element
   this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_TOP,this.m_struct_obj.act_shift_top);           // Active area offset from the upper edge of the element
   this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_RIGHT,this.m_struct_obj.act_shift_right);       // Active area offset from the right edge of the element
   this.SetProperty(CANV_ELEMENT_PROP_ACT_SHIFT_BOTTOM,this.m_struct_obj.act_shift_bottom);     // Active area offset from the bottom edge of the element
   this.SetProperty(CANV_ELEMENT_PROP_MOVABLE,this.m_struct_obj.movable);                       // Element moveability flag
   this.SetProperty(CANV_ELEMENT_PROP_ACTIVE,this.m_struct_obj.active);                         // Element activity flag
   this.SetProperty(CANV_ELEMENT_PROP_INTERACTION,this.m_struct_obj.interaction);               // Flag of interaction with the outside environment
   this.SetProperty(CANV_ELEMENT_PROP_COORD_ACT_X,this.m_struct_obj.coord_act_x);               // X coordinate of the element active area
   this.SetProperty(CANV_ELEMENT_PROP_COORD_ACT_Y,this.m_struct_obj.coord_act_y);               // Y coordinate of the element active area
   this.SetProperty(CANV_ELEMENT_PROP_ACT_RIGHT,this.m_struct_obj.coord_act_right);             // Right border of the element active area
   this.SetProperty(CANV_ELEMENT_PROP_ACT_BOTTOM,this.m_struct_obj.coord_act_bottom);           // Bottom border of the element active area
   this.m_color_bg=this.m_struct_obj.color_bg;                                                  // Element background color
   this.m_opacity=this.m_struct_obj.opacity;                                                    // Element opacity
   this.m_zorder=this.m_struct_obj.zorder;                                                      // Priority of a graphical object for receiving the event of clicking on a chart
//--- Save real properties

//--- Save string properties
   this.SetProperty(CANV_ELEMENT_PROP_NAME_OBJ,::CharArrayToString(this.m_struct_obj.name_obj));// Graphical element object name
   this.SetProperty(CANV_ELEMENT_PROP_NAME_RES,::CharArrayToString(this.m_struct_obj.name_res));// Graphical resource name
  }
//+------------------------------------------------------------------+
//| Save the object to the file                                      |
//+------------------------------------------------------------------+
bool CGCnvElement::Save(const int file_handle)
  {
   if(!this.ObjectToStruct())
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_CREATE_OBJ_STRUCT);
      return false;
     }
   ::ResetLastError();
   if(::FileWriteArray(file_handle,this.m_uchar_array)==0)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_WRITE_UARRAY_TO_FILE,true);
      return false;
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Upload the object from the file                                  |
//+------------------------------------------------------------------+
bool CGCnvElement::Load(const int file_handle)
  {
   ::ResetLastError();
   if(::FileReadArray(file_handle,this.m_uchar_array)==0)
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_LOAD_UARRAY_FROM_FILE,true);
      return false;
     }
   if(!::CharArrayToStruct(this.m_struct_obj,this.m_uchar_array))
     {
      CMessage::ToLog(DFUN,MSG_LIB_SYS_FAILED_CREATE_OBJ_STRUCT_FROM_UARRAY,true);
      return false;
     }
   this.StructToObject();
   return true;
  }
//+------------------------------------------------------------------+
//| Create the graphical element object                              |
//+------------------------------------------------------------------+
bool CGCnvElement::Create(const long chart_id,     // Chart ID
                          const int wnd_num,       // Chart subwindow
                          const string name,       // Element name
                          const int x,             // X coordinate
                          const int y,             // Y coordinate
                          const int w,             // Width
                          const int h,             // Height
                          const color colour,      // Background color
                          const uchar opacity,     // Opacity
                          const bool redraw=false) // Flag indicating the need to redraw
                         
  {
   ::ResetLastError();
   if(this.m_canvas.CreateBitmapLabel(chart_id,wnd_num,name,x,y,w,h,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      this.Erase(CLR_CANV_NULL);
      this.m_canvas.Update(redraw);
      this.m_shift_y=(int)::ChartGetInteger(chart_id,CHART_WINDOW_YDISTANCE,wnd_num);
      return true;
     }
   CMessage::ToLog(DFUN,::GetLastError(),true);
   return false;
  }
//+------------------------------------------------------------------+
//| Return the cursor position relative to the element               |
//+------------------------------------------------------------------+
bool CGCnvElement::CursorInsideElement(const int x,const int y)
  {
   return(x>=this.CoordX() && x<=this.RightEdge() && y>=this.CoordY() && y<=this.BottomEdge());
  }
//+------------------------------------------------------------------+
//| Return the cursor position relative to the element active area   |
//+------------------------------------------------------------------+
bool CGCnvElement::CursorInsideActiveArea(const int x,const int y)
  {
   return(x>=this.ActiveAreaLeft() && x<=this.ActiveAreaRight() && y>=this.ActiveAreaTop() && y<=this.ActiveAreaBottom());
  }
//+------------------------------------------------------------------+
//| Update the coordinate elements                                   |
//+------------------------------------------------------------------+
bool CGCnvElement::Move(const int x,const int y,const bool redraw=false)
  {
//--- Leave if the element is not movable or inactive
   if(!this.Movable())
      return false;
//--- If failed to set new values into graphical object properties, return 'false'
   if(!this.SetCoordX(x) || !this.SetCoordY(y))
      return false;
   //--- If the update flag is activated, redraw the chart.
   if(redraw)
      ::ChartRedraw(this.ChartID());
   //--- Return 'true'
   return true;
  }
//+------------------------------------------------------------------+
//| Set the new X coordinate                                         |
//+------------------------------------------------------------------+
bool CGCnvElement::SetCoordX(const int coord_x)
  {
   int x=(int)::ObjectGetInteger(this.ChartID(),this.NameObj(),OBJPROP_XDISTANCE);
   if(coord_x==x)
     {
      if(coord_x==GetProperty(CANV_ELEMENT_PROP_COORD_X))
         return true;
      this.SetProperty(CANV_ELEMENT_PROP_COORD_X,coord_x);
      return true;
     }
   if(::ObjectSetInteger(this.ChartID(),this.NameObj(),OBJPROP_XDISTANCE,coord_x))
     {
      this.SetProperty(CANV_ELEMENT_PROP_COORD_X,coord_x);
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Set the new Y coordinate                                         |
//+------------------------------------------------------------------+
bool CGCnvElement::SetCoordY(const int coord_y)
  {
   int y=(int)::ObjectGetInteger(this.ChartID(),this.NameObj(),OBJPROP_YDISTANCE);
   if(coord_y==y)
     {
      if(coord_y==GetProperty(CANV_ELEMENT_PROP_COORD_Y))
         return true;
      this.SetProperty(CANV_ELEMENT_PROP_COORD_Y,coord_y);
      return true;
     }
   if(::ObjectSetInteger(this.ChartID(),this.NameObj(),OBJPROP_YDISTANCE,coord_y))
     {
      this.SetProperty(CANV_ELEMENT_PROP_COORD_Y,coord_y);
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
//| Set the new width                                                |
//+------------------------------------------------------------------+
bool CGCnvElement::SetWidth(const int width)
  {
   return this.m_canvas.Resize(width,this.m_canvas.Height());
  }
//+------------------------------------------------------------------+
//| Set the new height                                               |
//+------------------------------------------------------------------+
bool CGCnvElement::SetHeight(const int height)
  {
   return this.m_canvas.Resize(this.m_canvas.Width(),height);
  }
//+------------------------------------------------------------------+
//| Set all shifts of the active area relative to the element        |
//+------------------------------------------------------------------+
void CGCnvElement::SetActiveAreaShift(const int left_shift,const int bottom_shift,const int right_shift,const int top_shift)
  {
   this.SetActiveAreaLeftShift(left_shift);
   this.SetActiveAreaBottomShift(bottom_shift);
   this.SetActiveAreaRightShift(right_shift);
   this.SetActiveAreaTopShift(top_shift);
  }
//+------------------------------------------------------------------+
//| Set the element opacity                                          |
//+------------------------------------------------------------------+
void CGCnvElement::SetOpacity(const uchar value,const bool redraw=false)
  {
   this.m_canvas.TransparentLevelSet(value);
   this.m_opacity=value;
   this.m_canvas.Update(redraw);
  }
//+------------------------------------------------------------------+
//| Clear the element filling it with color and opacity              |
//+------------------------------------------------------------------+
void CGCnvElement::Erase(const color colour,const uchar opacity,const bool redraw=false)
  {
   this.m_canvas.Erase(::ColorToARGB(colour,opacity));
   this.Update(redraw);
  }
//+------------------------------------------------------------------+
//| Clear the element with a gradient fill                           |
//+------------------------------------------------------------------+
void CGCnvElement::Erase(color &colors[],const uchar opacity,const bool vgradient=true,const bool cycle=false,const bool redraw=false)
  {
//--- Check the size of the color array
   int size=::ArraySize(colors);
//--- If there are less than two colors in the array
   if(size<2)
     {
      //--- if the array is empty, erase the background completely and leave
      if(size==0)
        {
         this.Erase(redraw);
         return;
        }
      //--- in case of one color, fill the background with this color and opacity, and leave
      this.Erase(colors[0],opacity,redraw);
      return;
     }
//--- Declare the receiver array
   color out[];
//--- Set the gradient size depending on the filling direction (vertical/horizontal)
   int total=(vgradient ? this.Height() : this.Width());
//--- and get the set of colors in the receive array
   CColors::Gradient(colors,out,total,cycle);
   total=::ArraySize(out);
//--- In the loop by the number of colors in the array
   for(int i=0;i<total;i++)
     {
      //--- depending on the filling direction
      switch(vgradient)
        {
         //--- Horizontal gradient - draw vertical segments from left to right with the color from the array
         case false :
            DrawLineVertical(i,0,this.Height()-1,out[i],opacity);
           break;
         //--- Vertical gradient - draw horizontal segments downwards with the color from the array
         default:
            DrawLineHorizontal(0,this.Width()-1,i,out[i],opacity);
           break;
        }
     }
//--- If specified, update the canvas
   this.Update(redraw);
  }
//+------------------------------------------------------------------+
//| Clear the element completely                                     |
//+------------------------------------------------------------------+
void CGCnvElement::Erase(const bool redraw=false)
  {
   this.m_canvas.Erase(CLR_CANV_NULL);
   this.Update(redraw);
  }
//+------------------------------------------------------------------+
//| Change the ARGB color lightness by the specified amount          |
//+------------------------------------------------------------------+
uint CGCnvElement::ChangeColorLightness(const uint clr,const double change_value)
  {
   if(change_value==0.0)
      return clr;
   double a=GETRGBA(clr);
   double r=GETRGBR(clr);
   double g=GETRGBG(clr);
   double b=GETRGBB(clr);
   double h=0,s=0,l=0;
   CColors::RGBtoHSL(r,g,b,h,s,l);
   double nl=l+change_value*0.01;
   if(nl>1.0) nl=1.0;
   if(nl<0.0) nl=0.0;
   CColors::HSLtoRGB(h,s,nl,r,g,b);
   return ARGB(a,r,g,b);
  }
//+------------------------------------------------------------------+
//| Change the COLOR lightness by the specified amount               |
//+------------------------------------------------------------------+
color CGCnvElement::ChangeColorLightness(const color colour,const double change_value)
  {
   if(change_value==0.0)
      return colour;
   uint clr=::ColorToARGB(colour,0);
   double r=GETRGBR(clr);
   double g=GETRGBG(clr);
   double b=GETRGBB(clr);
   double h=0,s=0,l=0;
   CColors::RGBtoHSL(r,g,b,h,s,l);
   double nl=l+change_value*0.01;
   if(nl>1.0) nl=1.0;
   if(nl<0.0) nl=0.0;
   CColors::HSLtoRGB(h,s,nl,r,g,b);
   return CColors::RGBToColor(r,g,b);
  }
//+------------------------------------------------------------------+
//| Change the ARGB color saturation by a specified amount           |
//+------------------------------------------------------------------+
uint CGCnvElement::ChangeColorSaturation(const uint clr,const double change_value)
  {
   if(change_value==0.0)
      return clr;
   double a=GETRGBA(clr);
   double r=GETRGBR(clr);
   double g=GETRGBG(clr);
   double b=GETRGBB(clr);
   double h=0,s=0,l=0;
   CColors::RGBtoHSL(r,g,b,h,s,l);
   double ns=s+change_value*0.01;
   if(ns>1.0) ns=1.0;
   if(ns<0.0) ns=0.0;
   CColors::HSLtoRGB(h,ns,l,r,g,b);
   return ARGB(a,r,g,b);
  }
//+------------------------------------------------------------------+
//| Change the COLOR saturation by a specified amount                |
//+------------------------------------------------------------------+
color CGCnvElement::ChangeColorSaturation(const color colour,const double change_value)
  {
   if(change_value==0.0)
      return colour;
   uint clr=::ColorToARGB(colour,0);
   double r=GETRGBR(clr);
   double g=GETRGBG(clr);
   double b=GETRGBB(clr);
   double h=0,s=0,l=0;
   CColors::RGBtoHSL(r,g,b,h,s,l);
   double ns=s+change_value*0.01;
   if(ns>1.0) ns=1.0;
   if(ns<0.0) ns=0.0;
   CColors::HSLtoRGB(h,ns,l,r,g,b);
   return CColors::RGBToColor(r,g,b);
  }
//+------------------------------------------------------------------+
//| Save the image to the array                                      |
//+------------------------------------------------------------------+
bool CGCnvElement::ImageCopy(const string source,uint &array[])
  {
   ::ResetLastError();
   int w=0,h=0;
   // if(!::ResourceReadImage(this.NameRes(),array,w,h))
   //   {
   //    CMessage::ToLog(source,MSG_LIB_SYS_FAILED_GET_DATA_GRAPH_RES,true);
   //    return false;
   //   }
   return false;
  }
//+------------------------------------------------------------------+
//| Save the graphical resource to the array                         |
//+------------------------------------------------------------------+
bool CGCnvElement::ResourceStamp(const string source)
  {
   return this.ImageCopy(DFUN,this.m_duplicate_res);
  }
//+------------------------------------------------------------------+
//| Restore the graphical resource from the array                    |
//+------------------------------------------------------------------+
bool CGCnvElement::Reset(void)
  {
//--- Get the size of the graphical resource copy array
   int size=::ArraySize(this.m_duplicate_res);
//--- If the array is empty, inform of that and return 'false'
   if(size==0)
     {
      CMessage::ToLog(DFUN,MSG_CANV_ELEMENT_ERR_EMPTY_ARRAY);
      return false;
     }
//--- If the size of the graphical resource copy array does not match the size of the graphical resource,
//--- inform of that in the journal and return 'false'
   if(this.m_canvas.Width()*this.m_canvas.Height()!=size)
     {
      CMessage::ToLog(DFUN,MSG_CANV_ELEMENT_ERR_ARRAYS_NOT_MATCH);
      return false;
     }
//--- Set the index of the array for setting the image pixel
   int n=0;
//--- In the loop by the resource height,
   for(int y=0;y<this.m_canvas.Height();y++)
     {
      //--- in the loop by the resource width
      for(int x=0;x<this.m_canvas.Width();x++)
        {
         //--- Restore the next image pixel from the array and increase the array index
         this.m_canvas.PixelSet(x,y,this.m_duplicate_res[n]);
         n++;
        }
     }
//--- Update the data on the canvas and return 'true'
   this.m_canvas.Update(false);
   return true;
  }
//+------------------------------------------------------------------+
//| Return coordinate offsets relative to the rectangle anchor point |
//| by size                                                          |
//+------------------------------------------------------------------+
void CGCnvElement::GetShiftXYbySize(const int width,const int height,const ENUM_FRAME_ANCHOR anchor,int &shift_x,int &shift_y)
  {
   switch(anchor)
     {
      case FRAME_ANCHOR_LEFT_TOP       :  shift_x=0;        shift_y=0;           break;
      case FRAME_ANCHOR_LEFT_CENTER    :  shift_x=0;        shift_y=-height/2;   break;
      case FRAME_ANCHOR_LEFT_BOTTOM    :  shift_x=0;        shift_y=-height;     break;
      case FRAME_ANCHOR_CENTER_TOP     :  shift_x=-width/2; shift_y=0;           break;
      case FRAME_ANCHOR_CENTER         :  shift_x=-width/2; shift_y=-height/2;   break;
      case FRAME_ANCHOR_CENTER_BOTTOM  :  shift_x=-width/2; shift_y=-height;     break;
      case FRAME_ANCHOR_RIGHT_TOP      :  shift_x=-width;   shift_y=0;           break;
      case FRAME_ANCHOR_RIGHT_CENTER   :  shift_x=-width;   shift_y=-height/2;   break;
      case FRAME_ANCHOR_RIGHT_BOTTOM   :  shift_x=-width;   shift_y=-height;     break;
      default                          :  shift_x=0;        shift_y=0;           break;
     }
  }
//+------------------------------------------------------------------+
//| Return coordinate offsets relative to the text anchor point      |
//+------------------------------------------------------------------+
void CGCnvElement::GetShiftXYbyText(const string text,const ENUM_FRAME_ANCHOR anchor,int &shift_x,int &shift_y)
  {
   int tw=0,th=0;
   this.TextSize(text,tw,th);
   this.GetShiftXYbySize(tw,th,anchor,shift_x,shift_y);
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CGCnvElement::OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- In case of a chart change event, recalculate the shift by Y for the subwindow
   if(id==CHARTEVENT_CHART_CHANGE)
     {
      this.m_shift_y=(int)::ChartGetInteger(this.ChartID(),CHART_WINDOW_YDISTANCE,this.WindowNum());
     }
  }
//+------------------------------------------------------------------+
