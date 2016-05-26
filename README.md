# Mock Prescriptions Api

Fake data to create a simple, mock API to separate front end and backend dependencies during development.

All the data used in this repo started out as fake data not belonging to any real user or user identifier.  I then took out any parts that could even be construed as being real to avoid any potential confusion.  

##How to use:

- Install Ruby 2.3. (It is suggested to use a Ruby version manager such as [rbenv](https://github.com/rbenv/rbenv#installation) and then to [install Ruby 2.3](https://github.com/rbenv/rbenv#installing-ruby-versions)).

Clone the repo
```
git clone https://github.com/department-of-veterans-affairs/mock-prescriptions-api.git
```

Start the server:

```
cd mock-prescriptions-api
ruby server.rb
```


Go to localhost:3004. You should get a list of the routes available for use with this mock API. These are:

- History for a user: /rx/v1/history
- Prescription status for a user: /rx/v1/prescription
- Prescription status for a specific prescription (id = 1435525): /rx/v1/prescription/1435525
- Tracking for a specific prescription (id = 1435525)": "/rx/v1/tracking/1435525

Go to any of these routes (for example localhost:3004/rx/v1/history) to get a json response that will match the format you will receive from the real API. 