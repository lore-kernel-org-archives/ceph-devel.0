From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: [RFC] Implement a new journal mode
Date: Fri, 19 Jun 2015 11:45:46 +0800
Message-ID: <5583906A.4090500@ubuntukylin.com>
References: <55683011.7000307@ubuntukylin.com> <alpine.DEB.2.00.1505290840180.6462@cobra.newdream.net> <556D774E.4050702@ubuntukylin.com> <alpine.DEB.2.00.1506020759440.9814@cobra.newdream.net> <5582C8D7.6090201@ubuntukylin.com> <alpine.DEB.2.00.1506180708590.23826@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:60014 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbbFSDq3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jun 2015 23:46:29 -0400
In-Reply-To: <alpine.DEB.2.00.1506180708590.23826@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

1  Submit transaction A into journal, mark a <offset, length>
non-journaling data write in pglog (peering) or omap/xattrs(scrub)
2 Write data to object
3 Submit transaction B into journal, to update the metadata as well as
pglog as usual

I think the problem is far from severe, as long as one OSD in the PG
has succeeded, the PG will be recovered to a consistent and correct
state by peering; The only problematical situation is the PG down as a
whole, and none of the OSDs has finished Step (3), and at least one of
the OSDs has finished Step (1). In that case, we revise peering or
scrub to make them realize the semantics of transaction A, and randomly
choose one osd to synchronize its content of written area to other
copies. We prefer to leave it the scrub's job. Since scrub is done
asynchronously, and maybe be scheduled to run late, during this period, 
client's resend may have recovered the content to consistent.

Cheers,
Li Wang


On 2015/6/18 22:14, Sage Weil wrote:
> On Thu, 18 Jun 2015, Li Wang wrote:
>> Hi Sage,
>>    I think we can process the write in the following steps,
>> (1) Submit transaction A to journal, include a PGLog update and a
>> write zero operation at <offset, length>
>> (2) Write the object at <offset, length>
>> (3) Submit a transaction B to journal, include a PGLog update and the metadata
>> update, if successfully submitted, it will disable the write
>> zero operation at <offset, length> in Step (1)
>>
>> The steps are ordered. In fact, if all done successfully, the object will be
>> updated for two versions.
>>
>> Fault Tolerance
>> 1 Crash before (1) done, nothing will happen
>> 2 Crash before (3) done, the object will be updated for one version on at
>> least one copy, the local journal replay plus peering will recover the PG to a
>> consistent state: with the written area on all copies are zero
>> 3 Crash after at least one copy has done (3), then local journal replay
>> and peering will recover the PG to a consistent state
>>
>> With this process, it is transparent to scrub. We will describe it in
>> detail at the blueprint page later.
>>
>> What do you think?
>
> It solves the scrub issue nicely.  However, it think it breaks the client
> behavior.  The overwrite-in-place works from RBD's perspective because
> block device semantics are such that we are happy with either old or new
> content on an interrupted write.  With the above, a crash will result in a
> zeroed region.  If the client though the request was acked it won't
> resend.. and even if it does, we don't handle the case where the client
> also fails and can't resend.
>
> I think that the old-or-new semantic requirement is at odds with the
> zeroing strategy.  It seems like the only way to make this work is to
> have RADOS ignore scrub errors within that region (or on the whole object)
> if it is marked unstable.  :/
>
> sage
>
>>
>> Cheers,
>> Li Wang
>>
>> On 2015/6/3 8:49, Sage Weil wrote:
>>> On Tue, 2 Jun 2015, Li Wang wrote:
>>>> I think for scrub, we have a relatively easy way to solve it,
>>>> add a field to object metadata with the value being either UNSTABLE
>>>> or STABLE, the algorithm is as below,
>>>> 1 Mark the object be UNSTABLE
>>>> 2 Perform object data write
>>>> 3 Perform metadata write and MARK the object STABLE
>>>> The order of the three steps are enforced, and the step 1 and 3 are
>>>> written into journal, while step 2 is performed directly on the object.
>>>> For scrub, it could now distinguish this situation, and one feasible
>>>> policy could be to find the copy with the latest metadata, and
>>>> synchronize the data of that copy to others.
>>>
>>> If you have some failure and some copies are unstable and some are stable,
>>> then sure, you can recover.  What do you do if all copies are unstable?
>>> You can arbitrarily sync them up (just pick a copy), but if you mark it
>>> stable, you have to pick a version to go with it... is it new or old?
>>>
>>>> For this metadata-only journal mode, I think it does not contradict
>>>> with new store, since they address different scenarios. Metadata-only
>>>> journal mode mainly focuses on the scenarios that data consistency
>>>> does not need be ensured by RADOS itself. And it is especially appealing
>>>> for the scenarios with many random small OVERWRITES, for example, RBD
>>>> in cloud environment. While new store is great for CREATE and APPEND,
>>>> for many random small OVERWRITES, new store is not
>>>> very easy to optimize. It seems the only way is to introduce small size
>>>> of fragments and turn those OVERWRITES into APPEND. However, in that
>>>> case, many small OVERWRITES could cause many small files on the local
>>>> file system, it will slow down the subsequent read/write performance of
>>>> the object, so it seems not worthy. Of course, a small-file-merge
>>>> process could be introduced, but that complicates the design.
>>>
>>> Yeah, I see the use-case.  I'm just worried about what else is would
>>> affect.
>>>
>>> This would take the form of... a flag on ObjectStore's write, indicating
>>> it is allowed to be leave the object in some nondeterministic state?  Is
>>> the rule that only the bytes indicated by the write may be changed (to
>>> either new or old values), or is allowed to corrupt the entire object?
>>>
>>> sage
>>>
>>>
>>>> So basically, I think new store is great for some of the scenarios,
>>>> while metadata-only is desirable for some others, they do not
>>>> contradict with each other, what do you think?
>>>>
>>>> Cheers,
>>>> Li Wang
>>>>
>>>>
>>>>
>>>> On 2015/6/1 8:39, Sage Weil wrote:
>>>>> On Fri, 29 May 2015, Li Wang wrote:
>>>>>> An important usage of Ceph is to integrate with cloud computing
>>>>>> platform
>>>>>> to provide the storage for VM images and instances. In such scenario,
>>>>>> qemu maps RBD as virtual block devices, i.e., disks to a VM, and
>>>>>> the guest operating system will format the disks and create file
>>>>>> systems on them. In this case, RBD mostly resembles a 'dumb' disk.  In
>>>>>> other words, it is enough for RBD to implement exactly the semantics
>>>>>> of
>>>>>> a disk controller driver. Typically, the disk controller itself does
>>>>>> not provide a transactional mechanism to ensure a write operation done
>>>>>> atomically. Instead, it is up to the file system, who manages the
>>>>>> disk,
>>>>>> to adopt some techniques such as journaling to prevent inconsistency,
>>>>>> if necessary. Consequently, RBD does not need to provide the
>>>>>> atomic mechanism to ensure a data write operation done atomically,
>>>>>> since the guest file system will guarantee that its write operations
>>>>>> to
>>>>>> RBD will remain consistent by using journaling if needed. Another
>>>>>> scenario is for the cache tiering, while cache pool has already
>>>>>> provided the durability, when dirty objects are written back, they
>>>>>> theoretically need not go through the journaling process of base pool,
>>>>>> since the flusher could replay the write operation. These motivate us
>>>>>> to implement a new journal mode, metadata-only journal mode, which
>>>>>> resembles the data=ordered journal mode in ext4. With such journal
>>>>>> mode
>>>>>> is on, object data are written directly to their ultimate location,
>>>>>> when data written finished, metadata are written into the journal,
>>>>>> then
>>>>>> the write returns to caller. This will avoid the double-write penalty
>>>>>> of object data due to the WRITE-AHEAD-LOGGING, potentially greatly
>>>>>> improve the RBD and cache tiering performance.
>>>>>>
>>>>>> The algorithm is straightforward, as before, the master send
>>>>>> transaction to slave, then they extract the object data write
>>>>>> operations and apply them to objects directly, next they write the
>>>>>> remaining part of the transaction into journal, then slave ack master,
>>>>>> master ack client. For some special operations such as 'clone', they
>>>>>> can be processed as before by throwing the entire transaction into
>>>>>> journal, which makes this approach an absolutely-better optimization
>>>>>> in terms of performance.
>>>>>>
>>>>>> In terms of consistency, metadata consistency is ensured, and
>>>>>> the data consistency of CREATE and APPEND are also ensured, just for
>>>>>> OVERWRITE, it relies on the caller, i.e., guest file system for RBD,
>>>>>> cache flusher for cache tiering to ensure the consistency. In
>>>>>> addition,
>>>>>> there remains a problem to be discussed that how to interact with the
>>>>>> scrub process while the object data consistency may not ensured now.
>>>>>
>>>>> Right.  This is appealing from a performance perspective, but I'm
>>>>> worried
>>>>> it will throw out too many other assumptions in RADOS that will cause
>>>>> pain.  The big one is that RADOS will no longer know if the version on
>>>>> the
>>>>> object metadata matches the data.  This will be most noticeable from
>>>>> scrub, which will have no idea whether the inconsistency is from a
>>>>> partial
>>>>> write or from a disk error.  And when that happens, it would have to
>>>>> guess
>>>>> which object is the right one--a guess that can easily be wrong if there
>>>>> is rebalancing or recovery that may replicate the partially updated
>>>>> object.
>>>>>
>>>>> Maybe we can journal metadata before applying the write to indicate the
>>>>> object is 'unstable' (undergoing an overwrite) to help out?
>>>>>
>>>>> I'm not sure.  Honestly, I would be more interested in investing our
>>>>> time
>>>>> in making the new OSD backends handle overwrite more efficiently, by
>>>>> avoiding write-ahead in the easy cases (append, create) as newstore
>>>>> does, and/or by doing some sort of COW when we do overwrite, or some
>>>>> other
>>>>> magic that does an atomic swap-data-into-position (e.g., by abusing the
>>>>> xfs defrag ioctl).
>>>>>
>>>>> What do you think?
>>>>> sage
>>>>>
>>>>>
>>>>>     >
>>>>>> We are actively working on it and have done part of the
>>>>>> implementation,
>>>>>> want to hear the feedback of the community, and we may submit it as a
>>>>>> blueprint to under discussion in coming CDS.
>>>>>>
>>>>>> Cheers,
>>>>>> Li Wang
>>>>>>
>>>>>>
>>>>>
>>>>
>>>>
>>>
>>
>>
>
