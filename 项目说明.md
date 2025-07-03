以下是基于Mql5DoEasy库的中文完整使用手册框架，结合了库的核心功能和搜索结果中的关键信息：

---

# Mql5DoEasy 库使用手册

## 一、库概述
Mql5DoEasy是一个综合性的MQL5开发库，提供：
- 图形化UI控件系统（仿Windows Forms风格）
- 交易功能封装
- 市场数据分析工具
- 复合图形对象管理

## 二、环境配置
1. **安装要求**
   - MetaTrader 5 Build 2000+
   - 将库文件解压至`MQL5/Include/DoEasy/`

2. **基础引用**
   ```mql5
   #include <DoEasy\Engine.mqh>
   CEngine engine; // 主引擎实例
   ```

## 三、图形控件系统
### 1. 核心控件类
| 类名            | 功能描述                          | 继承关系           |
|-----------------|----------------------------------|-------------------|
| `CForm`         | 基础窗体容器                     | 顶级容器          |
| `CPanel`        | 面板控件（可嵌套其他控件） | 继承自`CForm`     |
| `CButton`       | 按钮控件                         | 继承自`CElement`  |
| `CTabControl`   | 选项卡控件                       | 继承自`CWinForm`  |
| `CScrollBar`    | 支持动画效果的滚动条  | 继承自`CControl`  |

### 2. 控件创建示例
```mql5
// 创建主窗口
CWindow *win = new CWindow();
win.Create("示例窗口", 10, 10, 800, 600);

// 添加面板
CPanel *panel = new CPanel();
panel.Create("主面板", 20, 50, 760, 500, win);

// 在面板中添加按钮
CButton *btn = new CButton();
btn.Create("测试按钮", 30, 30, 100, 30, panel);
btn.OnClick(OnButtonClicked); // 绑定点击事件
```

### 3. 高级功能
- **控件绑定**：子控件可自动跟随父容器移动
- **裁剪区域**：自动隐藏超出容器的部分
- **DPI适配**：建议通过`TerminalInfoInteger(TERMINAL_SCREEN_DPI)`获取DPI值后手动缩放

## 四、交易功能模块
### 1. 核心交易方法
```mql5
// 开仓示例
engine.Trade().PositionOpen(
   Symbol(),                // 交易品种
   ORDER_TYPE_BUY,         // 方向
   0.1,                    // 手数
   0,                      // 开仓价（0表示市价）
   50,                     // 止损点数
   100                     // 止盈点数
);

// 平仓所有订单
engine.Trade().PositionsCloseAll();
```

### 2. 账户管理
```mql5
// 获取账户信息
double balance = engine.Account().Balance();
double equity = engine.Account().Equity();
```

## 五、图形对象管理
### 1. 复合对象操作
```mql5
// 创建复合图形对象
engine.Graphic().CreateComposite("OBJ_GROUP");

// 添加子对象
engine.Graphic().AddToComposite("OBJ_GROUP", OBJ_TRENDLINE);
engine.Graphic().AddToComposite("OBJ_GROUP", OBJ_ARROW);

// 统一移动/删除
engine.Graphic().MoveComposite("OBJ_GROUP", x_offset, y_offset);
engine.Graphic().DeleteComposite("OBJ_GROUP"); 
```

## 六、事件处理系统
### 1. 鼠标事件类型
| 事件常量                 | 触发条件                 |
|-------------------------|-------------------------|
| `ON_MOUSE_MOVE`         | 鼠标移动                |
| `ON_MOUSE_LEFT_CLICK`   | 左键单击                |
| `ON_MOUSE_RIGHT_CLICK`  | 右键单击                |
| `ON_MOUSE_WHEEL`        | 滚轮滚动    |

### 2. 事件绑定示例
```mql5
// 控件事件绑定
btn.OnEvent(ON_MOUSE_MOVE, OnMouseMoveHandler);

// 图表事件处理
void OnChartEvent(const int id, const long& lparam, const double& dparam, const string& sparam)
{
   engine.OnChartEvent(id, lparam, dparam, sparam); // 必须传递事件给引擎
}
```

## 七、调试与优化
1. **错误处理**
   ```mql5
   if(!engine.GetLastError(code, desc))
      Print("错误 ", code, ": ", desc);
   ```

2. **性能建议**
   - 避免在`OnTick()`中频繁创建/删除对象
   - 使用`PAUSE_FOR_CANV_UPDATE`控制画布刷新频率（默认16ms）

## 八、附录
### 1. 默认参数配置
```mql5
// Defines.mqh中的关键默认值
#define DEF_FONT        "Calibri"      // 默认字体
#define DEF_FONT_SIZE   8              // 默认字号
#define CLR_DEF_SHADOW_OPACITY 127     // 阴影透明度
```

### 2. 版本更新记录
- v1.0：基础图形控件系统
- v2.3：添加SplitContainer等WinForms控件

---

> 注：本手册基于公开文档整理，具体实现请参考库内示例和头文件注释。最新特性请关注官方更新日志。
