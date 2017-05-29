From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: Problem with query and any operation on PGs
Date: Mon, 29 May 2017 17:31:18 +0200
Message-ID: <126973081.20170529173118@tlen.pl>
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
  <2910218531.20170524233842@tlen.pl>  
  <alpine.DEB.2.11.1705242149300.3646@piezo.novalocal>
  <804507840.20170525000904@tlen.pl>
  <alpine.DEB.2.11.1705242227320.3646@piezo.novalocal>
  <154794248.20170525004623@tlen.pl>
  <alpine.DEB.2.11.1705250200270.3646@piezo.novalocal>
  <1316202582.20170525132254@tlen.pl>
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.148]:58386 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbdE2PbY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 29 May 2017 11:31:24 -0400
In-Reply-To: <1316202582.20170525132254@tlen.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello,

> ./omap:
> 000011.log  CURRENT  LOCK  LOG  LOG.old  MANIFEST-000010

> after running ceph-objectstore-tool it is:

> ceph pg dump_stuck
> ok
> pg_stat state   up      up_primary      acting  acting_primary
> 1.39    active+remapped+backfilling     [11,4,39]       11      [5,39,70]       5
> 1.1a9   active+remapped+backfilling     [11,30,3]       11      [0,30,8]        0
> 1.b     active+remapped+backfilling     [11,36,94]      11      [38,97,70]      38
> 1.12f   active+remapped+backfilling     [14,11,47]      14      [14,5,69]       14
> 1.1d2   active+remapped+backfilling     [11,2,38]       11      [0,36,49]       0
> 1.133   active+remapped+backfilling     [42,11,83]      42      [42,89,21]      42
> 40.69   stale+active+undersized+degraded        [48]    48      [48]    48
> 1.9d    active+remapped+backfilling     [39,2,11]       39      [39,2,86]       39
> 1.a2    active+remapped+backfilling     [11,12,34]      11      [14,35,95]      14
> 1.10a   active+remapped+backfilling     [11,2,87]       11      [1,87,81]       1
> 1.70    active+remapped+backfilling     [14,39,11]      14      [14,39,4]       14
> 1.60    down+remapped+peering   [83,69,68]      83      [9]     9
> 1.eb    active+remapped+backfilling     [11,18,53]      11      [14,53,69]      14
> 1.8d    active+remapped+backfilling     [11,0,30]       11      [36,0,30]       36
> 1.118   active+remapped+backfilling     [34,11,12]      34      [34,20,86]      34
> 1.121   active+remapped+backfilling     [43,11,35]      43      [43,35,2]       43
> 1.177   active+remapped+backfilling     [14,1,11]       14      [14,1,38]       14
> 1.17c   active+remapped+backfilling     [5,94,11]       5       [5,94,7]        5
> 1.16d   active+remapped+backfilling     [96,11,53]      96      [96,52,9]       96
> 1.19a   active+remapped+backfilling     [11,0,14]       11      [0,17,35]       0
> 1.165   down+peering    [39,55,82]      39      [39,55,82]      39
> 1.1a    active+remapped+backfilling     [36,52,11]      36      [36,52,96]      36
> 1.e7    active+remapped+backfilling     [11,35,44]      11      [34,44,9]       34


> Is there any chance to rescue this cluster ?

I  have  now turned off all OSDs and MONs, after that I turn on two of
three MONs to make qourum. On all osds all ceph processes are off. But
ceph osd tree see old/false data: https://pastebin.com/pVGLxAPs

Why  ceph doesn't see that all osds are down ? What can him block like
this ?



-- 
Regards,
 £ukasz Chrustek

