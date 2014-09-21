From: Sage Weil <sweil@redhat.com>
Subject: Re: snap_trimming + backfilling is inefficient with many
 purged_snaps
Date: Sun, 21 Sep 2014 12:41:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409211237420.27396@cobra.newdream.net>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com> <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com> <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com> <CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com>
 <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com> <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com> <alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net> <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
 <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net> <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com> <1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch> <CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com>
 <alpine.DEB.2.00.1409190819070.18018@cobra.newdream.net> <63ccef299522995cc0704e349ef86503@webmail.vanderster.com> <CAME-gARt1NZmEFj6SCpxkfxnibXyR7+AdYKO4YNkQc_n+XJuXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59332 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbaIUTlD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Sep 2014 15:41:03 -0400
In-Reply-To: <CAME-gARt1NZmEFj6SCpxkfxnibXyR7+AdYKO4YNkQc_n+XJuXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alphe Salas <asalas@kepler.cl>
Cc: Dan van der Ster <daniel.vanderster@cern.ch>, ceph-devel <ceph-devel@vger.kernel.org>, Florian Haas <florian@hastexo.com>

On Sat, 20 Sep 2014, Alphe Salas wrote:
> Real field testings and proof workout are better than any unit testing ... I
> would follow Dan s notice of resolution because it based on real problem and
> not fony style test ground.

It's been reviewed and look right, but the rados torture tests are 
pretty ... torturous, and this code is delicate.  I would still wait.

> Sage apart that problem is there a solution to the ever expending replicas
> problem ?

Discard for the kernel RBD client should go upstream this cycle.

As for RADOS consuming more data when RBD blocks are overwritten, I still 
have yet to see any actual evidence of this, and have a hard time seeing 
how it could happen.  A sequence of steps to reproduce would be the next 
step.

sage
