From: Wido den Hollander <wido@42on.com>
Subject: Re: OSD not coming back up again
Date: Thu, 11 Aug 2016 13:02:03 +0200 (CEST)
Message-ID: <301395781.2383.1470913324040@ox.pcextreme.nl>
References: <bdb93e87-8338-e485-a68d-f988d00f6785@digiware.nl>
 <453729567.2335.1470896803201@ox.pcextreme.nl>
 <a8d8e5cf-bfdb-6f73-e2a5-a2cc8a3e02af@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:38677 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcHKLCH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 07:02:07 -0400
In-Reply-To: <a8d8e5cf-bfdb-6f73-e2a5-a2cc8a3e02af@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>


> Op 11 augustus 2016 om 10:46 schreef Willem Jan Withagen <wjw@digiware.nl>:
> 
> 
> On 11-8-2016 08:26, Wido den Hollander wrote:
> > 
> >> Op 11 augustus 2016 om 2:40 schreef Willem Jan Withagen <wjw@digiware.nl>:
> >>
> >>
> >> Hi
> >>
> >> During testing with cephtool-test-mon.sh
> >>
> >> 3 OSDs are started, and then the code executes:
> >> ====
> >>   ceph osd set noup
> >>   ceph osd down 0
> >>   ceph osd dump | grep 'osd.0 down'
> >>   ceph osd unset noup
> >> ====
> >>
> >> And in 1000 secs osd.0 is not coming back up.
> >>
> >> Below some details, but where should I start looking?
> >>
> > Can you use the admin socket to query osd.0?
> > 
> > ceph daemon osd.0 status
> > 
> > What does that tell you?
> 
> Good suggestion:
> {
>     "cluster_fsid": "0f7dc8d3-7010-4094-aa9a-a0694e7c05a6",
>     "osd_fsid": "621c9b39-b8ea-412a-a9db-115c97eafe7d",
>     "whoami": 0,
>     "state": "waiting_for_healthy",
>     "oldest_map": 1,
>     "newest_map": 176,
>     "num_pgs": 8
> }
> 
> Right before setting the osd to down, the newest map is 173.
> So some maps have been exchanged....
> 
> How does the OSD decide that it is healthy?
> If it gets peer (ping) messages that is is up?
> 

Not 100% sure, but waiting for healthy is something I haven't seen before.

Is it incrementing the newest_map when the cluster advances?

> > Maybe try debug_osd = 20
> 
> But then still I need to know what to look for, since 20 generates
> serious output.
> 
True, it will. But I don't know exactly what to look for. debug_osd = 20 might reveal more information there.

It might be a very simple log line which tells you what is going on.

Wido

> Thanx,
> --WjW
> 
> > 
> > Wido
> > 
> >> Thanx
> >> --WjW
> >>
> >>
> >> ceph -s gives:
> >>
> >>     cluster 9b2500f8-44fb-40d1-91bc-ed522e9db5c6
> >>      health HEALTH_WARN
> >>             8 pgs degraded
> >>             8 pgs stuck unclean
> >>             8 pgs undersized
> >>      monmap e1: 3 mons at
> >> {a=127.0.0.1:7202/0,b=127.0.0.1:7203/0,c=127.0.0.1:7204/0}
> >>             election epoch 6, quorum 0,1,2 a,b,c
> >>      osdmap e179: 3 osds: 2 up, 2 in; 8 remapped pgs
> >>             flags sortbitwise,require_jewel_osds,require_kraken_osds
> >>       pgmap v384: 8 pgs, 1 pools, 0 bytes data, 0 objects
> >>             248 GB used, 198 GB / 446 GB avail
> >>                    8 active+undersized+degraded
> >>
> >> And the pgmap version is slowly growing.....
> >>
> >> This set of lines is repeated over and over in the osd.0.log
> >>
> >> 2016-08-11 02:31:48.710152 b2f4d00  1 -- 127.0.0.1:0/25528 -->
> >> 127.0.0.1:6806/25709 -- osd_ping(ping e175 stamp 2016-08-11
> >> 02:31:48.710144) v2 -- ?+0 0xb42bc00 con 0xb12ba40
> >> 2016-08-11 02:31:48.710188 b2f4d00  1 -- 127.0.0.1:0/25528 -->
> >> 127.0.0.1:6807/25709 -- osd_ping(ping e175 stamp 2016-08-11
> >> 02:31:48.710144) v2 -- ?+0 0xb42cc00 con 0xb12bb20
> >> 2016-08-11 02:31:48.710214 b2f4d00  1 -- 127.0.0.1:0/25528 -->
> >> 127.0.0.1:6810/25910 -- osd_ping(ping e175 stamp 2016-08-11
> >> 02:31:48.710144) v2 -- ?+0 0xb42a400 con 0xb12bc00
> >> 2016-08-11 02:31:48.710240 b2f4d00  1 -- 127.0.0.1:0/25528 -->
> >> 127.0.0.1:6811/25910 -- osd_ping(ping e175 stamp 2016-08-11
> >> 02:31:48.710144) v2 -- ?+0 0xb42c000 con 0xb12c140
> >> 2016-08-11 02:31:48.710604 b412480  1 -- 127.0.0.1:0/25528 <== osd.1
> >> 127.0.0.1:6806/25709 284 ==== osd_ping(ping_reply e179 stamp 2016-08-11
> >> 02:31:48.710144) v2 ==== 47+0+0 (281956571 0 0) 0xb42d800 con 0xb12ba40
> >> 2016-08-11 02:31:48.710665 b486900  1 -- 127.0.0.1:0/25528 <== osd.2
> >> 127.0.0.1:6810/25910 283 ==== osd_ping(ping_reply e179 stamp 2016-08-11
> >> 02:31:48.710144) v2 ==== 47+0+0 (281956571 0 0) 0xb42d200 con 0xb12bc00
> >> 2016-08-11 02:31:48.710683 b412480  1 -- 127.0.0.1:0/25528 <== osd.1
> >> 127.0.0.1:6806/25709 285 ==== osd_ping(you_died e179 stamp 2016-08-11
> >> 02:31:48.710144) v2 ==== 47+0+0 (1545205378 0 0) 0xb42d800 con 0xb12ba40
> >> 2016-08-11 02:31:48.710780 b412000  1 -- 127.0.0.1:0/25528 <== osd.1
> >> 127.0.0.1:6807/25709 284 ==== osd_ping(ping_reply e179 stamp 2016-08-11
> >> 02:31:48.710144) v2 ==== 47+0+0 (281956571 0 0) 0xb42da00 con 0xb12bb20
> >> 2016-08-11 02:31:48.710789 b486900  1 -- 127.0.0.1:0/25528 <== osd.2
> >> 127.0.0.1:6810/25910 284 ==== osd_ping(you_died e179 stamp 2016-08-11
> >> 02:31:48.710144) v2 ==== 47+0+0 (1545205378 0 0) 0xb42d200 con 0xb12bc00
> >> 2016-08-11 02:31:48.710821 b486d80  1 -- 127.0.0.1:0/25528 <== osd.2
> >> 127.0.0.1:6811/25910 283 ==== osd_ping(ping_reply e179 stamp 2016-08-11
> >> 02:31:48.710144) v2 ==== 47+0+0 (281956571 0 0) 0xb42d400 con 0xb12c140
> >> 2016-08-11 02:31:48.710973 b412000  1 -- 127.0.0.1:0/25528 <== osd.1
> >> 127.0.0.1:6807/25709 285 ==== osd_ping(you_died e179 stamp 2016-08-11
> >> 02:31:48.710144) v2 ==== 47+0+0 (1545205378 0 0) 0xb42da00 con 0xb12bb20
> >> 2016-08-11 02:31:48.711028 b486d80  1 -- 127.0.0.1:0/25528 <== osd.2
> >> 127.0.0.1:6811/25910 284 ==== osd_ping(you_died e179 stamp 2016-08-11
> >> 02:31:48.710144) v2 ==== 47+0+0 (1545205378 0 0) 0xb42d400 con 0xb12c140
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
