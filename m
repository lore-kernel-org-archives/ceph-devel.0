From: Guangliang Zhao <lucienchao@gmail.com>
Subject: Re: problem:add acl code to 3.4.66
Date: Thu, 24 Oct 2013 12:04:32 +0800
Message-ID: <20131024040432.GA3425@x230>
References: <CAHHQodtsVw=GWk9ubbn+aWSeo_SjB2nXRw8ZHqD6W1wd2uR2kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:52466 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab3JXEEh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Oct 2013 00:04:37 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so1831232pde.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Oct 2013 21:04:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHHQodtsVw=GWk9ubbn+aWSeo_SjB2nXRw8ZHqD6W1wd2uR2kA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?5p2o5rab?= <koalainthetree8@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Oct 24, 2013 at 11:37:30AM +0800, =E6=9D=A8=E6=B6=9B wrote:
> Hi, Guangliang Zhao
>=20
>=20
>     Thanks for you great work!
>  I am adding the acl function for kernel 3.4.66 now.
>    and find some problems:
>         1=E3=80=81I'm not sure which kernel your code is based on, so=
 can you tell
> me the exact version of your kernel.

Based on ceph client tree(git://github.com/ceph/ceph-client.git),
commit is 53d028160f1affc6c3562e2d07bc352b53d51f2c

>         2=E3=80=81I'm almost sure that we are using different kernals=
 because I've
> found some funtions with different parms such as "posix_acl_from_xatt=
r" in
> acl.c,It's parms are (const void *value, size_t size) in 3.4.66 ,not =
like
> your code.So do you have any suggestions about my current work?

The ACL code is still under reviewing, and I don't have enough time to
handle other versions now :-(

I think you should wait the final version and backport it.

>=20
>     I'm a Chinese programer.Thanks again for your help!
>     Best wishes!
>=20
>=20
>           Mike

--=20
Best regards,
Guangliang
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
