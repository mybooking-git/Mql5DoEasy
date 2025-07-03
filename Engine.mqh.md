# **Engine.mqh 中文详细说明**

`Engine.mqh` 是 **Mql5DoEasy** 库的核心引擎文件，负责协调整个库的功能模块，并提供统一的接口供开发者调用。它在库的架构中扮演 **中枢控制** 的角色，管理交易、UI、数据、事件等核心功能。  

---

## **1. Engine.mqh 的主要功能**
`Engine.mqh` 提供了以下核心功能：
1. **初始化与销毁**  
   - `OnInit()`：初始化所有子模块（交易、账户、图表、UI 等）。  
   - `OnDeinit()`：清理资源，防止内存泄漏。  
   - `OnTick()`：处理市场数据更新，驱动自动化交易逻辑。  

2. **交易功能（CTradeEx）**  
   - 增强版的 `CTrade`，支持批量下单、高级风控、自动止损止盈等功能。  
   - 示例：
     ```mql5
     engine.Trade().PositionOpen(Symbol(), ORDER_TYPE_BUY, 0.1, 0, 50, 100); // 开仓
     engine.Trade().PositionsCloseAll(); // 平仓所有订单
     ```

3. **账户管理（CAccountInfoEx）**  
   - 提供账户余额、净值、杠杆等信息的快捷访问：
     ```mql5
     double balance = engine.Account().Balance();
     double equity = engine.Account().Equity();
     ```

4. **UI 系统（CWindow, CButton, CEdit 等）**  
   - 支持 Windows Forms 风格的 UI 控件（按钮、输入框、标签等）。  
   - 示例：
     ```mql5
     CButton *btn = new CButton();
     btn.Create("Buy", 10, 10, 100, 30, engine.GetMainWindow());
     btn.OnClick(OnBuyClicked); // 绑定点击事件
     ```

5. **事件处理（OnChartEvent）**  
   - 统一管理鼠标、键盘、控件交互事件：
     ```mql5
     void OnChartEvent(const int id, const long& lparam, const double& dparam, const string& sparam) {
         engine.OnChartEvent(id, lparam, dparam, sparam); // 必须传递给引擎
     }
     ```

6. **数据管理（CDataInd）**  
   - 提供高效的指标数据存储和查询：
     ```mql5
     double maValue = engine.Data().GetIndicatorValue("MA", 0, 0); // 获取 MA 指标最新值
     ```

---

## **2. Engine.mqh 与其他库的关系**
| **模块** | **功能** | **如何通过 Engine.mqh 调用** |
|----------|---------|---------------------------|
| `Trade.mqh` | 交易执行 | `engine.Trade().PositionOpen()` |
| `AccountInfo.mqh` | 账户信息 | `engine.Account().Balance()` |
| `Controls.mqh` | UI 控件 | `engine.GetMainWindow()` 获取主窗口 |
| `Data.mqh` | 指标数据 | `engine.Data().GetIndicatorValue()` |
| `Graphic.mqh` | 图表绘制 | `engine.Graphic().DrawLine()` |

---

## **3. 典型使用示例**
### **(1) 初始化引擎**
```mql5
#include <Mql5DoEasy\Engine.mqh>
CEngine engine;

int OnInit() {
    if (!engine.OnInit()) { // 必须调用初始化
        Print("引擎初始化失败！");
        return INIT_FAILED;
    }
    
    // 创建 UI
    CButton *btn = new CButton();
    btn.Create("Buy", 10, 10, 100, 30, engine.GetMainWindow());
    btn.OnClick(OnBuyClicked);
    
    return INIT_SUCCEEDED;
}

void OnDeinit(const int reason) {
    engine.OnDeinit(); // 清理资源
}
```

### **(2) 交易逻辑**
```mql5
void OnTick() {
    engine.OnTick(); // 引擎更新市场数据
    
    // 检查条件并开仓
    if (engine.Data().GetIndicatorValue("RSI", 0, 0) < 30) {
        engine.Trade().PositionOpen(Symbol(), ORDER_TYPE_BUY, 0.1);
    }
}
```

### **(3) 事件处理**
```mql5
void OnBuyClicked() {
    engine.Trade().PositionOpen(Symbol(), ORDER_TYPE_BUY, 0.1);
}

void OnChartEvent(const int id, const long& lparam, const double& dparam, const string& sparam) {
    engine.OnChartEvent(id, lparam, dparam, sparam); // 必须传递事件
}
```

---

## **4. 注意事项**
1. **必须调用 `engine.OnInit()`**，否则子模块无法正常工作。  
2. **避免高频创建/销毁对象**，建议在 `OnInit()` 初始化，`OnDeinit()` 释放。  
3. **UI 控件需绑定到主窗口**，否则无法显示：
   ```mql5
   CButton *btn = new CButton();
   btn.Create("Test", 10, 10, 100, 30, engine.GetMainWindow()); // 必须传入主窗口
   ```
4. **错误处理**：
   ```mql5
   int errorCode;
   string errorDesc;
   if (!engine.GetLastError(errorCode, errorDesc)) {
       Print("错误 ", errorCode, ": ", errorDesc);
   }
   ```

---

## **5. 总结**
`Engine.mqh` 是 **Mql5DoEasy 库的核心**，负责：
- ✅ **初始化所有子模块**（交易、UI、数据等）  
- ✅ **提供统一接口**（`engine.Trade()`, `engine.Account()`, `engine.Data()`）  
- ✅ **管理事件和数据流**（`OnTick()`, `OnChartEvent()`）  
- ✅ **优化资源管理**（避免内存泄漏）  

适用于 **EA 交易、UI 界面开发、指标数据分析** 等场景。建议结合示例代码学习，以快速掌握其使用方法。 🚀
