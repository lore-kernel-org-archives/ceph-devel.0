From: Sage Weil <sweil@redhat.com>
Subject: Re: explicitly mapping pgs in OSDMap
Date: Thu, 2 Mar 2017 17:40:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703021737440.651@piezo.novalocal>
References: <alpine.DEB.2.11.1703011932530.651@piezo.novalocal> <362CBE0D-E1C6-4068-92AE-62CF5EDD836D@TERADATA.COM>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753217AbdCBRuQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Mar 2017 12:50:16 -0500
In-Reply-To: <362CBE0D-E1C6-4068-92AE-62CF5EDD836D@TERADATA.COM>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 2 Mar 2017, Kamble, Nitin A wrote:
> Hi Sage,
>   The crush algorithm handles mapping of pgs, and it will even with the
> addition of explicit mappings. I presume, finding which pgs belong to
> which OSDs will involve addition computation for each additional
> explicit mapping. 
> 
> What would be penalty of this additional computation? 
> 
> For small number of explicit mappings such penalty would be small, 
> IMO it can get quite expensive with large number of explicit mappings.
> The implementation will need to manage the count of explicit mappings,
> by reverting some of the explicit mappings as the distribution changes.
> The understanding of additional overhead of the explicit mappings would
> had great influence on the implementation.

Yeah, we'll want to be careful with the implementation, e.g., by using an 
unordered_map (hash table) for looking up the mappings (an rbtree won't 
scale particularly well).

Note that pg_temp is already a map<pg_t,vector<int>> and can get big when 
you're doing a lot of rebalancing, resulting on O(log n) lookups.  If we 
do something optimized here we should use the same strategy for pg_temp 
too.

sage


> 
> Nitin
> 
> 
> 
> 
> On 3/1/17, 11:44 AM, "ceph-devel-owner@vger.kernel.org on behalf of Sage Weil" <ceph-devel-owner@vger.kernel.org on behalf of sweil@redhat.com> wrote:
> 
>     There's been a longstanding desire to improve the balance of PGs and data 
>     across OSDs to better utilize storage and balance workload.  We had a few 
>     ideas about this in a meeting last week and I wrote up a summary/proposal 
>     here:
>     
>     	http://pad.ceph.com/p/osdmap-explicit-mapping
>     
>     The basic idea is to have the ability to explicitly map individual PGs 
>     to certain OSDs so that we can move PGs from overfull to underfull 
>     devices.  The idea is that the mon or mgr would do this based on some 
>     heuristics or policy and should result in a better distribution than teh 
>     current osd weight adjustments we make now with reweight-by-utilization.
>     
>     The other key property is that one reason why we need as many PGs as we do 
>     now is to get a good balance; if we can remap some of them explicitly, we 
>     can get a better balance with fewer.  In essense, CRUSH gives an 
>     approximate distribution, and then we correct to make it perfect (or close 
>     to it).
>     
>     The main challenge is less about figuring out when/how to remap PGs to 
>     correct balance, but figuring out when to remove those remappings after 
>     CRUSH map changes.  Some simple greedy strategies are obvious starting 
>     points (e.g., to move PGs off OSD X, first adjust or remove existing remap 
>     entries targetting OSD X before adding new ones), but there are a few 
>     ways we could structure the remap entries themselves so that they 
>     more gracefully disappear after a change.
>     
>     For example, a remap entry might move a PG from OSD A to B if it maps to 
>     A; if the CRUSH topology changes and the PG no longer maps to A, the entry 
>     would be removed or ignored.  There are a few ways to do this in the pad; 
>     I'm sure there are other options.
>     
>     I put this on the agenda for CDM tonight.  If anyone has any other ideas 
>     about this we'd love to hear them!
>     
>     sage
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>     the body of a message to majordomo@vger.kernel.org
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>     
> 
> 
