From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Odd "data used" reporting behavior by ceph -w
Date: Mon, 31 Jan 2011 08:18:59 -0700
Message-ID: <1296487139.23762.138.camel@sale659.sandia.gov>
References: <1291412399.4879.288.camel@sale659.sandia.gov>
 <AANLkTi=3fJz8aoywUCMzBrOWtENfaqEJ__76PXHrmppQ@mail.gmail.com>
 <1291418749.4879.319.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1012042048060.28007@cobra.newdream.net>
 <1291734873.4879.347.camel@sale659.sandia.gov>
 <AANLkTi=wo0LxhsKTSpRAMRc=Owb6wfV3D8=fYTxR+BMR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:54415 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab1AaPTL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jan 2011 10:19:11 -0500
In-Reply-To: <AANLkTi=wo0LxhsKTSpRAMRc=Owb6wfV3D8=fYTxR+BMR@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,

On Fri, 2011-01-28 at 17:44 -0700, Gregory Farnum wrote:
> Jim:
> It's been a while, but I started looking into this again a couple days
> ago. The file deletion being slow is something we've decided to push
> back after 1.0, since it doesn't really seem like a serious issue. The
> other two problems we wanted to solve, though, and I think we've
> succeeded. I was unable to reproduce your problem with ls on recent
> branches, and just pushed a fix for the slow dd-truncate-dd to both
> the master and stable branches. When you get the chance, please test
> one of those out and let me know if you still see issues like this.

I will.  Thanks for working on these issues.

-- Jim

> Thanks!
> -Greg
> 
> On Tue, Dec 7, 2010 at 7:14 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> >
> > Hi Sage,
> >
> > On Sat, 2010-12-04 at 21:59 -0700, Sage Weil wrote:
> >> Hi Jim,
> >>
> >> I think there are at least two different things going on here.
> >>
> >> On Fri, 3 Dec 2010, Jim Schutt wrote:
> >> > On Fri, 2010-12-03 at 15:36 -0700, Gregory Farnum wrote:
> >> > > How are you generating these files? It sounds like maybe you're
> >> doing
> >> > > them concurrently on a bunch of clients?
> >> >
> >> > When I created the files initially, I did it via one
> >> > dd per client over 64 clients, all at the same time.
> >> >
> >> > When I used echo to truncate them to zero length, I
> >> > did all files from one client.  Also, when I removed
> >> > the files, I did them all from a single client.
> >>
> >> The MDS doesn't release objects on deleted files until all references
> >> to
> >> the file go away (i.e. everyone closes the file handle).  The client
> >> make
> >> a point of releasing it's capability on inodes it unlinks, but since
> >> the
> >> unlink happened on a different node, the writer doesn't realize it's
> >> unlinked and doesn't bother to release its capability (until it gets
> >> pushed out of the inode cache due to normal cache pressure).  I
> >> suspect
> >> this will need some additional messaging to get the client to drop it
> >> sooner.
> >>
> >> http://tracker.newdream.net/issues/630
> >>
> >> That fix won't make it into 0.24, sorry!  Probably 0.24.1.
> >>
> >
> > Thanks for tracking this!  Whatever priority you assign
> > works great for me.
> >
> > -- Jim
> >
> >
> >
> >
> >
> 


