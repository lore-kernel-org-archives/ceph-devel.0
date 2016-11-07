From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: include linux/crush/mapper.h in crush/mapper.c
Date: Mon, 7 Nov 2016 19:38:53 +0100
Message-ID: <CAOi1vP9bmfZ2QaXqOP5MnX3bLnf9s2j1XjgNqzxiuoQQeanTkA@mail.gmail.com>
References: <20161028112324.14850-1-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36860 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932635AbcKGSiy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2016 13:38:54 -0500
Received: by mail-ua0-f193.google.com with SMTP id 12so6394187uas.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2016 10:38:54 -0800 (PST)
In-Reply-To: <20161028112324.14850-1-tklauser@distanz.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Oct 28, 2016 at 1:23 PM, Tobias Klauser <tklauser@distanz.ch> wrote=
:
> Include linux/crush/mapper.h in crush/mapper.c to get the prototypes of
> crush_find_rule and crush_do_rule which are defined there. This fixes
> the following GCC warnings when building with 'W=3D1':
>
>   net/ceph/crush/mapper.c:40:5: warning: no previous prototype for =E2=80=
=98crush_find_rule=E2=80=99 [-Wmissing-prototypes]
>   net/ceph/crush/mapper.c:793:5: warning: no previous prototype for =E2=
=80=98crush_do_rule=E2=80=99 [-Wmissing-prototypes]
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  net/ceph/crush/mapper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
> index a421e905331a..407bd146ba9e 100644
> --- a/net/ceph/crush/mapper.c
> +++ b/net/ceph/crush/mapper.c
> @@ -17,6 +17,7 @@
>  # include <linux/kernel.h>
>  # include <linux/crush/crush.h>
>  # include <linux/crush/hash.h>
> +# include <linux/crush/mapper.h>
>  #else
>  # include "crush_compat.h"
>  # include "crush.h"

Applied.

Thanks,

                Ilya
