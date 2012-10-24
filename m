From: Sage Weil <sage@inktank.com>
Subject: Re: getting kernel debug output
Date: Wed, 24 Oct 2012 11:32:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210241131130.31573@cobra.newdream.net>
References: <alpine.DEB.2.00.1210241007500.31573@cobra.newdream.net> <50883019.5040506@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50977 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965105Ab2JXScQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 14:32:16 -0400
In-Reply-To: <50883019.5040506@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 24 Oct 2012, Alex Elder wrote:
> On 10/24/2012 12:11 PM, Sage Weil wrote:
> > I'm working on http://tracker.newdream.net/issues/3342 and was able to 
> > reproduce the msgr bug (some annoying msgr race I think) while generating 
> > full libceph debug output.  I used a teuthology yaml fragment like so:
> 
> I have more trouble than that, but perhaps there's something
> weird about having my serial console connected from 1500 miles
> away.  I'm impressed full debugging didn't mess things up.

The serial doesn't have to be attached until it crashes.  And in any case, 
the output doesn't go to the console because it's pr_debug() or whatever.  

> > tasks:
> > - clock: null
> > - ceph:
> >     log-whitelist:
> >     - wrongly marked me down
> >     - objects unfound and apparently lost
> > - thrashosds: null
> > - kclient: null
> > - exec:
> >     client.0:
> >       - echo 'module libceph +p' > /sys/kernel/debug/dynamic_debug/control
> 
> This is cool, I didn't know you could do this.

I just added it yesterday :)

> > - workunit:
> >     clients:
> >       all:
> >       - suites/ffsb.sh
> > 
> > I was pleasantly surprised that even though this is putting copious 
> > amounts of crap in dmesg it didn't slow things down enough to avoid 
> > tripping the bug.  And the 'dmesg' command in kdb appears to be working 
> > now (a couple months back it wasn't).  Yay!
> 
> For me, dmesg has been working, but I'd like to know how to
> truncate the output to just, say, the last 200 lines.  (Maybe
> there is one.)

Me too!  Not sure it does that..
 
> > Anyway, this might be useful in tracking down other bugs as well...
> 
> Yes, this is good news.
> 
> 					-Alex
> 
> 
