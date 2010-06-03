From: Sage Weil <sage@newdream.net>
Subject: Re: cosd death by oom-killer
Date: Thu, 3 Jun 2010 16:41:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006031635520.29455@cobra.newdream.net>
References: <1274912650.4773.243.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1005261626220.24698@cobra.newdream.net>
 <1275600252.4800.13.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54643 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756510Ab0FCXkw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jun 2010 19:40:52 -0400
In-Reply-To: <1275600252.4800.13.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jim,

Thanks for tracking this down.  Greg is working on a similar patch that 
throttles memory consumed only by messages from clients.  (We can't 
throttle on memory used for inter-osd traffic currently without risking 
various deadlocks during recovery and so forth.  And buffers are used for 
various internal things as well.)  It's not a complete solution to the 
memory use issue, but it covers the most common problem (client induced 
memory use), and your problem in particular.

Thanks!
sage


On Thu, 3 Jun 2010, Jim Schutt wrote:

> Hi Sage,
> 
> So I've made a little progress on this.
> 
> I think I have a smoking gun: the "buf" column of
> /var/log/ceph/stat/osd0 shows that bufferlist memory
> grows to several GiB, and stays that way until the cosd
> process is killed via the oom-killer.
> 
> I also think that my test configuration contributes:
> my client host is several years newer than the server
> host, and my network is 10 Gb/s.
> 
> I've got a little patch that puts a Pipe reader to
> sleep for a bit if the bufferlist memory use gets too
> big, and it completely solves my problem.  With it my
> cosd RSS hovers in the few hundred MiB range.  I doubt if
> it is the correct final solution, but it surely seems
> to point in the direction of one.
> 
> I'll post it as a reply to this email; please let me know
> what you think.
> 
> -- Jim
> 
> On Wed, 2010-05-26 at 17:28 -0600, Sage Weil wrote:
> > Hi Jim,
> > 
> > Interesting.. we saw a similar report on irc.  Can you add
> > 
> > 	debug osd = 20
> > 	debug filestore = 20
> > 	debug journal = 20
> > 	debug ms = 1
> > 
> > to your [osd] section, reproduce the crash, and then send us the osd log?  
> > (It's at /var/log/ceph/osd$id, unless you've put it somewhere else.)
> > 
> > Thanks!
> > sage
> > 
> > 
> > On Wed, 26 May 2010, Jim Schutt wrote:
> > 
> > > Hi,
> > > 
> > > I'm running an interesting test case where I can
> > > cause an instance of cosd to use all available memory on
> > > its server.
> > > 
> > > On the server side I'm running the testing branch (at 
> > > commit  817495d2).  On the client side I'm running the
> > > for-linus branch (at commit 240ed68e).  Client and server
> > > are both CentOS 5.5.
> > > 
> > > My filesystem has one monitor daemon, two mds daemons,
> > > and one osd daemon, all running on one system with 4 GiB
> > > memory.  I'm running with no swap, because otherwise 
> > > during this test the system swaps like mad and becomes
> > > unresponsive.  The swapping is what made me look deeper.
> > > 
> > > I mount this filesystem on a client system, then try to 
> > > create a 16 GiB file on it using dd.  While creating
> > > the file I watch the server with top, and see that both
> > > the virtual memory use and resident set size of the
> > > cosd instance grow to ~4 GiB, and a short time later cosd 
> > > dies by oom-killer:
> > > 
> > > May 26 16:12:28 sasa008 kernel: [  902.544418] Killed process 6621 (cosd) vsz:4319672kB, anon-rss:3832152kB, file-rss:208kB
> > > 
> > > The osd has a 100 GiB partition for its data.
> > > 
> > > Am I maybe doing something wrong? 
> > > Is there anything else I can do to help debug this?
> > > 
> > > Thanks -- Jim
> > > 
> > > 
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
