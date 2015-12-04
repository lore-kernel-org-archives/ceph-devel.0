From: Ilja Slepnev <islepnev@gmail.com>
Subject: CephFS and single threaded RBD read performance
Date: Fri, 4 Dec 2015 20:16:29 +0000 (UTC)
Message-ID: <loom.20151204T201858-143@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39387 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754630AbbLDUUH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Dec 2015 15:20:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1a4wpp-0006yX-95
	for ceph-devel@vger.kernel.org; Fri, 04 Dec 2015 21:20:05 +0100
Received: from ip-176-192-220-123.bb.netbynet.ru ([ip-176-192-220-123.bb.netbynet.ru])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 04 Dec 2015 21:20:05 +0100
Received: from islepnev by ip-176-192-220-123.bb.netbynet.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 04 Dec 2015 21:20:05 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I see CephFS read performance a bit lower than RBD sequential read single
threaded performance.
Is it an expected behaviour?
Is file access with CephFS single threaded by design?

fio shows 70 MB/s seq read with 4M blocks, libaio, 1 thread, direct.
fio seq write 200 MB/s

# rados bench -t 1 -p test 60 write --no-cleanup
...
Bandwidth (MB/sec):     164.247
Stddev Bandwidth:       28.9474
Average Latency:        0.0243512
Stddev Latency:         0.0144412

# <drop_caches on OSD nodes>

# rados bench -t 1 -p test 60 seq
...
Bandwidth (MB/sec):    88.174
Average Latency:       0.0453621

On the other hand, 'rados bench -t 128 60 seq' shows about 1700 MB/s.

Is there anything to be tuned?

Hardware is 3 nodes x 24 HDDs with journals on SSDs, 2x10GbE
Triple replication.
cephfs clients: kernel and ceph-fuse on Fedora 23


