From: Sage Weil <sage@newdream.net>
Subject: Re: OSD questions
Date: Thu, 28 Jul 2011 08:52:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107280850250.13306@cobra.newdream.net>
References: <CABAwU-YsTz8WjPLzVZrhwJs64fYTPdAHbA2J1S1pdzMULuBM_w@mail.gmail.com>
 <CAF3hT9DHLsmWpL0jrrC+bm=Dq4m4+ohu2u2nL_NGhAxWM1TC2A@mail.gmail.com>
 <CAF3hT9BSbO3o6vBy0E3XPVJQz6X=W9VFVuWqjvdeyNR5x+j-Ng@mail.gmail.com>
 <CABAwU-Y5B2Fmy0J=6q3vn9_O0WGMy0PEV-QiwWXp0o12_CD8dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36926 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496Ab1G1Psy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 11:48:54 -0400
In-Reply-To: <CABAwU-Y5B2Fmy0J=6q3vn9_O0WGMy0PEV-QiwWXp0o12_CD8dg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 28 Jul 2011, huang jun wrote:
> 2011/7/28 Gregory Farnum <gregory.farnum@dreamhost.com>:
> > On Wed, Jul 27, 2011 at 9:05 AM, Gregory Farnum
> > <gregory.farnum@dreamhost.com> wrote:
> >> The doubled writes can be annoying, but it's really the only safe
> >> thing to do. Perhaps we could do something with btrfs and snapshots to
> >> avoid using a journal, but I'd have to look into it some more.
> > Actually this already works -- you are data safe if you run btrfs
> > without a journal. Apparently it's even slower, though -- you need to
> > go through a lot more syncs to guarantee your data safety.
> >
> we use btrfs and without journal, it turns out that :
> the performance of big write(10GB) is good, but the rm dir ops goes slow.
> So we reset the value of "filestore max sync interval = 0.1", the rm
> dirs rate increased.

Do you mean the rate that the rm operations completed, or the lag before 
the space became available?  In general, a longer sync interval should 
perform better (less fs commit overhead).

> Does this related to version of ceph kernel Client and kernel ? Can we
> promote the DIR ops
> performance on OSD end?

There shouldn't be any synchronous IO in the namespace operation paths 
(except in odd situations involving multiple client interactions).  
(Unless you fsync(dirfd), that is!)  What latencies are you seeing?

sage



> > So your best bet if it's a real problem is to add a fast disk to use
> > as your journaling device.
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
