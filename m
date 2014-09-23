From: Gregory Farnum <greg@inktank.com>
Subject: Re: snap_trimming + backfilling is inefficient with many purged_snaps
Date: Tue, 23 Sep 2014 13:00:18 -0700
Message-ID: <CAPYLRzi6Zd7QDnrQ4SyC+iM0XALQ-XcO+FPeEkTzknoC87zX1A@mail.gmail.com>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
	<07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com>
	<CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com>
	<alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net>
	<CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
	<alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net>
	<CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com>
	<1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch>
	<CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com>
	<alpine.DEB.2.00.1409190819070.18018@cobra.newdream.net>
	<63ccef299522995cc0704e349ef86503@webmail.vanderster.com>
	<CAME-gARt1NZmEFj6SCpxkfxnibXyR7+AdYKO4YNkQc_n+XJuXQ@mail.gmail.com>
	<CAPUexz-L=3O0qCkLWiW2UxUfJ0ryOLfO2w7A=kacOLoFui7ceA@mail.gmail.com>
	<7305be37366a5eadf5a3114efe1b0383@webmail.vanderster.com>
	<CAPUexz8GhXyNPmxkF2DDwdGppndVOWHnmX9YjO=E-HgDejmXEQ@mail.gmail.com>
	<alpine.DEB.2.00.1409211246120.27396@cobra.newdream.net>
	<CAPUexz_cV+MPfS9YXqDfcoh_TvKtSwxj-mQLvBstez7x3wHABw@mail.gmail.com>
	<CAPUexz-TnRRhDTG7+h4-etDkT0+ep-oea6-hEyLsobd9Dv-KNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:53265 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbaIWUAT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Sep 2014 16:00:19 -0400
Received: by mail-qa0-f54.google.com with SMTP id n8so2129323qaq.41
        for <ceph-devel@vger.kernel.org>; Tue, 23 Sep 2014 13:00:18 -0700 (PDT)
In-Reply-To: <CAPUexz-TnRRhDTG7+h4-etDkT0+ep-oea6-hEyLsobd9Dv-KNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Sage Weil <sweil@redhat.com>, Dan van der Ster <daniel.vanderster@cern.ch>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 23, 2014 at 6:20 AM, Florian Haas <florian@hastexo.com> wrote:
> On Mon, Sep 22, 2014 at 7:06 PM, Florian Haas <florian@hastexo.com> wrote:
>> On Sun, Sep 21, 2014 at 9:52 PM, Sage Weil <sweil@redhat.com> wrote:
>>> On Sun, 21 Sep 2014, Florian Haas wrote:
>>>> So yes, I think your patch absolutely still has merit, as would any
>>>> means of reducing the number of snapshots an OSD will trim in one go.
>>>> As it is, the situation looks really really bad, specifically
>>>> considering that RBD and RADOS are meant to be super rock solid, as
>>>> opposed to say CephFS which is in an experimental state. And contrary
>>>> to CephFS snapshots, I can't recall any documentation saying that RBD
>>>> snapshots will break your system.
>>>
>>> Yeah, it sounds like a separate issue, and no, the limit is not
>>> documented because it's definitely not the intended behavior. :)
>>>
>>> ...and I see you already have a log attached to #9503.  Will take a look.
>>
>> I've already updated that issue in Redmine, but for the list archives
>> I should also add this here: Dan's patch for #9503, together with
>> Sage's for #9487, makes the problem go away in an instant. I've
>> already pointed out that I owe Dan dinner, and Sage, well I already
>> owe Sage pretty much lifelong full board. :)
>
> Looks like I was bit too eager: while the cluster is behaving nicely
> with these patches while nothing happens to any OSDs, it does flag PGs
> as incomplete when an OSD goes down. Once the mon osd down out
> interval expires things seem to recover/backfill normally, but it's
> still disturbing to see this in the interim.
>
> I've updated http://tracker.ceph.com/issues/9503 with a pg query from
> one of the affected PGs, within the mon osd down out interval, while
> it was marked incomplete.
>
> Dan or Sage, any ideas as to what might be causing this?

That *looks* like it's just because the pool has both size and
min_size set to 2?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
