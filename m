From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Readiness for 14.2.7 ?
Date: Fri, 14 Feb 2020 09:25:47 -0800
Message-ID: <CAMMFjmGDBQf+K5K2Zz4e6-PJS=y1YoUAEm5_X0tTUTre3EmZgA@mail.gmail.com>
References: <CAMMFjmGWrhC_gd3wY5SfqfSB6O=0Tp_QRAu0ibMTDPVrja2HSg@mail.gmail.com>
 <20200214171554.l7ibzoo64uthd2ke@jfsuselaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391151AbgBNR0D (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:26:03 -0500
Received: by mail-qk1-f197.google.com with SMTP id 24so6634159qka.16
        for <ceph-devel@vger.kernel.org>; Fri, 14 Feb 2020 09:25:58 -0800 (PST)
In-Reply-To: <20200214171554.l7ibzoo64uthd2ke@jfsuselaptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, dev@ceph.io, "Development, Ceph" <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>, Nathan Cutler <ncutler@suse.cz>, Casey Bodley <cbodley@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Neha Ojha <nojha@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, David Zafman <dzafman@redhat.com>, "Weil, Sage" <sweil@redhat.com>, Ramana Venkatesh Raja <rraja@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Lekshmanan, Abhishek" <abhishek.lekshmanan@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@redhat.com>, ceph-qe-team <ceph-qe-team@redhat.com>, Andrew Schoen <aschoen@redh>

Thank you !

Correction  - the subject line should say 14.2.7

On Fri, Feb 14, 2020 at 9:19 AM Jan Fajerski <jfajerski@suse.com> wrote:
>
> On Mon, Feb 10, 2020 at 11:57:19AM -0800, Yuri Weinstein wrote:
> >Below is the current queue of PRs:
> >https://github.com/ceph/ceph/pulls?page=3D2&q=3Dis%3Aopen+label%3Anautil=
us-batch-1+label%3Aneeds-qa
> >
> >Most PRs are being tested.
> >Unless there are objections, we will start QE validation as soon as
> >all PRs in this queue were merged.
> >
> >Dev leads - pls add and tag all RRs that must be included.
> ceph-volume is ready, al backports are merged and tested (thank you Natha=
n!).
> >
> >Thx
> >YuriW
> >
>
> --
> Jan Fajerski
> Senior Software Engineer Enterprise Storage
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>
