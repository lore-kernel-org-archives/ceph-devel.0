From: David Flynn <davidf@rd.bbc.co.uk>
Subject: [PATCH] Fix memory leak in async readahead (ceph-client/master)
Date: Wed, 28 Sep 2011 18:19:29 +0000
Message-ID: <20110928181928.GA18477@rd.bbc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailout0.thls.bbc.co.uk ([132.185.240.35]:48148 "EHLO
	mailout0.thls.bbc.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab1I1S1h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 14:27:37 -0400
Received: from gateh.kw.bbc.co.uk (gateh.kw.bbc.co.uk [132.185.132.17])
	by mailout0.thls.bbc.co.uk (8.14.4/8.14.3) with ESMTP id p8SIJUCM029098
	for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2011 19:19:30 +0100 (BST)
Received: from mailhub.rd.bbc.co.uk ([172.29.120.130])
	by gateh.kw.bbc.co.uk (8.13.6/8.13.6) with ESMTP id p8SIJTHm000043
	for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2011 19:19:29 +0100 (BST)
Received: from lxg1.rd.bbc.co.uk ([172.29.123.71]:39639)
	by mailhub.rd.bbc.co.uk with esmtp (Exim 4.72)
	(envelope-from <davidf@rd.bbc.co.uk>)
	id 1R8yjB-0003pQ-7L
	for ceph-devel@vger.kernel.org; Wed, 28 Sep 2011 19:19:29 +0100
Received: from davidf by lxg1.rd.bbc.co.uk with local (Exim 4.72)
	(envelope-from <davidf@rd.bbc.co.uk>)
	id 1R8yjB-0004oR-3M
	for ceph-devel@vger.kernel.org; Wed, 28 Sep 2011 19:19:29 +0100
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

While running a test to improve read performance on 1GbE and 10GbE
clients, a memory leak in the async readahead code was discovered.  A
trivial fix follows.

In case it is of interest, using three separately hosted OSDs (10GbE),
each configured to use six disks, i get the following read performance
(single threaded read, using find $DIR -type f -exec dd bs=8M if={}
of=/dev/null, file system has 1.5TiB of data in variously sized objects)

  v3.0.0  (1GbE client): 500Mb/s
  v3.0.0 (10GbE client): 1Gb/s

  v3.0.0 + ceph-client/master  (1GbE client): >900Mb/s
  v3.0.0 + ceph-client/master (10GbE client): ~2.5-3Gb/s

Of note:
 - doubling the read ahead window for the 10GbE client didn't buy
   any more performance (default = 8192*1024).
 - adding more threads to do reads on the 10GbE client only brought
   aggregate throughput up to <4Gbit/sec

 - using 8 1GbE clients, an aggregate throughput of ~6Gbit/s is achieved
 - increasing to 12GbE clients, aggregate increases only up to 6.5Gbit/sec
   ( I shall retry this with a different disk configuration for the OSDs )

The numbers above are fairly woolly, but hopefully illustrate current
throughput improvements from the ceph-client/master branch.

Kind regards,

..david

David Flynn (1):
  ceph: fix memory leak in async readpages

 fs/ceph/addr.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

-- 
1.7.4.1
