From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Subject: RE: newstore direction
Date: Thu, 22 Oct 2015 17:42:12 +0000
Message-ID: <99767EA2E27DD44DB4E9F9B9ACA458C056195B6E@SSIEXCH-MB3.ssi.samsung.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <56268886.7010806@redhat.com> <1445415736.1809.71.camel@redhat.com>
 <56277468.5000504@redhat.com>
 <alpine.DEB.2.00.1510220528140.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.ssi.samsung.com ([207.140.43.204]:42902 "EHLO
	mx1.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461AbbJVVtn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 17:49:43 -0400
In-Reply-To: <alpine.DEB.2.00.1510220528140.16833@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ric Wheeler <rwheeler@redhat.com>
Cc: Orit Wasserman <owasserm@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage and other fellow cephers,
  I truly share the pains with you  all about filesystem while I am working on  objectstore to improve the performance. As mentioned , there is nothing wrong with filesystem. Just the Ceph as one of  use case need more supports but not provided in near future by filesystem no matter what reasons.

   There are so many techniques  pop out which can help to improve performance of OSD.  User space driver(DPDK from Intel) is one of them. It not only gives you the storage allocator,  also gives you the thread scheduling support,  CPU affinity , NUMA friendly, polling  which  might fundamentally change the performance of objectstore.  It should not be hard to improve CPU utilization 3x~5x times, higher IOPS etc.
    I totally agreed that goal of filestore is to gives enough support for filesystem with either 1 ,1b, or 2 solutions. In my humble opinion , The new design goal of objectstore should focus on giving the best  performance for OSD with new techniques. These two goals are not going to conflict with each other.  They are just for different purposes to make Ceph not only more stable but also better.  

  Scylla mentioned by Orit is a good example .

  Thanks all.

  Regards,
  James   

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Thursday, October 22, 2015 5:50 AM
To: Ric Wheeler
Cc: Orit Wasserman; ceph-devel@vger.kernel.org
Subject: Re: newstore direction

On Wed, 21 Oct 2015, Ric Wheeler wrote:
> You will have to trust me on this as the Red Hat person who spoke to 
> pretty much all of our key customers about local file systems and 
> storage - customers all have migrated over to using normal file systems under Oracle/DB2.
> Typically, they use XFS or ext4.  I don't know of any non-standard 
> file systems and only have seen one account running on a raw block 
> store in 8 years
> :)
> 
> If you have a pre-allocated file and write using O_DIRECT, your IO 
> path is identical in terms of IO's sent to the device.
> 
> If we are causing additional IO's, then we really need to spend some 
> time talking to the local file system gurus about this in detail.  I 
> can help with that conversation.

If the file is truly preallocated (that is, prewritten with zeros... 
fallocate doesn't help here because the extents is marked unwritten), then
sure: there is very little change in the data path.

But at that point, what is the point?  This only works if you have one (or a few) huge files and the user space app already has all the complexity of a filesystem-like thing (with its own internal journal, allocators, garbage collection, etc.).  Do they just do this to ease administrative tasks like backup?


This is the fundamental tradeoff:

1) We have a file per object.  We fsync like crazy and the fact that there are two independent layers journaling and managing different types of consistency penalizes us.

1b) We get clever and start using obscure and/or custom ioctls in the file system to work around what it is used to: we swap extents to avoid write-ahead (see Christoph's patch), O_NOMTIME, unprivileged open-by-handle, batch fsync, O_ATOMIC, setext ioctl, etc.

2) We preallocate huge files and write a user-space object system that lives within it (pretending the file is a block device).  The file system rarely gets in the way (assuming the file is prewritten and we don't do anything stupid).  But it doesn't give us anything a block device wouldn't, and it doesn't save us any complexity in our code.

At the end of the day, 1 and 1b are always going to be slower than 2.  
And although 1b performs a bit better than 1, it has similar (user-space) complexity to 2.  On the other hand, if you step back and view teh entire stack (ceph-osd + XFS), 1 and 1b are *significantly* more complex than 2... and yet still slower.  Given we ultimately have to support both (both as an upstream and as a distro), that's not very attractive.

Also note that every time we have strayed off the reservation from the beaten path (1) to anything mildly exotic (1b) we have been bitten by obscure file systems bugs.  And that's assume we get everything we need upstream... which is probably a year's endeavour.

Don't get me wrong: I'm all for making changes to file systems to better support systems like Ceph.  Things like O_NOCMTIME and O_ATOMIC make a huge amount of sense of a ton of different systems.  But our situations is a bit different: we always own the entire device (and often the server), so there is no need to share with other users or apps (and when you do, you just use the existing FileStore backend).  And as you know performance is a huge pain point.  We are already handicapped by virtue of being distributed and strongly consistent; we can't afford to give away more to a storage layer that isn't providing us much (or the right) value.

And I'm tired of half measures.  I want the OSD to be as fast as we can make it given the architectural constraints (RADOS consistency and ordering semantics).  This is truly low-hanging fruit: it's modular, self-contained, pluggable, and this will be my third time around this particular block.

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
