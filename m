From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Readiness for 14.2.8 ?
Date: Thu, 13 Feb 2020 14:13:12 -0800
Message-ID: <CAMMFjmE=3jEq1Gneox5uZD=-AeOsSy4p2tDgYOz04P5Bk2-jjQ@mail.gmail.com>
References: <CAMMFjmGWrhC_gd3wY5SfqfSB6O=0Tp_QRAu0ibMTDPVrja2HSg@mail.gmail.com>
 <CAKn7kBnRSm0NX5Z0sfZneG98jz_pP+aH-qQJrAwkumJihpBdTQ@mail.gmail.com>
 <CAMMFjmHr2R1wynMEiELYPY1R0c0mAG7GZstbFVxhF5ZvLwzCRg@mail.gmail.com> <CABNx+P8L++MhGkdqZ5U4HxL4hoEDF7MRCYiERP-VwHEfgjtENA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54693 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbgBMWN1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:13:27 -0500
Received: by mail-qt1-f198.google.com with SMTP id r9so4705425qtc.4
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2020 14:13:23 -0800 (PST)
In-Reply-To: <CABNx+P8L++MhGkdqZ5U4HxL4hoEDF7MRCYiERP-VwHEfgjtENA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <presnypreklad@gmail.com>
Cc: Neha Ojha <nojha@redhat.com>, dev@ceph.io, "Development, Ceph" <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>, Nathan Cutler <ncutler@suse.cz>, Casey Bodley <cbodley@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, David Zafman <dzafman@redhat.com>, "Weil, Sage" <sweil@redhat.com>, Ramana Venkatesh Raja <rraja@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@redhat.com>, ceph-qe-team <ceph-qe-team@redhat.com>, Andrew Schoen <aschoen@redhat.com>, ceph-qa <ceph-qa@ceph.com>M

If you say so yes !
:)

On Thu, Feb 13, 2020 at 1:55 PM Nathan Cutler <presnypreklad@gmail.com> wrote:
>
> > I see more PRs tagged
> > https://github.com/ceph/ceph/pulls?utf8=%E2%9C%93&q=is%3Aopen+label%3Anautilus-batch-1+label%3Aneeds-qa+
> >
> > Casey, are those newley tagged rgw PRs a must for 14.2.8?
> >
> > All - pls remove "needs-qa" for PRs that may wait till next point
> > release, otherwise we are shooting at moving targets.
>
> Sorry for putting the tags on more PRs today - it wasn't my intention
> to delay start of 14.2.8 QE.
>
> Can't we just start QE testing on what is already merged into
> Nautilus? Does it really matter which PRs are tagged?
>
> Nathan
>
