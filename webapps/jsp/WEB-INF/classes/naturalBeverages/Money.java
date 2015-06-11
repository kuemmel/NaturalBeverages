/**
 * Money in NaturalBeverages Project
 * represents math of currency.
 **/

import java.math.BigDecimal;

public class Money
{
	BigDecimal value;

	public Money(String value)
	{
		this.value = new BigDecimal(value);
	}

	public Money(double value)
	{
		value = Math.round(value*100.0)/100.0;
		this.value = new BigDecimal(String.valueOf(value));
	}

	public Money(BigDecimal value)
	{
		this.value = value;
	}

	public Money add(Money value)
	{
		return new Money(this.value.add(value.getValue()));
	}

	public Money multiply(Money value)
	{
		return new Money(this.value.multiply(value.getValue()));
	}
	
	public Money subtract(Money value)
	{
		return new Money(this.value.subtract(value.getValue()));
	}
	/**
	 * @arg percentage - percentage as in 0-1
	 * @return the percentage of the value of this object
	 */
	public BigDecimal getPercentage(BigDecimal percentage)
	{
		BigDecimal result = this.value.multiply(percentage);
		return result.divide(new BigDecimal("100"),BigDecimal.ROUND_HALF_EVEN);
	}

	public BigDecimal getValue()
	{
		return this.value;
	}

	@Override
	public String toString()
	{
		return String.valueOf(this.value)+"\u20AC";
	}


}