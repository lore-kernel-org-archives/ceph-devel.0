From: Sage Weil <sage@inktank.com>
Subject: Re: ceph cluster hangs when rebooting one node
Date: Wed, 14 Nov 2012 07:06:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211140704220.6512@cobra.newdream.net>
References: <50A1101A.4070401@profihost.ag> <alpine.DEB.2.00.1211120710330.2293@cobra.newdream.net> <50A114B5.30104@profihost.ag> <CAFjNkqSyDTttexDCfFXsHAkykeYtypJWXRCEYDg3B42BvUuu3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59135 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab2KNPGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 10:06:23 -0500
In-Reply-To: <CAFjNkqSyDTttexDCfFXsHAkykeYtypJWXRCEYDg3B42BvUuu3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aleksey Samarin <nrg3tik@gmail.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 14 Nov 2012, Aleksey Samarin wrote:
> Hello!
> 
> I have the same problem. After switching off the second node, the
> cluster hangs, there is some solution?
> 
> All the best, Alex!

I suspect this is min_size; the latest master has a few changes and also 
will print it out so you can tell what is going on.

min_size is the minimum number of replicas before the OSDs will go active 
(handle reads/writes).  Setting it to 1 gets you old behavior, while 
increasing it protects you from cases where writes to a single replica 
that then fails will force the admin to make a difficult decision about 
losing data.

You can adjust with

 ceph osd pool set <pool name> min_size <value>

sage

> 
> 2012/11/12 Stefan Priebe - Profihost AG <s.priebe@profihost.ag>:
> > Am 12.11.2012 16:11, schrieb Sage Weil:
> >
> >> On Mon, 12 Nov 2012, Stefan Priebe - Profihost AG wrote:
> >>>
> >>> Hello list,
> >>>
> >>> i was checking what happens if i reboot a ceph node.
> >>>
> >>> Sadly if i reboot one node, the whole ceph cluster hangs and no I/O is
> >>> possible.
> >>
> >>
> >> If you are using the current master, the new 'min_size' may be biting you;
> >> ceph osd dump | grep ^pool and see if you see min_size for your pools.
> >> You can change that back to the norma behavior with
> >
> >
> > No i don't see any min size:
> >
> > # ceph osd dump | grep ^pool
> > pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 1344
> > pgp_num 1344 last_change 1 owner 0 crash_replay_interval 45
> > pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num
> > 1344 pgp_num 1344 last_change 1 owner 0
> > pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 1344
> > pgp_num 1344 last_change 1 owner 0
> > pool 3 'kvmpool1' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
> > 3000 pgp_num 3000 last_change 958 owner 0
> >
> >
> >>   ceph osd pool set <poolname> min_size 1
> >
> > Yes this helps! But min_size is still not shown in ceph osd dump. Also when
> > i reboot a node it takes up to 10s-20s until all osds from this node are set
> > to failed and the I/O starts again. Should i issue an ceph osd out command
> > before?
> >
> > But i had already this set for all my rules in my crushmap
> >         min_size 1
> >         max_size 2
> >
> > in my crushmap for each rule.
> >
> >
> > Stefan
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
