From: Sage Weil <sage@inktank.com>
Subject: Re: different weight reports by "ceph osd tree" and crushmap
Date: Mon, 4 Feb 2013 08:51:06 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302040849070.24807@cobra.newdream.net>
References: <CAE63xUM0q_M2Q8w_6R+ksxONg_ppkOtvA6PY-uFR7C2g7XNgRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47589 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab3BDQvH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 11:51:07 -0500
In-Reply-To: <CAE63xUM0q_M2Q8w_6R+ksxONg_ppkOtvA6PY-uFR7C2g7XNgRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 4 Feb 2013, Ugis wrote:
> Hi,
> 
> ceph=0.56.2.
> I wonder where is the right place to look for actual weights of OSDs?
> Why "ceph osd tree" and freshly exported crusmap differ in weights?
> 
> # ceph osd tree
> # id    weight  type name       up/down reweight
> -2      6.2     host ceph2
> 0       0.4             osd.0   up      0.373
> 2       3               osd.2   up      2.8
> 4       2.8             osd.4   up      0.373
> -1      10.9    pool default
> -7      6.2             ups 10KVA
> -3      6.2                     rack rack1
> -2      6.2                             host ceph2
> 0       0.4                                     osd.0   up      0.373
> 2       3                                       osd.2   up      2.8
> 4       2.8                                     osd.4   up      0.373
> -8      4.7             ups 6KVA
> -6      4.7                     rack rack4
> -4      2                               host ceph1
> 1       2                                       osd.1   up      1.9
> -9      2.7                             host ceph4
> 3       2.7                                     osd.3   up      2.8

The "reweight" values on teh right side should be between 0 and 1.  I'm 
fixing the monitor ocmmand now to properly enforce this.  1 means "in" 
(the osd gets data), 0 means "out" (the osd gets no data), and anthing in 
between is sort of like a partial failure.

The CRUSH weights on the left should be proportional to the raw capacity. 
The reweights are meant for final corrections only.

sage


> (above weights are correct)
> 
> # ceph health detail
> HEALTH_WARN 1 near full osd(s)
> osd.4 is near full at 94%
> 
> Afterwards did :
> "ceph osd getcrushmap -o map.bin" + "crushtool -d map.bin -o map.plain"
> and here is the excerpt from map.plain:
> ...
> # buckets
> host ceph2 {
>         id -2           # do not change unnecessarily
>         # weight 6.200
>         alg straw
>         hash 0  # rjenkins1
>         item osd.0 weight 0.400
>         item osd.2 weight 3.000
>         item osd.4 weight 2.800
> ...
> 
> I see now why my osd.4 is filling faster than its twin osd.0.
> 
> At some point in past I did "ceph osd reweight osd.x Z.Z" to tune
> weights to match actual TB size of disks, cluster did data rebalancing
> so weights should be the same crush is using, right?
> 
> Any thoughts?
> 
> I will rewrite crushmap weights by hand and try to import the crushmap
> - hope this will rebalance OSDs.
> Or are there other suggestions how to solve this?
> 
> Ugis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
