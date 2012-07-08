From: Tiago Soares <tistesoa@gmail.com>
Subject: Re: lazy io
Date: Sun, 8 Jul 2012 20:54:11 +0000 (UTC)
Message-ID: <loom.20120708T224619-67@post.gmane.org>
References: <20100526210645.035A7224805A@bear.spirit.com> <Pine.LNX.4.64.1005261635380.24698@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40663 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab2GHVAI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 8 Jul 2012 17:00:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SnyaK-0006os-T6
	for ceph-devel@vger.kernel.org; Sun, 08 Jul 2012 23:00:05 +0200
Received: from 150.162.67.201 ([150.162.67.201])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 08 Jul 2012 23:00:04 +0200
Received: from tistesoa by 150.162.67.201 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 08 Jul 2012 23:00:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sage <at> newdream.net> writes:

> 
> I just pushed out some "lazy io" patches to the unstable branches.  Lazy 
> io is enabled on a file handle via a ceph ioctl (CEPH_IOC_LAZYIO).  Once 
> that happens, an application can do buffered reads/writes even when a file 
> is open on multiple clients, and is responsible for managing it's own 
> cache conherency between nodes.
> 
> An application can flush dirty data using sync_file_range(2), and 
> invalidate cached data using posix_fadvise(2) (POSIX_FADV_DONTNEED).  
> These are equivalent to the lazyio_propagate(2) and lazyio_synchronise(2) 
> in the original O_LAZY proposal from the POSIX IO group way back when.
> 
> If anybody is interested in testing this functionality, let us know!
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Hi Sage,
Im looking for use Parallel HDF5 on CEPH, and I expecting that Lazy IO can 
handle with Parallel IO on hdf file. I tried with ordinary CEPH although the 
parallel processes stuck. I guess that each process read or write operation will 
block until it is acknowledged by the OSD, right? How can I enable the Lazy IO 
on CEPH? There is some branch that I can get it?
Regards
Tiago

