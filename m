From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Fri, 25 May 2012 17:47:53 +0200 (CEST)
Message-ID: <96b57450-8d24-48df-8a82-b9bec2ff3c69@mailpro>
References: <4FBF76A8.3080206@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:34102 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab2EYPsP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 11:48:15 -0400
In-Reply-To: <4FBF76A8.3080206@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Hi Stephan,
Do you have same performance with read ?

Did you have done some iostats ?
how much time to flush from journal to disks ?

----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Vendredi 25 Mai 2012 14:10:16=20
Objet: Re: poor OSD performance using kernel 3.4=20

Even with v3.3-rc1 is pretty often 0.=20

Am 25.05.2012 13:31, schrieb Stefan Priebe - Profihost AG:=20
>=20
> Some speed tests with different Kernel Versions. The same applies to=20
> other FS like btrfs.=20
> I used "rados -p data bench 100 write -t 16" for all tests and a fres=
hly=20
> created FS. mount options were always: noatime,nodiratime,nobarrier.=20
>=20
> 3.0.30 with XFS=20
>=20
> speed is always between 120 and 160MB/s=20
>=20
> Total time run: 100.510061=20
> Total writes made: 3605=20
> Write size: 4194304=20
> Bandwidth (MB/sec): 143.468=20
>=20
> Average Latency: 0.445714=20
> Max latency: 1.99929=20
> Min latency: 0.084812=20
>=20
> 3.2.18 with XFS=20
>=20
> speed is between 40 and 170MB/s=20
>=20
> Total time run: 100.795653=20
> Total writes made: 3384=20
> Write size: 4194304=20
> Bandwidth (MB/sec): 134.292=20
>=20
> Average Latency: 0.476297=20
> Max latency: 2.92075=20
> Min latency: 0.084884=20
>=20
> 3.3.7 with XFS=20
>=20
> !! speed heavily jumps between 0 and 170 MB/s !!=20
>=20
> Total time run: 107.398166=20
> Total writes made: 2455=20
> Write size: 4194304=20
> Bandwidth (MB/sec): 91.435=20
>=20
> Average Latency: 0.699819=20
> Max latency: 13.8117=20
> Min latency: 0.084624=20
>=20
> 3.4 with XFS=20
>=20
> !! speed heavily jumps between 0 and 130 MB/s - most if the time it's=
=20
> near 0 !!=20
>=20
> Total time run: 115.433531=20
> Total writes made: 468=20
> Write size: 4194304=20
> Bandwidth (MB/sec): 16.217=20
>=20
> Average Latency: 3.9452=20
> Max latency: 53.4356=20
> Min latency: 0.091276=20
>=20
>=20
> Stefan=20
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
