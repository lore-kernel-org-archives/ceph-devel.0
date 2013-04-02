From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Trouble with paxos service for large PG count
Date: Tue, 02 Apr 2013 16:37:24 +0100
Message-ID: <515AFB34.2060008@inktank.com>
References: <5159F899.4090001@sandia.gov> <515ADFFD.5060000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:54169 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335Ab3DBPiK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 11:38:10 -0400
Received: by mail-ee0-f54.google.com with SMTP id e51so304982eek.41
        for <ceph-devel@vger.kernel.org>; Tue, 02 Apr 2013 08:38:08 -0700 (PDT)
In-Reply-To: <515ADFFD.5060000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/02/2013 02:41 PM, Joao Eduardo Luis wrote:
> Hi Jim,
>
> One thing to keep in mind is that with the monitor's rework we now share
> the Paxos instance across all Paxos services.  That may slow things down
> a bit, given paxos proposals for different services are now queued and
> have to wait their turn.  But what's happening to you appears to be
> something completely different -- see below.
>
> On 04/01/2013 10:14 PM, Jim Schutt wrote:
>> [snip]
>>
>> For this last configuration, after collecting the above
>> I waited a bit, started all the OSDs, waited a bit longer,
>> then collected this:
>>
>> 2013-04-01 14:54:37.364686 7ffff328d700 10
>> mon.cs31@0(leader).paxosservice(pgmap) propose_pending
>> 2013-04-01 14:54:37.433641 7ffff328d700  5
>> mon.cs31@0(leader).paxos(paxos active c 1..27) queue_proposal bl
>> 10629660 bytes; ctx = 0x11ece50
>> 2013-04-01 14:54:37.433750 7ffff328d700  5
>> mon.cs31@0(leader).paxos(paxos preparing update c 1..27)
>> propose_queued 28 10629660 bytes
>> 2013-04-01 14:54:37.433755 7ffff328d700 10
>> mon.cs31@0(leader).paxos(paxos preparing update c 1..27)
>> propose_queued list_proposals 1 in queue:
>> 2013-04-01 14:55:38.684532 7ffff328d700 10
>> mon.cs31@0(leader).paxos(paxos preparing update c 1..27) begin for 28
>> 10629660 bytes
>> 2013-04-01 14:55:38.814528 7ffff328d700 10
>> mon.cs31@0(leader).paxos(paxos updating c 1..27) commit 28
>> 2013-04-01 14:55:38.937087 7ffff328d700 10
>> mon.cs31@0(leader).paxos(paxos active c 1..28) finish_queued_proposal
>> finishing proposal
>> 2013-04-01 14:55:38.937120 7ffff328d700 10
>> mon.cs31@0(leader).paxos(paxos active c 1..28) finish_queued_proposal
>> finish it (proposal = 0x1c6e3c0)
>> 2013-04-01 14:55:38.937124 7ffff328d700 10
>> mon.cs31@0(leader).paxos(paxos active c 1..28) finish_queued_proposal
>> proposal took 61.503375 to finish
>> 2013-04-01 14:55:38.937168 7ffff328d700 10
>> mon.cs31@0(leader).paxosservice(pgmap) _active
>>
>> It looks like finish_queued_proposal processing time is scaling
>> quadratically with the proposal length for pgmaps.
>
> Ah! The reason is for such a delay just became obvious, and it's due to
> a quite dumb mistake.  Basically, during Paxos::begin() we're running
> the whole transaction on the JSON formatter, and then outputting it with
> log level 30 -- we should be checking for the log level first to avoid
> spending valuable time on that, specially when transactions are huge.

Well, this might not be right after all.

>
> Besides that, while looking into another bug, I noticed that there's a
> slight problem with the logic of monitor and, at a given point, each
> transaction we create ends up not only containing an incremental but
> also a full version, which is bound to slow things down and exacerbate
> what I just described in the previous paragraph.

But this would certainly explain the 10MB transaction on 'Paxos::begin'.

I'm now actively looking into this and created ticket #4620 on the 
tracker [1].

   -Joao

[1] - http://tracker.ceph.com/issues/4620

>
>
>    -Joao
>
>>
>> FWIW, I don't believe I saw any issues of this sort for
>> versions 0.58 and earlier.
>>
>> Please let me know if there is any other information I can
>> provide that will help to help fix this.
>>
>> Thanks -- Jim
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

