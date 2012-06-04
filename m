From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 11:35:47 +0200 (CEST)
Message-ID: <d1ba3477-a5ed-488a-8785-2a37f4301ffc@mailpro>
References: <4FCC7E34.7040005@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:51068 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab2FDJgJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 05:36:09 -0400
In-Reply-To: <4FCC7E34.7040005@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Hannes Reinecke <hare@suse.de>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, Stefan Majer <stefan.majer@gmail.com>

Hi,
about this:
>> Turning off Virtualisation extension in BIOS. Don't know why, but it=
=20
>>gaves us crappy performance. We usually put it on, because we use KVM=
 a=20
>>lot. In our case, OSD are in bare metal and disabling virtualisation=20
>>extension gives us a very big boost.=20
>>It may be a BIOS bug in our machines (DELL M610).=20

It could be related to iommu, if you pass intel_iommu=3Don in grub.
I have already had this kind of problem.

When intel_iommu=3Don, Linux (completely unrelated to KVM) adds a new l=
evel
of protection which didn't exist without an IOMMU - the network card, w=
hich
without an IOMMU could write (via DMA) to any memory location, now is
not allowed - the card can only write to memory locates which the OS
wanted it to write. Theoretically, this can protect the OS against
various kinds of attacks. But what happens now is that every time that
Linux passes a new buffer to the card, it needs to change the IOMMU
mappings. This noticably slows down I/O, unfortunately.=20


----- Mail original -----=20

De: "Yann Dupont" <Yann.Dupont@univ-nantes.fr>=20
=C3=80: "Stefan Majer" <stefan.majer@gmail.com>=20
Cc: "Hannes Reinecke" <hare@suse.de>, "Stefan Priebe - Profihost AG" <s=
=2Epriebe@profihost.ag>, "Mark Nelson" <mark.nelson@inktank.com>, ceph-=
devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 4 Juin 2012 11:21:56=20
Objet: Re: Infiniband 40GB=20

Le 04/06/2012 10:23, Stefan Majer a =C3=A9crit :=20
> Hi Hannes,=20
>=20
> our production environment is running on 10GB infrastructure. We had =
a=20
> lot of troubles till we got to where we are today.=20
> We use Intel X520 D2 cards on our OSD=C2=B4s and nexus switch=20
> infrastructure. All other cards we where testing failed horrible.=20
>=20

we have Intel Corporation 82599EB 10 Gigabit Dual Port Backplane=20
Connection (rev 01)... Don't know the 'commercial name'. ixgbe driver.=20


> Some of the problems we encountered have been:=20
> - page allocation failures in the ixgbe driver --> fixed in upstream=20
> - problems with jumbo frames, we had to disable tso, gro, lro -- >=20
> this is the most obscure thing=20
> - various tuning via sysctl in the net.tcp and net.ipv4 area --> this=
=20
> was also the outcome of stefan=C2=B4s benchmarking odysee.=20

some tuning we made :=20

-> Turning off Virtualisation extension in BIOS. Don't know why, but it=
=20
gaves us crappy performance. We usually put it on, because we use KVM a=
=20
lot. In our case, OSD are in bare metal and disabling virtualisation=20
extension gives us a very big boost.=20
It may be a BIOS bug in our machines (DELL M610).=20

-> One of my colleague played with receive flow steeting ; the intel=20
card supports multi queue, so it seems we can gain a little with it :=20

!/bin/sh=20

for x in $(seq 0 23); do echo FFFFFFFF >=20
/sys/class/net/eth2/queues/rx-${x}/rps_cpus; done=20
echo 16384 > /proc/sys/net/core/rps_sock_flow_entries=20
for x in $(seq 0 23); do echo 16384 >=20
/sys/class/net/eth2/queues/rx-${x}/rps_flow_cnt; done=20


>=20
> But after all this we a quite happy actully and are only limited by=20
> the speed of the drives (2TB SATA).=20
> The fsync is a fdatasync in fact which is available in newer glibc. I=
f=20
> you dont use btrfs (we use xfs) you need to use a recent glibc with=20
> fdatasync support.=20

Does it may explain why we see loosy performance with xfs right now ?=20
That the main reason we're stuck with btrfs for the moment.=20

we're using debian 'stable' : libc is=20
libc6 2.11.3-3=20
probably too old ?=20

Cheers,=20
--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes=20
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr=20


--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



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
