From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Mon, 03 Dec 2012 21:50:41 +0100
Message-ID: <50BD10A1.5020904@smart-weblications.de>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de> <50BCFA2F.9070603@inktank.com> <50BD0243.2050109@de-punkt.de> <50BD0E16.8090901@catalyst.net.nz>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:35156 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752009Ab2LCUvH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 15:51:07 -0500
In-Reply-To: <50BD0E16.8090901@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Clarke <davidc@catalyst.net.nz>
Cc: Christopher Kunz <chrislist@de-punkt.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 03.12.2012 21:39, schrieb David Clarke:
> On 04/12/12 08:49, Christopher Kunz wrote:
>> Am 03.12.12 20:14, schrieb Josh Durgin:
>>> On 12/03/2012 11:05 AM, Oliver Francke wrote:
> Also, if you're concerned about the time it takes to reboot a machine=
 (sans
> fsck) then you may want to consider using something like kexec (kexec=
-tools
> package in Debian/Ubuntu).
>=20
> http://en.wikipedia.org/wiki/Kexec
>=20

Nice idea, but the website states "Kexec is currently available on the =
x86
32-bit platform only."


- --=20

Mit freundlichen Gr=FC=DFen,


Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

- --
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz

- --=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

- --
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC9EKEACgkQIDU7oJmNmZoUfACgtLyYHChlEy4hMZbyiGAFmBFb
59YAn2usmqe+fxSwXrkd5fpEE7mO5jCz
=3DRDiH
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
