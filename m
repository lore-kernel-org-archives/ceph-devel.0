From: Sage Weil <sage@newdream.net>
Subject: Re: heartbeat logic
Date: Wed, 3 Aug 2011 21:28:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108032113270.4869@cobra.newdream.net>
References: <4E3A0DA7.8090409@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47561 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab1HDEYW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2011 00:24:22 -0400
In-Reply-To: <4E3A0DA7.8090409@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <samlang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 3 Aug 2011, Sam Lang wrote:
> During startup of an osd cluster with 37 osds, within the first few seconds I
> see osds getting marked down, even though the osd processes remain running and
> seem to be just fine.  The up count fluctuates for a while but seems to
> stabilize eventually at around 30 up osds, while 7 or so remain down, and
> eventually get marked out.
> 
> With debugging enabled, I've tracked it down to this bit of logic in
> OSD.cc:1502 (stable branch):
> 
> ------snip------
>   // ignore (and mark down connection for) old messages
>   epoch_t e = m->map_epoch;
>   if (!e)
>     e = m->peer_as_of_epoch;
>   if (e <= osdmap->get_epoch() &&
>       ((heartbeat_to.count(from) == 0 && heartbeat_from.count(from) == 0) ||
>        heartbeat_con[from] != m->get_connection())) {
>     dout(5) << "handle_osd_ping marking down peer " << m->get_source_inst()
> << " after old message from epoch " << e
> << " <= current " << osdmap->get_epoch() << dendl;
>     heartbeat_messenger->mark_down(m->get_connection());
>     goto out;
>   }
> --------------------
> 
> It looks as though the osd getting marked down is sending a heartbeat ping to
> another osd, at which point, that osd marks it as down.  Its not clear to me
> why that happens.  Is it because connections are getting dropped and ports are
> changing?
> 
> In any case, that if conditional succeeds, resulting in the osd marking down
> the osd that just sent it a ping heartbeat.
> 
> I modified the debug output to show the values for heartbeat_to.count(from)
> and heartbeat_from.count(from), as well as heartbeat_con[from] and
> m->get_connection().  The cases where osds are marked down are when the ping
> message's epoch and the osdmap epoch are the same (usually around 16), and the
> counts are always zero, suggesting that this is the first heartbeat from osdA
> to osdB.  Even if they weren't zero, the heartbeat_con[from] is null, and
> doesn't get set till later, so the conditional would succeed anyway.  Can
> someone explain the purpose and reasoning behind this bit of code?  If I just
> whack the second part of the conditional will bad things happen?  Any help is
> greatly appreciated.

Ha, Sam (Just) was just asking me about this bit of code at lunch today.  
It looks like it's the problem.

There are a couple different types of heartbeat messages, the 
important ones being heartbeats and heartbeat requests.  The requests are 
sent whenever a node starts expecting to receive heartbeats.  This keeps 
everyone happy even when the sender is behind in processing map updates.  
The above check is correct for heartbeats, but not the requests.

There is a bit of work that needs to be done here.  It looks like the 
logic is sound in the case where the OSDs have all the relevant PGs, but 
doesn't work when they do not (there are new ones, or PGs are quickly 
shifting around).  

In the meantime, you should be able to just comment out that whole block.  
The old connections won't get cleaned up, but it's a tiny resource leak, 
and if I'm remembering correctly nothing bad should come of it.

Sam (other Sam!), let's go over this in the morning!

sage
