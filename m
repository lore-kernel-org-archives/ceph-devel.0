From: Ming Lin <minggr@gmail.com>
Subject: Re: LibRBD QoS feature
Date: Tue, 14 Feb 2017 22:24:25 -0800
Message-ID: <CAF1ivSaPPOssLwk3gatxjR8PG3c=17dcWae3aUVbtB5GOhAJ1w@mail.gmail.com>
References: <A6B67B11-89A5-438E-B9BF-4FEE4F6A8F1C@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:38789 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdBOGY1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 01:24:27 -0500
Received: by mail-it0-f48.google.com with SMTP id c7so58066982itd.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 22:24:27 -0800 (PST)
In-Reply-To: <A6B67B11-89A5-438E-B9BF-4FEE4F6A8F1C@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 14, 2017 at 9:36 AM, LIU, Fei <james.liu@alibaba-inc.com> wrote=
:
> Hi Sage and Mark,
>    As mentioned in last Ceph weekly performance meeting, we are going to =
have a plan to have QoS with LibRBD (Not qemu QoS) if I remember right , co=
rrect?

FYI, Sage mentioned adding QoS to RADOS based on the mlock paper.
https://www.mail-archive.com/ceph-users@lists.ceph.com/msg34188.html

> Here is the background,  we are going to have lots of clients to access t=
heir own images in a pool of Ceph cluster, we don=E2=80=99t want to have pe=
rformance impact among the clients. Thanks for your input in advance.
>
>   Regards,
>   James
