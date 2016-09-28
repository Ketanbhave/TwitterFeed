# Twitter Feed Code Challenge - Salesforce

## Assumptions 

1. Every time user enters a search query, only the tweets which contain the seach string in its tweet as show. Rest are hidden. This search query is Case insenstive

2. The no of times a tweet has been retweeted in shown in bracket next t theo tweet text for e.g. (6) indicates 6 retweets

3. Every 60 seconds the screen refreshes with the latest tweets from Server and the searh query and text box are cleared.


## Demo projects in GitHub

### Web application - csproj
This project uses method getTwitterfeed make the api call and an Ajax json request to display the tweets.

Default.aspx - is main page loaded on this application which shows the latest 10 feeds and also a text box to enter seach query to filter within current tweets when 'Find' button is clicked

Web.config file contains appsettings which have ConsumerKey, ConsumerSecret, OAuth url used to get token from Twitter. It also has timelineurlformat which has filters like screen_name, tweet count, include retweets, exclude replies etc. As per current requirement screen name is salesforce and count is 10. 

### oAuthTwitterWrapper - csproj
This is server side application used to:

1. Authenticating and wrapping twitter's API calls using the 1.1 API and OAuth.
2. Getting list of latest tweets from user timeline using GET statuses/user_timeline Twitter API. Link below:
            https://dev.twitter.com/rest/reference/get/statuses/user_timeline


TimeLine.cs - Class has been created to serialize and store the json object retrieved from twitter API in c# server side, if needed.

Authenticate.cs - Class contains AuthenticateMe() method which is used to authenticate given user and get token.

Utitlity.cs - The RequstJson method in Utility class adds the AccessToken recieved on Authorization to make API call.

OAuthTwitterWrapper.cs -  Class contains GetMyTimeline() which is used to get json result from twitter API

### Technologies Used:

Server Side: C#
Client Side: HTML, Javascript, JQuery

## Code Snippets:

The following code refreshes the page every 60 seconds by making Ajax call to get latest tweets:

                 setInterval(function () { 
                    loadtweets(); // this will refresh page after every 60 seconds with latest tweets
                 }, 60000 


The following code returns the raw json from Twitter API to Web Application:

              var twit = new OAuthTwitterWrapper.OAuthTwitterWrapper();
              twit.GetMyTimeline();


## Notes

1. Currently it exposes timeline (twitter feed) , returned as raw json (which can be serialized into c#, if needed).

2. The page reloads every 60 seconds making ajax request to get latest 10 tweets

3. The top 10 tweet json data in stored on client side cache (HTML - localstorage)

4. We are showing 'Loading..' text every time page is refreshed from server side. This can be removed and is added for demo purpose only

5. function replaceURLWithHTMLLinks is used to replace text url with html hyperlinks (href)

6. test.json contains sample json returned from GET statuses/user_timeline Twitter API
