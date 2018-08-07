import pandas as pd
np = pd.np

def get_avg_gas_price():
	data = []
	with open('export-AvgGasPrice.csv', 'r') as f:
		for line in f:
			line = line.strip()
			line = line.replace('"', '')
			data.append(line.split(","))
	df = pd.DataFrame(data[1:],columns=data[0])
	df['Value'] = df['Value'].astype(np.float64) / 1000000000000000000.
	return df

def get_fee_stats(last_n_days=200): 
	df = get_avg_gas_price()
	prices = df['Value'].iloc[-last_n_days:]
	max_gas_price = prices.max()
	average_gas_price = prices.mean()
	std_gas_price = prices.std()
	return max_gas_price, average_gas_price, std_gas_price

if __name__ == '__main__':
	m, a, s = get_fee_stats()
	print(a + 4 * s)


