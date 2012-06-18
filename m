From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: stable 10GBE under 3.4.2 or 3.5.0-rc2
Date: Mon, 18 Jun 2012 10:11:11 +0200 (CEST)
Message-ID: <12a25ef8-317d-4f47-bfea-8bded75bd233@mailpro>
References: <4FDEDB7F.4070600@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:58376 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab2FRILe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 04:11:34 -0400
In-Reply-To: <4FDEDB7F.4070600@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

maybe try to play with net.ipv4.tcp_congestion_control ?=20



The available algorithms are:=20

    =E2=80=A2 BIC - The default on Gentoo=20
    =E2=80=A2 Reno - The classic TCP protocol. Most OSes use this.=20
    =E2=80=A2 highspeed - HighSpeed TCP: Sally Floyd's suggested algori=
thm=20
    =E2=80=A2 htcp - Hamilton TCP=20
    =E2=80=A2 hybla - For Satellite Links=20
    =E2=80=A2 scalable - Scalable TCP=20
    =E2=80=A2 vegas - Vegas TCP=20
    =E2=80=A2 westwood - Optimized for lossy networks=20

http://lwn.net/Articles/128681/

The High-speed TCP algorithm is optimized for very fat pipes - 10G Ethe=
rnet and such. When things are congested, it behaves much like the Reno=
 algorithm. When the congestion window is being increased, however, the=
 high-speed algorithm makes use of a table to pick large increment valu=
es. This approach lets the congestion window get very large (i.e. tens =
of thousands of segments) quickly, and to stay large, without requiring=
 that the network function for long periods of time without a single dr=
opped packet.



----- Mail original -----

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 18 Juin 2012 09:40:47=20
Objet: stable 10GBE under 3.4.2 or 3.5.0-rc2=20

Hi list,=20

i've still problems with stable network speed under recent kernels. Wit=
h=20
3.0.32 i get stable 9.90 Gbit/s in both directions. With 3.4.2 or=20
3.5.0-rc2 it drops sometimes down to around 1 Gbit/s. Sadly i've no ide=
a=20
when this happen? It works sometimes for minutes at 9.9Gbit/s and then=20
suddently only with 3-4Gbit/s or even 1Gbit/s using recent kernels.=20

I'm using various tunings recommanded by intel (Improving Performance)=20
=3D> http://downloadmirror.intel.com/5874/eng/README.txt=20

Has anybody a hint for me or additional settings intel does not mention=
?=20

Stefan=20
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
