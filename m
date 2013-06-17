From: Karol Jurak <karol.jurak@gmail.com>
Subject: Re: Writing to RBD image while it's snapshot is being created causes I/O errors
Date: Mon, 17 Jun 2013 10:06:07 +0200
Message-ID: <2147065.fKZgxGNGTf@karol-esprimo-p5925>
References: <1881883.Fj0UjQGoA9@karol-esprimo-p5925> <alpine.DEB.2.00.1306140855170.26467@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:55535 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab3FQIF2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Jun 2013 04:05:28 -0400
Received: by mail-ee0-f48.google.com with SMTP id b47so1598357eek.35
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jun 2013 01:05:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306140855170.26467@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Friday 14 of June 2013 08:56:55 Sage Weil wrote:
> On Fri, 14 Jun 2013, Karol Jurak wrote:
> > I noticed that writing to RBD image using kernel driver while it's
> > snapshot is being created causes I/O errors and the filesystem
> > (reiserfs) eventually aborts and remounts itself in read-only mode:
> 
> This is definitely a bug; you should be able to create a snapshot at any
> time.  After a rollback, it should look (to the fs) like a crash or power
> cycle.
> 
> How easy is this to reproduce?  Does it happen every time?

I can reproduce it in the following way:

# rbd create -s 10240 test
# rbd map test
# mkfs -t reiserfs /dev/rbd/rbd/test
# mount /dev/rbd/rbd/test /mnt/test
# dd if=/dev/zero of=/mnt/test/a bs=1M count=1024

and in another shell while dd is running:

# rbd snap create test@snap1

After 2 or 3 seconds dmesg shows I/O errors:

[429532.259910] end_request: I/O error, dev rbd1, sector 1384448
[429532.272554] end_request: I/O error, dev rbd1, sector 872
[429532.275556] REISERFS abort (device rbd1): Journal write error in 
flush_commit_list

and dd fails:

dd: writing `/mnt/test/a': Cannot allocate memory
590+0 records in
589+0 records out
618225664 bytes (618 MB) copied, 15.8701 s, 39.0 MB/s

This happens every time I repeat the test.

-- 
Karol Jurak

