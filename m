From: Wido den Hollander <wido@42on.com>
Subject: Re: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 19:43:27 +0100
Message-ID: <183263292.17021.1424976208041.open-xchange@websrv.42on.com>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net> <54EF008C.2050706@42on.com> <107057245.16991.1424972320227.open-xchange@websrv>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:36661 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbbBZSna convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 13:43:30 -0500
In-Reply-To: <107057245.16991.1424972320227.open-xchange@websrv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



> Op 26 feb. 2015 om 18:22 heeft Sage Weil <sweil@redhat.com> het volgende geschreven:
> 
>> On Thu, 26 Feb 2015, Wido den Hollander wrote:
>>> On 25-02-15 20:31, Sage Weil wrote:
>>> Hey,
>>> 
>>> We are considering switching to civetweb (the embedded/standalone rgw web
>>> server) as the primary supported RGW frontend instead of the current
>>> apache + mod-fastcgi or mod-proxy-fcgi approach.  "Supported" here means
>>> both the primary platform the upstream development focuses on and what the
>>> downstream Red Hat product will officially support.
>>> 
>>> How many people are using RGW standalone using the embedded civetweb
>>> server instead of apache?  In production?  At what scale?  What
>>> version(s) (civetweb first appeared in firefly and we've backported most
>>> fixes).
>>> 
>>> Have you seen any problems?  Any other feedback?  The hope is to (vastly)
>>> simplify deployment.
>> 
>> It seems like Civetweb listens on 0.0.0.0 by default and that doesn't seem
>> safe to me.
> 
> Can you clarify?  Is that because people may inadvertantly run this on a 
> public host and not realize that the host is answering requests?
> 

Yes, mainly. I think we should encourage users to run Apache, Nginx or Varnish as a proxy/filter in front.

I'd just suggest to bind on localhost by default and let the user choose otherwise.

> If we move to a world where this is the default/preferred route, this 
> seems like a good thing.. if they don't want to respond on an address they 
> can specify which IP to bind to?
> 

Most services listen on localhost unless specified otherwise.

>> In most deployments you'll put Apache, Nginx or Varnish in front of RGW to do
>> the proper HTTP handling.
>> 
>> I'd say that Civetweb should listen on 127.0.0.1:7480/[::1]:7480 by default.
>> 
>> And make sure it listens on IPv6 by default :-)
> 
> Yeah, +1 on IPv6:)
> 
> sage
> 
> 
>> 
>> Wido
>> 
>>> Thanks!
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
