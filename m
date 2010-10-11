From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph 0.23-rc make, slow write and client on kernel 2.6.35.7
Date: Sun, 10 Oct 2010 21:10:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010102108410.25037@cobra.newdream.net>
References: <AANLkTikqKtEC4pQP0-DKgyz+VD_14iRFL6JtSY7Y=3Nb@mail.gmail.com>
 <Pine.LNX.4.64.1010081159120.7262@cobra.newdream.net>
 <AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2041184419-1286770218=:25037"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51106 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab0JKEHo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Oct 2010 00:07:44 -0400
In-Reply-To: <AANLkTininb3-EF1__WjB9CA4w2uPxW=wUFODg=L6U2X5@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2041184419-1286770218=:25037
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 Oct 2010, DongJin Lee wrote:

> > What kind of freezes? =A0Do they resolve themselves?
> > Anything in dmesg? =A0The client in 2.6.35 should work out of the box.
>=20
> It froze and nothing happened, I can't reproduce this anymore after I
> compiled the latest kclient
> When kclient is not loaded, i.e., lsmod doesn't show ceph, and I tried
> to mount, I get this error
> "failed to parse ceph_options" I'm using 2.6.35.7 (the latest).
>=20
> I have used master-backport, but the make fails, it still complains about=
 the
> WARNING: "account_page_dirtied"
> [/home/aaa/ceph/ceph-client-standalone/ceph.ko] undefined!

Fix this.  I had the wrong kernel version on the backport #ifdef. =20
master-backport should work now.

> Again, the only thing that the 'make' work is the unstable-backport,
> I think something just went wrong, I keep getting the 'failed to parse
> error'. dmesg doesn't show anything.
>=20
> aaa@ss1:~/ceph/ceph-client-standalone$ sudo mount -t ceph
> 192.168.1.2:/ /media/ceph
> failed to parse ceph_options

This is a bug in the (outdated) -standalone.git code.  Please avoid=20
unstable and unstable-backport for now; they will be fixed later this=20
week.  master-backport should be fixed now!

Sorry about that!
sage



>=20
> Thanks
>=20
>=20
> >> so I just git the latest ceph-client-standalone, set to the master and
> >> did the make. I get
> >>
> >> WARNING: "account_page_dirtied"
> >> [/home/aaa/ceph/ceph-client-standalone/ceph.ko] undefined!
> >> =A0 LD [M] =A0/home/aaa/ceph/ceph-client-standalone/ceph.ko
> >> make[1]: Leaving directory `/usr/src/linux-headers-2.6.35-02063507-gen=
eric'
> >>
> >> So when I tried to modprobe ceph, I get
> >> FATAL: Error inserting ceph
> >> (/lib/modules/2.6.35-02063507-generic/extra/ceph.ko): Unknown symbol
> >> in module, or unknown parameter (see dmesg)
> >>
> >> dmesg just shows "ceph: Unknown symbol account_page_dirtied (err 0)"
> >
> > This symbol was introduced for 2.6.36; you need master-backport.
> >
> >> For "unstable" branch, I get lots of errors starting from
> >>
> >> make[1]: Entering directory `/usr/src/linux-headers-2.6.35-02063507-ge=
neric'
> >> =A0 CC [M] =A0/home/aaa/ceph/ceph-client-standalone/super.o
> >> /home/aaa/ceph/ceph-client-standalone/super.c:2:35: error:
> >> linux/ceph/ceph_debug.h: No such file or directory
> >> In file included from /home/aaa/ceph/ceph-client-standalone/super.c:18=
:
> >> /home/aaa/ceph/ceph-client-standalone/super.h:17:32: error:
> >> linux/ceph/libceph.h: No such file or directory
> >> In file included from /home/aaa/ceph/ceph-client-standalone/super.c:18=
:
> >> /home/aaa/ceph/ceph-client-standalone/super.h: In function ?ceph_put_c=
ap_snap?:
> >> /home/aaa/ceph/ceph-client-standalone/super.h:153: error: implicit
> >> declaration of function ?ceph_buffer_put?
> >> /home/aaa/ceph/ceph-client-standalone/super.h: At top level:
> >> /home/aaa/ceph/ceph-client-standalone/super.h:234: error: field
> >> ?i_vino? has incomplete type
> >> ...
> >>
> >> unstable-backport is the only thing that seems to modprobed,
> >> however it gives "failed to parse ceph_options" when I tried to mount.=
=2E
> >
> > You definitely need to use one of the -backport branches, unless you're
> > running on the latest kernel (the master and unstable branches don't
> > include any backport code). =A0The master-backport is probably the best
> > choice, as unstable is in a bit of limbo pending the upcoming merge
> > window, rbd, and some reorganization of the code into mulitple modules
> > (libceph, ceph, rbd).
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-2041184419-1286770218=:25037--
