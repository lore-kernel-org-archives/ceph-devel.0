From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Flexible placement
Date: Mon, 18 Apr 2016 12:07:29 -0700
Message-ID: <CAJ4mKGaXA4Y7AQSy0Gr_PFUEXmDtwUu_H6HGwXND9K7FcWeLRA@mail.gmail.com>
References: <alpine.DEB.2.11.1604172057000.4797@cpach.fuggernut.com>
	<20160418170836.GB20078@ultraspiritum.redhat.com>
	<alpine.DEB.2.11.1604181355330.4797@cpach.fuggernut.com>
	<20160418184755.GB22875@ultraspiritum.redhat.com>
	<alpine.DEB.2.11.1604181454160.4797@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36427 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcDRTHa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 15:07:30 -0400
Received: by mail-vk0-f52.google.com with SMTP id n67so2014906vkf.3
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 12:07:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604181454160.4797@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Mon, Apr 18, 2016 at 11:57 AM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 18 Apr 2016, Adam C. Emerson wrote:
>> > I think that in those cases, we let them use a wacky object -> PG
>> > mapping, and then have a linear/flat PG -> device mapping so they
>> > can still get some uniformity.
>> >
>> > This isn't completely general, but I'd want to see an example of
>> > something it can't express.  Maybe those entanglement erasure codes
>> > that Veronica was talking about at FAST?
>> >
>> > Or maybe the key step is to not assume the PG is a hash range, but
>> > instead consider it an arbitrary bucket in the pool.
>>
>> Would the idea basically be in that case that we go from OID =>
>> WHATEVER => DEVICE LIST without putting too many constraints on what
>> 'WHATEVER' is?
>
> Yeah, probably with the additional/implicit restriction that the OSD ->
> WHATEVER mapping is fixed.  That way when a policy or topology change
> happens, we do O(num WHATEVERs) remapping work.  It's the O(num objects)
> part that is really problematic.
>
> (I would say fundamental, but you *could* imagine something where you know
> the old and new mapping, and try both, or incrementall walk through them..
> but, man, it would be ugly.  At that point you're probably better of just
> migrating objects from pool A to pool B.)

Actually, exactly that is a thing I've blue skied with...somebody...as
a more graceful way of dealing with cluster expansions. You could have
CRUSH forks/epochs/whatever, and when making drastic changes to your
cluster, create a new fork. (eg, we just tripled our storage and want
all new data to be on the new servers, but to keep it in the same
pool, and not go through a data migration right now.) Then any object
access addresses every fork (or maybe you have metadata which knows
which fork it was written in) looking for it.
Then you could do things like incrementally merging forks (eg, fork 1
for all objects > hash x, otherwise it has moved to fork 2) to bring
them into unison.

I'm not 100% certain this is better than just getting our pg
replication easier to work well with, but it has some nice properties
(it makes moving a single PG within the cluster easy and gives the
admin a lot more control) and, unlike more manual movement (rbd
snapshot+copyup) doesn't require intelligent clients, just an
intelligent Objecter. On the downside, object fetches suddenly turn
into 2 seek IOs instead of 1.
-Greg
