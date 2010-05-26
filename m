From: Sage Weil <sage@newdream.net>
Subject: lazy io
Date: Wed, 26 May 2010 16:41:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005261635380.24698@cobra.newdream.net>
References: <20100526210645.035A7224805A@bear.spirit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52392 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935028Ab0EZXl4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 May 2010 19:41:56 -0400
In-Reply-To: <20100526210645.035A7224805A@bear.spirit.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: eestolan@cs.ucsc.edu, carlosm@soe.ucsc.edu

I just pushed out some "lazy io" patches to the unstable branches.  Lazy 
io is enabled on a file handle via a ceph ioctl (CEPH_IOC_LAZYIO).  Once 
that happens, an application can do buffered reads/writes even when a file 
is open on multiple clients, and is responsible for managing it's own 
cache conherency between nodes.

An application can flush dirty data using sync_file_range(2), and 
invalidate cached data using posix_fadvise(2) (POSIX_FADV_DONTNEED).  
These are equivalent to the lazyio_propagate(2) and lazyio_synchronise(2) 
in the original O_LAZY proposal from the POSIX IO group way back when.

If anybody is interested in testing this functionality, let us know!

sage

