From: Sage Weil <sage@newdream.net>
Subject: Re: The relationship between the number of cosd and memory cache
Date: Fri, 13 May 2011 09:20:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105130916500.12286@cobra.newdream.net>
References: <BANLkTik4ZkyWzWNKCt2LqOgy9cqjELaw2w@mail.gmail.com>
 <BANLkTi=FUUq7AEuha5RxFLYmUuXJfh+vbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59171 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab1EMQTr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 12:19:47 -0400
In-Reply-To: <BANLkTi=FUUq7AEuha5RxFLYmUuXJfh+vbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Sylar Shen <kimulaaa@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>


> On Fri, May 13, 2011 at 1:00 AM, Sylar Shen <kimulaaa@gmail.com> wrote:
> > Hi developers,
> > I have a question between the numbers of cosd and memory cache in a server.
> > Here is my environment....
> > I got 15 servers as OSDes and each one has 8 cores CPU, 16GB RAM and
> > 1TB*12 Disks.
> > I only have 1 MDS and 3 MONs(4 servers as total) and the
> > specifications are the same as OSDes.
> >
> > I know that each cosd process would consume some memories and so does
> > data transmission.
> > In my environment, I set 10 cosd processes on each server.
> > My assumption is that based on my scenario, the buffer used by each
> > cosd would be (Total RAM-N*cosd used)/N .....(N is the number of cosd)
> > That is,if I assume each cosd would use 200MB RAM, so each cosd would
> > have about (16GB-10*200MB)/10 = 1.4GB RAM to use as buffer.
> > I don't know if my assumption is right or not. Please correct me if it's wrong.
> > "IF" my theory is right, would it be better if I set the number of
> > cosd to be less?
> > What I mean is that when I get less cosd process, each cosd would have
> > more memories to use as buffer and it's better?
> >
> > In other words, based on my environment with 12 disks in a server, how
> > many numbers of cosd should I set to get the best usage of memories?
> > I know the more RAM, the better performance. But are there some kind
> > of formulas to calculate the proportions between cosd and RAM?
> > Thanks in advance!
>
> Well, as you correctly note each cosd takes up some RAM to run, and
> whatever's left over can be used by the page cache (the cosd doesn't
> implement any of its own caching). In this sense, you only want one

I think the thing to keep in mind here is that you have 12 TB of file 
system data, and however many GB of available RAM, and the kernel VM 
subsystem will manage all that for you.  The number of cosd processes you 
run won't affect that underlying ratio and your overall cache efficiency 
directly, except insofar as the cosd process itself will consume a bit 
memory.

sage
