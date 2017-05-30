From: Sage Weil <sage@newdream.net>
Subject: Re: Problem with query and any operation on PGs
Date: Tue, 30 May 2017 13:21:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705301315220.3646@piezo.novalocal>
References: <175484591.20170523135449@tlen.pl> <483467685.20170523144818@tlen.pl>                 <alpine.DEB.2.11.1705231415400.3646@piezo.novalocal>        <1464688590.20170523185052@tlen.pl>        <alpine.DEB.2.11.1705231738520.3646@piezo.novalocal>   
    <1075363645.20170523234331@tlen.pl>      <alpine.DEB.2.11.1705232146500.3646@piezo.novalocal>      <135176900.20170524151952@tlen.pl>      <alpine.DEB.2.11.1705241335190.3646@piezo.novalocal>     <1203308391.20170524155848@tlen.pl>    
 <alpine.DEB.2.11.1705241401260.3646@piezo.novalocal>   <379087365.20170524161815@tlen.pl>    <alpine.DEB.2.11.1705241444150.3646@piezo.novalocal>   <2910218531.20170524233842@tlen.pl>   <alpine.DEB.2.11.1705242149300.3646@piezo.novalocal>
 <804507840.20170525000904@tlen.pl>  <alpine.DEB.2.11.1705242227320.3646@piezo.novalocal> <154794248.20170525004623@tlen.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1540986057-1496150188=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57371 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdE3NVa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 30 May 2017 09:21:30 -0400
In-Reply-To: <154794248.20170525004623@tlen.pl>
Content-ID: <alpine.DEB.2.11.1705301316460.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1540986057-1496150188=:3646
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.11.1705301316461.3646@piezo.novalocal>

On Thu, 25 May 2017, £ukasz Chrustek wrote:
> Cze¶æ,
> 
> > On Thu, 25 May 2017, £ukasz Chrustek wrote:
> >> Cze¶æ,
> >> 
> >> > On Wed, 24 May 2017, £ukasz Chrustek wrote:
> >> >> Hello,
> >> >> 
> >> >> >>
> >> >> >> > This
> >> >> >> 
> >> >> >> osd 6 - isn't startable
> >> >> 
> >> >> > Disk completely 100% dead, or just borken enough that ceph-osd won't 
> >> >> > start?  ceph-objectstore-tool can be used to extract a copy of the 2 pgs
> >> >> > from this osd to recover any important writes on that osd.
> >> >> 
> >> >> >> osd 10, 37, 72 are startable
> >> >> 
> >> >> > With those started, I'd repeat the original sequence and get a fresh pg
> >> >> > query to confirm that it still wants just osd.6.
> >> >> 
> >> >> > use ceph-objectstore-tool to export the pg from osd.6, stop some other
> >> >> > ranodm osd (not one of these ones), import the pg into that osd, and start
> >> >> > again.  once it is up, 'ceph osd lost 6'.  the pg *should* peer at that
> >> >> > point.  repeat with the same basic process with the other pg.
> >> >> 
> >> >> Here is output from ceph-objectstore-tool - also didn't success:
> >> >> 
> >> >> https://pastebin.com/7XGAHdKH
> >> 
> >> > Hmm, btrfs:
> >> 
> >> > 2017-05-24 23:28:58.547456 7f500948e940 -1 
> >> > filestore(/var/lib/ceph/osd/ceph-84) ERROR: 
> >> > /var/lib/ceph/osd/ceph-84/current/nosnap exists, not rolling back to avoid
> >> > losing new data
> >> 
> >> > You could try setting --osd-use-stale-snap as suggested.
> >> 
> >> Yes... tried... and I simply get rided of 39GB data...
> 
> > What does "get rided" mean?
> 
> according to this pastebin: https://pastebin.com/QPcpkjg4
> 
> ls -R /var/lib/ceph/osd/ceph-33/current/
> 
> /var/lib/ceph/osd/ceph-33/current/:
> 
> commit_op_seq  omap
> 
> 
> 
> /var/lib/ceph/osd/ceph-33/current/omap:
> 
> 000003.log  CURRENT  LOCK  MANIFEST-000002
> 
> earlier there were same data files.

Okay, sorry I took a while to get back to you.  It looks like I gave 
you bad advice here!  The 'nosnap' files means filestore was 
operating in non-snapshotting mode, and the --osd-use-stale-snap 
warning that it would lose data was real... it rolled back to an empty 
state and threw out the data on the device.  :( :(  I'm *very* sorry about 
this!  I haven't looked at or worked with the btrfs mode is ages (we 
don't recommend it and almost nobody uses it) but I should have been 
paying close attention.

What is the state of the cluster now?

sage
--8323329-1540986057-1496150188=:3646--
