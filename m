From: Wido den Hollander <wido@42on.com>
Subject: Re: rbd top
Date: Tue, 16 Jun 2015 13:05:20 +0200
Message-ID: <558002F0.5060607@42on.com>
References: <CAANLjFp4+tkSj5=we88nGDFh0NtmX4jYc+sE__1N8L_4X30dfw@mail.gmail.com>	<CAC6JEv8qB6xStrp1EL+gyDWAzVo91DvtDQKyMs9VDB2KtoVR6A@mail.gmail.com>	<alpine.DEB.2.00.1506150647030.18741@cobra.newdream.net>	<557EE94C.10108@redhat.com> <CAANLjFpCt9tMhkkZ+eECXpvpXOgTCoS8wu6OEuA6S89Vbdfv_Q@mail.gmail.com> <557F02D9.1040303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:53172 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbbFPLFY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Jun 2015 07:05:24 -0400
In-Reply-To: <557F02D9.1040303@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, Robert LeBlanc <robert@leblancnet.us>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <greg@gregs42.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 06/15/2015 06:52 PM, John Spray wrote:
> 
> 
> On 15/06/2015 17:10, Robert LeBlanc wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> John, let me see if I understand what you are saying...
>>
>> When a person runs `rbd top`, each OSD would receive a message saying
>> please capture all the performance, grouped by RBD and limit it to
>> 'X'. That way the OSD doesn't have to constantly update performance
>> for each object, but when it is requested it starts tracking it?
> 
> Right, initially the OSD isn't collecting anything, it starts as soon as
> it sees a query get loaded up (published via OSDMap or some other
> mechanism).
> 

I like that idea very much. Currently the OSDs are already CPU bound, a
lot of time is used by processing a request while it's not waiting on
the disk.

Although tracking IOps might seem like a small and cheap thing to do,
it's yet more CPU time spent by the system on something else then
processing the I/O.

So I'm in favor of not always collecting, but only on demand.

Go for performance, low-latency and high IOps.

Wido

> That said, in practice I can see people having some set of queries that
> they always have loaded and feeding into graphite in the background.
>>
>> If so, that is an interesting idea. I wonder if that would be simpler
>> than tracking the performance of each/MRU objects in some format like
>> /proc/diskstats where it is in memory and not necessarily consistent.
>> The benefit is that you could have "lifelong" stats that show up like
>> iostat and it would be a simple operation.
> 
> Hmm, not sure we're on the same page about this part, what I'm talking
> about is all in memory and would be lost across daemon restarts.  Some
> other component would be responsible for gathering the stats across all
> the daemons in one place (that central part could persist stats if
> desired).
> 
>> Each object should be able
>> to reference back to RBD/CephFS upon request and the client could even
>> be responsible for that load. Client performance data would need stats
>> in addition to the object stats.
> 
> You could extend the mechanism to clients.  However, as much as possible
> it's a good thing to keep it server side, as servers are generally fewer
> (still have to reduce these stats across N servers to present to user),
> and we have multiple client implementations (kernel/userspace).  What
> kind of thing do you want to get from clients?
>> My concern is that adding additional SQL like logic to each op is
>> going to get very expensive. I guess if we could push that to another
>> thread early in the op, then it might not be too bad. I'm enjoying the
>> discussion and new ideas.
> 
> Hopefully in most cases the query can be applied very cheaply, for
> operations like comparing pool ID or grouping by client ID. However, I
> would also envisage an optional sampling number, such that e.g. only 1
> in every 100 ops would go through the query processing.  Useful for
> systems where keeping highest throughput is paramount, and the numbers
> will still be useful if clients are doing many thousands of ops per second.
> 
> Cheers,
> John
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
