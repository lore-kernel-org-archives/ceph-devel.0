From: Sage Weil <sage@newdream.net>
Subject: Re: heartbeat epoch
Date: Wed, 28 Sep 2011 11:06:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109281102300.13650@cobra.newdream.net>
References: <CABAwU-bJA62SRO47mBKdZa8at8mAr=v2KYeQGAs8ogXb4hpF5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39327 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab1I1SGg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 14:06:36 -0400
In-Reply-To: <CABAwU-bJA62SRO47mBKdZa8at8mAr=v2KYeQGAs8ogXb4hpF5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Huang,

On Wed, 28 Sep 2011, huang jun wrote:

> hi,all
> we encountered some problem
> origin cluster OSD0??OSD23
> we add OSD24??OSD27
> 
> the OSD20 log:
> 2011-09-28 10:32:50.602820 7f63498b6700 osd20 27
> update_heartbeat_peers: new _from osd24 192.168.0.118:6802/10487
> 2011-09-28 10:32:50.602831 7f63498b6700 -- 192.168.0.116:6802/10666
> --> 192.168.0.118:6802/10487 -- osd_ping(e0 as_of 27
> request_heartbeat) v1 -- ?+0 0x45a08c0 con 0x44863c0

This is osd.20 telling osd.24 that osd.24 should start sending heartbeats 
to osd.20.
 
> the OSD24 log:
> 2011-09-28 10:13:23.325257 7f1c33c99700 osd24 25  advance to epoch 26
> (<= newest 27)
> 2011-09-28 10:13:23.325261 7f1c33c99700 osd24 25 get_map 26 - cached 0x156f000
> 2011-09-28 10:13:23.325268 7f1c33c99700 osd24 26 advance_map epoch 26  0 pgs
> 2011-09-28 10:13:23.325273 7f1c33c99700 osd24 26 get_map 25 - cached 0x14d1c00
> 2011-09-28 10:13:23.325279 7f1c33c99700 osd24 26  advance to epoch 27
> (<= newest 27)
> 2011-09-28 10:13:23.325282 7f1c33c99700 osd24 26 get_map 27 - cached 0x156f300
> 2011-09-28 10:13:23.325288 7f1c33c99700 osd24 27 advance_map epoch 27  0 pgs
> 2011-09-28 10:13:23.325292 7f1c33c99700 osd24 27 get_map 26 - cached 0x156f000
> 2011-09-28 10:13:23.325298 7f1c33c99700 osd24 27 activate_map version 27
> 
> 2011-09-28 10:16:43.576857 7f1c33c99700 osd24 28  advance to epoch 29
> (<= newest 29)
> 2011-09-28 10:16:43.576868 7f1c33c99700 osd24 28 get_map 29 - cached 0x156f300
> 2011-09-28 10:16:43.576894 7f1c33c99700 osd24 29 advance_map epoch 29  27 pgs
> 
> i can not figure out why there is 0 pgs when OSD24 get osdmap of epoch 27?

osd.24 is brand new and doesn't have any data.  Nobody has told it (yet) 
that the PGs it is now responsible for even exist.

> but the OSD20 really regard the OSD24 as the new heartbeat_from peer
> at the epoch 27?

osd.20 will expect heartbeats when osd.20 reaches epoch 27 and sends the 
request_heartbeat message.  osd.24 will start sending heartbeats when it 
gets a request_heartbeat message, and only then.  It will stop when it 
gets a stop_heartbeat message.

> so this will result the OSD20 wronly marked OSD24 down.
> is  it a normal operation to marked down the timeout osd?

Under the old approach it would have.  Now, we only send heartbeats when 
requested, and we only expect them after requesting them.  This avoids all 
the confusing issues with OSDs being on different map version and having 
different sets of PGs that those decisions are based on.  It also means we 
can easily adjust the heartbeat policy later (to, say, include random 
other nodes in the cluster, or whatever).

Are you seeing OSDs marking each other down with the new approach?  So far 
(after the initial kinks were worked out) we haven't seen many problems in 
this area...

sage
