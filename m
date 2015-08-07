From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: rbd object map
Date: Fri, 7 Aug 2015 10:56:24 +0300
Message-ID: <CAOi1vP9XvZnFiALrMH4CptsaDVG=Jq=8KBXWEt6fgrcvgqOOBg@mail.gmail.com>
References: <CAJDfis=dmeWAnKCbK-jvoA2WHGAuzkUR_f2gLRuDOJKs=04U_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38115 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbbHGH40 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Aug 2015 03:56:26 -0400
Received: by wibxm9 with SMTP id xm9so54839030wib.1
        for <ceph-devel@vger.kernel.org>; Fri, 07 Aug 2015 00:56:24 -0700 (PDT)
In-Reply-To: <CAJDfis=dmeWAnKCbK-jvoA2WHGAuzkUR_f2gLRuDOJKs=04U_A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Max Yehorov <myehorov@skytap.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Aug 7, 2015 at 9:13 AM, Max Yehorov <myehorov@skytap.com> wrote:
> Hi,
>
> Object map feature was added in hammer. It is possible to create and
> delete an image with object map enabled using rbd, though it is not
> possible to map the image which has object map or exclusive lock
> features enabled, e.g.:
>
>   ceph@ceph1:~$ rbd create foo --size=42 --image-format=2 --image-features=15
>   ceph@ceph1:~$ sudo rbd map foo
>   rbd: sysfs write failed
>   rbd: map failed: (6) No such device or address
>
>
> I checked rbd.c in linux/drivers/block/rbd.c, it looks like that it
> only supports layering and striping as of kernel 4.1 branch.

Correct, and note that RBD_FEATURE_STRIPINGV2 is only partially
supported - you can map a STRIPINGV2 image only if it was created
with default striping parameters, i.e. you didn't specify --stripe-unit
or --stripe-count at create time.

>
>   #define RBD_FEATURE_LAYERING    (1<<0)
>   #define RBD_FEATURE_STRIPINGV2  (1<<1)
>   #define RBD_FEATURES_ALL \
>         (RBD_FEATURE_LAYERING | RBD_FEATURE_STRIPINGV2)
>
>   /* Features supported by this (client software) implementation. */
>
>   #define RBD_FEATURES_SUPPORTED  (RBD_FEATURES_ALL)
>
> Is object map a partial feature in hammer? If so, will there be a
> complete support of object map in some upcoming ceph release?

ceph releases and kernel releases are not tied together.  object map is
fully supported by librbd, it's just not supported by the kernel client
yet.  Work is under way, but it won't show up in anything earlier than
kernel 4.4.

Thanks,

                Ilya
