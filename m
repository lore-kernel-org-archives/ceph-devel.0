From: Sage Weil <sweil@redhat.com>
Subject: Re: bluestore prefer wal size
Date: Mon, 6 Mar 2017 17:53:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703061752210.24356@piezo.novalocal>
References: <alpine.DEB.2.11.1702011533340.3660@piezo.novalocal> <001001d27cbd$cee2a9f0$6ca7fdd0$@fisk.me.uk> <bb0bdeb6.AEMAHeJMfMsAAAAAAAAAAFklQUsAADNJBWwAAAAAAACRXwBYklNO@mailjet.com> <alpine.DEB.2.11.1702012137240.3654@piezo.novalocal>
 <45ba3843.AEEAHxSt8JAAAAAAAAAAAFklQUsAADNJBWwAAAAAAACRXwBYkldP@mailjet.com> <alpine.DEB.2.11.1702012147430.3654@piezo.novalocal> <alpine.DEB.2.11.1702012211300.3654@piezo.novalocal> <00bb01d27d45$21a48050$64ed80f0$@fisk.me.uk>
 <d0caeb89.AEUAHScduCcAAAAAAAAAAFPDZXcAADNJBWwAAAAAAACRXwBYk0Zd@mailjet.com> <c46b5c16-340e-7d9c-b7d9-ad8a21b22b6f@redhat.com> <002101d27d99$5e266ad0$1a734070$@fisk.me.uk> <5ed3f3b2.ADsAAGRwZ_AAAAAAAAAAAFPDZXcAADNJBWwAAAAAAACRXwBYlFIS@mailjet.com>
 <9e79a955-99d9-4cd7-df27-d18a36921a0d@redhat.com> <ba5b6d21.ADsAAGSJJ-oAAAAAAAAAAFJy4NwAADNJBWwAAAAAAACRXwBYlKUc@mailjet.com> <alpine.DEB.2.11.1703051956410.24356@piezo.novalocal> <a2725b53-1f31-76d3-b8cb-93983bd3bf71@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1995646361-1488822799=:24356"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753906AbdCFTUR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Mar 2017 14:20:17 -0500
In-Reply-To: <a2725b53-1f31-76d3-b8cb-93983bd3bf71@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Nick Fisk <nick@fisk.me.uk>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1995646361-1488822799=:24356
Content-Type: TEXT/PLAIN; charset=iso-8859-7
Content-Transfer-Encoding: 8BIT

On Mon, 6 Mar 2017, Mark Nelson wrote:
> On 03/06/2017 08:59 AM, Sage Weil wrote:
> > On Fri, 3 Feb 2017, Nick Fisk wrote:
> > > Hi Mark,
> > > 
> > > > -----Original Message-----
> > > > From: Mark Nelson [mailto:mnelson@redhat.com]
> > > > Sent: 03 February 2017 15:20
> > > > To: nick@fisk.me.uk; 'Sage Weil' <sage@newdream.net>
> > > > Cc: ceph-devel@vger.kernel.org
> > > > Subject: Re: bluestore prefer wal size
> > > > 
> > > > Hi Nick,
> > > > 
> > > > So I'm still catching up to your testing, but last night I ran through a
> > > > number of tests with a single OSD, a single client, and iodepth=1 fio
> > > > rbd tests:
> > > > 
> > > > https://drive.google.com/uc?export=download&id=0B2gTBZrkrnpZWE85OFI3Q2xQZ00
> > > > 
> > > > I tested HDD, HDD+NVMe, and NVMe configurations looking at filestore,
> > > > bluestore with 1k and 16k prefer wal sizes.  I believe I'm
> > > > seeing similar results to what you saw.  On NVMe we are pretty similar
> > > > likely due to the raw backend throughput the NVMe drives can
> > > > maintain but on HDD, bluestore is doing quite a bit worse than filestore
> > > > for this specific use case.  During the bluestore HDD tests, I
> > > > watched disk access and it appears we are saturating the disk with small
> > > > writes despite the low client performance.  I'll be digging into
> > > > this more today but I wanted to send out an update to let you know I
> > > > believe I've reproduced your results and am looking into it.
> > > 
> > > Glad to hear that you can reproduce. After debugging that IF statement,
> > > I think I'm at the point where I am out of my depth. But if there is
> > > anything I can do, let me know.
> > 
> > I finally got my dev box HDD sorted out and retested this.  The IOPS were
> > being halved because bluestore was triggering a rocksdb commit (and the
> > associated latency) just to retire the WAL record.  I rebased and fixed it
> > so that the WAL entries are deleted lazily (in the next commit round) and
> > it's 2x faster than before.  I'm getting ~110 IOPS with rados bench 4k
> > writes with queue depth 1 (6TB 7200rpm WD black).  That's in the
> > neighborhood of what I'd expect from a spinner... it's basically seeking
> > back and forth between two write positions (the rocksdb log and the new
> > object data where the allocator position is).  We could probably bring
> > this up a bit by making the WAL work be batched on HDD (build up several
> > IOs worth and dispatch it all at once to reduce seeks).  That'll take a
> > bit more work, though.

I've made this change too, and now I get about 400 IOPS out of a straight 
HDD (no SSD).  Much better!  I set up the tunables so that it does the 
batching behavior only for HDD and not for SSD; we may want to revisit 
that decision later.

> > With WAL on an NVMe, I get about ~450 IOPS.
> > 
> > Want to give it a try?
> 
> What's the branch?

wip-bluestore-prefer-wal-size

sage


> 
> 
> > sage
> > 
> > 
> >  >
> > > > 
> > > > Thanks!
> > > > Mark
> > > > 
> > > > On 02/03/2017 03:49 AM, Nick Fisk wrote:
> > > > > 
> > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Nick Fisk [mailto:nick@fisk.me.uk]
> > > > > > Sent: 02 February 2017 21:15
> > > > > > To: 'Mark Nelson' <mnelson@redhat.com>; 'Sage Weil'
> > > > > > <sage@newdream.net>
> > > > > > Cc: ceph-devel@vger.kernel.org
> > > > > > Subject: RE: bluestore prefer wal size
> > > > > > 
> > > > > > Hi Mark,
> > > > > > > -----Original Message-----
> > > > > > > From: Mark Nelson [mailto:mnelson@redhat.com]
> > > > > > > Sent: 02 February 2017 20:17
> > > > > > > To: nick@fisk.me.uk; 'Sage Weil' <sage@newdream.net>
> > > > > > > Cc: ceph-devel@vger.kernel.org
> > > > > > > Subject: Re: bluestore prefer wal size
> > > > > > > 
> > > > > > > Hi Nick,
> > > > > > > 
> > > > > > > On 02/02/2017 08:46 AM, Nick Fisk wrote:
> > > > > > > > Further update
> > > > > > > > 
> > > > > > > > If I do random writes instead of sequential, I see the "defering
> > > > > > > > small write
> > > > > > > via wal" action. But from the do_alloc_write function not small
> > > > > > > write.
> > > > > > > >  Ie. log entry is:
> > > > > > > > _do_alloc_write defering small 0x1000 write via wal
> > > > > > > 
> > > > > > > I just ran some tests using the branch with 4k random and
> > > > > > > sequential
> > > > > > > writes against a single OSD.  I see deferring small write via wal
> > > > > > > from do_alloc_write both for both sequential and random when
> > > > > > > bluestore_prefer_wal_size is set to be larger than the IO size.
> > > > > > > Otherwise, I don't see the messages.  I am also preconditioning
> > > > > > > with
> > > > > > > 4MB writes.
> > > > > > > 
> > > > > > > So far I've just been testing on NVMe, but I should be able to do
> > > > > > > some mixed tests soon to see if there are any interesting
> > > > > > > performance implications.
> > > > > > 
> > > > > > I've just looked at the RBD I ran those random tests on and I
> > > > > > realized that it was only about 90% pre-conditioned due to me
> > > > > > leaving
> > > > > > the time_based fio option on. After filling completely with writes,
> > > > > > now both random and sequential are doing _do_write_small
> > > > writes and no deferring wal writes.
> > > > > > 
> > > > > > From looking through the code today, as far as I understand it
> > > > > > 
> > > > > > Write_small = write to existing object under min_allow_size
> > > > > > Write_big
> > > > > > = write to existing object over min_allow_size Alloc_write = write
> > > > > > to
> > > > > > a new object
> > > > > > 
> > > > > > Is that correct?
> > > > > > 
> > > > > > If it is, I'm interested in why you are seeing alloc_writes, as I
> > > > > > don't see them if the RBD is fully pre-conditioned? Unless there is
> > > > > > something changing with the min_alloc_size as you are using non
> > > > rotational media, which is causing this change?
> > > > > > 
> > > > > > I'm adding a few extra dout's to the write_small function to try and
> > > > > > see what's going on, hopefully I will know more tomorrow.
> > > > > > 
> > > > > 
> > > > > Morning,
> > > > > 
> > > > > So, results are in. I added some debugging before the IF statement
> > > > > (https://github.com/liewegas/ceph/blob/944b4d3a3869a472c1e66a4fa73c127
> > > > > 66c7801ac/src/os/bluestore/BlueStore.cc#L7885)
> > > > > 
> > > > > So the following section now looks like below:
> > > > > 
> > > > >     dout(20) << __func__ << "  before IF 0x" << std::hex << b_off <<
> > > > > "~" << b_len << " - " << b->get_blob().get_ondisk_length() << " -
> > > > " << b->get_blob().is_unused(b_off, b_len) << " - " <<
> > > > b->get_blob().is_allocated(b_off, b_len) << " - " << dendl;
> > > > >     if ((b_off % chunk_size == 0 && b_len % chunk_size == 0) &&
> > > > >         b->get_blob().get_ondisk_length() >= b_off + b_len &&
> > > > >         b->get_blob().is_unused(b_off, b_len) &&
> > > > >         b->get_blob().is_allocated(b_off, b_len)) {
> > > > > 
> > > > > And the output was
> > > > > 
> > > > > _do_write_small  before IF 0xf000~1000 - 10000 - 0 - 1 -
> > > > > 
> > > > > So the " b->get_blob().is_unused(b_off, b_len)" call is returning
> > > > > false, which stops it going into the IF block and doing the prefer wal
> > > > write. Is that expected?
> > > > > 
> > > > > Nick
> > > > > 
> > > > > > Nick
> > > > > > 
> > > > > > > 
> > > > > > > Mark
> > > > > > > 
> > > > > > > > 
> > > > > > > > And that¢s for a 4kb random write on an RBD that has been fully
> > > > > > > > conditioned via fio 4MB writes
> > > > > > > > 
> > > > > > > > So it's something in the sequential nature of the test which
> > > > > > > > trips
> > > > > > > > it up as I don't see any sign of deferred writes
> > > > > > > > 
> > > > > > > > From looking at the code in the small write function, I can only
> > > > > > > > see two possibilities that would stop if from reaching the
> > > > > > > > prefer
> > > > > > > > wal IF statement
> > > > > > > > 
> > > > > > > >   while (ep != o->extent_map.extent_map.end()) {
> > > > > > > >     if (ep->blob_start() >= end) {
> > > > > > > >       break;
> > > > > > > > 
> > > > > > > > and
> > > > > > > > 
> > > > > > > >   if ((b_off % chunk_size == 0 && b_len % chunk_size == 0) &&
> > > > > > > > 	b->get_blob().get_ondisk_length() >= b_off + b_len &&
> > > > > > > > 	b->get_blob().is_unused(b_off, b_len) &&
> > > > > > > > 	b->get_blob().is_allocated(b_off, b_len)) {
> > > > > > > > 
> > > > > > > > Unfortunately, that¢s about as far as I have got, before my
> > > > > > > > knowledge of
> > > > > > > Bluestore becomes a limitation.
> > > > > > > > 
> > > > > > > > Don't know if that triggers any thoughts?
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 2017-02-02 10:39:31.988782 7ff7282ff700 10
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) queue_transactions
> > > > > > > > > existing
> > > > > > > > > 0x56102a5a4900
> > > > > > > > > osr(9.73 0x56102a5db1a0)
> > > > > > > > > 2017-02-02 10:39:31.988786 7ff7282ff700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _txc_create osr
> > > > > > > > > 0x56102a5a4900
> > > > > > > > > =
> > > > > > > > > 0x56102ab4be40 seq 260
> > > > > > > > > 2017-02-02 10:39:31.988797 7ff7282ff700 15
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _setattrs 9.73_head
> > > > > > > > > #9:cff290b9:::rbd_data.36646a74b0dc51.0000000000000001:head# 2
> > > > > > > > > key
> > > > > > > s
> > > > > > > > > 2017-02-02 10:39:31.988802 7ff7282ff700 10
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _setattrs 9.73_head
> > > > > > > > > #9:cff290b9:::rbd_data.36646a74b0dc51.0000000000000001:head# 2
> > > > > > > > > key
> > > > > > > s
> > > > > > > > > = 0
> > > > > > > > > 2017-02-02 10:39:31.988806 7ff7282ff700 15
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _write 9.73_head
> > > > > > > > > #9:cff290b9:::rbd_data.36646a74b0dc51.0000000000000001:head#
> > > > > > > 0xfb000~
> > > > > > > > > 1000
> > > > > > > > > 2017-02-02 10:39:31.988809 7ff7282ff700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _do_write
> > > > > > > > > #9:cff290b9:::rbd_data.36646a74b0dc51.0000000000000001:head#
> > > > > > > > > 0xfb000~1000 - have 0x400000 (4194304) bytes fadvise_flags 0x0
> > > > > > > > > 2017-02-02 10:39:31.988812 7ff7282ff700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _do_write prefer
> > > > > > > > > csum_order 12
> > > > > > > > > target_blob_size
> > > > > > > > > 0x80000
> > > > > > > > > 2017-02-02 10:39:31.988814 7ff7282ff700 10
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _do_write_small
> > > > > > > > > 0xfb000~1000
> > > > > > > > > 2017-02-02 10:39:31.988816 7ff7282ff700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _do_write_small
> > > > > > > > > considering
> > > > > > > > > Blob(0x56102aac05a0 blob([0x256480000~80000] mutable+csum
> > > > > > > > > crc32c/0x1000) ref_map(0x0~80000=1)
> > > > > > > > > SharedBlob(0x56102aa76260))
> > > > > > > > > bstart 0x80000
> > > > > > > > > 2017-02-02 10:39:31.988821 7ff7282ff700 20
> > > > > > > > > bluestore.BufferSpace(0x56102aa762b8 in 0x56102a1337a0)
> > > > > > > > > _discard
> > > > > > > > > 0x7b000~1000
> > > > > > > > > 2017-02-02 10:39:31.988827 7ff7282ff700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _do_write_small  wal write
> > > > > > > > > 0x7b000~1000 of mutable Blob(0x56102aac05a0
> > > > > > > blob([0x256480000~80000]
> > > > > > > > > mutable+csum crc32c/0x1000) ref_map(0x0~80000=1)
> > > > > > > > > SharedBlob(0x56102aa76260)) at [0x2564fb000~1000]
> > > > > > > > > 2017-02-02 10:39:31.988832 7ff7282ff700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _do_write_small  lex
> > > > > > > > > 0xfb000~1000: 0x7b000~1000
> > > > > > > > > Blob(0x56102aac05a0 blob([0x256480000~80000] mutable+csum
> > > > > > > > > crc32c/0x1000)
> > > > > > > > > ref_map(0x0~7b000=1,0x7b000~1000=2,0x7c000~4000=1)
> > > > > > > > > SharedBlob(0x56102aa76260))
> > > > > > > > > 2017-02-02 10:39:31.988836 7ff7282ff700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _do_alloc_write txc
> > > > > > > > > 0x56102ab4be40 0 blobs
> > > > > > > > > 2017-02-02 10:39:31.988837 7ff7282ff700 10 bitmapalloc:reserve
> > > > > > > > > instance 94627427524464 num_used 345738 total 7627973
> > > > > > > > > 2017-02-02 10:39:31.988840 7ff7282ff700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _wctx_finish lex_old
> > > > > > > > > 0xfb000~1000: 0x7b000~1000
> > > > > > > > > Blob(0x56102aac05a0 blob([0x256480000~80000] mutable+csum
> > > > > > > > > crc32c/0x1000)
> > > > > > > > > ref_map(0x0~7b000=1,0x7b000~1000=2,0x7c000~4000=1)
> > > > > > > > > SharedBlob(0x56102aa76260))
> > > > > > > > > 2017-02-02 10:39:31.988844 7ff7282ff700 20
> > > > > > > > > bluestore.extentmap(0x56102a8ee3f0) compress_extent_map
> > > > > > > 0xfb000~1000
> > > > > > > > > next shard
> > > > > > > > > 0x100000 merging 0x80000~7b000: 0x0~7b000 Blob(0x56102aac05a0
> > > > > > > > > blob([0x256480000~80000] mutable+csum crc32c/0x1000)
> > > > > > > > > ref_map(0x0~80000=1) SharedBlob(0x56102aa76260)) and
> > > > > > > > > 0xfb000~1000:
> > > > > > > > > 0x7b000~1000 Blob(0x56102aac05a0 blob([0x256480000~80000]
> > > > > > > > > mutable+csum crc32c/0x1000) ref_map(0x0~80000=1)
> > > > > > > > > SharedBlob(0x56102aa76260))
> > > > > > > > > 2017-02-02 10:39:31.988850 7ff7282ff700 20
> > > > > > > > > bluestore.extentmap(0x56102a8ee3f0) compress_extent_map
> > > > > > > 0xfb000~1000
> > > > > > > > > next shard
> > > > > > > > > 0x100000 merging 0x80000~7c000: 0x0~7c000 Blob(0x56102aac05a0
> > > > > > > > > blob([0x256480000~80000] mutable+csum crc32c/0x1000)
> > > > > > > > > ref_map(0x0~80000=1) SharedBlob(0x56102aa76260)) and
> > > > > > > > > 0xfc000~4000:
> > > > > > > > > 0x7c000~4000 Blob(0x56102aac05a0 blob([0x256480000~80000]
> > > > > > > > > mutable+csum crc32c/0x1000) ref_map(0x0~80000=1)
> > > > > > > > > SharedBlob(0x56102aa76260))
> > > > > > > > > 2017-02-02 10:39:31.988868 7ff7282ff700 20
> > > > > > > > > bluestore.extentmap(0x56102a8ee3f0) dirty_range mark shard
> > > > > > > > > 0x80000
> > > > > > > > > dirty
> > > > > > > > > 2017-02-02 10:39:31.988870 7ff7282ff700 10
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _write 9.73_head
> > > > > > > > > #9:cff290b9:::rbd_data.36646a74b0dc51.0000000000000001:head#
> > > > > > > > > 0xfb000~1000 = 0
> > > > > > > > > 2017-02-02 10:39:31.988875 7ff7282ff700 15
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _omap_setkeys 9.73_head
> > > > > > > > > #9:ce000000::::head#
> > > > > > > > > 2017-02-02 10:39:31.988882 7ff7282ff700 10
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _omap_setkeys 9.73_head
> > > > > > > > > #9:ce000000::::head# = 0
> > > > > > > > > 2017-02-02 10:39:31.988885 7ff7282ff700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _txc_write_nodes txc
> > > > > > > > > 0x56102ab4be40 onodes
> > > > > > > > > 0x56102a8ee300 shared_blobs
> > > > > > > > > 2017-02-02 10:39:31.988894 7ff7282ff700 20
> > > > > > > > > bluestore.extentmap(0x56102a8ee3f0) update shard 0x80000 is
> > > > > > > > > 531
> > > > > > > > > bytes
> > > > > > > (was 531) from 1 extents
> > > > > > > > > 2017-02-02 10:39:31.988902 7ff7282ff700 20
> > > > > > > bluestore(/var/lib/ceph/osd/ceph-4)   onode
> > > > > > > > > #9:cff290b9:::rbd_data.36646a74b0dc51.0000000000000001:head#
> > > > > > > > > is
> > > > > > > > > 424
> > > > > > > > > (422 bytes onode + 2 bytes spanning blobs + 0 bytes inline
> > > > > > > > > extents)
> > > > > > > > > 2017-02-02 10:39:31.988914 7ff7282ff700 10
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _txc_state_proc txc
> > > > > > > > > 0x56102ab4be40 prepare
> > > > > > > > > 2017-02-02 10:39:31.988916 7ff7282ff700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _txc_finish_io
> > > > > > > > > 0x56102ab4be40
> > > > > > > > > 2017-02-02 10:39:31.988917 7ff7282ff700 10
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _txc_state_proc txc
> > > > > > > > > 0x56102ab4be40 io_done
> > > > > > > > > 2017-02-02 10:39:31.988918 7ff7282ff700 20
> > > > > > > > > bluestore.BufferSpace(0x56102aa762b8 in 0x56102a1337a0)
> > > > > > > > > finish_write
> > > > > > > > > buffer(0x56102adb1830 space 0x56102aa762b8 0x7b000~1000
> > > > > > > > > writing
> > > > > > > > > nocache)
> > > > > > > > > 2017-02-02 10:39:31.988939 7ff72e30b700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _kv_sync_thread wake
> > > > > > > > > 2017-02-02 10:39:31.988941 7ff72e30b700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _kv_sync_thread committing
> > > > > > > > > 1
> > > > > > > > > submitting 1 cleaning 0
> > > > > > > > > 2017-02-02 10:39:31.988952 7ff72e30b700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _txc_finalize_kv txc
> > > > > > > > > 0x56102ab4be40 allocated 0x[] released 0x[]
> > > > > > > > > 2017-02-02 10:39:31.988999 7ff72e30b700 10
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _balance_bluefs_freespace
> > > > > > > > > bluefs
> > > > > > > > > 9535 M free
> > > > > > > > > (0.999896) bluestore 222 G free (0.954675), bluefs_ratio
> > > > > > > > > 0.0402143
> > > > > > > > > 2017-02-02 10:39:31.989400 7ff72e30b700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _kv_sync_thread committed
> > > > > > > > > 1
> > > > > > > > > cleaned 0 in 0.000456
> > > > > > > > > 2017-02-02 10:39:31.989405 7ff72e30b700 10
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _txc_state_proc txc
> > > > > > > > > 0x56102ab4be40 kv_submitted
> > > > > > > > > 2017-02-02 10:39:31.989407 7ff72e30b700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _txc_finish_kv txc
> > > > > > > > > 0x56102ab4be40
> > > > > > > > > 2017-02-02 10:39:31.989413 7ff72e30b700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _wal_apply txc
> > > > > > > > > 0x56102ab4be40
> > > > > > > > > seq
> > > > > > > > > 255
> > > > > > > > > 2017-02-02 10:39:31.989414 7ff72e30b700 20
> > > > > > > > > bluestore(/var/lib/ceph/osd/ceph-4) _do_wal_op write
> > > > > > > > > [0x2564fb000~1000]
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > sage
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > sage
> > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > > 
> > > > > > > > > > > > > sage
> > > > > > > > > > > > > 
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Nick
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > > > From: Nick Fisk [mailto:nick@fisk.me.uk]
> > > > > > > > > > > > > > Sent: 01 February 2017 19:03
> > > > > > > > > > > > > > To: 'Sage Weil' <sweil@redhat.com>; 'Mark Nelson'
> > > > > > > > > > > > > <mnelson@redhat.com>
> > > > > > > > > > > > > > Cc: ceph-devel@vger.kernel.org
> > > > > > > > > > > > > > Subject: RE: bluestore prefer wal size
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Hi Sage,
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > First results not looking good. It looks like write
> > > > > > > > > > > > > > IO to the
> > > > > > > > > > > > > > SSD's (sdd and sdi)
> > > > > > > > > > > > > is now massively amplified, by somewhere in the region
> > > > > > > > > > > > > of
> > > > > > > > > > > > > about 10x. But I'm still only getting around 100 4kb's
> > > > > > > > > > > > > seq
> > > > > > > > > > > > > write iops from the fio client. This is in comparison
> > > > > > > > > > > > > to
> > > > > > > > > > > > > 2500-3000 iops on the SSD's and ~200 iops per spinning
> > > > > > > > > > > > > disk (sdc,sde,sdg,sdh).
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > rbd engine: RBD version: 0.1.11
> > > > > > > > > > > > > > Jobs: 1 (f=1): [W(1)] [100.0% done] [0KB/476KB/0KB
> > > > > > > > > > > > > > /s]
> > > > > > > > > > > > > > [0/119/0 iops] [eta 00m:00s]
> > > > > > > > > > > > > > rbd_iodepth32: (groupid=0, jobs=1): err= 0:
> > > > > > > > > > > > > > pid=31171: Wed
> > > > > > > > > > > > > > Feb
> > > > > > > > > > > > > > 1
> > > > > > > > > > > > > 18:56:51 2017
> > > > > > > > > > > > > >   write: io=27836KB, bw=475020B/s, iops=115, runt=
> > > > > > > > > > > > > > 60006msec
> > > > > > > > > > > > > >     slat (usec): min=6, max=142, avg=10.98, stdev=
> > > > > > > > > > > > > > 8.38
> > > > > > > > > > > > > >     clat (msec): min=1, max=271, avg= 8.61, stdev=
> > > > > > > > > > > > > > 3.63
> > > > > > > > > > > > > >      lat (msec): min=1, max=271, avg= 8.62, stdev=
> > > > > > > > > > > > > > 3.63
> > > > > > > > > > > > > >     clat percentiles (msec):
> > > > > > > > > > > > > >      |  1.00th=[    8],  5.00th=[    9], 10.00th=[
> > > > > > > > > > > > > > 9], 20.00th=[    9],
> > > > > > > > > > > > > >      | 30.00th=[    9], 40.00th=[    9], 50.00th=[
> > > > > > > > > > > > > > 9], 60.00th=[    9],
> > > > > > > > > > > > > >      | 70.00th=[    9], 80.00th=[    9], 90.00th=[
> > > > > > > > > > > > > > 9], 95.00th=[    9],
> > > > > > > > > > > > > >      | 99.00th=[   17], 99.50th=[   25], 99.90th=[
> > > > > > > > > > > > > > 33], 99.95th=[   36],
> > > > > > > > > > > > > >      | 99.99th=[  273]
> > > > > > > > > > > > > >     bw (KB  /s): min=  191, max=  480, per=100.00%,
> > > > > > > > > > > > > > avg=464.18,
> > > > > > > stdev=34.60
> > > > > > > > > > > > > >     lat (msec) : 2=0.01%, 4=0.04%, 10=97.69%,
> > > > > > > > > > > > > > 20=1.55%, 50=0.69%
> > > > > > > > > > > > > >     lat (msec) : 500=0.01%
> > > > > > > > > > > > > >   cpu          : usr=0.13%, sys=0.12%, ctx=7224,
> > > > > > > > > > > > > > majf=0, minf=5
> > > > > > > > > > > > > >   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%,
> > > > > > > > > > > > > > 16=0.0%,
> > > > > > > 32=0.0%,
> > > > > > > > > > > > > > =64=0.0%
> > > > > > > > > > > > > >      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%,
> > > > > > > > > > > > > > 32=0.0%,
> > > > > > > 64=0.0%,
> > > > > > > > > > > > > > =64=0.0%
> > > > > > > > > > > > > >      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%,
> > > > > > > > > > > > > > 32=0.0%,
> > > > > > > > > > > > > > 64=0.0%, =64=0.0%
> > > > > > > > > > > > > >      issued    : total=r=0/w=6959/d=0,
> > > > > > > > > > > > > > short=r=0/w=0/d=0,
> > > > > > > > > > > > > drop=r=0/w=0/d=0
> > > > > > > > > > > > > >      latency   : target=0, window=0,
> > > > > > > > > > > > > > percentile=100.00%, depth=1
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > I've checked via the admin socket and the prefer wal
> > > > > > > > > > > > > > option
> > > > > > > > > > > > > > is set to
> > > > > > > 8192.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Random capture of iostat
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Device:         rrqm/s   wrqm/s     r/s     w/s
> > > > > > > > > > > > > > rkB/s    wkB/s avgrq-sz
> > > > > > > avgqu-sz
> > > > > > > > > > > > > await r_await w_await  svctm  %util
> > > > > > > > > > > > > > sda               0.00    77.00    0.00    5.50
> > > > > > > > > > > > > > 0.00   338.00   122.91     0.05
> > > > > > > 11.64
> > > > > > > > > > > > > 0.00   11.64   8.73   4.80
> > > > > > > > > > > > > > sdb               0.00     0.00    0.00    0.00
> > > > > > > > > > > > > > 0.00     0.00     0.00     0.00
> > > > > > > 0.00
> > > > > > > > > > > > > 0.00    0.00   0.00   0.00
> > > > > > > > > > > > > > sdc               0.00     0.00    0.00  151.50
> > > > > > > > > > > > > > 0.00   302.00     3.99     0.54
> > > > > > > 3.59
> > > > > > > > > > > > > 0.00    3.59   3.58  54.20
> > > > > > > > > > > > > > sdd               0.00     0.00    0.00 1474.00
> > > > > > > > > > > > > > 0.00  4008.00     5.44     0.09
> > > > > > > 0.06
> > > > > > > > > > > > > 0.00    0.06   0.06   9.20
> > > > > > > > > > > > > > sde               0.00     0.00    0.00  217.00
> > > > > > > > > > > > > > 0.00   434.00     4.00     0.91
> > > > > > > 4.20
> > > > > > > > > > > > > 0.00    4.20   4.20  91.20
> > > > > > > > > > > > > > sdf               0.00     0.00    0.00    0.00
> > > > > > > > > > > > > > 0.00     0.00     0.00     0.00
> > > > > > > 0.00
> > > > > > > > > > > > > 0.00    0.00   0.00   0.00
> > > > > > > > > > > > > > sdg               0.00     0.00    0.00   66.50
> > > > > > > > > > > > > > 0.00   134.00     4.03     0.18
> > > > > > > 2.68
> > > > > > > > > > > > > 0.00    2.68   2.68  17.80
> > > > > > > > > > > > > > sdh               0.00     0.00    0.00  217.00
> > > > > > > > > > > > > > 0.00   434.00     4.00     0.80
> > > > > > > 3.71
> > > > > > > > > > > > > 0.00    3.71   3.71  80.40
> > > > > > > > > > > > > > sdi               0.00     0.00    0.00 1134.00
> > > > > > > > > > > > > > 0.00  3082.00     5.44     0.09
> > > > > > > 0.08
> > > > > > > > > > > > > 0.00    0.08   0.07   8.40
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > > > > > > > > > > Sent: 01 February 2017 15:34
> > > > > > > > > > > > > > To: nick@fisk.me.uk
> > > > > > > > > > > > > > Cc: ceph-devel@vger.kernel.org
> > > > > > > > > > > > > > Subject: bluestore prefer wal size
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Hey Nick,
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > I've updated/improved the prefer wal size PR (that
> > > > > > > > > > > > > > sends
> > > > > > > > > > > > > > small writes through the wal).  See
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 	https://github.com/ceph/ceph/pull/13217
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > if you want to try it out.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Thanks!
> > > > > > > > > > > > > > sage
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > --
> > > > > > > > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > > > > > > > > ceph-devel"
> > > > > > > > > > > in the body of a message to majordomo@vger.kernel.org More
> > > > > > > > > > > majordomo info at
> > > > > > > > > > > http://vger.kernel.org/majordomo-info.html
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > 
> > > > > 
> > > 
> > > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-1995646361-1488822799=:24356--
