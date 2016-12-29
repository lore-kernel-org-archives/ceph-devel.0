From: Sage Weil <sage@newdream.net>
Subject: Re: problem with removing osd
Date: Thu, 29 Dec 2016 19:10:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612291908472.10615@piezo.novalocal>
References: <16310616780.20161229160718@tlen.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-280461373-1483038618=:10615"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55795 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbcL2TKT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2016 14:10:19 -0500
In-Reply-To: <16310616780.20161229160718@tlen.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-280461373-1483038618=:10615
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

On Thu, 29 Dec 2016, £ukasz Chrustek wrote:
> Hi,
> 
> I was trying to delete 3 osds from cluster, deletion procces took very
> long  time and I interrupted it. mon process then crushed, and in ceph
> osd tree (after restart ceph-mon) I saw:
> 
>  ~]# ceph osd tree
> ID         WEIGHT    TYPE NAME            UP/DOWN REWEIGHT PRIMARY-AFFINITY
>         -7  16.89590 root ssd-disks
>        -11         0     host ssd1
> -231707408         0
>      22100         0         osd.22100        DNE        0
>         71         0         osd.71           DNE        0
> 
> 
> when I tried to delete osd.22100:
> 
> [root@cc1 ~]# ceph osd crush remove osd.22100
> device 'osd.22100' does not appear in the crush map
> 
> then I tried to delete osd.71 and mon proccess crushed:
> 
> [root@cc1 ~]# ceph osd crush remove osd.71
> 2016-12-28 17:52:34.459668 7f426a862700  0 monclient: hunting for new mon
> 
> after restart of ceph-mon in ceph osd tree it shows:
> 
> # ceph osd tree
> ID        WEIGHT    TYPE NAME             UP/DOWN REWEIGHT PRIMARY-AFFINITY
>        -7  16.89590 root ssd-disks
>       -11         0     host ssd1
> 598798032         0         osd.598798032     DNE        0

Yikes!

>     21940         0         osd.21940         DNE        0
>        71         0         osd.71            DNE        0
> 
> My question is how to delete this osds without direct editing crushmap
> ? It is production system, I can't affort any service interruption :(,
> when I try to ceph osd crush remove then ceph-mon crushes....
> 
> I  dumped  crushmap,  but it took 19G (!!) after decompiling (compiled
> file  is  very small). So, I cleaned this file with perl (it take very
> long  time), and I have now small txt crushmap, which I edited. But is
> there  any  chance  that ceph will still remember somewhere about this
> huge  numbers  for osds ? Is it safe to apply this cleaned crushmap to
> cluster ?

It sounds like the problem is the OSDMap, not CRUSH per se.  Can you 
attach the output from 'ceph osd dump -f json-pretty'?

Do you know how osd.598798032 got created?  Or osd.21940 for that matter.  
OSD ids should be small since they are stored internally by OSDMap as a 
vector.  This is probably why your mon is crashing.

sage
--8323329-280461373-1483038618=:10615--
