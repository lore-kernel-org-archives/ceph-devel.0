From: Smart Weblications GmbH <info@smart-weblications.de>
Subject: Re: libvirtd + rbd - stale kvm after migrate
Date: Fri, 09 Dec 2011 11:03:10 +0100
Message-ID: <4EE1DCDE.503@smart-weblications.de>
References: <4EE0CE19.5060805@smart-weblications.de> <CAO47_-98p+8cB+jatjJiD4dsAvxeEYO2rBTT6Z7DQV6w64tquQ@mail.gmail.com> <4EE1D214.8030708@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:34138 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869Ab1LIKME (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Dec 2011 05:12:04 -0500
In-Reply-To: <4EE1D214.8030708@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: chb@muc.de, ceph-devel@vger.kernel.org

Am 09.12.2011 10:17, schrieb Smart Weblications GmbH - Florian Wiessner=
:
> Hi Christian,
>=20

i found the problem:

>     <type arch=3D'x86_64' machine=3D'pc-0.12'>hvm</type>

must be

<type arch=3D'x86_64' machine=3D'pc'>hvm</type>



--=20

Mit freundlichen Gr=FC=DFen,


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
