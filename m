From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: newstore direction
Date: Tue, 20 Oct 2015 10:08:25 +0800
Message-ID: <CACJqLyZEjOdzSVYBZeJ0_cgUudpn8oiskNBSCYC9oAPvyWtN3g@mail.gmail.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36106 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbJTCI0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 22:08:26 -0400
Received: by vkex70 with SMTP id x70so1966437vke.3
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 19:08:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Oct 20, 2015 at 3:49 AM, Sage Weil <sweil@redhat.com> wrote:
> The current design is based on two simple ideas:
>
>  1) a key/value interface is better way to manage all of our internal
> metadata (object metadata, attrs, layout, collection membership,
> write-ahead logging, overlay data, etc.)
>
>  2) a file system is well suited for storage object data (as files).
>
> So far 1 is working out well, but I'm questioning the wisdom of #2.  A few
> things:
>
>  - We currently write the data to the file, fsync, then commit the kv
> transaction.  That's at least 3 IOs: one for the data, one for the fs
> journal, one for the kv txn to commit (at least once my rocksdb changes
> land... the kv commit is currently 2-3).  So two people are managing
> metadata, here: the fs managing the file metadata (with its own
> journal) and the kv backend (with its journal).
>
>  - On read we have to open files by name, which means traversing the fs
> namespace.  Newstore tries to keep it as flat and simple as possible, but
> at a minimum it is a couple btree lookups.  We'd love to use open by
> handle (which would reduce this to 1 btree traversal), but running
> the daemon as ceph and not root makes that hard...
>
>  - ...and file systems insist on updating mtime on writes, even when it is
> a overwrite with no allocation changes.  (We don't care about mtime.)
> O_NOCMTIME patches exist but it is hard to get these past the kernel
> brainfreeze.
>
>  - XFS is (probably) never going going to give us data checksums, which we
> want desperately.
>
> But what's the alternative?  My thought is to just bite the bullet and
> consume a raw block device directly.  Write an allocator, hopefully keep
> it pretty simple, and manage it in kv store along with all of our other
> metadata.

This is really a tough decision. Although making a block device based
objectstore never walk out my mind since two years ago.

We would much more concern about the effective of space utilization
compared to local fs,  the buggy, the consuming time to build a tiny
local filesystem. I'm a little afraid of we would stuck into....

>
> Wins:
>
>  - 2 IOs for most: one to write the data to unused space in the block
> device, one to commit our transaction (vs 4+ before).  For overwrites,
> we'd have one io to do our write-ahead log (kv journal), then do
> the overwrite async (vs 4+ before).

Compared to filejournal, it seemed keyvaluedb doesn't play well in WAL
area from my perf.

>
>  - No concern about mtime getting in the way
>
>  - Faster reads (no fs lookup)
>
>  - Similarly sized metadata for most objects.  If we assume most objects
> are not fragmented, then the metadata to store the block offsets is about
> the same size as the metadata to store the filenames we have now.
>
> Problems:
>
>  - We have to size the kv backend storage (probably still an XFS
> partition) vs the block storage.  Maybe we do this anyway (put metadata on
> SSD!) so it won't matter.  But what happens when we are storing gobs of
> rgw index data or cephfs metadata?  Suddenly we are pulling storage out of
> a different pool and those aren't currently fungible.
>
>  - We have to write and maintain an allocator.  I'm still optimistic this
> can be reasonbly simple, especially for the flash case (where
> fragmentation isn't such an issue as long as our blocks are reasonbly
> sized).  For disk we may beed to be moderately clever.
>
>  - We'll need a fsck to ensure our internal metadata is consistent.  The
> good news is it'll just need to validate what we have stored in the kv
> store.
>
> Other thoughts:
>
>  - We might want to consider whether dm-thin or bcache or other block
> layers might help us with elasticity of file vs block areas.
>
>  - Rocksdb can push colder data to a second directory, so we could have a
> fast ssd primary area (for wal and most metadata) and a second hdd
> directory for stuff it has to push off.  Then have a conservative amount
> of file space on the hdd.  If our block fills up, use the existing file
> mechanism to put data there too.  (But then we have to maintain both the
> current kv + file approach and not go all-in on kv + block.)

A complex way...

Actually I would like to employ FileStore2 impl, which means we still
use FileJournal(or alike ..). But we need to employ more memory to
keep metadata/xattrs and use aio+dio to flush disk. A userspace
pagecache needed to be impl. Then we can skip journal if full write,
because osd is pg isolation we could make a barrier for single pg when
skipping journal. @Sage Is there other concerns for filestore skip
journal?

In a word, I like the model that filestore owns, but we need to have a
big refactor for existing impl.

Sorry to disturb the thought....

>
> Thoughts?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
