From: Sage Weil <sage@newdream.net>
Subject: Re: heartbeat logic
Date: Thu, 4 Aug 2011 13:10:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108041309340.26398@cobra.newdream.net>
References: <4E3A0DA7.8090409@gmail.com> <Pine.LNX.4.64.1108032113270.4869@cobra.newdream.net>
 <4E3AE286.6010203@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39181 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab1HDUF4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2011 16:05:56 -0400
In-Reply-To: <4E3AE286.6010203@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <samlang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Sam-

I'm working on restructuring the heartbeat code now to (hopefully) avoid 
all of these issues.  Looking good so far.. hoping to have something for 
you to test later today.

sage


On Thu, 4 Aug 2011, Sam Lang wrote:

> On 08/03/2011 11:28 PM, Sage Weil wrote:
> > On Wed, 3 Aug 2011, Sam Lang wrote:
> > > During startup of an osd cluster with 37 osds, within the first few
> > > seconds I
> > > see osds getting marked down, even though the osd processes remain running
> > > and
> > > seem to be just fine.  The up count fluctuates for a while but seems to
> > > stabilize eventually at around 30 up osds, while 7 or so remain down, and
> > > eventually get marked out.
> > > 
> > > With debugging enabled, I've tracked it down to this bit of logic in
> > > OSD.cc:1502 (stable branch):
> > > 
> > > ------snip------
> > >    // ignore (and mark down connection for) old messages
> > >    epoch_t e = m->map_epoch;
> > >    if (!e)
> > >      e = m->peer_as_of_epoch;
> > >    if (e<= osdmap->get_epoch()&&
> > >        ((heartbeat_to.count(from) == 0&&  heartbeat_from.count(from) == 0)
> > > ||
> > >         heartbeat_con[from] != m->get_connection())) {
> > >      dout(5)<<  "handle_osd_ping marking down peer "<<
> > > m->get_source_inst()
> > > <<  " after old message from epoch "<<  e
> > > <<  "<= current "<<  osdmap->get_epoch()<<  dendl;
> > >      heartbeat_messenger->mark_down(m->get_connection());
> > >      goto out;
> > >    }
> > > --------------------
> > > 
> > > It looks as though the osd getting marked down is sending a heartbeat ping
> > > to
> > > another osd, at which point, that osd marks it as down.  Its not clear to
> > > me
> > > why that happens.  Is it because connections are getting dropped and ports
> > > are
> > > changing?
> > > 
> > > In any case, that if conditional succeeds, resulting in the osd marking
> > > down
> > > the osd that just sent it a ping heartbeat.
> > > 
> > > I modified the debug output to show the values for
> > > heartbeat_to.count(from)
> > > and heartbeat_from.count(from), as well as heartbeat_con[from] and
> > > m->get_connection().  The cases where osds are marked down are when the
> > > ping
> > > message's epoch and the osdmap epoch are the same (usually around 16), and
> > > the
> > > counts are always zero, suggesting that this is the first heartbeat from
> > > osdA
> > > to osdB.  Even if they weren't zero, the heartbeat_con[from] is null, and
> > > doesn't get set till later, so the conditional would succeed anyway.  Can
> > > someone explain the purpose and reasoning behind this bit of code?  If I
> > > just
> > > whack the second part of the conditional will bad things happen?  Any help
> > > is
> > > greatly appreciated.
> > Ha, Sam (Just) was just asking me about this bit of code at lunch today.
> > It looks like it's the problem.
> > 
> > There are a couple different types of heartbeat messages, the
> > important ones being heartbeats and heartbeat requests.  The requests are
> > sent whenever a node starts expecting to receive heartbeats.  This keeps
> > everyone happy even when the sender is behind in processing map updates.
> > The above check is correct for heartbeats, but not the requests.
> > 
> > There is a bit of work that needs to be done here.  It looks like the
> > logic is sound in the case where the OSDs have all the relevant PGs, but
> > doesn't work when they do not (there are new ones, or PGs are quickly
> > shifting around).
> > 
> > In the meantime, you should be able to just comment out that whole block.
> > The old connections won't get cleaned up, but it's a tiny resource leak,
> > and if I'm remembering correctly nothing bad should come of it.
> Commenting out that bit of code fixes most of the problems I was seeing, but I
> still see osds getting marked down.  It looks like I'm hitting the case you
> described where PGs are shifting around.  OSDs are getting marked down by
> other osds that no longer including it in its list of heartbeat_to peers or
> heartbeat_from peers.  Lines 1429 and 1453 of OSD.cc (stable) in
> update_heartbeat_peers() are the next bits of code that are marking down
> peers.  Initially, the heartbeat_to.count(p->first) value is always 0,
> resulting in those old peers getting marked down.  Eventually the count is
> non-zero, but there are cases where the old connection ptr is not equal to the
> new heartbeat connection ptr, even though the peer addr/port/nonce remain
> equal.  I can't tell if we see follow on downings because the initial downings
> close connections that get reset, resulting in different connection pointers
> later on.  Is there a better way to do the comparison than with the connection
> pointers?
> 
> I'm not sure there's a quick and dirty solution in this case.  I can comment
> out the lines that mark those osds as down, but when I do, other nodes get
> marked down anyway (it looks like OSDMap::apply_incremental is marking them
> down).
> 
> If I can provide more info/debugging/logs etc, please let me know.
> 
> Thanks,
> -sam
> 
> 
> > Sam (other Sam!), let's go over this in the morning!
> > 
> > sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
