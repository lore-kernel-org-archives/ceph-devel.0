From: Wido den Hollander <wido@42on.com>
Subject: Returning the bucket name in RGW response
Date: Wed, 06 Nov 2013 20:33:42 +0100
Message-ID: <527A9996.8050402@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:38979 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885Ab3KFTdo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Nov 2013 14:33:44 -0500
Received: from [79.99.132.138] (unknown [79.99.132.138])
	by websrv.42on.com (Postfix) with ESMTPSA id 90A89BF764
	for <ceph-devel@vger.kernel.org>; Wed,  6 Nov 2013 20:33:42 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm working on a RGW setup where I'm using Varnish[0] to cache objects, 
but when doing so you run into the problem that a lot of (cached) 
requests will not reach the RGW itself so the accounting of traffic 
isn't correct.

To overcome this I've been sending all the logs from Varnish to 
Logstash[1] and into ElasticSearch and afterwards analyzing the logs in 
ElasticSearch to find out how much traffic each bucket did.

This method works, but it isn't safe enough. Since I'm currently parsing 
the "Host" header to find out which bucket it was, but this isn't always 
safe since users can CNAME.

So I've been playing with the idea to add the "Rgwx-bucket" header to 
each response which tells you which bucket the request was made to.

In Varnish I can catch this response header and send it to Logstash so I 
have a safer method of which requests was done by which bucket.

I'm using Varnish, but you could do the same with nginx or any HTTP 
caching proxy.

Would it be an idea to add this to RGW? I have it running on my system 
and it works fine, but it's currently a bit hacky.

A config variable like "rgw expose bucket" could be false by default, 
but when set to true RGW would send the response header with the bucket 
name.

How does this sound?

P.S.: When this is all up and running I'm planning to make a cool 
presentation about this for the next Ceph day.

[0]: http://www.varnish-cache.org/
[1]: http://www.logstash.net/

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
