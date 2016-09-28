<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFormsApplication.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="/js/twitter-text.js"></script>
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

            var cache = {};

            function loadtweets() {
                $('#loading').show(); //show loading text.. can be removed
                $.ajax({
                    url: "/Default.aspx/GetTwitterFeed",
                    data: {},
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (result) {
                        cache["top"] = result;
                       
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
                var json = $.parseJSON(result);
                for (var i = 0; i < json.length; i++) {
                    $("#results").append('<div class="tweet"><p><img src="' + json[i].user.profile_image_url_https + '" /><span><strong> - ' + json[i].user.name + '</span></strong><span>' + ' @' + json[i].user.screen_name + ' </span><br/><span>' + replaceURLWithHTMLLinks(json[i].text) + ' </span>' + ' (' + json[i].retweet_count + ')' + '</p>');

                    try {
                        for (var j = 0; j < json[i].entities.media.length; j++) {
                            $("#results").append('<a href="' + json[i].entities.media[j].media_url + '" ><img src="' + json[i].entities.media[j].media_url + ':thumb" /></a>');
                        }

                    } catch (e) {
                    }
                }
            }

            function replaceURLWithHTMLLinks(text) {
                var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
                return text.replace(exp, "<a href='$1'>$1</a>");
            }

            $("#find").click(function () {
                document.getElementById("results").innerHTML = "";
                $("#results").empty();
                var query = document.getElementById('query').value ; //seach query
                var tweets = cache["top"]; //cached top 10 tweets
                var json = $.parseJSON(tweets);
                for (var i = 0; i < json.length; i++) {
                    //profile_image_url
                    if (json[i].text.indexOf(query) !== -1) {
                    $("#results").append('</br><img src="' + json[i].profile_image_url + '" /></a></br>');
                    $("#results").append('<div class="tweet"><p><span><strong> - ' + json[i].user.name + '</span></strong><span>' + ' @' + json[i].user.screen_name + ' </span><br/><span>' + json[i].text + ' </span>' + ' (' + json[i].retweet_count + ')' + '</p>');

                    try {
                        for (var j = 0; j < json[i].entities.media.length; j++) {
                            $("#results").append('<a href="' + json[i].entities.media[j].media_url + '" ><img src="' + json[i].entities.media[j].media_url + ':thumb" /></a>');
                        }

                    } catch (e) {
                    }
                }
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div id="loading">Loading...</div> 
    <div >
        <input type="text" id="query"/>
        <button id="find"> Find </button>
    </div>
    <div id="results" />
    </form>
</body>
</html>
