From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: ceph kernel client orientation
Date: Thu, 21 May 2020 15:15:43 +0200
Message-ID: <CAOi1vP8kz0PpBDwpp78pHP-gT5-FpcNcQ7L6omd_pj8fyOZLFw@mail.gmail.com>
References: <6n.cjI5.4P7G519BQ1k.1Um{AC@seznam.cz> <CAOi1vP9HvJd-Cdm4TnfEjNN-PooZCAPBwANpS88UfinkhJuUsg@mail.gmail.com>
 <da.cjLX.3v4GDfOKIZE.1UnDtd@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgEUNPi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2020 09:15:38 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B61C061A0E
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2020 06:15:38 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f3so7400281ioj.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2020 06:15:38 -0700 (PDT)
In-Reply-To: <da.cjLX.3v4GDfOKIZE.1UnDtd@seznam.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal.Plsek@seznam.cz
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, May 20, 2020 at 9:36 AM <Michal.Plsek@seznam.cz> wrote:
>
> Thanks for swift answer.
>
> (This is my usage in librbd.cc)
>
> Basically there is a folder with symmetric keys used for block encryption=
, one key for one disk in some pool. For identification of key I need (pool=
_id, disk_id) of block. I am temporarily saving key to librbd::ImageCtx str=
ucture, so I don't have to get it from file every time. I use this key to e=
ncrypt/decrypt block data. Encrypt/decrypt is primitive, I'm not gonna ment=
ion it here, but it is done over the data provided by functions rbd_read() =
and rbd_write().
>
> If you could point how to edit rbd.c content to achieve similar behaviour=
, I would be much obliged.

I'm not sure what exactly you mean by disk id, but I assume image
id (displayed by "rbd info" in block_name_prefix field) is probably
part of that.  It is looked up in rbd_dev_image_id(), called from
rbd_dev_image_probe().  More generally, do_rbd_add() is roughly
equivalent to rbd_open() in librbd.  Everything related to "opening"
the image is done in or under do_rbd_add().

struct rbd_device is passed pretty much everywhere, so if you are
storing a key in librbd::ImageCtx, struct rbd_device is probably
the place to put it.

As for encryption, the easiest would probably be to stick it into
__rbd_img_fill_request().  But I want to stress that bolting on
your own crypto is very error-prone and highly unlikely to produce
anything remotely secure.  Unless you are doing it to get familiar
with the codebase or just for fun, I would advise against it.

Thanks,

                Ilya
