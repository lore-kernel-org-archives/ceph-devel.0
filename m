From: Varada Kari <Varada.Kari@sandisk.com>
Subject: RE: newstore direction
Date: Mon, 19 Oct 2015 22:40:28 +0000
Message-ID: <BN1PR0201MB06928ADCA966BFCB738B1ED9E23A0@BN1PR0201MB0692.namprd02.prod.outlook.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0085.outbound.protection.outlook.com ([207.46.100.85]:34255
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752024AbbJSWyk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 18:54:40 -0400
In-Reply-To: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

If we are managing the raw device, does it make sense to have a key value store to manage the whole space? 
Having metadata of the allocator might cause some other problems of consistency. Getting an fsck for that implementation can be tougher, we might have to have strict crc computations on the data. And have to manage sanity of the DB managing them.
If we can have a common mechanism of having data and metadata the same keyvalue store, will improve the performance. 
We have integrated a custom made key value store which works on raw device the key value store backend. And we have observed better bw utilization and iops.
Read/writes can be faster and no fslookup needed. We have tools like fsck to care of consistency of DB. 

Couple of comments inline.

Thanks,
Varada

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Tuesday, October 20, 2015 1:19 AM
> To: ceph-devel@vger.kernel.org
> Subject: newstore direction
> 
> The current design is based on two simple ideas:
> 
>  1) a key/value interface is better way to manage all of our internal metadata
> (object metadata, attrs, layout, collection membership, write-ahead logging,
> overlay data, etc.)
> 
>  2) a file system is well suited for storage object data (as files).
> 
> So far 1 is working out well, but I'm questioning the wisdom of #2.  A few
> things:
> 
>  - We currently write the data to the file, fsync, then commit the kv
> transaction.  That's at least 3 IOs: one for the data, one for the fs journal, one
> for the kv txn to commit (at least once my rocksdb changes land... the kv
> commit is currently 2-3).  So two people are managing metadata, here: the fs
> managing the file metadata (with its own
> journal) and the kv backend (with its journal).
> 
>  - On read we have to open files by name, which means traversing the fs
> namespace.  Newstore tries to keep it as flat and simple as possible, but at a
> minimum it is a couple btree lookups.  We'd love to use open by handle
> (which would reduce this to 1 btree traversal), but running the daemon as
> ceph and not root makes that hard...
> 
>  - ...and file systems insist on updating mtime on writes, even when it is a
> overwrite with no allocation changes.  (We don't care about mtime.)
> O_NOCMTIME patches exist but it is hard to get these past the kernel
> brainfreeze.
> 
>  - XFS is (probably) never going going to give us data checksums, which we
> want desperately.
> 
> But what's the alternative?  My thought is to just bite the bullet and consume
> a raw block device directly.  Write an allocator, hopefully keep it pretty
> simple, and manage it in kv store along with all of our other metadata.
> 
> Wins:
> 
>  - 2 IOs for most: one to write the data to unused space in the block device,
> one to commit our transaction (vs 4+ before).  For overwrites, we'd have one
> io to do our write-ahead log (kv journal), then do the overwrite async (vs 4+
> before).
> 
>  - No concern about mtime getting in the way
> 
>  - Faster reads (no fs lookup)
> 
>  - Similarly sized metadata for most objects.  If we assume most objects are
> not fragmented, then the metadata to store the block offsets is about the
> same size as the metadata to store the filenames we have now.
> 
> Problems:
> 
>  - We have to size the kv backend storage (probably still an XFS
> partition) vs the block storage.  Maybe we do this anyway (put metadata on
> SSD!) so it won't matter.  But what happens when we are storing gobs of rgw
> index data or cephfs metadata?  Suddenly we are pulling storage out of a
> different pool and those aren't currently fungible.

[Varada Kari]  Ideally if we can manage the raw device as key value store indirection to manage metadata and data both, we can benefit with faster lookups and writes (if the KVStore supports a batch atomic transactional write). SSD's might suffer with more write  amplification by putting the meta data alone, if we can manage this part(KV Store to deal with raw device) also(handling small writes) we can avoid write amplification and get better throughput from the device.

>  - We have to write and maintain an allocator.  I'm still optimistic this can be
> reasonbly simple, especially for the flash case (where fragmentation isn't
> such an issue as long as our blocks are reasonbly sized).  For disk we may
> beed to be moderately clever.
> 
[Varada Kari] Yes. If the writes are aligned to flash programmable page size, that will not cause any issues. But writes less than programmable page size will cause internal fragmentation. Repeated overwrites to the same, will cause more write amplification.

>  - We'll need a fsck to ensure our internal metadata is consistent.  The good
> news is it'll just need to validate what we have stored in the kv store.
> 
> Other thoughts:
> 
>  - We might want to consider whether dm-thin or bcache or other block
> layers might help us with elasticity of file vs block areas.
> 
>  - Rocksdb can push colder data to a second directory, so we could have a fast
> ssd primary area (for wal and most metadata) and a second hdd directory for
> stuff it has to push off.  Then have a conservative amount of file space on the
> hdd.  If our block fills up, use the existing file mechanism to put data there
> too.  (But then we have to maintain both the current kv + file approach and
> not go all-in on kv + block.)
> 
> Thoughts?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
