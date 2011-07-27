From: Sage Weil <sage@newdream.net>
Subject: Re: Primary mds failure
Date: Wed, 27 Jul 2011 13:35:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107271332420.29985@cobra.newdream.net>
References: <CAJD3hpXvxQD94MO+RHrtXcHV5sFxXvarJdOxEs3o-U0NyD4eqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34561 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab1G0UbN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 16:31:13 -0400
In-Reply-To: <CAJD3hpXvxQD94MO+RHrtXcHV5sFxXvarJdOxEs3o-U0NyD4eqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 27 Jul 2011, Jojy Varghese wrote:
> Hi
>    We are observing that when the primary mds goes away(say OOM killer
> victim), the client keeps on trying (forever) to write to it(try_write
> method in the messenger) and eventually results in filesystem hang. So
> the question is :
> 
>  - Why does the kernel client attempt another mds?

As soon as another mds takes over for it the client will connect to them.  
(Unless there's a bug in the old ceph_connection cleanup.)

>  - Is replication (mds) guaranteed to take place before the primary
> mds goes down? In other words, is replication done preemtively or due
> to a trigger (scheduled or event based)?

The MDS journals updates to the object store (where the objects are 
replicated by multiple osds).  The MDS is careful to inform the client 
which operations have committed and to prevent leakage of uncommitted 
information from one client to another.  On reconnect, clients replay 
their uncommitted state (by resending requests and re-writing back dirty 
cap/inode metadata).

sage
