From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: RBD speed vs threads
Date: Fri, 15 Jun 2012 07:56:58 +0200
Message-ID: <4FDACEAA.8080306@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35670 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab2FOF5G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 01:57:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i still don't understand why the speed of the rados bench depends so 
heavily on the threads.

Right now i get around 100MB/s per thread. So 1 thread is 100MB/s, 4 
Threads 400MB/s and 16 threads results an about 1100MB/s.

So 1100MB/s is great but i still don't get why 1 thread gets "only" 100MB/s.

Total time run:         30.037374
Total writes made:      8326
Write size:             4194304
Bandwidth (MB/sec):     1108.752

Stddev Bandwidth:       47.5612
Max bandwidth (MB/sec): 1152
Min bandwidth (MB/sec): 948
Average Latency:        0.0577107
Stddev Latency:         0.020784
Max latency:            0.382413
Min latency:            0.026057

Stefan
