From: =?iso-8859-1?q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Subject: Monitors calling for elections all the time under load
Date: Mon, 8 Aug 2011 11:27:12 +0200
Message-ID: <201108081127.12810.szekelyi@niif.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:52927 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab1HHJ1S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Aug 2011 05:27:18 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by mail.ki.iif.hu (Postfix) with ESMTP id 32A0287667
	for <ceph-devel@vger.kernel.org>; Mon,  8 Aug 2011 11:27:17 +0200 (CEST)
Received: from mail.ki.iif.hu ([IPv6:::ffff:193.6.222.241])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id MQ-ZmTQbovcO for <ceph-devel@vger.kernel.org>;
	Mon,  8 Aug 2011 11:27:14 +0200 (CEST)
Received: from mranderson.localnet (dhcp112.ki.iif.hu [193.6.223.112])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ki.iif.hu (Postfix) with ESMTPSA id F416587632
	for <ceph-devel@vger.kernel.org>; Mon,  8 Aug 2011 11:27:13 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

when I put my cluster under a little stress (doing performance measurements 
with fio from one client), I see messages like this when watching the cluster 
with ceph -w:

2011-08-08 11:12:55.448460   log 2011-08-08 11:12:36.912896 mon1 
193.225.36.16:6789/0 10 : [INF] mon.iscsigw1 calling new monitor election
2011-08-08 11:12:55.448460   log 2011-08-08 11:12:37.026584 mon0 
193.224.103.241:6789/0 33 : [INF] mon.cc calling new monitor election
2011-08-08 11:12:55.448460   log 2011-08-08 11:12:39.385518 mon0 
193.224.103.241:6789/0 34 : [INF] mon.cc@0 won leader election with quorum 
0,1,2
2011-08-08 11:12:55.448460   log 2011-08-08 11:12:49.410812 mon0 
193.224.103.241:6789/0 35 : [INF] mon.cc calling new monitor election
2011-08-08 11:12:55.448460   log 2011-08-08 11:12:54.453865 mon0 
193.224.103.241:6789/0 36 : [INF] mon.cc@0 won leader election with quorum 0,1
2011-08-08 11:13:14.978668   log 2011-08-08 11:13:14.347342 mon0 
193.224.103.241:6789/0 37 : [INF] mon.cc@0 won leader election with quorum 
0,1,2
2011-08-08 11:13:15.981194   log 2011-08-08 11:12:39.338398 mon2 
193.225.36.17:6789/0 4 : [INF] mon.iscsigw2 calling new monitor election
2011-08-08 11:14:08.379715   log 2011-08-08 11:13:45.568598 mon0 
193.224.103.241:6789/0 38 : [INF] mon.cc calling new monitor election
2011-08-08 11:14:08.379715   log 2011-08-08 11:13:56.824059 mon1 
193.225.36.16:6789/0 11 : [INF] mon.iscsigw1 calling new monitor election
2011-08-08 11:14:08.379715   log 2011-08-08 11:14:00.628754 mon0 
193.224.103.241:6789/0 39 : [INF] mon.cc@0 won leader election with quorum 0,1
2011-08-08 11:14:13.143723   log 2011-08-08 11:14:12.565642 mon0 
193.224.103.241:6789/0 40 : [INF] mon.cc@0 won leader election with quorum 
0,1,2
2011-08-08 11:14:14.970961   log 2011-08-08 11:14:12.241023 mon2 
193.225.36.17:6789/0 5 : [INF] mon.iscsigw2 calling new monitor election
2011-08-08 11:14:47.635992   log 2011-08-08 11:14:41.011297 mon0 
193.224.103.241:6789/0 41 : [INF] mon.cc calling new monitor election
2011-08-08 11:14:47.635992   log 2011-08-08 11:14:45.042795 mon0 
193.224.103.241:6789/0 42 : [INF] mon.cc@0 won leader election with quorum 
0,1,2
2011-08-08 11:16:06.347312   log 2011-08-08 11:15:50.808908 mon2 
193.225.36.17:6789/0 6 : [INF] mon.iscsigw2 calling new monitor election
2011-08-08 11:16:06.347312   log 2011-08-08 11:15:50.853742 mon0 
193.224.103.241:6789/0 43 : [INF] mon.cc@0 won leader election with quorum 
0,1,2
2011-08-08 11:16:06.556283   log 2011-08-08 11:16:00.988151 mon0 
193.224.103.241:6789/0 44 : [INF] mon.cc calling new monitor election
2011-08-08 11:16:06.556283   log 2011-08-08 11:16:06.057077 mon0 
193.224.103.241:6789/0 45 : [INF] mon.cc@0 won leader election with quorum 0,2
2011-08-08 11:16:21.780257   log 2011-08-08 11:16:20.741675 mon0 
193.224.103.241:6789/0 46 : [INF] mon.cc@0 won leader election with quorum 
0,1,2
2011-08-08 11:16:22.557468   log 2011-08-08 11:15:48.389684 mon1 
193.225.36.16:6789/0 12 : [INF] mon.iscsigw1 calling new monitor election
2011-08-08 11:17:25.361408   log 2011-08-08 11:17:03.837950 mon0 
193.224.103.241:6789/0 51 : [INF] mon.cc calling new monitor election
2011-08-08 11:17:25.361408   log 2011-08-08 11:17:08.911451 mon0 
193.224.103.241:6789/0 52 : [INF] mon.cc@0 won leader election with quorum 0,1
2011-08-08 11:17:26.614787   log 2011-08-08 11:17:02.422839 mon1 
193.225.36.16:6789/0 13 : [INF] mon.iscsigw1 calling new monitor election
2011-08-08 11:17:26.614787   log 2011-08-08 11:17:19.054286 mon0 
193.224.103.241:6789/0 53 : [INF] mon.cc calling new monitor election
2011-08-08 11:17:26.614787   log 2011-08-08 11:17:24.117397 mon0 
193.224.103.241:6789/0 54 : [INF] mon.cc@0 won leader election with quorum 0,1
2011-08-08 11:17:38.109811   log 2011-08-08 11:17:37.555961 mon0 
193.224.103.241:6789/0 55 : [INF] mon.cc@0 won leader election with quorum 
0,1,2
2011-08-08 11:17:39.167801   log 2011-08-08 11:17:37.429817 mon2 
193.225.36.17:6789/0 7 : [INF] mon.iscsigw2 calling new monitor election
2011-08-08 11:18:57.777452   log 2011-08-08 11:18:31.142533 mon0 
193.224.103.241:6789/0 56 : [INF] mon.cc calling new monitor election
2011-08-08 11:18:57.777452   log 2011-08-08 11:18:48.324033 mon0 
193.224.103.241:6789/0 57 : [INF] mon.cc@0 won leader election with quorum 
0,1,2
2011-08-08 11:19:03.593849   log 2011-08-08 11:18:47.039445 mon2 
193.225.36.17:6789/0 8 : [INF] mon.iscsigw2 calling new monitor election
2011-08-08 11:19:05.889120   log 2011-08-08 11:19:02.751202 mon0 
193.224.103.241:6789/0 58 : [INF] mon.cc calling new monitor election
2011-08-08 11:19:05.889120   log 2011-08-08 11:19:03.104806 mon0 
193.224.103.241:6789/0 59 : [INF] mon.cc@0 won leader election with quorum 
0,1,2
2011-08-08 11:20:30.282238   log 2011-08-08 11:20:24.778291 mon0 
193.224.103.241:6789/0 60 : [INF] mon.cc calling new monitor election
2011-08-08 11:20:30.282238   log 2011-08-08 11:20:29.853993 mon0 
193.224.103.241:6789/0 61 : [INF] mon.cc@0 won leader election with quorum 0,2
2011-08-08 11:20:42.685147   log 2011-08-08 11:20:42.115629 mon0 
193.224.103.241:6789/0 62 : [INF] mon.cc@0 won leader election with quorum 
0,1,2

Is this normal that leader elections are so frequent and quorum changes all 
the time? This doesn't happen when the cluster is idle (ie. I'm not stressing 
it with fio).

My setup consists of three machines:
1. iscsigw1: OSD+MDS+MON
2. iscsigw2: OSD+MDS(standby-replay)+MON
3. cc: MON+client+control utility

Thanks,
-- 
cc

