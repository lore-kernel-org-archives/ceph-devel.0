From: =?Big5?B?s6++5cGo?= <doki74216@gmail.com>
Subject: The installation: When we start Ceph, the system stops running.
Date: Fri, 1 Apr 2011 14:53:55 +0800
Message-ID: <AANLkTinV864-rE6HERpmL-DBtx_eqp2DNRGqiZWatWtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42314 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab1DAGx4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2011 02:53:56 -0400
Received: by vws1 with SMTP id 1so2482336vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2011 23:53:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I set an environment of 20 servers which include 2 MDSs, 3 MONs and 15
OSDes.
My version is 0.25.2 and OS is Fedora 14.
There's a problem when I was installing the Ceph.
When I finished "mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs
-k keyring.bin" .
I start the whole Ceph system.
But here is the problem I met:
The system stops running and it shows the error messages as shown below:

=== mon.0 ===
Starting Ceph mon0 on Ceph1...already running
=== mon.1 ===
Starting Ceph mon1 on Ceph2...
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
starting mon.1 rank 1 at 192.168.200.202:6789/0 mon_data /data1/mon1
fsid f1eb5c4c-5127-5038-6ea9-0cf47e6536c2
accepter.bind unable to bind to 192.168.200.202:6789: Address already in use
failed: 'ssh Ceph2  /usr/local/bin/cmon -i 1 -c /tmp/ceph.conf.29519 '

I want to know why  the system cannot run smoothly.


--
Best Regards,
Stefanie Chen
