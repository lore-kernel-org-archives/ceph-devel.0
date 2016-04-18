From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: OSDMap partitioning
Date: Mon, 18 Apr 2016 11:06:09 -0700
Message-ID: <CAJ4mKGbTFY8QHxvRtO72qwUbE94oqJ_ggDZ83njnOBxdXpiCkg@mail.gmail.com>
References: <alpine.DEB.2.11.1604180945280.4797@cpach.fuggernut.com>
	<20160418174305.GA22875@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36772 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbcDRSGL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 14:06:11 -0400
Received: by mail-vk0-f51.google.com with SMTP id n67so144059vkf.3
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 11:06:10 -0700 (PDT)
In-Reply-To: <20160418174305.GA22875@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Mon, Apr 18, 2016 at 10:43 AM, Adam C. Emerson <aemerson@redhat.com>=
 wrote:
> On 18/04/2016, Sage Weil wrote:
>> On Fri, 15 Apr 2016, Adam C. Emerson wrote: I'm not sure I'm
>> convinced.  The mon is doing way more than it should right now, but
>> we are about to rip all/most of the PGMonitor work out of ceph-mon
>> and move it into ceph-mgr. At that point, the OSDMap is a pretty
>> small burden for the mon to manage.  Even if we have clusters that
>> are 2 orders of magnitude larger (100,000 OSDs), that's maybe a
>> 100MB data structure at most.  Why do we need to partition it?
>
> Clients keeping 100MB of state just to talk to the cluster seems a bi=
t
> much to me, especially if we ever want anything embedded to be able t=
o
> use it.
>
> Also, it's not just the size. One worry is how well the monitor will
> be able to hold up if we have a bunch of OSDs going up and down at a
> fast rate (which becomes a bit more likely the bigger our clusters ge=
t.)
>
>> I get that pools are heavyweight, but I think that derivse from the
>> fact that it is a *placement* function, and we *want* placement to
>> be an administrative property, not a tentant/user property that can
>> proliferate.  Placement should depend on the hardware that comprises
>> the cluster, and that doesn't change so quickly, and the scale does
>> not change quickly.  Tenants want to create their own workspaces to
>> do their thing, but I think needs to remain a slice within the
>> existing placement primitives so they do't have direct control.
>> e.g., rados namespaces, or something more powerful if we need it,
>> because we'll have anywhere from 1 tenant to a million tenants, and
>> we can't have them spamming the cluster placement topology.
>>
>> At least, I think that's true on the OSD side of things.  On the
>> client side, might make sense to limit the client's view to certain
>> pools.  Maybe.
>>
>> Anyway, assuming we have some tenant primitive (like namespace slice
>> of a pool), I don't see the motivation for the huge complexity of
>> breaking apart OSDMap.  What am I missing?
>
> Three things, I think. Please tell me if I'm missing anything obvious
> or getting anything wrong.
>
> First, the gigantic bullsey intersection between tennancy and
> placement would be cases where regulatory regimes or contracts requir=
e
> isolation. (The whole "My data can't be stored on the same disk as
> anyone else's data." thing.)
>
> Second, I've always been working under the assumption that placement
> is a function of workload as well as hardware. At least there's a lot
> of interesting space in the 'placement function choice'/'workload
> optimization' intersection.
>
> Third, I think Namespaces and Pools as you describe them miss a
> piece. Users almost always want to be able to make collections of
> objects that can be treated like a unit. Sure, RADOSGW can make
> buckets, but I don't think we want to base the fundamental design of
> our system around the idea that people will be using legacy protocols
> like S3.

So, how do you build a placement system that treats stuff as a unit,
but isn't heavyweight like pools? People ask a lot for something like
that, and when they describe how it could be implemented, it either
turns into a pool or it turns into an object locator with the ability
to move everything with a given locator to a locator position.
Or else it's explicit mappings like some of the stupider Lustre hero ru=
ns.


That said, I've talked with Sam about in some way sharding OSDMaps or
Ceph clusters, and it is something worth exploring. One giant Ceph
cluster for your whole data center has issues apart from the size of
the OSDMap. Failures and changes to the CRUSH map affect placement in
totally uncorrelated parts of the system and that's not much fun. You
get part way there by putting pools in different sections of the CRUSH
tree, but maybe not quite enough -- more isolation within the data
structures also isolates the impact of bugs in the system.

So it might be good to be able to partition OSDs within a single data
center into separate sub-clusters with their own maps, possibly
administered by their own monitor clusters. That would mean a change
in CRUSH weights elsewhere in the system is less likely to
accidentally impact clusters elsewhere (eg, having a single global
pool that doesn't see much use any more but suddenly needs to move a
bunch of stale data). It means that when part of the cluster has
issues, spins up a bunch of OSDMaps, and hits some new map processing
cycle of doom we still have present, the other parts of the cluster
don't fall into the cycle too =E2=80=94 because they don't have any add=
itional
maps to process. And doing things to encourage admins to have smaller
pieces of their system (while doing whatever we can to make it easy to
shift between them) means that things like our CRUSH imbalances are
less likely to become a serious issue.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
