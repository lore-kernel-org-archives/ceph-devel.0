From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 18 Feb 2011 12:58:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102181254150.13848@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102172312550.26016@cobra.newdream.net>
 <AANLkTimC0eTX7NjLLPjWGOpa0FYiTiO0TsG3B5A1Waht@mail.gmail.com>
 <1298062110.25491.211.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48805 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598Ab1BRU4x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 15:56:53 -0500
In-Reply-To: <1298062110.25491.211.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 18 Feb 2011, Jim Schutt wrote:
> On Fri, 2011-02-18 at 12:07 -0700, Colin McCabe wrote:
> > > Anybody else have ideas?  :/
> > >
> > 
> > At the risk of asking a dumb question, does syslog have messages from
> > ntpd about date/time adjustments?
> 
> No, just a few messages like this:
> 
> Feb 18 08:34:43 an12 ntpd[4939]: kernel time sync enabled 0001
> Feb 18 09:08:53 an12 ntpd[4939]: kernel time sync enabled 4001
> Feb 18 10:34:16 an12 ntpd[4939]: kernel time sync enabled 0001
> Feb 18 11:25:30 an12 ntpd[4939]: kernel time sync enabled 4001
> Feb 18 11:42:36 an12 ntpd[4939]: kernel time sync enabled 0001
> Feb 18 12:33:52 an12 ntpd[4939]: kernel time sync enabled 4001
> Feb 18 13:08:00 an12 ntpd[4939]: kernel time sync enabled 0001
> 
> > 
> > Also, what is the load on the system like? dout will write to a
> > logfile using write(2), which of course is a blocking system call. 28
> > seconds is a long time for a write to block, but things can get weird
> > under heavy I/O.
> 
> During my tests my systems have high iowait  (40-80%), but CPU
> utilization is relatively low.  However, my ceph logs are going 
> to a dedicated disk via a dedicated I/O controller; i.e. my 
> ceph data disks are FC and my log disk is a local SATA disk.

Also, at least in your earlier example, lots of other crap is going into 
the log in a timely manner.

One thing that might shed some light on this is getting a series of 
snapshots of /proc/$cosd_pid/tasks/*/{status,sched,syscall} during this 
period.  (We also need to map the pthread ids we see in the logs to the 
task pid...)  It sounds to me like something is preventing the kernel from 
scheduling the thread, unrelated to and pthread-level primitives the code 
is interacting with.  I'm not familiar enough with the scheduling 
internals to know what that might be.

sage


> 
> -- Jim
> 
> > 
> > A more general problem is priority inversion through the dout lock.
> > For example, some other piece of code could be doing something like this
> > 
> > dout << my_happy_printer_function() << dendl
> > 
> > If my_happy_printer_function takes some heavily contended locks, this
> > will turn into
> > 1. lock dout lock
> > 2. lock heavily contended locks
> > 3. write(2) to logfile
> > 4. unlock ""
> > 5. unlock dout lock
> > 
> > This is one reason why I want to get rid of the dout lock (although
> > not the only one.)
> > 
> > Colin
> > 
> > 
> > On Thu, Feb 17, 2011 at 11:13 PM, Sage Weil <sage@newdream.net> wrote:
> > > On Thu, 17 Feb 2011, Jim Schutt wrote:
> > >> Check out the result:
> > >>
> > >> osd.68.log:256027:2011-02-17 15:44:50.141378 7fd42ad57940 osd68 5 tick
> > >> osd.68.log:256028:2011-02-17 15:44:50.141464 7fd42ad57940 osd68 5 tick getting read lock on map_lock
> > >> osd.68.log:256029:2011-02-17 15:44:50.141472 7fd42ad57940 osd68 5 tick got read lock on map_lock
> > >> osd.68.log:256031:2011-02-17 15:44:50.141612 7fd42ad57940 osd68 5 tick sending mon report
> > >> osd.68.log:256032:2011-02-17 15:44:50.141619 7fd42ad57940 osd68 5 tick removing stray pgs
> > >> osd.68.log:256033:2011-02-17 15:44:50.141626 7fd42ad57940 osd68 5 tick sending log to logclient
> > >> osd.68.log:256034:2011-02-17 15:44:50.141633 7fd42ad57940 osd68 5 tick arming timer for next tick     <==
> > >> osd.68.log:256277:2011-02-17 15:45:18.481656 7fd42ad57940 osd68 5 tick checking dispatch queue status <== 28 second gap
> > >> osd.68.log:256278:2011-02-17 15:45:18.481669 7fd42ad57940 osd68 5 tick done
> > >> osd.68.log:256279:2011-02-17 15:45:18.481691 7fd42ad57940 osd68 5 tick
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
