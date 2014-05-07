From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: RBD thoughts
Date: Wed, 7 May 2014 18:22:32 +0000
Message-ID: <7334B4281E425749B85E08CF7EC6F8531F5CBBB1@SACMBXIP01.sdcorp.global.sandisk.com>
References: <7334B4281E425749B85E08CF7EC6F8531F5C93CE@SACMBXIP01.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1405060837530.28165@cobra.newdream.net>
 <7334B4281E425749B85E08CF7EC6F8531F5CA5D5@SACMBXIP01.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1405061418490.28165@cobra.newdream.net>
 <alpine.DEB.2.00.1405070912450.31818@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:57434
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750884AbaEGSWi convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 May 2014 14:22:38 -0400
In-Reply-To: <alpine.DEB.2.00.1405070912450.31818@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ok, now I think I understand. Essentially, you have a write-ahead log + lazy application of the log to the backend + code that correctly deals with the RAW hazard (same as Cassandra, FileStore, LevelDB, etc.). Correct?

So every block write is done three times, once for the replication journal, once in the FileStore journal and once in the target file system. Correct?

Also, if I understand the architecture, you'll be moving the data over the network at least one more time (* # of replicas). Correct?

This seems VERY expensive in system resources, though I agree it's a simpler implementation task.

-----------------------------------------------------------
Never put off until tomorrow what you can do the day after tomorrow.
 Mark Twain

Allen Samuels
Chief Software Architect, Emerging Storage Solutions

951 SanDisk Drive, Milpitas, CA 95035
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


-----Original Message-----
From: Sage Weil [mailto:sage@inktank.com]
Sent: Wednesday, May 07, 2014 9:24 AM
To: Allen Samuels
Cc: ceph-devel@vger.kernel.org
Subject: RE: RBD thoughts

On Wed, 7 May 2014, Allen Samuels wrote:
> Sage wrote:
> > Allen wrote:
> > > I was looking over the CDS for Giant and was paying particular
> > > attention to the rbd journaling stuff. Asynchronous
> > > geo-replications for block devices is really a key for enterprise
> > > deployment and this is the foundational element of that. It?s an
> > > area that we are keenly interested in and would be willing to
> > > devote development resources toward. It wasn?t clear from the
> > > recording whether this was just musings or would actually be
> > > development for Giant, but when you get your head above water
> > > w.r.t. the acquisition I?d like to investigate how we (Sandisk) could help turn this into a real project. IMO, this is MUCH more important than CephFS stuff for penetrating enterprises.
> > >
> > > The blueprint suggests the creation of an additional journal for
> > > the block device and that this journal would track metadata
> > > changes and potentially record overwritten data (without the
> > > overwritten data you can only sync to snapshots ? which will be
> > > reasonable functionality for some use-cases). It seems to me that
> > > this probably doesn?t work too well. Wouldn?t it be the case that
> > > you really want to commit to the journal AND to the block device
> > > atomically? That?s really problematic with the current RADOS
> > > design as the separate journal would be in a separate PG from the
> > > target block and likely on a separate OSD. Now you have all sorts of cases of crashes/updates where the journal and the target block are out of sync.
> >
> > The idea is to make it a write-ahead journal, which avoids any need
> > for atomicity.  The writes are streamed to the journal, and applied
> > to the rbd image proper only after they commit there.  Since block
> > operations are effeictively idempotent (you can replay the journal
> > from any point and the end result is always the same) the recovery
> > case is pretty simple.
>
> Who is responsible for the block device part of the commit?. If it's
> the RBD code rather than the OSD, then I think there's a dangerous
> failure case where the journal commits and then the client crashes and
> the journal-based replication system ends up replicating the last
> (un-performed) write operation. If it's the OSDs that are responsible,
> then this is not an issue.

The idea is to use the usual set of write-ahead journaling tricks: we write first to the journal, then to the device, and lazily update a pointer indicating which journal events have been applied.  After a crash, the new client will reapply anything in the journal after that point to ensure the device is in sync.

While the device is in active use, we'd need to track which writes have not yet been applied to the device so we can delay a read following a recent write until it is applied.  (This should be very rare, given that the file system sitting on top of the device is generally doing all sorts of caching.)

This only works, of course, for use-cases where there is a single active writer for the device.  That means it's usable for local file systems like
ext3/4 and xfs, but not for someting like ocfs2.

> > Similarly, I don't think the snapshot limitation is there; you can
> > simply note the journal offset, then copy the image (in a racy way),
> > and then replay the journal from that position to capture the recent
> > updates.
>
> w.r.t. snapshots and non-old-data-preserving journaling mode, How will
> you deal with the race between reading the head of the journal and
> reading the data referenced by that head of the journal that could be
> over-written by a write operation before you can actually read it?

Oh, I think I'm using different terminology.  I'm assuming that the journal includes the *new* data (ala data=journal mode for ext*).  We talked a bit at CDS about an optional separate journal with overwritten data so that you could 'rewind' activity on an image, but that is probably not what you were talking about :).

> > > Even past the functional level issues this probably creates a
> > > performance hot-spot too ? also undesirable.
> >
> > For a naive journal implementation and busy block device, yes.  What
> > I'd like to do, though, is make a journal abstraction on top of
> > librados that can eventually also replace the current MDS journaler
> > and do things a bit more intelligently.  The main thing would be to
> > stripe events over a set of objects to distribute the load.  For the
> > MDS, there are a bunch of other minor things we want to do to
> > streamline the implementation and to improve the ability to inspect and repair the journal.
> >
> > Note that the 'old data' would be an optional thing that would only
> > be enabled if the user wanted the ability to rewind.
> >
> > > It seems to me that the extra journal isn?t necessary, i.e., that
> > > the current PG log already has most of the information that?s
> > > needed (it doesn?t have the ?old data?, but that?s easily added ?
> > > in fact it?s cheaper to add it in with a special transaction token
> > > because you don?t have to send the ?old data? over the wire twice?
> > > the OSD can read it locally to put into the PG log). Of course, PG
> > > logs aren?t synchronized across the pool but that?s easy [...]
> >
> > I don't think the pg log can be sanely repurposed for this.  It is a
> > metadata journal only, and needs to be in order to make peering work
> > effectively, whereas the rbd journal needs to be a data journal to
> > work well.  Also, if the updates are spread across all of the rbd
> > image blocks/objects, then it becomes impractical to stream them to
> > another cluster because you'll need to watch for those updates on
> > all objects (vs just the journal objects)...
>
> I don't see the difference between the pg-log "metadata" journal and
> the rbd journal (when running in the 'non-old-data-preserving' mode).
> Essentially, the pg-log allows a local replica to "catch up", how is
> that different then allowing a non-local rbd to "catch up"??

The PG log only indicates which objects were touched and which versions are (now) the latest.  When recovery happens, we go get the latest version of the object from the usual location.  If there are two updates to the same object the log tells us that happens but we don't preserved the intermediate version.  The rbd data journal, on the other hand, would preserve the full update timeline, ensuring that we have a fully-coherent view of the image at any point in the timeline.

--

In any case, this is the proposal we originally discussed at CDS.  I'm not sure if it's the best or most efficient, but I think it is relatively simple to implement and takes advantage of the existing abstractions and interfaces.  Input is definitely welcome!  I'm skeptical that the pg log will be useful in this case, but you're right that the overhead with the proposed approach is non-trivial...

sage


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).


