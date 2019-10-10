# Api for BTS Admin
API_BTS Admin is an API to get information from a database. Through the endpoints you can retrieve information for the different tables. Also you can use the HTTP methods like GET, POST, PUT and DELETE, to execute the actions that you need.
## Installation
To run the API we need to do some things first set the API settings and set the DB in your local.
#### Requirements
This API work over **Node.js**, version ``10.16.3``, and npm version ``6.9.0``  
If  you don't have it, here is the link to download [Node.js](https://nodejs.org/es/)
  
### Steps
1. Download the repository. You need to clone the repo in your local, so paste this command in your CommandLine  
    ````
    git clone git@gitlab.bluetrail.software:bts-platform/bts_internship_2019_be_app.git
    ````
2. Go to the project folder.  
3. Run the  command ``npm install`` in your command line.
4. Create the ``.env`` file to set your environment variables, use the ``.env.default.example`` file to know about what you need. The api now is ready to be executed
5. Now, got the folder **DB** and run the script ``BTSAdminSchema.sql``
6. Run the ``BTSAdmin.sql``   

Now you have the API ready.
## First use
1. Open your console inside the project folder.
2. Start the application using this command: ```node index.js```.
3. Make a request. paste the next endpoint in your browser.  
    ````
    http://localhost:3000/api/employees/
    ````
   You have to receive a JSON with the information of all employees in database

## Endpoints
The different endpoints for database are build in the next form:  
````
http://localhost/api/table-name
````
## Testing 
To run the tests for the API, open a new terminal and type the next code, ``npm run test``.  
This will run the test for the index.js, that means for all the endpoints of API.
