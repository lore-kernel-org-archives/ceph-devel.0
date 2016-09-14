From: "Ivanov Aleksandr" <a.ivanov@rnet.ru>
Subject: Fw: Ceph Bug #15176
Date: Wed, 14 Sep 2016 15:51:32 +0300
Message-ID: <9f0e83a921cc31574d1d9dea04265d9f@rnet.ru>
References: <294e9d501d52d0e3eba75e01e1139089@rnet.ru>
        <2677afa77c617db5e637cf1bdeabfeff@rnet.ru>
        <613574fe84de95fcc8ecc40cb2e29926@rnet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.rnet.ru ([94.242.1.97]:56414 "EHLO mail.rnet.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755632AbcINMxz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 08:53:55 -0400
Received: from rnet.ru [2a00:1838:10:10:3c34:72d5:6995:2083] ([127.0.0.1])
        by icewarp.rnet.ru (IceWarp 11.4.1.5 DEB8 x64) with ASMTP id 201609141553438829
        for <ceph-devel@vger.kernel.org>; Wed, 14 Sep 2016 15:53:43 +0300
In-Reply-To: <613574fe84de95fcc8ecc40cb2e29926@rnet.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hello!

Issue :
The thing is that I ran into a bug - http://tracker.ceph.com/issues/15176
Fresh ceph(10.2.2 0.el7 ceph/x86_64) install on centos 7 (centos 7.2.1511) and ceph-deploy (1.5.36)
Can someone tell me please in which version it was/will be fixed because I see that it was resolved.
[node1-ceph][DEBUG ] The operation has completed successfully.
[node1-ceph][WARNIN] update_partition: Calling partprobe on created device /dev/sdd
[node1-ceph][WARNIN] command_check_call: Running command: /usr/bin/udevadm settle --timeout=600
[node1-ceph][WARNIN] command: Running command: /sbin/partprobe /dev/sdd
[node1-ceph][WARNIN] update_partition: partprobe /dev/sdd failed : Error: Error informing the kernel about modifications to partition /dev/sdd1 --   Device or resource busy.  This means Linux won't know about any changes you made to /dev/sdd1 until you reboot -- so you shouldn't mount it or use   it in any way before rebooting.
[node1-ceph][WARNIN] Error: Failed to add partition 1 (Device or resource busy)
[node1-ceph][WARNIN]  (ignored, waiting 60s)

Thank you!

Regards,
Aleksandr




