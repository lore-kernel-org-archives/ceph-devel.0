From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: CEPH IOPS Baseline Measurements with MemStore
Date: Thu, 19 Jun 2014 09:05:18 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7433A2@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:35281 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755362AbaFSJFX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jun 2014 05:05:23 -0400
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, 

I made some benchmarks/testing using the firefly branch and GCC 4.9. Hardware is 2 CPUs with  6-core  Intel(R) Xeon(R) CPU E5-2630L 0 @ 2.00GHz with Hyperthreading and 256 GB of memory (kernel 2.6.32-431.17.1.el6.x86_64).

In my tests I run two OSD configurations on a single box:

[A] 4 OSDs running with MemStore
[B] 1 OSD running with MemStore

I use a pool with 'size=1' and read and read/write 1-byte objects all via localhost. 

The local RTT reported by ping is 15 micro seconds, the RTT measured with ZMQ is 100 micro seconds (10 kHZ synchronous 1-byte messages).
RTT measured with another file IO daemon (XRootD) we are using at CERN (31-byte messages) is 9.9 kHZ.

-------------------------------------------------------------------------------------------------------------------------
4 OSDs
-------------------------------------------------------------------------------------------------------------------------

{1} [A]
*******
I measure IOPS with 1 byte objects for separate write and read operations disabling logging of any subsystem:

Type : IOPS[kHz] : Latency [ms] : ConcurIO [#]
===================================
Write : 01.7 : 0.50 : 1
Write:  11.2 : 0.88 : 10
Write:  11.8 : 1.69 : 10 x 2 [ 2 rados bench processes ] 
Write:  11.2 : 3.57 : 10 x 4 [ 4 rados bench processes ] 
Read : 02.6 : 0.33 : 1
Read : 22.4 : 0.43 : 10
Read : 40.0 : 0.97 : 20 x 2 [ 2 rados bench processes ] 
Read : 46.0 : 0.88 : 10 x 4 [ 4 rados bench processes ]
Read : 40.0 : 1.60 : 20 x 4 [ 4 rados bench processes ] 

{2} [A]
*******
I measure IOPS with the CEPH firefly branch as is (default logging) :

Type : IOPS[kHz] : Latency [ms] : ConcurIO [#]
===================================
Write : 01.2 : 0.78 : 1
Write : 09.1 : 1.00 : 10
Read : 01.8 : 0.50 : 1
Read : 14.0 : 1.00 : 10
Read : 18:0 : 2.00 : 20 x 2 [ 2 rados bench processes ]
Read : 18.0 : 2.20 : 10 x 4 [ 4 rados bench processes ]

-------------------------------------------------------------------------------------------------------------------------
1 OSD
-------------------------------------------------------------------------------------------------------------------------

{1} [B] (subsys logging disabled, 1 OSD)
*******
Write : 02.0 : 0.46 : 1
Write : 10.0 : 0.95 : 10
Write : 11.1 : 1.74 : 20
Write : 12.0 : 1.80 : 10 x 2 [ 2 rados bench processes ]
Write : 10.8 : 3.60 : 10 x 4 [ 4 rados bench processes ]
Read : 03.6 : 0.27 : 1
Read : 16.9 : 0.50 : 10
Read : 28.0 : 0.70 : 10 x 2 [ 2 rados bench processes ]
Read : 29.6 : 1.37 : 20 x 2 [ 2 rados bench processes ] 
Read : 27.2 : 1.50 : 10 x 4 [ 4 rados bench processes ]

{2} [B] (defaultlogging, 1 OSD)
*******
Write : 01.4 : 0.68 : 1
Write : 04.0 : 2.35 : 10 
Write : 04.0 : 4.69 : 10 x 2 [ 2 rados bench processes ]

I also played with OSD thread number (no change) and used an in memory filesystem + journaling (filestore backend). Here the{1} [A] result is 1.4 kHz write for 1 IOPS in flight and the peak write performance putting many IOPS in flight and several rados bench processes is 2.3 kHz!


Some summarizing remarks:

1) Default Logging has an important impact on the IOPS & latency [0.1-0.2ms]
2) OSD implementation without journaling does not scale linear with concurrent IOs - need several OSDs to scale IOPS - lock contention/threading model?
3) a writing OSD never fills more than 4 cores
4) a reading OSD never fills more than 5 cores
5) running 'rados bench' on a remote machine gives similar or slghltly worse results (upto -20%)
6) CEPH delivering 20k read IOPS uses 4 cores on server side, while identical operations with higher payload (XRootD) uses one core for 3x higher performance (60k IOPS)
7) I can scale the other IO daemon (XRootD) to use 10 cores and to deliver 300.000 IOPS on the same box.

Looking forward to SSDs and volatile memory backend stores I see some improvements to be done in the OSD/communication layer.

If you have some ideas for parameters to tune or see some mistakes in this measurement - let me know!

Cheers Andreas.























