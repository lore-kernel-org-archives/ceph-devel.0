From: Sage Weil <sage@newdream.net>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Wed, 25 May 2011 11:29:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105251128530.29945@cobra.newdream.net>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
 <1288128642.10847.95.camel@sale659.sandia.gov> <Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
 <20110525110118.GA6872@systemlinux.org> <Pine.LNX.4.64.1105250913340.29945@cobra.newdream.net>
 <20110525173338.GI20417@systemlinux.org> <Pine.LNX.4.64.1105251050030.29945@cobra.newdream.net>
 <20110525182538.GJ20417@systemlinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40656 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab1EYS2V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 14:28:21 -0400
In-Reply-To: <20110525182538.GJ20417@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Jim Schutt <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 25 May 2011, Andre Noll wrote:
> On Wed, May 25, 10:52, Sage Weil wrote:
> > > Nope. I'm now running the ceph master branch (fe955881) on all nodes
> > > but the problem remains. Even after stopping the writer, the "ls -l"
> > > hangs. Linux kernel version is plain 2.6.38.7 everywhere and the ceph
> > > setup is fairly simple: 6 cosds, one cmon and one cmds.
> > 
> > I created a new bug (http://tracker.newdream.net/issues/1110) for this. 
> 
> Thanks.
> 
> > Can you generate an mds log for this
> 
> done.
> 
> > and attach it to the bug?
> 
> I've created an account (maan) for me but I can't login. The login
> attempt fails with "invalid user or password". I've clicked on "lost
> password" to make the tracker send the password back to me. This
> worked and I was able to change the password but I still can't log in.

Activated.  Not sure why it doesn't seem to work on its own.

> Anyway, I've put the log file on my server:
> 
> 	http://systemlinux.org/~maan/mds.0.log.gz

Thanks!
sage
