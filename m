From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: slow performance even when using SSDs
Date: Thu, 10 May 2012 14:09:13 +0200
Message-ID: <4FABAFE9.5060202@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35379 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492Ab2EJMQG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 08:16:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear List,

i'm doing a testsetup with ceph v0.46 and wanted to know how fast ceph is.

my testsetup:
3 servers with Intel Xeon X3440, 180GB SSD Intel 520 Series, 4GB RAM, 2x
1Gbit/s LAN each

All 3 are running as mon a-c and osd 0-2. Two of them are also running
as mds.2 and mds.3 (has 8GB RAM instead of 4GB).

All machines run ceph v0.46 and vanilla Linux Kernel v3.0.30 and all of
them use btrfs on the ssd which serves /srv/{osd,mon}.X. All of them use
eth0+eth1 as bond0 (mode 6).

This gives me:
rados -p rbd bench 60 write

...
Total time run:        61.465323
Total writes made:     776
Write size:            4194304
Bandwidth (MB/sec):    50.500

Average Latency:       1.2654
Max latency:           2.77124
Min latency:           0.170936

Shouldn't it be at least 100MB/s? (1Gbit/s / 8)

And rados -p rbd bench 60 write -b 4096 gives pretty bad results:
Total time run:        60.221130
Total writes made:     6401
Write size:            4096
Bandwidth (MB/sec):    0.415

Average Latency:       0.150525
Max latency:           1.12647
Min latency:           0.026599

All btrfs ssds are also mounted with noatime.

Thanks for your help!

Greets Stefan
