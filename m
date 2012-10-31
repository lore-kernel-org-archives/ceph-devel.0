From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: slow fio random read benchmark, need help
Date: Wed, 31 Oct 2012 12:59:58 +0100 (CET)
Message-ID: <3c3b5485-acc1-4955-8890-32f6399d117f@mailpro>
References: <509083D0.1060003@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:58822 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422658Ab2JaMA3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 08:00:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id EEA291802796B
	for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 13:00:03 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oM6-l2EJbaCg for <ceph-devel@vger.kernel.org>;
	Wed, 31 Oct 2012 12:59:58 +0100 (CET)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id A6FE018024767
	for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 12:59:58 +0100 (CET)
In-Reply-To: <509083D0.1060003@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

I'm doing some tests with fio from a qemu 1.2 guest (virtio disk,cache=none), randread, with 4K block size on a small size of 1G (so it can be handle by the buffer cache on ceph cluster)


fio --filename=/dev/vdb -rw=randread --bs=4K --size=1000M --iodepth=40  --group_reporting --name=file1 --ioengine=libaio --direct=1


I can't get more than 5000 iops.


RBD cluster is :
---------------
3 nodes,with each node : 
-6 x osd 15k drives (xfs), journal on tmpfs, 1 mon 
-cpu: 2x 4 cores intel xeon E5420@2.5GHZ
rbd 0.53

ceph.conf

        journal dio = false
        filestore fiemap = false
        filestore flusher = false
        osd op threads = 24
        osd disk threads = 24
        filestore op threads = 6

kvm host is : 4 x 12 cores opteron
------------


During the bench:

on ceph nodes:
- cpu  is around 10% used
- iostat show no disks activity on osds. (so I think that the 1G file is handle in the linux buffer)


on kvm host:

-cpu is around 20% used


I really don't see where is the bottleneck....

Any Ideas, hints ?


Regards,

Alexandre
