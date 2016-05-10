From: Wido den Hollander <wido@42on.com>
Subject: Re: "1 hosts down" health warning?
Date: Tue, 10 May 2016 08:05:50 +0200 (CEST)
Message-ID: <184215728.1353.1462860350329@ox.pcextreme.nl>
References: <alpine.DEB.2.11.1605091232040.1841@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:49389 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbcEJGF4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 02:05:56 -0400
In-Reply-To: <alpine.DEB.2.11.1605091232040.1841@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org


> Op 9 mei 2016 om 18:36 schreef Sage Weil <sweil@redhat.com>:
> 
> 
> We have a feature (mon_osd_reporter_subtree_level = host) that makes it so 
> that if an entire host is down (or whatever the configured hierarchy 
> level is) the osds aren't automatically marked out after 5 minutes.
> 
> This is confusing on an actual cluster because you see something like
> 
>             48/5661 in osds are down
> 
> bit it never clears.  It's not until you look at the ceph osd tree output 
> that you can see why they aren't getting marked out.
> 
> It would be great if the health warning said something like
> 
>             48/5661 in osds are down
>             1/142 hosts are down (accounting for 48/48 down osds)
> 
> and the health detail said something like
> 
>   host foo is down with 48 OSDs
> 
> I think this would be pretty easy to implement given the mon is 
> already doing the subtree-based checks.
> 
> Thoughts? Any takers?

Seems like a good thing to have. I wouldn't say 'host', since 'mon_osd_reporter_subtree_level' could be set to rack or row if you want to.

Maybe:

            480/6720 in osds are down
            1/14 of CRUSH type 'rack' are down (accounting for 480/480 down osds)

That seems more logical to me.

Wido

> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
