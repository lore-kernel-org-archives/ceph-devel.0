From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Newbie question about metadata_list.
Date: Thu, 6 Aug 2015 15:01:54 +0300
Message-ID: <CAOi1vP-S8zui8vwhbzc1i7t=LLJx6PW2Lmtg-OeZectL_umpFA@mail.gmail.com>
References: <20150806112630.d3c4ed783a07dfefb0d6dbc6@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34446 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbbHFMB4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 08:01:56 -0400
Received: by wicne3 with SMTP id ne3so19616263wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2015 05:01:55 -0700 (PDT)
In-Reply-To: <20150806112630.d3c4ed783a07dfefb0d6dbc6@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?=C5=81ukasz_Szymczyk?= <lukasz.szymczyk@corp.ovh.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Aug 6, 2015 at 12:26 PM, =C5=81ukasz Szymczyk
<lukasz.szymczyk@corp.ovh.com> wrote:
> Hi,
>
> I'm writing some program to replace image in cluster with it's copy.
> But I have problem with metadata_list.
> I created pool:
> #rados mkpool dupa
> then I created image:
> #rbd create --size 1000 -p mypool image --image-format 2
>
> Below is code which tries to get metadata, but it fails with -EOPNOTS=
UPP.
> I compile it with command like this:
> g++ file.cpp -lrbd -lrados -I/ceph/source/directory/src
>
> #include <stdio.h>
> #include <stdlib.h>
> #include "include/rbd/librbd.h"
> #include "include/rbd/librbd.hpp"
> using namespace ceph;
> #include "librbd/ImageCtx.h"
>
> int main() {
>         rados_t clu;
>         int ret =3D rados_create(&clu, NULL);
>         if (ret) return -1;
>
>         ret =3D rados_conf_read_file(clu, NULL);
>         if (ret) return -1;
>
>         rados_conf_parse_env(clu, NULL);
>         ret =3D rados_connect(clu);
>         if (ret) return -1;
>
>         rados_ioctx_t io;
>         ret =3D rados_ioctx_create(clu, "mypool", &io);
>         if (ret) return -1;
>
>         rbd_image_t im;
>         ret =3D rbd_open(io, "image", &im, NULL);
>         if (ret) return -1;
>
>         librbd::ImageCtx *ic =3D (librbd::ImageCtx*)im;
>         std::string start;
>         int max =3D 1000;
>         bufferlist in, out;
>         ::encode(start, in);
>         ::encode(max, in);
>         ret =3D ((librados::IoCtx*)&io)->exec(ic->header_oid, "rbd", =
"metadata_list", in, out);
>         if (ret < 0) printf("fail\n");

You should use rbd_metadata_list() C API instead of this.

>
>         return 0;
>
> }
>
> So, my question is: what should be set/enabled to get those metadata?
> Or maybe what I'm doing wrong here.

Try "rbd image-meta list image"?

It's a fairly recent feature, are you sure your OSDs support it?
What's the output of "ceph daemon osd.0 version"?

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
