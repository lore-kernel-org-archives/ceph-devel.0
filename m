From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: Problem with query and any operation on PGs
Date: Wed, 24 May 2017 23:38:42 +0200
Message-ID: <2910218531.20170524233842@tlen.pl>
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
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.140]:12698 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033246AbdEXVim (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 May 2017 17:38:42 -0400
In-Reply-To: <alpine.DEB.2.11.1705241444150.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello,

>>
>> > This
>> 
>> osd 6 - isn't startable

> Disk completely 100% dead, or just borken enough that ceph-osd won't 
> start?  ceph-objectstore-tool can be used to extract a copy of the 2 pgs
> from this osd to recover any important writes on that osd.

>> osd 10, 37, 72 are startable

> With those started, I'd repeat the original sequence and get a fresh pg
> query to confirm that it still wants just osd.6.

> use ceph-objectstore-tool to export the pg from osd.6, stop some other
> ranodm osd (not one of these ones), import the pg into that osd, and start
> again.  once it is up, 'ceph osd lost 6'.  the pg *should* peer at that
> point.  repeat with the same basic process with the other pg.

Here is output from ceph-objectstore-tool - also didn't success:

https://pastebin.com/7XGAHdKH


-- 
Pozdrowienia,
 £ukasz Chrustek

