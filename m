From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Odd "data used" reporting behavior by ceph -w
Date: Tue, 7 Dec 2010 08:14:33 -0700
Message-ID: <1291734873.4879.347.camel@sale659.sandia.gov>
References: <1291412399.4879.288.camel@sale659.sandia.gov>
 <AANLkTi=3fJz8aoywUCMzBrOWtENfaqEJ__76PXHrmppQ@mail.gmail.com>
 <1291418749.4879.319.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1012042048060.28007@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:39433 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab0LGPOm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Dec 2010 10:14:42 -0500
In-Reply-To: <Pine.LNX.4.64.1012042048060.28007@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi Sage,

On Sat, 2010-12-04 at 21:59 -0700, Sage Weil wrote:
> Hi Jim,
> 
> I think there are at least two different things going on here.
> 
> On Fri, 3 Dec 2010, Jim Schutt wrote:
> > On Fri, 2010-12-03 at 15:36 -0700, Gregory Farnum wrote:
> > > How are you generating these files? It sounds like maybe you're
> doing
> > > them concurrently on a bunch of clients?
> > 
> > When I created the files initially, I did it via one 
> > dd per client over 64 clients, all at the same time.
> > 
> > When I used echo to truncate them to zero length, I
> > did all files from one client.  Also, when I removed
> > the files, I did them all from a single client.
> 
> The MDS doesn't release objects on deleted files until all references
> to 
> the file go away (i.e. everyone closes the file handle).  The client
> make 
> a point of releasing it's capability on inodes it unlinks, but since
> the 
> unlink happened on a different node, the writer doesn't realize it's 
> unlinked and doesn't bother to release its capability (until it gets 
> pushed out of the inode cache due to normal cache pressure).  I
> suspect 
> this will need some additional messaging to get the client to drop it 
> sooner.
> 
> http://tracker.newdream.net/issues/630
> 
> That fix won't make it into 0.24, sorry!  Probably 0.24.1.
> 

Thanks for tracking this!  Whatever priority you assign
works great for me.

-- Jim




