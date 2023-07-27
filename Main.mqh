//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

#include "SmartInvestRSI.mqh"


LOGGER_DEFINE_FILENAME(__FILE__)

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
BEGIN_INPUT(CSmartInvestRSIParams)
INPUT(int, Magic, 1);               //Magic
INPUT(bool, Martingale, false);     //Use Martingale
INPUT(double, Factor, 1.5);         //Multiplier
INPUT(int, TakeProfit, 100);        //TakeProfit (Pipette/Points)
INPUT(int, Step, 100);              //Step (Pipette/Points)
INPUT(double, Lot, 0.01);           //Lots
INPUT_SEP("Exit");
INPUT(bool, CloseAtDrawDown, false); //Close at drawdown (Drawdown on EA)
INPUT(ENUM_RISK_TYPE, DrawDownType, ENUM_RISK_PERCENT_BALANCE); //Drawdown Type
INPUT(double, DrawDownToCloseValue, 5);  //Drawdown to close
INPUT_SEP("Pause");
INPUT(uint, MaxTrades, 100);        //Max Trades (Not applicable for hedge)
INPUT_SEP("RSI_Settings");
INPUT(int, RsiUpperBound, 70);                        //RSI Overbought
INPUT(int, RsiLowerBound, 30);                        //RSI Oversold
INPUT(ENUM_TIMEFRAMES, RsiTimeFrame, PERIOD_CURRENT); //RSI TimeFrame
INPUT(int, RsiMaLength, 14);                          //RSI Ma Length
INPUT(ENUM_APPLIED_PRICE, RsiAppliedPrice, PRICE_CLOSE); //RSI Applied Price
INPUT_SEP("Miscelaneous");
INPUT(bool, DisplayInformaion, true);//Display Information Status
INPUT_SEP("Hedging_NA"); // Hedging N/A
END_INPUT
//+------------------------------------------------------------------+
DECLARE_EA(CSmartInvestRSI, true, "SmartInvestRSI");
//+------------------------------------------------------------------+

