From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-mon always election when change crushmap in firefly
Date: Thu, 24 Sep 2015 03:42:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509240339030.13265@cobra.newdream.net>
References: <CAA4r=YCZ+7jekicx6NqJ-+bzAcniMReMrLL-dYafCtrPGixpMg@mail.gmail.com> <alpine.DEB.2.00.1509230531150.11876@cobra.newdream.net> <CAA4r=YBhSnrp=6khoPR9J3R_CCFqNB+=9E_ZUkdVdo86fjQtqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48042 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbbIXKm5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 06:42:57 -0400
In-Reply-To: <CAA4r=YBhSnrp=6khoPR9J3R_CCFqNB+=9E_ZUkdVdo86fjQtqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexander Yang <yangwanyuan8861@gmail.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>

On Thu, 24 Sep 2015, Alexander Yang wrote:
>     I use 'ceph osd crush dump | tail -n 20' get :
> 
>               "type": 1,
>           "min_size": 1,
>           "max_size": 10,
>           "steps": [
>                 { "op": "take",
>                   "item": -62,
>                   "item_name": "BJ-SSD"},
>                 { "op": "chooseleaf_firstn",
>                   "num": 0,
>                   "type": "rack"},
>                 { "op": "emit"}]}],
>   "tunables": { "choose_local_tries": 2,
>       "choose_local_fallback_tries": 5,
>       "choose_total_tries": 19,
>       "chooseleaf_descend_once": 0,
>       "profile": "argonaut",
>       "optimal_tunables": 0,
>       "legacy_tunables": 1,
>       "require_feature_tunables": 0,
>       "require_feature_tunables2": 0}}
> 
>    does it provide some clue?
> 
>    In my test environment, I can't reappear this problem, It just appear in
> production environment.So i need make sure my cluster as steady as
> possible,  as less data migration as possible. do you have some advice?

It looks like this is an old cluster that has been upgraded--it's still 
using the argonaut (original!) crush tunables.  I suggest moving to

 ceph osd crush tunables firefly

(assuming all your clients are firefly or newer).  If not, then the 
bobtail tunables are a good first step.  This should eliminate the behaior 
you see... but will trigger a fair bit of rebalancing to do the 
transition.  You can use crushtool to test how bad it will be with 
something like

 ceph osd getcrushmap -i cm
 crushtool -i cm --set-choose-local-tries 0 
--set-choose-local-fallback-tries 0 --set-choose-total-tries 50 
--set-chooseleaf-descend-once 1 --set-chooseleaf-vary-r 1 -o cm.new
 crushtool -i cm --test --num-rep 3 --show-mapping > /tmp/before
 curshtool -i cm.new --test --num-rep 3 --show-mapping > /tmp/after
 wc -l /tmp/before
 diff -u /tmp/before /tmp/after | grep ^+ | wc -l

sage


 > 
>    In addition? I find  the cluster reply slower than before when I use
> 'ceph -s '.  Before 'ceph -w'  print the status  per second,  but now
> sometimes it print one status I will wait for 3-4 seconds, Is this contact
> with that problem?
> 
>    thanks for your attention!
> 
> 2015-09-23 20:34 GMT+08:00 Sage Weil <sage@newdream.net>:
> 
> > On Wed, 23 Sep 2015, Alexander Yang wrote:
> > > hello,
> > >         We use Ceph+Openstack in our private cloud. In our cluster, we
> > have
> > > 5 mons and 800 osds, the Capacity is about 1Pb. And run about 700 vms and
> > > 1100 volumes,
> > >         recently, we increase our pg_num , now the cluster have about
> > 70000
> > > pgs. In my real intention? I want every osd have 100pgs. but after
> > increase
> > > pg_num, I find I'm wrong. Because the different crush weight for
> > different
> > > osd, the osd's pg_num is different, some osd have exceed  500pgs.
> > >         Now, the problem is  appear?cause some reason when i want to
> > change
> > > some osd  weight, that means change the crushmap.  This change cause
> > about
> > > 0.03% data to migrate. the mon is always begin to election. It's will
> > hung
> > > the cluster, and when they end, the  original  leader still is the new
> > > leader. And during the mon eclection?On the upper layer, vm have too many
> > > slow request will appear. so now i dare to do any operation about change
> > > crushmap. But i worry about an important thing, If  when our cluster
> > down
> > >  one host even down one rack.   By the time, the cluster curshmap will
> > > change large, and the migrate data also large. I worry the cluster will
> > > hung  long time. and result on upper layer, all vm became to  shutdown.
> > >         In my opinion, I guess when I change the crushmap,* the leader
> > mon
> > > maybe calculate the too many information*, or* too many client want to
> > get
> > > the new crushmap from leader mon*.  It must be hung the mon thread, so
> > the
> > > leader mon can't heatbeat to other mons, the other mons think the leader
> > is
> > > down then begin the new election.  I am sorry if i guess is wrong.
> > >         The crushmap in accessory. So who can give me some advice or
> > guide,
> > > Thanks very much!
> >
> > There were huge improvements made in hammer in terms of mon efficiency in
> > these cases where it is under load.  I recommend upgrading as that will
> > help.
> >
> > You can also mitigate the problem somewhat by adjusting the mon_lease and
> > associated settings up.  Scale all of mon_lease, mon_lease_renew_interval,
> > mon_lease_ack_timeout, mon_accept_timeout by 2x or 3x.
> >
> > It also sounds like you may be using some older tunables/settings
> > for your pools or crush rules.  Can you attach the output of 'ceph osd
> > dump' and 'ceph osd crush dump | tail -n 20' ?
> >
> > sage
> >
> 
