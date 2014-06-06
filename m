From: Sage Weil <sage@inktank.com>
Subject: Re: incomplete PG
Date: Fri, 6 Jun 2014 08:57:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406060856330.31587@cobra.newdream.net>
References: <20140606132000.GA17468@unsen.q53.spb.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43851 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbaFFP5q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jun 2014 11:57:46 -0400
In-Reply-To: <20140606132000.GA17468@unsen.q53.spb.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexey Kurnosov <alexey@kurnosov.spb.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 6 Jun 2014, Alexey Kurnosov wrote:
> Hi all.
> 
> Sorry for a rude offtop, but looks like nobody can help me at ceph-users.
> Here is the link to my email:
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-June/040383.html
> Here some additional data:
> http://pastebin.com/Nc4y3S1U
> 
> During read requests i can see in logs:
> 2014-06-06 13:28:08.586262 7f335f29f700 10 osd.7 21942 dequeue_op 0x356cb40 prio 127 cost 0 latency 0.000352 osd_op(client.11324.1:436 rb.0.1465.2ae8944a.000000000bb1 [read 0~131072] 4.b940a077 e21942) v4 pg pg[4.77( empty local-les=0 n=0 ec=144 les/c 19162/16786 21941/21941/21941) [7,2] r=0 lpr=21941 pi=8764-21940/115 mlcod 0'0 incomplete]
> 
> 
> Any help would be appreciated. 

This looks like a hangup somewhere in teh osd/osd communication that is 
preventing the peering/probing from happening.  Since you're running 
emperor and we stopped testing and backporting fixes there a while back 
I'm not sure offhand what bug fix is missing.  My suggestion is to upgrade 
to 0.80.1 firefly as a first step.

FWIW simply restartin the OSDs involved in those PGs will probably also 
get things rolling, but this bug will still be present.

sage


 > 
> 
> (Somebody hit similar issue here: http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-February/007948.html)
> 
> --
> Alexey Kurnosov
> 
> 
> 
> 
> 
> 
