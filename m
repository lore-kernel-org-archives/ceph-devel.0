From: Sage Weil <sage@newdream.net>
Subject: Re: Problem with query and any operation on PGs
Date: Wed, 24 May 2017 13:37:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705241335190.3646@piezo.novalocal>
References: <175484591.20170523135449@tlen.pl> <483467685.20170523144818@tlen.pl>       <alpine.DEB.2.11.1705231415400.3646@piezo.novalocal>   <1464688590.20170523185052@tlen.pl>   <alpine.DEB.2.11.1705231738520.3646@piezo.novalocal>  <1075363645.20170523234331@tlen.pl>
  <alpine.DEB.2.11.1705232146500.3646@piezo.novalocal> <135176900.20170524151952@tlen.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1334502866-1495633051=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40890 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758529AbdEXNhc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 09:37:32 -0400
In-Reply-To: <135176900.20170524151952@tlen.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1334502866-1495633051=:3646
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

On Wed, 24 May 2017, £ukasz Chrustek wrote:
> Cze¶æ,
> 
> > On Tue, 23 May 2017, £ukasz Chrustek wrote:
> >> Cze¶æ,
> >> 
> >> > On Tue, 23 May 2017, £ukasz Chrustek wrote:
> >> >> I'm  not  sleeping for over 30 hours, and still can't find solution. I
> >> >> did,      as      You      wrote,     but     turning     off     this
> >> >> (https://pastebin.com/1npBXeMV) osds didn't resolve issue...
> >> 
> >> > The important bit is:
> >> 
> >> >             "blocked": "peering is blocked due to down osds",
> >> >             "down_osds_we_would_probe": [
> >> >                 6,
> >> >                 10,
> >> >                 33,
> >> >                 37,
> >> >                 72
> >> >             ],
> >> >             "peering_blocked_by": [
> >> >                 {
> >> >                     "osd": 6,
> >> >                     "current_lost_at": 0,
> >> >                     "comment": "starting or marking this osd lost may let
> >> > us proceed"
> >> >                 },
> >> >                 {
> >> >                     "osd": 10,
> >> >                     "current_lost_at": 0,
> >> >                     "comment": "starting or marking this osd lost may let
> >> > us proceed"
> >> >                 },
> >> >                 {
> >> >                     "osd": 37,
> >> >                     "current_lost_at": 0,
> >> >                     "comment": "starting or marking this osd lost may let
> >> > us proceed"
> >> >                 },
> >> >                 {
> >> >                     "osd": 72,
> >> >                     "current_lost_at": 113771,
> >> >                     "comment": "starting or marking this osd lost may let
> >> > us proceed"
> >> >                 }
> >> >             ]
> >> >         },
> >> 
> >> > Are any of those OSDs startable?
> >> 
> >> They were all up and running - but I decided to shut them down and out
> >> them  from  ceph, now it looks like ceph working ok, but still two PGs
> >> are in down state, how to get rid of it ?
> 
> > If you haven't deleted the data, you should start the OSDs back up.
> 
> > If they are partially damanged you can use ceph-objectstore-tool to 
> > extract just the PGs in question to make sure you haven't lost anything,
> > inject them on some other OSD(s) and restart those, and *then* mark the
> > bad OSDs as 'lost'.
> 
> > If all else fails, you can just mark those OSDs 'lost', but in doing so
> > you might be telling the cluster to lose data.
> 
> > The best thing to do is definitely to get those OSDs started again.
> 
> Now situation looks like this:
> 
> [root@cc1 ~]# rbd info volumes/volume-ccc5d976-cecf-4938-a452-1bee6188987b
> rbd image 'volume-ccc5d976-cecf-4938-a452-1bee6188987b':
>         size 500 GB in 128000 objects
>         order 22 (4096 kB objects)
>         block_name_prefix: rbd_data.ed9d394a851426
>         format: 2
>         features: layering
>         flags:
> 
> [root@cc1 ~]# rados -p volumes ls | grep rbd_data.ed9d394a851426
> (output cutted)
> rbd_data.ed9d394a851426.000000000000447c
> rbd_data.ed9d394a851426.0000000000010857
> rbd_data.ed9d394a851426.000000000000ec8b
> rbd_data.ed9d394a851426.000000000000fa43
> rbd_data.ed9d394a851426.000000000001ef2d
> ^C
> 
> it hangs on this object and isn't going further. rbd cp also hangs...
> rbd map - also...
> 
> can  You advice what can be solution for this case ?

The hang is due to OSD throttling (see my first reply for how to wrok 
around that and get a pg query).  But you already did that and the cluster 
told you which OSDs it needs to see up in order for it to peer and 
recover.  If you haven't destroyed those disks, you should start those 
osds and it shoudl be fine.  If you've destroyed the data or the disks are 
truly broken and dead, then you can mark those OSDs lost and the cluster 
*maybe* recover (but hard to say given the information you've shared).

sage

--8323329-1334502866-1495633051=:3646--
