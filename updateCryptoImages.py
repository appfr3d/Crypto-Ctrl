from urllib.request import urlopen as uReq
from bs4 import BeautifulSoup as soup
import json

myUrl = 'https://coinmarketcap.com/' # coins/views/all/'
data = []
# myList = [] # name = string which is id, id = number which is image number

for i in range(1,10):
	# Opening up the connection and graps the page
	uClient = uReq(myUrl + str(i))

	# reads the page into a variable
	pageHTML = uClient.read()

	# closes the connection
	uClient.close()

	print('downloaded')

	# html parsing
	pageSoup = soup(pageHTML, 'html.parser')

	print('parsed')

	page = pageSoup.prettify()

	images = pageSoup.findAll('img', {'class': 'currency-logo-sprite'})
	# names = images.get('alt')
	# links = images.get('src')



	for img in images:
		# if str(img).startswith('https://files'):
		coin = {}
		coin['name'] = img.get('alt')
		coin['id'] = img.get('src').replace('https://files.coinmarketcap.com/static/img/coins/16x16/', '').replace('.png','')
		data.append(coin)
		# print('\n' + img.get('alt'))
		# print(img.get('src'))


with open('cryptoImageData.json', 'w') as outfile:
	json.dump(data, outfile, ensure_ascii=False, indent=4, sort_keys=True)

# print(data)


# for line in page:
#	print(line)

# for link in pageSoup.findAll('img'):
# 	# if str(link.get('src')).startswith('https://files'): # files.coinmarketcap.com/static/img/coins/16x16/
# 	print(link.get('src'))


# div = pageSoup.find('div',{'class':'container'})
# # print(poup.prettify())

# row = div.div.find('div', {'class':'row'})

# if row:
# 	print('hei')

# table = pageSoup.find('table', {'class': 'table dataTable no-footer'})

# tbody = table.find('tbody')

# containers = tbody.findAll('tr')

# # find all images
# images = containers.findAll('img') # , {'class':'currency-logo-sprite'}

# # myList = [x['src'] for x in pageSoup.findAll('img', {'class':'currency-logo-sprite'})]
# for i in range(1,len(images)):
# 	print(images[i])





