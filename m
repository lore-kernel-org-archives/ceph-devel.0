From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: Problem with query and any operation on PGs
Date: Tue, 23 May 2017 23:43:31 +0200
Message-ID: <1075363645.20170523234331@tlen.pl>
References: <175484591.20170523135449@tlen.pl> <483467685.20170523144818@tlen.pl>   
  <alpine.DEB.2.11.1705231415400.3646@piezo.novalocal>
  <1464688590.20170523185052@tlen.pl>
  <alpine.DEB.2.11.1705231738520.3646@piezo.novalocal>
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.148]:52694 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765095AbdEWVu0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 May 2017 17:50:26 -0400
In-Reply-To: <alpine.DEB.2.11.1705231738520.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Cze¶æ,

> On Tue, 23 May 2017, £ukasz Chrustek wrote:
>> I'm  not  sleeping for over 30 hours, and still can't find solution. I
>> did,      as      You      wrote,     but     turning     off     this
>> (https://pastebin.com/1npBXeMV) osds didn't resolve issue...

> The important bit is:

>             "blocked": "peering is blocked due to down osds",
>             "down_osds_we_would_probe": [
>                 6,
>                 10,
>                 33,
>                 37,
>                 72
>             ],
>             "peering_blocked_by": [
>                 {
>                     "osd": 6,
>                     "current_lost_at": 0,
>                     "comment": "starting or marking this osd lost may let
> us proceed"
>                 },
>                 {
>                     "osd": 10,
>                     "current_lost_at": 0,
>                     "comment": "starting or marking this osd lost may let
> us proceed"
>                 },
>                 {
>                     "osd": 37,
>                     "current_lost_at": 0,
>                     "comment": "starting or marking this osd lost may let
> us proceed"
>                 },
>                 {
>                     "osd": 72,
>                     "current_lost_at": 113771,
>                     "comment": "starting or marking this osd lost may let
> us proceed"
>                 }
>             ]
>         },

> Are any of those OSDs startable?

They were all up and running - but I decided to shut them down and out
them  from  ceph, now it looks like ceph working ok, but still two PGs
are in down state, how to get rid of it ?

ceph health detail
HEALTH_WARN 2 pgs down; 2 pgs peering; 2 pgs stuck inactive
pg 1.165 is stuck inactive since forever, current state down+remapped+peering, last acting [38,48]
pg 1.60 is stuck inactive since forever, current state down+remapped+peering, last acting [66,40]
pg 1.60 is down+remapped+peering, acting [66,40]
pg 1.165 is down+remapped+peering, acting [38,48]
[root@cc1 ~]# ceph -s
    cluster 8cdfbff9-b7be-46de-85bd-9d49866fcf60
     health HEALTH_WARN
            2 pgs down
            2 pgs peering
            2 pgs stuck inactive
     monmap e1: 3 mons at {cc1=192.168.128.1:6789/0,cc2=192.168.128.2:6789/0,cc3=192.168.128.3:6789/0}
            election epoch 872, quorum 0,1,2 cc1,cc2,cc3
     osdmap e115175: 100 osds: 88 up, 86 in; 2 remapped pgs
      pgmap v67583069: 3520 pgs, 17 pools, 26675 GB data, 4849 kobjects
            76638 GB used, 107 TB / 182 TB avail
                3515 active+clean
                   3 active+clean+scrubbing+deep
                   2 down+remapped+peering
  client io 0 B/s rd, 869 kB/s wr, 14 op/s rd, 113 op/s wr

-- 
Regards
 £ukasz Chrustek

