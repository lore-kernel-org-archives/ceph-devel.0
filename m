From: Sage Weil <sage@inktank.com>
Subject: Re: rgw quota
Date: Mon, 23 Sep 2013 16:11:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309231602470.7394@cobra.newdream.net>
References: <CABBk=J_XYE8Pz7ZDLATVaw9atniZjZmJgv2FiEMmN3xZEp6RBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35653 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3IWXLH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 19:11:07 -0400
In-Reply-To: <CABBk=J_XYE8Pz7ZDLATVaw9atniZjZmJgv2FiEMmN3xZEp6RBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 23 Sep 2013, Yehuda Sadeh wrote:
> Real short description of rgw quota feature implementation as was discussed:
> 
> 1. Implement per-bucket quota
> 
>  - we already have a per-bucket total info
>  - cache per-bucket info in rgw
>  - define per-bucket max (can set default per system, per user, per bucket)
>  - define a threshold for which operations are synchronous (e.g., 90%)
>  - if bucket crossed soft threshold then before each write, update
> internal cache, check that not crossed hard limit
>  - update internal cache with approximated bucket info after write
>  - if not crossed soft threshold then use a ttl to determine when to
> re-read the bucket info
>      - should reuse data log mechanism for that

Sounds good.  What would the TTL be?

> 2. per-user quota
> 
>  - create a new user objclass
>  - move user bucket-list omap operations to objclass
>  - add a new namespace to user info omap

add attr version to indicate whether to do a format-upgrade on the 
object content?

>  - add user objclass functions:
>     - set buckets info
>     - get total
>     - update per-bucket info
>  - per-user ttl should determine when to re-examine all user buckets.
> This should only be used if user have had data modification since last
> time all buckets were checked.

is there an existing way to know whehter there has been a modification?

i was thinking:

 - objclass function set_refresh_stamp(now + some interval) to indicate 
that we may modify a particular bucket that is covered by a quota
 - if the refresh stamp has expired, an(other) rgw should refresh the 
stats for that bucket in the user info omap
   - if there have been no changes since the last refresh, don't reset of 
the refresh in the future but zero it out instead (i.e., mark the bucket 
idle)

?

>  - cache per-user total in gateway
>  - if crossed soft threshold switch to sync mode (like in the bucket case)
>  - touched buckets should be updated periodically (in the user buckets list)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
