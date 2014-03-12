From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: O_DIRECT logic in CephFS, ceph-fuse / Performance
Date: Wed, 12 Mar 2014 21:27:11 +0100
Message-ID: <20140312202711.GA21325@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:50659 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaCLU1O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 16:27:14 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Kasper Dieter <Dieter.Kasper@ts.fujitsu.com>, mark.nelson@inktank.com, Sage Weil <sage@inktank.com>

The 'man 2 open' states 
---snip---
The behaviour of O_DIRECT with NFS will differ from local file systems.  (...)
The  NFS  protocol does not support passing the flag to the server, 
so O_DIRECT I/O will bypass the page cache only on the client; 
the server may still cache the I/O.
---snip---

Q1: How does CephFS and ceph-fuse handle the O_DIRECT flag ?	
	(similar to NFS Ceph is Network FS, too and has client/server)


Some Test cases with O_DIRECT & io_submit() on 4K (65536, 262144, 1048576, 4194304 is the different obj_size):

out.rand.fuse.ssd2-r2-1-1-1048576:  Max. throughput read         : 7.22768MB/s
out.rand.fuse.ssd2-r2-1-1-262144:  Max. throughput read         : 7.18318MB/s
out.rand.fuse.ssd2-r2-1-1-65536:  Max. throughput read         : 7.25543MB/s
out.sequ.fuse.ssd2-r2-1-1-1048576:  Max. throughput read         : 118.092MB/s
out.sequ.fuse.ssd2-r2-1-1-262144:  Max. throughput read         : 111.073MB/s
out.sequ.fuse.ssd2-r2-1-1-65536:  Max. throughput read         : 95.4332MB/s

out.rand.cephfs.ssd2-r2-1-1-1048576:  Max. throughput read         : 11.2144MB/s
out.rand.cephfs.ssd2-r2-1-1-262144:  Max. throughput read         : 11.0371MB/s
out.rand.cephfs.ssd2-r2-1-1-65536:  Max. throughput read         : 11.017MB/s
out.sequ.cephfs.ssd2-r2-1-1-1048576:  Max. throughput read         : 11.2299MB/s
out.sequ.cephfs.ssd2-r2-1-1-262144:  Max. throughput read         : 10.9488MB/s
out.sequ.cephfs.ssd2-r2-1-1-65536:  Max. throughput read         : 10.5669MB/s

out.rand.t3-ssd2-v2-1-1048576-20:  Max. throughput read         : 81.9598MB/s
out.rand.t3-ssd2-v2-1-262144-18:  Max. throughput read         : 140.45MB/s
out.rand.t3-ssd2-v2-1-4194304-22:  Max. throughput read         : 55.8478MB/s
out.rand.t3-ssd2-v2-1-65536-16:  Max. throughput read         : 158.441MB/s
out.sequ.t3-ssd2-v2-1-1048576-20:  Max. throughput read         : 74.3693MB/s
out.sequ.t3-ssd2-v2-1-262144-18:  Max. throughput read         : 140.444MB/s
out.sequ.t3-ssd2-v2-1-4194304-22:  Max. throughput read         : 42.7327MB/s
out.sequ.t3-ssd2-v2-1-65536-16:  Max. throughput read         : 165.434MB/s

t3 = XFS on rbd.ko

CephFS and ceph-fuse 	seems to use no caching at all on random-reads.
Ceph-fuse 		seems to use some caching on sequential-reads.
rbd.ko 			seems to use caching on all reads (because only XFS knows about O_DIRECT ;-))


Q2: How can the read-caching logic be enabled for ceph-fuse / CephFS ?

BTW I'm aware of the "O_DIRECT (...) designed  by  a  deranged monkey" text in the open-2-manpage ;-)


-Dieter
