From: Wido den Hollander <wido@42on.com>
Subject: Re: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 12:16:28 +0100
Message-ID: <54EF008C.2050706@42on.com>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:36086 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbbBZLQb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 06:16:31 -0500
In-Reply-To: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-users@ceph.com, ceph-devel@vger.kernel.org



On 25-02-15 20:31, Sage Weil wrote:
> Hey,
>
> We are considering switching to civetweb (the embedded/standalone rgw web
> server) as the primary supported RGW frontend instead of the current
> apache + mod-fastcgi or mod-proxy-fcgi approach.  "Supported" here means
> both the primary platform the upstream development focuses on and what the
> downstream Red Hat product will officially support.
>
> How many people are using RGW standalone using the embedded civetweb
> server instead of apache?  In production?  At what scale?  What
> version(s) (civetweb first appeared in firefly and we've backported most
> fixes).
>
> Have you seen any problems?  Any other feedback?  The hope is to (vastly)
> simplify deployment.
>

It seems like Civetweb listens on 0.0.0.0 by default and that doesn't 
seem safe to me.

In most deployments you'll put Apache, Nginx or Varnish in front of RGW 
to do the proper HTTP handling.

I'd say that Civetweb should listen on 127.0.0.1:7480/[::1]:7480 by default.

And make sure it listens on IPv6 by default :-)

Wido

> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
