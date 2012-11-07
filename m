From: Stefan Priebe <s.priebe@profihost.ag>
Subject: rbd striping format v1 / v2 benchmark
Date: Wed, 07 Nov 2012 21:03:43 +0100
Message-ID: <509ABE9F.5050300@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42540 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab2KGUDs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 15:03:48 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i've done some benchmarks regarding striping / v1 / v2.

Results:
format 1:

   write: io=5739MB, bw=65278KB/s, iops=16319, runt= 90029msec
   read : io=5771MB, bw=65636KB/s, iops=16408, runt= 90030msec
   write: io=77224MB, bw=874044KB/s, iops=213, runt= 90473msec
   read : io=178840MB, bw=1983MB/s, iops=495, runt= 90168msec

format 2:

  --stripe-count 8 --stripe-unit 524288 -s 4194304

   write: io=5377MB, bw=61147KB/s, iops=15286, runt= 90041msec
   read : io=5332MB, bw=60617KB/s, iops=15154, runt= 90067msec
   write: io=75136MB, bw=849285KB/s, iops=207, runt= 90593msec
   read : io=160292MB, bw=1777MB/s, iops=444, runt= 90226msec

  --stripe-count 4 --stripe-unit 1048576 -s 4194304

   write: io=5301MB, bw=60281KB/s, iops=15070, runt= 90046msec
   read : io=5367MB, bw=61031KB/s, iops=15257, runt= 90057msec
   write: io=74448MB, bw=840293KB/s, iops=205, runt= 90724msec
   read : io=170616MB, bw=1891MB/s, iops=472, runt= 90227msec

So it seems right now that striping doesn't improve performance.

Greets,
Stefan
