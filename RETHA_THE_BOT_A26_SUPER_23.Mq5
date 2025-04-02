//+------------------------------------------------------------------+  
//|                                                      RETHA_THE_BOT_A26_SUPER.mq5  |
//|                        Copyright 2025, MetaQuotes Software Corp.  |
//|                                       https://www.mql5.com         |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>

input double Lots = 0.01;         // Reduced lot size
input int MaxPositions = 10;      // Maximum number of positions allowed

// Declare the trade object
CTrade trade;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    Print("RETHA_THE_BOT_A26_SUPER has been initialized");
    AddChartAnnotations();
    return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    Print("RETHA_THE_BOT_A26_SUPER has been deinitialized");
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    // Monthly Analysis
    if (!PerformMonthlyAnalysis()) return;

    // Weekly Analysis
    if (!PerformWeeklyAnalysis()) return;

    // Daily Analysis
    if (!PerformDailyAnalysis()) return;

    // 4-Hour Analysis
    if (!Perform4HourAnalysis()) return;

    // 1-Hour Analysis
    if (!Perform1HourAnalysis()) return;

    // 30-Minute Analysis
    if (!Perform30MinuteAnalysis()) return;

    // 15-Minute Analysis
    if (!Perform15MinuteAnalysis()) return;

    // 1-Minute & 5-Minute Charts Execution
    PerformExecution();
}
//+------------------------------------------------------------------+
//| Monthly Analysis                                                 |
//+------------------------------------------------------------------+
bool PerformMonthlyAnalysis() {
    double monthlyClose[3];

    // Get the closing prices of the last three monthly candles
    for (int i = 0; i < 3; i++) {
        monthlyClose[i] = iClose(NULL, PERIOD_MN1, i);
    }

    // Determine the overall trend
    if (monthlyClose[0] > monthlyClose[1] && monthlyClose[1] > monthlyClose[2]) {
        // Uptrend
        Print("Monthly trend: Uptrend");
    } else if (monthlyClose[0] < monthlyClose[1] && monthlyClose[1] < monthlyClose[2]) {
        // Downtrend
        Print("Monthly trend: Downtrend");
    } else {
        // Sideways
        Print("Monthly trend: Sideways");
    }

    return true; // Return false if the analysis fails
}
//+------------------------------------------------------------------+
//| Weekly Analysis                                                  |
//+------------------------------------------------------------------+
bool PerformWeeklyAnalysis() {
    double weeklyClose[3];

    // Get the closing prices of the last three weekly candles
    for (int i = 0; i < 3; i++) {
        weeklyClose[i] = iClose(NULL, PERIOD_W1, i);
    }

    // Determine the overall trend
    if (weeklyClose[0] > weeklyClose[1] && weeklyClose[1] > weeklyClose[2]) {
        // Uptrend
        Print("Weekly trend: Uptrend");
    } else if (weeklyClose[0] < weeklyClose[1] && weeklyClose[1] < weeklyClose[2]) {
        // Downtrend
        Print("Weekly trend: Downtrend");
    } else {
        // Sideways
        Print("Weekly trend: Sideways");
    }

    return true; // Return false if the analysis fails
}
//+------------------------------------------------------------------+
//| Daily Analysis                                                   |
//+------------------------------------------------------------------+
bool PerformDailyAnalysis() {
    double dailyClose[3];

    // Get the closing prices of the last three daily candles
    for (int i = 0; i < 3; i++) {
        dailyClose[i] = iClose(NULL, PERIOD_D1, i);
    }

    // Determine support and resistance levels
    // For simplicity, let's assume support and resistance are based on the highs and lows of the last three daily candles
    double support = MathMin(dailyClose[0], MathMin(dailyClose[1], dailyClose[2]));
    double resistance = MathMax(dailyClose[0], MathMax(dailyClose[1], dailyClose[2]));

    Print("Daily support level: ", support);
    Print("Daily resistance level: ", resistance);

    return true; // Return false if the analysis fails
}
//+------------------------------------------------------------------+
//| 4-Hour Analysis                                                  |
//+------------------------------------------------------------------+
bool Perform4HourAnalysis() {
    double maShort = iMA(NULL, PERIOD_H4, 10, 0, MODE_SMA, PRICE_CLOSE);
    double maLong = iMA(NULL, PERIOD_H4, 50, 0, MODE_SMA, PRICE_CLOSE);

    // Simple Moving Average Crossover Strategy
    if (maShort > maLong) {
        Print("4-Hour Signal: Buy");
    } else if (maShort < maLong) {
        Print("4-Hour Signal: Sell");
    }

    return true; // Return false if the analysis fails
}
//+------------------------------------------------------------------+
//| 1-Hour Analysis                                                  |
//+------------------------------------------------------------------+
bool Perform1HourAnalysis() {
    double maShort = iMA(NULL, PERIOD_H1, 10, 0, MODE_SMA, PRICE_CLOSE);
    double maLong = iMA(NULL, PERIOD_H1, 50, 0, MODE_SMA, PRICE_CLOSE);

    // Simple Moving Average Crossover Strategy
    if (maShort > maLong) {
        Print("1-Hour Signal: Buy");
    } else if (maShort < maLong) {
        Print("1-Hour Signal: Sell");
    }

    return true; // Return false if the analysis fails
}
//+------------------------------------------------------------------+
//| 30-Minute Analysis                                               |
//+------------------------------------------------------------------+
bool Perform30MinuteAnalysis() {
    double maShort = iMA(NULL, PERIOD_M30, 10, 0, MODE_SMA, PRICE_CLOSE);
    double maLong = iMA(NULL, PERIOD_M30, 50, 0, MODE_SMA, PRICE_CLOSE);

    // Simple Moving Average Crossover Strategy
    if (maShort > maLong) {
        Print("30-Minute Signal: Buy");
    } else if (maShort < maLong) {
        Print("30-Minute Signal: Sell");
    }

    return true; // Return false if the analysis fails
}
//+------------------------------------------------------------------+
//| 15-Minute Analysis                                               |
//+------------------------------------------------------------------+
bool Perform15MinuteAnalysis() {
    double maShort = iMA(NULL, PERIOD_M15, 10, 0, MODE_SMA, PRICE_CLOSE);
    double maLong = iMA(NULL, PERIOD_M15, 50, 0, MODE_SMA, PRICE_CLOSE);

    // Simple Moving Average Crossover Strategy
    if (maShort > maLong) {
        Print("15-Minute Signal: Buy");
    } else if (maShort < maLong) {
        Print("15-Minute Signal: Sell");
    }

    return true; // Return false if the analysis fails
}
//+------------------------------------------------------------------+
//| Execute Trades                                                   |
//+------------------------------------------------------------------+
void PerformExecution() {
    double maShortM1 = iMA(NULL, PERIOD_M1, 10, 0, MODE_SMA, PRICE_CLOSE);
    double maLongM1 = iMA(NULL, PERIOD_M1, 50, 0, MODE_SMA, PRICE_CLOSE);
    double maShortM5 = iMA(NULL, PERIOD_M5, 10, 0, MODE_SMA, PRICE_CLOSE);
    double maLongM5 = iMA(NULL, PERIOD_M5, 50, 0, MODE_SMA, PRICE_CLOSE);
    double maShortM15 = iMA(NULL, PERIOD_M15, 10, 0, MODE_SMA, PRICE_CLOSE);
    double maLongM15 = iMA(NULL, PERIOD_M15, 50, 0, MODE_SMA, PRICE_CLOSE);
    double maShortM30 = iMA(NULL, PERIOD_M30, 10, 0, MODE_SMA, PRICE_CLOSE);
    double maLongM30 = iMA(NULL, PERIOD_M30, 50, 0, MODE_SMA, PRICE_CLOSE);

    double ask, bid;
    if (!SymbolInfoDouble(Symbol(), SYMBOL_ASK, ask)) {
        Print("Error getting ask price");
        return;
    }
    if (!SymbolInfoDouble(Symbol(), SYMBOL_BID, bid)) {
        Print("Error getting bid price");
        return;
    }

    double equity = AccountInfoDouble(ACCOUNT_EQUITY);
    double freeMargin = AccountInfoDouble(ACCOUNT_FREEMARGIN);

    double marginRequired;
    if (!SymbolInfoDouble(Symbol(), SYMBOL_MARGIN_INITIAL, marginRequired)) {
        Print("Error getting margin required");
        return;
    }

    Print("Equity: ", equity);
    Print("Free Margin: ", freeMargin);
    Print("Required Margin: ", marginRequired * Lots);

    if (freeMargin < marginRequired * Lots) {
        Print("Not enough free margin to open a position");
        return;
    }

    // Check the number of current positions
    int totalPositions = PositionsTotal();
    if (totalPositions >= MaxPositions) {
        Print("Limit positions reached: ", totalPositions);
        return;
    }

    // Range trading strategy
    double support = 82546.16; // Daily support level
    double resistance = 85846.46; // Daily resistance level
    double currentPrice = iClose(NULL, PERIOD_M1, 0); // Current price on 1-minute chart

    // Check for confirmation on 1-minute and 5-minute timeframes
    bool confirmM1 = (maShortM1 < maLongM1 && currentPrice >= resistance) || (maShortM1 > maLongM1 && currentPrice <= support);
    bool confirmM5 = (maShortM5 < maLongM5 && currentPrice >= resistance) || (maShortM5 > maLongM5 && currentPrice <= support);

    if (confirmM1 && confirmM5) {
        // Check for retests on 15-minute and 30-minute timeframes
        bool retestM15 = (maShortM15 < maLongM15 && currentPrice >= resistance) || (maShortM15 > maLongM15 && currentPrice <= support);
        bool retestM30 = (maShortM30 < maLongM30 && currentPrice >= resistance) || (maShortM30 > maLongM30 && currentPrice <= support);

        if (retestM15 || retestM30) {
            if (currentPrice <= support) {
                // Close all sell positions before buying
                CloseAllSellPositions();
                // Buy at support
                if (trade.Buy(Lots)) {
                    Print("Opened Buy position at support on retest");
                }
            } else if (currentPrice >= resistance) {
                // Close all buy positions before selling
                CloseAllBuyPositions();
                // Sell at resistance
                if (trade.Sell(Lots)) {
                    Print("Opened Sell position at resistance on retest");
                }
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Close all sell positions                                         |
//+------------------------------------------------------------------+
void CloseAllSellPositions() {
    for (int i = PositionsTotal() - 1; i >= 0; i--) {
        ulong ticket = PositionGetTicket(i);
        if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL) {
            if (trade.PositionClose(ticket)) {
                Print("Closed Sell position with ticket: ", ticket);
            } else {
                Print("Failed to close Sell position with ticket: ", ticket);
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Close all buy positions                                          |
//+------------------------------------------------------------------+
void CloseAllBuyPositions() {
    for (int i = PositionsTotal() - 1; i >= 0; i--) {
        ulong ticket = PositionGetTicket(i);
        if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) {
            if (trade.PositionClose(ticket)) {
                Print("Closed Buy position with ticket: ", ticket);
            } else {
                Print("Failed to close Buy position with ticket: ", ticket);
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Add Chart Annotations                                            |
//+------------------------------------------------------------------+
void AddChartAnnotations() {
    string infoText = "Instrument: BTCUSD\nTimeframe: H1 (Hourly)\nMonthly Trend: Sideways\nWeekly Trend: Sideways\nDaily Support Level: 82546.16\nDaily Resistance Level: 85846.46";
    Comment(infoText);
}
