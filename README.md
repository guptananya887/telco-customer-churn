# telco-customer-churn

# Customer Churn Prediction & Retention Strategy

An end-to-end machine learning project that predicts customer churn with actionable business insights. Built a Random Forest model achieving 79.4% accuracy, identified $1.3M in annual revenue at risk, and developed targeted retention strategies with quantified ROI.

## Business Problem

A telecommunications company with 26.5% annual customer churn rate needs to identify at-risk customers, understand churn drivers, and prioritize retention efforts for maximum impact.

## Key Results

- Identified 1,392 high/medium-risk customers representing $1.3M in annual revenue at risk
- Month-to-month contracts show 42.7% churn vs 2.8% for two-year contracts
- New customers (0-6 months tenure) have 47.7% churn rate vs 9.5% for established customers
- Customers using automatic payments have 50% lower churn than manual payment users
- Developed four retention strategies with $393K potential annual savings (30% churn reduction scenario)

## Technical Approach

**Data Analysis:**
- Analyzed 7,043 customer records with 21 features
- Cleaned and transformed telecom customer data
- Created features: Customer Lifetime Value, service engagement metrics, customer segments

**Machine Learning Model:**
- Algorithm: Random Forest Classifier
- Performance: 79.4% accuracy, 0.839 ROC-AUC, 64.7% precision
- Top predictors: Price per service (21%), contract type (16%), tenure (13%), monthly charges (12%)

**Business Intelligence:**
- Developed 10 SQL queries for customer segmentation and risk analysis
- Created interactive Tableau dashboard for executive reporting
- Generated prioritized retention campaign target lists


**Requirements:**
- Python 3.8+
- Jupyter Notebook
- Libraries: pandas, numpy, scikit-learn, matplotlib, seaborn


## Methodology

**1. Exploratory Data Analysis**
- Analyzed churn patterns across contract types, tenure groups, and service usage
- Identified correlation between service engagement and retention
- Discovered significant churn concentration in first 6 months

**2. Feature Engineering**
- Customer Lifetime Value: tenure multiplied by monthly charges
- Service engagement: count of active services per customer
- Customer segments: new vs established, high vs low value
- Binary indicators: automatic payment, internet service status

**3. Model Development**
- Train/test split: 80/20 with stratification
- Random Forest with 100 trees, max depth 10
- Evaluated using accuracy, precision, recall, ROC-AUC
- Generated churn probability scores for risk segmentation

**4. Business Recommendations**

Developed four targeted retention strategies:

**New Customer Onboarding (835 at-risk customers)**
- Enhanced onboarding and early engagement program
- Projected annual savings: $702K

**Contract Upgrade Campaign (1,391 month-to-month customers at risk)**
- Incentivize annual/two-year contract adoption
- Projected annual savings: $1.3M

**Service Cross-Sell (636 low-engagement customers at risk)**
- Increase product adoption and engagement
- Projected annual savings: $480K

**Payment Method Migration (1,197 manual payment users at risk)**
- Promote automatic payment enrollment
- Projected annual savings: $1.1M

## SQL Analysis

Created operational queries for business teams:
- High-risk customer identification and prioritization
- Revenue at risk by customer segment
- Churn rate analysis by contract, tenure, and payment method
- Customer value segmentation for targeted campaigns
- Retention program performance tracking

Full queries available in `sql/churn_analysis_queries.sql`

## Visualizations

Interactive Tableau dashboard includes:
- Executive KPIs: total customers, churn rate, revenue at risk, potential savings
- Churn analysis by contract type and customer tenure
- Risk distribution across customer base
- Drill-down capability for segment-level insights

Dashboard link: [Tableau Public - Coming Soon]

## Model Performance

**Classification Metrics:**
- Accuracy: 79.35%
- ROC-AUC: 0.839
- Precision: 64.66%
- Recall: 48.93%

**Business Impact:**
- Correctly identified 183 churners for retention outreach
- Missed 191 churners (opportunity for model improvement)
- 100 false positives (acceptable given retention campaign costs)


## Contact

Ananya Gupta  
Data Analyst  
guptananya887@gmail.com
