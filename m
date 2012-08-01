From: <Eric_YH_Chen@wiwynn.com>
Subject: RE: The cluster do not aware some osd are disappear
Date: Wed, 1 Aug 2012 01:07:01 +0000
Message-ID: <60E83269D669544E8069A09CB69135EA012278@GDC-CLDMBX-P02.whq.wistron>
References: <60E83269D669544E8069A09CB69135EA011D62@GDC-CLDMBX-P02.whq.wistron>
 <5018515D.7000909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw2.wistron.com ([220.128.89.22]:50769 "EHLO
	TWNHUMSW2.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961Ab2HABHC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 21:07:02 -0400
In-Reply-To: <5018515D.7000909@inktank.com>
Content-Language: zh-TW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

Hi, Josh:

I do not assign the crushmap by myself, I use the default setting.
And after I reboot the server, I cannot reproduce this situation. 
The heartbeat check works fine when one of the server not available.


-----Original Message-----
From: Josh Durgin [mailto:josh.durgin@inktank.com] 
Sent: Wednesday, August 01, 2012 5:43 AM
To: Eric YH Chen/WYHQ/Wiwynn
Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WYHQ/Wiwynn; Victor CY Chang/WYHQ/Wiwynn
Subject: Re: The cluster do not aware some osd are disappear

On 07/31/2012 12:48 AM, Eric_YH_Chen@wiwynn.com wrote:
> Dear All:
>
> My Environment:  two servers, and 12 hard-disk on each server.
>                   Version: Ceph 0.48, Kernel: 3.2.0-27
>
> We create a ceph cluster with 24 osd, 3 monitors
> Osd.0 ~ osd.11 is on server1
> Osd.12 ~ osd.23 is on server2
> Mon.0 is on server1
> Mon.1 is on server2
> Mon.2 is on server3 which has no osd
>
> When I turn off the network of server1, we expect that server2 would aware 12 osd (on server 1) disappear.
> However, when I type ceph -s, it still show 24 osd there.

There's a grace period before osds are marked down by their heartbeat peers (configured by osd_heartbeat_grace), which is 20 seconds by default. This avoids unnecessary data movement from short-lived issues.

> And from the log of osd.0 and osd.11, we can find heartbeat check on server1, but not on server2.
> What happened to server2? Can we restart the heartbeat server? Thanks!

There's no separate heartbeat server, it's a thread in the osd. If the heartbeat thread stopped, the process would exit. If waiting longer doesn't trigger the heartbeat failures, your crushmap might not be separating peers onto different hosts correctly. OSDs heartbeat with their peers.

Josh

> root@wistor-002:~# ceph -s
>     health HEALTH_WARN 1 mons down, quorum 1,2 008,009
>     monmap e1: 3 mons at {006=192.168.200.84:6789/0,008=192.168.200.86:6789/0,009=192.168.200.87:6789/0}, election epoch 522, quorum 1,2 008,009
>     osdmap e1388: 24 osds: 24 up, 24 in
>      pgmap v288663: 4608 pgs: 4608 active+clean; 257 GB data, 988 GB used, 20214 GB / 22320 GB avail
>     mdsmap e1: 0/0/1 up
>
> log of ceph -w (we turn of server1 arround 15:20, that cause the new 
> monitor election)
> 2012-07-31 15:21:25.966572 mon.0 [INF] pgmap v288658: 4608 pgs: 4608 
> active+clean; 257 GB data, 988 GB used, 20214 GB / 22320 GB avail
> 2012-07-31 15:20:10.400566 mon.1 [INF] mon.008 calling new monitor 
> election
> 2012-07-31 15:21:36.030473 mon.1 [INF] mon.008 calling new monitor 
> election
> 2012-07-31 15:21:36.079772 mon.2 [INF] mon.009 calling new monitor 
> election
> 2012-07-31 15:21:46.102587 mon.1 [INF] mon.008@1 won leader election 
> with quorum 1,2
> 2012-07-31 15:21:46.273253 mon.1 [INF] pgmap v288659: 4608 pgs: 4608 
> active+clean; 257 GB data, 988 GB used, 20214 GB / 22320 GB avail
> 2012-07-31 15:21:46.273379 mon.1 [INF] mdsmap e1: 0/0/1 up
> 2012-07-31 15:21:46.273495 mon.1 [INF] osdmap e1388: 24 osds: 24 up, 
> 24 in
> 2012-07-31 15:21:46.273814 mon.1 [INF] monmap e1: 3 mons at 
> {006=192.168.200.84:6789/0,008=192.168.200.86:6789/0,009=192.168.200.8
> 7:6789/0}
> 2012-07-31 15:21:46.587679 mon.1 [INF] pgmap v288660: 4608 pgs: 4608 
> active+clean; 257 GB data, 988 GB used, 20214 GB / 22320 GB avail
> 2012-07-31 15:22:01.245813 mon.1 [INF] pgmap v288661: 4608 pgs: 4608 
> active+clean; 257 GB data, 988 GB used, 20214 GB / 22320 GB avail
> 2012-07-31 15:22:33.970838 mon.1 [INF] pgmap v288662: 4608 pgs: 4608 
> active+clean; 257 GB data, 988 GB used, 20214 GB / 22320 GB avail
>
> Log of osd.0 (on server 1)
> 2012-07-31 15:20:25.309264 7fdc06470700  0 -- 
> 192.168.200.81:6825/12162 >> 192.168.200.82:6840/8772 pipe(0x4dbea00 
> sd=52 pgs=0 cs=0 l=0).accept connect_seq 0 vs existing 0 state 1
> 2012-07-31 15:20:25.310887 7fdc1c551700  0 -- 
> 192.168.200.81:6825/12162 >> 192.168.200.82:6833/15570 pipe(0x4dbec80 
> sd=51 pgs=0 cs=0 l=0).accept connect_seq 0 vs existing 0 state 1
> 2012-07-31 15:21:46.861458 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.12 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861496 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.13 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861506 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.14 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861514 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.15 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861522 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.16 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861530 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.17 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861538 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.18 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861546 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.19 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861556 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.20 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861576 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.21 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861609 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.22 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
> 2012-07-31 15:21:46.861618 7fdc14e9d700 -1 osd.0 1388 heartbeat_check: 
> no reply from osd.23 since 2012-07-31 15:21:26.770108 (cutoff 
> 2012-07-31 15:21:26.861458)
>
> Log of osd.12 (on server 2)
> 2012-07-31 15:20:31.475815 7f9eac5ba700  0 osd.12 1387 pg[2.16f( v 
> 1356'10485 (465'9480,1356'10485] n=42 ec=1 les/c 1387/1387 
> 1383/1383/1383) [12,0] r=0 lpr=1383 mlcod 0'0 active+clean] watch: 
> oi.user_version=45
> 2012-07-31 15:20:31.475817 7f9eabdb9700  0 osd.12 1387 pg[2.205( v 
> 1282'26975 (1254'25973,1282'26975] n=86 ec=1 les/c 1387/1387 
> 1383/1383/1383) [12,9] r=0 lpr=1383 lcod 0'0 mlcod 0'0 active+clean] 
> watch: ctx->obc=0x5838dc0 cookie=9 oi.version=26975 
> ctx->at_version=1387'26976
> 2012-07-31 15:20:31.475837 7f9eabdb9700  0 osd.12 1387 pg[2.205( v 
> 1282'26975 (1254'25973,1282'26975] n=86 ec=1 les/c 1387/1387 
> 1383/1383/1383) [12,9] r=0 lpr=1383 lcod 0'0 mlcod 0'0 active+clean] 
> watch: oi.user_version=1043
> 2012-07-31 15:35:31.512306 7f9ea6f8e700  0 -- 192.168.200.82:6840/8772 
> >> 192.168.200.81:6847/18544 pipe(0x4633780 sd=41 pgs=82 cs=1 
> l=0).fault with nothing to send, going to standby
> 2012-07-31 15:35:31.512342 7f9ea7897700  0 -- 192.168.200.82:6840/8772 
> >> 192.168.200.81:6853/19122 pipe(0x4a68280 sd=43 pgs=83 cs=1 
> l=0).fault with nothing to send, going to standby
> 2012-07-31 15:35:31.579095 7f9ea6c8b700  0 -- 192.168.200.82:6840/8772 
> >> 192.168.200.81:6809/17957 pipe(0x6309c80 sd=55 pgs=80 cs=1 
> l=0).fault with nothing to send, going to standby
> 2012-07-31 15:35:31.592368 7f9ea7a99700  0 -- 192.168.200.82:6840/8772 
> >> 192.168.200.81:6840/12656 pipe(0x4b44780 sd=44 pgs=104 cs=1 
> l=0).fault with nothing to send, going to standby
> 2012-07-31 15:35:31.596484 7f9ea94b3700  0 -- 192.168.200.82:6840/8772 
> >> 192.168.200.81:6836/18275 pipe(0x4cfb780 sd=48 pgs=76 cs=1 
> l=0).fault with nothing to send, going to standby
> 2012-07-31 15:35:31.720803 7f9ea5a79700  0 -- 192.168.200.82:6840/8772 
> >> 192.168.200.81:6838/12409 pipe(0xeb4000 sd=38 pgs=105 cs=1 
> l=0).fault with nothing to send, going to standby
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>

