From: Sage Weil <sage@inktank.com>
Subject: Re: Writing to RBD image while it's snapshot is being created causes
 I/O errors
Date: Mon, 17 Jun 2013 21:25:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306172125170.27409@cobra.newdream.net>
References: <1881883.Fj0UjQGoA9@karol-esprimo-p5925> <alpine.DEB.2.00.1306140855170.26467@cobra.newdream.net> <2147065.fKZgxGNGTf@karol-esprimo-p5925>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34166 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab3FREZu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jun 2013 00:25:50 -0400
In-Reply-To: <2147065.fKZgxGNGTf@karol-esprimo-p5925>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karol Jurak <karol.jurak@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 17 Jun 2013, Karol Jurak wrote:
> On Friday 14 of June 2013 08:56:55 Sage Weil wrote:
> > On Fri, 14 Jun 2013, Karol Jurak wrote:
> > > I noticed that writing to RBD image using kernel driver while it's
> > > snapshot is being created causes I/O errors and the filesystem
> > > (reiserfs) eventually aborts and remounts itself in read-only mode:
> > 
> > This is definitely a bug; you should be able to create a snapshot at any
> > time.  After a rollback, it should look (to the fs) like a crash or power
> > cycle.
> > 
> > How easy is this to reproduce?  Does it happen every time?
> 
> I can reproduce it in the following way:
> 
> # rbd create -s 10240 test
> # rbd map test
> # mkfs -t reiserfs /dev/rbd/rbd/test
> # mount /dev/rbd/rbd/test /mnt/test
> # dd if=/dev/zero of=/mnt/test/a bs=1M count=1024
> 
> and in another shell while dd is running:
> 
> # rbd snap create test@snap1
> 
> After 2 or 3 seconds dmesg shows I/O errors:
> 
> [429532.259910] end_request: I/O error, dev rbd1, sector 1384448
> [429532.272554] end_request: I/O error, dev rbd1, sector 872
> [429532.275556] REISERFS abort (device rbd1): Journal write error in 
> flush_commit_list
> 
> and dd fails:
> 
> dd: writing `/mnt/test/a': Cannot allocate memory
> 590+0 records in
> 589+0 records out
> 618225664 bytes (618 MB) copied, 15.8701 s, 39.0 MB/s
> 
> This happens every time I repeat the test.

What kernel version are you using?  I'm not able to reproduce this with 
ext4 or reiserfs and many snapshots over several minutes of write 
workload.

sage
