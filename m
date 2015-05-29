From: Milosz Tanski <milosz@adfin.com>
Subject: Re: rados bench throughput with no disk or network activity
Date: Thu, 28 May 2015 20:41:30 -0400
Message-ID: <CANP1eJGdzNJJEH8eBLrCCi5iRySSK7h6EQ-+3=7KfwpTLDG6kA@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166995A9B@satlexdag04.amd.com>
	<CAC6JEv82uAz2kwZM9iRfkMSdtUx=AJ03ZBDW4v598sWE-7B53Q@mail.gmail.com>
	<BC97738F8E7C8742BABED7F06FB9DF9166995BA6@satlexdag04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33359 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbbE2Alc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 20:41:32 -0400
Received: by lbcue7 with SMTP id ue7so38994763lbc.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 17:41:30 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166995BA6@satlexdag04.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: Gregory Farnum <greg@gregs42.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 28, 2015 at 7:50 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
>
>
>> -----Original Message-----
>> From: Gregory Farnum [mailto:greg@gregs42.com]
>> Sent: Thursday, May 28, 2015 6:18 PM
>> To: Deneau, Tom
>> Cc: ceph-devel
>> Subject: Re: rados bench throughput with no disk or network activity
>>
>> On Thu, May 28, 2015 at 4:09 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
>> > I've noticed that
>> >    * with a single node cluster with 4 osds
>> >    * and running rados bench rand on that same node so no network traffic
>> >    * with a number of objects small enough so that everything is in
>> > the cache so no disk traffic
>> >
>> > we still peak out at about 1600 MB/sec.
>> >
>> > And the cpu is 40% idle. (and a good chunk of the cpu activity is the
>> > rados benchmark itself)
>> >
>> > What is likely causing the throttling here?
>>
>> Well, rados bench itself is essentially single-threaded, so if it's using
>> 100% CPU that's probably the bottleneck you're hitting.
>>
>> Otherwise, by default it will limit itself to 100MB of outstanding IO
>> (there's an objecter config value you can change for this; it's been
>> discussed recently) and that might not be enough given the latencies of
>> hopping packets across different CPUs, and the OSDs have a slightly-
>> embarrassing amount of CPU computation and thread hopping they have to
>> perform on every op (around half a millisecond's worth on each read, I
>> think?).
>> -Gerg
>
> Right.  I was involved in the objecter config discussion :) and
> I have set the limits higher.   And this 1600 MB/sec limit seems to be
> the same whatever the size of the objects.
>
> rados bench is using about 30% of the cpu and the total cpu usage is about 60%
> (the rest being mostly from the 4 osds).
>
> Hmm, I just tried running 4 copies of rados bench rand, and I can get a little bit
> higher combined totals, but not much higher maybe 1800 MB/sec.

I take it you have multiple different CPUs/cores and you mean 60%
average across all the CPUs/cores? Not 60% of a single core? Just
wanting to be explicit.

In any case, I wonder if what you're seeing is some kind of
serialization (contention) either in the kernel or somewhere in the
OSD.

>
> -- Tom
>



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
