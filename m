From: Wido den Hollander <wido@42on.com>
Subject: Re: newstore direction
Date: Mon, 19 Oct 2015 23:18:52 +0200
Message-ID: <56255E3C.1040607@42on.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:56902 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbJSVSy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 17:18:54 -0400
In-Reply-To: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 10/19/2015 09:49 PM, Sage Weil wrote:
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
> 
> Wins:
> 
>  - 2 IOs for most: one to write the data to unused space in the block 
> device, one to commit our transaction (vs 4+ before).  For overwrites, 
> we'd have one io to do our write-ahead log (kv journal), then do 
> the overwrite async (vs 4+ before).
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

I've been using bcache for a while now in production and that helped a lot.

Intel SSDs with GPT. First few partitions as Journals and then one big
partition for bcache.

/dev/bcache0    2.8T  264G  2.5T  10% /var/lib/ceph/osd/ceph-60
/dev/bcache1    2.8T  317G  2.5T  12% /var/lib/ceph/osd/ceph-61
/dev/bcache2    2.8T  303G  2.5T  11% /var/lib/ceph/osd/ceph-62
/dev/bcache3    2.8T  316G  2.5T  12% /var/lib/ceph/osd/ceph-63
/dev/bcache4    2.8T  167G  2.6T   6% /var/lib/ceph/osd/ceph-64
/dev/bcache5    2.8T  295G  2.5T  11% /var/lib/ceph/osd/ceph-65

The maintainers from bcache also presented bcachefs:
https://lkml.org/lkml/2015/8/21/22

"checksumming, compression: currently only zlib is supported for
compression, and for checksumming there's crc32c and a 64 bit checksum."

Wouldn't that be something that can be leveraged from? Consuming a raw
block device seems like re-inventing the wheel to me. I might be wrong
though.

I have no idea how stable bcachefs is, but it might be worth looking in to.

>  - Rocksdb can push colder data to a second directory, so we could have a 
> fast ssd primary area (for wal and most metadata) and a second hdd 
> directory for stuff it has to push off.  Then have a conservative amount 
> of file space on the hdd.  If our block fills up, use the existing file 
> mechanism to put data there too.  (But then we have to maintain both the 
> current kv + file approach and not go all-in on kv + block.)
> 
> Thoughts?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
