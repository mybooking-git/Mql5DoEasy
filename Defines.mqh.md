# **Defines.mqh 中文详细说明手册**

`Defines.mqh` 是 **Mql5DoEasy** 库的核心定义文件，包含 **全局常量、枚举、宏定义和基础结构体**，为整个库提供统一的配置和标准。  

---

## **1. 文件作用**
- **定义库的全局参数**（如默认颜色、字体、控件样式等）
- **标准化错误代码**（便于调试和错误处理）
- **提供枚举类型**（如交易方向、订单类型、图形对象类型等）
- **优化代码可读性**（通过宏定义简化复杂操作）

---

## **2. 核心内容详解**
### **2.1 颜色与样式定义**
定义 UI 控件、图表对象的默认颜色和样式：
```mql5
// 默认颜色
#define CLR_DEF_WINDOW_BG      C'240,240,240'    // 窗口背景色（浅灰）
#define CLR_DEF_BUTTON_BG      C'51,153,255'     // 按钮背景色（蓝色）
#define CLR_DEF_TEXT           clrBlack          // 默认文本颜色（黑色）

// 边框样式
#define BORDER_FLAT            0                 // 扁平边框
#define BORDER_RAISED          1                 // 凸起边框
#define BORDER_SUNKEN          2                 // 凹陷边框
```

### **2.2 错误代码（Error Codes）**
定义库内部的错误类型，便于调试：
```mql5
#define ERR_DOEASY_INVALID_INPUT   10001    // 无效输入参数
#define ERR_DOEASY_TRADE_FAILED    10002    // 交易执行失败
#define ERR_DOEASY_UI_NOT_READY    10003    // UI 未初始化
```

### **2.3 交易相关枚举**
标准化订单类型、交易方向等：
```mql5
// 订单类型
enum ENUM_ORDER_TYPE_EX {
   ORDER_TYPE_BUY_EX = 0,       // 买入
   ORDER_TYPE_SELL_EX = 1,      // 卖出
   ORDER_TYPE_BUY_LIMIT_EX = 2, // 限价买入
   ORDER_TYPE_SELL_LIMIT_EX = 3 // 限价卖出
};

// 止损/止盈模式
enum ENUM_SLTP_MODE {
   SLTP_FIXED = 0,     // 固定点数
   SLTP_PERCENT = 1,   // 百分比计算
   SLTP_ATR_BASED = 2  // 基于 ATR 波动率
};
```

### **2.4 图形对象类型**
定义支持的图表对象类型：
```mql5
enum ENUM_GRAPHIC_OBJECTS {
   OBJ_TRENDLINE = 0,    // 趋势线
   OBJ_ARROW = 1,        // 箭头标记
   OBJ_RECTANGLE = 2,    // 矩形
   OBJ_LABEL = 3         // 文本标签
};
```

### **2.5 常用宏定义**
简化代码编写：
```mql5
// 计算两个价格的差值（点数）
#define PRICE_DIFF(p1, p2) ((p1 - p2) / _Point)

// 检查指针是否有效
#define SAFE_DELETE(p) { if (CheckPointer(p) == POINTER_DYNAMIC) delete p; p = NULL; }

// 限制数值范围
#define CLAMP(v, min, max) ((v < min) ? min : ((v > max) ? max : v))
```

---

## **3. 使用示例**
### **3.1 在交易逻辑中使用枚举**
```mql5
#include <Mql5DoEasy\Defines.mqh>

void PlaceOrder(ENUM_ORDER_TYPE_EX orderType, double lot, double sl, double tp) {
   if (orderType == ORDER_TYPE_BUY_EX) {
      engine.Trade().PositionOpen(Symbol(), ORDER_TYPE_BUY, lot, 0, sl, tp);
   }
   // ...其他逻辑
}
```

### **3.2 在 UI 开发中使用颜色定义**
```mql5
#include <Mql5DoEasy\Defines.mqh>
#include <Mql5DoEasy\Controls\Button.mqh>

CButton *btn = new CButton();
btn.Create("Submit", 10, 10, 100, 30, mainWindow);
btn.BackColor(CLR_DEF_BUTTON_BG);  // 使用预定义的按钮背景色
btn.TextColor(CLR_DEF_TEXT);       // 使用默认文本颜色
```

### **3.3 错误处理**
```mql5
if (!engine.Trade().PositionOpen(...)) {
   int errCode = engine.GetLastError();
   if (errCode == ERR_DOEASY_TRADE_FAILED) {
      Alert("交易失败！请检查市场状态");
   }
}
```

---

## **4. 注意事项**
1. **避免修改默认值**：除非必要，不建议直接修改 `Defines.mqh` 中的常量，以免影响库的稳定性。
2. **兼容性**：不同版本的 `Defines.mqh` 可能有差异，升级库时需检查变更。
3. **性能优化**：宏定义（如 `SAFE_DELETE`）能减少代码量，但过度使用可能影响可读性。

---

## **5. 总结**
`Defines.mqh` 是 **Mql5DoEasy** 库的“基石”，提供：
✅ **统一的常量、枚举和错误代码**  
✅ **标准化 UI 样式和交易参数**  
✅ **简化代码的宏定义**  

建议结合库的示例代码（如 `SampleEA.mq5`）学习其实际应用。
