From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Readiness for 14.2.8 ?
Date: Thu, 13 Feb 2020 12:19:43 -0800
Message-ID: <CAMMFjmHr2R1wynMEiELYPY1R0c0mAG7GZstbFVxhF5ZvLwzCRg@mail.gmail.com>
References: <CAMMFjmGWrhC_gd3wY5SfqfSB6O=0Tp_QRAu0ibMTDPVrja2HSg@mail.gmail.com>
 <CAKn7kBnRSm0NX5Z0sfZneG98jz_pP+aH-qQJrAwkumJihpBdTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23078 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728673AbgBMUUD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2020 15:20:03 -0500
Received: by mail-qk1-f199.google.com with SMTP id d134so4548790qkc.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2020 12:19:54 -0800 (PST)
In-Reply-To: <CAKn7kBnRSm0NX5Z0sfZneG98jz_pP+aH-qQJrAwkumJihpBdTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neha Ojha <nojha@redhat.com>
Cc: dev@ceph.io, "Development, Ceph" <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>, Nathan Cutler <ncutler@suse.cz>, Casey Bodley <cbodley@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, David Zafman <dzafman@redhat.com>, "Weil, Sage" <sweil@redhat.com>, Ramana Venkatesh Raja <rraja@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@redhat.com>, ceph-qe-team <ceph-qe-team@redhat.com>, Andrew Schoen <aschoen@redhat.com>, ceph-qa <ceph-qa@ceph.com>, Matt Benjamin <mbenjamin@redhat.com>

I see more PRs tagged
https://github.com/ceph/ceph/pulls?utf8=%E2%9C%93&q=is%3Aopen+label%3Anautilus-batch-1+label%3Aneeds-qa+

Casey, are those newley tagged rgw PRs a must for 14.2.8?

All - pls remove "needs-qa" for PRs that may wait till next point
release, otherwise we are shooting at moving targets.

Thx
YuriW

On Wed, Feb 12, 2020 at 11:52 AM Neha Ojha <nojha@redhat.com> wrote:
>
> Yuri, there's nothing other than what's already in your queue from the
> rados standpoint. +1 to starting QE validation after that.
>
> Thanks,
> Neha
>
>
> On Mon, Feb 10, 2020 at 11:57 AM Yuri Weinstein <yweinste@redhat.com> wrote:
> >
> > Below is the current queue of PRs:
> > https://github.com/ceph/ceph/pulls?page=2&q=is%3Aopen+label%3Anautilus-batch-1+label%3Aneeds-qa
> >
> > Most PRs are being tested.
> > Unless there are objections, we will start QE validation as soon as
> > all PRs in this queue were merged.
> >
> > Dev leads - pls add and tag all RRs that must be included.
> >
> > Thx
> > YuriW
> >
>
