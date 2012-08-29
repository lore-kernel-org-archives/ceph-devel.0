From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: qemu-rbd : savevm monitor command don't save vmstate, is it normal
 ?
Date: Wed, 29 Aug 2012 15:48:05 +0200
Message-ID: <503E1D95.6060304@smart-weblications.de>
References: <3aa58a4b-8f7f-48ac-8ab7-510924be9e2a@mailpro>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:59429 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752785Ab2H2Nru (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Aug 2012 09:47:50 -0400
In-Reply-To: <3aa58a4b-8f7f-48ac-8ab7-510924be9e2a@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

Am 29.08.2012 15:40, schrieb Alexandre DERUMIER:
> Hi,=20
>=20
> I'm trying to take a full vm state snapshot with savevm monitor comma=
nd  (qemu 0.12rc1 + rbd 0.48.1)
>=20

Have you tried qemu 1.1.1? 0.12 seems very old!


--=20

Mit freundlichen Gr=C3=BC=C3=9Fen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=C3=A4ftsf=C3=BChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
