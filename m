From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: newstore direction
Date: Tue, 20 Oct 2015 12:44:35 -0700
Message-ID: <CADRKj5TR98zG4bD_f6RW5U4yD+qdvtiwHpSMOGvf4RdWbPfk2g@mail.gmail.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
	<56268886.7010806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34486 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbbJTTog (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Oct 2015 15:44:36 -0400
Received: by oies66 with SMTP id s66so16440926oie.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2015 12:44:35 -0700 (PDT)
In-Reply-To: <56268886.7010806@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ric Wheeler <rwheeler@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Oct 20, 2015 at 11:31 AM, Ric Wheeler <rwheeler@redhat.com> wrote:
> On 10/19/2015 03:49 PM, Sage Weil wrote:
>>
>> The current design is based on two simple ideas:
>>
>>   1) a key/value interface is better way to manage all of our internal
>> metadata (object metadata, attrs, layout, collection membership,
>> write-ahead logging, overlay data, etc.)
>>
>>   2) a file system is well suited for storage object data (as files).
>>
>> So far 1 is working out well, but I'm questioning the wisdom of #2.  A few
>> things:
>>
>>   - We currently write the data to the file, fsync, then commit the kv
>> transaction.  That's at least 3 IOs: one for the data, one for the fs
>> journal, one for the kv txn to commit (at least once my rocksdb changes
>> land... the kv commit is currently 2-3).  So two people are managing
>> metadata, here: the fs managing the file metadata (with its own
>> journal) and the kv backend (with its journal).
>
>
> If all of the fsync()'s fall into the same backing file system, are you sure
> that each fsync() takes the same time? Depending on the local FS
> implementation of course, but the order of issuing those fsync()'s can
> effectively make some of them no-ops.
>
>>
>>   - On read we have to open files by name, which means traversing the fs
>> namespace.  Newstore tries to keep it as flat and simple as possible, but
>> at a minimum it is a couple btree lookups.  We'd love to use open by
>> handle (which would reduce this to 1 btree traversal), but running
>> the daemon as ceph and not root makes that hard...
>
>
> This seems like a a pretty low hurdle to overcome.
>
>>
>>   - ...and file systems insist on updating mtime on writes, even when it
>> is
>> a overwrite with no allocation changes.  (We don't care about mtime.)
>> O_NOCMTIME patches exist but it is hard to get these past the kernel
>> brainfreeze.
>
>
> Are you using O_DIRECT? Seems like there should be some enterprisey database
> tricks that we can use here.
>
>>
>>   - XFS is (probably) never going going to give us data checksums, which
>> we
>> want desperately.
>
>
> What is the goal of having the file system do the checksums? How strong do
> they need to be and what size are the chunks?
>
> If you update this on each IO, this will certainly generate more IO (each
> write will possibly generate at least one other write to update that new
> checksum).
>
>>
>> But what's the alternative?  My thought is to just bite the bullet and
>> consume a raw block device directly.  Write an allocator, hopefully keep
>> it pretty simple, and manage it in kv store along with all of our other
>> metadata.
>
>
> The big problem with consuming block devices directly is that you ultimately
> end up recreating most of the features that you had in the file system. Even
> enterprise databases like Oracle and DB2 have been migrating away from
> running on raw block devices in favor of file systems over time.  In effect,
> you are looking at making a simple on disk file system which is always
> easier to start than it is to get back to a stable, production ready state.
>
> I think that it might be quicker and more maintainable to spend some time
> working with the local file system people (XFS or other) to see if we can
> jointly address the concerns you have.
>
>>
>> Wins:
>>
>>   - 2 IOs for most: one to write the data to unused space in the block
>> device, one to commit our transaction (vs 4+ before).  For overwrites,
>> we'd have one io to do our write-ahead log (kv journal), then do
>> the overwrite async (vs 4+ before).
>>
>>   - No concern about mtime getting in the way
>>
>>   - Faster reads (no fs lookup)
>>
>>   - Similarly sized metadata for most objects.  If we assume most objects
>> are not fragmented, then the metadata to store the block offsets is about
>> the same size as the metadata to store the filenames we have now.
>>
>> Problems:
>>
>>   - We have to size the kv backend storage (probably still an XFS
>> partition) vs the block storage.  Maybe we do this anyway (put metadata on
>> SSD!) so it won't matter.  But what happens when we are storing gobs of
>> rgw index data or cephfs metadata?  Suddenly we are pulling storage out of
>> a different pool and those aren't currently fungible.
>>
>>   - We have to write and maintain an allocator.  I'm still optimistic this
>> can be reasonbly simple, especially for the flash case (where
>> fragmentation isn't such an issue as long as our blocks are reasonbly
>> sized).  For disk we may beed to be moderately clever.
>>
>>   - We'll need a fsck to ensure our internal metadata is consistent.  The
>> good news is it'll just need to validate what we have stored in the kv
>> store.
>>
>> Other thoughts:
>>
>>   - We might want to consider whether dm-thin or bcache or other block
>> layers might help us with elasticity of file vs block areas.
>>
>>   - Rocksdb can push colder data to a second directory, so we could have a
>> fast ssd primary area (for wal and most metadata) and a second hdd
>> directory for stuff it has to push off.  Then have a conservative amount
>> of file space on the hdd.  If our block fills up, use the existing file
>> mechanism to put data there too.  (But then we have to maintain both the
>> current kv + file approach and not go all-in on kv + block.)
>>
>> Thoughts?
>> sage
>> --
>
>
> I really hate the idea of making a new file system type (even if we call it
> a raw block store!).

While I mostly agree with the sentiment, (and I also believe that as
with any project like that you know where you start, but 5 years later
you still don't know when you're going to end) I do think that it
seems quite different in requirements and functionality than a normal
filesystem (e.g., no need for directories, filenames?). Maybe we need
to have a proper understanding of the requirements, and then we can
weigh what the proper solution is?
>
> In addition to the technical hurdles, there are also production worries like
> how long will it take for distros to pick up formal support?  How do we test
> it properly?
>

Does it even need to be a kernel module?

Yehuda
