From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: [ceph-users] rbd rm <image> results in osd marked down wrongly
 with 0.61.3
Date: Thu, 13 Jun 2013 14:25:36 +0200
Message-ID: <51B9BA40.6040901@smart-weblications.de>
References: <51B731F7.2050002@smart-weblications.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:58021 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755006Ab3FMMZR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 13 Jun 2013 08:25:17 -0400
In-Reply-To: <51B731F7.2050002@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com

Hi,

Is really no one on the list interrested in fixing this? Or am i the on=
ly one
having this kind of bug/problem?

Am 11.06.2013 16:19, schrieb Smart Weblications GmbH - Florian Wiessner=
:
> Hi List,
>=20
> i observed that an rbd rm <image> results in some osds mark one osd a=
s down
> wrongly in cuttlefish.
>=20
> The situation gets even worse if there are more than one rbd rm <imag=
e> running
> in parallel.
>=20
> Please see attached logfiles. The rbd rm command was issued on 20:24:=
00 via
> cronjob, 40 seconds later the osd 6 got marked down...
>=20
>=20
> ceph osd tree
>=20
> # id    weight  type name       up/down reweight
> -1      7       pool default
> -3      7               rack unknownrack
> -2      1                       host node01
> 0       1                               osd.0   up      1
> -4      1                       host node02
> 1       1                               osd.1   up      1
> -5      1                       host node03
> 2       1                               osd.2   up      1
> -6      1                       host node04
> 3       1                               osd.3   up      1
> -7      1                       host node06
> 5       1                               osd.5   up      1
> -8      1                       host node05
> 4       1                               osd.4   up      1
> -9      1                       host node07
> 6       1                               osd.6   up      1
>=20
>=20
> I have seen some patches to parallelize rbd rm, but i think there mus=
t be some
> other issue, as my clients seem to not be able to do IO when ceph is
> recovering... I think this has worked better in 0.56.x - there was IO=
 while
> recovering.
>=20
> I also observed in the log of osd.6 that after heartbeat_map reset_ti=
meout, the
> osd tries to connect to the other osds, but it retries so fast that y=
ou could
> think this is a DoS attack...
>=20
>=20
> Please advise..
>=20


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
