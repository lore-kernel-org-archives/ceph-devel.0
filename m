From: Mark Nigh <mnigh@netelligent.com>
Subject: Assistance in Troubleshooting and Fixing MDS in Replay
Date: Thu, 23 Jun 2011 23:17:08 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C6788625320F@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.netelligent.com ([199.255.228.141]:9530 "EHLO
	NC-SVR-11.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751400Ab1FXERQ convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Jun 2011 00:17:16 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I would like some assistance in troubleshooting and fixes the issue of a MDS in replay.

root@ceph001:/var/log/ceph#  ceph -s
2011-06-23 23:07:43.945503    pg v2802: 396 pgs: 328 active+clean, 50 down+degraded+peering, 18 crashed+down+degraded+peering; 1155 MB data, 2575 MB used, 11115 GB / 11118 GB avail; 8/5958 degraded (0.134%)
2011-06-23 23:07:43.946151   mds e1458: 1/1/1 up {0=0=up:replay}
2011-06-23 23:07:43.946170   osd e808: 4 osds: 4 up, 4 in
2011-06-23 23:07:43.946205   log 2011-06-23 23:06:34.284905 osd2 10.6.1.81:6800/3611 1 : [WRN] map e803 wrongly marked me down or wrong addr
2011-06-23 23:07:43.946245   mon e1: 1 mons at {0=10.6.1.80:6789/0}
root@ceph001:/var/log/ceph#  ceph -v
ceph version 0.29.1-466-g86b41ff (commit:86b41ff96e0f6a9efb9553790efbb3c89a5ab080)

I wish I could tell you how this happen but I did open another post earlier in the week that was solved with consistent version of ceph throughout my 2 node cluster. I have one (1) mds and one (1) mon located on the 1st node. The four (4) osd are spread across the two (2) nodes evenly. The version are consistent.

Please let me know what I can provide to fix this problem. Thank you.


Mark Nigh



This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
