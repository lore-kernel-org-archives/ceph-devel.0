From: Sage Weil <sage@newdream.net>
Subject: Re: Problem while CEPH setup
Date: Thu, 8 Dec 2011 08:29:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112080827550.2448@cobra.newdream.net>
References: <CAPrqf92pUqDZznQHhnKAwFHwZh0OMWs3r-5VMjWcu_g9ds-ehQ@mail.gmail.com>
 <CAPrqf9335B=mh7KOHLr_hDv2BwTG0T54fQsWG4zMPsyOjgGw1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1625698549-1323361755=:2448"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45749 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab1LHQ3Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 11:29:16 -0500
In-Reply-To: <CAPrqf9335B=mh7KOHLr_hDv2BwTG0T54fQsWG4zMPsyOjgGw1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pankaj singh <psingh.ait@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1625698549-1323361755=:2448
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

> On Wed, Dec 7, 2011 at 12:40 PM, pankaj singh <psingh.ait@gmail.com> wrot=
e:
> > =A0 =A0Hi,
> >
> > =A0 =A0I and my friend Rohan tries to setup ceph on our machine. We are=
 new
> > =A0 =A0to ceph. We have got some issues during ceph setup.
> > =A0 =A0We have followed following steps.
> >
> > =A0 =A01. downloaded the code from Git repo.
> > =A0 =A02. compile the code. ./configure ; make
> > =A0 =A03. make install
> > =A0 =A04. created ceph.conf file.
> > =A0 =A0/------------------
> > =A0 =A0[global]
> > =A0 =A0; =A0 =A0 =A0 log dir =3D out
> > =A0 =A0; =A0 =A0 =A0 logger dir =3D log
> > =A0 =A0; =A0 =A0 =A0 chdir =3D ""
> > =A0 =A0; =A0 =A0 =A0 pid file =3D out/$type$id.pid
> > =A0 =A0; =A0 =A0 =A0 auth supported =3D cephx
> > =A0 =A0; =A0 =A0 =A0 keyring =3D /etc/ceph/$name.keyring
> > =A0 =A0[mon]
> > =A0 =A0 =A0 =A0 =A0mon data =3D /root/workera/CEPH/mondata/data/mon.$id
> >
> > =A0 =A0[osd]
> > =A0 =A0 =A0 =A0 =A0osd data =3D /root/workera/CEPH/mondata/data/osd.$id
> > =A0 =A0 =A0 =A0 =A0osd journal =3D /root/workera/CEPH/mondata/data/osd.=
$id.journal
> > =A0 =A0 =A0 =A0 =A0osd journal size =3D 1000
> >
> > =A0 =A0[mon.0]
> > =A0 =A0 =A0 =A0 =A0host =3D alpha
> > =A0 =A0 =A0 =A0 =A0mon addr =3D 192.168.56.102:6789
> >
> > =A0 =A0[osd.0]
> > =A0 =A0 =A0 =A0 =A0host =3D alpha
> > =A0 =A0 =A0 =A0 =A0btrfs devs =3D /root/workera/CEPH/mondata/data/osd0
> >
> > =A0 =A0[mds]
> > =A0 =A0 =A0 =A0 =A0debug mds =3D 1
> > =A0 =A0[mds.alpha]
> > =A0 =A0 =A0 =A0 =A0host =3D alpha
> > =A0 =A0/----------------------
> > =A0 =A05. Created the necessary directories. mkdir -p
> > /root/workera/CEPH/mondata/data
> > =A0 =A06. created a file disk "osd0" with btrfs filesystem.
> > =A0 =A07. Run mkcephfs --allhosts -c ceph.conf
> > =A0 =A0 =A0This is the error what i got:
> >
> > =A0 =A0/---------------------------
> > =A0 =A0temp dir is /tmp/mkcephfs.rvWtFT0Ddi
> > =A0 =A0preparing monmap in /tmp/mkcephfs.rvWtFT0Ddi/monmap
> > =A0 =A0/usr/local/bin/monmaptool --create --clobber --add 0
> > =A0 =A0192.168.56.102:6789 --print /tmp/mkcephfs.rvWtFT0Ddi/monmap
> > =A0 =A0/usr/local/bin/monmaptool: monmap file /tmp/mkcephfs.rvWtFT0Ddi/=
monmap
> > =A0 =A0/usr/local/bin/monmaptool: generated fsid
> > fa4b96f9-9c95-424c-b9b0-d55b83ce1d59
> > =A0 =A0epoch 0
> > =A0 =A0fsid fa4b96f9-9c95-424c-b9b0-d55b83ce1d59
> > =A0 =A0last_changed 2011-12-04 05:35:34.443071
> > =A0 =A0created 2011-12-04 05:35:34.443071
> > =A0 =A00: 192.168.56.102:6789/0 mon.0
> > =A0 =A0/usr/local/bin/monmaptool: writing epoch 0 to
> > =A0 =A0/tmp/mkcephfs.rvWtFT0Ddi/monmap (1 monitors)
> > =A0 =A0=3D=3D=3D osd.0 =3D=3D=3D
> > =A0 =A02011-12-04 05:35:34.785176 b70bc710 created object store
> > =A0 =A0/root/workera/CEPH/mondata/data/osd.0 journal
> > =A0 =A0/root/workera/CEPH/mondata/data/osd.0.journal for osd.0 fsid
> > =A0 =A0fa4b96f9-9c95-424c-b9b0-d55b83ce1d59
> > =A0 =A0creating private key for osd.0 keyring
> > /tmp/mkcephfs.rvWtFT0Ddi/keyring.osd.0
> > =A0 =A0creating /tmp/mkcephfs.rvWtFT0Ddi/keyring.osd.0
> > =A0 =A0=3D=3D=3D mds.alpha =3D=3D=3D
> > =A0 =A0creating private key for mds.alpha keyring
> > =A0 =A0/tmp/mkcephfs.rvWtFT0Ddi/keyring.mds.alpha
> > =A0 =A0creating /tmp/mkcephfs.rvWtFT0Ddi/keyring.mds.alpha
> > =A0 =A0Building generic osdmap from /tmp/mkcephfs.rvWtFT0Ddi/conf
> > =A0 =A0/usr/local/bin/osdmaptool: osdmap file '/tmp/mkcephfs.rvWtFT0Ddi=
/osdmap'

If you run just this command

=09osdmaptool --create-from-conf /tmp/osdmap -c ceph.conf

do you get the same error?

sage



> > =A0 =A0*** glibc detected *** /usr/local/bin/osdmaptool: free(): invali=
d
> > =A0 =A0pointer: 0x081e84a8 ***
> > =A0 =A0=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =A0 =A0/lib/libc.so.6(+0x6ed8b)[0xb71e6d8b]
> > =A0 =A0/lib/libc.so.6(cfree+0x9b)[0xb71eb28b]
> > =A0 =A0/usr/local/bin/osdmaptool(crush_calc_straw+0x26c)[0x8135cdc]
> > =A0 =A0/usr/local/bin/osdmaptool(crush_make_straw_bucket+0xd7)[0x8135e0=
7]
> > =A0 =A0/usr/local/bin/osdmaptool(crush_make_bucket+0xb0)[0x8135ed0]
> > =A0 =A0/usr/local/bin/osdmaptool(_ZN12CrushWrapper10add_bucketEiiiiiPiS=
0_+0x46)[0x811430c]
> > =A0 =A0/usr/local/bin/osdmaptool(_ZN6OSDMap32build_simple_crush_map_fro=
m_confEP11CephContextR12CrushWrapperRSt3mapIiPKcSt4lessIiESaISt4pairIKiS6_E=
EE+0x102)[0x8111f34]
> > =A0 =A0/usr/local/bin/osdmaptool(_ZN6OSDMap22build_simple_from_confEP11=
CephContextjR6uuid_diii+0x588)[0x8111d88]
> > =A0 =A0/usr/local/bin/osdmaptool(main+0xc80)[0x80f4d8f]
> > =A0 =A0/lib/libc.so.6(__libc_start_main+0xf3)[0xb7191003]
> > =A0 =A0/usr/local/bin/osdmaptool[0x80f3ed1]
> > =A0 =A0=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
> > =A0 =A008048000-081cf000 r-xp 00000000 08:02 802104 =A0 =A0 /usr/local/=
bin/osdmaptool
> > =A0 =A0081cf000-081d1000 r--p 00187000 08:02 802104 =A0 =A0 /usr/local/=
bin/osdmaptool
> > =A0 =A0081d1000-081d3000 rw-p 00189000 08:02 802104 =A0 =A0 /usr/local/=
bin/osdmaptool
> > =A0 =A0081d3000-081ff000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[heap=
]
> > =A0 =A0b68b2000-b68b3000 ---p 00000000 00:00 0
> > =A0 =A0b68b3000-b7178000 rw-p 00000000 00:00 0
> > =A0 =A0b7178000-b72de000 r-xp 00000000 08:02 525765 =A0 =A0 /lib/libc-2=
=2E14.1.so
> > =A0 =A0b72de000-b72e0000 r--p 00165000 08:02 525765 =A0 =A0 /lib/libc-2=
=2E14.1.so
> > =A0 =A0b72e0000-b72e1000 rw-p 00167000 08:02 525765 =A0 =A0 /lib/libc-2=
=2E14.1.so
> > =A0 =A0b72e1000-b72e4000 rw-p 00000000 00:00 0
> > =A0 =A0b72e4000-b7300000 r-xp 00000000 08:02 525771 =A0 =A0 /lib/libgcc=
_s.so.1
> > =A0 =A0b7300000-b7301000 r--p 0001b000 08:02 525771 =A0 =A0 /lib/libgcc=
_s.so.1
> > =A0 =A0b7301000-b7302000 rw-p 0001c000 08:02 525771 =A0 =A0 /lib/libgcc=
_s.so.1
> > =A0 =A0b7302000-b732b000 r-xp 00000000 08:02 525493 =A0 =A0 /lib/libm-2=
=2E14.1.so
> > =A0 =A0b732b000-b732c000 r--p 00028000 08:02 525493 =A0 =A0 /lib/libm-2=
=2E14.1.so
> > =A0 =A0b732c000-b732d000 rw-p 00029000 08:02 525493 =A0 =A0 /lib/libm-2=
=2E14.1.so
> > =A0 =A0b732d000-b740f000 r-xp 00000000 08:02 270052
> > /usr/lib/libstdc++.so.6.0.16
> > =A0 =A0b740f000-b7413000 r--p 000e2000 08:02 270052
> > /usr/lib/libstdc++.so.6.0.16
> > =A0 =A0b7413000-b7414000 rw-p 000e6000 08:02 270052
> > /usr/lib/libstdc++.so.6.0.16
> > =A0 =A0b7414000-b741c000 rw-p 00000000 00:00 0
> > =A0 =A0b741c000-b7811000 r-xp 00000000 08:02 293697
> > /usr/lib/libcryptopp.so.9.0.0
> > =A0 =A0b7811000-b7847000 r--p 003f5000 08:02 293697
> > /usr/lib/libcryptopp.so.9.0.0
> > =A0 =A0b7847000-b7849000 rw-p 0042b000 08:02 293697
> > /usr/lib/libcryptopp.so.9.0.0
> > =A0 =A0b7849000-b784d000 rw-p 00000000 00:00 0
> > =A0 =A0b784d000-b7854000 r-xp 00000000 08:02 525478 =A0 =A0 /lib/librt-=
2.14.1.so
> > =A0 =A0b7854000-b7855000 r--p 00006000 08:02 525478 =A0 =A0 /lib/librt-=
2.14.1.so
> > =A0 =A0b7855000-b7856000 rw-p 00007000 08:02 525478 =A0 =A0 /lib/librt-=
2.14.1.so
> > =A0 =A0b7856000-b785a000 r-xp 00000000 08:02 525907 =A0 =A0 /lib/libuui=
d.so.1.3.0
> > =A0 =A0b785a000-b785b000 r--p 00003000 08:02 525907 =A0 =A0 /lib/libuui=
d.so.1.3.0
> > =A0 =A0b785b000-b785c000 rw-p 00004000 08:02 525907 =A0 =A0 /lib/libuui=
d.so.1.3.0
> > =A0 =A0b785c000-b7873000 r-xp 00000000 08:02 525926 =A0 =A0 /lib/libpth=
read-2.14.1.so
> > =A0 =A0b7873000-b7874000 r--p 00016000 08:02 525926 =A0 =A0 /lib/libpth=
read-2.14.1.so
> > =A0 =A0b7874000-b7875000 rw-p 00017000 08:02 525926 =A0 =A0 /lib/libpth=
read-2.14.1.so
> > =A0 =A0b7875000-b7877000 rw-p 00000000 00:00 0
> > =A0 =A0b788c000-b788f000 rw-p 00000000 00:00 0
> > =A0 =A0b788f000-b78ae000 r-xp 00000000 08:02 525496 =A0 =A0 /lib/ld-2.1=
4.1.so
> > =A0 =A0b78ae000-b78af000 r--p 0001f000 08:02 525496 =A0 =A0 /lib/ld-2.1=
4.1.so
> > =A0 =A0b78af000-b78b0000 rw-p 00020000 08:02 525496 =A0 =A0 /lib/ld-2.1=
4.1.so
> > =A0 =A0bfdfc000-bfe1d000 rw-p 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[stac=
k]
> > =A0 =A0ffffe000-fffff000 r-xp 00000000 00:00 0 =A0 =A0 =A0 =A0 =A0[vdso=
]
> > =A0 =A0*** Caught signal (Aborted) **
> > =A0 =A0 in thread b7176710
> > =A0 =A0 ceph version 0.39-28-g4a0b00a
> > (commit:4a0b00a0f29a87965925e0b44c997bece96b9936)
> > =A0 =A0 1: (ceph::BackTrace::BackTrace(int)+0x36) [0x8107cc6]
> > =A0 =A0 2: /usr/local/bin/osdmaptool() [0x81079bd]
> > =A0 =A0 3: [0xffffe400]
> > =A0 =A0 4: (gsignal()+0x45) [0xb71a58c5]
> > =A0 =A0 5: (abort()+0x175) [0xb71a71d5]
> > =A0 =A0 6: (()+0x685ca) [0xb71e05ca]
> > =A0 =A0 7: (()+0x6ed8b) [0xb71e6d8b]
> > =A0 =A0 8: (cfree()+0x9b) [0xb71eb28b]
> > =A0 =A0 9: (crush_calc_straw()+0x26c) [0x8135cdc]
> > =A0 =A0 10: (crush_make_straw_bucket()+0xd7) [0x8135e07]
> > =A0 =A0 11: (crush_make_bucket()+0xb0) [0x8135ed0]
> > =A0 =A0 12: (CrushWrapper::add_bucket(int, int, int, int, int, int*,
> > =A0 =A0int*)+0x46) [0x811430c]
> > =A0 =A0 13: (OSDMap::build_simple_crush_map_from_conf(CephContext*,
> > =A0 =A0CrushWrapper&, std::map<int, char const*, std::less<int>,
> > =A0 =A0std::allocator<std::pair<int const, char const*> > >&)+0x102)
> > =A0 =A0[0x8111f34]
> > =A0 =A0 14: (OSDMap::build_simple_from_conf(CephContext*, unsigned int,
> > =A0 =A0uuid_d&, int, int, int)+0x588) [0x8111d88]
> > =A0 =A0 15: (main()+0xc80) [0x80f4d8f]
> > =A0 =A0 16: (__libc_start_main()+0xf3) [0xb7191003]
> > =A0 =A0 17: /usr/local/bin/osdmaptool() [0x80f3ed1]
> > =A0 =A0/usr/local/sbin/mkcephfs: line 405: 26267 Aborted
> > =A0 =A0(core dumped) $BINDIR/osdmaptool --create-from-conf $dir/osdmap =
-c
> > =A0 =A0$conf
> > =A0 =A0/-------------------------------------
> >
> > =A0 =A0This error probably occurs because of following reason
> > =A0 =A0In function crush_calc_straw while allocating "reverse" malloc g=
etting
> > =A0 =A0zero as the argument because "bucket->h.size" happens to be zero=
=2E So
> > =A0 =A0while trying to free this variable causing =A0trouble.
> >
> > =A0 =A0So, We tried a work around by putting the check for zero size in
> > =A0 =A0the start of function, which would return from the function if i=
t is zero.
> >
> > =A0 =A0 After this mkcephfs ran successfully but still
> >
> > =A0 =A0getting issues while trying to run ceph-mon.
> > =A0 =A0Now ceph-mon =A0command is unable to create ceph-mon daemon and =
hence when we
> >
> > =A0 =A0try to mount with the fuse interface or using the kernel client =
it
> > =A0 =A0does not gets mounted stating error connection failed.
> >
> > =A0 =A0Here is my machine info:
> > =A0 =A0Platform =3D OpenSuse 12.1
> > =A0 =A0kernel version =3D linux-3.1.0-1.2
> >
> > --
> > Regards,
> > Pankaj SIngh
> > Phone No: 8826266889
>=20
>=20
>=20
> --=20
> Regards,
> Pankaj SIngh
> Phone No: 8826266889
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1625698549-1323361755=:2448--
