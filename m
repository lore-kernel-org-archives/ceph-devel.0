From: Sage Weil <sage@inktank.com>
Subject: Re: RGW Blocking on 1-2 PG's - argonaut
Date: Mon, 4 Mar 2013 09:02:13 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303040900500.14723@cobra.newdream.net>
References: <CAMwB3ThhN036aBHP+29fVJ47E=PxOnj+fTiKJrB2dANFn1-Q1w@mail.gmail.com> <CAC-hyiGG+f7R1jCY8CPR2HKTa7bSetnGWs+ERii6iTdEAXpWMg@mail.gmail.com> <CAMwB3ThWcpWNOp03tCv1vG1OckH0Nw0moKYnPDytNya2Hhv+XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51372 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757486Ab3CDRCO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 12:02:14 -0500
In-Reply-To: <CAMwB3ThWcpWNOp03tCv1vG1OckH0Nw0moKYnPDytNya2Hhv+XA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 4 Mar 2013, S?awomir Skowron wrote:
> Ok, thanks for response. But if i have crush map like this in attachment.
> 
> All data should be balanced equal, not including hosts with 0.5 weight.
> 
> How make data auto balanced ?? when i know that some pq's have too
> much data ?? I have 4800 pg's on RGW only with 78 OSD, it is quite
> enough.
> 
> pool 3 '.rgw.buckets' rep size 3 crush_ruleset 0 object_hash rjenkins
> pg_num 4800 pgp_num 4800 last_change 908 owner 0
> 
> When will bee possible to expand number of pg's ??

Soon.  :)

The bigger question for me is why there is one PG that is getting pounded 
while the others are not.  Is there a large skew in the workload toward a 
small number of very hot objects?  I expect it should be obvious if you go 
to the loaded osd and do

 ceph --admin-daemon /var/run/ceph/ceph-osd.NN.asok dump_ops_in_flight

and look at the request queue.

sage


> 
> Best Regards
> 
> Slawomir Skowron
> 
> On Mon, Mar 4, 2013 at 3:16 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> > On Mon, Mar 4, 2013 at 3:02 AM, S?awomir Skowron <szibis@gmail.com> wrote:
> >> Hi,
> >>
> >> We have a big problem with RGW. I don't know what is the initial
> >> trigger, but i have theory.
> >>
> >> 2-3 osd, from 78 in cluster (6480 PG on RGW pool), have 3x time more
> >> RAM usage, they have much more operations in journal, and much bigger
> >> latency.
> >>
> >> When we PUT some objects then in some cases, there are so many
> >> operations in triple replication on this osd (one PG). Then this
> >> triple can't handle this load, and goes down, drives on backend of
> >> this osd are getting fire with big wait-io, and big response times.
> >> RGW waiting for this PG, and eventually block all the others
> >> operations when makes 1024 operations blocked in queue.
> >> Then whole cluster have problems, and we have an outage.
> >>
> >> When RGW block operations there is only one PG that have >1000
> >> operations in queue -
> >> ceph pg map 3.9447554d
> >> osdmap e11404 pg 3.9447554d (3.54d) -> up [53,45,23] acting [53,45,23]
> >>
> >> now this osd are migrated, with ratio 0.5 on, but before it was
> >>
> >> ceph pg map 3.9447554d
> >> osdmap e11404 pg 3.9447554d (3.54d) -> up [71,45,23] acting [71,45,23]
> >>
> >> and this three osd's have such a problems. Under this osd's are only 3
> >> drive, one drive per osd, that's why this have such a big impact.
> >>
> >> What i done. I gave 50% smaller ratio in CRUSH for this osd's, but
> >> data move to other osd, and this osd, have half of possible capacity.
> >> I think it won't help in long term, and it's not a solution.
> >>
> >> I have second cluster, with only replication on it, and there are same
> >> case. Attachment explain everything. Every parameter on this bad osd
> >> is much higher than on others. There are 2-3 osd with such high
> >> counters.
> >>
> >> Is this a bug ?? maybe there is no problems in bobtail ?? I can't
> >> switch quick into bobtail that's why i need some answers, which way i
> >> need to go.
> >>
> >
> > Not sure if bobtail is going to help much here, although there were a
> > few performance fixes that went in. If your cluster is unbalanced (in
> > terms of performance) then requests are going to be accumulated on the
> > weakest link. Reweighting the osd like what you did is a valid way to
> > go. You need to make sure that on the steady state, there's no one osd
> > that starts holding all the traffic.
> > Also, make sure that your pools have enough pgs so that the placement
> > distribution is uniform.
> >
> > Yehuda
> 
> 
> 
> --
> -----
> Pozdrawiam
> 
> S?awek "sZiBis" Skowron
> 
