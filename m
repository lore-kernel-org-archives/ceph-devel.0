From: Mohamad Gebai <mgebai@suse.com>
Subject: RBD journaling benchmarks
Date: Fri, 7 Jul 2017 14:38:28 -0400
Message-ID: <aee550b1-bbf5-f08c-6ca1-ac676483614c@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:51908 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdGGSih (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 7 Jul 2017 14:38:37 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi,

We ran some benchmarks to assess the overhead caused by enabling
client-side RBD journaling in Luminous. The tests consists of:
- Create an image with journaling enabled  (--image-feature journaling)
- Run randread, randwrite and randrw workloads sequentially from a
single client using fio
- Collect IOPS

More info:
- Feature exclusive-lock is enabled with journaling (required)
- Queue depth of 128 for fio
- With 1 and 2 threads


Cluster 1
================

- 5 OSD nodes
- 6 OSDs per node
- 3 monitors
- Ceph version 12.0.3-1380-g6984d41b5d
(6984d41b5d142ce157216b6e757bcb547da2c7d2) luminous (dev)
- All SSD
- 10GbE NIC
- Bluestore + WAL


Results:

        Default        Journaling                Jour width 32      
Jobs    IOPS        IOPS        Slowdown        IOPS        Slowdown
RW
1        19521        9104       2.1x            16067        1.2x
2        30575        726       42.1x              488        62.6x
Read
1        22775        22946      0.9x            23601        0.9x
2        35955        1078      33.3x              446        80.2x
Write
1        18515        6054       3.0x             9765        1.9x
2        29586        1188      24.9x              534        55.4x

- "Default" is the baseline (with journaling disabled)
- "Journaling" is with journaling enabled
- "Jour width 32" is with a journal data width of 32 objects
(--journal-splay-width 32)
- The major slowdown for two jobs is due to locking
- With a journal width of 32, the 0.9x slowdown (which is actually a
speedup) is due to the read-only workload, which doesn't exercise the
journaling code. The 0.9x slowdown is due to other factors (eg. network
and other fluctuations), and should ideally be 1.
- The randwrite workload exercises the journaling code the most, and is
expected to have the highest slowdown, which is 1.9x in this case.


Cluster 2
================

- 3 OSD nodes
- 10 OSDs per node
- 1 monitor
- All HDD
- Filestore
- 10GbE NIC
- Ceph version 12.1.0-289-g117b171715
(117b1717154e1236b2d37c405a86a9444cf7871d) luminous (dev)


Results:

        Default        Journaling                 Jour width 32      
Jobs      IOPS        IOPS     Slowdown          IOPS       Slowdown
RW                                      
1        11869        3674        3.2x           4914          2.4x
2        13127         736       17.8x            432         30.4x
Read                                      
1        14500       14700        1.0x          14703          1.0x
2        16673        3893        4.3x            307         54.3x
Write                                      
1         8267        1925        4.3x           2591          3.2x
2         8283        1012        8.2x            417         19.9x

- The number of IOPS for the write workload is quite low, which is due
to HDDs and filestore

Mohamad


