From: huang jun <hjwsm1989@gmail.com>
Subject: cluster_network goes slow during erasure code pool's stress testing
Date: Mon, 21 Dec 2015 23:21:36 +0800
Message-ID: <CABAwU-bDsMvf7A2aDR7s_8fRdS+0BS_rcKXPj0xnDn3PyJtEFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34995 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbLUPVh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Dec 2015 10:21:37 -0500
Received: by mail-lb0-f179.google.com with SMTP id bc4so17008465lbc.2
        for <ceph-devel@vger.kernel.org>; Mon, 21 Dec 2015 07:21:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com

hi,all
We meet a problem related to erasure pool with k:m=3:1 and stripe_unit=64k*3.
We have a cluster with 96 OSDs on 4 Hosts(hosts are: srv1, srv2, srv3,
srv4), each host have 24 OSDs,
each host have 12 core processors (Intel(R) Xeon(R) CPU E5-2620 v2 @
2.10GHz) and 48GB memory.
cluster configured with(both are 10GB ethernet):
cluster_network = 172.19.0.0/16
public_network = 192.168.0.0/16

Test suite below:
1) on each host, mount a Kernel client which bind to erasue pool
2) on each host, configure a smb server which use cephfs's mount point
3) every samba server have a windows smb client, which doing file
write\read\delete operations
4) every kernel client, we run a test shell script, write a 5GB file
recursivelly and create many dirs.

we run the test at 6:00 pm, but the second day morning, the cluster is broken,
1) there are 48 ODSs down, on srv1 and srv4
2) i check the down OSD's log, there are two kinds of log:
a) many osds down due to Filestore::op_thread timeout suicide
b) many osds down due to OSD::osd_op_tp timeout suicide

Because we have met this problem before, we use iperf to check the
network between srv1 and srv4;
the public_network is fine, the throughput can reach 9.20 Gbits/sec.
but the cluster_network performs bad from srv1 to srv4;
"iperf -c 172.19.10.4 " shows:
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-79.6 sec   384 KBytes  39.5 Kbits/sec

**but** iperf test from srv4 to srv1 is ok.

**note**:
a) at this time, there are no ceph-osd daemons on srv1 and srv4
b) after restart the network, iperf test on all sides shows ok

If the network is so slow, the osd_op_tp can be stucked in
submit_message if the reader is reciving data,
which can finally result the osd_op_tp thread suicide.

And we have another cluster with the same configuration,and run the
same tests, the **only** difference is
this cluster is testing replicated pool, not erasure pool.

why the network is so slow, bc the erasure pool use more cpu and mem
than replicated pool?

Any hints and tips are welcome.


-- 
thanks
huangjun
