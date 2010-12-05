From: Sage Weil <sage@newdream.net>
Subject: Re: Odd "data used" reporting behavior by ceph -w
Date: Sat, 4 Dec 2010 20:59:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012042048060.28007@cobra.newdream.net>
References: <1291412399.4879.288.camel@sale659.sandia.gov>
 <AANLkTi=3fJz8aoywUCMzBrOWtENfaqEJ__76PXHrmppQ@mail.gmail.com>
 <1291418749.4879.319.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57973 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab0LEEyc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Dec 2010 23:54:32 -0500
In-Reply-To: <1291418749.4879.319.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jim,

I think there are at least two different things going on here.

On Fri, 3 Dec 2010, Jim Schutt wrote:
> On Fri, 2010-12-03 at 15:36 -0700, Gregory Farnum wrote:
> > How are you generating these files? It sounds like maybe you're doing
> > them concurrently on a bunch of clients?
> 
> When I created the files initially, I did it via one 
> dd per client over 64 clients, all at the same time.
> 
> When I used echo to truncate them to zero length, I
> did all files from one client.  Also, when I removed
> the files, I did them all from a single client.

The MDS doesn't release objects on deleted files until all references to 
the file go away (i.e. everyone closes the file handle).  The client make 
a point of releasing it's capability on inodes it unlinks, but since the 
unlink happened on a different node, the writer doesn't realize it's 
unlinked and doesn't bother to release its capability (until it gets 
pushed out of the inode cache due to normal cache pressure).  I suspect 
this will need some additional messaging to get the client to drop it 
sooner.

http://tracker.newdream.net/issues/630

That fix won't make it into 0.24, sorry!  Probably 0.24.1.

> For all but one of the files, the recreate happened on a 
> different client from the truncate.
> 
> Also, a possibly related behavior I've noticed is that
> an 'ls' on a directory where I'm writing files
> does not return until all the writers are finished.
> 
> I realize it's likely related to caps, but
> I'm hoping that can be fixed up somehow?

It depends.  If the clients "wrote" that data into the buffer cache and 
it's just taking a long time to flush it out, then things are working as 
intended (given current locking state machine).  That can be improved, but 
hasn't been a priority (see #541).  If the dd's are still writing and they 
don't stop, something is wrong, either on the mds or kclient.

> > > 4) recreate files, same size/name as step 2);
> > >
> > > Note that this step takes _much_ longer: 1448 sec vs. 41 sec.
> > > Maybe redirecting stdout onto a file from an echo of nothing
> > > is a really stupid way to truncate a file, but still...
> > > seems like something might not be right?

When you say 'recreate', you mean you 0-truncate the file, and then reopen 
and write new data, right?  It's not a _new_ file that happens to have the 
same name?

My first guess is that it's related to the fact that the truncate is done 
on a different client and the 'wanted' caps aren't getting released, 
forcing IO to be synchronous.  Can you repeat that experiment, but 
write + truncate + rewrite all on the same node?

It may also be that there is some contention on the OSDs due to the object 
deletes going in parallel with the new data being written.  I wouldn't 
expect that to be an issue though... :/

Thanks!
sage




> > >
> > > At the end, ceph -w reports:
> > >
> > > 2010-12-03 13:59:18.031146    pg v3902: 3432 pgs: 3432 active+clean; 4097 MB data, 8574 MB used, 2978 GB / 3013 GB avail
> > > (lots of scrub activity)
> > > 2010-12-03 14:05:33.016532    pg v3971: 3432 pgs: 3432 active+clean; 4097 MB data, 8595 MB used, 2978 GB / 3013 GB avail
> > >
> > > 5) rm all files; ceph -w reports:
> > >
> > > 2010-12-03 14:06:08.287086    pg v3993: 3432 pgs: 3432 active+clean; 4033 MB data, 8596 MB used, 2978 GB / 3013 GB avail
> > > (lots of scrub activity)
> > > 2010-12-03 14:12:29.090263    pg v4139: 3432 pgs: 3432 active+clean; 4033 MB data, 8520 MB used, 2978 GB / 3013 GB avail
> > >
> > > Should the space reported as used here get returned
> > > to the available pool eventually?  Should I have
> > > waited longer?
> > >
> > > 6) unmount file system on all clients; ceph -w reports:
> > >
> > > (lots of scrub activity)
> > > 2010-12-03 14:15:04.119015    pg v4232: 3432 pgs: 3432 active+clean; 1730 KB data, 4213 MB used, 2982 GB / 3013 GB avail
> > >
> > >
> > > 7) remount file system on all clients; ceph -w reports:
> > >
> > > 2010-12-03 14:16:28.238805    pg v4271: 3432 pgs: 3432 active+clean; 1754 KB data, 1693 MB used, 2985 GB / 3013 GB avail
> > >
> > >
> > > Hopefully the above is useful.  They were
> > > generated on unstable (63fab458f625) + rc (378d13df9505)
> > > + testing (1a4ad835de66) branches.
> > >
> > > -- Jim
> > >
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
