From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: pgs stuck undersized and degraded
Date: Mon, 29 Jun 2015 12:25:29 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669AE3EF@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0117.outbound.protection.outlook.com ([157.56.111.117]:13312
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752500AbbF2MZg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 08:25:36 -0400
Received: from satlvexedge01.amd.com (satlvexedge01.amd.com [10.177.96.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by atltwp02.amd.com (Axway MailGate 5.3.1) with ESMTPS id 2A781D16028
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 08:25:29 -0400 (EDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On a very small (3 node) cluster, I have one pool with a replication size of 3 that is showing some stuck PGs.
This pool has 64 pgs and the other pgs in the pool seem fine, mapped to 3 osds each.
And all the pgs in other pools are also fine.
Why would these pgs be stuck with 2 ?
The osd crush chooseleaf type is 1 for host and the osd tree is shown below.

-- Tom Deneau

pg_stat	state	up	up_primary	acting	acting_primary
--------------------------------------------------------------
13.34	active+undersized+degraded	[0,7]	0	[0,7]	0
13.3a	active+undersized+degraded	[2,8]	2	[2,8]	2
13.a	active+undersized+degraded	[8,2]	8	[8,2]	8
13.e	active+undersized+degraded	[0,8]	0	[0,8]	0
13.3c	active+undersized+degraded	[2,5]	2	[2,5]	2
13.22	active+undersized+degraded	[8,2]	8	[8,2]	8
13.1b	active+undersized+degraded	[2,8]	2	[2,8]	2
13.21	active+undersized+degraded	[8,0]	8	[8,0]	8
13.1e	active+undersized+degraded	[8,3]	8	[8,3]	8
13.1f	active+undersized+degraded	[4,6]	4	[4,6]	4
13.2a	active+remapped	       [7,4]	7	[7,4,0]	7
13.33	active+undersized+degraded	[7,2]	7	[7,2]	7
13.0	active+undersized+degraded	[0,7]	0	[0,7]	0

ID WEIGHT  TYPE NAME                  UP/DOWN REWEIGHT PRIMARY-AFFINITY
-1 4.94997 root default
-2 1.79999     host aus01
 0 0.45000         osd.0                   up  1.00000          1.00000
 2 0.45000         osd.2                   up  1.00000          1.00000
 3 0.45000         osd.3                   up  1.00000          1.00000
 4 0.45000         osd.4                   up  1.00000          1.00000
-3 1.79999     host aus05
 5 0.45000         osd.5                   up  1.00000          1.00000
 6 0.45000         osd.6                   up  1.00000          1.00000
 7 0.45000         osd.7                   up  1.00000          1.00000
 8 0.45000         osd.8                   up  1.00000          1.00000
-4 1.34999     host aus06
 9 0.45000         osd.9                   up  1.00000          1.00000
10 0.45000         osd.10                  up  1.00000          1.00000
11 0.45000         osd.11                down        0          1.00000
 1       0 osd.1                         down        0          1.00000

