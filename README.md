
<!-- Shields -->
![](https://img.shields.io/badge/Rails-5.2.6-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)


![Gone Hiking](https://highcountry.guide/wp-content/uploads/2018/11/backpackers-hiking_0.jpg)
<!-- TABLE OF CONTENTS -->
<summary><h2 style="display: inline-block">Table of Contents</h2></summary>
<ol>
  <li><a href="#about-the-project">About The Project</a>
  <li><a href="#project-board">Project Board</a></li>
  <li><a href="#database-schema">Database Schema</a></li>
  <li><a href="#built-with">Built With</a>
  <li><a href="#setup-instructions">Setup Instructions</a></li>
  <li><a href="#contact">Contact</a></li>
  <li><a href="#acknowledgements">Acknowledgements</a></li>
</ol>

<!-- ABOUT THE PROJECT -->
## About The Project

[Gone Hiking](https://gone-hiking.herokuapp.com/) is an API that allows users to request national parks from across the US or from within each state. Users can also limit the results to those parks without entrance fees and sort alphabetically.

### Key Points
* Users can be created and are assigned an API key at creation.
* Continuous integration via Travis CI
* Consumes National Park Service API
* Deployed API on [Heroku](https://gone-hiking.herokuapp.com/)

<!-- DATABBASE SCHEMA -->
## Database Schema

### Users
#### emails, API key, password, timestamps
#### (I used the bcrypt gem so the passwords are encrypted and not directly linked with the user.)

### Searches
#### user_id, text, timestamps
#### Searches must be case sensitively unique for each user.  In the future, I would change this from a validation at the time of creation to a validation at the model level that could be called whenever desired.  I would further add functionality that would allow for all searches to be pulled by user as well as all searches across the board--probably as a hash: "search_text" => Number.

<!-- BUILT WITH -->
## Built With

* [Ruby on Rails](https://rubyonrails.org/)
* [Postgresql](https://www.postgresql.org/)
* [National Parks Service API](https://developer.nps.gov)


<!-- SETUP INSTRUCTIONS -->
## Setup Instructions
To get a local copy up and running follow these simple steps.

1. Clone the repo
   ```
   git clone https://github.com/kaiheiongaku/gone_hiking
   ```
2. Install dependencies
   ```
   bundle install
   ```
3. DB creation/migration
   ```
   rails db:create
   rails db:migrate
   ```
3. Run tests and view test coverage
   ```
   bundle exec rspec
   open coverage/index.html
   ```
4. Run server and navigate to http://localhost:3000/
   ```
   rails s
   ```
5. Visit http://www.postman.com to try different requests (listed below).

OR

1. Visit Postman and send requests to:
   ```
   https://gone-hiking.herokuapp.com/
   ```

## API Endpoints
** Prepend URLs with https://gone-hiking.herokuapp.com/ if not running locally.

### PARKS
* get '/api/v1/parks'

Pulls the first 50 of all parks from the NPS.

__The following query parameters are available:__
* state

Pulls parks for a particular state with a default limit of 50.   
Example: get '/api/v1/parks?state=wv'  
Note: The API can handle both different capitalizations and periods for the
state abbreviations. Both WV and w.v. are valid.

* limit

Changes the number of parks returned.  
Example: get '/api/v1/parks?limit=200'

* alphasort

Sorts alphabetically by name.  
Example: '/api/v1/parks?alphasort=true'  
Note: Do not use the alphasort parameter if not desired.  
Future versions will better handle this parameter.

* filterfee

Returns only parks with free entrance fees.  
Example: '/api/v1/parks?filterfee=true'  
Note: Do not use the filterfee parameter if not desired.  
Future versions will better handle this parameter.

Combinations are possible. Examples:
* get '/api/v1/parks?state=wv&limit=2'
* get '/api/v1/parks?filterfee=true&alphasort=true&limit=200'

Appropriate errors are returned for invalid parameters. For instance:
* get '/api/v1/parks?state=notAstate'
* get '/api/v1/parks?state=pl'
* get '/api/v1/notParks'

Attributes returned for each park:
* nps_id: National Park Service ID
* full_name: Full name of the park
* description: Brief description of the park
* phone_number: Office number for the park
* entrance_fee: The normal entrance fee for the park
* hours: Park hours
* description: broad description of hours for the park
    * exceptions (listed as an array of hashes)
      * exceptionHours
      * startDate
      * name
      * endDate
    * monday: hours for each day of the week
    * tuesday
    * wednesday
    * thursday
    * friday
    * saturday
    * sunday
* office_address: Physical address of the park office (not necessarily in park)
    * zip_code
    * state
    * city
    * street
* image: first image provided by the NPS
    * credit: source of photo
    * title: name of photo
    * action_description: Description of photo
    * location_caption: Additional description of photo
    * url: url where photo can be found
    (Note: The action description and the location caption are often
      interchangeable. NPS does not consistently label the type of writing.)
* weather_info: General weather information about the park
Sample output:
```
{
    "data": [
        {
            "id": "null",
            "type": "parks",
            "attributes": {
                "nps_id": "77E0D7F0-1942-494A-ACE2-9004D2BDC59E",
                "full_name": "Abraham Lincoln Birthplace National Historical Park",
                "description": "For over a century people from around the world have come to rural Central Kentucky to honor the humble beginnings of our 16th president, Abraham Lincoln. His early life on Kentucky's frontier shaped his character and prepared him to lead the nation through Civil War. The country's first memorial to Lincoln, built with donations from young and old, enshrines the symbolic birthplace cabin.",
                "phone_number": "2703583137",
                "entrance_fee": "0.00",
                "hours": {
                    "description": "The Memorial Building is open 9:00 am - 4:30 pm eastern time with a limited viewing area.  The Visitor Center and grounds of the Birthplace Unit are open 9:00 am - 5:00 pm eastern time with one-way traffic flow and social distancing.\n\n\nThe Boyhood Home Unit at Knob Creek will be closed August 3, 2020, to July 31, 2021, due to the Lincoln Tavern Rehabilitation Project.",
                    "exceptions": [
                        {
                            "exceptionHours": {},
                            "startDate": "2022-01-01",
                            "name": "Park is Closed",
                            "endDate": "2022-01-01"
                        },
                        {
                            "exceptionHours": {},
                            "startDate": "2021-11-25",
                            "name": "Park is Closed",
                            "endDate": "2021-11-25"
                        },
                        {
                            "exceptionHours": {},
                            "startDate": "2021-12-25",
                            "name": "Park is Closed",
                            "endDate": "2021-12-25"
                        }
                    ],
                    "monday": "9:00AM - 5:00PM",
                    "tuesday": "9:00AM - 5:00PM",
                    "wednesday": "9:00AM - 5:00PM",
                    "thursday": "9:00AM - 5:00PM",
                    "friday": "9:00AM - 5:00PM",
                    "saturday": "9:00AM - 5:00PM",
                    "sunday": "9:00AM - 5:00PM"
                },
                "office_address": {
                    "zip_code": "42748",
                    "state": "KY",
                    "city": "Hodgenville",
                    "street": "2995 Lincoln Farm Road"
                },
                "image": {
                    "credit": "NPS Photo",
                    "title": "The Memorial Building with fall colors",
                    "action_description": "The Memorial Building surrounded by fall colors",
                    "location_caption": "Over 200,000 people a year come to walk up the steps of the Memorial Building to visit the site where Abraham Lincoln was born",
                    "url": "https://www.nps.gov/common/uploads/structured_data/3C861078-1DD8-B71B-0B774A242EF6A706.jpg"
                },
                "weather_info": "There are four distinct seasons in Central Kentucky. However, temperature and weather conditions can vary widely within those seasons. Spring and Fall are generally pleasant with frequent rain showers. Summer is usually hot and humid. Winter is moderately cold with mixed precipitation."
            }
        },
        .....
    ]}
```

### USERS
Users can be created by sending email and password in the body via the parameters. For example:
```
headers = { 'ACCEPT' => 'application/json' }
params = { "user": {
          "email": "ilovehotels@example.com",
          "password": "H0t3l3ng1n3R0x",
          "password_confirmation": "H0t3l3ng1n3R0x"}
        }
post '/api/v1/users', params: params, headers: headers
```
Future versions will use the Devise gem.
Successful creation returns:
```
{
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "-O2CcCuRe8kafwtGfPUEfw"
        }
    }
}
```
Unsuccessful creation returns an appropriate error:
```
{
    "errors": "Missing password confirmation."
}
```

### SEARCHES
A search can be created by providing the text and the user as follows:
```
headers = { 'ACCEPT' => 'application/json' }
params = { "search": {
          "text": "pa",
          "user": @user1.id
          }
        }
post '/api/v1/searches', params: params, headers: headers
```
It is important to note that searches must be case sensitively unique to each
user.  Future versions will change this so that duplicate searches are not
forbidden but instead noted.

Successful creation returns:
```
{
    "data": {
        "id": "1",
        "type": "searches",
        "attributes": {
            "text": "pa",
            "user_id": 1
        }
    }
}
```
Unsuccessful creation returns an error:
```
"errors": [
     "Text has already been taken"
 ]
```

## Code Structure
A brief description of the data flow for a parks request.
1. Routes sends it to the Parks Controller.
2. The Parks Controller checks if there is a state parameter. If there is, it
is validated via the Application Controller (primarily the error handler).
3. The Parks Controller sends the request to the Parks Facade, which calls the
Parks Service.
4. The Parks Facade calls the Parks Service. The single responsibility of the Parks Service is to call the NPS API and return the data.
5. The Parks Service then returns it to the Parks Facade, which iterates over each park's data to prepare it for the controller.
6. The Park Plain Old Ruby Object (PORO)creates park objects with address, image, and hours objects as well.
7. The Parks Facade then returns the Park objects to the Parks Controller, which then sends all those objects to the Parks Serializer.
8. The Parks Serializer converts the objects to JSON, and the Parks Controller returns that JSON response.

## Lessons Learned

I find it important to record particular challenges and solutions found.
First, Travis CI presented me with a 'Bundler cannot be found. Add it to your
Gemfile' error. After some searching for ideas, I tried updating Rails,
Bundler, and others on my local machine.  I had assumed it meant 'my' Gemfile.
After reading my errors many times and rethinking my assumptions, I discovered
that it was the Gemfile on Travis' end.  I subsequently added a
'before_install' line in my .travis.yml and made a small platform change to
solve the issue.

Second, my app worked locally and passed all tests. However, when I first
uploaded it to Heroku, I was getting a 500 error from Postman.  By looking at
the Heroku logs, I noticed that '.map could not be called on nil class' in the
Parks Facade. After checking the app again locally, I had to rethink my
assumptions, eventually realizing that data coming into the app was not being
processed and that my API key was not being uploaded to Github (as intended).
I added the NPS API key to Heroku, which immediately fixed the issue.

Third, I reworked a previous project's user creation.  However, I recently
implemented the Devise gem in another project, and will use that in future prj.


<!-- CONTACT -->
## Contact
* [Robert Heath](robert.b.heathii@gmail.com) - robert.b.heathii@gmail.com

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [README template](https://github.com/othneildrew/Best-README-Template)
* [National Park Service](https://developer.nps.gov)
* Custom coded for: Kennedy Watson, Silas Rioux, Dinshaw Gobhai, and Collin Smith at Hotel Engine.
