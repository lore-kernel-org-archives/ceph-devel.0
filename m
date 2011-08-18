From: Sage Weil <sage@newdream.net>
Subject: Re: what's wrong with radosgw ??
Date: Wed, 17 Aug 2011 21:08:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108172106290.20343@cobra.newdream.net>
References: <CADSLUZn8_sVRz=4u_mNcVZ1oE1Y85-XheoX=vgO9ZwLKVMMpxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2022259987-1313640530=:20343"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53921 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab1HREEF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Aug 2011 00:04:05 -0400
In-Reply-To: <CADSLUZn8_sVRz=4u_mNcVZ1oE1Y85-XheoX=vgO9ZwLKVMMpxA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?wdbTycfl?= <linyouqing7@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2022259987-1313640530=:20343
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Aug 2011, =C1=D6=D3=C9=C7=E5 wrote:
> These days, I want install radosgw on two virtual machines.
> one is Centos 5.4 i386 with ceph-0.25.1 , another is fedora 14 i686
> with ceph-0.32
>=20
> while I input command # ./configure --with-radosgw
> meet a problem:
>=20
> configure: error: --with-radosgw was given but libfcgi (libfcgi-dev on
> debian) not found
> See `config.log' for more details.
>=20
> so I input  # yum install fcgi-devel
>=20
> [root@monitor2 ~]# yum list | grep fcgi
> fcgi.i686                                2.4.0-15.fc15                  @=
fedora
> fcgi-devel.i686                          2.4.0-15.fc15                  @=
fedora
> mod_fcgid.i686                           2.3.6-3.fc15                   @=
fedora
> spawn-fcgi.i686                          1.6.3-2.fc15                   @=
fedora
> fcgi-perl.i686                           2.4.0-15.fc15                  f=
edora
>=20
> [root@ceph-monitor1 ~]# yum list | grep fcgi
> fcgi.i386                             2.4.0-12.el5            installed
> fcgi-devel.i386                       2.4.0-12.el5            installed
> fcgi-perl.i386                        2.4.0-12.el5            installed
> mod_fcgid.i386                        2.2-11.el5              installed
> spawn-fcgi.i386                       1.6.3-1.el5             installed
>=20
> as shown above,I have install fcgi-devel in two machines, but the
> problem is still unsolved.

The actual check that autoconf is doing is

=09    [AC_CHECK_LIB([fcgi], [FCGX_Init],

Is /usr/lib/libfcgi.* present on your system?  I suspect it's=20
libfcgi and libfcgi-devel you need.

sage
--557981400-2022259987-1313640530=:20343--
