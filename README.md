# Api for BTS Admin
API_BTS Admin is an API to get information from a database. Through the endpoints you can retrieve information for the different tables. Also you can use the HTTP methods like GET, POST, PUT and DELETE, to execute the actions that you need.
## Installation
To run the API we need to do some things first set the API settings and set the DB in your local.
#### Requirements
This API work over **Node.js**, version ``10.16.3``  
If  you don't have it, here is the link to download [Node.js](https://nodejs.org/es/)
  
### Steps
1. Download the repository. You need to clone the repo in your local, so paste this link in your CommandLine  
    ````
    https://gitlab.buetrailsoftware/api.git
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
## Scaffolding
   ![](scaffolding.PNG)
- ``config/`` **:** Main configuration of API
    - ``api.js`` **:** Define the router for the routes with functionality
    - ``constants.js`` **:** Environment variables, that we are using a along the app.
    - ``db.js`` **:** Settings for database connection
- ``daos/`` **:** All database methods.
    - ``exampleDao.js`` **:** SQL query for DB operation.  
- ``filters/`` **:** Middleware, general validators 
- ``models/`` **:** Database models
- ``resources/`` **:** Controllers for the different functions
- ``routers/`` **:** Routes for the files that are needed for the different functionality. API Routes
- ``services/`` **:** Files which consumes the Database
- ``test/`` **:** Test code for unit test
- ``utils/`` **:** Extra methods
- ``validationSchemas/`` **:** JSON schemas to validate the data
- ``README.md`` **:** Introductory text about the app
- ``index.js`` **:** Main file the runs and call the different functions
- ``loadenv.js`` **:** Loader for environment variables
- ``.env`` **:** File where we define the environment variables
- ``package.json`` **:** Dependencies for the project
