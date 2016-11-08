From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: [ceph-users] Hammer OSD memory increase when add new
 machine
Date: Tue, 8 Nov 2016 14:08:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611081407100.29278@piezo.us.to>
References: <CAAL-TMfWddz2x7GzTghoJzp=_=d-OwtVa7fxvt8aD-rFCUqiWg@mail.gmail.com> <CAAL-TMdf-8Q9nd1px+VqFeQtVjg=vX6or4Xv0X3YW=-OzkNKgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1124726008-1478614101=:29278"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54894 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbcKHOIW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 09:08:22 -0500
In-Reply-To: <CAAL-TMdf-8Q9nd1px+VqFeQtVjg=vX6or4Xv0X3YW=-OzkNKgQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Wu <archer.wudong@gmail.com>
Cc: ceph-users <ceph-users@lists.ceph.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1124726008-1478614101=:29278
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

> ---------- Forwarded message ----------
> From: Dong Wu <archer.wudong@gmail.com>
> Date: 2016-10-27 18:50 GMT+08:00
> Subject: Re: [ceph-users] Hammer OSD memory increase when add new machine
> To: huang jun <hjwsm1989@gmail.com>
> 抄送： ceph-users <ceph-users@lists.ceph.com>
> 
> 
> 2016-10-27 17:50 GMT+08:00 huang jun <hjwsm1989@gmail.com>:
> > how do you add the new machine ?
> > does it first added to default ruleset and then you add the new rule
> > for this group?
> > do you have data pool use the default rule, does these pool contain data?
> 
> we dont use default ruleset, when we add new group machine,
> crush_location auto generate root and chassis, then we add a new rule
> for this group.
> 
> 
> > 2016-10-27 17:34 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
> >> Hi all,
> >>
> >> We have a ceph cluster only use rbd. The cluster contains several
> >> group machines, each group contains several machines, then each
> >> machine has 12 SSDs, each ssd as an OSD (journal and data together).
> >> eg:
> >> group1: machine1~machine12
> >> group2: machine13~machine24
> >> ......
> >> each group is separated with other group, which means each group has
> >> separated pools.
> >>
> >> we use Hammer(0.94.6) compiled with jemalloc(4.2).
> >>
> >> We have found that when we add a new group machine, the other group
> >> machine's memory increase 5% more or less (OSDs usage).
> >>
> >> each group's data is separated with others, so backfill only in group,
> >> not across.
> >> Why add a group of machine cause others memory increase? Is this reasonable?

It could be cached OSDmaps (they get slightly larger when you add OSDs) 
but it's hard to say.  It seems more likely that the pools and crush rules 
aren't configured right and you're adding OSDs to the wrong group.

If you look at the 'ceph daemon osd.NNN perf dump' output you can see, 
among other things, how many PGs are on the OSD.  Can you capture the 
output before and after the change (and 5% memory footprint increase)?

sage

--8323329-1124726008-1478614101=:29278--
