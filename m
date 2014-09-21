From: Sage Weil <sweil@redhat.com>
Subject: Re: snap_trimming + backfilling is inefficient with many
 purged_snaps
Date: Sun, 21 Sep 2014 12:52:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409211246120.27396@cobra.newdream.net>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com> <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com> <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com> <alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net>
 <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com> <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net> <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com> <1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch>
 <CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com> <alpine.DEB.2.00.1409190819070.18018@cobra.newdream.net> <63ccef299522995cc0704e349ef86503@webmail.vanderster.com> <CAME-gARt1NZmEFj6SCpxkfxnibXyR7+AdYKO4YNkQc_n+XJuXQ@mail.gmail.com>
 <CAPUexz-L=3O0qCkLWiW2UxUfJ0ryOLfO2w7A=kacOLoFui7ceA@mail.gmail.com> <7305be37366a5eadf5a3114efe1b0383@webmail.vanderster.com> <CAPUexz8GhXyNPmxkF2DDwdGppndVOWHnmX9YjO=E-HgDejmXEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59419 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbaIUTw2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Sep 2014 15:52:28 -0400
In-Reply-To: <CAPUexz8GhXyNPmxkF2DDwdGppndVOWHnmX9YjO=E-HgDejmXEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Dan van der Ster <daniel.vanderster@cern.ch>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 21 Sep 2014, Florian Haas wrote:
> So yes, I think your patch absolutely still has merit, as would any
> means of reducing the number of snapshots an OSD will trim in one go.
> As it is, the situation looks really really bad, specifically
> considering that RBD and RADOS are meant to be super rock solid, as
> opposed to say CephFS which is in an experimental state. And contrary
> to CephFS snapshots, I can't recall any documentation saying that RBD
> snapshots will break your system.

Yeah, it sounds like a separate issue, and no, the limit is not 
documented because it's definitely not the intended behavior. :)

...and I see you already have a log attached to #9503.  Will take a look.

Thanks!
sage

