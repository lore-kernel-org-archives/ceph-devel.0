From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: newstore direction
Date: Tue, 20 Oct 2015 13:36:31 -0700
Message-ID: <CAJ4mKGY0=+isJhh4oF3kqtxEZ6HWSDZXJyM9sBHxc8s21M_y8g@mail.gmail.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
	<CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com>
	<alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35530 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbbJTUge convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Oct 2015 16:36:34 -0400
Received: by wicll6 with SMTP id ll6so62906401wic.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2015 13:36:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Oct 20, 2015 at 12:44 PM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 20 Oct 2015, Ric Wheeler wrote:
>> The big problem with consuming block devices directly is that you ul=
timately
>> end up recreating most of the features that you had in the file syst=
em. Even
>> enterprise databases like Oracle and DB2 have been migrating away fr=
om running
>> on raw block devices in favor of file systems over time.  In effect,=
 you are
>> looking at making a simple on disk file system which is always easie=
r to start
>> than it is to get back to a stable, production ready state.
>
> This was why we abandoned ebofs ~4 years ago... btrfs had arrived and=
 had
> everything we were implementing and more: mainly, copy on write and d=
ata
> checksums.  But in practice the fact that its general purpose means i=
t
> targets a very different workloads and APIs than what we need.

Try 7 years since ebofs...
That's one of my concerns, though. You ditched ebofs once already
because it had metastasized into an entire FS, and had reached its
limits of maintainability. What makes you think a second time through
would work better? :/

On Mon, Oct 19, 2015 at 12:49 PM, Sage Weil <sweil@redhat.com> wrote:
>  - 2 IOs for most: one to write the data to unused space in the block
> device, one to commit our transaction (vs 4+ before).  For overwrites=
,
> we'd have one io to do our write-ahead log (kv journal), then do
> the overwrite async (vs 4+ before).

I can't work this one out. If you're doing one write for the data and
one for the kv journal (which is on another filesystem), how does the
commit sequence work that it's only 2 IOs instead of the same 3 we
already have? Or are you planning to ditch the LevelDB/RocksDB store
for our journaling and just use something within the block layer?


If we do want to go down this road, we shouldn't need to write an
allocator from scratch. I don't remember exactly which ones it is but
we've read/seen at least a few storage papers where people have reused
existing allocators  =E2=80=94 I think the one from ext2? And somebody =
managed
to get it running in userspace.

Of course, then we also need to figure out how to get checksums on the
block data, since if we're going to put in the effort to reimplement
this much of the stack we'd better get our full data integrity
guarantees along with it!

On Tue, Oct 20, 2015 at 1:00 PM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 20 Oct 2015, John Spray wrote:
>> On Mon, Oct 19, 2015 at 8:49 PM, Sage Weil <sweil@redhat.com> wrote:
>> >  - We have to size the kv backend storage (probably still an XFS
>> > partition) vs the block storage.  Maybe we do this anyway (put met=
adata on
>> > SSD!) so it won't matter.  But what happens when we are storing go=
bs of
>> > rgw index data or cephfs metadata?  Suddenly we are pulling storag=
e out of
>> > a different pool and those aren't currently fungible.
>>
>> This is the concerning bit for me -- the other parts one "just" has =
to
>> get the code right, but this problem could linger and be something w=
e
>> have to keep explaining to users indefinitely.  It reminds me of cas=
es
>> in other systems where users had to make an educated guess about ino=
de
>> size up front, depending on whether you're expecting to efficiently
>> store a lot of xattrs.
>>
>> In practice it's rare for users to make these kinds of decisions wel=
l
>> up-front: it really needs to be adjustable later, ideally
>> automatically.  That could be pretty straightforward if the KV part
>> was stored directly on block storage, instead of having XFS in the
>> mix.  I'm not quite up with the state of the art in this area: are
>> there any reasonable alternatives for the KV part that would consume
>> some defined range of a block device from userspace, instead of
>> sitting on top of a filesystem?
>
> I agree: this is my primary concern with the raw block approach.
>
> There are some KV alternatives that could consume block, but the prob=
lem
> would be similar: we need to dynamically size up or down the kv porti=
on of
> the device.
>
> I see two basic options:
>
> 1) Wire into the Env abstraction in rocksdb to provide something just
> smart enough to let rocksdb work.  It isn't much: named files (not th=
at
> many--we could easily keep the file table in ram), always written
> sequentially, to be read later with random access. All of the code is
> written around abstractions of SequentialFileWriter so that everythin=
g
> posix is neatly hidden in env_posix (and there are various other env
> implementations for in-memory mock tests etc.).

This seems like the obviously correct move to me? Except we might want
to include the rocksdb store on flash instead of hard drives, which
means maybe we do want some unified storage system which can handle
multiple physical storage devices as a single piece of storage space.
(Not that any of those exist in "almost done" hell, or that we're
going through requirements expansion or anything!)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
