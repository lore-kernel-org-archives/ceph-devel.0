From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore-Performance regression in the latest master
Date: Thu, 6 Oct 2016 17:12:37 -0500
Message-ID: <50c62b05-5712-9502-1648-0772f8f8c5c1@redhat.com>
References: <BY2PR02MB396BEF6CFDD1164D194C9D2F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1610062115250.19850@piezo.us.to>
 <BY2PR02MB3969BB28F45C805DB4D2735F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755810AbcJFWMl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 18:12:41 -0400
In-Reply-To: <BY2PR02MB3969BB28F45C805DB4D2735F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is bluestore specific?  My guess is the cache sizes as well. 
Bluestore on master is actually significantly faster for me in all of 
the tests I've thrown at it vs earlier this week, but my onode hit rate 
is still "decent".

I still see higher performance by increasing the min alloc size to 16k 
and then bumping up the onode cache size a bit with the memory savings.

Mark

On 10/06/2016 04:52 PM, Somnath Roy wrote:
> I have increased the cache size at the point where it is started swapping after 30 min run or so , but, still I am seeing the huge latest difference.
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
>> I am seeing the performance with the latest master is not stable compare to 3 days old master. The peak performance is higher but it is jumping up and down. Analyzing further I suspect recent cache changes has an impact. While the performance is high , I am seeing lower disk reads (probably because of cache hits) , but the low point is much lower when it is missing the cache probably. You were saying on the standup about adding buffers in the cache in the write path , is that merged into the master ?
>
> The buffered writes by default is not merged:
>
> https://github.com/ceph/ceph/pull/11301
>
>> The following pull request for cache that got merged seems reasonable.
>>
>> https://github.com/ceph/ceph/pull/11295
>
> This cut the cache size down by 4x, plus whatever your sharding factor is/was.  Could that be it?
>
>> Any hunch what is causing this degradation recently ? Otherwise, I
>> need to dig down to find that out :-(
>>
>> See the graph in the following link for the performance difference.
>>
>> https://docs.google.com/spreadsheets/d/1JO3FaBbfT5jEdyYGB8EhHnAl5bAHe0
>> 6ojLE85mPzsK4/edit?usp=sharing
>>
>> The left side graph is with old master and right one is with latest master..Old one I ran for 10 hour and latest master I ran it for 2 hours.
>> The new one has *4X more* latency as well..
>
> My guess is the cache size.  I can't think of what else would have much of an effect on latency...
>
> s
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
