From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: Object Write Latency
Date: Fri, 20 Sep 2013 12:27:29 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx30.cern.ch ([137.138.144.177]:7578 "EHLO CERNMX30.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754490Ab3ITM1b convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Sep 2013 08:27:31 -0400
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, 


we made some benchmarks about object read/write latencies on the CERN ceph installation.

The cluster has 44 nodes and ~1k disks, all on 10GE and the pool configuration has 3 copies. 
Client & Server is 0.67.

The latencies we observe (using tiny objects ... 5 bytes) on the idle pool:

write full object(sync) ~65-80ms
append to object ~60-75ms
set xattr object ~65-80ms
lock object ~65-80ms
stat object ~1ms

We seem to saturate the pools writing ~ 20k objects/s (= internally 60k/s).

Is there an easy explanation for 80 ms (quasi without payload) and a possible tuning to reduce that?
I measured (append few bytes +fsync) on such a disk around 33ms which explains probably part of the latency.

Then I tried with the async API to see if there is a difference in the measurement between wait_for_complete or wait_for_safe ... shouldn't wait_for_complete be much shorter, but I get always comparable results ...

Thanks, Andreas.