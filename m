From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd death by oom-killer
Date: Fri, 4 Jun 2010 08:41:38 -0600
Message-ID: <1275662498.4800.34.camel@sale659.sandia.gov>
References: <1274912650.4773.243.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1005261626220.24698@cobra.newdream.net>
 <1275600252.4800.13.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1006031635520.29455@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:34346 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab0FDOlp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jun 2010 10:41:45 -0400
In-Reply-To: <Pine.LNX.4.64.1006031635520.29455@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Thu, 2010-06-03 at 17:41 -0600, Sage Weil wrote:
> Hi Jim,
> 
> Thanks for tracking this down.  Greg is working on a similar patch that 
> throttles memory consumed only by messages from clients.  (We can't 
> throttle on memory used for inter-osd traffic currently without risking 
> various deadlocks during recovery and so forth.  And buffers are used for 
> various internal things as well.) 

Great.  I'll be happy to give it some extra early testing if needed.
I consider my patch to be a crutch that lets me continue testing
while a better solution is devised.

>  It's not a complete solution to the 
> memory use issue, but it covers the most common problem (client induced 
> memory use), and your problem in particular.

Will it also maybe address the possibility of OOM during recovery?

I need to learn more about how ceph balances resources for
recovery vs. resources for client requests during recovery ....

Thanks for looking into this.

-- Jim

> 
> Thanks!
> sage
> 
> 
> On Thu, 3 Jun 2010, Jim Schutt wrote:
> 
> > Hi Sage,
> > 
> > So I've made a little progress on this.
> > 
> > I think I have a smoking gun: the "buf" column of
> > /var/log/ceph/stat/osd0 shows that bufferlist memory
> > grows to several GiB, and stays that way until the cosd
> > process is killed via the oom-killer.
> > 
> > I also think that my test configuration contributes:
> > my client host is several years newer than the server
> > host, and my network is 10 Gb/s.
> > 
> > I've got a little patch that puts a Pipe reader to
> > sleep for a bit if the bufferlist memory use gets too
> > big, and it completely solves my problem.  With it my
> > cosd RSS hovers in the few hundred MiB range.  I doubt if
> > it is the correct final solution, but it surely seems
> > to point in the direction of one.
> > 
> > I'll post it as a reply to this email; please let me know
> > what you think.
> > 
> > -- Jim
> > 
> > On Wed, 2010-05-26 at 17:28 -0600, Sage Weil wrote:
> > > Hi Jim,
> > > 
> > > Interesting.. we saw a similar report on irc.  Can you add
> > > 
> > > 	debug osd = 20
> > > 	debug filestore = 20
> > > 	debug journal = 20
> > > 	debug ms = 1
> > > 
> > > to your [osd] section, reproduce the crash, and then send us the osd log?  
> > > (It's at /var/log/ceph/osd$id, unless you've put it somewhere else.)
> > > 
> > > Thanks!
> > > sage
> > > 
> > > 
> > > On Wed, 26 May 2010, Jim Schutt wrote:
> > > 
> > > > Hi,
> > > > 
> > > > I'm running an interesting test case where I can
> > > > cause an instance of cosd to use all available memory on
> > > > its server.
> > > > 
> > > > On the server side I'm running the testing branch (at 
> > > > commit  817495d2).  On the client side I'm running the
> > > > for-linus branch (at commit 240ed68e).  Client and server
> > > > are both CentOS 5.5.
> > > > 
> > > > My filesystem has one monitor daemon, two mds daemons,
> > > > and one osd daemon, all running on one system with 4 GiB
> > > > memory.  I'm running with no swap, because otherwise 
> > > > during this test the system swaps like mad and becomes
> > > > unresponsive.  The swapping is what made me look deeper.
> > > > 
> > > > I mount this filesystem on a client system, then try to 
> > > > create a 16 GiB file on it using dd.  While creating
> > > > the file I watch the server with top, and see that both
> > > > the virtual memory use and resident set size of the
> > > > cosd instance grow to ~4 GiB, and a short time later cosd 
> > > > dies by oom-killer:
> > > > 
> > > > May 26 16:12:28 sasa008 kernel: [  902.544418] Killed process 6621 (cosd) vsz:4319672kB, anon-rss:3832152kB, file-rss:208kB
> > > > 
> > > > The osd has a 100 GiB partition for its data.
> > > > 
> > > > Am I maybe doing something wrong? 
> > > > Is there anything else I can do to help debug this?
> > > > 
> > > > Thanks -- Jim
> > > > 
> > > > 
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > 
> > > > 
> > > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 


