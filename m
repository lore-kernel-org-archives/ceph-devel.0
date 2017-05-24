From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: Problem with query and any operation on PGs
Date: Wed, 24 May 2017 21:47:38 +0200
Message-ID: <1241712267.20170524214738@tlen.pl>
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
  <1412483127.20170524190709@tlen.pl>
  <alpine.DEB.2.11.1705241716000.3646@piezo.novalocal>
  <1614890646.20170524192853@tlen.pl>
  <alpine.DEB.2.11.1705241815040.3646@piezo.novalocal>
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.140]:53588 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968123AbdEXTyW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 May 2017 15:54:22 -0400
In-Reply-To: <alpine.DEB.2.11.1705241815040.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello,

> On Wed, 24 May 2017, £ukasz Chrustek wrote:
>> Cze¶æ,
>> 
>> > On Wed, 24 May 2017, £ukasz Chrustek wrote:
>> >> 
>> >> >> And  now  it  is very weird.... I made osd.37 up, and loop
>> >> >> while true;do; ceph tell 1.165 query ;done
>> >> 
>> >> > Here  need  to  explain  more  - all I did was start ceph-osd id=37 on
>> >> > storage node, in ceph osd tree this osd osd is marked as out:
>> >> 
>> >> 
>> >> > -17  21.49995     host stor8
>> >> >  22   1.59999         osd.22            up  1.00000          1.00000 
>> >> >  23   1.59999         osd.23            up  1.00000          1.00000 
>> >> >  36   2.09999         osd.36            up  1.00000          1.00000 
>> >> >  37   2.09999         osd.37            up        0          1.00000 
>> >> >  38   2.50000         osd.38            up  1.00000          1.00000 
>> >> >  39   2.50000         osd.39            up  1.00000          1.00000 
>> >> >  40   2.50000         osd.40            up        0          1.00000 
>> >> >  41   2.50000         osd.41          down        0          1.00000 
>> >> >  42   2.50000         osd.42            up  1.00000          1.00000 
>> >> >  43   1.59999         osd.43            up  1.00000          1.00000
>> >> 
>> >> >  after start of this osd, ceph tell 1.165 query  worked only for one call of this command
>> >> >> catch this:
>> >> 
>> >> >> https://pastebin.com/zKu06fJn
>> >> 
>> >> here is for pg 1.60:
>> >> 
>> >> https://pastebin.com/Xuk5iFXr
>> 
>> > Look at the bottom, after it says
>> 
>> >             "blocked": "peering is blocked due to down osds",
>> 
>> > Did the 1.165 pg recover?
>> 
>> No it didn't:
>> 
>> [root@cc1 ~]# ceph health detail
>> HEALTH_WARN 1 pgs down; 1 pgs incomplete; 1 pgs peering; 2 pgs stuck inactive
>> pg 1.165 is stuck inactive since forever, current state incomplete, last acting [67,88,48]
>> pg 1.60 is stuck inactive since forever, current state down+remapped+peering, last acting [68]
>> pg 1.60 is down+remapped+peering, acting [68]
>> pg 1.165 is incomplete, acting [67,88,48]
>> [root@cc1 ~]#

> Hrm.

>  ceph daemon osd.67 config set debug_osd 20
>  ceph daemon osd.67 config set debug_ms 1
>  ceph osd down 67

> and capture the log resulting log segment, then post it with 
> ceph-post-file.

args: -- /var/log/ceph/ceph-osd.67.log
/usr/bin/ceph-post-file: upload tag 05a02f14-8fd6-43da-9b9c-e42cd1fce560
/usr/bin/ceph-post-file: user: root@stor3
/usr/bin/ceph-post-file: will upload file /var/log/ceph/ceph-osd.67.log
sftp> mkdir post/05a02f14-8fd6-43da-9b9c-e42cd1fce560_root@stor3_8612f2d9-bb31-4d5e-b3e7-3722f8d13314
sftp> cd post/05a02f14-8fd6-43da-9b9c-e42cd1fce560_root@stor3_8612f2d9-bb31-4d5e-b3e7-3722f8d13314
sftp> put /tmp/tmp.rggR3suNMt user
sftp> put /var/log/ceph/ceph-osd.67.log

/usr/bin/ceph-post-file: copy the upload id below to share with a dev:

ceph-post-file: 05a02f14-8fd6-43da-9b9c-e42cd1fce560

-- 
Regards,,
 £ukasz Chrustek

