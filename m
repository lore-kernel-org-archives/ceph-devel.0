From: Sage Weil <sage@inktank.com>
Subject: RE: RBD thoughts
Date: Wed, 7 May 2014 09:12:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405061418490.28165@cobra.newdream.net>
References: <7334B4281E425749B85E08CF7EC6F8531F5C93CE@SACMBXIP01.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1405060837530.28165@cobra.newdream.net> <7334B4281E425749B85E08CF7EC6F8531F5CA5D5@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50808 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbaEGQMh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 12:12:37 -0400
In-Reply-To: <7334B4281E425749B85E08CF7EC6F8531F5CA5D5@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: ceph-devel@vger.kernel.org

[Moving this thread to ceph-devel]

-----Original Message-----

Sage wrote:
> Allen wrote:
> > I was looking over the CDS for Giant and was paying particular
> > attention to the rbd journaling stuff. Asynchronous geo-replications
> > for block devices is really a key for enterprise deployment and this
> > is the foundational element of that. It?s an area that we are keenly
> > interested in and would be willing to devote development resources
> > toward. It wasn?t clear from the recording whether this was just
> > musings or would actually be development for Giant, but when you get
> > your head above water w.r.t. the acquisition I?d like to investigate
> > how we (Sandisk) could help turn this into a real project. IMO, this is MUCH more important than CephFS stuff for penetrating enterprises.
> >
> > The blueprint suggests the creation of an additional journal for the
> > block device and that this journal would track metadata changes and
> > potentially record overwritten data (without the overwritten data you
> > can only sync to snapshots ? which will be reasonable functionality
> > for some use-cases). It seems to me that this probably doesn?t work
> > too well. Wouldn?t it be the case that you really want to commit to
> > the journal AND to the block device atomically? That?s really
> > problematic with the current RADOS design as the separate journal
> > would be in a separate PG from the target block and likely on a
> > separate OSD. Now you have all sorts of cases of crashes/updates where the journal and the target block are out of sync.
> 
> The idea is to make it a write-ahead journal, which avoids any need for 
> atomicity.  The writes are streamed to the journal, and applied to the 
> rbd image proper only after they commit there.  Since block operations 
> are effeictively idempotent (you can replay the journal from any point 
> and the end result is always the same) the recovery case is pretty 
> simple.

Who is responsible for the block device part of the commit?. If it's the 
RBD code rather than the OSD, then I think there's a dangerous failure 
case where the journal commits and then the client crashes and the 
journal-based replication system ends up replicating the last 
(un-performed) write operation. If it's the OSDs that are responsible, 
then this is not an issue.
 
> Similarly, I don't think the snapshot limitation is there; you can 
> simply note the journal offset, then copy the image (in a racy way), and 
> then replay the journal from that position to capture the recent 
> updates.
 
w.r.t. snapshots and non-old-data-preserving journaling mode, How will you 
deal with the race between reading the head of the journal and reading the 
data referenced by that head of the journal that could be over-written by 
a write operation before you can actually read it?
 
> > Even past the functional level issues this probably creates a 
> > performance hot-spot too ? also undesirable.
> 
> For a naive journal implementation and busy block device, yes.  What I'd 
> like to do, though, is make a journal abstraction on top of librados 
> that can eventually also replace the current MDS journaler and do things 
> a bit more intelligently.  The main thing would be to stripe events over 
> a set of objects to distribute the load.  For the MDS, there are a bunch 
> of other minor things we want to do to streamline the implementation and 
> to improve the ability to inspect and repair the journal.
> 
> Note that the 'old data' would be an optional thing that would only be 
> enabled if the user wanted the ability to rewind.
> 
> > It seems to me that the extra journal isn?t necessary, i.e., that the 
> > current PG log already has most of the information that?s needed (it 
> > doesn?t have the ?old data?, but that?s easily added ? in fact it?s 
> > cheaper to add it in with a special transaction token because you 
> > don?t have to send the ?old data? over the wire twice? the OSD can 
> > read it locally to put into the PG log). Of course, PG logs aren?t 
> > synchronized across the pool but that?s easy [...]
> 
> I don't think the pg log can be sanely repurposed for this.  It is a 
> metadata journal only, and needs to be in order to make peering work 
> effectively, whereas the rbd journal needs to be a data journal to work 
> well.  Also, if the updates are spread across all of the rbd image 
> blocks/objects, then it becomes impractical to stream them to another 
> cluster because you'll need to watch for those updates on all objects 
> (vs just the journal objects)...

I don't see the difference between the pg-log "metadata" journal and the 
rbd journal (when running in the 'non-old-data-preserving' mode). 
Essentially, the pg-log allows a local replica to "catch up", how is that 
different then allowing a non-local rbd to "catch up"??
