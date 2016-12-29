From: Sage Weil <sage@newdream.net>
Subject: Re: problem with removing osd
Date: Thu, 29 Dec 2016 20:49:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612292048580.10615@piezo.novalocal>
References: <16310616780.20161229160718@tlen.pl>   <alpine.DEB.2.11.1612291908472.10615@piezo.novalocal>  <109878557.20161229212030@tlen.pl>  <alpine.DEB.2.11.1612292025280.10615@piezo.novalocal> <1498014063.20161229214621@tlen.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1541610147-1483044562=:10615"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56531 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbcL2UtX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2016 15:49:23 -0500
In-Reply-To: <1498014063.20161229214621@tlen.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1541610147-1483044562=:10615
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

On Thu, 29 Dec 2016, £ukasz Chrustek wrote:
> Cze¶æ,
> 
> > On Thu, 29 Dec 2016, £ukasz Chrustek wrote:
> >> Hi,
> >> 
> >> 
> >> >> 
> >> >> # ceph osd tree
> >> >> ID        WEIGHT    TYPE NAME             UP/DOWN REWEIGHT PRIMARY-AFFINITY
> >> >>        -7  16.89590 root ssd-disks
> >> >>       -11         0     host ssd1
> >> >> 598798032         0         osd.598798032     DNE        0
> >> 
> >> > Yikes!
> >> 
> >> Yes... indeed, I don't like this number too...
> >> 
> >> >>     21940         0         osd.21940         DNE        0
> >> >>        71         0         osd.71            DNE        0
> >> >> 
> >> >> My question is how to delete this osds without direct editing crushmap
> >> >> ? It is production system, I can't affort any service interruption :(,
> >> >> when I try to ceph osd crush remove then ceph-mon crushes....
> >> >> 
> >> >> I  dumped  crushmap,  but it took 19G (!!) after decompiling (compiled
> >> >> file  is  very small). So, I cleaned this file with perl (it take very
> >> >> long  time), and I have now small txt crushmap, which I edited. But is
> >> >> there  any  chance  that ceph will still remember somewhere about this
> >> >> huge  numbers  for osds ? Is it safe to apply this cleaned crushmap to
> >> >> cluster ?
> >> 
> >> > It sounds like the problem is the OSDMap, not CRUSH per se.  Can you 
> >> > attach the output from 'ceph osd dump -f json-pretty'?
> >> 
> >> It's quite big so I put it on pastebin:
> >> 
> >> http://pastebin.com/Unkk2Pa7
> >> 
> >> > Do you know how osd.598798032 got created?  Or osd.21940 for that matter.
> >> > OSD ids should be small since they are stored internally by OSDMap as a
> >> > vector.  This is probably why your mon is crashing.
> >> 
> >> [root@cc1 /etc/ceph]# ceph osd tree
> >> ID  WEIGHT    TYPE NAME            UP/DOWN REWEIGHT PRIMARY-AFFINITY
> >>  -7  16.89590 root ssd-intel-s3700
> >> -11         0     host ssd-stor1
> >>  69         0         osd.69          down        0          1.00000
> >>  70         0         osd.70          down        0          1.00000
> >>  71         0         osd.71          down        0          1.00000
> >> 
> >> 
> >> This the moment, when it happend:
> >> ]# for i in `seq 69 71`;do ceph osd crush remove osd.$i;done
> >> removed item id 69 name 'osd.69' from crush map
> >> 
> >> 
> >> removed item id 70 name 'osd.70' from crush map
> >> 
> >> here i press ctrl+c
> >> 
> >> 2016-12-28 17:38:10.055239 7f4576d7a700  0 monclient: hunting for new mon
> >> 2016-12-28 17:38:10.055582 7f4574233700  0 -- 192.168.128.1:0/1201679761 >> 192.168.128.2:6789/0 pipe(0x7f456c023190 sd=3 :0 s=1 pgs=0 cs=0 l=1 c=0x7f456c024470).fault
> >> 2016-12-28 17:38:30.550622 7f4574233700  0 -- 192.168.128.1:0/1201679761 >> 192.168.128.1:6789/0 pipe(0x7f45600008c0 sd=3 :0 s=1 pgs=0 cs=0 l=1 c=0x7f4560001df0).fault
> >> 2016-12-28 17:38:54.551031 7f4574474700  0 -- 192.168.128.1:0/1201679761 >> 192.168.128.2:6789/0 pipe(0x7f45600046c0 sd=4 :0 s=1 pgs=0 cs=0 l=1 c=0x7f45600042b0).fault
> 
> > What version is this?
> 
> infernalis
> 
> > Can you attach the crush map too?  (ceph osd crush dump -f json-pretty)
> 
> I can't - ceph-mons are crushing on diffrent ceph-mon hosts:
> 
> ]# ceph osd crush dump -f json-pretty

Hmm, in that case, 'ceph osd getcrushmap -o cm' and post that somewhere?

sage

--8323329-1541610147-1483044562=:10615--
