From: "Tang, Haodong" <haodong.tang@intel.com>
Subject: parallel transaction submit
Date: Thu, 25 Aug 2016 07:45:51 +0000
Message-ID: <FC753468179C1C4EB15768F212C46AF266329D@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:45145 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758261AbcHYHpz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 25 Aug 2016 03:45:55 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sweil@redhat.com" <sweil@redhat.com>, "varada.kari@sandisk.com" <varada.kari@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage, Varada
 
Noticed you are making parallel transaction submits, we also worked out a prototype that looks similar, here is the link for the implementation: https://github.com/ceph/ceph/pull/10856
 
Background: 
From the perf counter we added, found it spent a lot time in kv_queue, that is, single thread transaction submits is not competent to handle the transaction from OSD.
 
Implementation: 
The key thought is to use multiple thread and assign each TransContext to one of the processing threads. In order to parallelize transaction submit, add different kv_locks and kv_conds for each thread.
 
Performance evaluation: 
Test ENV:
	4 x server, 4 x client, 16 x Intel S3700 as block device, and 4 x Intel P3600 as Rocksdb/WAL device. 
Performance: 
We also did several quick tests to verify the performance benefit, the results showed that parallel transaction submission will brought 10% performance improvement if using memdb, but little performance improvement with rocksdb. 
 
What's more, without parallel transaction submits, we also see performance boost if just changing to MemDB, but a little.
 
Test summary:
QD Scaling Test - 4k Random Write:
                                                                                  QD = 1      QD = 16     QD = 32      QD = 64      QD = 128
With rocksdb (IOPS)                                              682            173000       190000        203000       204000
With memdb (IOPS)                                              704            180000       194000        206000       218000
With rocksdb+multiple_kv_thread(IOPS)          /                164243        167037        180961      201752
With memdb+multiple_kv_thread(IOPS)          /                 176000       200000        221000      227000
 

It seems single thread of transaction submits will be a bottleneck if using MemDB.
