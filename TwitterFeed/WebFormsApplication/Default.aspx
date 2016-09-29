<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFormsApplication.Default" %>

<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
    <title></title>
    <script type="text/javascript">
        $(function () {
            // debugger;
            $(document).ready(function () {
                loadtweets(); // This will get tweets on page load
                setInterval(function () {
                    loadtweets(); // this will run after every 60 seconds
                }, 60000);
            });

           
            function loadtweets() {
                $('#loading').show(); //show loading text.. can be removed
                $.ajax({
                    url: "/Default.aspx/GetTwitterFeed",
                    data: {},
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                         
                        if (result.hasOwnProperty("d")) {
                            bindTweets(result.d);
                        }
                        else {
                            bindTweets(result);
                        }

                    },
                    complete: function(){
                        $('#loading').hide();
                    },
                    error: function (xhr, status) {
                        alert(status + " - " + xhr.responseText);
                    }
                });
            }

            function bindTweets(result) {
                $("#results").empty();
                document.getElementById('query').value = "";
                //saving in cache
                localStorage.setItem("tweets", result);
                var json = $.parseJSON(result);
                for (var i = 0; i < json.length; i++) {
                    $("#results").append('<div id = "tweet'+ i +'" ><p><img src="' + json[i].user.profile_image_url_https + '" /><span><strong> - ' + json[i].user.name + '</span></strong><span>' + ' @' + json[i].user.screen_name + ' </span><br/><span>' + replaceURLWithHTMLLinks(json[i].text) + ' </span>' + ' (' + json[i].retweet_count + ')' + '</p>');

                    try {
                        for (var j = 0; j < json[i].entities.media.length; j++) {
                            $("#tweet" + i).append('<a href="' + json[i].entities.media[j].media_url + '" ><img src="' + json[i].entities.media[j].media_url + ':thumb" /></a>');
                        }

                    } catch (e) {
                    }
                }
            }

            //used to replace hyperlink in tweet
            function replaceURLWithHTMLLinks(text) {
                var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
                return text.replace(exp, "<a href='$1'>$1</a>");
            }

            $("#find").click(function () {
                var query = document.getElementById('query').value; //seach query
                var tweets = localStorage.getItem("tweets"); //cached top 10 tweets
                var json = $.parseJSON(tweets);
                for (var i = 0; i < json.length; i++) {
                    var divid = "#tweet" + i;
                    if (json[i].text.toUpperCase().indexOf(query.toUpperCase()) !== -1) {// tweet contains query
                        //alert(divid + "found");
                        $(divid).css("display", "block");
                     } else {
                        //dont display tweets which do not contain the query
                        $(divid).css("display", "none");
                      
                    }
                }
            });
        });
    </script>
</head>
<body>
    <div>
        <input type="text" id="query"/>
        <button id="find"> Find </button>
    </div>
    <div id="loading">Loading...</div> 
    <div id="results" />
</body>
</html>
