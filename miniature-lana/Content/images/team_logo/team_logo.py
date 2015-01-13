import requests
from bs4 import BeautifulSoup
from pprint import pprint
from urllib.parse import urljoin
from urllib.request import urlretrieve
import csv

# The base url for craigslist in New York
BASE_URL = 'http://lol.gamepedia.com/'

def scrape_NATeams():
    """ Scrape all the missed connections from a list """
    response = requests.get(BASE_URL + "Category:North_American_Teams")
    soup = BeautifulSoup(response.content)

    teams = soup.find("div", class_="mw-content-ltr").find_all("a")
    print(teams)

    # Get all the links to missed connection pages:
    for team in teams:
        link = team.get('href')
        url = urljoin(BASE_URL, link)       
        scrape_NATeam(url)

def scrape_NATeam(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.content)
    csvfile = 'C:/Python34/team_logo/team_logo.csv'
    if soup.select("div.center div.floatnone a img"):
##        print(soup.select("div.center div.floatnone a img")[0])
        img = soup.select("div.center div.floatnone a img")[0]
        path = r"C:\Python34\team_logo" "\\"
        with open(csvfile, "a") as output:
            print('test ' + img.get('alt'))
            writer = csv.writer(output, lineterminator = '\n')
            writer.writerow([img.get('alt')])
                    
##        urlretrieve(img.get('src'), path + str(img.get('alt')))
        
        data = {
            'img_url': img.get('src'),
            'img_alt': img.get('alt')
##        'subject': soup.find('h2', {'class':'postingtitle'}).text.strip(),
##        'body': soup.find('section', {'id':'postingbody'}).text.strip(),
##        'datetime': soup.find('time').attrs['datetime']
        }

    # Print it prettily. 
        pprint(data)

if __name__ == '__main__':
    scrape_NATeams()
