From: Sage Weil <sage@newdream.net>
Subject: Re: Problem with query and any operation on PGs
Date: Wed, 24 May 2017 17:16:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705241716000.3646@piezo.novalocal>
References: <175484591.20170523135449@tlen.pl> <483467685.20170523144818@tlen.pl>              <alpine.DEB.2.11.1705231415400.3646@piezo.novalocal>       <1464688590.20170523185052@tlen.pl>       <alpine.DEB.2.11.1705231738520.3646@piezo.novalocal>     
 <1075363645.20170523234331@tlen.pl>     <alpine.DEB.2.11.1705232146500.3646@piezo.novalocal>     <135176900.20170524151952@tlen.pl>     <alpine.DEB.2.11.1705241335190.3646@piezo.novalocal>    <1203308391.20170524155848@tlen.pl>   
 <alpine.DEB.2.11.1705241401260.3646@piezo.novalocal>  <379087365.20170524161815@tlen.pl>   <alpine.DEB.2.11.1705241444150.3646@piezo.novalocal>  <419974552.20170524170005@tlen.pl>  <alpine.DEB.2.11.1705241510290.3646@piezo.novalocal>  <806057225.20170524175447@tlen.pl>
 <501939192.20170524180213@tlen.pl> <1412483127.20170524190709@tlen.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-195960002-1495646189=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46251 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdEXRQa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 13:16:30 -0400
In-Reply-To: <1412483127.20170524190709@tlen.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-195960002-1495646189=:3646
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

On Wed, 24 May 2017, £ukasz Chrustek wrote:
> 
> >> And  now  it  is very weird.... I made osd.37 up, and loop
> >> while true;do; ceph tell 1.165 query ;done
> 
> > Here  need  to  explain  more  - all I did was start ceph-osd id=37 on
> > storage node, in ceph osd tree this osd osd is marked as out:
> 
> 
> > -17  21.49995     host stor8
> >  22   1.59999         osd.22            up  1.00000          1.00000 
> >  23   1.59999         osd.23            up  1.00000          1.00000 
> >  36   2.09999         osd.36            up  1.00000          1.00000 
> >  37   2.09999         osd.37            up        0          1.00000 
> >  38   2.50000         osd.38            up  1.00000          1.00000 
> >  39   2.50000         osd.39            up  1.00000          1.00000 
> >  40   2.50000         osd.40            up        0          1.00000 
> >  41   2.50000         osd.41          down        0          1.00000 
> >  42   2.50000         osd.42            up  1.00000          1.00000 
> >  43   1.59999         osd.43            up  1.00000          1.00000
> 
> >  after start of this osd, ceph tell 1.165 query  worked only for one call of this command
> >> catch this:
> 
> >> https://pastebin.com/zKu06fJn
> 
> here is for pg 1.60:
> 
> https://pastebin.com/Xuk5iFXr

Look at the bottom, after it says

            "blocked": "peering is blocked due to down osds",

Did the 1.165 pg recover?

sage
--8323329-195960002-1495646189=:3646--
