From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Tue, 26 Oct 2010 15:30:42 -0600
Message-ID: <1288128642.10847.95.camel@sale659.sandia.gov>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:58362 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735Ab0JZVaw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Oct 2010 17:30:52 -0400
In-Reply-To: <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi,

On Tue, 2010-10-26 at 13:25 -0600, Sage Weil wrote:
> On Tue, 26 Oct 2010, Jim Schutt wrote:
> > Hi,
> >
> > I'm testing a file system with 10 osd daemons,
> > 1 mds daemon, 1 mon daemon.
> >
> > Client code is 2.6.36 + current for-linus branch
> > Server code is unstable branch, 2a3e73bb325f.
> >
> > After mounting 64 clients, I had each write its own 512 MiB
> > file with dd, with all files being created in the same directory.
> >
> > A few seconds after they completed, from another client (not one
> > of the 64 writers) I did "ls -l" on the directory holding the
> > new files.
> >
> > After several minutes, it still hasn't returned;
> > all the daemons are still running.
> 
> This looks just like a client bug I'm tracking down with Henry Chang.
> I'll try again to reproduce it in my environment (as that should speed
> up
> the debugging process anyway!).

Cool!  Let me know if it turns out there's some way for
me to help further on this.

-- Jim

> 
> sage
> 


