From: Mike Dawson <mdawson@gammacode.com>
Subject: 0.55 init script Issue?
Date: Wed, 05 Dec 2012 11:15:16 -0500
Message-ID: <50BF7314.2020809@gammacode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 23-25-46-103-static.hfc.comcastbusiness.net ([23.25.46.103]:41578
	"EHLO mail1.gammacode.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2LEQXH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 11:23:07 -0500
Received: from localhost (mail1.gammacode.com [127.0.0.1])
	by mail1.gammacode.com (iRedMail) with ESMTP id E93453D802F
	for <ceph-devel@vger.kernel.org>; Wed,  5 Dec 2012 11:13:55 -0500 (EST)
Received: from mail1.gammacode.com ([127.0.0.1])
	by localhost (mail1.gammacode.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4SgvaXEK6y8h for <ceph-devel@vger.kernel.org>;
	Wed,  5 Dec 2012 11:13:55 -0500 (EST)
Received: from [10.10.1.176] (unknown [10.10.1.176])
	by mail1.gammacode.com (iRedMail) with ESMTPSA id 57B933D802E
	for <ceph-devel@vger.kernel.org>; Wed,  5 Dec 2012 11:13:55 -0500 (EST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All,

After upgrading from 0.54 to 0.55, the command "service ceph start" 
fails. But "/etc/init.d/ceph start" works. This is the case for start. 
stop, etc. Here is an example:

root@node2:~# /etc/init.d/ceph stop
=== mon.a ===
Stopping Ceph mon.a on node2...kill 2505...done
=== osd.0 ===
Stopping Ceph osd.0 on node2...kill 5042...done
=== osd.1 ===
Stopping Ceph osd.1 on node2...kill 5116...done
=== osd.17 ===
Stopping Ceph osd.17 on node2...kill 5275...done


root@node2:~# service ceph start
start: Job is already running: ceph


root@node2:~# /etc/init.d/ceph start
=== mon.a ===
Starting Ceph mon.a on node2...
starting mon.a rank 0 at 172.16.1.2:6789/0 mon_data 
/var/lib/ceph/mon/ceph-a fsid 4951e786-945e-47b6-b1b1-4043b6cc3b55
=== osd.0 ===
Starting Ceph osd.0 on node2...
starting osd.0 at :/0 osd_data /var/lib/ceph/osd/ceph-0 /dev/sda6
=== osd.1 ===
Starting Ceph osd.1 on node2...
starting osd.1 at :/0 osd_data /var/lib/ceph/osd/ceph-1 /dev/sda7
=== osd.17 ===
Starting Ceph osd.17 on node2...
starting osd.17 at :/0 osd_data /var/lib/ceph/osd/ceph-17 /dev/sda8


This is Ubuntu 12.10 with packages from debian-testing. One other user 
on IRC confirmed the same behavior. Is this a known issue?


Thanks,
Mike Dawson

