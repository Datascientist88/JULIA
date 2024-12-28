abstract type FinancialInstrument end

struct Loan <: FinancialInstrument
	principal::Float64
	anual_rate::Float64
	years::Int
end

struct Investment <: FinancialInstrument
	initial_amount::Float64
	annual_rate::Float64
	years::Int
end

# Calculate monthly payment for a loan
function monthly_payment(loan::Loan)
    r = loan.annual_rate / 12 / 100
    n = loan.years * 12
    return loan.principal * r / (1 - (1 + r)^(-n))
end

# Calculate future value of an investment
function future_value(investment::Investment)
	return investment.initial_amount * (1 + investment.annual_rate / 100)^investment.years
end

# Calculate Net Present Value (NPV)
function npv(rate::Float64, cash_flows::Vector{Float64})
	npv_value = 0.0
	for (t, cash_flow) in enumerate(cash_flows)
		npv_value += cash_flow / (1 + rate)^t
	end
	return npv_value
end

# Calculate Internal Rate of Return (IRR)
function irr(cash_flows::Vector{Float64}; guess::Float64 = 0.1, tol::Float64 = 1e-5, max_iter::Int = 1000)
	rate = guess
	for _ in 1:max_iter
		f = npv(rate, cash_flows)
		f_prime = sum(-t * cash_flow / (1 + rate)^(t + 1) for (t, cash_flow) in enumerate(cash_flows))
		new_rate = rate - f / f_prime
		if abs(new_rate - rate) < tol
			return new_rate
		end
		rate = new_rate
	end
	error("IRR did not converge")
end

# Calculate Payback Period
function payback_period(cash_flows::Vector{Float64})
	cumulative_cash_flow = 0.0
	for (t, cash_flow) in enumerate(cash_flows)
		cumulative_cash_flow += cash_flow
		if cumulative_cash_flow >= 0
			return t - 1 + (0 - (cumulative_cash_flow - cash_flow)) / cash_flow
		end
	end
	return nothing  # Payback period not reached
end

# Create a Loan instance
my_loan = Loan(200000.0, 5.0, 30)

# Create an Investment instance
my_investment = Investment(10000.0, 7.0, 10)

# Calculate the monthly payment for the loan
println("Monthly Payment: $(monthly_payment(my_loan))")

# Calculate the future value of the investment
println("Future Value: $(future_value(my_investment))")

# Example cash flows for NPV and IRR
cash_flows = [-10000, 3000, 4200, 6800, 7200]

# Calculate NPV
println("NPV: $(npv(0.1, cash_flows))")

# Calculate IRR
println("IRR: $(irr(cash_flows))")

# Calculate Payback Period
println("Payback Period: $(payback_period(cash_flows))")