From: Sage Weil <sage@newdream.net>
Subject: Re: Luminous RC feedback - device classes and osd df weirdness
Date: Thu, 29 Jun 2017 13:27:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706291326030.3424@piezo.novalocal>
References: <71ce32a8-6232-0f5b-35a5-d86f30a045db@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35231 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752698AbdF2N2A (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jun 2017 09:28:00 -0400
In-Reply-To: <71ce32a8-6232-0f5b-35a5-d86f30a045db@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 29 Jun 2017, Mark Kirkwood wrote:
> Hi,
> 
> I'm running a 4 node test 'cluster' (VMs on my workstation) that I've upgraded
> to Luminous RC. Specifically I wanted to test having each node with 1 spinning
> device and one solid state state so I could try out device classes to create
> fast and slow(er) pools.
> 
> I started with 4 filestore osds (comimg from the Jewel pre-upgrade), and added
> 4 more, all of which were Bluestore on the ssds.
> 
> I used crushtool to set the device classes (see crush test diff below).
> 
> That all went very smoothly, with only a couple of things that seemed weird.
> Firstly the crush/osd tree output is a bit strange (but I could get to the
> point where it make sense):
> 
> $ sudo ceph osd tree
> ID  WEIGHT  TYPE NAME          UP/DOWN REWEIGHT PRIMARY-AFFINITY
> -15 0.23196 root default~ssd
> -11 0.05699     host ceph1~ssd
>   4 0.05699         osd.4           up  1.00000 1.00000
> -12 0.05899     host ceph2~ssd
>   5 0.05899         osd.5           up  1.00000 1.00000
> -13 0.05699     host ceph3~ssd
>   6 0.05699         osd.6           up  1.00000 1.00000
> -14 0.05899     host ceph4~ssd
>   7 0.05899         osd.7           up  1.00000 1.00000
> -10 0.07996 root default~hdd
>  -6 0.01999     host ceph1~hdd
>   0 0.01999         osd.0           up  1.00000 1.00000
>  -7 0.01999     host ceph2~hdd
>   1 0.01999         osd.1           up  1.00000 1.00000
>  -8 0.01999     host ceph3~hdd
>   2 0.01999         osd.2           up  1.00000 1.00000
>  -9 0.01999     host ceph4~hdd
>   3 0.01999         osd.3           up  1.00000 1.00000
>  -1 0.31198 root default
>  -2 0.07700     host ceph1
>   0 0.01999         osd.0           up  1.00000 1.00000
>   4 0.05699         osd.4           up  1.00000 1.00000
>  -3 0.07899     host ceph2
>   1 0.01999         osd.1           up  1.00000 1.00000
>   5 0.05899         osd.5           up  1.00000 1.00000
>  -4 0.07700     host ceph3
>   2 0.01999         osd.2           up  1.00000 1.00000
>   6 0.05699         osd.6           up  1.00000 1.00000
>  -5 0.07899     host ceph4
>   3 0.01999         osd.3           up  1.00000 1.00000
>   7 0.05899         osd.7           up  1.00000 1.00000

I was a bit divided when we were doing this about whether the unfiltered 
(above) output or a view that hides the per-class view is better.  Maybe

 ceph osd tree

would show the traditional view (with a device class column) and

 ceph osd class-tree <class>

would show a single class?

> But the osd df output is baffling, I've got two identical lines for each osd
> (hard to see immediately - sorting by osd id would make it easier). This is
> not ideal, particularly as for the bluestore guys there is no other way to
> work out utilization. Any ideas - have I done something obviously wrong here
> that is triggering the 2 lines?
> 
> $ sudo ceph osd df
> ID WEIGHT  REWEIGHT SIZE   USE    AVAIL  %USE VAR  PGS
>  4 0.05699  1.00000 60314M  1093M 59221M 1.81 1.27   0
>  5 0.05899  1.00000 61586M  1234M 60351M 2.00 1.40   0
>  6 0.05699  1.00000 60314M  1248M 59066M 2.07 1.45   0
>  7 0.05899  1.00000 61586M  1209M 60376M 1.96 1.37   0
>  0 0.01999  1.00000 25586M 43812k 25543M 0.17 0.12  45
>  1 0.01999  1.00000 25586M 42636k 25544M 0.16 0.11  37
>  2 0.01999  1.00000 25586M 44336k 25543M 0.17 0.12  53
>  3 0.01999  1.00000 25586M 42716k 25544M 0.16 0.11  57
>  0 0.01999  1.00000 25586M 43812k 25543M 0.17 0.12  45
>  4 0.05699  1.00000 60314M  1093M 59221M 1.81 1.27   0
>  1 0.01999  1.00000 25586M 42636k 25544M 0.16 0.11  37
>  5 0.05899  1.00000 61586M  1234M 60351M 2.00 1.40   0
>  2 0.01999  1.00000 25586M 44336k 25543M 0.17 0.12  53
>  6 0.05699  1.00000 60314M  1248M 59066M 2.07 1.45   0
>  3 0.01999  1.00000 25586M 42716k 25544M 0.16 0.11  57
>  7 0.05899  1.00000 61586M  1209M 60376M 1.96 1.37   0
>               TOTAL   338G  4955M   333G 1.43
> MIN/MAX VAR: 0.11/1.45  STDDEV: 0.97

This is just a bug, fixing.

Thanks!
sage



> 
> 
> The modifications to crush map
> --- crush.txt.orig    2017-06-28 14:38:38.067669000 +1200
> +++ crush.txt    2017-06-28 14:41:22.071669000 +1200
> @@ -8,14 +8,14 @@
>  tunable allowed_bucket_algs 54
> 
>  # devices
> -device 0 osd.0
> -device 1 osd.1
> -device 2 osd.2
> -device 3 osd.3
> -device 4 osd.4
> -device 5 osd.5
> -device 6 osd.6
> -device 7 osd.7
> +device 0 osd.0 class hdd
> +device 1 osd.1 class hdd
> +device 2 osd.2 class hdd
> +device 3 osd.3 class hdd
> +device 4 osd.4 class ssd
> +device 5 osd.5 class ssd
> +device 6 osd.6 class ssd
> +device 7 osd.7 class ssd
> 
>  # types
>  type 0 osd
> @@ -80,7 +80,7 @@
>      type replicated
>      min_size 1
>      max_size 10
> -    step take default
> +    step take default class hdd
>      step chooseleaf firstn 0 type host
>      step emit
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
