From: Wido den Hollander <wido@widodh.nl>
Subject: RGW object purging in upstream caches
Date: Tue, 22 Jan 2013 17:41:40 +0100
Message-ID: <50FEC144.2050304@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:33326 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671Ab3AVQln (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 11:41:43 -0500
Received: from [IPv6:2a00:f10:11c:ab:f0f8:2426:2a86:7bb3] (unknown [IPv6:2a00:f10:11c:ab:f0f8:2426:2a86:7bb3])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id 2E659435F4
	for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 17:41:40 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

(http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/12316)
 > Hopefully not Varnish-specific; something like the Last-Modified header
 > would be good.
 >
 > Also there are tricks you can do with queries; see for instance
 > http://forum.nginx.org/read.php?2,1047,1052

It seems like a good discussion to have, since more people are looking 
at this.

Yehuda started a thread in May last year about the future directions of 
the RGW: http://www.spinics.net/lists/ceph-devel/msg06257.html

To improve performance I still think using a proxy like Varnish or Nginx 
can help a lot.

Now, when running just one Varnish instance which does loadbalancing 
over multiple RGW instances is not a real problem. When it sees a PUT 
operation it can "purge" (called banning in Varnish) the object from 
it's cache.

When looking at the scenario where you have multiple caches you run into 
the cache-consistency problem. If an object is modified the caches are 
not notified and will continue to serve an outdated object.

Looking at the Last-Modified header is not an option since the cache 
will not contact RGW when serving out of it's cache.

To handle this there has to be some kind of "hook" inside RGW that can 
notify Varnish (or some other cache) when an object changes.

Is this something that's on the roadmap? Thoughts?

Wido
