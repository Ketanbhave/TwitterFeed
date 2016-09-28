### Twitter Feed Code Challenge - Salesforce

## Code Snippets:

The following code returns the raw json from Twitter API:

            var twit = new OAuthTwitterWrapper.OAuthTwitterWrapper();
            twit.GetMyTimeline();


## Notes
Currently it exposes timeline (twitter feed) , returned as raw json (which can be serialized into c#,).

The page reloads every 60 seconds making ajax request to get latest 10 tweets

The top 10 tweet json data in stored on client side cache (HTML - localstorage)

## Demo projects in GitHub

# Web application - csproj
This uses a page WebMethod to make the api call and an Ajax json request to display the tweets.
It could however be exposed in any kind of web service.

Default.aspx is main page loaded on this application which shows the latest 10 feeds and also a text box to enter seach query to filter within current tweets when 'Find' button is clicked

# oAuthTwitterWrapper - csproj
This is server side application used to:

1. Authenticating and wrapping twitter's API calls using the 1.1 API and OAuth.
2. Getting list of latest tweets from user timeline using GET statuses/user_timeline Twitter API. Link below:
            https://dev.twitter.com/rest/reference/get/statuses/user_timeline

