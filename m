From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: [RFC] Implement a new journal mode
Date: Wed, 03 Jun 2015 11:42:53 +0800
Message-ID: <556E77BD.8050400@ubuntukylin.com>
References: <55683011.7000307@ubuntukylin.com>	<alpine.DEB.2.00.1505290840180.6462@cobra.newdream.net>	<556D774E.4050702@ubuntukylin.com> <CACJqLyZ1-+=uXK0ztJNd_cw0yh8a=TRSooMnmv8iEapETX7Fyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:36702 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbbFCDnJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jun 2015 23:43:09 -0400
In-Reply-To: <CACJqLyZ1-+=uXK0ztJNd_cw0yh8a=TRSooMnmv8iEapETX7Fyw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Essentially, RBD is a block device with enhanced data consistency by
software implemented RAID. Metadata-only journal mode retains the RAID
mechanism. The RADOS-level object data journaling mechanism does not
help much in virtualization environment, since it is too fined-grained,
the application has to maintain its own journaling, for example, CephFS
must do journaling itself since there exists transactions refers to
multiple objects, which, currently, RADOS could not handle. RBD
mirroring is another example. Google submitted a patch to linux
kernel to turn off the journaling of ext4, since its distributed
file system on top of ext4 will do journaling itself, the
double-journaling degraded the performance. Similarly, the guest
file system on top of RBD will do journaling itself, if necessary,
so it is theoretically no problem to turn off the data journaling of RADOS.

Cheers,
Li Wang

On 2015/6/2 20:20, Haomai Wang wrote:
> On Tue, Jun 2, 2015 at 5:28 PM, Li Wang <liwang@ubuntukylin.com> wrote:
>> I think for scrub, we have a relatively easy way to solve it,
>> add a field to object metadata with the value being either UNSTABLE
>> or STABLE, the algorithm is as below,
>> 1 Mark the object be UNSTABLE
>> 2 Perform object data write
>
> I guess this write should be sync.
>
>> 3 Perform metadata write and MARK the object STABLE
>> The order of the three steps are enforced, and the step 1 and 3 are
>> written into journal, while step 2 is performed directly on the object.
>> For scrub, it could now distinguish this situation, and one feasible
>> policy could be to find the copy with the latest metadata, and
>> synchronize the data of that copy to others.
>
> UNSTABLE/STABLE markers also influent recovery thing I think, in other
> word, this way is a little like we "write the majority" strategy.
>
> Except complexity things, I'm more afraid of the macroscopic
> influences. Disk controller is only a local driver and mostly carry
> battery to ensure atomic unit write at least, but ceph is a
> distributed system which will bring more unstable things to io
> stack(any software bug will be amplificative). If we weaken constrains
> here, we will more rely to a stable/perfect guest filesystem
> impl(legacy filesystem won't safety here, and we can't distinguish the
> correctness among different os, kernel version). As a cloud provider
> side, application's io has be very long and expensive, we may want to
> have a strong consistent block storage to ensure the reliability of
> data. We could say rbd is safe for almost block usage, otherwise
> meeting data broken problem we will stuck into the big trouble! That's
> to say,  we say ceph is safe or unsafe(a broken ceph release) for a
> version not ceph may safe for some guest fs(use cases) or not. It may
> let ceph suffer more accidental accused.
>
>>
>> For this metadata-only journal mode, I think it does not contradict
>> with new store, since they address different scenarios. Metadata-only
>> journal mode mainly focuses on the scenarios that data consistency
>> does not need be ensured by RADOS itself. And it is especially appealing
>> for the scenarios with many random small OVERWRITES, for example, RBD
>> in cloud environment. While new store is great for CREATE and APPEND,
>> for many random small OVERWRITES, new store is not
>> very easy to optimize. It seems the only way is to introduce small size
>> of fragments and turn those OVERWRITES into APPEND. However, in that
>> case, many small OVERWRITES could cause many small files on the local
>> file system, it will slow down the subsequent read/write performance of
>> the object, so it seems not worthy. Of course, a small-file-merge
>> process could be introduced, but that complicates the design.
>>
>> So basically, I think new store is great for some of the scenarios,
>> while metadata-only is desirable for some others, they do not
>> contradict with each other, what do you think?
>>
>> Cheers,
>> Li Wang
>>
>>
>>
>>
>> On 2015/6/1 8:39, Sage Weil wrote:
>>>
>>> On Fri, 29 May 2015, Li Wang wrote:
>>>>
>>>> An important usage of Ceph is to integrate with cloud computing platform
>>>> to provide the storage for VM images and instances. In such scenario,
>>>> qemu maps RBD as virtual block devices, i.e., disks to a VM, and
>>>> the guest operating system will format the disks and create file
>>>> systems on them. In this case, RBD mostly resembles a 'dumb' disk.  In
>>>> other words, it is enough for RBD to implement exactly the semantics of
>>>> a disk controller driver. Typically, the disk controller itself does
>>>> not provide a transactional mechanism to ensure a write operation done
>>>> atomically. Instead, it is up to the file system, who manages the disk,
>>>> to adopt some techniques such as journaling to prevent inconsistency,
>>>> if necessary. Consequently, RBD does not need to provide the
>>>> atomic mechanism to ensure a data write operation done atomically,
>>>> since the guest file system will guarantee that its write operations to
>>>> RBD will remain consistent by using journaling if needed. Another
>>>> scenario is for the cache tiering, while cache pool has already
>>>> provided the durability, when dirty objects are written back, they
>>>> theoretically need not go through the journaling process of base pool,
>>>> since the flusher could replay the write operation. These motivate us
>>>> to implement a new journal mode, metadata-only journal mode, which
>>>> resembles the data=ordered journal mode in ext4. With such journal mode
>>>> is on, object data are written directly to their ultimate location,
>>>> when data written finished, metadata are written into the journal, then
>>>> the write returns to caller. This will avoid the double-write penalty
>>>> of object data due to the WRITE-AHEAD-LOGGING, potentially greatly
>>>> improve the RBD and cache tiering performance.
>>>>
>>>> The algorithm is straightforward, as before, the master send
>>>> transaction to slave, then they extract the object data write
>>>> operations and apply them to objects directly, next they write the
>>>> remaining part of the transaction into journal, then slave ack master,
>>>> master ack client. For some special operations such as 'clone', they
>>>> can be processed as before by throwing the entire transaction into
>>>> journal, which makes this approach an absolutely-better optimization
>>>> in terms of performance.
>>>>
>>>> In terms of consistency, metadata consistency is ensured, and
>>>> the data consistency of CREATE and APPEND are also ensured, just for
>>>> OVERWRITE, it relies on the caller, i.e., guest file system for RBD,
>>>> cache flusher for cache tiering to ensure the consistency. In addition,
>>>> there remains a problem to be discussed that how to interact with the
>>>> scrub process while the object data consistency may not ensured now.
>>>
>>>
>>> Right.  This is appealing from a performance perspective, but I'm worried
>>> it will throw out too many other assumptions in RADOS that will cause
>>> pain.  The big one is that RADOS will no longer know if the version on the
>>> object metadata matches the data.  This will be most noticeable from
>>> scrub, which will have no idea whether the inconsistency is from a partial
>>> write or from a disk error.  And when that happens, it would have to guess
>>> which object is the right one--a guess that can easily be wrong if there
>>> is rebalancing or recovery that may replicate the partially updated
>>> object.
>>>
>>> Maybe we can journal metadata before applying the write to indicate the
>>> object is 'unstable' (undergoing an overwrite) to help out?
>>>
>>> I'm not sure.  Honestly, I would be more interested in investing our time
>>> in making the new OSD backends handle overwrite more efficiently, by
>>> avoiding write-ahead in the easy cases (append, create) as newstore
>>> does, and/or by doing some sort of COW when we do overwrite, or some other
>>> magic that does an atomic swap-data-into-position (e.g., by abusing the
>>> xfs defrag ioctl).
>
> Yep! I'm interested in implementing a file translation layout here.
> Instead of relying to a magic from specified filesystem, I remember
> someone implement useful primitives like range-clone, range-move,
> range-discard based on ext4. So upper layout can enjoy inherent
> snapshot and single-write journal advantages! Although it may easy to
> do for SSD but hard for HDD.
>
>>>
>>> What do you think?
>>> sage
>>>
>>>
>>>    >
>>>>
>>>> We are actively working on it and have done part of the implementation,
>>>> want to hear the feedback of the community, and we may submit it as a
>>>> blueprint to under discussion in coming CDS.
>>>>
>>>> Cheers,
>>>> Li Wang
>>>>
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
