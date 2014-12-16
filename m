From: Sage Weil <sweil@redhat.com>
Subject: tcp tuning
Date: Tue, 16 Dec 2014 13:36:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412161334200.20966@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56439 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbaLPVgL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Dec 2014 16:36:11 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBGLaAu5005196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 16 Dec 2014 16:36:11 -0500
Received: from redhat.com ([10.3.112.11])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sBGLaAmI022609
	for <ceph-devel@vger.kernel.org>; Tue, 16 Dec 2014 16:36:10 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I stumbled across this comment in the bug tracker from Jake Young:

	http://tracker.ceph.com/issues/9844

It's unrelated to the original bug, but wanted to post it here for comment 
as a quick glance at this makes me think some of these tunings would be 
good for users in general.

sage

"My cluster originally had 4 nodes, with 7 osds on each node, 28 osds 
total, running Gian. I did not have any problems at this time.

My problems started after adding two new nodes, so I had 6 nodes and 42 
total osds. It would run fine on low load, but when the request load 
increased, osds started to fall over.

I was able to set the debug_ms to 10 and capture the logs from a failed 
OSD. There were a few different reasons the osds were going down. This 
example shows it terminating normally for an unspecified reason a minute 
after it notices it is marked down in the map.

Osd 25 actually marks this osd (osd 35) down. For some reason many osds 
cannot communicate with each other.

[...]

The recurring theme here is that there is a communication issue between 
the osds.

I looked carefully at my network hardware configuration (UCS C240s with 
40Gbps Cisco VICs connected to a pair of Nexus 5672 using A-FEX Port 
Profile configuration) and couldn't find any dropped packets or errors.

I ran "ss -s" for the first time on my osds and was a bit suprised to see 
how many open TCP connections they all have.

ceph@osd6:/var/log/ceph$ ss -s
Total: 1492 (kernel 0)
TCP: 1411 (estab 1334, closed 40, orphaned 0, synrecv 0, timewait 0/0), 
ports 0

Transport Total IP IPv6
0 - -
RAW 0 0 0
UDP 10 4 6
TCP 1371 1369 2
INET 1381 1373 8
FRAG 0 0 0
While researching if additional kernel tuning would be required to handle 
so many connections, I eventually realized that I forgot to copy my 
customized /etc/sysctl.conf file on the two new nodes. I'm not sure if the 
large amount of TCP connections is part of the performance enhancements 
between Giant and Firefly, or if Firefly uses a similar number of 
connections.

ceph@osd6:/var/log/ceph$ cat /etc/sysctl.conf
# /etc/sysctl.conf - Configuration file for setting system variables
See /etc/sysctl.d/ for additional system variables
See sysctl.conf (5) for information. #

Increase Linux autotuning TCP buffer limits
Set max to 16MB for 1GE and 32M (33554432) or 54M (56623104) for 10GE

Don't set tcp_mem itself! Let the kernel scale it based on RAM.
net.core.rmem_max = 56623104
net.core.wmem_max = 56623104
net.core.rmem_default = 56623104
net.core.wmem_default = 56623104
net.core.optmem_max = 40960
net.ipv4.tcp_rmem = 4096 87380 56623104
net.ipv4.tcp_wmem = 4096 65536 56623104

Make room for more TIME_WAIT sockets due to more clients,
and allow them to be reused if we run out of sockets

Also increase the max packet backlog
net.core.somaxconn = 1024
net.core.netdev_max_backlog = 50000
net.ipv4.tcp_max_syn_backlog = 30000
net.ipv4.tcp_max_tw_buckets = 2000000
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 10

Disable TCP slow start on idle connections
net.ipv4.tcp_slow_start_after_idle = 0

If your servers talk UDP, also up these limits
net.ipv4.udp_rmem_min = 8192
net.ipv4.udp_wmem_min = 8192

Disable source routing and redirects
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.accept_source_route = 0

I added the net.core.somaxconn after this experience, since the default is 
128. This represents the allowed socket backlog in the kernel; which 
should help when I reboot an osd node and 1300 connections need to be made 
quickly.

I found that I needed to restart my osds after applying the kernel tuning 
above for my cluster to stabilize.

My system is now stable again and performs very well.

"
