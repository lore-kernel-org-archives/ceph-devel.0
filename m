From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: syncfs slower than without syncfs
Date: Wed, 07 Nov 2012 10:41:58 +0100
Message-ID: <509A2CE6.1010100@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:33567 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab2KGJmG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 04:42:06 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

syncfs is much slower than without syncfs to me.

If i compile latest ceph master with wip-rbd-read:

with syncfs:
rand 4K:
   write: io=1133MB, bw=12853KB/s, iops=3213, runt= 90277msec
   read : io=1239MB, bw=14046KB/s, iops=3511, runt= 90325msec
seq 4M:
   write: io=37560MB, bw=423874KB/s, iops=103, runt= 90738msec
   read : io=103852MB, bw=1151MB/s, iops=287, runt= 90237msec

without syncfs:
rand 4K:
   write: io=3733MB, bw=42459KB/s, iops=10614, runt= 90039msec
   read : io=6018MB, bw=68446KB/s, iops=17111, runt= 90038msec
seq 4M:
   write: io=51204MB, bw=577328KB/s, iops=140, runt= 90820msec
   read : io=150320MB, bw=1666MB/s, iops=416, runt= 90228msec

I thought syncfs should boost the performance.

Greets,
Stefan
