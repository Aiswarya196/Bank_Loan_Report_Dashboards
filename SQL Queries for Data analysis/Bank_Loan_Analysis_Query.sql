select * from bank_loan_data

select COUNT(id) as Total_Loan_Applications from bank_loan_data

SELECT COUNT(id) AS MTD_Total_Loan_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = (
        SELECT MAX(MONTH(issue_date)) FROM bank_loan_data
    )
  AND YEAR(issue_date) = (
        SELECT MAX(YEAR(issue_date)) FROM bank_loan_data
    );

SELECT COUNT(id) AS PMTD_Total_Loan_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = MONTH(DATEADD(month, -1, (SELECT MAX(issue_date) FROM bank_loan_data)))
  AND YEAR(issue_date)  = (SELECT YEAR(MAX(issue_date)) FROM bank_loan_data);

select sum(loan_amount) as Total_Funded_Amount from bank_loan_data

select sum(loan_amount) as MTD_Total_Funded_Amount from bank_loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021


select sum(loan_amount) as PMTD_Total_Funded_Amount from bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)=2021

select sum(total_payment) as Total_Amount_Received from bank_loan_data

select sum(total_payment) as MTD_Total_Amount_Received from bank_loan_data
where MONTH(issue_date)=12 and YEAR(issue_date)=2021

select sum(total_payment) as MTD_Total_Amount_Received from bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)=2021

select Round(AVG(int_rate) *100 , 2) as PMTD_Avg_Interest_Rate from bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)=2021

select Round(AVG(dti)*100,2) as PMTD_Avg_DTI from bank_loan_data
where MONTH(issue_date)=11 and YEAR(issue_date)=2021

USE [BankLoan DB];
GO

Select distinct(loan_status) from bank_loan_data


SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

select COUNT(id) AS Bad_Loan_Applications
FROM bank_loan_data
where loan_status = 'Charged Off'

select sum(loan_amount) as Bad_Loan_Funded_Amount from bank_loan_data
where loan_status = 'Charged Off'

select sum(total_payment) as Bad_Loan_Amount_Received from bank_loan_data
where loan_status  = 'Charged Off'


SELECT
        loan_status,
        COUNT(id) AS Total_Loan_Applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status


SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

SELECT 
	address_state, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state


SELECT 
	term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term


SELECT 
	emp_length as Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

USE [BankLoan DB];
GO

SELECT 
	purpose as Purpose, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

SELECT 
	home_ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC