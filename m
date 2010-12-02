From: Sage Weil <sage@newdream.net>
Subject: Re: crashed+down+peering
Date: Thu, 2 Dec 2010 11:27:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012021126270.1982@cobra.newdream.net>
References: <AANLkTi=qVPB4ouEySHKAbRZLo7YgSyq6MdyY3LkT5JfS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33428 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab0LBTXM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 14:23:12 -0500
In-Reply-To: <AANLkTi=qVPB4ouEySHKAbRZLo7YgSyq6MdyY3LkT5JfS@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

Hi Christian,

On Thu, 2 Dec 2010, Christian Brunner wrote:
> We have simulated the simultanious crash of multiple osds in our
> environment. After starting all the cosd again, we have the following
> situation:
> 
> 2010-12-02 16:18:33.944436    pg v724432: 3712 pgs: 1 active, 3605
> active+clean, 1 crashed+peering, 46 down+peering, 56
> crashed+down+peering, 3 active+clean+inconsistent; 177 GB data, 365 GB
> used, 83437 GB / 83834 GB avail; 1/93704 degraded (0.001%)
> 
> When I set of an "rbd rm" command for one of our rbd volumes, it seems
> to hit the the "crashed+down+peering" pg. After that the command is
> stuck.

The pg isn't active, so any IO will hang until peering completes.  What 
version of the code are you running?  If it's something from unstable 
from the last couple of weeks it's probably related to problems there; 
please upgrade and restart the osds.  If it's the latest and greatest 
'rc', we should look at the logs to see what's going on!

Thanks-
sage

)

 > 
> When I turn on "debug ms = 1" on the client side I can see the
> following messages:
> 
> 2010-12-02 16:24:06.364081 7f7f67c887e0 -- 10.255.0.130:0/7505 -->
> osd14 10.255.0.63:6804/2175 -- osd_op(client97429.0:3
> rb.0.4b.000000000001 [delete] 3.2c79) v1 -- ?+0 0x191c720
> 2010-12-02 16:24:21.358572 7f7f66683710 -- 10.255.0.130:0/7505 -->
> mon1 10.255.0.21:6789/0 -- mon_subscribe({monmap=2+,osdmap=1730}) v1
> -- ?+0 0x7f7f38000a90
> 2010-12-02 16:24:21.358633 7f7f66683710 -- 10.255.0.130:0/7505 -->
> osd14 10.255.0.63:6804/2175 -- ping v1 -- ?+0 0x7f7f38000d30
> 2010-12-02 16:24:21.359298 7f7f67c87710 -- 10.255.0.130:0/7505 <==
> mon1 10.255.0.21:6789/0 10 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0
> (844714770 0 0) 0x7f7f58000d70
> 2010-12-02 16:24:26.358836 7f7f66683710 -- 10.255.0.130:0/7505 -->
> osd14 10.255.0.63:6804/2175 -- ping v1 -- ?+0 0x7f7f38000d30
> [...]
> 
> The "ping v1" continues forever. When I turn on "debug ms = 1" and
> "debug osd = 10" on the cosd side, I can see which pg causes the
> problem:
> 
> 2010-12-02 16:04:25.701914 7f024363c710 -- 10.255.0.63:6800/19612 <==
> client98231 10.255.0.130:0/7161 3 ==== osd_op(client9
> 8231.0:41 rb.0.4a.000000000027 [delete] 3.2dab) v1 ==== 128+0+0
> (4170532710 0 0) 0x7f0154000e10
> 2010-12-02 16:04:25.701954 7f024363c710 osd12 1718 request for pool=3
> (rbd) owner=0 perm=7 may_read=0 may_write=1 may_exec=
> 0 require_exec_caps=0
> 2010-12-02 16:04:25.701971 7f024363c710 osd12 1718 pg[3.1ab( v
> 630'8247 (630'8241,630'8247] n=78 ec=2 les=814 1712/1712/1712) [12,10]
> r=0 lcod 0'0 mlcod 0'0 !hml crashed+down+peering] not active (yet)
> 
> 
> What would be the correct way to resolve this situation?
> 
> Thanks, Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
