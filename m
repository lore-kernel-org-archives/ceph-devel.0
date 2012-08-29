From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: qemu-rbd : savevm monitor command don't save vmstate, is it normal ?
Date: Wed, 29 Aug 2012 16:25:41 +0200 (CEST)
Message-ID: <1ff8d1c9-7b40-4000-badf-bd239010e36e@mailpro>
References: <503E1D95.6060304@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:46304 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845Ab2H2O0G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 10:26:06 -0400
In-Reply-To: <503E1D95.6060304@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f wiessner <f.wiessner@smart-weblications.de>
Cc: ceph-devel@vger.kernel.org

damn, I wanted to say, qemu 1.2rc1 ;)



----- Mail original -----=20

De: "Smart Weblications GmbH - Florian Wiessner" <f.wiessner@smart-webl=
ications.de>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 29 Ao=C3=BBt 2012 15:48:05=20
Objet: Re: qemu-rbd : savevm monitor command don't save vmstate, is it =
normal ?=20

Am 29.08.2012 15:40, schrieb Alexandre DERUMIER:=20
> Hi,=20
>=20
> I'm trying to take a full vm state snapshot with savevm monitor comma=
nd (qemu 0.12rc1 + rbd 0.48.1)=20
>=20

Have you tried qemu 1.1.1? 0.12 seems very old!=20


--=20

Mit freundlichen Gr=C3=BC=C3=9Fen,=20

=46lorian Wiessner=20

Smart Weblications GmbH=20
Martinsberger Str. 1=20
D-95119 Naila=20

fon.: +49 9282 9638 200=20
fax.: +49 9282 9638 205=20
24/7: +49 900 144 000 00 - 0,99 EUR/Min*=20
http://www.smart-weblications.de=20

--=20
Sitz der Gesellschaft: Naila=20
Gesch=C3=A4ftsf=C3=BChrer: Florian Wiessner=20
HRB-Nr.: HRB 3840 Amtsgericht Hof=20
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz=20



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
