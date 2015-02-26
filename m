From: Sage Weil <sweil@redhat.com>
Subject: Re: AW: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 11:15:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502261112500.25838@cobra.newdream.net>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net> <1dc4d01d051f2$febae0e0$fc30a2a0$@dunkel.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1825081174-1424978129=:25838"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34690 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825AbbBZTPg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 14:15:36 -0500
In-Reply-To: <1dc4d01d051f2$febae0e0$fc30a2a0$@dunkel.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Axel Dunkel <ad@dunkel.de>
Cc: ceph-users@ceph.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1825081174-1424978129=:25838
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi Axel,

On Thu, 26 Feb 2015, Axel Dunkel wrote:
> Sage,
> 
> we use apache as a filter for security and additional functionality
> reasons. I do like the idea, but we'd need some kind of interface to
> filter/modify/process requests.

Civetweb has some basic functionality here:

	https://github.com/sunsetbrew/civetweb/blob/master/README.md#overview

Notably, "URL rewrite, file blacklist, IP-based ACL" and "Download speed 
limit based on client subnet or URI pattern" fall into the category of 
stuff I'd expect people to be doing with Apache.  Does this cover what 
you're after, or can you be more specific about what you need to do?

Also, for cases where we don't natively do something, would running 
something like nginx or apache in a proxying mode do the trick?

sage


> 
> Best regards
> Axel Dunkel
> 
> -----Ursprüngliche Nachricht-----
> Von: ceph-devel-owner@vger.kernel.org
> [mailto:ceph-devel-owner@vger.kernel.org] Im Auftrag von Sage Weil
> Gesendet: Mittwoch, 25. Februar 2015 20:32
> An: ceph-users@ceph.com; ceph-devel@vger.kernel.org
> Betreff: who is using radosgw with civetweb?
> 
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
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--557981400-1825081174-1424978129=:25838--
