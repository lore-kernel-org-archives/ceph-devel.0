From: Sage Weil <sweil@redhat.com>
Subject: Re: explicitly mapping pgs in OSDMap
Date: Thu, 2 Mar 2017 18:09:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703021804520.651@piezo.novalocal>
References: <alpine.DEB.2.11.1703011932530.651@piezo.novalocal> <362CBE0D-E1C6-4068-92AE-62CF5EDD836D@TERADATA.COM> <alpine.DEB.2.11.1703021737440.651@piezo.novalocal> <F6F90D3B-5362-48D1-B786-2191E5B98331@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1754240917-1488478150=:651"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbdCBUEn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Mar 2017 15:04:43 -0500
In-Reply-To: <F6F90D3B-5362-48D1-B786-2191E5B98331@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tiger Hu <hufh2004@gmail.com>
Cc: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1754240917-1488478150=:651
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 3 Mar 2017, Tiger Hu wrote:
> Hi Sage,
> I am very glad to know you raised this issue. In some cases, user may want
> to accurately control the PG numbers in every OSDs. Is it possible to
> add/implement a new policy to support fixed-mapping? This may be useful for
> performance tuning or test purpose. Thanks.

In principle this could be used to map every pg explicitly without regard 
for CRUSH.  In think in practice, though, we can have CRUSH map 80-90% of 
the PGs, and then have explicit mappings for 10-20% in order to achieve 
the same "perfect" balance of PGs.

The result is a smaller OSDMap.  It might not matter that much for small 
clusters, but for large clusters, it is helpful to keep the OSDMap small.

OTOH, maybe through all of this we end up in a place where the OSDMap is 
just an explicit map and the mgr agent that's managing it is using CRUSH 
to generate it; who knows!  That might make for faster mappings on the 
clients since it's a table lookup instead of a mapping calculation.

I'm thinking that if we implement the ability to have the explicit 
mappings in the OSDMap we open up both possibilities.  The hard part is 
always getting the mapping compatbility into the client, so if we do that 
right, luminous+ clients will support explicit mapping (overrides) in 
OSDMap and would be able to work with future versions that go all-in on 
explicit...

sage


 > 
> Tiger
>       在 2017年3月3日，上午1:40，Sage Weil <sweil@redhat.com> 写道：
> 
> On Thu, 2 Mar 2017, Kamble, Nitin A wrote:
>       Hi Sage,
>        The crush algorithm handles mapping of pgs, and it will
>       even with the
>       addition of explicit mappings. I presume, finding which
>       pgs belong to
>       which OSDs will involve addition computation for each
>       additional
>       explicit mapping. 
> 
>       What would be penalty of this additional computation? 
> 
>       For small number of explicit mappings such penalty would
>       be small, 
>       IMO it can get quite expensive with large number of
>       explicit mappings.
>       The implementation will need to manage the count of
>       explicit mappings,
>       by reverting some of the explicit mappings as the
>       distribution changes.
>       The understanding of additional overhead of the explicit
>       mappings would
>       had great influence on the implementation.
> 
> 
> Yeah, we'll want to be careful with the implementation, e.g., by using
> an 
> unordered_map (hash table) for looking up the mappings (an rbtree
> won't 
> scale particularly well).
> 
> Note that pg_temp is already a map<pg_t,vector<int>> and can get big
> when 
> you're doing a lot of rebalancing, resulting on O(log n) lookups.  If
> we 
> do something optimized here we should use the same strategy for
> pg_temp 
> too.
> 
> sage
> 
> 
> 
>       Nitin
> 
> 
> 
> 
>       On 3/1/17, 11:44 AM, "ceph-devel-owner@vger.kernel.org on
>       behalf of Sage Weil" <ceph-devel-owner@vger.kernel.org on
>       behalf of sweil@redhat.com> wrote:
> 
>          There's been a longstanding desire to improve the
>       balance of PGs and data 
>          across OSDs to better utilize storage and balance
>       workload.  We had a few 
>          ideas about this in a meeting last week and I wrote up
>       a summary/proposal 
>          here:
> 
>           http://pad.ceph.com/p/osdmap-explicit-mapping
> 
>          The basic idea is to have the ability to explicitly map
>       individual PGs 
>          to certain OSDs so that we can move PGs from overfull
>       to underfull 
>          devices.  The idea is that the mon or mgr would do this
>       based on some 
>          heuristics or policy and should result in a better
>       distribution than teh 
>          current osd weight adjustments we make now with
>       reweight-by-utilization.
> 
>          The other key property is that one reason why we need
>       as many PGs as we do 
>          now is to get a good balance; if we can remap some of
>       them explicitly, we 
>          can get a better balance with fewer.  In essense, CRUSH
>       gives an 
>          approximate distribution, and then we correct to make
>       it perfect (or close 
>          to it).
> 
>          The main challenge is less about figuring out when/how
>       to remap PGs to 
>          correct balance, but figuring out when to remove those
>       remappings after 
>          CRUSH map changes.  Some simple greedy strategies are
>       obvious starting 
>          points (e.g., to move PGs off OSD X, first adjust or
>       remove existing remap 
>          entries targetting OSD X before adding new ones), but
>       there are a few 
>          ways we could structure the remap entries themselves so
>       that they 
>          more gracefully disappear after a change.
> 
>          For example, a remap entry might move a PG from OSD A
>       to B if it maps to 
>          A; if the CRUSH topology changes and the PG no longer
>       maps to A, the entry 
>          would be removed or ignored.  There are a few ways to
>       do this in the pad; 
>          I'm sure there are other options.
> 
>          I put this on the agenda for CDM tonight.  If anyone
>       has any other ideas 
>          about this we'd love to hear them!
> 
>          sage
>          --
>          To unsubscribe from this list: send the line
>       "unsubscribe ceph-devel" in
>          the body of a message to majordomo@vger.kernel.org
>          More majordomo info at
>        http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> 
--8323329-1754240917-1488478150=:651--
