From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Fri, 29 Jun 2012 13:32:38 +0200 (CEST)
Message-ID: <7ac7ca20-a94a-43e4-bb27-4b28b8e5f29c@mailpro>
References: <4FED8792.1090905@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:57061 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab2F2LdB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 07:33:01 -0400
In-Reply-To: <4FED8792.1090905@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

I see something strange with my tests:

3 nodes (8cores E5420  @ 2.50GHz) , 5 osd (xfs) by node with 15k drives=
, journal on tmpfs


kvm guest, with cache=3Dwriteback or cache=3Dnone (same result):

random write test with 4k block: 5000iop/s , cpu idle 20%
sequential write test with 4k block: 20000iop/s , cpu idle 80%  (I'm sa=
turating my gibagit link)


So what's the difference in osd between random or sequential write if b=
lock have same size ?



----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Vendredi 29 Juin 2012 12:46:42=20
Objet: speedup ceph / scaling / find the bottleneck=20

Hello list,=20

i've made some further testing and have the problem that ceph doesn't=20
scale for me. I added a 4th osd server to my existing 3 node osd=20
cluster. I also reformated all to be able to start with a clean system.=
=20

While doing random 4k writes from two VMs i see about 8% idle on the os=
d=20
servers (Single Intel Xeon E5 8 cores 3,6Ghz). I believe that this is=20
the limiting factor and also the reason why i don't see any improvement=
=20
by adding osd servers.=20

3 nodes: 2VMS: 7000 IOp/s 4k writes osds: 7-15% idle=20
4 nodes: 2VMS: 7500 IOp/s 4k writes osds: 7-15% idle=20

Even the cpu is not the limiting factor i think it would be really=20
important to lower the CPU usage while doing 4k writes. The CPU is only=
=20
used by the ceph-osd process. I see nearly no usage by other processes=20
(only 5% by kworker and 5% flush).=20

Could somebody recommand me a way to debug this? So we know where all=20
this CPU usage goes?=20

Stefan=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
