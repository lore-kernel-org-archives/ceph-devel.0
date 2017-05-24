From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: Problem with query and any operation on PGs
Date: Wed, 24 May 2017 17:24:19 +0200
Message-ID: <84229753.20170524172419@tlen.pl>
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
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.158]:43911 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937215AbdEXPYY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 May 2017 11:24:24 -0400
In-Reply-To: <alpine.DEB.2.11.1705241510290.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello,

>> 
>> >> osd 10, 37, 72 are startable
>> 
>> > With those started, I'd repeat the original sequence and get a fresh pg
>> > query to confirm that it still wants just osd.6.
>> 
>> You  mean about procedure with loop and taking down OSDs, which broken
>> PGs are pointing to ?
>> pg 1.60 is down+remapped+peering, acting [66,40]
>> pg 1.165 is down+peering, acting [67,88,48]
>> 
>> for pg 1.60 <--> 66 down, then in loop check pg query ?

> Right.

>> > use ceph-objectstore-tool to export the pg from osd.6, stop some other
>> > ranodm osd (not one of these ones), import the pg into that osd, and start
>> > again.  once it is up, 'ceph osd lost 6'.  the pg *should* peer at that
>> > point.  repeat with the same basic process with the other pg.
>> 
>> I have already did 'ceph osd lost 6', do I need to do this once again ?

> Hmm not sure, if the OSD is empty then there is no harm in doing it again.
> Try that first since it might resolve it.  If not, do the query loop 
> above.
[root@cc1 ~]# ceph osd lost 6 --yes-i-really-mean-it
marked osd lost in epoch 113414
[root@cc1 ~]#
[root@cc1 ~]# ceph -s
    cluster 8cdfbff9-b7be-46de-85bd-9d49866fcf60
     health HEALTH_WARN
            2 pgs down
            2 pgs peering
            2 pgs stuck inactive
     monmap e1: 3 mons at {cc1=192.168.128.1:6789/0,cc2=192.168.128.2:6789/0,cc3=192.168.128.3:6789/0}
            election epoch 872, quorum 0,1,2 cc1,cc2,cc3
     osdmap e115449: 100 osds: 88 up, 86 in; 1 remapped pgs
      pgmap v67646402: 4032 pgs, 18 pools, 26733 GB data, 4862 kobjects
            76759 GB used, 107 TB / 182 TB avail
                4030 active+clean
                   1 down+peering
                   1 down+remapped+peering
  client io 57154 kB/s rd, 1189 kB/s wr, 95 op/s


There is no action after marking again this osd as lost.


-- 
Regards,
 £ukasz Chrustek

