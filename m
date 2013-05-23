From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Subject: Ceph newbie questions
Date: Thu, 23 May 2013 17:14:43 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA5604502FD7F5@SMBXKO5.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko3.compugroup.com ([193.47.161.188]:54600 "EHLO
	SMXKO3.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965Ab3EWRWX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 13:22:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by SMXKO3.compugroup.com (Postfix) with ESMTP id EAE90602C
	for <ceph-devel@vger.kernel.org>; Thu, 23 May 2013 19:14:45 +0200 (CEST)
Received: from SMXKO3.compugroup.com ([127.0.0.1])
	by localhost (SMXKO3.compugroup.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gu0F1lfMLa3 for <ceph-devel@vger.kernel.org>;
	Thu, 23 May 2013 19:14:45 +0200 (CEST)
Received: from SCASKO4.cgm.ag (unknown [10.0.0.84])
	by SMXKO3.compugroup.com (Postfix) with ESMTPS id AB2376026
	for <ceph-devel@vger.kernel.org>; Thu, 23 May 2013 19:14:45 +0200 (CEST)
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello, 

Problem1:

Ceph health says HEALTH_WARN clock skew detected on mon.b, mon.c

But:

root@hcmonko1:~# date && ssh hcmonko3 date && ssh hcmonko2 date
Thu May 23 18:19:38 CEST 2013
Thu May 23 18:19:38 CEST 2013
Thu May 23 18:19:38 CEST 2013

Seems to be ok, ntp configured. Restarted all the servers, still the same.


Problem 2:

Service ceph -a works seriell, not parallel.
Situation: every osd and mon is offline via service ceph -a stop. When I want to bring them online with "service ceph -a start", it begins with mon a, then mon b, then osd0, osd1 etc.
But the procedure hangs at the point ceph-create keys for the first mon in the row.

root@hcosdko1:~# service ceph -a start
=== mon.a ===
Starting Ceph mon.a on hcmonko1...
Starting ceph-create-keys on hcmonko1...

I get to know via your irc-channel that ceph-create-keys needs the mon quorum to proceed. I think the ceph -a start script is designed to not make it serial, rather it has to do it parallel for all mons+osd.
But in my scenario it hangs at this point: ceph is started on mon1, hangs at the keys because there is no quorum => ceph will not start on mon2,mon3, osd0 and so on. (when I type "service ceph -a start on mon1, it will begin on the host itself, create the keys, proceed with starting ceph on mon2 and can create the keys there, because there is a quorum because ceph is started already on mon1).


Question1
For testing we have only 1 osd node at this moment, there will follow 2 other nodes, perhaps we will add certain osd hdds in one server/node.
when i want to add a node or only an osd.. is it right, that i change the ceph.conf, copy it via ssh to each node(mon,osd,..) and then make ceph -a start to reload the new config, so the new servers,osds,mons etc are activated?
When I wants to add an osd (hdd), I have to type makecephfs --mkfs.. will it destroy the data on the already existing osd-hdds?

Question2
when i have to restart 1 server, i think the ceph mechanism will start replicating the data to the other hosts directly. is it possible to define a server/osd for maintenance mode, so rados does not begin to start replicating the data, only because 1 osd is restarting?


Thank you very much!

Regards
Philipp



