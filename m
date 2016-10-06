From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore-Performance regression in the latest master
Date: Thu, 6 Oct 2016 23:04:17 +0000
Message-ID: <BY2PR02MB396C9E7D9CB33A1CDD204AAF4C70@BY2PR02MB396.namprd02.prod.outlook.com>
References: <BY2PR02MB396BEF6CFDD1164D194C9D2F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1610062115250.19850@piezo.us.to>
 <BY2PR02MB3969BB28F45C805DB4D2735F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
 <50c62b05-5712-9502-1648-0772f8f8c5c1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:34259
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932395AbcJFXEU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 19:04:20 -0400
In-Reply-To: <50c62b05-5712-9502-1648-0772f8f8c5c1@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Mark,
If you see the graph in the below link , you will see it is choppy and fast=
er till 1 hour , beyond that it is degrading fast..
If you see the left side graph that is holding the constant performance thr=
oughout for 10 hour (old master)
Have you checked the latency with the shorter run with the latest master as=
 well ? Even with the shorter run it is 4X more latency (even though aggreg=
ated throughput is bit more) for me..
Anyways, I am trying to reproduce this in another setup just to eliminate H=
W issues in case..

Thanks & Regards
Somnath

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com]=20
Sent: Thursday, October 06, 2016 3:13 PM
To: Somnath Roy; Sage Weil
Cc: Ceph Development
Subject: Re: Bluestore-Performance regression in the latest master

This is bluestore specific?  My guess is the cache sizes as well.=20
Bluestore on master is actually significantly faster for me in all of the t=
ests I've thrown at it vs earlier this week, but my onode hit rate is still=
 "decent".

I still see higher performance by increasing the min alloc size to 16k and =
then bumping up the onode cache size a bit with the memory savings.

Mark

On 10/06/2016 04:52 PM, Somnath Roy wrote:
> I have increased the cache size at the point where it is started swapping=
 after 30 min run or so , but, still I am seeing the huge latest difference=
.
> Will try to find out what went wrong recently..
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Thursday, October 06, 2016 2:17 PM
> To: Somnath Roy
> Cc: Ceph Development
> Subject: Re: Bluestore-Performance regression in the latest master
>
> On Thu, 6 Oct 2016, Somnath Roy wrote:
>> Sage,
>> I am seeing the performance with the latest master is not stable compare=
 to 3 days old master. The peak performance is higher but it is jumping up =
and down. Analyzing further I suspect recent cache changes has an impact. W=
hile the performance is high , I am seeing lower disk reads (probably becau=
se of cache hits) , but the low point is much lower when it is missing the =
cache probably. You were saying on the standup about adding buffers in the =
cache in the write path , is that merged into the master ?
>
> The buffered writes by default is not merged:
>
> https://github.com/ceph/ceph/pull/11301
>
>> The following pull request for cache that got merged seems reasonable.
>>
>> https://github.com/ceph/ceph/pull/11295
>
> This cut the cache size down by 4x, plus whatever your sharding factor is=
/was.  Could that be it?
>
>> Any hunch what is causing this degradation recently ? Otherwise, I=20
>> need to dig down to find that out :-(
>>
>> See the graph in the following link for the performance difference.
>>
>> https://docs.google.com/spreadsheets/d/1JO3FaBbfT5jEdyYGB8EhHnAl5bAHe
>> 0
>> 6ojLE85mPzsK4/edit?usp=3Dsharing
>>
>> The left side graph is with old master and right one is with latest mast=
er..Old one I ran for 10 hour and latest master I ran it for 2 hours.
>> The new one has *4X more* latency as well..
>
> My guess is the cache size.  I can't think of what else would have much o=
f an effect on latency...
>
> s
> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>
