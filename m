From: Milosz Tanski <milosz@adfin.com>
Subject: Re: newstore direction
Date: Thu, 22 Oct 2015 08:32:41 -0400
Message-ID: <CANP1eJEZGe6uqdd3i8exT7zX8wWHHRSk-x0H8zn1h9u5pni3+A@mail.gmail.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
	<CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com>
	<alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33044 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbbJVMco (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 08:32:44 -0400
Received: by lffv3 with SMTP id v3so45899394lff.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2015 05:32:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Oct 20, 2015 at 4:00 PM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 20 Oct 2015, John Spray wrote:
>> On Mon, Oct 19, 2015 at 8:49 PM, Sage Weil <sweil@redhat.com> wrote:
>> >  - We have to size the kv backend storage (probably still an XFS
>> > partition) vs the block storage.  Maybe we do this anyway (put metadata on
>> > SSD!) so it won't matter.  But what happens when we are storing gobs of
>> > rgw index data or cephfs metadata?  Suddenly we are pulling storage out of
>> > a different pool and those aren't currently fungible.
>>
>> This is the concerning bit for me -- the other parts one "just" has to
>> get the code right, but this problem could linger and be something we
>> have to keep explaining to users indefinitely.  It reminds me of cases
>> in other systems where users had to make an educated guess about inode
>> size up front, depending on whether you're expecting to efficiently
>> store a lot of xattrs.
>>
>> In practice it's rare for users to make these kinds of decisions well
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
> There are some KV alternatives that could consume block, but the problem
> would be similar: we need to dynamically size up or down the kv portion of
> the device.
>
> I see two basic options:
>
> 1) Wire into the Env abstraction in rocksdb to provide something just
> smart enough to let rocksdb work.  It isn't much: named files (not that
> many--we could easily keep the file table in ram), always written
> sequentially, to be read later with random access. All of the code is
> written around abstractions of SequentialFileWriter so that everything
> posix is neatly hidden in env_posix (and there are various other env
> implementations for in-memory mock tests etc.).
>
> 2) Use something like dm-thin to sit between the raw block device and XFS
> (for rocksdb) and the block device consumed by newstore.  As long as XFS
> doesn't fragment horrifically (it shouldn't, given we *always* write ~4mb
> files in their entirety) we can fstrim and size down the fs portion.  If
> we similarly make newstores allocator stick to large blocks only we would
> be able to size down the block portion as well.  Typical dm-thin block
> sizes seem to range from 64KB to 512KB, which seems reasonable enough to
> me.  In fact, we could likely just size the fs volume at something
> conservatively large (like 90%) and rely on -o discard or periodic fstrim
> to keep its actual utilization in check.
>

I think you could prototype a raw block device OSD store using LMDB as
a starting point. I know there's been some experiments using LMDB as
KV store before with positive read numbers and not great write
numbers.

1. It mmaps, just mmap the raw disk device / partition. I've done this
as an experiment before, I can dig up a patch for LMDB.
2. It already has a free space management strategy. I'm prob it's not
right for the OSDs in the long term but there's something to start
there with.
3. It's already supports transactions / COW.
4. LMDB isn't a huge code base so it might be a good place to start /
evolve code from.
5. You're not starting a multi-year effort at the 0 point.

As to the not great write performance, that could be addressed by
write transaction merging (what mysql implemented a few years ago).
Here you have an opportunity to do it two days. One, you can do it in
the application layer while waiting for the fsync from transaction to
complete. This is probably the easier route. Two, you can do it in the
DB layer (the LMDB transaction handling / locking) where you're
already started processing the following transactions using the
currently committing transaction (COW) as a starting point. This is
harder mostly because of the synchronization needed or involved.

I've actually spend some time thinking about doing LMDB write
transaction merging outside the OSD context. This was for another
project.

My 2 cents.

-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
