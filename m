From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 0/3] rbd: fix some issues around flushing notifies
Date: Tue, 17 Mar 2020 18:24:47 +0100
Message-ID: <CAOi1vP-LJPzywiFb1pyXpdFRCO0UVom8N_xCx0qQb=+oU_Q4pw@mail.gmail.com>
References: <20200317120422.3406-1-idryomov@gmail.com> <CA+aFP1DkGftqkWF6_g6Op0prYBXgv50ynfsG=yyCinLDm++uRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:43897 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQRYo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2020 13:24:44 -0400
Received: by mail-io1-f66.google.com with SMTP id n21so21836718ioo.10
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2020 10:24:43 -0700 (PDT)
In-Reply-To: <CA+aFP1DkGftqkWF6_g6Op0prYBXgv50ynfsG=yyCinLDm++uRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Mar 17, 2020 at 5:41 PM Jason Dillaman <jdillama@redhat.com> wrote:
>
> On Tue, Mar 17, 2020 at 8:06 AM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > Hello,
> >
> > A recent snapshot-based mirroring experiment exposed a deadlock on
> > header_rwsem in the error path of rbd_dev_image_probe() (i.e. "rbd
> > map").
> >
> > Thanks,
> >
> >                 Ilya
> >
> >
> > Ilya Dryomov (3):
> >   rbd: avoid a deadlock on header_rwsem when flushing notifies
> >   rbd: call rbd_dev_unprobe() after unwatching and flushing notifies
> >   rbd: don't test rbd_dev->opts in rbd_dev_image_release()
> >
> >  drivers/block/rbd.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > --
> > 2.19.2
> >
>
> The "get_snapcontext" call still going to hang (albeit in an
> interruptible state) if the image has > 510 snapshots, correct?

Yes, this has been a limitation of the messenger and its interface
since day one.  This is a krbd ticket specifically about snapshots,
but this limitation affects a lot more than that:

  https://tracker.ceph.com/issues/12874

It is engraved pretty deeply, but I'm planning to address it while
the messenger is opened up for surgery.

Thanks,

                Ilya
