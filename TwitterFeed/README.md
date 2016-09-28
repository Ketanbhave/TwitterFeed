#oAuthTwitterWrapper - csproj
This provides a really simple solution to authenticating and wrapping twitter's API calls using the 1.1 API and OAuth.

##Quick installation instructions:

The following code returns the raw json from Twitter API:

            var twit = new OAuthTwitterWrapper.OAuthTwitterWrapper();
            twit.GetMyTimeline();


#Notes
Currently it exposes timeline (twitter feed) , returned as raw json (which can be serialized into c#,).



## Demo projects in GitHub


### Web application 
This uses a page WebMethod to make the api call and an Ajax json request to display the tweets.
It could however be exposed in any kind of web service.

