From: Sage Weil <sage@newdream.net>
Subject: Re: Problem with query and any operation on PGs
Date: Wed, 24 May 2017 21:53:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705242149300.3646@piezo.novalocal>
References: <175484591.20170523135449@tlen.pl> <483467685.20170523144818@tlen.pl>             <alpine.DEB.2.11.1705231415400.3646@piezo.novalocal>      <1464688590.20170523185052@tlen.pl>      <alpine.DEB.2.11.1705231738520.3646@piezo.novalocal>    
 <1075363645.20170523234331@tlen.pl>    <alpine.DEB.2.11.1705232146500.3646@piezo.novalocal>    <135176900.20170524151952@tlen.pl>    <alpine.DEB.2.11.1705241335190.3646@piezo.novalocal>   <1203308391.20170524155848@tlen.pl>   <alpine.DEB.2.11.1705241401260.3646@piezo.novalocal>
  <379087365.20170524161815@tlen.pl>  <alpine.DEB.2.11.1705241444150.3646@piezo.novalocal> <2910218531.20170524233842@tlen.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1652578257-1495662603=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52588 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164274AbdEXVxE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 17:53:04 -0400
In-Reply-To: <2910218531.20170524233842@tlen.pl>
Content-ID: <alpine.DEB.2.11.1705242150210.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1652578257-1495662603=:3646
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1705242150211.3646@piezo.novalocal>

On Wed, 24 May 2017, £ukasz Chrustek wrote:
> Hello,
> 
> >>
> >> > This
> >> 
> >> osd 6 - isn't startable
> 
> > Disk completely 100% dead, or just borken enough that ceph-osd won't 
> > start?  ceph-objectstore-tool can be used to extract a copy of the 2 pgs
> > from this osd to recover any important writes on that osd.
> 
> >> osd 10, 37, 72 are startable
> 
> > With those started, I'd repeat the original sequence and get a fresh pg
> > query to confirm that it still wants just osd.6.
> 
> > use ceph-objectstore-tool to export the pg from osd.6, stop some other
> > ranodm osd (not one of these ones), import the pg into that osd, and start
> > again.  once it is up, 'ceph osd lost 6'.  the pg *should* peer at that
> > point.  repeat with the same basic process with the other pg.
> 
> Here is output from ceph-objectstore-tool - also didn't success:
> 
> https://pastebin.com/7XGAHdKH

Hmm, btrfs:

2017-05-24 23:28:58.547456 7f500948e940 -1 
filestore(/var/lib/ceph/osd/ceph-84) ERROR: 
/var/lib/ceph/osd/ceph-84/current/nosnap exists, not rolling back to avoid 
losing new data

You could try setting --osd-use-stale-snap as suggested.

Is it the same error with the other one?


Looking at the log you sent earlier for 1.165 on osd.67, and the primary 
reports:

2017-05-24 21:37:11.505256 7efdbc1e5700  5 osd.67 pg_epoch: 115601 pg[1.165( v 112959'67282586 (112574'67278552,112959'67282586] lb 1/db616165/rbd_data.ed9979641a9d82.000000000001dcee/head (NIBBLEWISE) local-les=112600 n=354 ec=253 les/c/f 112600/112582/70621 115601/115601/115601) [67,88,48] r=0 lpr=115601 pi=112581-115600/111 crt=112959'67282586 lcod 0'0 mlcod 0'0 peering NIBBLEWISE] enter Started/Primary/Peering/GetLog
2017-05-24 21:37:11.505291 7efdbc1e5700 10 osd.67 pg_epoch: 115601 pg[1.165( v 112959'67282586 (112574'67278552,112959'67282586] lb 1/db616165/rbd_data.ed9979641a9d82.000000000001dcee/head (NIBBLEWISE) local-les=112600 n=354 ec=253 les/c/f 112600/112582/70621 115601/115601/115601) [67,88,48] r=0 lpr=115601 pi=112581-115600/111 crt=112959'67282586 lcod 0'0 mlcod 0'0 peering NIBBLEWISE] calc_acting osd.37 1.165( v 112598'67281552 (112574'67278547,112598'67281552] lb 1/56500165/rbd_data.674a3ed7dffd473.0000000000000b38/
head (NIBBLEWISE) local-les=112584 n=1 ec=253 les/c/f 112600/112582/70621 115601/115601/115601)
2017-05-24 21:37:11.505299 7efdbc1e5700 10 osd.67 pg_epoch: 115601 pg[1.165( v 112959'67282586 (112574'67278552,112959'67282586] lb 1/db616165/rbd_data.ed9979641a9d82.000000000001dcee/head (NIBBLEWISE) local-les=112600 n=354 ec=253 les/c/f 112600/112582/70621 115601/115601/115601) [67,88,48] r=0 lpr=115601 pi=112581-115600/111 crt=112959'67282586 lcod 0'0 mlcod 0'0 peering NIBBLEWISE] calc_acting osd.38 1.165( v 112959'67282586 (112574'67278552,112959'67282586] lb 1/db616165/rbd_data.ed9979641a9d82.000000000001dcee/h
ead (NIBBLEWISE) local-les=112600 n=354 ec=253 les/c/f 112600/112582/70621 115601/115601/115601)
2017-05-24 21:37:11.505306 7efdbc1e5700 10 osd.67 pg_epoch: 115601 pg[1.165( v 112959'67282586 (112574'67278552,112959'67282586] lb 1/db616165/rbd_data.ed9979641a9d82.000000000001dcee/head (NIBBLEWISE) local-les=112600 n=354 ec=253 les/c/f 112600/112582/70621 115601/115601/115601) [67,88,48] r=0 lpr=115601 pi=112581-115600/111 crt=112959'67282586 lcod 0'0 mlcod 0'0 peering NIBBLEWISE] calc_acting osd.48 1.165( v 112959'67282586 (112574'67278552,112959'67282586] lb 1/db616165/rbd_data.ed9979641a9d82.000000000001dcee/h
ead (NIBBLEWISE) local-les=112600 n=354 ec=253 les/c/f 112600/112582/70621 115601/115601/115601)
2017-05-24 21:37:11.505313 7efdbc1e5700 10 osd.67 pg_epoch: 115601 pg[1.165( v 112959'67282586 (112574'67278552,112959'67282586] lb 1/db616165/rbd_data.ed9979641a9d82.000000000001dcee/head (NIBBLEWISE) local-les=112600 n=354 ec=253 les/c/f 112600/112582/70621 115601/115601/115601) [67,88,48] r=0 lpr=115601 pi=112581-115600/111 crt=112959'67282586 lcod 0'0 mlcod 0'0 peering NIBBLEWISE] calc_acting osd.67 1.165( v 112959'67282586 (112574'67278552,112959'67282586] lb 1/db616165/rbd_data.ed9979641a9d82.000000000001dcee/h
ead (NIBBLEWISE) local-les=112600 n=354 ec=253 les/c/f 112600/112582/70621 115601/115601/115601)
2017-05-24 21:37:11.505319 7efdbc1e5700 10 osd.67 pg_epoch: 115601 pg[1.165( v 112959'67282586 (112574'67278552,112959'67282586] lb 1/db616165/rbd_data.ed9979641a9d82.000000000001dcee/head (NIBBLEWISE) local-les=112600 n=354 ec=253 les/c/f 112600/112582/70621 115601/115601/115601) [67,88,48] r=0 lpr=115601 pi=112581-115600/111 crt=112959'67282586 lcod 0'0 mlcod 0'0 peering NIBBLEWISE] calc_acting osd.88 1.165( empty local-les=0 n=0 ec=253 les/c/f 112600/112582/70621 115601/115601/115601)
2017-05-24 21:37:11.505326 7efdbc1e5700 10 osd.67 pg_epoch: 115601 pg[1.165( v 112959'67282586 (112574'67278552,112959'67282586] lb 1/db616165/rbd_data.ed9979641a9d82.000000000001dcee/head (NIBBLEWISE) local-les=112600 n=354 ec=253 les/c/f 112600/112582/70621 115601/115601/115601) [67,88,48] r=0 lpr=115601 pi=112581-115600/111 crt=112959'67282586 lcod 0'0 mlcod 0'0 peering NIBBLEWISE] choose_acting failed

in particular, osd 37 38 48 67 all have incomplete copies of the PG (they 
are mid-backfill) and 68 has nothing.  Some data is lost unless you can 
recovery another OSD with that PG.

The set of OSDs that might have data are: 6,10,33,72,84

If that bears no fruit, then you can force last_backfill to report 
complete on one of those OSDs and it'll think it has all the data even 
though some of it is likely gone.  (We can pick one that is farther 
along... 38 48 and 67 seem to all match.)

sage
--8323329-1652578257-1495662603=:3646--
