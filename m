From: Nathan Cutler <presnypreklad@gmail.com>
Subject: Re: Readiness for 14.2.8 ?
Date: Thu, 13 Feb 2020 22:55:31 +0100
Message-ID: <CABNx+P8L++MhGkdqZ5U4HxL4hoEDF7MRCYiERP-VwHEfgjtENA@mail.gmail.com>
References: <CAMMFjmGWrhC_gd3wY5SfqfSB6O=0Tp_QRAu0ibMTDPVrja2HSg@mail.gmail.com>
 <CAKn7kBnRSm0NX5Z0sfZneG98jz_pP+aH-qQJrAwkumJihpBdTQ@mail.gmail.com> <CAMMFjmHr2R1wynMEiELYPY1R0c0mAG7GZstbFVxhF5ZvLwzCRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44260 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgBMVzp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Feb 2020 16:55:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so7386313oia.11
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2020 13:55:44 -0800 (PST)
In-Reply-To: <CAMMFjmHr2R1wynMEiELYPY1R0c0mAG7GZstbFVxhF5ZvLwzCRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Neha Ojha <nojha@redhat.com>, dev@ceph.io, "Development, Ceph" <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>, Nathan Cutler <ncutler@suse.cz>, Casey Bodley <cbodley@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, David Zafman <dzafman@redhat.com>, "Weil, Sage" <sweil@redhat.com>, Ramana Venkatesh Raja <rraja@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@redhat.com>, ceph-qe-team <ceph-qe-team@redhat.com>, Andrew Schoen <aschoen@redhat.com>, ceph-qa <ceph-qa@ceph.com>M

> I see more PRs tagged
> https://github.com/ceph/ceph/pulls?utf8=%E2%9C%93&q=is%3Aopen+label%3Anautilus-batch-1+label%3Aneeds-qa+
>
> Casey, are those newley tagged rgw PRs a must for 14.2.8?
>
> All - pls remove "needs-qa" for PRs that may wait till next point
> release, otherwise we are shooting at moving targets.

Sorry for putting the tags on more PRs today - it wasn't my intention
to delay start of 14.2.8 QE.

Can't we just start QE testing on what is already merged into
Nautilus? Does it really matter which PRs are tagged?

Nathan
