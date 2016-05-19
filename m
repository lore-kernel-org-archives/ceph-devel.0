From: Gaurav Bafna <bafnag@gmail.com>
Subject: No Ceph Recovery : Is it a bug ?
Date: Thu, 19 May 2016 12:30:23 +0530
Message-ID: <CAPg135a2YdLrMspcGdLbkx-fWvh30VJ3J4Y=hKSMAxDzosd+KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35437 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbcESHAY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 03:00:24 -0400
Received: by mail-oi0-f49.google.com with SMTP id x19so114465218oix.2
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 00:00:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Cephers ,

In our production cluster at Reliance Jio, when as osd goes corrupt
and crashes, Cluster remains unhealthy even after 4 hours.

    cluster fac04d85-db48-4564-b821-deebda046261
     health HEALTH_WARN
            658 pgs degraded
            658 pgs stuck degraded
            688 pgs stuck unclean
            658 pgs stuck undersized
            658 pgs undersized
            recovery 3064/1981308 objects degraded (0.155%)
            recovery 124/1981308 objects misplaced (0.006%)
     monmap e11: 11 mons at
{dssmon2=10.140.208.224:6789/0,dssmon3=10.140.208.225:6789/0,dssmon31=10.135.38.141:6789/0,dssmon32=10.135.38.142:6789/0,dssmon33=10.135.38.143:6789/0,dssmon34=10.135.38.144:6789/0,dssmon35=10.135.38.145:6789/0,dssmon4=10.140.208.226:6789/0,dssmon5=10.140.208.227:6789/0,dssmon6=10.140.208.228:6789/0,dssmonleader1=10.140.208.223:6789/0}
            election epoch 792, quorum 0,1,2,3,4,5,6,7,8,9,10
dssmon31,dssmon32,dssmon33,dssmon34,dssmon35,dssmonleader1,dssmon2,dssmon3,dssmon4,dssmon5,dssmon6
     osdmap e8778: 2774 osds: 2746 up, 2746 in; 30 remapped pgs
      pgmap v2740957: 75680 pgs, 11 pools, 386 GB data, 322 kobjects
            16288 GB used, 14299 TB / 14315 TB avail
            3064/1981308 objects degraded (0.155%)
            124/1981308 objects misplaced (0.006%)
               74992 active+clean
                 658 active+undersized+degraded
                  30 active+remapped
  client io 12394 B/s rd, 17 op/s

With 12 osd are down due to H/W failure, and having replication factor
6 , the cluster should have recovered , but it is not recovering.

When I kill an osd daemon, it recovers quickly. Any ideas why the PGs
are remaining undersized ?

What could be the difference between two scenarions :

1. OSD down due to H/W failure.
2. OSD daemon killed .

When I remove the 12 osds from the crushmap manually or do ceph osd
crush remove for those osds, the cluster recovers just fine.

I have mailed this on Ceph-Users but found no solution. Hence asking
on this ML .

Thanks
Gaurav
