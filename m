From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: upgrade from 0.39 to 0.40 failed...
Date: Sat, 21 Jan 2012 17:30:28 +0100
Message-ID: <4F1AE824.3000006@smart-weblications.de>
References: <4F1ABD5C.1000907@smart-weblications.de> <4F1AE704.6010005@widodh.nl>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.smart-weblications.de ([188.65.144.37]:40774 "EHLO
	mx02.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751356Ab2AUQaN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 21 Jan 2012 11:30:13 -0500
In-Reply-To: <4F1AE704.6010005@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Am 21.01.2012 17:25, schrieb Wido den Hollander:
> Hi,
>=20
>=20
> Although I don't think it is related I'd advise you to switch from nu=
meric
> monitor names to alphanumeric names:
>=20
> A while ago this changed, I also think the configuration doesn't even=
 allow
> numeric monitors anymore? (correct me if I'm wrong!)
>=20

Well, this config used to work with 0.39 - i did not see any hint in th=
e relase
mail that i have to change something in the config - 0.40 should be mos=
tly a
stabilization release...

I can change the config etc and setup again when i am able to get my da=
ta out of
the current installation.

>>
>> i did set up ceph without cephx
>=20
> When did you enable cephx? Did you do so from the upgrade to 0.39 to =
0.40 or
> earlier?

As stated above, i did not set up ceph with authentication. so there wa=
s no
authentication used in 0.39 nor in 0.40

But now somehow authentication seems to be enforced - at least that's w=
hat i
read from the output that ceph -w gives me...


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
