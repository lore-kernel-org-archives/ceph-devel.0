From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Rados faster than KVM block device?
Date: Thu, 28 Jun 2012 15:10:22 +0200
Message-ID: <4FEC57BE.9060703@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:40342 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030Ab2F1NK2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 09:10:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

my cluster is now pretty stable i'm just wondering about the sequential 
write values.

With rados bench command and 16 threads i get totally different values 
than with KVM and rbd block device.

rados -p kvmpool bench 60 write -t 16:
pool size 2: Bandwidth (MB/sec):     1137.294
pool size 3: Bandwidth (MB/sec):     846.983

Inside KVM with fio:

fio --filename=$DISK --direct=1 --rw=write --bs=4M --size=200G 
--numjobs=16 --runtime=60 --group_reporting --name=file1:

pool size 2:
   write: io=32984MB, bw=562046KB/s, iops=137 , runt= 60094msec
pool size 3:
   write: io=29124MB, bw=496024KB/s, iops=121 , runt= 60124msec

Even when i change the pool size to 3 i get with fio 520MB/s.

Any ideas? Is this expected?

Greets
Stefan
