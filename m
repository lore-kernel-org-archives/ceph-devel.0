From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: Problem with query and any operation on PGs
Date: Wed, 24 May 2017 19:07:09 +0200
Message-ID: <1412483127.20170524190709@tlen.pl>
References: <175484591.20170523135449@tlen.pl> <483467685.20170523144818@tlen.pl>           
   <alpine.DEB.2.11.1705231415400.3646@piezo.novalocal>     
  <1464688590.20170523185052@tlen.pl>     
  <alpine.DEB.2.11.1705231738520.3646@piezo.novalocal>    
  <1075363645.20170523234331@tlen.pl>   
  <alpine.DEB.2.11.1705232146500.3646@piezo.novalocal>   
  <135176900.20170524151952@tlen.pl>   
  <alpine.DEB.2.11.1705241335190.3646@piezo.novalocal>  
  <1203308391.20170524155848@tlen.pl>  
  <alpine.DEB.2.11.1705241401260.3646@piezo.novalocal>
  <379087365.20170524161815@tlen.pl>
  <alpine.DEB.2.11.1705241444150.3646@piezo.novalocal>
  <419974552.20170524170005@tlen.pl>
  <alpine.DEB.2.11.1705241510290.3646@piezo.novalocal>
  <806057225.20170524175447@tlen.pl> <501939192.20170524180213@tlen.pl>
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.158]:42298 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752950AbdEXRHS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 May 2017 13:07:18 -0400
In-Reply-To: <501939192.20170524180213@tlen.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org



>> And  now  it  is very weird.... I made osd.37 up, and loop
>> while true;do; ceph tell 1.165 query ;done

> Here  need  to  explain  more  - all I did was start ceph-osd id=37 on
> storage node, in ceph osd tree this osd osd is marked as out:


> -17  21.49995     host stor8
>  22   1.59999         osd.22            up  1.00000          1.00000 
>  23   1.59999         osd.23            up  1.00000          1.00000 
>  36   2.09999         osd.36            up  1.00000          1.00000 
>  37   2.09999         osd.37            up        0          1.00000 
>  38   2.50000         osd.38            up  1.00000          1.00000 
>  39   2.50000         osd.39            up  1.00000          1.00000 
>  40   2.50000         osd.40            up        0          1.00000 
>  41   2.50000         osd.41          down        0          1.00000 
>  42   2.50000         osd.42            up  1.00000          1.00000 
>  43   1.59999         osd.43            up  1.00000          1.00000

>  after start of this osd, ceph tell 1.165 query  worked only for one call of this command
>> catch this:

>> https://pastebin.com/zKu06fJn

here is for pg 1.60:

https://pastebin.com/Xuk5iFXr

>> Can You tell, what is wrong now ?


>>>> > use ceph-objectstore-tool to export the pg from osd.6, stop some other
>>>> > ranodm osd (not one of these ones), import the pg into that osd, and start
>>>> > again.  once it is up, 'ceph osd lost 6'.  the pg *should* peer at that
>>>> > point.  repeat with the same basic process with the other pg.
>>>> 
>>>> I have already did 'ceph osd lost 6', do I need to do this once again ?

>>> Hmm not sure, if the OSD is empty then there is no harm in doing it again.
>>> Try that first since it might resolve it.  If not, do the query loop 
>>> above.

>>> s









-- 
Pozdrowienia,
 £ukasz Chrustek

