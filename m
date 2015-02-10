From: Sage Weil <sage@newdream.net>
Subject: Re: Bounding OSD memory requirements during peering/recovery
Date: Mon, 9 Feb 2015 17:51:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502091746100.3035@cobra.newdream.net>
References: <54D78939.4000708@cam.ac.uk> <CAC6JEv8NYw2qk9O7pcSmrVwd2p=7mfLDrA+1tBmFxf2-_f-tZw@mail.gmail.com> <54D92850.5080409@cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51353 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbbBJBvy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 20:51:54 -0500
In-Reply-To: <54D92850.5080409@cam.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David McBride <dwm37@cam.ac.uk>
Cc: Gregory Farnum <greg@gregs42.com>, Ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 9 Feb 2015, David McBride wrote:
> On 09/02/15 15:31, Gregory Farnum wrote:
> 
> > So, memory usage of an OSD is usually linear in the number of PGs it
> > hosts. However, that memory can also grow based on at least one other
> > thing: the number of OSD Maps required to go through peering. It
> > *looks* to me like this is what you're running in to, not growth on
> > the number of state machines. In particular, those past_intervals you
> > mentioned. ;)
> 
> Hi Greg,
> 
> Right, that sounds entirely plausible, and is very helpful.
> 
> In practice, that means I'll need to be careful to avoid this situation
> occurring in production ? but given that's unlikely to occur except in the
> case of non-trivial neglect, I don't think I need be particularly concerned.
> 
> (Happily, I'm in the situation that my existing cluster is purely for testing
> purposes; the data is expendable.)
> 
> That said, for my own peace of mind, it would be valuable to have a procedure
> that can be used to recover from this state, even if it's unlikely to occur in
> practice.

The best luck I've had recovering from situations is something like:

- stop all osds
- osd set nodown
- osd set nobackfill
- osd set noup
- set map cache size smaller to reduce memory footprint.  

  osd map cache size = 50
  osd map max advance = 25
  osd map share max epochs = 25
  osd pg epoch persisted max stale = 25

(basically, keep most of those values in sync, and smaller than 
the map cache)

- start all osds, let them catch up on their maps.  (if they can't fit in 
memory at this point then another creative solution will be needed)
- unset noup so that everyone peers at once

It may also help to try to match the in/out state with where the data 
actually resides (i.e. mark an osd back in if it was marked out but the 
cluster didn't rebalance).

> I'm currently running an experiment where I augment the RAM of each OSD node
> with 10GB swapfiles on each spinning OSD disk, so that there's a big-enough
> backing-store to complete log reconstruction.

Swap tends to not work very well.. make sure nodown is set if you have to 
go this route or else osds will get marked down when they miss 
heartbeats...

sage

