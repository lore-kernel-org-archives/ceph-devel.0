From: Sage Weil <sage@inktank.com>
Subject: Re: lazy io
Date: Sun, 8 Jul 2012 21:18:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207082114090.13271@cobra.newdream.net>
References: <20100526210645.035A7224805A@bear.spirit.com>
 <Pine.LNX.4.64.1005261635380.24698@cobra.newdream.net>
 <loom.20120708T224619-67@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46446 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2GIES6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 00:18:58 -0400
In-Reply-To: <loom.20120708T224619-67@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tiago Soares <tistesoa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 8 Jul 2012, Tiago Soares wrote:
> Sage Weil <sage <at> newdream.net> writes:
> 
> > 
> > I just pushed out some "lazy io" patches to the unstable branches.  Lazy 
> > io is enabled on a file handle via a ceph ioctl (CEPH_IOC_LAZYIO).  Once 
> > that happens, an application can do buffered reads/writes even when a file 
> > is open on multiple clients, and is responsible for managing it's own 
> > cache conherency between nodes.
> > 
> > An application can flush dirty data using sync_file_range(2), and 
> > invalidate cached data using posix_fadvise(2) (POSIX_FADV_DONTNEED).  
> > These are equivalent to the lazyio_propagate(2) and lazyio_synchronise(2) 
> > in the original O_LAZY proposal from the POSIX IO group way back when.
> > 
> > If anybody is interested in testing this functionality, let us know!
> > 
> > sage
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> Hi Sage,
> Im looking for use Parallel HDF5 on CEPH, and I expecting that Lazy IO can 
> handle with Parallel IO on hdf file. I tried with ordinary CEPH although the 
> parallel processes stuck. I guess that each process read or write operation will 
> block until it is acknowledged by the OSD, right? How can I enable the Lazy IO 
> on CEPH? There is some branch that I can get it?

First, does it behave correctly without enabling lazyio?

The lazyio ioctl has been upstream for some time now; any recent (e.g., 
3.0 or later) mainline kernel will certainly have it.

If you call the lazyio ioctl, it should just allow read caching and async 
writeback on that inode.  Reads will block just as they did before (if you 
don't have the data you have to wait), but in general writes will go to 
the page cache and not wait, just as they would for a regular file with 
one writer.

The lazyio code isnt regularly tested (that I know of) so I won't be 
terribly surprised if it broke at some point, but it at least used to 
work.  If you observe that the application normally behaves but stops 
doing so when the lazyio ioctl is called that will be helpful!

sage
