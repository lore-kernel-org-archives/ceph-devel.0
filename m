From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: stable 10GBE under 3.4.2 or 3.5.0-rc2
Date: Mon, 18 Jun 2012 11:21:09 +0200 (CEST)
Message-ID: <1656f33e-a77c-42aa-ac97-e351f90db724@mailpro>
References: <4FDEF0B4.208@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:40965 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab2FRJVc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 05:21:32 -0400
In-Reply-To: <4FDEF0B4.208@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

Did you use same driver version with the differents kernel version ?


Maybe try to  desactive tso,gso,... with ethtool ?


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 18 Juin 2012 11:11:16=20
Objet: Re: stable 10GBE under 3.4.2 or 3.5.0-rc2=20

Am 18.06.2012 10:11, schrieb Alexandre DERUMIER:=20
> maybe try to play with net.ipv4.tcp_congestion_control ?=20
The default on my machines and even under RHEL6 is cubic. But i've now=20
alos tried, reno, bic and highspeed. But it doesn't change anything.=20

Everything is fine under 3.0.32 and pretty bad under 3.4.X or 3.5rc2.=20

Stefan=20




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
