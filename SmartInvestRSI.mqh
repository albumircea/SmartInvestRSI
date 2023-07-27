//+------------------------------------------------------------------+
//|                                               SmartInvestRSI.mqh |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "https://www.mql5.com"



#include "../SmartInvestBasicV3/SmartInvestBasicV3.mqh"
#include <Indicators/Oscilators.mqh>



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CSmartInvestRSIParams : public CSmartInvestParams
{
                     ObjectAttrProtected(double, RsiUpperBound);
                     ObjectAttrProtected(double, RsiLowerBound);
                     ObjectAttrProtected(ENUM_TIMEFRAMES, RsiTimeFrame);
                     ObjectAttrProtected(int, RsiMaLength);
                     ObjectAttrProtected(ENUM_APPLIED_PRICE, RsiAppliedPrice);



protected:



public:
   bool               Check()
   {
      if(!CSmartInvestParams::Check())
         return false;
      return true;
   }
};


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CSmartInvestRSI : public CSmartInvestV3
{
                     ObjectAttrProtected(double, RsiUpperBound);
                     ObjectAttrProtected(double, RsiLowerBound);
                     ObjectAttrProtected(ENUM_TIMEFRAMES, RsiTimeFrame);
                     ObjectAttrProtected(int, RsiMaLength);
                     ObjectAttrProtected(ENUM_APPLIED_PRICE, RsiAppliedPrice);
public:
                     CSmartInvestRSI(CSmartInvestRSIParams *params) :
                     CSmartInvestV3(params),
                     mRsiUpperBound(params.GetRsiUpperBound()),
                     mRsiLowerBound(params.GetRsiLowerBound()),
                     mRsiTimeFrame(params.GetRsiTimeFrame()),
                     mRsiMaLength(params.GetRsiMaLength()),
                     mRsiAppliedPrice(params.GetRsiAppliedPrice())

   {
      if(!_iRSI.Create(mSymbol, mRsiTimeFrame, mRsiMaLength, mRsiAppliedPrice))
         ExpertRemove();
      _iRSI.Refresh();
   }
protected:

   CiRSI             _iRSI;
   double            _rsiValueCurrent, _rsiValuePrevious;

protected:
   virtual ENUM_DIRECTION     GetSignalFirstTrade() override;
   virtual void               DisplayExpertInfo() override;

public:
   virtual void       Main();
   virtual void       OnTrade_() {}
protected:
   virtual void       OnReInit() {}

};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSmartInvestRSI::Main()
{
   _iRSI.Refresh();

   _rsiValueCurrent = _iRSI.Main(1);
   _rsiValuePrevious = _iRSI.Main(2);

   CSmartInvestV3::Main();
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_DIRECTION CSmartInvestRSI::GetSignalFirstTrade() override
{
   if(_rsiValueCurrent > mRsiUpperBound) //&& _rsiValuePrevious <= mRsiUpperBound)
      return ENUM_DIRECTION_BEARISH;

   if(_rsiValueCurrent < mRsiLowerBound) //&& _rsiValuePrevious >= mRsiLowerBound)
      return ENUM_DIRECTION_BULLISH;

   return ENUM_DIRECTION_NEUTRAL;
}
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSmartInvestRSI::DisplayExpertInfo() override
{

   string space = "                                                                       ";
   string dashboard = space + "Information Dashboard";
   dashboard += "\n" + space + "Direction: " + EnumToString(_direction);
   dashboard += "\n" + space + "Current Gap: " + IntegerToString(_currentGap);
   dashboard += "\n" + space + "Number of Positions: " + IntegerToString(_sTradeDetails.totalPositions);
   dashboard += "\n" + space + "Next Volume: " + DoubleToString(CRiskService::GetVolumeBasedOnMartinGaleBatch(_sTradeDetails.totalPositions, mFactor, mSymbol, mLot, ENUM_TYPE_MARTINGALE_MULTIPLICATION));
   dashboard += "\n" + space + "DrawDown: " + DoubleToString(GetDrawDown());
   dashboard += "\n" + space + "Costs: " + DoubleToString(_sTradeDetails.totalCosts, 2);
   dashboard += "\n" + space + "GrossProfit: " + DoubleToString(_sTradeDetails.totalGrossProfit, 2);
   dashboard += "\n" + space + "Spread: " + IntegerToString(CSymbolInfo::GetSpread(mSymbol));
   dashboard += "\n" +space + "Prev Candle RSI Value: " + DoubleToString(_rsiValueCurrent, 2);
   Comment(dashboard);

  
}
//+------------------------------------------------------------------+
