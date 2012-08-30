From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: Ceph + RBD + Xen: Complete collapse -> Network issue in domU
 / Bad data for OSD / OOM Kill
Date: Thu, 30 Aug 2012 16:14:27 +0200
Message-ID: <503F7543.6090309@smart-weblications.de>
References: <CAF6-1L5t9CGk_kB08UPKdrOhQeZZXdbr5n+we1Oae+STpodxtg@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:36038 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752570Ab2H3OOF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Aug 2012 10:14:05 -0400
In-Reply-To: <CAF6-1L5t9CGk_kB08UPKdrOhQeZZXdbr5n+we1Oae+STpodxtg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: xen-users@lists.xen.org, ceph-devel@vger.kernel.org

Am 30.08.2012 16:06, schrieb Sylvain Munaut:
> Hi,
>=20
>=20
> So something is going _very_ wrong here .... any suggestions from any=
one ?
>=20
> Note that when using the exact same setup on a dom0 that doesn't run
> any OSD in a domU, it works fine. Also, only the OSD running under
> that dom0 is affected, the rest of the cluster is working nicely.

I would suggest trying kvm instead of xen...

     "net eth0: rx->offset: 0, size: 4294967295"

Seems that there is something wrong with networking code in xen?


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
