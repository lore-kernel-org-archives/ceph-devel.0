From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 13:40:05 +0200 (CEST)
Message-ID: <70f814ae-c265-4778-bd6c-7dbbe6f9952f@mailpro>
References: <201206041147.22993.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:45922 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2FDLke convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 07:40:34 -0400
In-Reply-To: <201206041147.22993.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org, Yann Dupont <Yann.Dupont@univ-nantes.fr>

Hi,=20

I'm currently doing some tests with xfs, debian wheezy with standard li=
bc6 (2.11.3-3) and 3.2 kernel.

I'm doing some iostats(3 nodes with 5 osd), and I see constant writes t=
o disks.(as the datas are flushed each second from journal to disk).

Journal is big enough (20GB tmpfs) to handle 30s of write.

Do you think it's related to the missing syncfs() support ?

-Alexandre


----- Mail original -----=20

De: "Amon Ott" <a.ott@m-privacy.de>=20
=C3=80: "Yann Dupont" <Yann.Dupont@univ-nantes.fr>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 4 Juin 2012 11:47:22=20
Objet: Re: Infiniband 40GB=20

On Monday 04 June 2012 you wrote:=20
> Le 04/06/2012 10:23, Stefan Majer a =C3=A9crit :=20
> > Hi Hannes,=20
> >=20
> > our production environment is running on 10GB infrastructure. We ha=
d a=20
> > lot of troubles till we got to where we are today.=20
> > We use Intel X520 D2 cards on our OSD=C2=B4s and nexus switch=20
> > infrastructure. All other cards we where testing failed horrible.=20
>=20
> we have Intel Corporation 82599EB 10 Gigabit Dual Port Backplane=20
> Connection (rev 01)... Don't know the 'commercial name'. ixgbe driver=
=2E=20
>=20
> > Some of the problems we encountered have been:=20
> > - page allocation failures in the ixgbe driver --> fixed in upstrea=
m=20
> > - problems with jumbo frames, we had to disable tso, gro, lro -- >=20
> > this is the most obscure thing=20
> > - various tuning via sysctl in the net.tcp and net.ipv4 area --> th=
is=20
> > was also the outcome of stefan=C2=B4s benchmarking odysee.=20
>=20
> some tuning we made :=20
>=20
> -> Turning off Virtualisation extension in BIOS. Don't know why, but =
it=20
> gaves us crappy performance. We usually put it on, because we use KVM=
 a=20
> lot. In our case, OSD are in bare metal and disabling virtualisation=20
> extension gives us a very big boost.=20
> It may be a BIOS bug in our machines (DELL M610).=20
>=20
> -> One of my colleague played with receive flow steeting ; the intel=20
> card supports multi queue, so it seems we can gain a little with it :=
=20
>=20
> !/bin/sh=20
>=20
> for x in $(seq 0 23); do echo FFFFFFFF >=20
> /sys/class/net/eth2/queues/rx-${x}/rps_cpus; done=20
> echo 16384 > /proc/sys/net/core/rps_sock_flow_entries=20
> for x in $(seq 0 23); do echo 16384 >=20
> /sys/class/net/eth2/queues/rx-${x}/rps_flow_cnt; done=20
>=20
> > But after all this we a quite happy actully and are only limited by=
=20
> > the speed of the drives (2TB SATA).=20
> > The fsync is a fdatasync in fact which is available in newer glibc.=
 If=20
> > you dont use btrfs (we use xfs) you need to use a recent glibc with=
=20
> > fdatasync support.=20
>=20
> Does it may explain why we see loosy performance with xfs right now ?=
=20
> That the main reason we're stuck with btrfs for the moment.=20
>=20
> we're using debian 'stable' : libc is=20
> libc6 2.11.3-3=20
> probably too old ?=20

One reason for performance problems with that libc6 version is missing=20
syncfs() support. I backported a patch for 2.13, originally by Andreas=20
Schwab, schwab@redhat.com, to Debian stable code. Patch is attached.=20

Copy the patch to eglibc's debian/patches/, add to debian/patches/serie=
s,=20
rebuild eglibc packages (including libc6) with dpkg-buildpackage, insta=
ll new=20
libc6-dev, rebuild ceph packages against it, install and retry. AFAIK, =
not=20
even libc6 in Debian experimental has syncfs() support.=20

Also see thread "OSD deadlock with cephfs client and OSD on same machin=
e"=20

Amon Ott=20
--=20
Dr. Amon Ott=20
m-privacy GmbH Tel: +49 30 24342334=20
Am K=C3=B6llnischen Park 1 Fax: +49 30 24342336=20
10179 Berlin http://www.m-privacy.de=20

Amtsgericht Charlottenburg, HRB 84946=20

Gesch=C3=A4ftsf=C3=BChrer:=20
Dipl.-Kfm. Holger Maczkowsky,=20
Roman Maczkowsky=20

GnuPG-Key-ID: 0x2DD3A649=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
