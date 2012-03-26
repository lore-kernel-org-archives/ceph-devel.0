From: Sage Weil <sage@newdream.net>
Subject: Re: osd shutdown notification
Date: Mon, 26 Mar 2012 13:16:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203261310240.19530@cobra.newdream.net>
References: <Pine.LNX.4.64.1203261228050.19530@cobra.newdream.net>
 <CAORUGqDBoyvSFsSMVZdfWhPUFGsQTG6pZ-n9u=YnXtj0zzOGAg@mail.gmail.com>
 <Pine.LNX.4.64.1203261251230.19530@cobra.newdream.net>
 <CAORUGqDi8+Jdhoop7QYHvROBYouJd5AvHr_ZHLD5Z+j6jZHrdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59242 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541Ab2CZURA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 16:17:00 -0400
In-Reply-To: <CAORUGqDi8+Jdhoop7QYHvROBYouJd5AvHr_ZHLD5Z+j6jZHrdA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 26 Mar 2012, Tommi Virtanen wrote:
> On Mon, Mar 26, 2012 at 12:52, Sage Weil <sage@newdream.net> wrote:
> >> For daemon crashes, perhaps the next run, after upstart/etc restarts
> >> the daemon, can somehow convince others proactively that the new
> >> osd.42 is better than the old osd.42. That sounds like a good feature
> >> to have..
> >
> > That much we already have, but startup/restart can take a while.
> > sysvinit doesn't do auto-restart, though, and it would be nice not to rely
> > on it in upstart/whatever.
> 
> I think daemon restarting is just something you can assume to exist in
> the modern world.
> 
> > I can also imagine a scenario where we don't have auto-restart but do want
> > fast failure notification...
> 
> Perhaps a separate executable that sends "osd.42 is now definitely
> down" will be good enough? Hopefully you don't have two osd.42's
> around, anyway. And if you want that, instead of execing ceph-osd, you
> do a fork & exec, wait in the parent, then exec that thing that marks
> it down. For upstart (and often for others too), there's a "after the
> service exits" hook where we could also plug that in, if we wanted to.

...except that the way to reliably mark down a particular osd.42 requires 
data that's private to the ceph-osd instance, and unknown until it starts 
up and joins the cluster.  That makes it awkward to implement any kind of 
wrapper because you have to pass it a cookie using some side-channel.

execv() in the signal handler, OTOH, is easy.  Is it that offensive?

The other nice thing about that is that the failure notification can be 
informative for free: "osd.42 stopped: got SIGTERM", "osd.42 stopped: 
failed assert at foo.cc:1234", etc.

sage

