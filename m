From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: explicitly mapping pgs in OSDMap
Date: Thu, 2 Mar 2017 11:42:52 +0800
Message-ID: <CAEYCsVJvCwk-QUzv04MSbumBoSCbW3euEE996VRO_wDMe8uyrQ@mail.gmail.com>
References: <alpine.DEB.2.11.1703011932530.651@piezo.novalocal>
 <CABZ+qqn3f2+eGfSP=fuB-eGSAyrK6eCJ2XjWiBAWyourfyrpGA@mail.gmail.com> <alpine.DEB.2.11.1703012204460.651@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36233 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbdCBDmy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Mar 2017 22:42:54 -0500
Received: by mail-yw0-f179.google.com with SMTP id v200so48118280ywc.3
        for <ceph-devel@vger.kernel.org>; Wed, 01 Mar 2017 19:42:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1703012204460.651@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looks like the mapping need to be generated automatically by some
external/internal tools, not by administrator , they can do it handy but I
dont think human can properly balance thousands of PGs across thousands of
OSDs correctly.

Assume we have such tool, can we simplify the "remove" to "regenerate" the
mapping? i.e , when osdmap changes, all previous mapping cleared, crush
rule applies and pgmap generated, then **balance tool** jump in and
generate new mapping, then we have a *balanced* pgmap.

> That means either we need to (1) understand the CRUSH rule
constraints, or (2) encode the (simplified?) set of placement constraints
in the Ceph OSDMap and auto-generate the CRUSH rule from that.

will it be simpler by just extend the crushwrapper to have a
validate_pg_map(crush *map, vector<int> pg_map)?  it just hack the "random"
logical in crush_choose and see if crush can generate same mapping as the
wanted mapping?


Xiaoxi

2017-03-02 6:10 GMT+08:00 Sage Weil <sweil@redhat.com>:
> On Wed, 1 Mar 2017, Dan van der Ster wrote:
>> On Wed, Mar 1, 2017 at 8:44 PM, Sage Weil <sweil@redhat.com> wrote:
>> > There's been a longstanding desire to improve the balance of PGs and data
>> > across OSDs to better utilize storage and balance workload.  We had a few
>> > ideas about this in a meeting last week and I wrote up a summary/proposal
>> > here:
>> >
>> >         http://pad.ceph.com/p/osdmap-explicit-mapping
>> >
>> > The basic idea is to have the ability to explicitly map individual PGs
>> > to certain OSDs so that we can move PGs from overfull to underfull
>> > devices.  The idea is that the mon or mgr would do this based on some
>> > heuristics or policy and should result in a better distribution than teh
>> > current osd weight adjustments we make now with reweight-by-utilization.
>> >
>> > The other key property is that one reason why we need as many PGs as we do
>> > now is to get a good balance; if we can remap some of them explicitly, we
>> > can get a better balance with fewer.  In essense, CRUSH gives an
>> > approximate distribution, and then we correct to make it perfect (or close
>> > to it).
>> >
>> > The main challenge is less about figuring out when/how to remap PGs to
>> > correct balance, but figuring out when to remove those remappings after
>> > CRUSH map changes.  Some simple greedy strategies are obvious starting
>> > points (e.g., to move PGs off OSD X, first adjust or remove existing remap
>> > entries targetting OSD X before adding new ones), but there are a few
>> > ways we could structure the remap entries themselves so that they
>> > more gracefully disappear after a change.
>> >
>> > For example, a remap entry might move a PG from OSD A to B if it maps to
>> > A; if the CRUSH topology changes and the PG no longer maps to A, the entry
>> > would be removed or ignored.  There are a few ways to do this in the pad;
>> > I'm sure there are other options.
>> >
>> > I put this on the agenda for CDM tonight.  If anyone has any other ideas
>> > about this we'd love to hear them!
>> >
>>
>> Hi Sage. This would be awesome! Seriously, it would let us run multi
>> PB clusters closer to being full -- 1% of imbalance on a 100 PB
>> cluster is *expensive* !!
>>
>> I can't join the meeting, but here are my first thoughts on the implementation.
>>
>> First, since this is a new feature, it would be cool if it supported
>> non-trivial topologies from the beginning -- i.e. the trivial topology
>> is when all OSDs should have equal PGs/weight. A non-trivial topology
>> is where only OSDs beneath a user-defined crush bucket are balanced.
>>
>> And something I didn't understand about the remap format options --
>> when the cluster topology changes, couldn't we just remove all
>> remappings and start again? If you use some consistent method for the
>> remaps, shouldn't the result anyway remain similar after incremental
>> topology changes?
>>
>> In the worst case, remaps will only form maybe 10-20% of PGs. Clearly
>> we don't want to shuffle those for small topology changes, but for
>> larger changes perhaps we can accept those to move.
>
> If there is a small change, then we don't want to toss the mappings.. but
> if there is a large change you do; which ones you toss should
> probably depend on whether the original mapping they were overriding
> changed.
>
> The other hard part of this, now that I think about it, is that you have
> placement constraints encoded into the CRUSH rules (e.g., separate
> replicas across racks).  Whatever is installing new mappings needs to
> understand those constraints so tha the remap entries also respect the
> policy.  That means either we need to (1) understand the CRUSH rule
> constraints, or (2) encode the (simplified?) set of placement constraints
> in the Ceph OSDMap and auto-generate the CRUSH rule from that.
>
> For (1), I bet we can make a simple "CRUSH rule intepreter" that, instead
> of making pseudorandom choices, pick each child based on the minimum
> utilization (or the original mapping value) in order to generate the remap
> entries...
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
