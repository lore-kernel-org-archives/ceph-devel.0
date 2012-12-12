From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Problems with active+remapped PGs in Ceph 0.55
Date: Wed, 12 Dec 2012 00:57:20 -0800
Message-ID: <50C846F0.7090900@inktank.com>
References: <50C836CB.6000502@rocknob.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:42651 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab2LLI51 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 03:57:27 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so170289dak.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 00:57:26 -0800 (PST)
In-Reply-To: <50C836CB.6000502@rocknob.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: norbi <norbi@rocknob.de>
Cc: ceph-devel@vger.kernel.org

On 12/11/2012 11:48 PM, norbi wrote:
> Hi Ceph-List,
>
> i have set up a Ceph-Cluster with 3 OSDs, 3 Mons, 2 MDS over three server.
> Server 1 has 2 ODSs (osd0,osd2) and one MON/MDS and Server 2 has only
> osd2 and one MON + MDS.
> Server 3 has only the third MON-Service.
>
> All Servers are running Ceph 0.55 and Kernel 3.6.9 with Centos 6 64bit.
>
> ceph osd shows me in first state
>
> ceph osd tree
>
> # id    weight  type name       up/down reweight
> -1      3       pool default
> -3      3               rack unknownrack
> -4      1                       host unknownhost
> 1       1                               osd.1   up      1
> 2       1                               osd.2   up      1
> 0       1                               osd.0   up      1
>
> ceph health is ok !
>
> now i have edit the crush map to the following
>
> # id    weight  type name       up/down reweight
> -1      3       pool default
> -3      3               rack unknownrack
> -4      1                       host testblade01
> 1       1                               osd.1   up      1
> -2      1                       host unknownhost
> 2       1                               osd.2   up      1
> 0       1                               osd.0   up      1
>
>
> now ceph is remaping some existing PGs and there are my problems began...
>
> ceph is stopping remapping some PGs and the status is "current state
> active+remapped" but nothing happens... after about 14h the PGs are in
> the same state and ceph health is in status HEALTH_WARN. there are no
> lost or unfound object, i can read all files in ceph without problems
> and i can write into ceph storage.
>
> how can i find the problem or force remapping of the PGs ? i have looked
> into the source code, but i dont find a comman like "ceph pg force_remap
> 1.a4". "ceph pg PGNUMBER" shows me that there are no unfound objects.
>
> any help ?

I'm guessing you're hitting the issue with small numbers of devices and
legacy crush tunables described here:

http://ceph.com/docs/master/rados/operations/crush-map/#impact-of-legacy-values

Updating to use the recommended new tunables as described on that page
should fix the problem.

You can verify that this is the problem by checking the output of
'ceph pg dump' - it will show the up set of osds for the remapped pgs
as only a single osd, and being remapped to an acting set including two
osds.

Josh
