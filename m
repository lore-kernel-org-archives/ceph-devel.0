From: Chang <oykimchi@gmail.com>
Subject: Ceph support for Direct I/O
Date: Thu, 17 May 2012 21:23:12 +0000 (UTC)
Message-ID: <loom.20120517T232245-455@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36569 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759935Ab2EQVZH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 May 2012 17:25:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SV8Bz-0003YY-L7
	for ceph-devel@vger.kernel.org; Thu, 17 May 2012 23:25:03 +0200
Received: from 135.245.8.6 ([135.245.8.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 23:25:03 +0200
Received: from oykimchi by 135.245.8.6 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 23:25:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I was trying to test write performance of Ceph, using direct I/O.

$ dd if=/dev/zero of=/mnt/ceph/my.dat bs=1M count=1 oflag=direct

But dd is just stuck without doing any write.

Without oflag, write is done fine.

In the above example, I used Ceph kernel module 0.20, built on kernel 2.6.32.

I also tried Ceph fuse client to mount.
In this case, the above dd command gives me:

"dd: opening `/mnt/ceph/my.dat': Invalid argument"

Is it because Ceph does not support direct I/O?

I'm using ceph 0.46, installed using Debian release package.
There are three OSDs, 1 Mon and 1 MDS in the cluster.

Any help or clarification is appreciated.

Chang


