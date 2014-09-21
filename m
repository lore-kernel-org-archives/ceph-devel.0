From: Florian Haas <florian@hastexo.com>
Subject: Re: snap_trimming + backfilling is inefficient with many purged_snaps
Date: Sun, 21 Sep 2014 15:33:09 +0200
Message-ID: <CAPUexz-L=3O0qCkLWiW2UxUfJ0ryOLfO2w7A=kacOLoFui7ceA@mail.gmail.com>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
 <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch> <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com>
 <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com>
 <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com> <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com>
 <alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net> <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
 <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net> <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com>
 <1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch> <CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com>
 <alpine.DEB.2.00.1409190819070.18018@cobra.newdream.net> <63ccef299522995cc0704e349ef86503@webmail.vanderster.com>
 <CAME-gARt1NZmEFj6SCpxkfxnibXyR7+AdYKO4YNkQc_n+XJuXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34137 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbaIUNda (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Sep 2014 09:33:30 -0400
Received: by mail-qg0-f41.google.com with SMTP id j107so557904qga.28
        for <ceph-devel@vger.kernel.org>; Sun, 21 Sep 2014 06:33:29 -0700 (PDT)
In-Reply-To: <CAME-gARt1NZmEFj6SCpxkfxnibXyR7+AdYKO4YNkQc_n+XJuXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alphe Salas <asalas@kepler.cl>
Cc: Dan van der Ster <daniel.vanderster@cern.ch>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Sat, Sep 20, 2014 at 9:08 PM, Alphe Salas <asalas@kepler.cl> wrote:
> Real field testings and proof workout are better than any unit testing ... I
> would follow Dan s notice of resolution because it based on real problem and
> not fony style test ground.

That statement is almost an insult to the authors and maintainers of
the testing framework around Ceph. Therefore, I'm taking the liberty
to register my objection.

That said, I'm not sure that wip-9487-dumpling is the final fix to the
issue. On the system where I am seeing the issue, even with the fix
deployed, osd's still not only go crazy snap trimming (which by itself
would be understandable, as the system has indeed recently had
thousands of snapshots removed), but they also still produce the
previously seen ENOENT messages indicating they're trying to trim
snaps that aren't there.

That system, however, has PGs marked as recovering, not backfilling as
in Dan's system. Not sure if wip-9487 falls short of fixing the issue
at its root. Sage, whenever you have time, would you mind commenting?

Cheers,
Florian
