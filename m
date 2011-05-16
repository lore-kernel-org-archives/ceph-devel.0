From: Sage Weil <sage@newdream.net>
Subject: Re: How to enable the debug symbols
Date: Mon, 16 May 2011 09:39:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105160939350.12367@cobra.newdream.net>
References: <BANLkTi=aKfr4ZpqsnhCpzREin8c5Y_sbpg@mail.gmail.com>
 <10709e0d5db695dae3ba2d07c2fe73ff.squirrel@pl1.haspere.com>
 <BANLkTikCB1gAL-WPGv1u8AZk_OjD4TLgyA@mail.gmail.com>
 <77a86a15068ca287fcc7343f071f093e@pl1.haspere.com>
 <BANLkTimcMtBi0HpqxsrbJ_oQ-mkNCZctZQ@mail.gmail.com>
 <BANLkTi=Y4E2_6gjo9z0-H104GXspG1Kpng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-105716890-1305563988=:12367"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45467 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab1EPQir (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2011 12:38:47 -0400
In-Reply-To: <BANLkTi=Y4E2_6gjo9z0-H104GXspG1Kpng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Simon Tian <aixt2006@gmail.com>, YS3fpFE2ykfB@dyweni.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-105716890-1305563988=:12367
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 16 May 2011, Gregory Farnum wrote:
> Did you actually re-build the code? Configure just sets up some of the sc=
ripts:
> 1) ./configure #(with desired environment settings)
> 2) ./autogen.sh

  2.5) make clean

> 3) make #(hopefully -j8 or something)

sage



>=20
> Then you'll need to make sure that the built library is the one you're
> linking with -- how to do this varies a bit depending on your
> environment but probably the easiest way to do it is to run "make
> install".
> -Greg
>=20
> On Mon, May 16, 2011 at 5:45 AM, Simon Tian <aixt2006@gmail.com> wrote:
> > Hi,
> >
> > I tried =A0( =A0 =A0 =A0 =A0CFLAGS=3D"-march=3Dx86_64 -pipe -ggdb"
> > CXXFLAGS=3D"${CFLAGS}" =A0 =A0 =A0 ), =A0but error comes:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > root@houyi-vm06.dev.sd.aliyun.com # ./configure
> > checking build system type... x86_64-unknown-linux-gnu
> > checking host system type... x86_64-unknown-linux-gnu
> > checking target system type... x86_64-unknown-linux-gnu
> > checking for a BSD-compatible install... /usr/bin/install -c
> > checking whether build environment is sane... yes
> > checking for a thread-safe mkdir -p... /bin/mkdir -p
> > checking for gawk... gawk
> > checking whether make sets $(MAKE)... yes
> > checking for style of include used by make... GNU
> > checking for gcc... gcc
> > checking for C compiler default output file name...
> > configure: error: C compiler cannot create executables
> > See `config.log' for more details.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > So I tried ( =A0 =A0 =A0 =A0CFLAGS=3D"-pipe -ggdb" CXXFLAGS=3D"${CFLAGS=
}" =A0 =A0 =A0 ),
> > =A0all the FLAGS in the Makefile was set to "-pipe -ggdb", =A0as the
> > attachment showed..
> >
> > Hmm, but there was still "??" in the back trace:
> >
> > (gdb) bt
> > #0 =A00x00007fd007491c32 in ?? () from /usr/local/lib/libceph.so.1
> > #1 =A00x00007fd00746322d in ceph_write (fd=3D10, buf=3D0x7fff4ffe2210 "=
",
> > size=3D2097152, offset=3D0) at libceph.cc:322
> > #2 =A00x0000000000400fd3 in main (argc=3D1, argv=3D0x7fff501e23d8) at t=
estceph.cc:72
> >
> >
> >
> >
> >
> > There is a exception when running my application with libceph, so I
> > need the stack in the libceph to point the problem. It's a little
> > URGENT...But I don't know what happened in the libceph, so
> > unlucky.....Here is my stack:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > (gdb) c
> > Continuing.
> >
> > Program received signal SIGABRT, Aborted.
> > [Switching to Thread 0x40838940 (LWP 9118)]
> > 0x000000312b630265 in raise () from /lib64/libc.so.6
> > (gdb) bt
> > #0 =A00x000000312b630265 in raise () from /lib64/libc.so.6
> > #1 =A00x000000312b631d10 in abort () from /lib64/libc.so.6
> > #2 =A00x000000312debec44 in __gnu_cxx::__verbose_terminate_handler ()
> > from /usr/lib64/libstdc++.so.6
> > #3 =A00x000000312debcdb6 in ?? () from /usr/lib64/libstdc++.so.6
> > #4 =A00x000000312debcde3 in std::terminate () from /usr/lib64/libstdc++=
=2Eso.6
> > #5 =A00x000000312debceca in __cxa_throw () from /usr/lib64/libstdc++.so=
=2E6
> > #6 =A00x00007fdb4cce7a78 in ?? () from /usr/local/lib/libceph.so.1
> > #7 =A00x00007fdb4cbb4e1c in Mutex::Lock (this=3D0x66d790,
> > no_lockdep=3Dfalse) at ./common/Mutex.h:118
> > #8 =A00x00007fdb4cbcf5f4 in ?? () from /usr/local/lib/libceph.so.1
> > #9 =A00x00007fdb4cc45304 in ?? () from /usr/local/lib/libceph.so.1
> > #10 0x00007fdb4cd2b1d5 in ?? () from /usr/local/lib/libceph.so.1
> > #11 0x00007fdb4cbec038 in ?? () from /usr/local/lib/libceph.so.1
> > #12 0x00007fdb4cc6101d in ?? () from /usr/local/lib/libceph.so.1
> > #13 0x00007fdb4cc4862b in ?? () from /usr/local/lib/libceph.so.1
> > #14 0x00007fdb4cbb8641 in ?? () from /usr/local/lib/libceph.so.1
> > #15 0x00007fdb4cbf0a28 in ?? () from /usr/local/lib/libceph.so.1
> > #16 0x000000312be064a7 in start_thread () from /lib64/libpthread.so.0
> > #17 0x000000312b6d3c2d in clone () from /lib64/libc.so.6
> > (gdb)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > Thx!
> > Simon
> >
> >
> > 2011/5/15 Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>:
> >> Hi Simon!
> >>
> >> Set your CFLAGS and CXXFLAGS environment variables before calling conf=
igure
> >> and make.
> >>
> >> Example:
> >> CFLAGS=3D"-march=3Dnative -pipe -ggdb" CXXFLAGS=3D"${CFLAGS}" ./config=
ure
> >> CFLAGS=3D"-march=3Dnative -pipe -ggdb" CXXFLAGS=3D"${CFLAGS}" make
> >> etc
> >>
> >>
> >> Thanks,
> >> Dyweni
> >>
> >>
> >> On Sun, 15 May 2011 20:37:16 +0800, Simon Tian wrote:
> >>
> >>> Hi Dyweni,
> >>>
> >>> Can I do this by any options of "./configure"? or JUST modify
> >>> the Makefile manually?
> >>>
> >>> Thx!
> >>> Simon
> >>>
> >>
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-105716890-1305563988=:12367--
