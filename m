From: Martin Mailand <martin@tuxadero.com>
Subject: Cluster sync doesn't finsh
Date: Thu, 17 Nov 2011 21:48:56 +0100
Message-ID: <4EC57338.9040004@tuxadero.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:48264 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab1KQUtF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Nov 2011 15:49:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@dreamhost.com>

Hi,
I am doing cluster failure test, where I shut down one OSD an wait for 
the cluster to sync. But the sync never finshed, at around 4-5% it 
stops. I stoped osd2.

2011-11-17 16:40:48.015370    pg v1333: 600 pgs: 1 active, 546 
active+clean, 53 active+clean+degraded; 113 GB data, 183 GB used, 1142 
GB / 1395 GB avail; 4200/82404 degraded (5.097%)
2011-11-17 16:40:53.109391    pg v1334: 600 pgs: 1 active, 546 
active+clean, 53 active+clean+degraded; 113 GB data, 183 GB used, 1142 
GB / 1395 GB avail; 4117/82404 degraded (4.996%)
2011-11-17 16:40:58.228525    pg v1335: 600 pgs: 1 active, 546 
active+clean, 53 active+clean+degraded; 113 GB data, 183 GB used, 1142 
GB / 1395 GB avail; 4037/82404 degraded (4.899%)
2011-11-17 16:41:03.223778    pg v1336: 600 pgs: 547 active+clean, 53 
active+clean+degraded; 113 GB data, 183 GB used, 1142 GB / 1395 GB 
avail; 4025/82404 degraded (4.884%)
2011-11-17 16:42:45.520740    pg v1337: 600 pgs: 547 active+clean, 53 
active+clean+degraded; 113 GB data, 184 GB used, 1141 GB / 1395 GB 
avail; 4025/82404 degraded (4.884%)

^C
root@m-brick-000:~# date -R
Thu, 17 Nov 2011 17:56:08 +0100
root@m-brick-000:~#

So for the last hour nothing happend, there is no load on the cluster.

The osd log, the ceph.conf, pg dump, osd dump could be found here.

http://85.214.49.87/ceph/

ceph version 0.38-181-g2e19550 
(commit:2e195500b5d3a8ab8512bcf2a219a6b7ff922c97)

-martin



