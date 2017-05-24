From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: Problem with query and any operation on PGs
Date: Wed, 24 May 2017 17:07:02 +0200
Message-ID: <1145011826.20170524170702@tlen.pl>
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
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.158]:39501 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966493AbdEXPHF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 May 2017 11:07:05 -0400
In-Reply-To: <419974552.20170524170005@tlen.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org






> it is all I get for this osd in logs, when I try to start it.

>>> osd 10, 37, 72 are startable

>> With those started, I'd repeat the original sequence and get a fresh pg
>> query to confirm that it still wants just osd.6.

> You  mean about procedure with loop and taking down OSDs, which broken
> PGs are pointing to ?
> pg 1.60 is down+remapped+peering, acting [66,40]
> pg 1.165 is down+peering, acting [67,88,48]

> for pg 1.60 <--> 66 down, then in loop check pg query ?



>> use ceph-objectstore-tool to export the pg from osd.6, stop some other
>> ranodm osd (not one of these ones), import the pg into that osd, and start
>> again.  once it is up, 'ceph osd lost 6'.  the pg *should* peer at that
>> point.  repeat with the same basic process with the other pg.

> I have already did 'ceph osd lost 6', do I need to do this once again ?

/dev/sdb1       3,7T   34M  3,7T   1% /var/lib/ceph/osd/ceph-6

this disk have no data, they where migrated, when this osd was able to
be up.

-- 
Regards,
 £ukasz Chrustek

