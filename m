From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: OSD Hardware questions
Date: Thu, 28 Jun 2012 17:45:15 +0200 (CEST)
Message-ID: <3069bbf7-ebcf-467f-978f-c8026befe064@mailpro>
References: <Pine.LNX.4.64.1206280831590.32016@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:41531 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab2F1Ppi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 11:45:38 -0400
In-Reply-To: <Pine.LNX.4.64.1206280831590.32016@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>

>>Have you tried adjusting 'osd op threads'? The default is 2, but bump=
ing=20
>>that to, say, 8, might give you better concurrency and throughput.=20
Not yet,I'll try that tomorrow

>>Definitely. Seeing perf/oprofile/whatever results for the osd under t=
hat=20
>>workload would be very interesting! We need to get perf going in our=20
>>testing environment...=20

I'm not an expert, but if you give me command line, I'll do it ;)


BTW : wip-flushmin improve a lot the performance with random write. I j=
ump from 1500-2000 iop/s (with spikes/slowdown),to constant 5500 iop/s.
      With btrfs, I see random write flushed each x seconds sequentiall=
y. (so it's really help with seeks)
      But with xfs,I see constant random writes...(maybe it's an xfs bu=
g...)



----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Gregory Farnum" <greg@ink=
tank.com>, ceph-devel@vger.kernel.org, "Stefan Priebe - Profihost AG" <=
s.priebe@profihost.ag>=20
Envoy=C3=A9: Jeudi 28 Juin 2012 17:33:31=20
Objet: Re: OSD Hardware questions=20

On Thu, 28 Jun 2012, Alexandre DERUMIER wrote:=20
> Hi,=20
> maybe it can help, I'm doing same tests that stefan,=20
> random write with 4K with 3 nodes with 5 osds (with 15K drives)=20
> fio --filename=3D[disk] --direct=3D1 --rw=3Drandwrite --bs=3D4k --siz=
e=3D100M --numjobs=3D50 --runtime=3D30 --group_reporting --name=3Dfile1=
=20
>=20
> I can achieve 5500io/s (disks are not at 100%)=20
>=20
> cpu is around 30%idle ( 8 cores E5420 @ 2.50GHz)=20

Have you tried adjusting 'osd op threads'? The default is 2, but bumpin=
g=20
that to, say, 8, might give you better concurrency and throughput.=20

"Mark Nelson" <mark.nelson@inktank.com> wrote:=20
> It would be interesting to see where all your CPU time is being spent=
=2E=20
> What benchmark are you using to do the random writes?=20

Definitely. Seeing perf/oprofile/whatever results for the osd under tha=
t=20
workload would be very interesting! We need to get perf going in our=20
testing environment...=20

sage=20



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
