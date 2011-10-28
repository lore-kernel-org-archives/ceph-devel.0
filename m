From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Problem using librados
Date: Fri, 28 Oct 2011 08:46:26 -0700
Message-ID: <3812880fa7f821d4927e30ce58f4d152@hq.newdream.net>
References: <CAMiHsJKtwp_xKKMa_=WscZK7H8cG8YXHMX=x0USw7poW8HENBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:46947 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006Ab1J1PrJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2011 11:47:09 -0400
Received: from pochacco.sd.dreamhost.com (pochacco.sd.dreamhost.com [66.33.195.34])
	by hapkido.dreamhost.com (Postfix) with ESMTP id B1B3F17BD17
	for <ceph-devel@vger.kernel.org>; Fri, 28 Oct 2011 08:47:08 -0700 (PDT)
In-Reply-To: <CAMiHsJKtwp_xKKMa_=WscZK7H8cG8YXHMX=x0USw7poW8HENBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Atish Kathpal <atish.kathpal@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 28 Oct 2011 16:22:07 +0530, Atish Kathpal
<atish.kathpal@gmail.com> wrote:
> Hello developers,
>=20
> This is a users query. Please help out.
> I am trying to use the librados-dev library to use RADOS components o=
f Ceph.
> I have got Ceph installed on my machine, and the rados command line
> shows me a pool named "data" when I say "rados lspools". I have also
> tried out creating objects in this pool and it works perfectly.
> However, when I try to access the same pool "data" through my C code,
> by using librados.h, my code compiles and links fine but at run time =
I
> get this error:-
>=20
> $./a.out: cannot open rados pool data: No such file or directory
>=20
> My code is as follows:-
> #include <stdio.h>
> #include "rados/librados.h"
> main(int argc, char *argv[])
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int err;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rados_t cluster;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D rados_create(&cluster, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("%s: c=
annot open a rados connection: %s\n",
> argv[0], strerror(-err));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

You need a couple more steps here - rados_create doesn't connect to the
cluster yet. Looks like the docs need updating for this. You need to do

the following before opening the pool (error checking omitted for
brevity):

        // get configuration info - use NULL as the path to search the
default ceph.conf locations
        rados_conf_read_file(cluster, path);
        rados_connect(cluster);

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rados_ioctx_t io;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *poolname =3D "data";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D rados_ioctx_create(cluster, pooln=
ame, &io);
> //<--------------------This line is causing the problem. Why am I not
> able to access the pool?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("%s: c=
annot open rados pool %s: %s\n", argv[0],
> poolname, strerror(-err));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rados_shutdow=
n(cluster);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D rados_write_full(io, "BITARRAY", =
"hello", 5);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("%s: c=
annot write pool %s: %s\n", argv[0],
> poolname, strerror(-err));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rados_ioctx_d=
estroy(io);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rados_shutdow=
n(cluster);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> }
>=20
> To show that the pool "data" exists, here's the output of the command
> line rados tool:-
> $ rados lspools
> data
> metadata
> rbd
>=20
>=20
> Please help me out.
>=20
> Thank you.
>=20
> Regards
> Atish

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
