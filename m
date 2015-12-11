From: Sage Weil <sage@newdream.net>
Subject: Re: The max single write IOPS on single RBD
Date: Fri, 11 Dec 2015 05:15:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512110512560.10312@cobra.newdream.net>
References: <CAGkCoN+fT_9fqmUzc0HYkpder_qis-tB9jR-nCwvtJZPD=QGKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50574 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbLKNPE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Dec 2015 08:15:04 -0500
In-Reply-To: <CAGkCoN+fT_9fqmUzc0HYkpder_qis-tB9jR-nCwvtJZPD=QGKQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhi Zhang <zhang.david2011@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 11 Dec 2015, Zhi Zhang wrote:
> Hi Guys,
> 
> We have a small 4 nodes cluster. Here is the hardware configuration.
> 
> 11 x 300GB SSD, 24 cores, 32GB memory per one node.
> all the nodes connected within one 1Gb/s network.
> 
> So we have one Monitor and 44 OSDs for testing kernel RBD IOPS using
> fio. Here are the major fio options.
> 
> -direct=1
> -rw=randwrite
> -ioengine=psync
> -size=1000M
> -bs=4k
> -numjobs=1
> 
> The max IOPS we can achieve for single write (numjobs=1) is close to
> 1000. This means each IO from RBD takes 1.x ms.
> 
> >From osd logs, we can also observe most of osd_ops will take 1.x ms,
> including op processing, journal writing, replication, etc, before
> sending commit back to client.
> 
> The network RTT is around 0.04 ms;
> Most osd_ops on primary OSD take around 0.5~0.7 ms, journal write takes 0.3 ms;
> Most osd_repops including writing journal on peer OSD take around 0.5 ms.
> 
> We even tried to modify journal to write page cache only, but didn't
> get very significant improvement. Does it mean this is the best result
> we can get for single write on single RBD?

What version is this?  There have been a few recent changes that will 
reduce the wall clock time spent preparing/processing a request.  There is 
still a fair bit of work to do here, though--the theoretical lower bound 
is the SSD write time + 2x RTT (client <-> primary osd <-> replica osd <-> 
replica ssd).

sage

