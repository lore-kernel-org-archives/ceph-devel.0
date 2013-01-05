From: Sage Weil <sage@inktank.com>
Subject: Re: ceph stays degraded after crushmap rearrangement
Date: Sat, 5 Jan 2013 10:46:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301051045290.15430@cobra.newdream.net>
References: <50E85799.4060607@profihost.ag> <50E85CC9.9080503@profihost.ag> <alpine.DEB.2.00.1301050905170.15430@cobra.newdream.net> <50E85EB1.8060803@profihost.ag> <50E86008.30000@profihost.ag> <alpine.DEB.2.00.1301050939570.15430@cobra.newdream.net>
 <50E86708.6070909@profihost.ag> <alpine.DEB.2.00.1301050955150.15430@cobra.newdream.net> <50E86B57.4090708@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46035 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab3AESq2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 13:46:28 -0500
In-Reply-To: <50E86B57.4090708@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Followed up on IRC.  The rbd thing was the library version mismatch (see 
my email last night), and the crush issue looks like it was related to 
the rule and only have 1 rack, but we'll see when Stefan tries again.

sage


On Sat, 5 Jan 2013, Stefan Priebe wrote:

> Hi,
> 
> Am 05.01.2013 18:56, schrieb Sage Weil:
> > > But my rbd images are gone ?!
> > > 
> > > [1202: ~]# rbd -p kvmpool1 ls
> > > [1202: ~]#
> > 
> > Oh.. I think this is related to the librados/librbd compatibility issue I
> > mentioned yesterday.  Please make sure the clients (librados, librbd) are
> > also running the latest testing branch.
> 
> ah OK  - thanks that's it - ceph has now also recovered completely with old
> crushmap.
> 
> OK now back to my original problem.
> 
> i wanted to change from this:
> -----------------------------------------
> ...
> 
> rack D2-switchA {
>         id -100         # do not change unnecessarily
>         # weight 12.000
>         alg straw
>         hash 0  # rjenkins1
>         item server1263 weight 4.000
>         item server1264 weight 4.000
>         item server1265 weight 4.000
> }
> rack D2-switchB {
>         id -101         # do not change unnecessarily
>         # weight 12.000
>         alg straw
>         hash 0  # rjenkins1
>         item server1266 weight 4.000
>         item server1267 weight 4.000
>         item server1268 weight 4.000
> }
> root root {
>         id -10000               # do not change unnecessarily
>         # weight 24.000
>         alg straw
>         hash 0  # rjenkins1
>         item D2-switchA weight 12.000
>         item D2-switchB weight 12.000
> }
> 
> ...
> -----------------------------------------
> 
> to this one:
> 
> -----------------------------------------
> ...
> 
> rack D2 {
>         id -100         # do not change unnecessarily
>         # weight 24.000
>         alg straw
>         hash 0  # rjenkins1
>         item cloud1-1263 weight 4.000
>         item cloud1-1264 weight 4.000
>         item cloud1-1265 weight 4.000
>         item cloud1-1266 weight 4.000
>         item cloud1-1267 weight 4.000
>         item cloud1-1268 weight 4.000
> }
> root root {
>         id -10000               # do not change unnecessarily
>         # weight 24.000
>         alg straw
>         hash 0  # rjenkins1
>         item D2 weight 24.000
> }
> 
> ...
> -----------------------------------------
> 
> This was where all problems started. Is this wrong? / not possible?
> 
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
