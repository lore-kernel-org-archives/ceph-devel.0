From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: 2 related bluestore questions
Date: Tue, 10 May 2016 17:41:46 +0300
Message-ID: <b6240191-0849-d60c-ebb6-147b5785e3e7@mirantis.com>
References: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com>
 <6168022b-e3c0-b8f2-e8c7-3b4b82f9dc6e@mirantis.com>
 <alpine.DEB.2.11.1605100841400.15518@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33857 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbcEJOlu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 10:41:50 -0400
Received: by mail-lf0-f52.google.com with SMTP id m64so17421937lfd.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 07:41:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605100841400.15518@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: allen.samuels@sandisk.com, ceph-devel@vger.kernel.org


On 10.05.2016 15:53, Sage Weil wrote:
> On Tue, 10 May 2016, Igor Fedotov wrote:
>> Hi Sage,
>> Please find my comments below.
>>
>> WRT 1. there is an alternative approach that doesn't need persistent refmap.
>> It works for non-shared bnode only though. In fact one can build such a refmap
>> using onode's lextents map pretty easy. It looks like any procedure that
>> requires such a refmap has a logical offset as an input. This provides an
>> appropriate lextent referring to some blob we need refmap for. What we need to
>> do for blob's refmap building is to enumerate lextents within +-max_blob_size
>> range from the original loffset. I suppose we are going to avoid small lextent
>> entries most of time by merging them thus such enumeration should be short
>> enough. Most probably such refmap build is needed for background wal procedure
>> (or its replacement - see below) thus it wouldn't affect primary write path
>> performance. And this procedure will require some neighboring lxtent
>> enumeration to detect  lextents to merge anyway.
>>
>> Actually I don't have strong opinion which approach is better.  Just a minor
>> point that tracking persistent refmap is a bit more complex and space
>> consuming.
> Yeah, that's my only real concern--and mostly on the memory allocation
> side, less so on the size of the encoded metadata.  Since the alternative
> only works in the non-shared bnode case, I think it'll be simpler to only
> implement one approach for now, and consider optimizing later, since we'd
> have to implement to share-capable approach either way.  (For example,
> most blobs will have one reference for their full range; we could probably
> represent this as an empty map with a bit of care.)
So the initial approach is to have refmap, right?
>> WRT to 2. IMO single  byte granularity is OK. Initial write request handling
>> can create lextents of any size depending on the input data blocks. But we
>> will try to eliminate it during wal processing to have larger extents and
>> better space usage though.
> Ok cool.
>   
>> WRT WAL changes. My idea is to replace WAL with a bit different extent merge
>> (defragmenter, garbage collector, space optimizer - whatever name of your
>> choice) process. The main difference - current WAL implementation tracks some
>> user data and thus it's a part of the consistency model (i.e. one has to check
>> if data block is in the WAL). In my approach data is always consistent without
>> such a service. At the first write handling step we always write data to the
>> store by allocating new blob and modifying lextent map. And apply
>> corresponding checksum using regular means if needed. Thus we always have
>> consistent data in lextent/blob structures. And defragmenter process is just a
>> cleanup/optimization thread that merges sparse lextents to improve space
>> utilization. To avoid full lextent map enumeration during defragmentation
>> ExtentManager (or whatever entity that handles writes) may return some 'hints'
>> where space optimization should be applied. This is to be done at initial
>> write processing. Such hint is most probably just a logical offset or some
>> interval within object logical space. Write handler provides such a hint if it
>> detects (by lextent map inspection) that optimization is required, e.g. in
>> case of partial lextent overwrite, big hole punch, sparse small lextents etc.
>> Pending optimization tasks (list of hints) are maintained by the BlueStore and
>> passed to EM (or another corresponding entity) for processing in the context
>> of a specific thread. Based of such hints defragmenter locates lextents to
>> merge and do the job: Read/Modify/Write multiple lextents and/or blobs.
>> Optionally this can be done with with some delay to care write burst within a
>> specific object region. Another point is that hint list can be potentially
>> tracked without KV store (some in-memory data structure is enough) as there is
>> no mandatory need for its replay in case of OSD failure - data are always
>> consistent at the store and failure can lead to some local space
>> ineffectiveness only. That's a rare case though.
>>
>> What do you think about this approach?
> My concern is that it makes a simple overwrite less IO efficient because
> you have to (1) write a new (temporary-ish) blob, (2) commit the kv
> transaction, and then (3) write an updated/merged blob, then (4) commit
> the kv txn for new blob.
Yes, that's true. But there are some concerns about WAL case as well:
1) Are you sure that writing larger KV record ( metadata + user data ) 
is better than direct data write to the store + smaller KV (metadata 
only) update?

2) Either WAL records will increase or we need to have both WAL and 
optimizer simultaneously. Especially for compressed case. As far as I 
understand currently WAL record has up to block_size bytes of user data. 
With blob introduction this raises up to max_blob_size ( 
N*min_alloc_size). Or we'll need to maintain both WAL and optimizer
E.g. there is an lextent 0~256K and overwrite 1K~254K, block size = 4K
For no checksum and compression case WAL records are 2 * 3K
For checksum case WAL records are 2 * (max( csum_block_size, block_size) 
- 1K)
For compression case WAL records are 2 * (max( max_blob_size, 
block_size) - 1K) or do that temporary blob allocation.

3) WAL apply locks the subsequent read until its completion. I.e. 
subsequent read has to wait until WAL apply is completed ( o->flush() 
call in _do_read()). In case of optimizer approach lock can be postponed 
as optimizer doesn't need to perform the task immediately.

> And if I understand the proposal correctly any
> overwrite is still off-limits because you can't to the overwrite IO
> atomically with the kv commit.  Is that right?
Could you please elaborate - not sure I understand the question.
> Making the wal part of the consistency model is more complex, but it means
> we can (1) log our intent to overwrite atomically with the kv txn commit,
> and then (2) do the async overwrite.  It will get a bit more complex
> because we'll be doing metadata updates as part of the wal completion, but
> it's not a big step from where we are now, and I think the performance
> benefit will be worth it.
May I have some example how it's supposed to work please?

> I think we'll still want a gc/cleanup/optimizer async process like you
> describe, but it can be driven by wal hints or whatever other mechanism we
> like.
>
> sage

