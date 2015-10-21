From: Mark Nelson <mnelson@redhat.com>
Subject: Re: newstore direction
Date: Wed, 21 Oct 2015 08:44:35 -0500
Message-ID: <562796C3.7020107@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net> <56268886.7010806@redhat.com> <7334B4281E425749B85E08CF7EC6F8534383DD15@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38216 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151AbbJUNoj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Oct 2015 09:44:39 -0400
In-Reply-To: <7334B4281E425749B85E08CF7EC6F8534383DD15@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/21/2015 05:06 AM, Allen Samuels wrote:
> I agree that moving newStore to raw block is going to be a significant development effort. But the current scheme of using a KV store combined with a normal file system is always going to be problematic (FileStore or NewStore). This is caused by the transactional requirements of the ObjectStore interface, essentially you need to make transactionally consistent updates to two indexes, one of which doesn't understand transactions (File Systems) and can never be tightly-connected to the other one.
>
> You'll always be able to make this "loosely coupled" approach work, but it will never be optimal. The real question is whether the performance difference of a suboptimal implementation is something that you can live with compared to the longer gestation period of the more optimal implementation. Clearly, Sage believes that the performance difference is significant or he wouldn't have kicked off this discussion in the first place.
>
> While I think we can all agree that writing a full-up KV and raw-block ObjectStore is a significant amount of work. I will offer the case that the "loosely couple" scheme may not have as much time-to-market advantage as it appears to have. One example: NewStore performance is limited due to bugs in XFS that won't be fixed in the field for quite some time (it'll take at least a couple of years before a patched version of XFS will be widely deployed at customer environments).
>
> Another example: Sage has just had to substantially rework the journaling code of rocksDB.
>
> In short, as you can tell, I'm full throated in favor of going down the optimal route.
>
> Internally at Sandisk, we have a KV store that is optimized for flash (it's called ZetaScale). We have extended it with a raw block allocator just as Sage is now proposing to do. Our internal performance measurements show a significant advantage over the current NewStore. That performance advantage stems primarily from two things:

Has there been any discussion regarding opensourcing zetascale?

>
> (1) ZetaScale uses a B+-tree internally rather than an LSM tree (levelDB/RocksDB). LSM trees experience exponential increase in write amplification (cost of an insert) as the amount of data under management increases. B+tree write-amplification is nearly constant independent of the size of data under management. As the KV database gets larger (Since newStore is effectively moving the per-file inode into the kv data base. Don't forget checksums that Sage want's to add :)) this performance delta swamps all others.
> (2) Having a KV and a file-system causes a double lookup. This costs CPU time and disk accesses to page in data structure indexes, metadata efficiency decreases.
>
> You can't avoid (2) as long as you're using a file system.
>
> Yes an LSM tree performs better on HDD than does a B-tree, which is a good argument for keeping the KV module pluggable.
>
>
> Allen Samuels
> Software Architect, Fellow, Systems and Software Solutions
>
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ric Wheeler
> Sent: Tuesday, October 20, 2015 11:32 AM
> To: Sage Weil <sweil@redhat.com>; ceph-devel@vger.kernel.org
> Subject: Re: newstore direction
>
> On 10/19/2015 03:49 PM, Sage Weil wrote:
>> The current design is based on two simple ideas:
>>
>>    1) a key/value interface is better way to manage all of our internal
>> metadata (object metadata, attrs, layout, collection membership,
>> write-ahead logging, overlay data, etc.)
>>
>>    2) a file system is well suited for storage object data (as files).
>>
>> So far 1 is working out well, but I'm questioning the wisdom of #2.  A
>> few
>> things:
>>
>>    - We currently write the data to the file, fsync, then commit the kv
>> transaction.  That's at least 3 IOs: one for the data, one for the fs
>> journal, one for the kv txn to commit (at least once my rocksdb
>> changes land... the kv commit is currently 2-3).  So two people are
>> managing metadata, here: the fs managing the file metadata (with its
>> own
>> journal) and the kv backend (with its journal).
>
> If all of the fsync()'s fall into the same backing file system, are you sure that each fsync() takes the same time? Depending on the local FS implementation of course, but the order of issuing those fsync()'s can effectively make some of them no-ops.
>
>>
>>    - On read we have to open files by name, which means traversing the
>> fs namespace.  Newstore tries to keep it as flat and simple as
>> possible, but at a minimum it is a couple btree lookups.  We'd love to
>> use open by handle (which would reduce this to 1 btree traversal), but
>> running the daemon as ceph and not root makes that hard...
>
> This seems like a a pretty low hurdle to overcome.
>
>>
>>    - ...and file systems insist on updating mtime on writes, even when
>> it is a overwrite with no allocation changes.  (We don't care about
>> mtime.) O_NOCMTIME patches exist but it is hard to get these past the
>> kernel brainfreeze.
>
> Are you using O_DIRECT? Seems like there should be some enterprisey database tricks that we can use here.
>
>>
>>    - XFS is (probably) never going going to give us data checksums,
>> which we want desperately.
>
> What is the goal of having the file system do the checksums? How strong do they need to be and what size are the chunks?
>
> If you update this on each IO, this will certainly generate more IO (each write will possibly generate at least one other write to update that new checksum).
>
>>
>> But what's the alternative?  My thought is to just bite the bullet and
>> consume a raw block device directly.  Write an allocator, hopefully
>> keep it pretty simple, and manage it in kv store along with all of our
>> other metadata.
>
> The big problem with consuming block devices directly is that you ultimately end up recreating most of the features that you had in the file system. Even enterprise databases like Oracle and DB2 have been migrating away from running on raw block devices in favor of file systems over time.  In effect, you are looking at making a simple on disk file system which is always easier to start than it is to get back to a stable, production ready state.
>
> I think that it might be quicker and more maintainable to spend some time working with the local file system people (XFS or other) to see if we can jointly address the concerns you have.
>>
>> Wins:
>>
>>    - 2 IOs for most: one to write the data to unused space in the block
>> device, one to commit our transaction (vs 4+ before).  For overwrites,
>> we'd have one io to do our write-ahead log (kv journal), then do the
>> overwrite async (vs 4+ before).
>>
>>    - No concern about mtime getting in the way
>>
>>    - Faster reads (no fs lookup)
>>
>>    - Similarly sized metadata for most objects.  If we assume most
>> objects are not fragmented, then the metadata to store the block
>> offsets is about the same size as the metadata to store the filenames we have now.
>>
>> Problems:
>>
>>    - We have to size the kv backend storage (probably still an XFS
>> partition) vs the block storage.  Maybe we do this anyway (put
>> metadata on
>> SSD!) so it won't matter.  But what happens when we are storing gobs
>> of rgw index data or cephfs metadata?  Suddenly we are pulling storage
>> out of a different pool and those aren't currently fungible.
>>
>>    - We have to write and maintain an allocator.  I'm still optimistic
>> this can be reasonbly simple, especially for the flash case (where
>> fragmentation isn't such an issue as long as our blocks are reasonbly
>> sized).  For disk we may beed to be moderately clever.
>>
>>    - We'll need a fsck to ensure our internal metadata is consistent.
>> The good news is it'll just need to validate what we have stored in
>> the kv store.
>>
>> Other thoughts:
>>
>>    - We might want to consider whether dm-thin or bcache or other block
>> layers might help us with elasticity of file vs block areas.
>>
>>    - Rocksdb can push colder data to a second directory, so we could
>> have a fast ssd primary area (for wal and most metadata) and a second
>> hdd directory for stuff it has to push off.  Then have a conservative
>> amount of file space on the hdd.  If our block fills up, use the
>> existing file mechanism to put data there too.  (But then we have to
>> maintain both the current kv + file approach and not go all-in on kv +
>> block.)
>>
>> Thoughts?
>> sage
>> --
>
> I really hate the idea of making a new file system type (even if we call it a raw block store!).
>
> In addition to the technical hurdles, there are also production worries like how long will it take for distros to pick up formal support?  How do we test it properly?
>
> Regards,
>
> Ric
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
