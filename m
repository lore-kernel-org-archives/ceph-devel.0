From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: newstore direction
Date: Thu, 22 Oct 2015 22:06:03 -0400
Message-ID: <5629960B.7030108@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <56268886.7010806@redhat.com> <1445415736.1809.71.camel@redhat.com>
 <56277468.5000504@redhat.com>
 <alpine.DEB.2.00.1510220528140.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39978 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741AbbJWCGG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Oct 2015 22:06:06 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 88014228
	for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 02:06:06 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1510220528140.16833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Orit Wasserman <owasserm@redhat.com>, ceph-devel@vger.kernel.org

On 10/22/2015 08:50 AM, Sage Weil wrote:
> On Wed, 21 Oct 2015, Ric Wheeler wrote:
>> You will have to trust me on this as the Red Hat person who spoke to pretty
>> much all of our key customers about local file systems and storage - customers
>> all have migrated over to using normal file systems under Oracle/DB2.
>> Typically, they use XFS or ext4.  I don't know of any non-standard file
>> systems and only have seen one account running on a raw block store in 8 years
>> :)
>>
>> If you have a pre-allocated file and write using O_DIRECT, your IO path is
>> identical in terms of IO's sent to the device.
>>
>> If we are causing additional IO's, then we really need to spend some time
>> talking to the local file system gurus about this in detail.  I can help with
>> that conversation.
> If the file is truly preallocated (that is, prewritten with zeros...
> fallocate doesn't help here because the extents is marked unwritten), then
> sure: there is very little change in the data path.
>
> But at that point, what is the point?  This only works if you have one (or
> a few) huge files and the user space app already has all the complexity of
> a filesystem-like thing (with its own internal journal, allocators,
> garbage collection, etc.).  Do they just do this to ease administrative
> tasks like backup?

I think that the key here is that if we fsync() like crazy - regardless of 
writing to a file system or to some new, yet to be define block device primitive 
store - we are limited to the IOP's of that particular block device.

Ignoring exotic hardware configs for people who can ignore all SSD devices, we 
will have rotating, high capacity, slow spinning drives for *a long time* as the 
eventual tier.  Given that assumption, we need to do better then to be limited 
to synchronous IOP's for a slow drive.  When we have commodity pricing for 
things like persistent DRAM, then I agree that writing directly to that medium 
makes sense (but you can do that with DAX by effectively mapping that into the 
process address space).

Specifically, moving from a file system with some inefficiencies will only boost 
performance from say 20-30 IOP's to roughly 40-50 IOP's.

The way this has been handled traditionally for things like databases, etc is:

* batch up the transactions that need to be destaged
* issue an O_DIRECT async IO for all of the elements that need to be written 
(bypassed the page cache, direct to the backing store)
* wait for completion

We should probably add to that sequence an fsync() of the directory (or a file 
in the file system) to insure that any volatile write cache is invalidated, but 
there is *no* reason to fsync() each file.

I think that we need to look at why the write pattern is so heavily synchronous 
and single threaded if we are hoping to extract from any given storage tier its 
maximum performance.

Doing this can raise your file creations per second (or allocations per second) 
from a few dozen to a few hundred or more per second.

The complexity that writing a new block level allocation strategy that you save is:

* if you lay out a lot of small objects on the block store that can grow, we 
will quickly end up doing very complicated techniques that file systems solved a 
long time ago (pre-allocation, etc)
* multi-stream aware allocation if you have multiple processes writing to the 
same store
* tracking things like allocated but unwritten (can happen if some process 
"pokes" a hole in an object, common with things like virtual machine images)

One we end up handling all of that in new, untested code, I think that we end up 
with a lot of pain and only minimal gain in terms of performance.

ric

>
>
> This is the fundamental tradeoff:
>
> 1) We have a file per object.  We fsync like crazy and the fact that
> there are two independent layers journaling and managing different types
> of consistency penalizes us.
>
> 1b) We get clever and start using obscure and/or custom ioctls in the file
> system to work around what it is used to: we swap extents to avoid
> write-ahead (see Christoph's patch), O_NOMTIME, unprivileged
> open-by-handle, batch fsync, O_ATOMIC, setext ioctl, etc.
>
> 2) We preallocate huge files and write a user-space object system that
> lives within it (pretending the file is a block device).  The file system
> rarely gets in the way (assuming the file is prewritten and we don't do
> anything stupid).  But it doesn't give us anything a block device
> wouldn't, and it doesn't save us any complexity in our code.
>
> At the end of the day, 1 and 1b are always going to be slower than 2.
> And although 1b performs a bit better than 1, it has similar (user-space)
> complexity to 2.  On the other hand, if you step back and view teh
> entire stack (ceph-osd + XFS), 1 and 1b are *significantly* more complex
> than 2... and yet still slower.  Given we ultimately have to support both
> (both as an upstream and as a distro), that's not very attractive.
>
> Also note that every time we have strayed off the reservation from the
> beaten path (1) to anything mildly exotic (1b) we have been bitten by
> obscure file systems bugs.  And that's assume we get everything we need
> upstream... which is probably a year's endeavour.
>
> Don't get me wrong: I'm all for making changes to file systems to better
> support systems like Ceph.  Things like O_NOCMTIME and O_ATOMIC make a
> huge amount of sense of a ton of different systems.  But our situations is
> a bit different: we always own the entire device (and often the server),
> so there is no need to share with other users or apps (and when you do,
> you just use the existing FileStore backend).  And as you know performance
> is a huge pain point.  We are already handicapped by virtue of being
> distributed and strongly consistent; we can't afford to give away more to
> a storage layer that isn't providing us much (or the right) value.
>
> And I'm tired of half measures.  I want the OSD to be as fast as we can
> make it given the architectural constraints (RADOS consistency and
> ordering semantics).  This is truly low-hanging fruit: it's modular,
> self-contained, pluggable, and this will be my third time around this
> particular block.
>
> sage

