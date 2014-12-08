From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: CEPH & Shared RBD Volumes
Date: Mon, 08 Dec 2014 19:19:52 +0100
Message-ID: <5485EBC8.2010407@smart-weblications.de>
References: <88C3E003BB3649489ED4ECA6C80410476B9D8E@ORSMSX102.amr.corp.intel.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.smart-weblications.de ([188.65.144.61]:48581 "EHLO
	mail.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752066AbaLHSTy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Dec 2014 13:19:54 -0500
In-Reply-To: <88C3E003BB3649489ED4ECA6C80410476B9D8E@ORSMSX102.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Cook, Nigel" <nigel.cook@intel.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Nigel,

Am 08.12.2014 15:30, schrieb Cook, Nigel:
> Folks,
>=20
> Can CEPH support 2 clients simultaneously accessing a single volume -=
 for example a database cluster - and honor read and write order of blo=
cks across the multiple clients?
>=20

Yes, we use ocfs2 ontop of rbd, gfs2 should also work...

--=20

Mit freundlichen Gr=FC=DFen,

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
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
