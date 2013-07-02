From: Sage Weil <sage@inktank.com>
Subject: Re: Erasure coding implementation : high level description
Date: Mon, 1 Jul 2013 20:52:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307012044220.18469@cobra.newdream.net>
References: <51C9D65F.8000507@dachary.org> <51CF11A8.2070208@dachary.org> <51D1F875.3080002@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44731 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701Ab3GBDwa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jul 2013 23:52:30 -0400
In-Reply-To: <51D1F875.3080002@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

We had a chat about this this afternoon and another idea came up: support 
only object append in full-stripe writes.  The primary would log the write 
(as per usual), along with the write offset and length.  Each shard 
processes its piece and extends the file. If there is a failure and the pg 
log gets rolled back, we simply truncate off the incompletely 
written/committed stripe from each shard.

This is more limited (no overwrites yet, append-only) but captures the 
most important use-cases, it's super simple, and it's efficient.  It's 
also simple enough that I don't think it commits us in any particular 
direction if/when we later want to do per-stripe overwrites.

One thing it does bring up, though is how the stripe size is determined.  
I suggest that it is specified by the writer on object creation (since the 
writer is responsible for writing in stripe-aligned chunks) and is 
recorded as immutable per-object metadata.  Maybe there is a per-pool 
property to inform clients, but that is mostly just policy...

sage




On Mon, 1 Jul 2013, Loic Dachary wrote:

> For the record,
> 
> Sam suggested today that the chunks of a stripe ( an object if we limit ourselves to full writes ) are written without deleting the chunks from a previous version of the object. i.e. for instance
> 
> object A1 contains "ABCDEFGHI" => version 1 of the object is written as chunks "ABC" "DEF" "GHI" and "XYZ" parity on OSD1, OSD2, OSD3, OSD4 respectively.
> object A1 is updated to "ABCDEF123" => version 2 of the object is written as chunks "ABC" "DEF" "123" and "KLM" parity on OSD1, OSD2, OSD3, OSD4 respectively.
> 
> At some point OSD3 contains both "GHI" ( chunk 3 object A1 version 1 ) and "123" ( chunk 3 object A1 version 2 ).
> 
> When the PG receives an update of last_complete ( which should happen when the PG becomes active ) it knows that all objects with a version lower than last_complete can be discarded. It can then trim the objects stored on the OSD that have a version older than last_complete. With ReplicatedPG this does not need to be done because the new version of the object overrides the previous one. It could be done together with pg_log trimming but it would waste more disk space because the default log size it by default 3000 meaning a chunk would only be deleted from disk after 3000 pg_log_entry were added to pg_log. 
> 
> The object name does not currently contain the version number and this would need to be changed to avoid name clashes.
> 
> Cheers
> 
> On 29/06/2013 18:56, Loic Dachary wrote:
> > Hi Sage,
> > 
> > The level of understanding of ReplicatedPG/PG/OSD required to sketch the path for implementing the erasure coding is beyond me at the moment. A few hours of browsing demonstrated that a number of important areas are still unknown to me. A meaningfull example is probably the logic associated with 
> > 
> > struct AccessMode {
> > 
> > https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f582/src/osd/ReplicatedPG.h#L114
> > 
> > I suspect there are a number of similarities with the erasure code that would be relevant to ensure that a stripe is fully written to disk ( i.e. in relation with the "ondisk" acknowledgment probably ) before removing the previous version of the same stripe from all OSDs supporting it.
> > 
> > The time spent during this exploration was not wasted, I learnt a few things that will be useful :-) But I think it would be more useful for me to work on a more modest task to move in the direction of the erasure coding implementation.
> > 
> > Cheers
> > 
> > On 06/25/2013 07:41 PM, Loic Dachary wrote:
> >> Hi Sage,
> >>
> >> Paraphrasing what you suggested today : 
> >>
> >> The logic for writing a stripe ( i.e. all the chunks created by the erasure encoding function for a given object or part of a given object if it exceeds the maximum size of a stripe ) for a single object is going to be done in a way that is not the same as what we currently have for replicated objects. The object is consistent when all chunks ( or at least K if K+M ) are committed to disk. It may make sense to start writing all the chunks in parallel and when they are acknowledged, send a pg_log event that says : now switch to this new version of the object. To avoid ending up with chunks that are partially for one version of the object and other chunks partially for another version of the object and we can't repair any of them. 
> >>
> >> I will try to sketch the path for implementing the erasure coding ( including the above ) by adding to https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasure-code.rst
> >>
> >> Cheers
> >>
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do nothing.
> 
> 
