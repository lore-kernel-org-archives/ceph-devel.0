From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Flexible placement
Date: Wed, 20 Apr 2016 04:55:11 +1000
Message-ID: <CA+z5DswGKVmj2cSA+Z92SO-y_eYSjWCf1yo-XeGL92qbF77NSw@mail.gmail.com>
References: <alpine.DEB.2.11.1604172057000.4797@cpach.fuggernut.com>
 <20160418170836.GB20078@ultraspiritum.redhat.com> <alpine.DEB.2.11.1604181355330.4797@cpach.fuggernut.com>
 <20160418184755.GB22875@ultraspiritum.redhat.com> <alpine.DEB.2.11.1604181454160.4797@cpach.fuggernut.com>
 <CAJ4mKGaXA4Y7AQSy0Gr_PFUEXmDtwUu_H6HGwXND9K7FcWeLRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33678 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932761AbcDSSzc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2016 14:55:32 -0400
Received: by mail-vk0-f66.google.com with SMTP id v68so3545299vka.0
        for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2016 11:55:32 -0700 (PDT)
In-Reply-To: <CAJ4mKGaXA4Y7AQSy0Gr_PFUEXmDtwUu_H6HGwXND9K7FcWeLRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, "Adam C. Emerson" <aemerson@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 19 April 2016 at 05:07, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Mon, Apr 18, 2016 at 11:57 AM, Sage Weil <sage@newdream.net> wrote:
>> On Mon, 18 Apr 2016, Adam C. Emerson wrote:
>>> > I think that in those cases, we let them use a wacky object -> PG
>>> > mapping, and then have a linear/flat PG -> device mapping so they
>>> > can still get some uniformity.
>>> >
>>> > This isn't completely general, but I'd want to see an example of
>>> > something it can't express.  Maybe those entanglement erasure codes
>>> > that Veronica was talking about at FAST?
>>> >
>>> > Or maybe the key step is to not assume the PG is a hash range, but
>>> > instead consider it an arbitrary bucket in the pool.
>>>
>>> Would the idea basically be in that case that we go from OID =>
>>> WHATEVER => DEVICE LIST without putting too many constraints on what
>>> 'WHATEVER' is?
>>
>> Yeah, probably with the additional/implicit restriction that the OSD ->
>> WHATEVER mapping is fixed.  That way when a policy or topology change
>> happens, we do O(num WHATEVERs) remapping work.  It's the O(num objects)
>> part that is really problematic.
>>
>> (I would say fundamental, but you *could* imagine something where you know
>> the old and new mapping, and try both, or incrementall walk through them..
>> but, man, it would be ugly.  At that point you're probably better of just
>> migrating objects from pool A to pool B.)
>
> Actually, exactly that is a thing I've blue skied with...somebody...as
> a more graceful way of dealing with cluster expansions. You could have
> CRUSH forks/epochs/whatever, and when making drastic changes to your
> cluster, create a new fork. (eg, we just tripled our storage and want
> all new data to be on the new servers, but to keep it in the same
> pool, and not go through a data migration right now.) Then any object
> access addresses every fork (or maybe you have metadata which knows
> which fork it was written in) looking for it.
> Then you could do things like incrementally merging forks (eg, fork 1
> for all objects > hash x, otherwise it has moved to fork 2) to bring
> them into unison.
>
> I'm not 100% certain this is better than just getting our pg
> replication easier to work well with, but it has some nice properties
> (it makes moving a single PG within the cluster easy and gives the
> admin a lot more control) and, unlike more manual movement (rbd
> snapshot+copyup) doesn't require intelligent clients, just an
> intelligent Objecter. On the downside, object fetches suddenly turn
> into 2 seek IOs instead of 1.

Interesting thread. Just wanted to say, as an institution with a
couple of fairly large clusters and a few years of operational
experience under our belts now, this particular comment of Greg's
resonates.

Crush is awesome and elegant, but one of our biggest operational
pain-points is managing map changes and their impacts. Our reality is
that we impose more map changes on the cluster through standard
maintenance and expansion/refresh activity than do failures (even at
the ~1000 drive scale), and we'd really like to have some more
flexibility around managing those activities.

-- 
Cheers,
~Blairo
