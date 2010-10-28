From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Thu, 28 Oct 2010 10:16:28 -0600
Message-ID: <1288282588.10847.131.camel@sale659.sandia.gov>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
 <1288128642.10847.95.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:54450 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0J1QQd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Oct 2010 12:16:33 -0400
In-Reply-To: <Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

On Wed, 2010-10-27 at 23:06 -0600, Sage Weil wrote:
> Hi Jim,
> 
> It turns out Henry's problem was actually cause by a bad fix on my part, 
> d91f2438 in ceph-client.git.  (Unfortunately that made it into 2.6.36!)  
> Reverting that commit fixed things for him.
> 
> I pushed that revert to the ceph-client.git master branch, or you can 
> revert it yourself.  master also includes everything that's been merged 
> for 2.6.37-rc1, so you may want to revert it yourself and keep the 2.6.36 
> stuff.
> 
> In any case, please let us know if it fixes your problem. 

Thanks, reverting d91f2438 fixes my problem.

To be clear, I'm running 2.6.36 + for-linus (as of commit efa4c1206ea)
+ d91f2438 reverted against unstable branch server code as of
commit c1a6ee574b.

-- Jim

>  In the 
> meantime, I'll try to figure out what it was I thought I was fixing in the 
> first place!  :(
> 
> sage
> 
> 
> On Tue, 26 Oct 2010, Jim Schutt wrote:
> 
> > 
> > Hi,
> > 
> > On Tue, 2010-10-26 at 13:25 -0600, Sage Weil wrote:
> > > On Tue, 26 Oct 2010, Jim Schutt wrote:
> > > > Hi,
> > > >
> > > > I'm testing a file system with 10 osd daemons,
> > > > 1 mds daemon, 1 mon daemon.
> > > >
> > > > Client code is 2.6.36 + current for-linus branch
> > > > Server code is unstable branch, 2a3e73bb325f.
> > > >
> > > > After mounting 64 clients, I had each write its own 512 MiB
> > > > file with dd, with all files being created in the same directory.
> > > >
> > > > A few seconds after they completed, from another client (not one
> > > > of the 64 writers) I did "ls -l" on the directory holding the
> > > > new files.
> > > >
> > > > After several minutes, it still hasn't returned;
> > > > all the daemons are still running.
> > > 
> > > This looks just like a client bug I'm tracking down with Henry Chang.
> > > I'll try again to reproduce it in my environment (as that should speed
> > > up
> > > the debugging process anyway!).
> > 
> > Cool!  Let me know if it turns out there's some way for
> > me to help further on this.
> > 
> > -- Jim
> > 
> > > 
> > > sage
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


