From: Sage Weil <sweil@redhat.com>
Subject: Re: libnuma / ceph
Date: Sun, 10 May 2015 19:48:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505101947350.28239@cobra.newdream.net>
References: <CAMieVSeUfLN0NGG6cxGy_Hbi0FwuzkivfFLqcAGxwX7BrjW-DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbbEKCsN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 10 May 2015 22:48:13 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4B2mClI004440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Sun, 10 May 2015 22:48:12 -0400
In-Reply-To: <CAMieVSeUfLN0NGG6cxGy_Hbi0FwuzkivfFLqcAGxwX7BrjW-DQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kbader@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 9 May 2015, Kyle Bader wrote:
> It looks like the NUMA problem [1] could easily be solved by:
> 
> #include <numa.h> in ceph-osd.cc
> numa_available() should return 0
> read from /var/lib/ceph/ceph-$id/numa_node
> make sure int
> make sure sure numa node exists
> int numa_bind(numa_node)
> 
> Then that OSD will only use the cpu cores and memory in that NUMA
> region. This could also be handy for converging ceph-mon/rgw/etc with
> OSD.
> 
> [mon.a]
> numa_node = 1
> 
> ceph-mon numa_bind(1)
> 
> [rgw.a]
> numa_node = 1
> 
> radosgw numa_bind(1)

Hmm!

So, numa_node default would probably be -1.  What about 
a zone_reclaim_mode option?  Or should we just do a warning?

sage

> 
> [1] https://www.mail-archive.com/ceph-users@lists.ceph.com/msg16274.html
> 
> -- 
> Kyle Bader - Red Hat
> Senior Solution Architect
> Ceph Storage Architectures
> 
> 
