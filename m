From: Ming Lin <minggr@gmail.com>
Subject: Re: rocksdb related build error
Date: Tue, 03 May 2016 16:28:27 -0700
Message-ID: <1462318107.23609.3.camel@gmail.com>
References: <CAF1ivSbg-n6o2_mHzCS_Y9rDZTD+ySess8TqOto-ox7MV012bA@mail.gmail.com>
	 <alpine.DEB.2.11.1605030824500.26967@cpach.fuggernut.com>
	 <CAF1ivSZ_wxv9SkGkpw3ry7Bt9+HYBse=BZ+WysPLPFD3we=fNw@mail.gmail.com>
	 <20160503225852.GA17962@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36137 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345AbcECX23 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 19:28:29 -0400
Received: by mail-pa0-f42.google.com with SMTP id bt5so16099511pac.3
        for <ceph-devel@vger.kernel.org>; Tue, 03 May 2016 16:28:29 -0700 (PDT)
In-Reply-To: <20160503225852.GA17962@degu.b.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, John Spray <john.spray@redhat.com>

On Tue, 2016-05-03 at 18:58 -0400, Marcus Watts wrote:
> On Tue, May 03, 2016 at 02:15:49PM -0700, Ming Lin wrote:
> > On Tue, May 3, 2016 at 5:26 AM, Sage Weil <sage@newdream.net>
> > wrote:
> > > On Tue, 3 May 2016, Ming Lin wrote:
> > > > Hi John,
> > > >=20
> > > > I got rocksdb related build error (commit bb7d9c15).
> > > > Any hint to fix it?
> > > >=20
> > > > It's OK if I build in the ceph source tree.
> > >=20
> > > Out of tree builds don't work currently with autotools.
> >=20
> > I just learned a bit about autotools.
> > https://en.wikipedia.org/wiki/GNU_Build_System
> >=20
> > Could you share what the problem is here to support out-of-tree
> > build?
> > I'll try to write a patch to fix it.
>=20
> I looked at this fairly recently.
>=20
> rocksdb comes with a cmake (only used for windows), and makefile
> build.
> The makefile build doesn't use autotools, it's just a gnu makefile.
> gnu make does support out of tree builds, but the rocksdb file
> doesn't
> do that.=C2=A0=C2=A0So, it wants to find all its source wherever it's
> installed,
> and it puts all the .o's in the same place - So: no separate build
> possible.
> This is a problem for both automake & cmake.
>=20
> You could change the makefile to work "out of tree", but it won't
> be pretty.=C2=A0=C2=A0Probably you would be adding some "VPATH" state=
ments,
> add -I as necessary, and you'd have to work within the structure
> of the file which I think seemed a bit more complicated than
> necessary.

Here is my quick hack. Just add ${srcdir}
It's not real "out of tree" because rocksdb is still build in the tree
actually.

diff --git a/src/kv/Makefile.am b/src/kv/Makefile.am
index b876171..0dd754c 100644
--- a/src/kv/Makefile.am
+++ b/src/kv/Makefile.am
@@ -21,8 +21,8 @@ if FREEBSD
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NPROC =3D sysctl =
-n hw.ncpu
=C2=A0endif
=C2=A0rocksdb/librocksdb.a:
-	cd rocksdb && CC=3D"${CC}" CXX=3D"${CXX}" EXTRA_CXXFLAGS=3D-fPIC PORT=
ABLE=3D1 $(MAKE) -j$(shell ${NPROC}) static_lib
-libkv_a_CXXFLAGS +=3D -I rocksdb/include -fPIC
+	cd ${srcdir}/rocksdb && CC=3D"${CC}" CXX=3D"${CXX}" EXTRA_CXXFLAGS=3D=
-fPIC PORTABLE=3D1 $(MAKE) -j$(shell ${NPROC}) static_lib
+libkv_a_CXXFLAGS +=3D -I ${srcdir}/rocksdb/include -fPIC
=C2=A0libkv_a_SOURCES +=3D kv/RocksDBStore.cc
=C2=A0libkv_a_LIBADD +=3D rocksdb/librocksdb.a
=C2=A0noinst_HEADERS +=3D kv/RocksDBStore.h
diff --git a/src/os/Makefile.am b/src/os/Makefile.am
index 6d22778..4305fe2 100644
--- a/src/os/Makefile.am
+++ b/src/os/Makefile.am
@@ -61,7 +61,7 @@ if WITH_LIBZFS
=C2=A0libos_a_SOURCES +=3D os/filestore/ZFSFileStoreBackend.cc
=C2=A0endif
=C2=A0
-libos_a_CXXFLAGS =3D ${AM_CXXFLAGS} -I rocksdb/include -fPIC
+libos_a_CXXFLAGS =3D ${AM_CXXFLAGS} -I ${srcdir}/rocksdb/include -fPIC
=C2=A0libos_a_LIBADD =3D libos_types.a libkv.a
=C2=A0noinst_LIBRARIES +=3D libos.a
=C2=A0
diff --git a/src/test/Makefile-server.am b/src/test/Makefile-server.am
index fbb42e4..2aaa635 100644
--- a/src/test/Makefile-server.am
+++ b/src/test/Makefile-server.am
@@ -227,7 +227,7 @@ endif # WITH_OSD
=C2=A0if WITH_SLIBROCKSDB
=C2=A0unittest_rocksdb_option_static_SOURCES =3D test/objectstore/TestR=
ocksdbOptionParse.cc
=C2=A0unittest_rocksdb_option_static_LDADD =3D $(LIBOS) $(UNITTEST_LDAD=
D) $(CEPH_GLOBAL)
-unittest_rocksdb_option_static_CXXFLAGS =3D $(UNITTEST_CXXFLAGS) ${AM_=
CXXFLAGS} ${LIBROCKSDB_CFLAGS} -I rocksdb/include
+unittest_rocksdb_option_static_CXXFLAGS =3D $(UNITTEST_CXXFLAGS) ${AM_=
CXXFLAGS} ${LIBROCKSDB_CFLAGS} -I ${srcdir}/rocksdb/include
=C2=A0check_TESTPROGRAMS +=3D unittest_rocksdb_option_static
=C2=A0endif
=C2=A0
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
