From: Sage Weil <sweil@redhat.com>
Subject: rocksdb backend?
Date: Thu, 28 Apr 2016 19:33:29 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604281926520.25990@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53677 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbcD1XdX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Apr 2016 19:33:23 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86FFE81104
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 23:33:22 +0000 (UTC)
Received: from cpach ([10.3.112.6])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3SNXK1r019183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 19:33:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

Kyle was telling me that some of the MySQL folks were interested in doing 
an InnoDB backend that sat directly on librados. This is pretty 
interesting for DBaaS use-cases, but it reminded me that the MyRocks stuff 
that Facebook has been doing (a RocksDB backend ofr MySQL) has also been 
showing a lot of promise, and that someone had told me that some CMU 
students had written a librados backend for either leveldb or rocksdb.
Perhaps doing a RocksDB backend will work just as well (or better) for the 
mysql users *and* whatever other things are using rocksdb out there.

It turns out that writing a new backend is really not that hard.  I had to 
do one for BlueStore and it didn't take that long, and most of the work 
was building BlueFS, a toy file system that sat directly on a block 
device.  In the librados case, we can make a super-simple directory 
structure in omap and write files to individual rados objects.  Writes are 
always streaming and full object writes, nothing is read until it is 
written, and so forth.  I think it could be done with a few days' effort.

Also, as part of the bluefs work, I pushed an EnvMirror backend upstream 
that tells rocksdb to mirror to two backends and validate that the return 
identical results on all reads.  This was super useful for debugging the 
bluefs/bluestore backend, and would aid testing here, too.

Anyway, if anyone thinks this is a good or bad idea, or is interested in 
working on it, let us know!

sage


