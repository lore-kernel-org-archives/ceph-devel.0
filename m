From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Some of my PGs stay at "active"
Date: Fri, 06 Jan 2012 11:19:25 +0100
Message-ID: <1854635.GsxyuXkRgh@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:35475 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758144Ab2AFKT2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Jan 2012 05:19:28 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id C5FF210C866
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jan 2012 11:19:26 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

ceph -s reports most of my PGs as "active+clean", but a small number will stay 
at just "active":

# ceph -s
2012-01-06 11:16:44.832625    pg v278953: 396 pgs: 8 active, 388 active+clean; 
70764 MB data, 157 GB used, 4994 GB / 5257 GB avail; 170/38388 degraded 
(0.443%)
2012-01-06 11:16:44.842568   mds e9: 1/1/1 up {0=alpha=up:active}
2012-01-06 11:16:44.842648   osd e243: 6 osds: 6 up, 6 in
2012-01-06 11:16:44.842799   log 2012-01-06 06:12:00.829148 osd.4 
10.3.1.35:6800/1490 343 : [INF] 0.4e scrub ok
2012-01-06 11:16:44.844179   mon e5: 3 mons at 
{ceph1=10.3.1.33:6789/0,ceph2=10.3.1.34:6789/0,ceph3=10.3.1.35:6789/0}

It's been like that for several days now. IIRC, the last thing I did with the 
cluster was to add some more OSDs. The last time this happened, the problem 
went away after restarting some of the OSDs.

What does this mean? Is that a bug?

Regards,
	Guido
