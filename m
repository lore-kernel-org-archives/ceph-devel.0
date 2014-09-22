From: Florian Haas <florian@hastexo.com>
Subject: Re: snap_trimming + backfilling is inefficient with many purged_snaps
Date: Mon, 22 Sep 2014 19:06:38 +0200
Message-ID: <CAPUexz_cV+MPfS9YXqDfcoh_TvKtSwxj-mQLvBstez7x3wHABw@mail.gmail.com>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
 <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com> <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com>
 <alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net> <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
 <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net> <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com>
 <1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch> <CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com>
 <alpine.DEB.2.00.1409190819070.18018@cobra.newdream.net> <63ccef299522995cc0704e349ef86503@webmail.vanderster.com>
 <CAME-gARt1NZmEFj6SCpxkfxnibXyR7+AdYKO4YNkQc_n+XJuXQ@mail.gmail.com>
 <CAPUexz-L=3O0qCkLWiW2UxUfJ0ryOLfO2w7A=kacOLoFui7ceA@mail.gmail.com>
 <7305be37366a5eadf5a3114efe1b0383@webmail.vanderster.com> <CAPUexz8GhXyNPmxkF2DDwdGppndVOWHnmX9YjO=E-HgDejmXEQ@mail.gmail.com>
 <alpine.DEB.2.00.1409211246120.27396@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:61048 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbaIVRG7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Sep 2014 13:06:59 -0400
Received: by mail-qg0-f51.google.com with SMTP id a108so3174517qge.24
        for <ceph-devel@vger.kernel.org>; Mon, 22 Sep 2014 10:06:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409211246120.27396@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Dan van der Ster <daniel.vanderster@cern.ch>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Sep 21, 2014 at 9:52 PM, Sage Weil <sweil@redhat.com> wrote:
> On Sun, 21 Sep 2014, Florian Haas wrote:
>> So yes, I think your patch absolutely still has merit, as would any
>> means of reducing the number of snapshots an OSD will trim in one go=
=2E
>> As it is, the situation looks really really bad, specifically
>> considering that RBD and RADOS are meant to be super rock solid, as
>> opposed to say CephFS which is in an experimental state. And contrar=
y
>> to CephFS snapshots, I can't recall any documentation saying that RB=
D
>> snapshots will break your system.
>
> Yeah, it sounds like a separate issue, and no, the limit is not
> documented because it's definitely not the intended behavior. :)
>
> ...and I see you already have a log attached to #9503.  Will take a l=
ook.

I've already updated that issue in Redmine, but for the list archives
I should also add this here: Dan's patch for #9503, together with
Sage's for #9487, makes the problem go away in an instant. I've
already pointed out that I owe Dan dinner, and Sage, well I already
owe Sage pretty much lifelong full board. :)

Everyone with a ton of snapshots in their clusters (not sure where the
threshold is, but it gets nasty somewhere between 1,000 and 10,000 I
imagine) should probably update to 0.67.11 and 0.80.6 as soon as they
come out, otherwise Terrible Things Will Happen=E2=84=A2 if you're ever=
 forced
to delete a large number of snaps at once.

Thanks again to Dan and Sage,
=46lorian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
