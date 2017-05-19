From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel warnings in CEPH
Date: Fri, 19 May 2017 08:57:04 +0200
Message-ID: <CAOi1vP9aivvLi58cUE7e2r4X823yFMsiGpNSJP21QCbH=MfDqA@mail.gmail.com>
References: <20170518170613.5e1d924f@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34651 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754617AbdESG5F (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 May 2017 02:57:05 -0400
Received: by mail-ua0-f178.google.com with SMTP id u10so20852630uaf.1
        for <ceph-devel@vger.kernel.org>; Thu, 18 May 2017 23:57:05 -0700 (PDT)
In-Reply-To: <20170518170613.5e1d924f@xeon-e3>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 19, 2017 at 2:06 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> Building kernel with CEPH and warnings enabled shows several missing
> prototypes and unused variables. Please fix.
>
>
> net/ceph/ceph_common.c:62:13: warning: no previous prototype for =E2=80=
=98ceph_file_part=E2=80=99 [-Wmissing-prototypes]
> net/ceph/messenger.c: In function =E2=80=98write_partial_message_data=E2=
=80=99:
> net/ceph/messenger.c:1580:8: warning: variable =E2=80=98need_crc=E2=80=99=
 set but not used [-Wunused-but-set-variable]
> net/ceph/mon_client.c: In function =E2=80=98ceph_monmap_decode=E2=80=99:
> net/ceph/mon_client.c:46:6: warning: variable =E2=80=98version=E2=80=99 s=
et but not used [-Wunused-but-set-variable]
> net/ceph/auth_x.c: In function =E2=80=98process_one_ticket=E2=80=99:
> net/ceph/auth_x.c:146:19: warning: variable =E2=80=98blob_struct_v=E2=80=
=99 set but not used [-Wunused-but-set-variable]

I'll fix these up.

Thanks,

                Ilya
