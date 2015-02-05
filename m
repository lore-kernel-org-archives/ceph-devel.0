From: Samuel Just <sam.just@inktank.com>
Subject: Re: Bucket index op - lock contention hang op threads
Date: Thu, 5 Feb 2015 13:42:13 -0800
Message-ID: <CA+4uBUZkTa5F65gYLCmQOpOEC-jQ3VJU7vJ2wdg=EX1wHR8RZw@mail.gmail.com>
References: <BLU175-W313E35FB584EA01A9D258CDF3B0@phx.gbl>
	<CA+4uBUbN_mW=M0oAW64CF=xWZFt6O4D3m45jPu2VTxMj2KykgA@mail.gmail.com>
	<BLU175-W1776AE5CA99C76AAE06468DF3B0@phx.gbl>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:56446 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbbBEVmP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 16:42:15 -0500
Received: by mail-lb0-f175.google.com with SMTP id n10so7732135lbv.6
        for <ceph-devel@vger.kernel.org>; Thu, 05 Feb 2015 13:42:14 -0800 (PST)
In-Reply-To: <BLU175-W1776AE5CA99C76AAE06468DF3B0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

Sure, a81f3e6e61abfc7eca7743a83bf4af810705b449.  The intention was
actually to allow writes on degraded objects for replicated pools (to
avoid a 4k rbd write blocking on a 4mb recovery), but I think it
solves this issue as well.
-Sam

On Thu, Feb 5, 2015 at 1:39 PM, GuangYang <yguang11@outlook.com> wrote:
> Thanks Sam! Do you mind sharing the pull request / commit Id of the change?
>
>> Date: Thu, 5 Feb 2015 11:52:04 -0800
>> Subject: Re: Bucket index op - lock contention hang op threads
>> From: sam.just@inktank.com
>> To: yguang11@outlook.com
>> CC: ceph-devel@vger.kernel.org; sweil@redhat.com
>
>>
>> Recent changes already merged for hammer should prevent blocking the
>> thread on the ondisk_read_lock by expanding the ObjectContext::rwstate
>> lists mostly as you suggested.
>> -Sam
>>
>> On Thu, Feb 5, 2015 at 1:36 AM, GuangYang <yguang11@outlook.com> wrote:
>> > Hi ceph-devel,
>> > In our ceph cluster (with rgw), we came across a problem that all rgw
>> > process are stuck (all worker threads wait for the response from OSD, and
>> > start giving 500 to clients). objecter_requests dump showed the slow in
>> > flight requests were caused by one OSD, which has 2 PGs doing backfilling
>> > and it has 2 bucket index objects.
>> >
>> > At OSD side, we configure 8 threads, it turned out when this problem
>> > occurred, several op threads took seconds (even tens of seconds) handling
>> > bucket index op, with most of time waiting for the ondisk_read_lock. As a
>> > result, the throughput of the op threads drop (qlen increasing).
>> >
>> > I am wondering what options we can pursue to improve the situation, some
>> > general ideas on my mind:
>> > 1> Similar to OpContext::rwstate, instead of make the op thread stuck,
>> > put this op to a waiting list and notify upon lock available. I am not sure
>> > if this worth it or break anything.
>> > 2> Differentiate the service class at filestore level for such OP -
>> > somebody is waiting for its release of the lock. Does this break any
>> > assumption at filestore layer?
>> >
>> > As we are using EC (8+3), the fan out is more than replication pool,
>> > such kind of slow from one OSD could be cascading to more OSDs easier.
>> >
>> > BTW, I created a tracker for this - http://tracker.ceph.com/issues/10739
>> >
>> > Look forward to your suggestions.
>> >
>> > Thanks,
>> > Guang --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
