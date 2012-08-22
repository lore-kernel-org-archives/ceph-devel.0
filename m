From: Denis Fondras <ceph@ledeuns.net>
Subject: Re: Ceph performance improvement
Date: Wed, 22 Aug 2012 14:10:02 +0200
Message-ID: <5034CC1A.4010800@ledeuns.net>
References: <50349E62.90405@ledeuns.net> <5034B354.1040109@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:36056 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab2HVMKI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 08:10:08 -0400
Received: from [IPv6:2a01:728:103:1::21] (unknown [IPv6:2a01:728:103:1::21])
	by mail.ledeuns.net (Postfix) with ESMTPSA id 178A893281
	for <ceph-devel@vger.kernel.org>; Wed, 22 Aug 2012 14:10:05 +0200 (CEST)
In-Reply-To: <5034B354.1040109@cam.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Thank you for the answer David.

>
> That looks like you're writing to a filesystem on that disk, rather than
> the block device itself -- but lets say you've got 139MB/sec
> (1112Mbit/sec) of straight-line performance.
>
> Note: this is already faster than your network link can go -- you can,
> at best, only achieve 120MB/sec over your gigabit link.
>

Yes, I am aware of that, I can't get more than the GB link. However, I 
mentionned this to show that the disk should not be a bottleneck.

>
> Is this a dd to the RBD device directly, or is this a write to a file in
> a filesystem created on top of it?
>

The RBD device is mounted and formatted with BTRFS.

> dd will write blocks synchronously -- that is, it will write one block,
> wait for the write to complete, then write the next block, and so on.
> Because of the durability guarantees provided by ceph, this will result
> in dd doing a lot of waiting around while writes are being sent over the
> network and written out on your OSD.
>

Thank you for that information.

> (If you're using the default replication count of 2, probably twice? I'm
> not exactly sure what Ceph does when it only has one OSD to work on..?)
>

I don't know exactly how it behaves but "ceph -s" tells the cluster is 
degraded at 50%. Adding a second OSD allows Ceph to replicate.

>
> Just ignoring networking and storage for a moment, this also isn't a
> fair test: you're comparing the decompress-and-unpack time of a 139MB
> tarball on a 3GHz Pentium 4 with 1GB of RAM and a quad-core Xeon E5 that
> has 8GB.
>

That's a very good point ! Comparing figures on the same host tells a 
different story (/mnt is Ceph RBD device) :)

root@ceph-osd-1:/home# time tar xzf ../src.tar.gz && sync

real    0m43.668s
user    0m9.649s
sys     0m20.897s

root@ceph-osd-1:/mnt# time tar xzf ../src.tar.gz && sync

real    0m38.022s
user    0m9.101s
sys     0m11.265s

Thank you again,
Denis
