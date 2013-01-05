From: Denis Fondras <ceph@ledeuns.net>
Subject: Is Ceph recovery able to handle massive crash
Date: Sat, 05 Jan 2013 13:19:09 +0100
Message-ID: <50E81A3D.5070100@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:39409 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab3AEM0w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 07:26:52 -0500
Received: from [IPv6:2001:7a8:b5ad::10:10] (unknown [IPv6:2001:7a8:b5ad::10:10])
	by mail.ledeuns.net (Postfix) with ESMTPSA id 0563693264
	for <ceph-devel@vger.kernel.org>; Sat,  5 Jan 2013 13:19:39 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello all,

I'm using Ceph 0.55.1 on a Debian Wheezy (1 mon, 1 mds et 3 osd over 
btrfs) and every once in a while, an OSD process crashes (almost never 
the same osd crashes).
This time I had 2 osd crash in a row and so I only had one replicate. I 
could bring the 2 crashed osd up and it started to recover. 
Unfortunately, the "source" osd crashed while recovering and now I have 
a some lost PGs.

If I happen to bring the primary OSD up again, can I imagine the lost PG 
will be recovered too ?

Regards,
Denis
