From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: newstore direction
Date: Wed, 21 Oct 2015 07:18:00 -0400
Message-ID: <56277468.5000504@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <56268886.7010806@redhat.com> <1445415736.1809.71.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932112AbbJULSD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Oct 2015 07:18:03 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 0BE03A84
	for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2015 11:18:03 +0000 (UTC)
In-Reply-To: <1445415736.1809.71.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 10/21/2015 04:22 AM, Orit Wasserman wrote:
> On Tue, 2015-10-20 at 14:31 -0400, Ric Wheeler wrote:
>> On 10/19/2015 03:49 PM, Sage Weil wrote:
>>> The current design is based on two simple ideas:
>>>
>>>    1) a key/value interface is better way to manage all of our internal
>>> metadata (object metadata, attrs, layout, collection membership,
>>> write-ahead logging, overlay data, etc.)
>>>
>>>    2) a file system is well suited for storage object data (as files).
>>>
>>> So far 1 is working out well, but I'm questioning the wisdom of #2.  A few
>>> things:
>>>
>>>    - We currently write the data to the file, fsync, then commit the kv
>>> transaction.  That's at least 3 IOs: one for the data, one for the fs
>>> journal, one for the kv txn to commit (at least once my rocksdb changes
>>> land... the kv commit is currently 2-3).  So two people are managing
>>> metadata, here: the fs managing the file metadata (with its own
>>> journal) and the kv backend (with its journal).
>> If all of the fsync()'s fall into the same backing file system, are you sure
>> that each fsync() takes the same time? Depending on the local FS implementation
>> of course, but the order of issuing those fsync()'s can effectively make some of
>> them no-ops.
>>
>>>    - On read we have to open files by name, which means traversing the fs
>>> namespace.  Newstore tries to keep it as flat and simple as possible, but
>>> at a minimum it is a couple btree lookups.  We'd love to use open by
>>> handle (which would reduce this to 1 btree traversal), but running
>>> the daemon as ceph and not root makes that hard...
>> This seems like a a pretty low hurdle to overcome.
>>
>>>    - ...and file systems insist on updating mtime on writes, even when it is
>>> a overwrite with no allocation changes.  (We don't care about mtime.)
>>> O_NOCMTIME patches exist but it is hard to get these past the kernel
>>> brainfreeze.
>> Are you using O_DIRECT? Seems like there should be some enterprisey database
>> tricks that we can use here.
>>
>>>    - XFS is (probably) never going going to give us data checksums, which we
>>> want desperately.
>> What is the goal of having the file system do the checksums? How strong do they
>> need to be and what size are the chunks?
>>
>> If you update this on each IO, this will certainly generate more IO (each write
>> will possibly generate at least one other write to update that new checksum).
>>
>>> But what's the alternative?  My thought is to just bite the bullet and
>>> consume a raw block device directly.  Write an allocator, hopefully keep
>>> it pretty simple, and manage it in kv store along with all of our other
>>> metadata.
>> The big problem with consuming block devices directly is that you ultimately end
>> up recreating most of the features that you had in the file system. Even
>> enterprise databases like Oracle and DB2 have been migrating away from running
>> on raw block devices in favor of file systems over time.  In effect, you are
>> looking at making a simple on disk file system which is always easier to start
>> than it is to get back to a stable, production ready state.
> The best performance is still on block device (SAN).
> File system simplify the operation tasks which worth the performance
> penalty for a database. I think in a storage system this is not the
> case.
> In many cases they can use their own file system that is tailored for
> the database.

You will have to trust me on this as the Red Hat person who spoke to pretty much 
all of our key customers about local file systems and storage - customers all 
have migrated over to using normal file systems under Oracle/DB2. Typically, 
they use XFS or ext4.  I don't know of any non-standard file systems and only 
have seen one account running on a raw block store in 8 years :)

If you have a pre-allocated file and write using O_DIRECT, your IO path is 
identical in terms of IO's sent to the device.

If we are causing additional IO's, then we really need to spend some time 
talking to the local file system gurus about this in detail.  I can help with 
that conversation.

>
>> I think that it might be quicker and more maintainable to spend some time
>> working with the local file system people (XFS or other) to see if we can
>> jointly address the concerns you have.
>>> Wins:
>>>
>>>    - 2 IOs for most: one to write the data to unused space in the block
>>> device, one to commit our transaction (vs 4+ before).  For overwrites,
>>> we'd have one io to do our write-ahead log (kv journal), then do
>>> the overwrite async (vs 4+ before).
>>>
>>>    - No concern about mtime getting in the way
>>>
>>>    - Faster reads (no fs lookup)
>>>
>>>    - Similarly sized metadata for most objects.  If we assume most objects
>>> are not fragmented, then the metadata to store the block offsets is about
>>> the same size as the metadata to store the filenames we have now.
>>>
>>> Problems:
>>>
>>>    - We have to size the kv backend storage (probably still an XFS
>>> partition) vs the block storage.  Maybe we do this anyway (put metadata on
>>> SSD!) so it won't matter.  But what happens when we are storing gobs of
>>> rgw index data or cephfs metadata?  Suddenly we are pulling storage out of
>>> a different pool and those aren't currently fungible.
>>>
>>>    - We have to write and maintain an allocator.  I'm still optimistic this
>>> can be reasonbly simple, especially for the flash case (where
>>> fragmentation isn't such an issue as long as our blocks are reasonbly
>>> sized).  For disk we may beed to be moderately clever.
>>>
>>>    - We'll need a fsck to ensure our internal metadata is consistent.  The
>>> good news is it'll just need to validate what we have stored in the kv
>>> store.
>>>
>>> Other thoughts:
>>>
>>>    - We might want to consider whether dm-thin or bcache or other block
>>> layers might help us with elasticity of file vs block areas.
>>>
>>>    - Rocksdb can push colder data to a second directory, so we could have a
>>> fast ssd primary area (for wal and most metadata) and a second hdd
>>> directory for stuff it has to push off.  Then have a conservative amount
>>> of file space on the hdd.  If our block fills up, use the existing file
>>> mechanism to put data there too.  (But then we have to maintain both the
>>> current kv + file approach and not go all-in on kv + block.)
>>>
>>> Thoughts?
>>> sage
>>> --
>> I really hate the idea of making a new file system type (even if we call it a
>> raw block store!).
>>
> This won't be a file system but just an allocator which is a very small
> part of a file system.

That is always the intention and then we wake up a few years into the project 
with something that looks and smells like a file system as we slowly bring in 
just one more small thing at a time.

>
> The benefits are not just in reducing the number of IO operations we
> preform, we are also removing the file system stack overhead that will
> reduce our latency and make it more predictable.
> Removing this layer will give use more control and allow us other
> optimization we cannot do today.

I strongly disagree here - we can get that optimal number of IO's if we use the 
file system API's developed over the years to support enterprise databases.  And 
we can have that today without having to re-write allocation routines and checkers.

>
> I think this is more acute when taking SSD (and even faster
> technologies) into account.

XFS and ext4 both support DAX, so we can effectively do direct writes to 
persistent memory (no block IO required). Most of the work over the past few 
years in the IO stack has been around driving IOPs at insanely high rates on top 
of the whole stack (file system layer included) and we have really good results.

>
>> In addition to the technical hurdles, there are also production worries like how
>> long will it take for distros to pick up formal support?  How do we test it
>> properly?
>>
> This should be userspace only, I don't think we need it in the kernel
> (will need root access for opening the device).
> For users that don't have root access we can use one big file and use
> the same allocator in it. It can be good for testing too.
>
> As someone that already been part of such a
> move more than once (for example in Exanet) I can say that the
> performance gain is very impressive and after the change we could
> remove many workarounds which simplified the code.
>
> As the API should be small the testing effort is reasonable, we do need
> to test it well as a bug in the allocator has really bad consequences.
>
> We won't be able to match (or exceed) our competitors performance
> without making this effort ...
>
> Orit
>

I don't agree that we will see a performance win if we use the file system 
properly.  Certainly, you can measure a slow path through a file system and then 
show an improvement with a new, user space block access, but that is not a long 
term path to success.  As far as I know, exanet never published their code or 
performance numbers when measured against local file systems, but it would be 
easy to show how well we can drive XFS or ext4.

Regardless of the address space that the code lives in, we will need to test it 
over things that file systems already know how to do.

Regards,

Ric


