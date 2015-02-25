From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 09:15:36 +1100
Message-ID: <CA+z5DsxhMDdbq5wR0LP5=y2j-39t6xU89et45w+e=Dwn5=+O8w@mail.gmail.com>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:39371 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbBYWP6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 17:15:58 -0500
Received: by lbvn10 with SMTP id n10so7048204lbv.6
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 14:15:57 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph-User <ceph-users@ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>

It'd be nice to see a standard/recommended LB and HA approach for RGW
with supporting documentation too.

On 26 February 2015 at 06:31, Sage Weil <sweil@redhat.com> wrote:
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
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
~Blairo
