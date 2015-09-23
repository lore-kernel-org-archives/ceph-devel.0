From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: perf counters from a performance discrepancy
Date: Wed, 23 Sep 2015 16:33:37 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9192500992@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0069.outbound.protection.outlook.com ([65.55.169.69]:25632
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753302AbbIWQdn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 12:33:43 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp01.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2A3ECCAE616
	for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 12:33:38 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all --

Looking for guidance with perf counters...
I am trying to see whether the perf counters can tell me anything about the following discrepancy

I populate a number of 40k size objects in each of two pools, poolA and poolB.
Both pools cover osds on a single node, 5 osds total.

   * Config 1 (1p): 
      * use single rados bench client with 32 threads to do seq read of 20000 objects from poolA.

   * Config 2 (2p):
      * use two concurrent rados bench clients (running on same client node) with 16 threads each,
           one reading 10000 objects from poolA,
           one reading 10000 objects from poolB,

So in both configs, we have 32 threads total and the number of objects read is the same.
Note: in all cases, we drop the caches before doing the seq reads

The combined bandwidth (MB/sec) for the 2 clients in config 2 is about 1/3 of the bandwidth for
the single client in config 1.


I gathered perf counters before and after each run and looked at the difference of
the before and after counters for both the 1p and 2p cases.  Here are some things I noticed
that are different between the two runs.  Can someone take a look and let me know
whether any of these differences are significant.  In particular, for the
throttle-msgr_dispatch_throttler ones, since I don't know the detailed definitions of these fields.
Note: these are the numbers for one of the 5 osds, the other osds are similar...

* The field osd/loadavg is always about 3 times higher on the 2p c

some latency-related counters
------------------------------
osd/op_latency/sum 1p=6.24801117205061, 2p=579.722513078945
osd/op_process_latency/sum 1p=3.48506945394911, 2p=42.6278494549915
osd/op_r_latency/sum 1p=6.2480111719924, 2p=579.722513079003
osd/op_r_process_latency/sum 1p=3.48506945399276, 2p=42.6278494550061


and some throttle-msgr_dispatch_throttler related counters
----------------------------------------------------------
throttle-msgr_dispatch_throttler-client/get 1p=1337, 2p=1339, diff=2
throttle-msgr_dispatch_throttler-client/get_sum 1p=222877, 2p=223088, diff=211
throttle-msgr_dispatch_throttler-client/put 1p=1337, 2p=1339, diff=2
throttle-msgr_dispatch_throttler-client/put_sum 1p=222877, 2p=223088, diff=211
throttle-msgr_dispatch_throttler-hb_back_server/get 1p=58, 2p=134, diff=76
throttle-msgr_dispatch_throttler-hb_back_server/get_sum 1p=2726, 2p=6298, diff=3572
throttle-msgr_dispatch_throttler-hb_back_server/put 1p=58, 2p=134, diff=76
throttle-msgr_dispatch_throttler-hb_back_server/put_sum 1p=2726, 2p=6298, diff=3572
throttle-msgr_dispatch_throttler-hb_front_server/get 1p=58, 2p=134, diff=76
throttle-msgr_dispatch_throttler-hb_front_server/get_sum 1p=2726, 2p=6298, diff=3572
throttle-msgr_dispatch_throttler-hb_front_server/put 1p=58, 2p=134, diff=76
throttle-msgr_dispatch_throttler-hb_front_server/put_sum 1p=2726, 2p=6298, diff=3572
throttle-msgr_dispatch_throttler-hbclient/get 1p=168, 2p=252, diff=84
throttle-msgr_dispatch_throttler-hbclient/get_sum 1p=7896, 2p=11844, diff=3948
throttle-msgr_dispatch_throttler-hbclient/put 1p=168, 2p=252, diff=84
throttle-msgr_dispatch_throttler-hbclient/put_sum 1p=7896, 2p=11844, diff=3948

-- Tom Deneau, AMD

