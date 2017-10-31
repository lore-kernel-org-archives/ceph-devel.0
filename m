From: Sage Weil <sweil@redhat.com>
Subject: Re: Why does Erasure-pool not support omap?
Date: Tue, 31 Oct 2017 02:26:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710310220480.2819@piezo.novalocal>
References: <201710251652060421729@zte.com.cn> <alpine.DEB.2.11.1710251213140.22592@piezo.us.to> <37aa304a-f13b-2cf8-c5c5-5d03d37feffa@redhat.com> <CAJ4mKGa+Xpt9a2P0y_cz9bohj7R_hP_Ysiar4oqRgW-yWJY+ug@mail.gmail.com> <alpine.DEB.2.11.1710261423200.22592@piezo.us.to>
 <1e168a03-ec8f-36c9-f444-550738f4c0f1@redhat.com> <CAJ4mKGbYnyd1sMFZGM-RZ+448fJ+XsnGquJ-ZOyZwPxQGwaydg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-763005413-1509416795=:2819"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbdJaC0g (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Oct 2017 22:26:36 -0400
In-Reply-To: <CAJ4mKGbYnyd1sMFZGM-RZ+448fJ+XsnGquJ-ZOyZwPxQGwaydg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Xie Xingguo <xie.xingguo@zte.com.cn>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-763005413-1509416795=:2819
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 30 Oct 2017, Gregory Farnum wrote:
> On Thu, Oct 26, 2017 at 9:21 AM Josh Durgin <jdurgin@redhat.com> wrote:
> >
> > On 10/26/2017 07:26 AM, Sage Weil wrote:
> > > On Thu, 26 Oct 2017, Gregory Farnum wrote:
> > >> On Wed, Oct 25, 2017 at 8:57 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> > >>> On 10/25/2017 05:16 AM, Sage Weil wrote:
> > >>>>
> > >>>> Hi Xingguo,
> > >>>>
> > >>>> On Wed, 25 Oct 2017, xie.xingguo@zte.com.cn wrote:
> > >>>>>
> > >>>>>         I wonder why erasure-pools can not support omap currently.
> > >>>>>
> > >>>>>         The simplest way for erasure-pools to support omap I can figure
> > >>>>> out would be duplicating omap on every shard.
> > >>>>>
> > >>>>>         It is because it consumes too much space when k + m gets bigger?
> > >>>>
> > >>>>
> > >>>> Right.  There isn't a nontrivial way to actually erasure code it, and
> > >>>> duplicating on every shard is inefficient.
> > >>>>
> > >>>> One reasonableish approach would be to replicate the omap data on m+1
> > >>>> shards.  But it's a bit of work to implement and nobody has done it.
> > >>>>
> > >>>> I can't remember if there were concerns with this approach or it was just
> > >>>> a matter of time/resources... Josh? Greg?
> > >>>
> > >>>
> > >>> It restricts us to erasure codes like reed-solomon where a subset of shards
> > >>> are always updated. I think this is a reasonable trade-off though, it's just
> > >>> a matter of implementing it. We haven't written
> > >>> up the required peering changes, but they did not seem too difficult to
> > >>> implement.
> > >>>
> > >>> Some notes on the approach are here - just think of 'replicating omap'
> > >>> as a partial write to m+1 shards:
> > >>>
> > >>> http://pad.ceph.com/p/ec-partial-writes
> > >>
> > >> Yeah. To expand a bit on why this only works for Reed-Solomon,
> > >> consider the minimum and appropriate number of copies — and the actual
> > >> shard placement — for local recovery codes. :/ We were unable to
> > >> generalize for that (or indeed for SHEC, IIRC) when whiteboarding.
> > >>
> > >> I'm also still nervous that this might do weird things to our recovery
> > >> and availability patterns in more complex failure cases, but I don't
> > >> have any concrete issues.
> > >
> > > It seems like the minimum-viable variation of this is that we don't change
> > > any of the peering or logging behavior at all, but just send the omap
> > > writes to all shards (like any other write), but only the annointed shards
> > > persist.
> > >
> > > That leaves lots of room for improvement, but it makes the feature work
> > > without many changes, and means we can drop the specialness around rbd
> > > images in EC pools.
> >
> > Won't that still require recovery and read path changes?
> 
> 
> I also don't understand at all how this would work. Can you expand, Sage?

On write, the ECTransaction collects the omap operation.  We either send 
it to all shards or slide just the omap key/value data for shard_id > k.  
For shard_id <= k, we write the omap data to the local object.  We still 
send the write op to all shards with attrs and pg log entries.

We take care to always select the first acting shard as the primary, which 
will ensure a shard_id <= k if we go active, such that cls operations and 
omap reads can be handled locally.

Hmm, I think the problem is with rollback, though.  IIRC the code is 
structured around rollback and not rollforward, and omap writes are blind.  

So, not trivial, but it doesn't require any of the stuff we were talking 
about before where we'd only send writes to a subset of shards and have 
incomplete pg logs on each shard.

sage
--8323329-763005413-1509416795=:2819--
