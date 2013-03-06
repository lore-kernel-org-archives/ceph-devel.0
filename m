From: Sage Weil <sage@inktank.com>
Subject: Re: CephFS Space Accounting and Quotas
Date: Wed, 6 Mar 2013 13:42:06 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303061339270.5072@cobra.newdream.net>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com> <51363490.4070408@42on.com> <1F15E079964848B9BE079E974A1946B4@inktank.com> <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net> <51363B30.7080006@42on.com> <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
 <513793FD.7010001@sandia.gov> <340852C7DC4E472A9D6EA3E0AEDE6EB0@inktank.com> <51379FCD.9000502@sandia.gov> <D19243567199482692F961618A335817@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49647 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab3CFVmH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 16:42:07 -0500
In-Reply-To: <D19243567199482692F961618A335817@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org, Wido den Hollander <wido@42on.com>

On Wed, 6 Mar 2013, Greg Farnum wrote:
> > 'ls -lh <dir>' seems to be just the thing if you already know <dir>.
> >  
> > And it's perfectly suitable for our use case of not scheduling
> > new jobs for users consuming too much space.
> >  
> > I was thinking I might need to find a subtree where all the
> > subdirectories are owned by the same user, on the theory that
> > all the files in such a subtree would be owned by that same
> > user. E.g., we might want such a capability to manage space per
> > user in shared project directories.
> >  
> > So, I tried 'find <dir> -type d -exec ls -lhd {} \;'
> >  
> > Unfortunately, that ended up doing a 'newfstatat' on each file
> > under <dir>, evidently to learn if it was a directory. The
> > result was that same slowdown for files written on other clients.
> >  
> > Is there some other way I should be looking for directories if I
> > don't already know what they are?

Normally the readdir result as the d_type field filled in to indicate 
whether the dentry is a directory or not, which makes the stat 
unnecessary.  I'm surprised that find isn't doing that properly already!  
It's possible we aren't populating a field we should be in our readdir 
code...

> > Also, this issue of stat on files created on other clients seems
> > like it's going to be problematic for many interactions our users
> > will have with the files created by their parallel compute jobs -
> > any suggestion on how to avoid or fix it?
> >  
> 
> Brief background: stat is required to provide file size information, and 
> so when you do a stat Ceph needs to find out the actual file size. If 
> the file is currently in use by somebody, that requires gathering up the 
> latest metadata from them. Separately, while Ceph allows a client and 
> the MDS to proceed with a bunch of operations (ie, mknod) without having 
> it go to disk first, it requires anything which is visible to a third 
> party (another client) be durable on disk for consistency reasons.
> 
> These combine to mean that if you do a stat on a file which a client 
> currently has buffered writes for, that buffer must be flushed out to 
> disk before the stat can return. This is the usual cause of the slow 
> stats you're seeing. You should be able to adjust dirty data thresholds 
> to encourage faster writeouts, do fsyncs once a client is done with a 
> file, etc in order to minimize the likelihood of running into this.

This is the current behavior.  There is a bug in the tracker to introduce 
a new lock state to optimize the stat case so that writers are paused but 
buffers aren't flushed.  It hasn't been prioritized, but is not terribly 
complex.

sage
