From: Tiago Soares <tistesoa@gmail.com>
Subject: Re: lazy io
Date: Tue, 10 Jul 2012 01:31:17 +0000 (UTC)
Message-ID: <loom.20120710T032905-563@post.gmane.org>
References: <20100526210645.035A7224805A@bear.spirit.com> <Pine.LNX.4.64.1005261635380.24698@cobra.newdream.net> <loom.20120708T224619-67@post.gmane.org> <Pine.LNX.4.64.1207082114090.13271@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50876 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab2GJBb3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Jul 2012 21:31:29 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SoPIU-0004kZ-GT
	for ceph-devel@vger.kernel.org; Tue, 10 Jul 2012 03:31:27 +0200
Received: from 150.162.67.92 ([150.162.67.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 03:31:26 +0200
Received: from tistesoa by 150.162.67.92 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 03:31:26 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sage <at> inktank.com> writes:

> 
> On Sun, 8 Jul 2012, Tiago Soares wrote:
> > Sage Weil <sage <at> newdream.net> writes:
> > 
> > > 
> > > I just pushed out some "lazy io" patches to the unstable branches.  Lazy 
> > > io is enabled on a file handle via a ceph ioctl (CEPH_IOC_LAZYIO).  Once 
> > > that happens, an application can do buffered reads/writes even when a file 
> > > is open on multiple clients, and is responsible for managing it's own 
> > > cache conherency between nodes.
> > > 
> > > An application can flush dirty data using sync_file_range(2), and 
> > > invalidate cached data using posix_fadvise(2) (POSIX_FADV_DONTNEED).  
> > > These are equivalent to the lazyio_propagate(2) and lazyio_synchronise(2) 
> > > in the original O_LAZY proposal from the POSIX IO group way back when.
> > > 
> > > If anybody is interested in testing this functionality, let us know!
> > > 
> > > sage
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo <at> vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > 
> > Hi Sage,
> > Im looking for use Parallel HDF5 on CEPH, and I expecting that Lazy IO can 
> > handle with Parallel IO on hdf file. I tried with ordinary CEPH although the 
> > parallel processes stuck. I guess that each process read or write operation 
will 
> > block until it is acknowledged by the OSD, right? How can I enable the Lazy 
IO 
> > on CEPH? There is some branch that I can get it?
> 
> First, does it behave correctly without enabling lazyio?

No, it doesn't. The parallel process stuck in the firts attempt and int the 
third attempt when I take off the file caching. The funny is, all the parallel 
clients is the same ceph osd nodes and they all locked. There is one client 
which is not a osd nodes and it still can access the ceph file system as serial 
IO. I'm using ceph-fuse to all clients to access the ceph system, I don't know 
if it could be a problem.
Basically, in my cluster, I have 8 nodes as osd and as client-fuse of the 
parallel application. One of them is a client-ceph, osd, mon and meta, which a 
call as Master node. All the parallel node writing in the same hdf5 file. I can 
confirm that the application works because I already run fine in PVFS, with no 
problems. 


> 
> The lazyio ioctl has been upstream for some time now; any recent (e.g., 
> 3.0 or later) mainline kernel will certainly have it.
> 
> If you call the lazyio ioctl, it should just allow read caching and async 
> writeback on that inode.  Reads will block just as they did before (if you 
> don't have the data you have to wait), but in general writes will go to 
> the page cache and not wait, just as they would for a regular file with 
> one writer.
> 
> The lazyio code isnt regularly tested (that I know of) so I won't be 
> terribly surprised if it broke at some point, but it at least used to 
> work.  If you observe that the application normally behaves but stops 
> doing so when the lazyio ioctl is called that will be helpful!
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

If I understand, using kernel version 2.6.32 there is no way to use  lazyio 
ioctl ?

Regards


