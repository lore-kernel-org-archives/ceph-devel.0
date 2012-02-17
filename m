From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Tier and MetroCluster
Date: Fri, 17 Feb 2012 17:13:28 +0100
Message-ID: <-4946957540367980946@unknownmsgid>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:50942 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab2BQQNe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2012 11:13:34 -0500
Received: by werb13 with SMTP id b13so1939552wer.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Feb 2012 08:13:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have some question, about future plans.

I know ceph is LAN DFS, not a WAN in any kind, but ;)

1. Is there any plan about tier support. Example:
I have ceph cluster with fast SAS drives, and a losts of RAM, and SSD
acceleration, and 10GE network. I use only RBD, and RadosGW. Cluster
have relative small capacity, but its fast.
I have a second cluster with diffrent configuration, with a large
number of big SATA drives, and smaller number of RAM, 1Gb ethernet.
Same usage as above.
All i need is to have phisical 2 clusters, but with some tier
function, to move old objects from fast to slow cluster (for archive),
and opposite.

If ceph will be very stable this can be done inside one cluster it
will be much simpler, but crush need to know what is faster, and what
is slower.

2. Like above two clusters this time same configurations and size, but
with async replication between.
Replication can be done by the external replication darmon on top of
rados, or other solution.

Is there any plans with any of this ?? Or something like this ??

Pozdrawiam

Slawomir Skowron
