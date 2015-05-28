From: Gregory Farnum <greg@gregs42.com>
Subject: Re: RBD mirroring design draft
Date: Wed, 27 May 2015 22:37:58 -0700
Message-ID: <CAC6JEv_gGMnNUVFr5m2PaTum9Pa2z2YadVSJA+JBE7BvqOMKuA@mail.gmail.com>
References: <55529E04.1070202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35195 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbE1FiA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 01:38:00 -0400
Received: by qkdn188 with SMTP id n188so19032910qkd.2
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 22:38:00 -0700 (PDT)
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com. [209.85.220.178])
        by mx.google.com with ESMTPSA id p100sm635939qkp.3.2015.05.27.22.37.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 22:37:59 -0700 (PDT)
Received: by qkoo18 with SMTP id o18so19035855qko.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 22:37:58 -0700 (PDT)
In-Reply-To: <55529E04.1070202@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, John Spray <john.spray@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 12, 2015 at 5:42 PM, Josh Durgin <jdurgin@redhat.com> wrote=
:
> We've talked about this a bit at ceph developer summits, but haven't
> gone through several parts of the design thoroughly. I'd like to post
> this to a wider audience and get feedback on this draft of a design.
>
> The journal parts are more defined, but the failover/failback workflo=
w
> and general configuration need more fleshing out. Enabling/disabling
> journaling on existing images isn't described yet, though it's
> something that should be supported.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RBD Mirroring
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The goal of rbd mirroring is to provide disaster recovery for rbd
> images.
>
> This includes:
>
> 1) maintaining a crash-consistent view of an image
> 2) streaming updates from one site to another
> 3) failover/failback
>
> I'll refer to different (cluster, pool1, [pool2, ... poolN]) combinat=
ions
> where rbd images are stored as "zones" here, which would be a new
> abstraction introduced for easier configuration of mirroring. This is
> the same term used by radosgw replication.
>
> Crash consistency
> -----------------
>
> This is the basic level of consistency block devices can provide with
> no higher-level hooks, like qemu's guest agent. For replaying a strea=
m
> of block device writes, higher-level hooks could make sense, but thes=
e
> could be added later as points in a stream of writes. For crash
> consistency, rbd just needs to maintain the order of writes. There ar=
e
> a few ways to do this:
>
> a) snapshots
>
>   rbd has supported differential snapshots for a while now, and these
>   are great for performing backups. They don't work as well for
>   providing a stream of consistent updates, since there is overhead i=
n
>   space and I/O load to creating and deleting rados snapshots. For
>   backend filesystems like xfs and ext4, frequent snapshots would tur=
n
>   many small writes into copies of 4MB and a small write, wasting
>   space. Deleting snapshots is also expensive if there hundreds or
>   thousands happening all the time. Rados snapshots were not designed
>   for this kind of load. In addition, diffing snapshots does not tell
>   us the order in which writes were done, so a partially applied
>   diff would be inconsistent and likely unusable.
>
> b) log-structured rbd
>
>   The simplest way to keep writes in order is to only write them in
>   order, by appending to a log of rados objects. This is great for
>   mirroring, but vastly complicates everything else. This would
>   require all the usual bells and whistles of a log-structured
>   filesystem, including garbage collection, reference tracking, a new
>   rbd-level snapshot mechanism, and more. Custom fsck-like tools for
>   consistency checking and repair would be needed, and the I/O paths
>   would be much more complex. This is a good research project, but
>   it would take a long time to develop and stabilize.
>
> c) journaling
>
>   Journaling is an intermediate step between snapshots and log
>   structured rbd. The idea is that each image has a log of all writes
>   (including data) and metadata changes, like resize, snapshot
>   create/delete, etc. This journal is stored as a series of rados
>   objects, similar to cephfs' journal. A write would first be appende=
d
>   to the journal, acked to the librbd user at that point, and later
>   written out to the usual rbd data objects. Extending rbd's existing
>   client-side cache to track this allows reads of data written to the
>   journal but not the data objects to be satisfied from the cache, an=
d
>   avoids issues of stale reads. This data needs to be kept in memory
>   anyway, so it makes sense to keep it in the cache, where it can be
>   useful.
>
> Structure
> ^^^^^^^^^
>
> The journal could be stored in a separate pool from the image, such a=
s
> one backed by ssds to improve write performance. Since it is
> append-only, the journal's data could be stored in an EC pool to save
> space.

This is a lot trickier than it sounds. Remember you need to append to
an EC pool in the appropriate append block size =E2=80=94 the smallest =
such
size that is really feasible is going to be 4KB * M. I'm not sure what
sizes our RBD writes usually come down in, but I can see them being
rather smaller...

>
> It will need some metadata regarding positions in the journal. These
> could be stored as omap values in a 'journal header' object in a
> replicated pool, for rbd perhaps the same pool as the image for
> simplicity. The header would contain at least:
>
> * pool_id - where journal data is stored
> * journal_object_prefix - unique prefix for journal data objects
> * positions - (zone, purpose, object num, offset) tuples indexed by z=
one
> * object_size - approximate size of each data object
> * object_num_begin - current earliest object in the log
> * object_num_end - max potential object in the log
>
> Similar to rbd images, journal data would be stored in objects named
> after the journal_object_prefix and their object number. To avoid
> issues of padding or splitting journal entries, and to make it simple=
r
> to keep append-only, it's easier to allow the objects to be near
> object_size before moving to the next object number instead of
> sticking with an exact object size.
>
> Ideally this underlying structure could be used for both rbd and
> cephfs. Variable sized objects are different from the existing cephfs
> journal, which uses fixed-size objects for striping. The default is
> still 4MB chunks though. How important is striping the journal to
> cephfs? For rbd it seems unlikely to help much, since updates need to
> be batched up by the client cache anyway.

I think the journaling v2 stuff that John did actually made objects
variably-sized as you've described here. We've never done any sort of
striping on the MDS journal, although I think it was
possible.previously.

>
> Usage
> ^^^^^
>
> When an rbd image with journaling enabled is opened, the journal
> metadata would be read and the last part of the journal would be
> replayed if necessary.
>
> In general, a write would first go to the journal, return to the
> client, and then be written to the underlying rbd image. Once a
> threshold of bytes of journal entries are flushed, or a time period i=
s
> reached and some journal entries were flushed, a position with purpos=
e
> "flushed" for the zone the rbd image is in would be updated in the
> journal metadata.

Can you expand on this a bit? I think you're here referring to the
up-to-date tags on each zone, but I'm not quite sure =E2=80=94 and it b=
rings
up questions like how the local image is aware of which zones are
mirroring it (possibly addressed later; I haven't finished reading
yet).

>
> Trimming old entries from the journal would be allowed up to the
> minimum of all the positions stored in its metadata. This would be an
> asynchronous operation executed by the consumers of the journal.
>
> There would be a new feature bit for rbd images to enable
> journaling. As a first step it could only be set when an image is
> created.
>
> One way to enable it dynamically would be to take a snapshot at the
> same time to serve as a base for mirroring further changes.  This
> could be added as a journal entry for snapshot creation with a specia=
l
> 'internal' flag, and the snapshot could be deleted by the process tha=
t
> trims this journal entry.
>
> Deleting an image would delete its journal, despite any mirroring in
> progress, since mirroring is not backup.

I suspect that this is going to make some users sad. We've already got
people doing stuff like taking snapshots of RGW pools (don't, it
doesn't work right!) in order to protect against accidental deletions.

>
> Streaming Updates
> -----------------
>
> This a complex area with many trade-offs. I expect we'll need some
> iteration to find good general solutions here. I'll describe a simple
> initial step, and some potential optimizations, and issues to address
> in future versions.
>
> In general, there will be a new daemon (tentatively called rbd-mirror
> here) that reads journal entries from images in one zone and replays
> them in different zones. An initial implementation might connect to
> ceph clusters in all zones, and replay writes and metadata changes to
> images in other zones directly via librbd. To simplify failover, it
> would be better to run these in follower zones rather than the leader
> zone.
>
> There are a couple of improvements on this we'd probably want to make
> early:
>
> * using multiple threads to mirror many images at once
> * using multiple processes to scale across machines, so one node is
> not a bottleneck
>
> Some other possible optimizations:
> * reading a large window of the journal to coalesce overlapping write=
s
> * decoupling reading from the leader zone and writing to follower zon=
es,
> to allow optimizations like compression of the journal or other
> transforms as data is sent, and relaxing the requirement for one node
> to be directly connected to more than one ceph cluster

Yeah. We actually already have formats in use by the ceph-objectstore
tool and some of the CephFS metadata dump commands for dumping out
data; we might want to start out by basing the transfer on these. I'm
not sure we really get much by making the replay daemons a unified
system to begin with versus having a reader generating a stream and a
writer replaying it. And if they start off separate they're much
easier to optimize in ways like you've already discussed.

>
> Noticing updates
> ^^^^^^^^^^^^^^^^
>
> There are two kinds of changes that rbd-mirror needs to be aware of:
>
> 1) journaled image creation/deletion
>
> The features of an image are only stored in the image's header right
> now. To get updates of these more easily, we need an index of some
> sort. This could take the form of an additional index in the
> rbd_directory object, which already contains all images. Creating or
> deleting an image with the journal feature bit could send a rados
> notify on the rbd_directory object, and rbd-mirror could watch
> rbd_directory for these notifications. The notifications could contai=
n
> information about the image (at least its features), but if
> rbd-mirror's watch times out it could simply re-read the features of
> all images in a pool that it cares about (more on this later).

Do we actually need to store the features in the rbd_directory,
instead of simply having the mirror reader daemon check each new
image?
Do you plan to have any sort of separate database of the mirror
daemon's internal state so that on restart it can behave in a vaguely
efficient fashion instead of an order-N pass?

>
> Dynamically enabling/disabling features would work the same way. The
> image header would be updated as usual, and the rbd_directory index
> would be updated as well. If the journaling feature bit changed, a
> notify on the rbd_directory object would be sent.
>
> Since we'd be storing the features in two places, to keep them in syn=
c
> we could use an approach like:
>
> a) set a new updated_features field on image header
> b) set features on rbd_directory
> c) clear updated_features and set features on image header
>
> This is all through the lock holder, so we don't need to worry about
> concurrent updates - header operations are prefixed by an assertion
> that the lock is still held for extra safety.
>
> 2) journal updates for a particular image
>
> Generally rbd-mirror can keep reading the journal until it hits the
> end, detected by -ENOENT on an object or less than the journal's
> target object size.
>
> Once it reaches the end, it can poll for new content periodically, or
> use notifications like watch/notify on the journal header for the max
> journal object number to change. I don't think polling in this case i=
s
> very expensive, especially if it uses exponential backoff to a
> configurable max time it can be behind the journal.
>
> Clones
> ^^^^^^
>
> Cloning is currently the only way images can be related. Mirroring
> should preserve these relationships so mirrored zones behave the same
> as the original zone.
>
> In order for clones with non-zero overlap to be useful, their parent
> snapshot must be present in the zone already. A simple approach is to
> avoid mirroring clones until their parent snapshot is mirrored.
>
> Clones refer to parents by pool id, image id, and snapshot id. These
> are all generated automatically when each is created, so they will be
> different in different zones. Since pools and images can be renamed,
> we'll need a way to make sure we keep the correct mappings in mirrore=
d
> zones. A simple way to do this is to record a leader zone ->
> follower zone mapping for pool and image ids. When a pool or image
> is created in follower zones, their mapping to the ids in the leader
> zone would be stored in the destination zone.
>
> Parallelism
> ^^^^^^^^^^^
>
> Mirroring many images is embarrassingly parallel. A simple unit of
> work is an image (more specifically a journal, if e.g. a group of
> images shared a journal as part of a consistency group in the future)=
=2E
>
> Spreading this work across threads within a single process is
> relatively simple. For HA, and to avoid a single NIC becoming a
> bottleneck, we'll want to spread out the work across multiple
> processes (and probably multiple hosts). rbd-mirror should have no
> local state, so we just need a mechanism to coordinate the division o=
f
> work across multiple processes.
>
> One way to do this would be layering on top of watch/notify. Each
> rbd-mirror process in a zone could watch the same object, and shard
> the set of images to mirror based on a hash of image ids onto the
> current set of rbd-mirror processes sorted by client gid. The set of
> rbd-mirror processes could be determined by listing watchers.

You're going to have some tricky cases here when reassigning authority
as watchers come and go, but I think it should be doable.

>
> Failover
> --------
>
> Watch/notify could also be used (via a predetermined object) to
> communicate with rbd-mirror processes to get sync status from each,
> and for managing failover.
>
> Failing over means preventing changes in the original leader zone, an=
d
> making the new leader zone writeable. The state of a zone (read-only =
vs
> writeable) could be stored in a zone's metadata in rados to represent
> this, and images with the journal feature bit could check this before
> being opened read/write for safety. To make it race-proof, the zone
> state can be a tri-state - read-only, read-write, or changing.

If you want these states to be authoritative you're going to have a
bit of a tricky time =E2=80=94 what happens when you do the failover an=
d then
the old leader zone comes back up and think it's a leader? How do
rbd-mirror processes elsewhere react?
If nothing else you'll definitely need leader epochs, and possibly
more. Our experience with RGW DR has taught us that these
follower-leader paradigms are really difficult to get right. :(

>
> In the original leader zone, if it is still running, the zone would b=
e
> set to read-only mode and all clients could be blacklisted to avoid
> creating too much divergent history to rollback later.
>
> In the new leader zone, the zone's state would be set to 'changing',
> and rbd-mirror processes would be told to stop copying from the
> original leader and close the images they were mirroring to.  New
> rbd-mirror processes should refuse to start mirroring when the zone i=
s
> not read-only. Once the mirroring processes have stopped, the zone
> could be set to read-write, and begin normal usage.
>
> Failback
> ^^^^^^^^
>
> In this scenario, after failing over, the original leader zone (A)
> starts running again, but needs to catch up to the current leader
> (B). At a high level, this involves syncing up the image by rolling
> back the updates in A past the point B synced to as noted in an
> images's journal in A, and mirroring all the changes since then from
> B.

How do you envision this rollback happening? I don't see how it's
feasible =E2=80=94 you can't possibly wait on writeback of data until i=
t's
mirrored to all zones, and once it's written to the backing image
there's no undoing it.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
