From: Florian Haas <florian@hastexo.com>
Subject: Re: snap_trimming + backfilling is inefficient with many purged_snaps
Date: Thu, 25 Sep 2014 00:01:51 +0100
Message-ID: <CAPUexz8BvvS7r_NM5WDmi0BvOixgBcvYpbwWowwVU0_zXz9ELw@mail.gmail.com>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
 <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com>
 <1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch> <CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com>
 <alpine.DEB.2.00.1409190819070.18018@cobra.newdream.net> <63ccef299522995cc0704e349ef86503@webmail.vanderster.com>
 <CAME-gARt1NZmEFj6SCpxkfxnibXyR7+AdYKO4YNkQc_n+XJuXQ@mail.gmail.com>
 <CAPUexz-L=3O0qCkLWiW2UxUfJ0ryOLfO2w7A=kacOLoFui7ceA@mail.gmail.com>
 <7305be37366a5eadf5a3114efe1b0383@webmail.vanderster.com> <CAPUexz8GhXyNPmxkF2DDwdGppndVOWHnmX9YjO=E-HgDejmXEQ@mail.gmail.com>
 <alpine.DEB.2.00.1409211246120.27396@cobra.newdream.net> <CAPUexz_cV+MPfS9YXqDfcoh_TvKtSwxj-mQLvBstez7x3wHABw@mail.gmail.com>
 <CAPUexz-TnRRhDTG7+h4-etDkT0+ep-oea6-hEyLsobd9Dv-KNQ@mail.gmail.com>
 <C207F487-4FD4-45FF-AE41-6A0E706C9D38@cern.ch> <CAPUexz8MBvCbPaYYk2SWQqbgSLYBqmOArVwZkNqgH-=E0_V7cQ@mail.gmail.com>
 <alpine.DEB.2.00.1409231700150.27396@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:61332 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbaIXXCM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Sep 2014 19:02:12 -0400
Received: by mail-qc0-f173.google.com with SMTP id r5so2077690qcx.32
        for <ceph-devel@vger.kernel.org>; Wed, 24 Sep 2014 16:02:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409231700150.27396@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Dan Van Der Ster <daniel.vanderster@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Sep 24, 2014 at 1:05 AM, Sage Weil <sweil@redhat.com> wrote:
> Sam and I discussed this on IRC and have we think two simpler patches that
> solve the problem more directly.  See wip-9487.

So I understand this makes Dan's patch (and the config parameter that
it introduces) unnecessary, but is it correct to assume that just like
Dan's patch yours too will not be effective unless osd snap trim sleep
> 0?

> Queued for testing now.
> Once that passes we can backport and test for firefly and dumpling too.
>
> Note that this won't make the next dumpling or firefly point releases
> (which are imminent).  Should be in the next ones, though.

OK, just in case anyone else runs into problems after removing tons of
snapshots with <=0.67.11, what's the plan to get them going again
until 0.67.12 comes out? Install the autobuild package from the wip
branch?

Cheers,
Florian
