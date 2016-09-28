using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace OAuthTwitterWrapper.JsonTypes
{

    public class TimeLine
    {
        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("screenname")]
        public string screen_name { get; set; }

        [JsonProperty("text")]
		public string Text { get; set; }

		[JsonProperty("retweet_count")]
		public int RetweetCount { get; set; }

        
    }

}
