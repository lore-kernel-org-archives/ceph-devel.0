From: John Spray <jspray@redhat.com>
Subject: Re: OSDMap partitioning
Date: Mon, 18 Apr 2016 18:24:03 -0400
Message-ID: <CALe9h7eKyC3t9GdWgFA3e9ZY3etfLeN=t8tDKjJQ6f2VMR=9Gw@mail.gmail.com>
References: <alpine.DEB.2.11.1604180945280.4797@cpach.fuggernut.com>
 <20160418174305.GA22875@ultraspiritum.redhat.com> <CAJ4mKGbTFY8QHxvRtO72qwUbE94oqJ_ggDZ83njnOBxdXpiCkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33425 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbcDRWYY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 18:24:24 -0400
Received: by mail-oi0-f46.google.com with SMTP id r78so63220939oie.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 15:24:24 -0700 (PDT)
In-Reply-To: <CAJ4mKGbTFY8QHxvRtO72qwUbE94oqJ_ggDZ83njnOBxdXpiCkg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sage@newdream.net>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Mon, Apr 18, 2016 at 2:06 PM, Gregory Farnum <gfarnum@redhat.com> wr=
ote:
> On Mon, Apr 18, 2016 at 10:43 AM, Adam C. Emerson <aemerson@redhat.co=
m> wrote:
>> On 18/04/2016, Sage Weil wrote:
>>> On Fri, 15 Apr 2016, Adam C. Emerson wrote: I'm not sure I'm
>>> convinced.  The mon is doing way more than it should right now, but
>>> we are about to rip all/most of the PGMonitor work out of ceph-mon
>>> and move it into ceph-mgr. At that point, the OSDMap is a pretty
>>> small burden for the mon to manage.  Even if we have clusters that
>>> are 2 orders of magnitude larger (100,000 OSDs), that's maybe a
>>> 100MB data structure at most.  Why do we need to partition it?
>>
>> Clients keeping 100MB of state just to talk to the cluster seems a b=
it
>> much to me, especially if we ever want anything embedded to be able =
to
>> use it.
>>
>> Also, it's not just the size. One worry is how well the monitor will
>> be able to hold up if we have a bunch of OSDs going up and down at a
>> fast rate (which becomes a bit more likely the bigger our clusters g=
et.)
>>
>>> I get that pools are heavyweight, but I think that derivse from the
>>> fact that it is a *placement* function, and we *want* placement to
>>> be an administrative property, not a tentant/user property that can
>>> proliferate.  Placement should depend on the hardware that comprise=
s
>>> the cluster, and that doesn't change so quickly, and the scale does
>>> not change quickly.  Tenants want to create their own workspaces to
>>> do their thing, but I think needs to remain a slice within the
>>> existing placement primitives so they do't have direct control.
>>> e.g., rados namespaces, or something more powerful if we need it,
>>> because we'll have anywhere from 1 tenant to a million tenants, and
>>> we can't have them spamming the cluster placement topology.
>>>
>>> At least, I think that's true on the OSD side of things.  On the
>>> client side, might make sense to limit the client's view to certain
>>> pools.  Maybe.
>>>
>>> Anyway, assuming we have some tenant primitive (like namespace slic=
e
>>> of a pool), I don't see the motivation for the huge complexity of
>>> breaking apart OSDMap.  What am I missing?
>>
>> Three things, I think. Please tell me if I'm missing anything obviou=
s
>> or getting anything wrong.
>>
>> First, the gigantic bullsey intersection between tennancy and
>> placement would be cases where regulatory regimes or contracts requi=
re
>> isolation. (The whole "My data can't be stored on the same disk as
>> anyone else's data." thing.)
>>
>> Second, I've always been working under the assumption that placement
>> is a function of workload as well as hardware. At least there's a lo=
t
>> of interesting space in the 'placement function choice'/'workload
>> optimization' intersection.
>>
>> Third, I think Namespaces and Pools as you describe them miss a
>> piece. Users almost always want to be able to make collections of
>> objects that can be treated like a unit. Sure, RADOSGW can make
>> buckets, but I don't think we want to base the fundamental design of
>> our system around the idea that people will be using legacy protocol=
s
>> like S3.
>
> So, how do you build a placement system that treats stuff as a unit,
> but isn't heavyweight like pools? People ask a lot for something like
> that, and when they describe how it could be implemented, it either
> turns into a pool or it turns into an object locator with the ability
> to move everything with a given locator to a locator position.
> Or else it's explicit mappings like some of the stupider Lustre hero =
runs.
>
>
> That said, I've talked with Sam about in some way sharding OSDMaps or
> Ceph clusters, and it is something worth exploring. One giant Ceph
> cluster for your whole data center has issues apart from the size of
> the OSDMap. Failures and changes to the CRUSH map affect placement in
> totally uncorrelated parts of the system and that's not much fun. You
> get part way there by putting pools in different sections of the CRUS=
H
> tree, but maybe not quite enough -- more isolation within the data
> structures also isolates the impact of bugs in the system.

Yeah, the value of isolation is an important point.

I think this thread started with the assumption that having multiple
physical clusters for multiple workloads was a bug, but sometimes it's
a feature.  Some (maybe most?) users with multiple clusters wouldn't
want to merge them into one big one even if we offered them the
ability.

That said, I have a lot of sympathy for the complaint that even
clients accessing a sub-tree of the crush map still have to subscribe
to the entire OSD map.  Same for OSDs that will only ever be peers of
some nearish neighbours.  We could improve that mon-side by allowing
clients to subscribe to their desired sub-map[1] (probably just
specify which pools they care about and let the mon work it out).  But
to be clear, that's not truly scalability improvement, it's just a
pragmatic, useful improvement to the ways we allow people to partition
their ceph clusters to avoid operating at higher scale than they need.

John

> So it might be good to be able to partition OSDs within a single data
> center into separate sub-clusters with their own maps, possibly
> administered by their own monitor clusters. That would mean a change
> in CRUSH weights elsewhere in the system is less likely to
> accidentally impact clusters elsewhere (eg, having a single global
> pool that doesn't see much use any more but suddenly needs to move a
> bunch of stale data). It means that when part of the cluster has
> issues, spins up a bunch of OSDMaps, and hits some new map processing
> cycle of doom we still have present, the other parts of the cluster
> don't fall into the cycle too =E2=80=94 because they don't have any a=
dditional
> maps to process. And doing things to encourage admins to have smaller
> pieces of their system (while doing whatever we can to make it easy t=
o
> shift between them) means that things like our CRUSH imbalances are
> less likely to become a serious issue.
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
