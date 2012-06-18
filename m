From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: stable 10GBE under 3.4.2 or 3.5.0-rc2
Date: Mon, 18 Jun 2012 11:27:35 +0200 (CEST)
Message-ID: <c37b9070-7a30-44d1-90c7-e24cde988ffd@mailpro>
References: <1656f33e-a77c-42aa-ac97-e351f90db724@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:42169 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab2FRJ15 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 05:27:57 -0400
In-Reply-To: <1656f33e-a77c-42aa-ac97-e351f90db724@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

also , I see a new feature in 3.3

byte_queue_limits=20

1.5. Bufferbloat fighting: Byte queue limits

https://lwn.net/Articles/454390/

"Bufferbloat" is a term used to describe the latency and throughput pro=
blems caused by excessive buffering trough the several elements of a ne=
twork connection. Some tools are being developed to help to alleviate t=
hese problems, and this feature is one of them.

Byte queue limits are a configurable limit of packet data that can be p=
ut in the transmission queue of a network device. As a result one can t=
une things such that high priority packets get serviced with a reasonab=
le amount of latency whilst not subjecting the hardware queue to emptyi=
ng when data is available to send. Configuration of the queue limits is=
 in the tx-<n> sysfs directory for the queue under the byte_queue_limit=
s directory.

I see some bug report about spike:

http://www.mail-archive.com/e1000-devel@lists.sourceforge.net/msg05538.=
html



maybe can you try to play with values in

/sys/class/net/eth0/queues/tx-0/byte_queue_limits/*

----- Mail original -----=20

De: "Alexandre DERUMIER" <aderumier@odiso.com>=20
=C3=80: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 18 Juin 2012 11:21:09=20
Objet: Re: stable 10GBE under 3.4.2 or 3.5.0-rc2=20

Did you use same driver version with the differents kernel version ?=20


Maybe try to desactive tso,gso,... with ethtool ?=20


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
