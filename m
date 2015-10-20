From: Mark Nelson <mnelson@redhat.com>
Subject: Re: newstore direction
Date: Tue, 20 Oct 2015 08:19:37 -0500
Message-ID: <56263F69.9080700@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F3174851F@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1510191353100.16833@cobra.newdream.net> <99767EA2E27DD44DB4E9F9B9ACA458C056195331@SSIEXCH-MB3.ssi.samsung.com> <6F3FA899187F0043BA1827A69DA2F7CC036341E8@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1510200526530.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43897 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbbJTNTk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 Oct 2015 09:19:40 -0400
In-Reply-To: <alpine.DEB.2.00.1510200526530.16833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/20/2015 07:30 AM, Sage Weil wrote:
> On Tue, 20 Oct 2015, Chen, Xiaoxi wrote:
>> +1, nowadays K-V DB care more about very small key-value pairs, say
>> several bytes to a few KB, but in SSD case we only care about 4KB or
>> 8KB. In this way, NVMKV is a good design and seems some of the SSD
>> vendor are also trying to build this kind of interface, we had a NVM-L
>> library but still under development.
>
> Do you have an NVMKV link?  I see a paper and a stale github repo.. not
> sure if I'm looking at the right thing.
>
> My concern with using a key/value interface for the object data is that
> you end up with lots of key/value pairs (e.g., $inode_$offset =
> $4kb_of_data) that is pretty inefficient to store and (depending on the
> implementation) tends to break alignment.  I don't think these interfaces
> are targetted toward block-sized/aligned payloads.  Storing just the
> metadata (block allocation map) w/ the kv api and storing the data
> directly on a block/page interface makes more sense to me.
>
> sage

I get the feeling that some of the folks that were involved with nvmkv 
at Fusion IO have left.  Nisha Talagala is now out at Parallel Systems 
for instance.  http://pmem.io might be a better bet, though I haven't 
looked closely at it.

Mark

>
>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of James (Fei) Liu-SSI
>>> Sent: Tuesday, October 20, 2015 6:21 AM
>>> To: Sage Weil; Somnath Roy
>>> Cc: ceph-devel@vger.kernel.org
>>> Subject: RE: newstore direction
>>>
>>> Hi Sage and Somnath,
>>>    In my humble opinion, There is another more aggressive  solution than raw
>>> block device base keyvalue store as backend for objectstore. The new key
>>> value  SSD device with transaction support would be  ideal to solve the issues.
>>> First of all, it is raw SSD device. Secondly , It provides key value interface
>>> directly from SSD. Thirdly, it can provide transaction support, consistency will
>>> be guaranteed by hardware device. It pretty much satisfied all of objectstore
>>> needs without any extra overhead since there is not any extra layer in
>>> between device and objectstore.
>>>     Either way, I strongly support to have CEPH own data format instead of
>>> relying on filesystem.
>>>
>>>    Regards,
>>>    James
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of Sage Weil
>>> Sent: Monday, October 19, 2015 1:55 PM
>>> To: Somnath Roy
>>> Cc: ceph-devel@vger.kernel.org
>>> Subject: RE: newstore direction
>>>
>>> On Mon, 19 Oct 2015, Somnath Roy wrote:
>>>> Sage,
>>>> I fully support that.  If we want to saturate SSDs , we need to get
>>>> rid of this filesystem overhead (which I am in process of measuring).
>>>> Also, it will be good if we can eliminate the dependency on the k/v
>>>> dbs (for storing allocators and all). The reason is the unknown write
>>>> amps they causes.
>>>
>>> My hope is to keep behing the KeyValueDB interface (and/more change it as
>>> appropriate) so that other backends can be easily swapped in (e.g. a btree-
>>> based one for high-end flash).
>>>
>>> sage
>>>
>>>
>>>>
>>>> Thanks & Regards
>>>> Somnath
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: ceph-devel-owner@vger.kernel.org
>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
>>>> Sent: Monday, October 19, 2015 12:49 PM
>>>> To: ceph-devel@vger.kernel.org
>>>> Subject: newstore direction
>>>>
>>>> The current design is based on two simple ideas:
>>>>
>>>>   1) a key/value interface is better way to manage all of our internal
>>>> metadata (object metadata, attrs, layout, collection membership,
>>>> write-ahead logging, overlay data, etc.)
>>>>
>>>>   2) a file system is well suited for storage object data (as files).
>>>>
>>>> So far 1 is working out well, but I'm questioning the wisdom of #2.  A
>>>> few
>>>> things:
>>>>
>>>>   - We currently write the data to the file, fsync, then commit the kv
>>>> transaction.  That's at least 3 IOs: one for the data, one for the fs
>>>> journal, one for the kv txn to commit (at least once my rocksdb
>>>> changes land... the kv commit is currently 2-3).  So two people are
>>>> managing metadata, here: the fs managing the file metadata (with its
>>>> own
>>>> journal) and the kv backend (with its journal).
>>>>
>>>>   - On read we have to open files by name, which means traversing the fs
>>> namespace.  Newstore tries to keep it as flat and simple as possible, but at a
>>> minimum it is a couple btree lookups.  We'd love to use open by handle
>>> (which would reduce this to 1 btree traversal), but running the daemon as
>>> ceph and not root makes that hard...
>>>>
>>>>   - ...and file systems insist on updating mtime on writes, even when it is a
>>> overwrite with no allocation changes.  (We don't care about mtime.)
>>> O_NOCMTIME patches exist but it is hard to get these past the kernel
>>> brainfreeze.
>>>>
>>>>   - XFS is (probably) never going going to give us data checksums, which we
>>> want desperately.
>>>>
>>>> But what's the alternative?  My thought is to just bite the bullet and
>>> consume a raw block device directly.  Write an allocator, hopefully keep it
>>> pretty simple, and manage it in kv store along with all of our other metadata.
>>>>
>>>> Wins:
>>>>
>>>>   - 2 IOs for most: one to write the data to unused space in the block device,
>>> one to commit our transaction (vs 4+ before).  For overwrites, we'd have one
>>> io to do our write-ahead log (kv journal), then do the overwrite async (vs 4+
>>> before).
>>>>
>>>>   - No concern about mtime getting in the way
>>>>
>>>>   - Faster reads (no fs lookup)
>>>>
>>>>   - Similarly sized metadata for most objects.  If we assume most objects are
>>> not fragmented, then the metadata to store the block offsets is about the
>>> same size as the metadata to store the filenames we have now.
>>>>
>>>> Problems:
>>>>
>>>>   - We have to size the kv backend storage (probably still an XFS
>>>> partition) vs the block storage.  Maybe we do this anyway (put
>>>> metadata on
>>>> SSD!) so it won't matter.  But what happens when we are storing gobs of
>>> rgw index data or cephfs metadata?  Suddenly we are pulling storage out of a
>>> different pool and those aren't currently fungible.
>>>>
>>>>   - We have to write and maintain an allocator.  I'm still optimistic this can be
>>> reasonbly simple, especially for the flash case (where fragmentation isn't
>>> such an issue as long as our blocks are reasonbly sized).  For disk we may
>>> beed to be moderately clever.
>>>>
>>>>   - We'll need a fsck to ensure our internal metadata is consistent.  The good
>>> news is it'll just need to validate what we have stored in the kv store.
>>>>
>>>> Other thoughts:
>>>>
>>>>   - We might want to consider whether dm-thin or bcache or other block
>>> layers might help us with elasticity of file vs block areas.
>>>>
>>>>   - Rocksdb can push colder data to a second directory, so we could
>>>> have a fast ssd primary area (for wal and most metadata) and a second
>>>> hdd directory for stuff it has to push off.  Then have a conservative
>>>> amount of file space on the hdd.  If our block fills up, use the
>>>> existing file mechanism to put data there too.  (But then we have to
>>>> maintain both the current kv + file approach and not go all-in on kv +
>>>> block.)
>>>>
>>>> Thoughts?
>>>> sage
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More
>>> majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>> ________________________________
>>>>
>>>> PLEASE NOTE: The information contained in this electronic mail message is
>>> intended only for the use of the designated recipient(s) named above. If the
>>> reader of this message is not the intended recipient, you are hereby notified
>>> that you have received this message in error and that any review,
>>> dissemination, distribution, or copying of this message is strictly prohibited. If
>>> you have received this communication in error, please notify the sender by
>>> telephone or e-mail (as shown above) immediately and destroy any and all
>>> copies of this message in your possession (whether hard copies or
>>> electronically stored copies).
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More
>>> majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
>>> body of a message to majordomo@vger.kernel.org More majordomo info at
>>> http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
>>> body of a message to majordomo@vger.kernel.org More majordomo info at
>>> http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
