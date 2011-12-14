From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Perf counters assert error
Date: Wed, 14 Dec 2011 15:53:46 -0800 (PST)
Message-ID: <138631751.2978.1323906826560.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:36505 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab1LNXxq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2011 18:53:46 -0500
Received: from mail-01.cse.ucsc.edu (mail-01.cse.ucsc.edu [128.114.48.32])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTP id A14CB7744004
	for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2011 15:53:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I got this assertion with the latest master.

Thanks,
Noah

nwatkins@piha:~$ hadoop fs -ls
11/12/14 15:51:57 INFO ceph.CephFileSystem: initialize:Ceph initialization arguments: CephFSInterface --log-file /tmp/client.log --debug_client 20 --debug_ms 20 -m 192.168.141.123:6789 --client-readahead-max-periods=1
common/perf_counters.cc: In function 'void PerfCountersCollection::remove(PerfCounters*)', in thread '7f82d022b700'
common/perf_counters.cc: 52: FAILED assert(i != m_loggers.end())
 ceph version 0.39-124-g1430c8a (commit:1430c8abaa37ee8ae4795907773b9b350fc5189a)
 1: (PerfCountersCollection::remove(PerfCounters*)+0x222) [0x7f8285e67062]
 2: (Client::shutdown()+0x215) [0x7f8285d1ca75]
 3: (ceph_mount()+0x11c) [0x7f8285d151ec]
 4: (Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1initializeClient()+0x39d) [0x7f8284cb57bd]
 5: [0x7f82cc29bc88]
 ceph version 0.39-124-g1430c8a (commit:1430c8abaa37ee8ae4795907773b9b350fc5189a)
 1: (PerfCountersCollection::remove(PerfCounters*)+0x222) [0x7f8285e67062]
 2: (Client::shutdown()+0x215) [0x7f8285d1ca75]
 3: (ceph_mount()+0x11c) [0x7f8285d151ec]
 4: (Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1initializeClient()+0x39d) [0x7f8284cb57bd]
 5: [0x7f82cc29bc88]
terminate called after throwing an instance of 'ceph::FailedAssertion'
Aborted
