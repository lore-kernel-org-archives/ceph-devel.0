From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Problem using librados
Date: Fri, 28 Oct 2011 16:22:07 +0530
Message-ID: <CAMiHsJKtwp_xKKMa_=WscZK7H8cG8YXHMX=x0USw7poW8HENBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39385 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229Ab1J1Kw3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2011 06:52:29 -0400
Received: by bkbzt4 with SMTP id zt4so317728bkb.19
        for <ceph-devel@vger.kernel.org>; Fri, 28 Oct 2011 03:52:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello developers,

This is a users query. Please help out.
I am trying to use the librados-dev library to use RADOS components of =
Ceph.
I have got Ceph installed on my machine, and the rados command line
shows me a pool named "data" when I say "rados lspools". I have also
tried out creating objects in this pool and it works perfectly.
However, when I try to access the same pool "data" through my C code,
by using librados.h, my code compiles and links fine but at run time I
get this error:-

$./a.out: cannot open rados pool data: No such file or directory

My code is as follows:-
#include <stdio.h>
#include "rados/librados.h"
main(int argc, char *argv[])
{
=A0 =A0 =A0 =A0 int err;
=A0 =A0 =A0 =A0 rados_t cluster;
=A0 =A0 =A0 =A0 err =3D rados_create(&cluster, NULL);
=A0 =A0 =A0 =A0 if (err < 0) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("%s: cannot open a rados connect=
ion: %s\n",
argv[0], strerror(-err));
=A0 =A0 =A0 =A0 }
=A0 =A0 =A0 =A0 rados_ioctx_t io;
=A0 =A0 =A0 =A0 char *poolname =3D "data";
=A0 =A0 =A0 =A0 err =3D rados_ioctx_create(cluster, poolname, &io);
//<--------------------This line is causing the problem. Why am I not
able to access the pool?
=A0 =A0 =A0 =A0 if (err < 0) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("%s: cannot open rados pool %s: =
%s\n", argv[0],
poolname, strerror(-err));
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rados_shutdown(cluster);
=A0 =A0 =A0 =A0 }
=A0 =A0 =A0 =A0 err =3D rados_write_full(io, "BITARRAY", "hello", 5);
=A0 =A0 =A0 =A0 if (err < 0) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("%s: cannot write pool %s: %s\n"=
, argv[0],
poolname, strerror(-err));
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rados_ioctx_destroy(io);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rados_shutdown(cluster);
=A0 =A0 =A0 =A0 }
}

To show that the pool "data" exists, here's the output of the command
line rados tool:-
$ rados lspools
data
metadata
rbd


Please help me out.

Thank you.

Regards
Atish
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
