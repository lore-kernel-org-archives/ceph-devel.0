From: Vishal Kanaujia <Vishal.Kanaujia@sandisk.com>
Subject: CephFS: slow log trimming
Date: Fri, 12 Aug 2016 10:26:01 +0000
Message-ID: <CY4PR02MB2487A848AE06BE15484F73EAE91F0@CY4PR02MB2487.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0086.outbound.protection.outlook.com ([104.47.38.86]:23734
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752611AbcHLO5G (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Aug 2016 10:57:06 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I am getting following errors while running a small file creation test:

2016-08-11 08:10:45.358127 7fc3d8c35700  0 log_channel(cluster) log [WRN] : slow request
 45.400021 seconds old, received at 2016-08-11 08:09:59.957972:
client_request(client.26308:5130031 create #10000423cc0/_11_11512_
2016-08-11 08:09:59.952255) currently submit entry: journal_and_reply

2016-08-11 08:10:45.358130 7fc3d8c35700  0 log_channel(cluster) log [WRN] : slow request
 45.718211 seconds old, received at 2016-08-11 08:09:59.639783:
 client_request(client.26308:5129520 create #10000422c54/_09_9037_
2016-08-11 08:09:59.636259) currently submit entry: journal_and_reply

Ceph health also shows a problem:

$ ceph -s
    cluster 40377bf4-75fd-4474-b4c1-4926f2b53638
     health HEALTH_WARN
            mds0: Behind on trimming (196/50) <----------------
     monmap e1: 1 mons at {iflab12=10.10.10.101:6789/0}
            election epoch 9, quorum 0 iflab12
      fsmap e1466: 1/1/1 up {0=iflab12=up:active}
     osdmap e925: 16 osds: 16 up, 16 in
            flags sortbitwise
      pgmap v165880: 2112 pgs, 3 pools, 8046 GB data, 2025 kobjects
            16093 GB used, 98178 GB / 111 TB avail
                2112 active+clean
  client io 1319 MB/s wr, 0 op/s rd, 1312 op/s wr


The ceph.conf has following MDS conf:
[mds]
mds_log_max_expiring = 200
mds_cache_size = 10000000
mds_log_max_segments = 50

Test:
Create ~260K files of size 4k, each. It uses 16 threads, and files/thread are 16384.

Kernel version:  4.4.0-28-generic
Ubuntu 14.04

$ ceph --version
ceph version 10.2.2-CEPH-1.4.0.9 (45107e21c568dd033c2f0a3107dec8f0b0e58374)

How could I better MDS performance?

Thanks,
Vishal
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
