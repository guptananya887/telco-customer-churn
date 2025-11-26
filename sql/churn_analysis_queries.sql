-- ============================================================
-- CUSTOMER CHURN ANALYSIS - SQL QUERIES
-- ============================================================

-- Query 1: High-Risk Customer Identification
-- Purpose: Identify customers most likely to churn for targeted retention
SELECT 
    customerID,
    tenure,
    MonthlyCharges,
    CLV,
    Contract,
    ChurnProbability,
    RiskCategory,
    TotalServices
FROM customers
WHERE ChurnProbability > 0.7
  AND CLV > (SELECT AVG(CLV) FROM customers)
ORDER BY ChurnProbability DESC, CLV DESC
LIMIT 100;


-- Query 2: Churn Rate by Customer Segment
-- Purpose: Understand which segments have highest churn for strategy prioritization
SELECT 
    CASE 
        WHEN tenure < 6 THEN 'New (0-6 months)'
        WHEN tenure < 24 THEN 'Growing (6-24 months)'
        ELSE 'Established (24+ months)'
    END as customer_segment,
    COUNT(*) as total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2) as avg_monthly_charges
FROM customers
GROUP BY customer_segment
ORDER BY churn_rate_pct DESC;


-- Query 3: Revenue at Risk Analysis
-- Purpose: Calculate potential revenue loss from predicted churners
SELECT 
    RiskCategory,
    COUNT(*) as customer_count,
    ROUND(SUM(MonthlyCharges), 2) as monthly_revenue_at_risk,
    ROUND(SUM(MonthlyCharges * 12), 2) as annual_revenue_at_risk,
    ROUND(AVG(ChurnProbability) * 100, 2) as avg_churn_probability_pct
FROM customers
WHERE ChurnProbability > 0.5
GROUP BY RiskCategory
ORDER BY annual_revenue_at_risk DESC;


-- Query 4: Contract Type Impact on Churn
-- Purpose: Quantify the relationship between contract type and retention
SELECT 
    Contract,
    COUNT(*) as total_customers,
    ROUND(AVG(tenure), 1) as avg_tenure_months,
    ROUND(AVG(MonthlyCharges), 2) as avg_monthly_charges,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned_count,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_rate_pct,
    ROUND(SUM(CLV), 2) as total_clv
FROM customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;


-- Query 5: Service Usage vs Churn Correlation
-- Purpose: Understand if service engagement reduces churn
SELECT 
    TotalServices,
    COUNT(*) as customer_count,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2) as avg_monthly_charges
FROM customers
GROUP BY TotalServices
ORDER BY TotalServices;


-- Query 6: Payment Method Effectiveness
-- Purpose: Identify which payment methods correlate with lower churn
SELECT 
    PaymentMethod,
    COUNT(*) as customer_count,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_rate_pct,
    ROUND(AVG(tenure), 1) as avg_tenure_months,
    HasAutomaticPayment
FROM customers
GROUP BY PaymentMethod, HasAutomaticPayment
ORDER BY churn_rate_pct DESC;


-- Query 7: New Customer Onboarding Success
-- Purpose: Track churn in first 6 months to optimize onboarding
SELECT 
    CASE 
        WHEN IsNewCustomer = 1 THEN 'New Customer (0-6 months)'
        ELSE 'Established Customer (6+ months)'
    END as customer_type,
    COUNT(*) as total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_rate_pct,
    ROUND(AVG(TotalServices), 2) as avg_services_used
FROM customers
GROUP BY customer_type;


-- Query 8: Customer Value Segmentation with Risk
-- Purpose: Prioritize retention efforts by customer value and risk
SELECT 
    CustomerValue,
    RiskCategory,
    COUNT(*) as customer_count,
    ROUND(AVG(MonthlyCharges), 2) as avg_monthly_charges,
    ROUND(SUM(CLV), 2) as total_clv,
    ROUND(AVG(ChurnProbability) * 100, 2) as avg_churn_prob_pct
FROM customers
GROUP BY CustomerValue, RiskCategory
ORDER BY CustomerValue DESC, RiskCategory DESC;


-- Query 9: Retention Campaign Target List
-- Purpose: Generate actionable list for retention team
SELECT 
    customerID,
    tenure,
    Contract,
    MonthlyCharges,
    TotalServices,
    ChurnProbability,
    CASE 
        WHEN Contract = 'Month-to-month' AND ChurnProbability > 0.7 
            THEN 'Offer annual contract discount'
        WHEN TotalServices <= 2 AND ChurnProbability > 0.6 
            THEN 'Cross-sell additional services'
        WHEN HasAutomaticPayment = 0 AND ChurnProbability > 0.5 
            THEN 'Incentivize auto-payment'
        WHEN IsNewCustomer = 1 AND ChurnProbability > 0.6 
            THEN 'Enhanced onboarding support'
        ELSE 'General retention outreach'
    END as recommended_action
FROM customers
WHERE ChurnProbability > 0.5
ORDER BY ChurnProbability DESC, CLV DESC
LIMIT 500;


-- Query 10: Monthly Cohort Retention Analysis
-- Purpose: Track retention by tenure cohort for trend analysis
SELECT 
    tenure_group,
    COUNT(*) as total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2) as avg_monthly_revenue,
    ROUND(SUM(MonthlyCharges * 12), 2) as annual_revenue
FROM customers
WHERE tenure_group IS NOT NULL
GROUP BY tenure_group
ORDER BY 
    CASE tenure_group
        WHEN '0-12 months' THEN 1
        WHEN '12-24 months' THEN 2
        WHEN '24-48 months' THEN 3
        WHEN '48+ months' THEN 4
    END;
