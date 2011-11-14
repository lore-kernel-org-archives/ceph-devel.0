From: Sage Weil <sage@newdream.net>
Subject: Re: rbd - input/output error
Date: Mon, 14 Nov 2011 13:39:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111141338160.3717@cobra.newdream.net>
References: <4EBF98B5.7040706@b1-systems.de> <Pine.LNX.4.64.1111141148220.29742@cobra.newdream.net>
 <4EC18864.4010308@b1-systems.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1759018362-1321306768=:3717"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38527 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab1KNVj3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 16:39:29 -0500
In-Reply-To: <4EC18864.4010308@b1-systems.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mario van der Linde <linde@b1-systems.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1759018362-1321306768=:3717
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 14 Nov 2011, Mario van der Linde wrote:
> Hello,
>=20
> On 14.11.2011 20:48, Sage Weil wrote:
> > On Sun, 13 Nov 2011, Mario van der Linde wrote:
> [...]
> >>> ceph1:~ # modprobe rbd
> >>> ceph1:~ # rbd create testimg --size 10240
> >>> create error: error 5: Input/output error
> >=20
> > Can you try with=20
> >=20
> >  rbd create testmsg --size 10240 --log-to-stderr --debug-ms 1
> >=20
> > so we can see a bit more about what is going on?
>=20
> This one gave me some output:
> rbd create testimg --size=3D10240 --log-to-stderr 2 --debug-ms 2
>=20
> See attached file.

It sounds like the OSD can't find the libcls_rbd.so file.  Can you verify=
=20
that it is in /usr/lib/rados-classes, and that that location isn't be=20
overridden by something in ceph.conf?

sage


>=20
> Additional Info:
> > ceph5:~ # modinfo rbd
> > filename:       /lib/modules/3.1.0-rc9-1-desktop/kernel/drivers/block/r=
bd.ko
> > license:        GPL
> > author:         Jeff Garzik <jeff@garzik.org>
> > description:    rados block device
> > author:         Yehuda Sadeh <yehuda@hq.newdream.net>
> > author:         Sage Weil <sage@newdream.net>
> > srcversion:     C8F4E38D4A716AB32B9F75C
> > depends:       =20
> > vermagic:       3.1.0-rc9-1-desktop SMP preempt mod_unload modversions
>=20
>=20
> Regards
> Mario
>=20
>=20
> --=20
> Mario van der Linde
> Linux Consultant & Trainer
> Tel.: +49-151-16879485
> Mail: linde@b1-systems.de
>=20
> B1 Systems GmbH
> Osterfeldstra=DFe 7 / 85088 Vohburg / http://www.b1-systems.de
> GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537
>=20
--557981400-1759018362-1321306768=:3717--
