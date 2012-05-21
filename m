From: Tommi Virtanen <tv@inktank.com>
Subject: Re: ceph 0.47 libs3 install problem
Date: Mon, 21 May 2012 13:22:15 -0700
Message-ID: <CADvuQRG5EGBq2DB3L71RHKahT8z40mZ=sSPkEaPf2gPTgki+Xg@mail.gmail.com>
References: <CAPud5_7UKKe-=GNfWnJEut179Nz6oBdegrKX5Xoyo4Vj7oL4cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49785 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883Ab2EUUWh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 16:22:37 -0400
Received: by dady13 with SMTP id y13so7265973dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 13:22:37 -0700 (PDT)
In-Reply-To: <CAPud5_7UKKe-=GNfWnJEut179Nz6oBdegrKX5Xoyo4Vj7oL4cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>, Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, May 21, 2012 at 1:14 PM, Nick Bartos <nick@pistoncloud.com> wro=
te:
> I'm trying to install ceph 0.47, but --prefix isn't getting passed to
> the bundled libs3. =C2=A0I installed libs3 separately, but even when =
using
> --with-system-libs3 (as ./configure suggests) or
> --with-system-libs3=3Dyes (just for the hell of it), it still install=
s
> libs3, and outside of the prefix it was given.
>
> Anyone know of a way to either get ceph's libs3 to be installed in
> --prefix, or to get it to use the system one instead?

Hmm. I just noticed this: src/Makefile.am has

SUBDIRS =3D ocf libs3
=2E..
if WITH_SYSTEM_LIBS3
rest_bench_LDADD +=3D -ls3
else
rest_bench_LDADD +=3D libs3/build/lib/libs3.a -lcurl -lxml2
rest_bench_CXXFLAGS +=3D -I$(top_srcdir)/src/libs3/inc
SUBDIRS +=3D libs3
endif

I'm guessing the top SUBDIRS assignment should not have libs3 there,
and that's the source of your trouble. Yehuda, can you confirm &
commit a fix?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
