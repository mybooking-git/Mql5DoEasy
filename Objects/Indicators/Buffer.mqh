//+------------------------------------------------------------------+
//|                                                       Buffer.mqh |
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
#include "..\..\Services\Select.mqh"
#include "..\..\Objects\BaseObj.mqh"
//+------------------------------------------------------------------+
//| Abstract indicator buffer class                                  |
//+------------------------------------------------------------------+
class CBuffer : public CBaseObj
  {
private:
   long              m_long_prop[BUFFER_PROP_INTEGER_TOTAL];                     // Integer properties
   double            m_double_prop[BUFFER_PROP_DOUBLE_TOTAL];                    // Real properties
   string            m_string_prop[BUFFER_PROP_STRING_TOTAL];                    // String properties
   bool              m_act_state_trigger;                                        // Auxiliary buffer status switch flag
   uchar             m_total_arrays;                                             // Total number of buffer arrays
//--- Return the index of the array the buffer's (1) double and (2) string properties are actually located at
   int               IndexProp(ENUM_BUFFER_PROP_DOUBLE property)           const { return(int)property-BUFFER_PROP_INTEGER_TOTAL;                           }
   int               IndexProp(ENUM_BUFFER_PROP_STRING property)           const { return(int)property-BUFFER_PROP_INTEGER_TOTAL-BUFFER_PROP_DOUBLE_TOTAL;  }
//--- Set the graphical construction type by buffer type and status
   void              SetDrawType(void);
//--- Return the adjusted buffer array index
   int               GetCorrectIndexBuffer(const uint buffer_index) const;

protected:
   struct SDataBuffer { double Array[]; };                                       // Structure for storing buffer object buffer arrays
   SDataBuffer       DataBuffer[];                                               // Array of all object indicator buffers
   double            ColorBufferArray[];                                         // Color buffer array
   int               ArrayColors[];                                              // Array for storing colors
public:
//--- Set buffer's (1) integer, (2) real and (3) string property
   void              SetProperty(ENUM_BUFFER_PROP_INTEGER property,long value)   { this.m_long_prop[property]=value;                                        }
   void              SetProperty(ENUM_BUFFER_PROP_DOUBLE property,double value)  { this.m_double_prop[this.IndexProp(property)]=value;                      }
   void              SetProperty(ENUM_BUFFER_PROP_STRING property,string value)  { this.m_string_prop[this.IndexProp(property)]=value;                      }
//--- Return buffer’s (1) integer, (2) real and (3) string property from the properties array
   long              GetProperty(ENUM_BUFFER_PROP_INTEGER property)        const { return this.m_long_prop[property];                                       }
   double            GetProperty(ENUM_BUFFER_PROP_DOUBLE property)         const { return this.m_double_prop[this.IndexProp(property)];                     }
   string            GetProperty(ENUM_BUFFER_PROP_STRING property)         const { return this.m_string_prop[this.IndexProp(property)];                     }
//--- Return description of buffer's (1) integer, (2) real and (3) string property
   string            GetPropertyDescription(ENUM_BUFFER_PROP_INTEGER property);
   string            GetPropertyDescription(ENUM_BUFFER_PROP_DOUBLE property);
   string            GetPropertyDescription(ENUM_BUFFER_PROP_STRING property);
//--- Return the flag of the buffer supporting the property
   virtual bool      SupportProperty(ENUM_BUFFER_PROP_INTEGER property)          { return true;       }
   virtual bool      SupportProperty(ENUM_BUFFER_PROP_DOUBLE property)           { return true;       }
   virtual bool      SupportProperty(ENUM_BUFFER_PROP_STRING property)           { return true;       }

//--- Compare CBuffer objects by all possible properties (for sorting the lists by a specified buffer object property)
   virtual int       Compare(const CObject *node,const int mode=0) const;
//--- Compare CBuffer objects by all properties (to search for equal buffer objects)
   bool              IsEqual(CBuffer* compared_obj) const;
                     
//--- Set the buffer name
   void              SetName(const string name)                                  { this.m_name=name;  }
//--- (1) Set and (2) return the buffer status switch flag
   void              SetActStateFlag(const bool flag)                            { this.m_act_state_trigger=flag;    }
   bool              GetActStateFlag(void)                                 const { return this.m_act_state_trigger;  }
   
//--- Default constructor
                     CBuffer(void){ this.m_type=OBJECT_DE_TYPE_IND_BUFFER; }
protected:
//--- Protected parametric constructor
                     CBuffer(ENUM_BUFFER_STATUS status_buffer,
                             ENUM_BUFFER_TYPE buffer_type,
                             const uint index_plot,
                             const uint index_base_array,
                             const int num_datas,
                             const uchar total_arrays,
                             const int width,
                             const string label);
public:  
//--- Display the description of the object properties in the journal (full_prop=true - all properties, false - supported ones only - implemented in descendant classes)
   virtual void      Print(const bool full_prop=false,const bool dash=false);
//--- Display a short description of the object in the journal
   virtual void      PrintShort(const bool dash=false,const bool symbol=false);
   
//--- Set (1) the arrow code, (2) vertical shift of arrows, (3) symbol, (4) timeframe, (5) buffer activity flag
//--- (6) drawing type, (7) number of initial bars without drawing, (8) flag of displaying construction values in DataWindow,
//--- (9) shift of the indicator graphical construction along the time axis, (10) line style, (11) line width,
//--- (12) total number of colors, (13) one drawing color, (14) color of drawing in the specified color index,
//--- (15) drawing colors from the color array, (16) empty value, (17) name of the graphical series displayed in DataWindow
   virtual void      SetArrowCode(const uchar code)                  { return;                                                               }
   virtual void      SetArrowShift(const int shift)                  { return;                                                               }
   void              SetSymbol(const string symbol)                  { this.SetProperty(BUFFER_PROP_SYMBOL,symbol);                          }
   void              SetTimeframe(const ENUM_TIMEFRAMES timeframe)   { this.SetProperty(BUFFER_PROP_TIMEFRAME,timeframe);                    }
   void              SetActive(const bool flag)                      { this.SetProperty(BUFFER_PROP_ACTIVE,flag);                            }
   void              SetDrawType(const ENUM_DRAW_TYPE draw_type);
   void              SetDrawBegin(const int value);
   void              SetShowData(const bool flag);
   void              SetShift(const int shift);
   void              SetStyle(const ENUM_LINE_STYLE style);
   void              SetWidth(const int width);
   void              SetColorNumbers(const int number);
   void              SetColor(const color colour);
   void              SetColor(const color colour,const uchar index);
   void              SetColors(const color &array_colors[]);
   void              SetEmptyValue(const double value);
   virtual void      SetLabel(const string label);
   void              SetID(const int id)                             { this.SetProperty(BUFFER_PROP_ID,id);                                  }
   void              SetIndicatorHandle(const int handle)            { this.SetProperty(BUFFER_PROP_IND_HANDLE,handle);                      }
   void              SetIndicatorType(const ENUM_INDICATOR type)     { this.SetProperty(BUFFER_PROP_IND_TYPE,type);                          }
   void              SetIndicatorName(const string name)             { this.SetProperty(BUFFER_PROP_IND_NAME,name);                          }
   void              SetIndicatorShortName(const string name)        { this.SetProperty(BUFFER_PROP_IND_NAME_SHORT,name);                    }
   void              SetLineMode(const ENUM_INDICATOR_LINE_MODE mode){ this.SetProperty(BUFFER_PROP_IND_LINE_MODE,mode);                     }
   void              SetIndicatorLineAdditionalNumber(const int number){this.SetProperty(BUFFER_PROP_IND_LINE_ADDITIONAL_NUM,number);        }
   
//--- Return (1) the serial number of the drawn buffer, (2) bound array index, (3) color buffer index,
//--- (4) index of the first free bound array, (5) index of the next drawn buffer, (6) buffer data period, (7) buffer status,
//--- (8) buffer type, (9) buffer usage flag, (10) arrow code, (11) arrow shift for DRAW_ARROW style,
//--- (12) number of initial bars that are not drawn and values in DataWindow, (13) graphical construction type,
//--- (14) flag of displaying construction values in DataWindow, (15) indicator graphical construction shift along the time axis,
//--- (16) drawing line style, (17) drawing line width, (18) number of colors, (19) drawing color, (20) number of buffers for construction
//--- (21) set empty value, (22) buffer symbol, (23) name of the indicator graphical series displayed in DataWindow
//--- (24) buffer ID, (25) indicator handle, (26) standard indicator type, (27) standard indicator name,
//--- (28) additional indicator line index, (29) line type (main, signal, etc), (30) number of calculated bars of the standard indicator
   int               IndexPlot(void)                           const { return (int)this.GetProperty(BUFFER_PROP_INDEX_PLOT);                 }
   int               IndexBase(void)                           const { return (int)this.GetProperty(BUFFER_PROP_INDEX_BASE);                 }
   int               IndexColor(void)                          const { return (int)this.GetProperty(BUFFER_PROP_INDEX_COLOR);                }
   int               IndexNextBaseBuffer(void)                 const { return (int)this.GetProperty(BUFFER_PROP_INDEX_NEXT_BASE);            }
   int               IndexNextPlotBuffer(void)                 const { return (int)this.GetProperty(BUFFER_PROP_INDEX_NEXT_PLOT);            }
   ENUM_TIMEFRAMES   Timeframe(void)                           const { return (ENUM_TIMEFRAMES)this.GetProperty(BUFFER_PROP_TIMEFRAME);      }
   ENUM_BUFFER_STATUS Status(void)                             const { return (ENUM_BUFFER_STATUS)this.GetProperty(BUFFER_PROP_STATUS);      }
   ENUM_BUFFER_TYPE  TypeBuffer(void)                          const { return (ENUM_BUFFER_TYPE)this.GetProperty(BUFFER_PROP_TYPE);          }
   bool              IsActive(void)                            const { return (bool)this.GetProperty(BUFFER_PROP_ACTIVE);                    }
   uchar             ArrowCode(void)                           const { return (uchar)this.GetProperty(BUFFER_PROP_ARROW_CODE);               }
   int               ArrowShift(void)                          const { return (int)this.GetProperty(BUFFER_PROP_ARROW_SHIFT);                }
   int               DrawBegin(void)                           const { return (int)this.GetProperty(BUFFER_PROP_DRAW_BEGIN);                 }
   ENUM_DRAW_TYPE    DrawType(void)                            const { return (ENUM_DRAW_TYPE)this.GetProperty(BUFFER_PROP_DRAW_TYPE);       }
   bool              IsShowData(void)                          const { return (bool)this.GetProperty(BUFFER_PROP_SHOW_DATA);                 }
   int               Shift(void)                               const { return (int)this.GetProperty(BUFFER_PROP_SHIFT);                      }
   ENUM_LINE_STYLE   LineStyle(void)                           const { return (ENUM_LINE_STYLE)this.GetProperty(BUFFER_PROP_LINE_STYLE);     }
   int               LineWidth(void)                           const { return (int)this.GetProperty(BUFFER_PROP_LINE_WIDTH);                 }
   int               ColorsTotal(void)                         const { return (int)this.GetProperty(BUFFER_PROP_COLOR_INDEXES);              }
   color             Color(void)                               const { return (color)this.GetProperty(BUFFER_PROP_COLOR);                    }
   int               BuffersTotal(void)                        const { return (int)this.GetProperty(BUFFER_PROP_NUM_DATAS);                  }
   double            EmptyValue(void)                          const { return this.GetProperty(BUFFER_PROP_EMPTY_VALUE);                     }
   string            Symbol(void)                              const { return this.GetProperty(BUFFER_PROP_SYMBOL);                          }
   string            Label(void)                               const { return this.GetProperty(BUFFER_PROP_LABEL);                           }
   int               ID(void)                                  const { return (int)this.GetProperty(BUFFER_PROP_ID);                         }
   int               IndicatorHandle(void)                     const { return (int)this.GetProperty(BUFFER_PROP_IND_HANDLE);                 }
   ENUM_INDICATOR    IndicatorType(void)                       const { return (ENUM_INDICATOR)this.GetProperty(BUFFER_PROP_IND_TYPE);        }
   string            IndicatorName(void)                       const { return this.GetProperty(BUFFER_PROP_IND_NAME);                        }
   string            IndicatorShortName(void)                  const { return this.GetProperty(BUFFER_PROP_IND_NAME_SHORT);                  }
   int               IndicatorLineAdditionalNumber(void)       const { return (int)this.GetProperty(BUFFER_PROP_IND_LINE_ADDITIONAL_NUM);    }
   int               IndicatorLineMode(void)                   const { return (int)this.GetProperty(BUFFER_PROP_IND_LINE_MODE);              }
   int               IndicatorBarsCalculated(void);
   
//--- Return descriptions of the (1) buffer status, (2) buffer type, (3) buffer usage flag, (4) flag of displaying construction values in DataWindow,
//--- (5) drawing line style, (6) set empty value, (7) graphical construction type and (8) used timeframe and (9) specified colors
   string            GetStatusDescription(bool draw_type=false)const;
   string            GetTypeBufferDescription(void)            const;
   string            GetActiveDescription(void)                const;
   string            GetShowDataDescription(void)              const;
   string            GetLineStyleDescription(void)             const;
   string            GetEmptyValueDescription(void)            const;
   string            GetDrawTypeDescription(void)              const;
   string            GetTimeframeDescription(void)             const;
   string            GetColorsDescription(void)                const;
   string            GetIndicatorLineModeDescription(void)     const;
   
//--- Return the size of the data buffer array
   virtual int       GetDataTotal(const uint buffer_index=0)   const;
//--- Return the value from the specified index of the specified (1) data, (2) color index and (3) color buffer arrays
   double            GetDataBufferValue(const uint buffer_index,const int series_index) const;
   int               GetColorBufferValueIndex(const int series_index) const;
   color             GetColorBufferValueColor(const int series_index) const;
//--- Set the value to the specified index of the specified (1) data and (2) color buffer arrays
   void              SetBufferValue(const uint buffer_index,const uint series_index,const double value);
   void              SetBufferColorIndex(const uint series_index,const uchar color_index);
//--- Initialize all object buffers by (1) a specified value, (2) the empty value specified for the object
   void              InitializeAll(const double value,const uchar color_index);
   void              InitializeAll(void);
//--- Fill all data buffers with empty values in the specified timeseries index
   void              ClearData(const int series_index);
//--- Fill the specified buffer with data from the passed array
   void              FillAsSeries(const int buffer_index,const double &array[]);

  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Closed parametric constructor                                    |
//+------------------------------------------------------------------+
CBuffer::CBuffer(ENUM_BUFFER_STATUS buffer_status,
                 ENUM_BUFFER_TYPE buffer_type,
                 const uint index_plot,
                 const uint index_base_array,
                 const int num_datas,
                 const uchar total_arrays,
                 const int width,
                 const string label)
  {
//--- Set the object type
   this.m_type=OBJECT_DE_TYPE_IND_BUFFER;
#ifdef __MQL5__
   this.m_act_state_trigger=true;
   this.m_total_arrays=total_arrays;
//--- Save integer properties
   this.m_long_prop[BUFFER_PROP_STATUS]                        = buffer_status;
   this.m_long_prop[BUFFER_PROP_TYPE]                          = buffer_type;
   this.m_long_prop[BUFFER_PROP_ID]                            = WRONG_VALUE;
   this.m_long_prop[BUFFER_PROP_IND_LINE_MODE]                 = INDICATOR_LINE_MODE_MAIN;
   this.m_long_prop[BUFFER_PROP_IND_HANDLE]                    = INVALID_HANDLE;
   this.m_long_prop[BUFFER_PROP_IND_TYPE]                      = WRONG_VALUE;
   this.m_long_prop[BUFFER_PROP_IND_LINE_ADDITIONAL_NUM]       = WRONG_VALUE;
   ENUM_DRAW_TYPE type=
     (
      !this.TypeBuffer() || !this.Status() ? DRAW_NONE      : 
      this.Status()==BUFFER_STATUS_FILLING ? DRAW_FILLING   : 
      ENUM_DRAW_TYPE(this.Status()+8)
     );
   this.m_long_prop[BUFFER_PROP_DRAW_TYPE]                     = type;
   this.m_long_prop[BUFFER_PROP_TIMEFRAME]                     = PERIOD_CURRENT;
   this.m_long_prop[BUFFER_PROP_ACTIVE]                        = true;
   this.m_long_prop[BUFFER_PROP_ARROW_CODE]                    = 0x9F;
   this.m_long_prop[BUFFER_PROP_ARROW_SHIFT]                   = 0;
   this.m_long_prop[BUFFER_PROP_DRAW_BEGIN]                    = 0;
   this.m_long_prop[BUFFER_PROP_SHOW_DATA]                     = (buffer_type>BUFFER_TYPE_CALCULATE ? true : false);
   this.m_long_prop[BUFFER_PROP_SHIFT]                         = 0;
   this.m_long_prop[BUFFER_PROP_LINE_STYLE]                    = STYLE_SOLID;
   this.m_long_prop[BUFFER_PROP_LINE_WIDTH]                    = width;
   this.m_long_prop[BUFFER_PROP_COLOR_INDEXES]                 = (this.Status()>BUFFER_STATUS_NONE ? (this.Status()!=BUFFER_STATUS_FILLING ? 1 : 2) : 0);
   this.m_long_prop[BUFFER_PROP_COLOR]                         = clrRed;
   this.m_long_prop[BUFFER_PROP_NUM_DATAS]                     = num_datas;
   this.m_long_prop[BUFFER_PROP_INDEX_PLOT]                    = index_plot;
   this.m_long_prop[BUFFER_PROP_INDEX_BASE]                    = index_base_array;
   this.m_long_prop[BUFFER_PROP_INDEX_COLOR]                   = this.GetProperty(BUFFER_PROP_INDEX_BASE)+
                                                                   (this.TypeBuffer()!=BUFFER_TYPE_CALCULATE ? this.GetProperty(BUFFER_PROP_NUM_DATAS) : 0);
   this.m_long_prop[BUFFER_PROP_INDEX_NEXT_BASE]               = index_base_array+this.m_total_arrays;
   this.m_long_prop[BUFFER_PROP_INDEX_NEXT_PLOT]               = (this.TypeBuffer()>BUFFER_TYPE_CALCULATE ? index_plot+1 : index_plot);
   
//--- Save real properties
   this.m_double_prop[this.IndexProp(BUFFER_PROP_EMPTY_VALUE)] = (this.TypeBuffer()>BUFFER_TYPE_CALCULATE ? EMPTY_VALUE : 0);
//--- Save string properties
   this.m_string_prop[this.IndexProp(BUFFER_PROP_SYMBOL)]      = ::Symbol();
   this.m_string_prop[this.IndexProp(BUFFER_PROP_LABEL)]       = (this.TypeBuffer()>BUFFER_TYPE_CALCULATE ? label : NULL);
   this.m_string_prop[this.IndexProp(BUFFER_PROP_IND_NAME)]    = NULL;
   this.m_string_prop[this.IndexProp(BUFFER_PROP_IND_NAME_SHORT)]=NULL;

//--- If failed to change the size of the indicator buffer array, display the appropriate message indicating the string
   if(::ArrayResize(this.DataBuffer,(int)this.GetProperty(BUFFER_PROP_NUM_DATAS))==WRONG_VALUE)
      ::Print(DFUN_ERR_LINE,CMessage::Text(MSG_LIB_SYS_FAILED_DRAWING_ARRAY_RESIZE),". ",CMessage::Text(MSG_LIB_SYS_ERROR),": ",(string)::GetLastError());
      
//--- If failed to change the size of the color array (only for a non-calculated buffer), display the appropriate message indicating the string
   if(this.TypeBuffer()>BUFFER_TYPE_CALCULATE)
      if(::ArrayResize(this.ArrayColors,(int)this.ColorsTotal())==WRONG_VALUE)
         ::Print(DFUN_ERR_LINE,CMessage::Text(MSG_LIB_SYS_FAILED_COLORS_ARRAY_RESIZE),". ",CMessage::Text(MSG_LIB_SYS_ERROR),": ",(string)::GetLastError());

//--- For DRAW_FILLING, fill in the color array with two default colors
   if(this.Status()==BUFFER_STATUS_FILLING)
     {
      this.SetColor(clrBlue,0);
      this.SetColor(clrRed,1);
     }

//--- Bind indicator buffers with arrays
//--- In a loop by the number of indicator buffers
   int total=::ArraySize(DataBuffer);
   for(int i=0;i<total;i++)
     {
      //--- calculate the index of the next array and
      //--- bind the indicator buffer by the calculated index with the dynamic array
      //--- located by the i loop index in the DataBuffer array
      int index=(int)this.GetProperty(BUFFER_PROP_INDEX_BASE)+i;
      ::SetIndexBuffer(index,this.DataBuffer[i].Array,(this.TypeBuffer()==BUFFER_TYPE_DATA ? INDICATOR_DATA : INDICATOR_CALCULATIONS));
      //--- Set indexation flag as in the timeseries to all buffer arrays
      ::ArraySetAsSeries(this.DataBuffer[i].Array,true);
     }
//--- Bind the color buffer with the array (only for a non-calculated buffer and not for the filling buffer)
   if(this.Status()!=BUFFER_STATUS_FILLING && this.TypeBuffer()!=BUFFER_TYPE_CALCULATE)
     {
      ::SetIndexBuffer((int)this.GetProperty(BUFFER_PROP_INDEX_COLOR),this.ColorBufferArray,INDICATOR_COLOR_INDEX);
      ::ArraySetAsSeries(this.ColorBufferArray,true);
     }
//--- Done if this is a calculated buffer
   if(this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
//--- Set integer parameters of the graphical series
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_DRAW_TYPE,(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_DRAW_TYPE));
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_ARROW,(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_ARROW_CODE));
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_ARROW_SHIFT,(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_ARROW_SHIFT));
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_DRAW_BEGIN,(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_DRAW_BEGIN));
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_SHOW_DATA,(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_SHOW_DATA));
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_SHIFT,(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_SHIFT));
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_LINE_STYLE,(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_LINE_STYLE));
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_LINE_WIDTH,(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_LINE_WIDTH));
   this.SetColor((color)this.GetProperty(BUFFER_PROP_COLOR));
//--- Set real parameters of the graphical series
   ::PlotIndexSetDouble((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_EMPTY_VALUE,this.GetProperty(BUFFER_PROP_EMPTY_VALUE));
//--- Set string parameters of the graphical series
   ::PlotIndexSetString((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_LABEL,this.GetProperty(BUFFER_PROP_LABEL));

//--- MQL4
#else 
   this.m_act_state_trigger=true;
   this.m_total_arrays=1;
//--- Save integer properties
   this.m_long_prop[BUFFER_PROP_STATUS]                        = buffer_status;
   this.m_long_prop[BUFFER_PROP_TYPE]                          = buffer_type;
   this.m_long_prop[BUFFER_PROP_ID]                            = WRONG_VALUE;
   this.m_long_prop[BUFFER_PROP_IND_LINE_MODE]                 = INDICATOR_LINE_MODE_MAIN;
   this.m_long_prop[BUFFER_PROP_IND_HANDLE]                    = INVALID_HANDLE;
   this.m_long_prop[BUFFER_PROP_IND_TYPE]                      = WRONG_VALUE;
   this.m_long_prop[BUFFER_PROP_IND_LINE_ADDITIONAL_NUM]       = WRONG_VALUE;
   
   ENUM_DRAW_TYPE type=DRAW_COLOR_NONE;
   switch((int)this.Status())
     {
      case BUFFER_STATUS_LINE       :  type=DRAW_COLOR_LINE;      break;
      case BUFFER_STATUS_HISTOGRAM  :  type=DRAW_COLOR_HISTOGRAM; break;
      case BUFFER_STATUS_ARROW      :  type=DRAW_COLOR_ARROW;     break;
      case BUFFER_STATUS_SECTION    :  type=DRAW_COLOR_SECTION;   break;
      case BUFFER_STATUS_ZIGZAG     :  type=DRAW_COLOR_ZIGZAG;    break;
      case BUFFER_STATUS_NONE       :  type=DRAW_COLOR_NONE;      break;
      case BUFFER_STATUS_FILLING    :  type=DRAW_COLOR_NONE;      break;
      case BUFFER_STATUS_HISTOGRAM2 :  type=DRAW_COLOR_NONE;      break;
      case BUFFER_STATUS_BARS       :  type=DRAW_COLOR_NONE;      break;
      case BUFFER_STATUS_CANDLES    :  type=DRAW_COLOR_NONE;      break;
      default                       :  type=DRAW_COLOR_NONE;      break;
     }
   this.m_long_prop[BUFFER_PROP_DRAW_TYPE]                     = type;
   this.m_long_prop[BUFFER_PROP_TIMEFRAME]                     = PERIOD_CURRENT;
   this.m_long_prop[BUFFER_PROP_ACTIVE]                        = true;
   this.m_long_prop[BUFFER_PROP_ARROW_CODE]                    = 0x9F;
   this.m_long_prop[BUFFER_PROP_ARROW_SHIFT]                   = 0;
   this.m_long_prop[BUFFER_PROP_DRAW_BEGIN]                    = 0;
   this.m_long_prop[BUFFER_PROP_SHOW_DATA]                     = (buffer_type>BUFFER_TYPE_CALCULATE ? true : false);
   this.m_long_prop[BUFFER_PROP_SHIFT]                         = 0;
   this.m_long_prop[BUFFER_PROP_LINE_STYLE]                    = STYLE_SOLID;
   this.m_long_prop[BUFFER_PROP_LINE_WIDTH]                    = width;
   this.m_long_prop[BUFFER_PROP_COLOR_INDEXES]                 = (this.Status()>BUFFER_STATUS_NONE ? (this.Status()!=BUFFER_STATUS_FILLING ? 1 : 2) : 0);
   this.m_long_prop[BUFFER_PROP_COLOR]                         = clrRed;
   this.m_long_prop[BUFFER_PROP_NUM_DATAS]                     = num_datas;
   this.m_long_prop[BUFFER_PROP_INDEX_PLOT]                    = index_plot;
   this.m_long_prop[BUFFER_PROP_INDEX_BASE]                    = index_base_array;
   this.m_long_prop[BUFFER_PROP_INDEX_COLOR]                   = this.GetProperty(BUFFER_PROP_INDEX_BASE);
   this.m_long_prop[BUFFER_PROP_INDEX_NEXT_BASE]               = index_base_array+this.m_total_arrays;
   this.m_long_prop[BUFFER_PROP_INDEX_NEXT_PLOT]               = (this.TypeBuffer()>BUFFER_TYPE_CALCULATE ? index_plot+1 : index_plot);
   
//--- Save real properties
   this.m_double_prop[this.IndexProp(BUFFER_PROP_EMPTY_VALUE)] = (this.TypeBuffer()>BUFFER_TYPE_CALCULATE ? EMPTY_VALUE : 0);
//--- Save string properties
   this.m_string_prop[this.IndexProp(BUFFER_PROP_SYMBOL)]      = ::Symbol();
   this.m_string_prop[this.IndexProp(BUFFER_PROP_LABEL)]       = (this.TypeBuffer()>BUFFER_TYPE_CALCULATE ? label : NULL);
   this.m_string_prop[this.IndexProp(BUFFER_PROP_IND_NAME)]    = NULL;
   this.m_string_prop[this.IndexProp(BUFFER_PROP_IND_NAME_SHORT)]=NULL;

//--- If failed to change the size of the indicator buffer array, display the appropriate message indicating the string
   if(::ArrayResize(this.DataBuffer,(int)this.GetProperty(BUFFER_PROP_NUM_DATAS))==WRONG_VALUE)
      ::Print(DFUN_ERR_LINE,CMessage::Text(MSG_LIB_SYS_FAILED_DRAWING_ARRAY_RESIZE),". ",CMessage::Text(MSG_LIB_SYS_ERROR),": ",(string)::GetLastError());
      
//--- Bind indicator buffers with arrays
//--- In a loop by the number of indicator buffers
   int total=::ArraySize(DataBuffer);
   for(int i=0;i<total;i++)
     {
      //--- calculate the index of the next array and
      //--- bind the indicator buffer by the calculated index with the dynamic array
      //--- located by the i loop index in the DataBuffer array
      int index=(int)this.GetProperty(BUFFER_PROP_INDEX_BASE)+i;
      ::SetIndexBuffer(index,this.DataBuffer[i].Array,(this.TypeBuffer()==BUFFER_TYPE_DATA ? INDICATOR_DATA : INDICATOR_CALCULATIONS));
      //--- Set indexation flag as in the timeseries to all buffer arrays
      ::ArraySetAsSeries(this.DataBuffer[i].Array,true);
     }

//--- Done if this is a calculated buffer
   if(this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
//--- Set integer parameters of the graphical series
   this.SetDrawType(type);
   ::SetIndexStyle((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),
                   (ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_DRAW_TYPE),
                   (ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_LINE_STYLE),
                   (ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_LINE_WIDTH),
                   (ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_COLOR));
   ::SetIndexArrow((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_ARROW_CODE));
   ::SetIndexShift((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_ARROW_SHIFT));
   ::SetIndexDrawBegin((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_DRAW_BEGIN));
   ::SetIndexShift((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_SHIFT));
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_SHOW_DATA,(ENUM_PLOT_PROPERTY_INTEGER)this.GetProperty(BUFFER_PROP_SHOW_DATA));
   
//--- Set real parameters of the graphical series
   ::SetIndexEmptyValue((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),this.GetProperty(BUFFER_PROP_EMPTY_VALUE));
   
//--- Set string parameters of the graphical series
   ::SetIndexLabel((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),this.GetProperty(BUFFER_PROP_LABEL));
   
#endif 
  }
//+------------------------------------------------------------------+
//| Class methods                                                    |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Compare CBuffer objects by all possible properties               |
//+------------------------------------------------------------------+
int CBuffer::Compare(const CObject *node,const int mode=0) const
  {
   const CBuffer *compared_obj=node;
//--- compare integer properties of two buffers
   if(mode<BUFFER_PROP_INTEGER_TOTAL)
     {
      long value_compared=compared_obj.GetProperty((ENUM_BUFFER_PROP_INTEGER)mode);
      long value_current=this.GetProperty((ENUM_BUFFER_PROP_INTEGER)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare real properties of two buffers
   else if(mode<BUFFER_PROP_INTEGER_TOTAL+BUFFER_PROP_DOUBLE_TOTAL)
     {
      double value_compared=compared_obj.GetProperty((ENUM_BUFFER_PROP_DOUBLE)mode);
      double value_current=this.GetProperty((ENUM_BUFFER_PROP_DOUBLE)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
//--- compare string properties of two buffers
   else if(mode<BUFFER_PROP_INTEGER_TOTAL+BUFFER_PROP_DOUBLE_TOTAL+BUFFER_PROP_STRING_TOTAL)
     {
      string value_compared=compared_obj.GetProperty((ENUM_BUFFER_PROP_STRING)mode);
      string value_current=this.GetProperty((ENUM_BUFFER_PROP_STRING)mode);
      return(value_current>value_compared ? 1 : value_current<value_compared ? -1 : 0);
     }
   return 0;
  }
//+------------------------------------------------------------------+
//| Compare CBuffer objects by all properties                        |
//+------------------------------------------------------------------+
bool CBuffer::IsEqual(CBuffer *compared_obj) const
  {
   int begin=0, end=BUFFER_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BUFFER_PROP_INTEGER prop=(ENUM_BUFFER_PROP_INTEGER)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=BUFFER_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BUFFER_PROP_DOUBLE prop=(ENUM_BUFFER_PROP_DOUBLE)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   begin=end; end+=BUFFER_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BUFFER_PROP_STRING prop=(ENUM_BUFFER_PROP_STRING)i;
      if(this.GetProperty(prop)!=compared_obj.GetProperty(prop)) return false; 
     }
   return true;
  }
//+------------------------------------------------------------------+
//| Display buffer properties in the journal                         |
//+------------------------------------------------------------------+
void CBuffer::Print(const bool full_prop=false,const bool dash=false)
  {
   string bktl=(this.TypeBuffer()>BUFFER_TYPE_CALCULATE ? "(" : "[");
   string bktr=(this.TypeBuffer()>BUFFER_TYPE_CALCULATE ? ")" : "]");
   string dscr=(this.TypeBuffer()>BUFFER_TYPE_CALCULATE ? " \""+this.GetStatusDescription(true)+"\"" : "");
   ::Print("============= ",
           CMessage::Text(MSG_LIB_PARAMS_LIST_BEG),": ",
           this.GetTypeBufferDescription(),bktl,string(this.Status()>BUFFER_STATUS_NONE ? this.IndexPlot() : this.IndexBase()),bktr,dscr,
           " =================="
          );
   int begin=0, end=BUFFER_PROP_INTEGER_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BUFFER_PROP_INTEGER prop=(ENUM_BUFFER_PROP_INTEGER)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   if(this.Status()>BUFFER_STATUS_NONE)
      ::Print("------");
   begin=end; end+=BUFFER_PROP_DOUBLE_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BUFFER_PROP_DOUBLE prop=(ENUM_BUFFER_PROP_DOUBLE)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   if(this.Status()>BUFFER_STATUS_NONE)
      ::Print("------");
   begin=end; end+=BUFFER_PROP_STRING_TOTAL;
   for(int i=begin; i<end; i++)
     {
      ENUM_BUFFER_PROP_STRING prop=(ENUM_BUFFER_PROP_STRING)i;
      if(!full_prop && !this.SupportProperty(prop)) continue;
      ::Print(this.GetPropertyDescription(prop));
     }
   ::Print("================== ",
           CMessage::Text(MSG_LIB_PARAMS_LIST_END),": ",
           this.GetTypeBufferDescription(),bktl,string(this.Status()>BUFFER_STATUS_NONE ? this.IndexPlot() : this.IndexBase()),bktr,dscr,
           " ==================\n"
          );
  }
//+------------------------------------------------------------------+
//| Return description of a buffer's integer property                |
//+------------------------------------------------------------------+
string CBuffer::GetPropertyDescription(ENUM_BUFFER_PROP_INTEGER property)
  {
   return
     (
      property==BUFFER_PROP_INDEX_PLOT    ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_INDEX_PLOT)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_STATUS        ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetStatusDescription()
         )  :
      property==BUFFER_PROP_TYPE          ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_TYPE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetTypeBufferDescription()
         )  :
      property==BUFFER_PROP_TIMEFRAME     ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_TIMEFRAME)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetTimeframeDescription()
         )  :
      property==BUFFER_PROP_ACTIVE        ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_ACTIVE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetActiveDescription()
         )  :
      property==BUFFER_PROP_DRAW_TYPE     ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_DRAW_TYPE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetDrawTypeDescription()
         )  :
      property==BUFFER_PROP_ARROW_CODE    ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_ARROW_CODE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_ARROW_SHIFT   ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_ARROW_SHIFT)+
         (!this.SupportProperty(property)    ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_LINE_STYLE    ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_LINE_STYLE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetLineStyleDescription()
         )  :
      property==BUFFER_PROP_LINE_WIDTH    ?  
         (this.Status()==BUFFER_STATUS_ARROW ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_ARROW_SIZE) :
          CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_LINE_WIDTH))+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_DRAW_BEGIN    ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_DRAW_BEGIN)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_SHOW_DATA     ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_SHOW_DATA)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetShowDataDescription()
         )  :
      property==BUFFER_PROP_SHIFT         ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_SHIFT)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_COLOR_INDEXES ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_COLOR_NUM)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_INDEX_COLOR   ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_INDEX_COLOR)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_INDEX_BASE    ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_INDEX_BASE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_INDEX_NEXT_BASE ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_INDEX_NEXT_BASE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_INDEX_NEXT_PLOT ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_INDEX_NEXT_PLOT)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_ID ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_ID)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_IND_LINE_MODE ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_IND_LINE_MODE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetIndicatorLineModeDescription()
         )  :
      property==BUFFER_PROP_IND_HANDLE ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_IND_HANDLE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_IND_TYPE ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_IND_TYPE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+::StringSubstr(::EnumToString((ENUM_INDICATOR)this.GetProperty(property)),4)
         )  :
      property==BUFFER_PROP_IND_LINE_ADDITIONAL_NUM ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_IND_LINE_ADDITIONAL_NUM)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.GetProperty(property)==WRONG_VALUE ? CMessage::Text(MSG_LIB_PROP_NOT_SET) : (string)this.GetProperty(property))
         )  :
      property==BUFFER_PROP_NUM_DATAS     ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_NUM_DATAS)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(string)this.GetProperty(property)
         )  :
      property==BUFFER_PROP_COLOR         ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_COLOR)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetColorsDescription()
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of a buffer's real property                   |
//+------------------------------------------------------------------+
string CBuffer::GetPropertyDescription(ENUM_BUFFER_PROP_DOUBLE property)
  {
   return
     (
      property==BUFFER_PROP_EMPTY_VALUE    ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_EMPTY_VALUE)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.GetEmptyValueDescription()
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return description of a buffer's string property                 |
//+------------------------------------------------------------------+
string CBuffer::GetPropertyDescription(ENUM_BUFFER_PROP_STRING property)
  {
   return
     (
      property==BUFFER_PROP_SYMBOL    ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_SYMBOL)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+this.Symbol()
         )  :
      property==BUFFER_PROP_LABEL    ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_LABEL)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.Label()==NULL || this.Label()=="" ? CMessage::Text(MSG_LIB_PROP_NOT_SET) : "\""+this.Label()+"\"")
         )  :
      property==BUFFER_PROP_IND_NAME   ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_IND_NAME)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.IndicatorName()==NULL || this.IndicatorName()=="" ? CMessage::Text(MSG_LIB_PROP_NOT_SET) : "\""+this.IndicatorName()+"\"")
         )  :
      property==BUFFER_PROP_IND_NAME_SHORT   ?  CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_IND_NAME_SHORT)+
         (!this.SupportProperty(property) ?  ": "+CMessage::Text(MSG_LIB_PROP_NOT_SUPPORTED) :
          ": "+(this.IndicatorShortName()==NULL || this.IndicatorShortName()=="" ? CMessage::Text(MSG_LIB_PROP_NOT_SET) : "\""+this.IndicatorShortName()+"\"")
         )  :
      ""
     );
  }
//+------------------------------------------------------------------+
//| Return the buffer status description                             |
//+------------------------------------------------------------------+
string CBuffer::GetStatusDescription(bool draw_type=false) const
  {
   string type=
     (
      this.Status()==BUFFER_STATUS_NONE         ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_NONE)         :
      this.Status()==BUFFER_STATUS_ARROW        ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_ARROW)        :
      this.Status()==BUFFER_STATUS_BARS         ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_BARS)         :
      this.Status()==BUFFER_STATUS_CANDLES      ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_CANDLES)      :
      this.Status()==BUFFER_STATUS_FILLING      ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_FILLING)      :
      this.Status()==BUFFER_STATUS_HISTOGRAM    ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_HISTOGRAM)    :
      this.Status()==BUFFER_STATUS_HISTOGRAM2   ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_HISTOGRAM2)   :
      this.Status()==BUFFER_STATUS_LINE         ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_LINE)         :
      this.Status()==BUFFER_STATUS_SECTION      ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_SECTION)      :
      this.Status()==BUFFER_STATUS_ZIGZAG       ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_ZIGZAG)       :
      "Unknown"
     );
   return(!draw_type ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_STATUS_NAME)+" \""+type+"\"" : type);
  }
//+------------------------------------------------------------------+
//| Return the buffer type description                               |
//+------------------------------------------------------------------+
string CBuffer::GetTypeBufferDescription(void) const
  {
   return
     (
      this.TypeBuffer()==BUFFER_TYPE_DATA       ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_TYPE_DATA)        :
      this.TypeBuffer()==BUFFER_TYPE_CALCULATE  ? CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_TYPE_CALCULATE)   :
      "Unknown"
     );
  }
//+------------------------------------------------------------------+
//| Return description of the buffer usage flag                      |
//+------------------------------------------------------------------+
string CBuffer::GetActiveDescription(void) const
  {
   return(this.IsActive() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO));
  }
//+---------------------------------------------------------------------+
//|Return description of displaying construction values in DataWindow   |
//+---------------------------------------------------------------------+
string CBuffer::GetShowDataDescription(void) const
  {
   return(this.IsShowData() ? CMessage::Text(MSG_LIB_TEXT_YES) : CMessage::Text(MSG_LIB_TEXT_NO));
  }
//+------------------------------------------------------------------+
//| Return description of the drawing line style                     |
//+------------------------------------------------------------------+
string CBuffer::GetLineStyleDescription(void) const
  {
   return LineStyleDescription(this.LineStyle());
  }
//+------------------------------------------------------------------+
//| Return description of the set empty value                        |
//+------------------------------------------------------------------+
string CBuffer::GetEmptyValueDescription(void) const
  {
   double value=fabs(this.EmptyValue());
   return(value<EMPTY_VALUE ? ::DoubleToString(this.EmptyValue(),(this.EmptyValue()==0 ? 1 : 8)) : (this.EmptyValue()>0 ? "EMPTY_VALUE" : "-EMPTY_VALUE"));
  }
//+------------------------------------------------------------------+
//| Return description of the graphical construction type            |
//+------------------------------------------------------------------+
string CBuffer::GetDrawTypeDescription(void) const
  {
   return this.GetStatusDescription(true);
  } 
//+------------------------------------------------------------------+
//| Return description of the used timeframe                         |
//+------------------------------------------------------------------+
string CBuffer::GetTimeframeDescription(void) const
  {
   string timeframe=TimeframeDescription(this.Timeframe());
   return(this.Timeframe()==PERIOD_CURRENT ? CMessage::Text(MSG_LIB_TEXT_PERIOD_CURRENT)+" ("+timeframe+")" : timeframe);
  } 
//+------------------------------------------------------------------+
//| Return description of specified colors                           |
//+------------------------------------------------------------------+
string CBuffer::GetColorsDescription(void) const
  {
   int total=this.ColorsTotal();
   if(total==1)
      return ::ColorToString(this.Color(),true);
   string res="";
   for(int i=0;i<total;i++)
     {
      res+=::ColorToString(this.ArrayColors[i],true)+(i<total-1 ? "," : "");
     }
   return res;
  }
//+------------------------------------------------------------------+
//| Return description of indicator buffer line                      |
//+------------------------------------------------------------------+
string CBuffer::GetIndicatorLineModeDescription(void) const
  {
   uchar shift=0;
   switch(this.IndicatorType())
     {
      case IND_ENVELOPES   :
      case IND_FRACTALS    :
      case IND_GATOR       :
      case IND_BANDS       :  shift=2; break;
      case IND_ALLIGATOR   :  shift=5; break;
      case IND_ADX         :
      case IND_ADXW        :  shift=8; break;
      case IND_ICHIMOKU    :  shift=10;break;
      default              :  shift=0; break;
     }
   return ::StringSubstr(::EnumToString(ENUM_INDICATOR_LINE(this.GetProperty(BUFFER_PROP_IND_LINE_MODE)+shift)),10);
  }
//+------------------------------------------------------------------+
//| Set the graphical construction type by type and status           |
//+------------------------------------------------------------------+
void CBuffer::SetDrawType(void)
  {
   ENUM_DRAW_TYPE type=(!this.TypeBuffer() || !this.Status() ? (ENUM_DRAW_TYPE)DRAW_NONE : this.Status()==BUFFER_STATUS_FILLING ? (ENUM_DRAW_TYPE)DRAW_FILLING : ENUM_DRAW_TYPE(this.Status()+8));
   this.SetProperty(BUFFER_PROP_DRAW_TYPE,type);
   #ifdef __MQL5__
      ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_DRAW_TYPE,type);
   #else 
      ::SetIndexStyle((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),type,EMPTY,EMPTY,EMPTY);
   #endif 
  }
//+------------------------------------------------------------------+
//| Set the passed graphical construction type                       |
//+------------------------------------------------------------------+
void CBuffer::SetDrawType(const ENUM_DRAW_TYPE draw_type)
  {
   if(this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
   this.SetProperty(BUFFER_PROP_DRAW_TYPE,draw_type);
   #ifdef __MQL5__
      ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_DRAW_TYPE,draw_type);
   #else 
      ::SetIndexStyle((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),draw_type,EMPTY,EMPTY,EMPTY);
   #endif 
  }
//+------------------------------------------------------------------+
//| Set the number of initial bars                                   |
//| without drawing and values in DataWindow                         |
//+------------------------------------------------------------------+
void CBuffer::SetDrawBegin(const int value)
  {
   if(this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
   this.SetProperty(BUFFER_PROP_DRAW_BEGIN,value);
   #ifdef __MQL5__
      ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_DRAW_BEGIN,value);
   #else 
      ::SetIndexDrawBegin((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),value);
   #endif 
  }
//+------------------------------------------------------------------+
//| Set the flag of displaying                                       |
//| construction values in DataWindow                                |
//+------------------------------------------------------------------+
void CBuffer::SetShowData(const bool flag)
  {
   if(this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
   this.SetProperty(BUFFER_PROP_SHOW_DATA,flag);
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_SHOW_DATA,flag);
  }
//+------------------------------------------------------------------+
//| Set the indicator graphical construction shift                   |
//+------------------------------------------------------------------+
void CBuffer::SetShift(const int shift)
  {
   this.SetProperty(BUFFER_PROP_SHIFT,shift);
   if(this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
   #ifdef __MQL5__
      ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_SHIFT,shift);
   #else 
      ::SetIndexShift((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),shift);
   #endif 
  }
//+------------------------------------------------------------------+
//| Set the line style                                               |
//+------------------------------------------------------------------+
void CBuffer::SetStyle(const ENUM_LINE_STYLE style)
  {
   if(this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
   this.SetProperty(BUFFER_PROP_LINE_STYLE,style);
   #ifdef __MQL5__
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_LINE_STYLE,style);
   #else 
      ::SetIndexStyle((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),this.DrawType(),style,EMPTY,EMPTY);
   #endif 
  }
//+------------------------------------------------------------------+
//| Set the line width                                               |
//+------------------------------------------------------------------+
void CBuffer::SetWidth(const int width)
  {
   if(this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
   this.SetProperty(BUFFER_PROP_LINE_WIDTH,width);
   #ifdef __MQL5__
      ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_LINE_WIDTH,width);
   #else 
      ::SetIndexStyle((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),this.DrawType(),EMPTY,width,EMPTY);
   #endif 
  }
//+------------------------------------------------------------------+
//| Set the number of colors                                         |
//+------------------------------------------------------------------+
void CBuffer::SetColorNumbers(const int number)
  {
   if(number>IND_COLORS_TOTAL || this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
   int n=(this.Status()!=BUFFER_STATUS_FILLING ? number : 2);
   this.SetProperty(BUFFER_PROP_COLOR_INDEXES,n);
   ::ArrayResize(this.ArrayColors,n);
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_COLOR_INDEXES,n);
  }
//+------------------------------------------------------------------+
//| Set a single specified drawing color for the buffer              |
//+------------------------------------------------------------------+
void CBuffer::SetColor(const color colour)
  {
   if(this.Status()==BUFFER_STATUS_FILLING || this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
   this.SetColorNumbers(1);
   this.SetProperty(BUFFER_PROP_COLOR,colour);
   this.ArrayColors[0]=colour;
   #ifdef __MQL5__
      ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_LINE_COLOR,0,this.ArrayColors[0]);
   #else 
      ::SetIndexStyle((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),this.DrawType(),EMPTY,EMPTY,this.ArrayColors[0]);
   #endif 
  }
//+------------------------------------------------------------------+
//| Set the drawing color to the specified color index               |
//+------------------------------------------------------------------+
void CBuffer::SetColor(const color colour,const uchar index)
  {
#ifdef __MQL5__
   if(index>IND_COLORS_TOTAL-1 || this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
   if(index>this.ColorsTotal()-1)
      this.SetColorNumbers(index+1);
   this.ArrayColors[index]=colour;
   if(index==0)
      this.SetProperty(BUFFER_PROP_COLOR,(color)this.ArrayColors[0]);
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_LINE_COLOR,index,this.ArrayColors[index]);
#else 
#endif 
  }
//+------------------------------------------------------------------+
//| Set drawing colors from the color array                          |
//+------------------------------------------------------------------+
void CBuffer::SetColors(const color &array_colors[])
  {
#ifdef __MQL5__
//--- Exit if the passed array is empty
   if(::ArraySize(array_colors)==0 || this.TypeBuffer()==BUFFER_TYPE_CALCULATE)
      return;
//--- Copy the passed array to the array of buffer object colors
   ::ArrayCopy(this.ArrayColors,array_colors,0,0,IND_COLORS_TOTAL);
//--- Exit if the color array was empty and not copied for some reason
   int total=::ArraySize(this.ArrayColors);
   if(total==0)
      return;
//--- If the drawing style is not DRAW_FILLING
   if(this.Status()!=BUFFER_STATUS_FILLING)
     {
      //--- if the new number of colors exceeds the currently set one, 
      //--- set the new value for the number of colors
      if(total>this.ColorsTotal())
         this.SetColorNumbers(total);
     }
   //--- If the drawing style is DRAW_FILLING, set the number of colors equal to 2
   else
      total=2;
//--- Set the very first color from the color array (for a single color) to the buffer object color property
   this.SetProperty(BUFFER_PROP_COLOR,(color)this.ArrayColors[0]);
//--- Set the new number of colors for the indicator buffer
   ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_COLOR_INDEXES,total);
//--- In the loop by the new number of colors, set all colors by their indices for the indicator buffer
   for(int i=0;i<total;i++)
      ::PlotIndexSetInteger((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_LINE_COLOR,i,this.ArrayColors[i]);
#else 
#endif 
  }
//+------------------------------------------------------------------+
//| Set the "empty" value for construction                           |
//| without drawing                                                  |
//+------------------------------------------------------------------+
void CBuffer::SetEmptyValue(const double value)
  {
   this.SetProperty(BUFFER_PROP_EMPTY_VALUE,value);
   if(this.TypeBuffer()!=BUFFER_TYPE_CALCULATE)
      #ifdef __MQL5__
         ::PlotIndexSetDouble((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_EMPTY_VALUE,value);
      #else 
         ::SetIndexEmptyValue((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),value);
      #endif 
  }
//+------------------------------------------------------------------+
//| Set the indicator graphical series name                          |
//+------------------------------------------------------------------+
void CBuffer::SetLabel(const string label)
  {
   this.SetProperty(BUFFER_PROP_LABEL,label);
   if(this.TypeBuffer()!=BUFFER_TYPE_CALCULATE)
      #ifdef __MQL5__
         ::PlotIndexSetString((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),PLOT_LABEL,label);
      #else 
         ::SetIndexLabel((int)this.GetProperty(BUFFER_PROP_INDEX_PLOT),label);
      #endif 
  }
//+------------------------------------------------------------------+
//| Return the adjusted buffer array index                           |
//+------------------------------------------------------------------+
int CBuffer::GetCorrectIndexBuffer(const uint buffer_index) const
  {
   return int(buffer_index<this.GetProperty(BUFFER_PROP_NUM_DATAS) ? buffer_index : this.GetProperty(BUFFER_PROP_NUM_DATAS)-1);
  }
//+------------------------------------------------------------------+
//| Return the array size of the specified data buffer               |
//+------------------------------------------------------------------+
int CBuffer::GetDataTotal(const uint buffer_index=0) const
  {
    int index=this.GetCorrectIndexBuffer(buffer_index);
    return(index>WRONG_VALUE ? ::ArraySize(this.DataBuffer[index].Array) : 0);
  }
//+------------------------------------------------------------------+
//| Return the value from the specified timeseries index             |
//| of the specified data buffer array                               |
//+------------------------------------------------------------------+
double CBuffer::GetDataBufferValue(const uint buffer_index,const int series_index) const
  {
   int correct_buff_index=this.GetCorrectIndexBuffer(buffer_index);
   int data_total=this.GetDataTotal(correct_buff_index);
   if(data_total==0 || series_index<0)
      return this.EmptyValue();
   int data_index=((int)series_index<data_total ? (int)series_index : data_total-1);
   return this.DataBuffer[correct_buff_index].Array[data_index];
  }
//+------------------------------------------------------------------+
//| Return the color index value from the specified timeseries index |
//| of the specified color buffer array                              |
//+------------------------------------------------------------------+
int CBuffer::GetColorBufferValueIndex(const int series_index) const
  {
   int data_total=this.GetDataTotal(0);
   if(data_total==0 || series_index<0)
      return WRONG_VALUE;
   int data_index=((int)series_index<data_total ? (int)series_index : data_total-1);
   return(this.ColorsTotal()==1 ? 0 : (int)this.ColorBufferArray[data_index]);
  }
//+------------------------------------------------------------------+
//| Return the color value from the specified timeseries index       |
//| of the specified color buffer array                              |
//+------------------------------------------------------------------+
color CBuffer::GetColorBufferValueColor(const int series_index) const
  {
   int data_total=this.GetDataTotal(0);
   if(data_total==0 || series_index<0)
      return clrNONE;
   int color_index=this.GetColorBufferValueIndex(series_index);
   return(color_index>WRONG_VALUE ? (color)this.ArrayColors[color_index] : clrNONE);
  }
//+------------------------------------------------------------------+
//| Set the value to the specified timeseries index                  |
//| for the specified data buffer array                              |
//+------------------------------------------------------------------+
void CBuffer::SetBufferValue(const uint buffer_index,const uint series_index,const double value)
  {
   if(this.GetDataTotal(buffer_index)==0)
      return;
   int correct_buff_index=this.GetCorrectIndexBuffer(buffer_index);
   int data_total=this.GetDataTotal(buffer_index);
   int data_index=((int)series_index<data_total ? (int)series_index : data_total-1);
   if(data_index<0)
      return;
   this.DataBuffer[correct_buff_index].Array[data_index]=value;
  }
//+------------------------------------------------------------------+
//| Set the color index to the specified timeseries index            |
//| of the color buffer array                                        |
//+------------------------------------------------------------------+
void CBuffer::SetBufferColorIndex(const uint series_index,const uchar color_index)
  {
   #ifdef __MQL4__
      return;
   #endif 
   if(this.GetDataTotal(0)==0 || color_index>this.ColorsTotal()-1 || this.Status()==BUFFER_STATUS_FILLING || this.Status()==BUFFER_STATUS_NONE)
      return;
   int data_total=this.GetDataTotal(0);
   int data_index=((int)series_index<data_total ? (int)series_index : data_total-1);
   if(::ArraySize(this.ColorBufferArray)==0)
      ::Print(DFUN,CMessage::Text(MSG_LIB_SYS_ERROR),": ",CMessage::Text(MSG_LIB_TEXT_BUFFER_TEXT_INVALID_PROPERTY_BUFF));
   if(data_index<0)
      return;
   this.ColorBufferArray[data_index]=color_index;
  }
//+------------------------------------------------------------------+
//| Return the number of standard indicator calculated bars          |
//+------------------------------------------------------------------+
int CBuffer::IndicatorBarsCalculated(void)
  {
   return(#ifdef __MQL5__ ::BarsCalculated((int)this.GetProperty(BUFFER_PROP_IND_HANDLE)) #else ::Bars(this.Symbol(),this.Timeframe()) #endif);
  }
//+------------------------------------------------------------------+
//| Initialize all object buffers by the specified value             |
//+------------------------------------------------------------------+
void CBuffer::InitializeAll(const double value,const uchar color_index)
  {
   for(int i=0;i<this.GetProperty(BUFFER_PROP_NUM_DATAS);i++)
      ::ArrayInitialize(this.DataBuffer[i].Array,value);
   if(this.Status()!=BUFFER_STATUS_FILLING && this.TypeBuffer()!=BUFFER_TYPE_CALCULATE)
      ::ArrayInitialize(this.ColorBufferArray,(color_index>this.ColorsTotal()-1 ? 0 : color_index));
  }
//+------------------------------------------------------------------+
//| Initialize all object buffers                                    |
//| by the empty value set for the object                            |
//+------------------------------------------------------------------+
void CBuffer::InitializeAll(void)
  {
   for(int i=0;i<this.GetProperty(BUFFER_PROP_NUM_DATAS);i++)
      ::ArrayInitialize(this.DataBuffer[i].Array,this.EmptyValue());
   if(this.Status()!=BUFFER_STATUS_FILLING && this.TypeBuffer()!=BUFFER_TYPE_CALCULATE)
      ::ArrayInitialize(this.ColorBufferArray,0);
  }
//+------------------------------------------------------------------+
//| Fill all data buffers with the empty value                       |
//| in the specified timeseries index                                |
//+------------------------------------------------------------------+
void CBuffer::ClearData(const int series_index)
  {
   for(int i=0;i<this.GetProperty(BUFFER_PROP_NUM_DATAS);i++)
      this.SetBufferValue(i,series_index,this.EmptyValue());
   this.SetBufferColorIndex(series_index,0);
  }
//+------------------------------------------------------------------+
//| Fill the specified buffer with data from the passed array        |
//+------------------------------------------------------------------+
void CBuffer::FillAsSeries(const int buffer_index,const double &array[])
  {
//--- Get the copied array size
   int total=::ArraySize(array);
   if(total==0)
      return;
//--- In the loop from the very last array element (from the current bar)
   int n=0;
   for(int i=total-1;i>WRONG_VALUE && !::IsStopped();i--)
     {
      //--- calculate the index, based on which the array value is saved to the buffer, and
      //--- write the value of the array cell by i index using the calculated index
      n=total-1-i;
      this.SetBufferValue(buffer_index,n,array[i]);
     }
  }
//+------------------------------------------------------------------+
