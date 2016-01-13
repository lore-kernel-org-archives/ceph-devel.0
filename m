From: Sage Weil <sweil@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Wed, 13 Jan 2016 08:48:00 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com> <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com> <20160112173248.GA8218@ultraspiritum.redhat.com> <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54359 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277AbcAMNr4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jan 2016 08:47:56 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 59AF4C0BF2D7
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jan 2016 13:47:56 +0000 (UTC)
In-Reply-To: <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Erwan Velu <evelu@redhat.com>
Cc: "Adam C. Emerson" <aemerson@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, 13 Jan 2016, Erwan Velu wrote:
> >One concern with monotonic clocks, even for elapsed time, is that their epoch is
> >unspecified. You cannot send a monotonic time over the network to another
> >machine nor can you save it to a file and re-read it later. Anything to be
> >serialized must be a real time.
> 
> While speaking about ceph_clock_now(), I was more likely targeting lots of local code like
>   start = ceph_clock_now();
>   ... do_stuff ...
>   elapse_time = ceph_clock_now() - start
> 
> 
> I'm thinking of code like this in void OSD::tick_without_osd_lock():
> Starting at https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L4009.
> 
> This code is trying to estimate if a mon is still alive by computing a difference of system time by
> doing a  "if (now - last_pg_stats_sent > max) {" where now & last_pg_stats_sent are the output of "ceph_clock_now()"
> 
> As ceph_clock_now() is using CLOCK_REALTIME, we could have cases where a simple drift caused by a NTP trigger that code.
> As we are only trying to compute a difference of absolute time (and not system time), using a MONOTONIC_* seems much more accurate at my taste.
> 
> I know that's pretty picky but that could exists.

That's a perfect example of where the monotonic time should be used. There 
are a zillion instances of this pattern that could be cleaned up... :)

> >I find it interesting. If you want to change more subsystems to use ceph_time
> >and use monotonic and coarse clocks in appropriate places I think that would be
> >wonderful. It might be worthwhile to focus on the places where we use double to
> >represent a time value.
> >Please read through ceph_time.h and osdc to get a feel for it. If you think it
> >could use improvement, I'd be happy to hear your ideas.
> 
> You mean we could switch some of ceph_clock_now() calls to ceph_time ? 
> We could use coarse_mono_clock to perform that.
> 
> If you agree that switching code like the one I'm speaking is valuable, 
> I can work on it.

That would be great!

sage

