From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: newstore direction
Date: Wed, 21 Oct 2015 11:51:13 -0400
Message-ID: <5627B471.1040602@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <56268886.7010806@redhat.com>
 <7334B4281E425749B85E08CF7EC6F8534383DD15@SACMBXIP03.sdcorp.global.sandisk.com>
 <562775DD.8050304@redhat.com> <56279DD3.4020901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40818 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbbJUPvO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Oct 2015 11:51:14 -0400
In-Reply-To: <56279DD3.4020901@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/21/2015 10:14 AM, Mark Nelson wrote:
>
>
> On 10/21/2015 06:24 AM, Ric Wheeler wrote:
>>
>>
>> On 10/21/2015 06:06 AM, Allen Samuels wrote:
>>> I agree that moving newStore to raw block is going to be a significant
>>> development effort. But the current scheme of using a KV store
>>> combined with a normal file system is always going to be problematic
>>> (FileStore or NewStore). This is caused by the transactional
>>> requirements of the ObjectStore interface, essentially you need to
>>> make transactionally consistent updates to two indexes, one of which
>>> doesn't understand transactions (File Systems) and can never be
>>> tightly-connected to the other one.
>>>
>>> You'll always be able to make this "loosely coupled" approach work,
>>> but it will never be optimal. The real question is whether the
>>> performance difference of a suboptimal implementation is something
>>> that you can live with compared to the longer gestation period of the
>>> more optimal implementation. Clearly, Sage believes that the
>>> performance difference is significant or he wouldn't have kicked off
>>> this discussion in the first place.
>>
>> I think that we need to work with the existing stack - measure and do
>> some collaborative analysis - before we throw out decades of work.  Very
>> hard to understand why the local file system is a barrier for
>> performance in this case when it is not an issue in existing enterprise
>> applications.
>>
>> We need some deep analysis with some local file system experts thrown in
>> to validate the concerns.
>
> I think Sage has been working pretty closely with the XFS guys to uncover 
> these kinds of issues.  I know if I encounter something fairly FS specific I 
> try to drag Eric or Dave in.  I think the core of the problem is that we often 
> find ourselves exercising filesystems in pretty unusual ways.  While it's 
> probably good that we add this kind of coverage and help work out somewhat 
> esoteric bugs, I think it does make our job of making Ceph perform well 
> harder.  One example:  I had been telling folks for several years to favor 
> dentry and inode cache due to the way our PG directory splitting works (backed 
> by test results), but then Sage discovered:
>
> http://www.spinics.net/lists/ceph-devel/msg25644.html
>
> This is just one example of how very nuanced our performance story is. I can 
> keep many users at least semi-engaged when talking about objects being laid 
> out in a nested directory structure, how dentry/inode cache affects that in a 
> general sense, etc.  But combine the kind of subtlety in the link above with 
> the vastness of things in the data path that can hurt performance, and people 
> generally just can't wrap their heads around all of it (With the exception of 
> some of the very smart folks on this mailing list!)
>
> One of my biggest concerns going forward is reducing the user-facing 
> complexity of our performance story.  The question I ask myself is: Does 
> keeping Ceph on a FS help us or hurt us in that regard?

The upshot of that is that the kind of micro-optimization is already handled by 
the file system, so the application job should be easier. Better to fsync() each 
file from an application that you care about rather than to worry about using 
more obscure calls.

>
>>
>>>
>>> While I think we can all agree that writing a full-up KV and raw-block
>>> ObjectStore is a significant amount of work. I will offer the case
>>> that the "loosely couple" scheme may not have as much time-to-market
>>> advantage as it appears to have. One example: NewStore performance is
>>> limited due to bugs in XFS that won't be fixed in the field for quite
>>> some time (it'll take at least a couple of years before a patched
>>> version of XFS will be widely deployed at customer environments).
>>
>> Not clear what bugs you are thinking of or why you think fixing bugs
>> will take a long time to hit the field in XFS. Red Hat has most of the
>> XFS developers on staff and we actively backport fixes and ship them,
>> other distros do as well.
>>
>> Never seen a "bug" take a couple of years to hit users.
>
> Maybe a good way to start out would be to see how quickly we can get the patch 
> dchinner posted here:
>
> http://oss.sgi.com/archives/xfs/2015-10/msg00545.html
>
> rolled out into RHEL/CentOS/Ubuntu.  I have no idea how long these things 
> typically take, but this might be a good test case.

How quickly things land in a distro is up to the interested parties making the 
case for it.

Ric

>
>>
>> Regards,
>>
>> Ric
>>
>>>
>>> Another example: Sage has just had to substantially rework the
>>> journaling code of rocksDB.
>>>
>>> In short, as you can tell, I'm full throated in favor of going down
>>> the optimal route.
>>>
>>> Internally at Sandisk, we have a KV store that is optimized for flash
>>> (it's called ZetaScale). We have extended it with a raw block
>>> allocator just as Sage is now proposing to do. Our internal
>>> performance measurements show a significant advantage over the current
>>> NewStore. That performance advantage stems primarily from two things:
>>>
>>> (1) ZetaScale uses a B+-tree internally rather than an LSM tree
>>> (levelDB/RocksDB). LSM trees experience exponential increase in write
>>> amplification (cost of an insert) as the amount of data under
>>> management increases. B+tree write-amplification is nearly constant
>>> independent of the size of data under management. As the KV database
>>> gets larger (Since newStore is effectively moving the per-file inode
>>> into the kv data base. Don't forget checksums that Sage want's to add
>>> :)) this performance delta swamps all others.
>>> (2) Having a KV and a file-system causes a double lookup. This costs
>>> CPU time and disk accesses to page in data structure indexes, metadata
>>> efficiency decreases.
>>>
>>> You can't avoid (2) as long as you're using a file system.
>>>
>>> Yes an LSM tree performs better on HDD than does a B-tree, which is a
>>> good argument for keeping the KV module pluggable.
>>>
>>>
>>> Allen Samuels
>>> Software Architect, Fellow, Systems and Software Solutions
>>>
>>> 2880 Junction Avenue, San Jose, CA 95134
>>> T: +1 408 801 7030| M: +1 408 780 6416
>>> allen.samuels@SanDisk.com
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ric Wheeler
>>> Sent: Tuesday, October 20, 2015 11:32 AM
>>> To: Sage Weil <sweil@redhat.com>; ceph-devel@vger.kernel.org
>>> Subject: Re: newstore direction
>>>
>>> On 10/19/2015 03:49 PM, Sage Weil wrote:
>>>> The current design is based on two simple ideas:
>>>>
>>>>    1) a key/value interface is better way to manage all of our internal
>>>> metadata (object metadata, attrs, layout, collection membership,
>>>> write-ahead logging, overlay data, etc.)
>>>>
>>>>    2) a file system is well suited for storage object data (as files).
>>>>
>>>> So far 1 is working out well, but I'm questioning the wisdom of #2.  A
>>>> few
>>>> things:
>>>>
>>>>    - We currently write the data to the file, fsync, then commit the kv
>>>> transaction.  That's at least 3 IOs: one for the data, one for the fs
>>>> journal, one for the kv txn to commit (at least once my rocksdb
>>>> changes land... the kv commit is currently 2-3).  So two people are
>>>> managing metadata, here: the fs managing the file metadata (with its
>>>> own
>>>> journal) and the kv backend (with its journal).
>>> If all of the fsync()'s fall into the same backing file system, are
>>> you sure that each fsync() takes the same time? Depending on the local
>>> FS implementation of course, but the order of issuing those fsync()'s
>>> can effectively make some of them no-ops.
>>>
>>>>    - On read we have to open files by name, which means traversing the
>>>> fs namespace.  Newstore tries to keep it as flat and simple as
>>>> possible, but at a minimum it is a couple btree lookups. We'd love to
>>>> use open by handle (which would reduce this to 1 btree traversal), but
>>>> running the daemon as ceph and not root makes that hard...
>>> This seems like a a pretty low hurdle to overcome.
>>>
>>>>    - ...and file systems insist on updating mtime on writes, even when
>>>> it is a overwrite with no allocation changes.  (We don't care about
>>>> mtime.) O_NOCMTIME patches exist but it is hard to get these past the
>>>> kernel brainfreeze.
>>> Are you using O_DIRECT? Seems like there should be some enterprisey
>>> database tricks that we can use here.
>>>
>>>>    - XFS is (probably) never going going to give us data checksums,
>>>> which we want desperately.
>>> What is the goal of having the file system do the checksums? How
>>> strong do they need to be and what size are the chunks?
>>>
>>> If you update this on each IO, this will certainly generate more IO
>>> (each write will possibly generate at least one other write to update
>>> that new checksum).
>>>
>>>> But what's the alternative?  My thought is to just bite the bullet and
>>>> consume a raw block device directly.  Write an allocator, hopefully
>>>> keep it pretty simple, and manage it in kv store along with all of our
>>>> other metadata.
>>> The big problem with consuming block devices directly is that you
>>> ultimately end up recreating most of the features that you had in the
>>> file system. Even enterprise databases like Oracle and DB2 have been
>>> migrating away from running on raw block devices in favor of file
>>> systems over time.  In effect, you are looking at making a simple on
>>> disk file system which is always easier to start than it is to get
>>> back to a stable, production ready state.
>>>
>>> I think that it might be quicker and more maintainable to spend some
>>> time working with the local file system people (XFS or other) to see
>>> if we can jointly address the concerns you have.
>>>> Wins:
>>>>
>>>>    - 2 IOs for most: one to write the data to unused space in the block
>>>> device, one to commit our transaction (vs 4+ before).  For overwrites,
>>>> we'd have one io to do our write-ahead log (kv journal), then do the
>>>> overwrite async (vs 4+ before).
>>>>
>>>>    - No concern about mtime getting in the way
>>>>
>>>>    - Faster reads (no fs lookup)
>>>>
>>>>    - Similarly sized metadata for most objects.  If we assume most
>>>> objects are not fragmented, then the metadata to store the block
>>>> offsets is about the same size as the metadata to store the filenames
>>>> we have now.
>>>>
>>>> Problems:
>>>>
>>>>    - We have to size the kv backend storage (probably still an XFS
>>>> partition) vs the block storage.  Maybe we do this anyway (put
>>>> metadata on
>>>> SSD!) so it won't matter.  But what happens when we are storing gobs
>>>> of rgw index data or cephfs metadata?  Suddenly we are pulling storage
>>>> out of a different pool and those aren't currently fungible.
>>>>
>>>>    - We have to write and maintain an allocator.  I'm still optimistic
>>>> this can be reasonbly simple, especially for the flash case (where
>>>> fragmentation isn't such an issue as long as our blocks are reasonbly
>>>> sized).  For disk we may beed to be moderately clever.
>>>>
>>>>    - We'll need a fsck to ensure our internal metadata is consistent.
>>>> The good news is it'll just need to validate what we have stored in
>>>> the kv store.
>>>>
>>>> Other thoughts:
>>>>
>>>>    - We might want to consider whether dm-thin or bcache or other block
>>>> layers might help us with elasticity of file vs block areas.
>>>>
>>>>    - Rocksdb can push colder data to a second directory, so we could
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
>>> I really hate the idea of making a new file system type (even if we
>>> call it a raw block store!).
>>>
>>> In addition to the technical hurdles, there are also production
>>> worries like how long will it take for distros to pick up formal
>>> support?  How do we test it properly?
>>>
>>> Regards,
>>>
>>> Ric
>>>
>>>

