From: norbi <norbi@rocknob.de>
Subject: Problems with active+remapped PGs in Ceph 0.55
Date: Wed, 12 Dec 2012 08:48:27 +0100
Message-ID: <50C836CB.6000502@rocknob.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:34168 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab2LLHxp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 02:53:45 -0500
Received: from [80.67.16.214] (helo=[192.168.10.165])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <norbi@rocknob.de>)
	id 1Tih3M-0000if-2X
	for ceph-devel@vger.kernel.org; Wed, 12 Dec 2012 08:48:28 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph-List,

i have set up a Ceph-Cluster with 3 OSDs, 3 Mons, 2 MDS over three server.
Server 1 has 2 ODSs (osd0,osd2) and one MON/MDS and Server 2 has only 
osd2 and one MON + MDS.
Server 3 has only the third MON-Service.

All Servers are running Ceph 0.55 and Kernel 3.6.9 with Centos 6 64bit.

ceph osd shows me in first state

ceph osd tree

# id    weight  type name       up/down reweight
-1      3       pool default
-3      3               rack unknownrack
-4      1                       host unknownhost
1       1                               osd.1   up      1
2       1                               osd.2   up      1
0       1                               osd.0   up      1

ceph health is ok !

now i have edit the crush map to the following

# id    weight  type name       up/down reweight
-1      3       pool default
-3      3               rack unknownrack
-4      1                       host testblade01
1       1                               osd.1   up      1
-2      1                       host unknownhost
2       1                               osd.2   up      1
0       1                               osd.0   up      1


now ceph is remaping some existing PGs and there are my problems began...

ceph is stopping remapping some PGs and the status is "current state 
active+remapped" but nothing happens... after about 14h the PGs are in 
the same state and ceph health is in status HEALTH_WARN. there are no 
lost or unfound object, i can read all files in ceph without problems 
and i can write into ceph storage.

how can i find the problem or force remapping of the PGs ? i have looked 
into the source code, but i dont find a comman like "ceph pg force_remap 
1.a4". "ceph pg PGNUMBER" shows me that there are no unfound objects.

any help ?
