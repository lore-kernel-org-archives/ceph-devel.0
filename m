From: Sage Weil <sage@newdream.net>
Subject: Re: problem with removing osd
Date: Thu, 29 Dec 2016 22:18:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612292216160.10615@piezo.novalocal>
References: <16310616780.20161229160718@tlen.pl>       <alpine.DEB.2.11.1612291908472.10615@piezo.novalocal>    <109878557.20161229212030@tlen.pl>    <alpine.DEB.2.11.1612292025280.10615@piezo.novalocal>   <1498014063.20161229214621@tlen.pl>  
 <alpine.DEB.2.11.1612292048580.10615@piezo.novalocal>  <1039341611.20161229215518@tlen.pl>  <alpine.DEB.2.11.1612292137550.10615@piezo.novalocal> <10710520745.20161229230211@tlen.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-715822131-1483049884=:10615"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56893 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbcL2WSF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2016 17:18:05 -0500
In-Reply-To: <10710520745.20161229230211@tlen.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-715822131-1483049884=:10615
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

On Thu, 29 Dec 2016, £ukasz Chrustek wrote:
> Hi,
> 
> Thank  You  very  much for analize and the file ! I had similar :) but
> wasn't sure if it wan't distroy something in cluster.
> 
> > The encoded tree bucket -11 had bad values.  I don't really trust the tree
> > bucket code in crush... it's not well tested (and is a poor balance 
> > computation and efficiency anyway).  We should probably try to remove tree
> > entirely.
> 
> > I've attached a fixed map that you can inject with
> 
> >  ceph osd setcrushmap -i <filename>
> 
> Now it works, and also ceph osd crush dump -f json-pretty runs OK.

Great news!
 
> > Bucket -11 is now empty; not sure what was supposed to be in it.
> 
> this server will be reinstalled, there where three osds.
> 
> > I suggest switching all of your tree buckets over to straw2 as soon as
> > possible.  Note that this will result in some rebalancing.  You could do
> > it one bucket a time if that's concerning.
> 
> OK,  changing  alg  to straw2 will rebalance ale PGs on all nodes ?

For any bucket you change from tree -> straw2, you'll see PGs shuffle 
between the children of that bucket.  So for hosts, you'll see data move 
between the disks.  And fixing ssd-intel-s3700 will shuffle data between 
hosts.

I'd also switch the straw buckets to straw2, although that will move a 
comparatively small amount of data.

sage

--8323329-715822131-1483049884=:10615--
