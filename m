From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore-Performance regression in the latest master
Date: Thu, 6 Oct 2016 21:52:55 +0000
Message-ID: <BY2PR02MB3969BB28F45C805DB4D2735F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
References: <BY2PR02MB396BEF6CFDD1164D194C9D2F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1610062115250.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0070.outbound.protection.outlook.com ([104.47.37.70]:11968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933672AbcJFVx2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 17:53:28 -0400
In-Reply-To: <alpine.DEB.2.11.1610062115250.19850@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I have increased the cache size at the point where it is started swapping a=
fter 30 min run or so , but, still I am seeing the huge latest difference.
Will try to find out what went wrong recently..

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Thursday, October 06, 2016 2:17 PM
To: Somnath Roy
Cc: Ceph Development
Subject: Re: Bluestore-Performance regression in the latest master

On Thu, 6 Oct 2016, Somnath Roy wrote:
> Sage,
> I am seeing the performance with the latest master is not stable compare =
to 3 days old master. The peak performance is higher but it is jumping up a=
nd down. Analyzing further I suspect recent cache changes has an impact. Wh=
ile the performance is high , I am seeing lower disk reads (probably becaus=
e of cache hits) , but the low point is much lower when it is missing the c=
ache probably. You were saying on the standup about adding buffers in the c=
ache in the write path , is that merged into the master ?

The buffered writes by default is not merged:

https://github.com/ceph/ceph/pull/11301

> The following pull request for cache that got merged seems reasonable.
>
> https://github.com/ceph/ceph/pull/11295

This cut the cache size down by 4x, plus whatever your sharding factor is/w=
as.  Could that be it?

> Any hunch what is causing this degradation recently ? Otherwise, I
> need to dig down to find that out :-(
>
> See the graph in the following link for the performance difference.
>
> https://docs.google.com/spreadsheets/d/1JO3FaBbfT5jEdyYGB8EhHnAl5bAHe0
> 6ojLE85mPzsK4/edit?usp=3Dsharing
>
> The left side graph is with old master and right one is with latest maste=
r..Old one I ran for 10 hour and latest master I ran it for 2 hours.
> The new one has *4X more* latency as well..

My guess is the cache size.  I can't think of what else would have much of =
an effect on latency...

s
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
