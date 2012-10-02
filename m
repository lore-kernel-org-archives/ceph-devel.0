From: Mike Ryan <mike.ryan@inktank.com>
Subject: Re: PG recovery reservation state chart
Date: Tue, 2 Oct 2012 15:39:23 -0700
Message-ID: <20121002223923.GH8206@splice>
References: <20121002194858.GC8206@splice>
 <CADvuQRHUKEJzbySqqT-9ri=65wM3fh0Dk5wjSPJ1Uhn2+cY_+Q@mail.gmail.com>
 <20121002204249.GF8206@splice>
 <506B6417.9020009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33692 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab2JBWj1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 18:39:27 -0400
Received: by pbbrr4 with SMTP id rr4so9213480pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 15:39:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <506B6417.9020009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

> It'd be good to update doc/dev/osd_internals with a description of the
> reservations though, maybe expanding
> doc/dev/osd_internals/backfill_reservation.

Will do.

> One other thing I'd like to see made explicit:
> 
> How does this handle upgrades? i.e., what will happen when some OSDs
> have this reservation mechanism and some do not?

I will introduce a feature bit for recovery reservations.

If a replica lacks the mechanism then the primary "grants" itself a
reservation from that replica. There will obviously be no need to
release the reservation.

If the primary lacks the mechanism, recovery proceeds as though none of
the replicas have the mechanism (which is to say, exactly how it
proceeds today).

In either case, an OSD can become heavily loaded if too many recovery
operations are occurring at the same time, but it's no worse than the
current status quo.
