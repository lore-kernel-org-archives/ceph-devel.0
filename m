From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: stripping of ceph class objects
Date: Fri, 17 Dec 2010 14:53:36 +0800
Message-ID: <1292568816.1795.42.camel@cephhost>
References: <AANLkTiko9b3h46WcQU_z8PMwMatmRc1Jh-OY4S6j0R=M@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:3457 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751226Ab0LQH2X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Dec 2010 02:28:23 -0500
In-Reply-To: <AANLkTiko9b3h46WcQU_z8PMwMatmRc1Jh-OY4S6j0R=M@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>, Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org, sage <sage@newdream.net>



=E5=9C=A8 2010-12-17=E4=BA=94=E7=9A=84 07:35 +0800=EF=BC=8CYehuda Sadeh=
 Weinraub=E5=86=99=E9=81=93=EF=BC=9A
> Hi Laszlo,
>=20
>  we just installed the latest ceph debian packages and it seems that
> the class objects (that are installed in /usr/lib/rados-classes/) are
> stripped. We need to keep a few symbols visible on those shared
> objects, namely, all the symbols that start with '__cls_'. Our regula=
r
> automake resulted binaries keeps those symbols, but I guess that the
> debian packaging strips them.

Hi ,
If only stripped debugging symbols and sections,
Could which keep these symbols ?

Like this:
------------
strip --strip--debug rados-classes/libcls_rbd.so.1.0.0
strip --strip--debug libceph.so.1.0.0=20
strip --strip--debug libcrush.so.1.0.0 =20
strip --strip--debug librados.so.1.0.0 =20


> These symbols have the class name and version in them, which helps us
> in cases where the ceph installation is running on a cluster that
> consists of multiple architectures. A script running on the monitor
> thus should be able to identify the class name and version no matter
> what its architecture is.
>=20
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
