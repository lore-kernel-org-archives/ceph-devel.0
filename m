From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: host settings in ceph.conf when ipaddress != hostname
Date: Thu, 16 Aug 2012 22:01:05 +0200
Message-ID: <502D5181.8030900@smart-weblications.de>
References: <CACkq2moqr-VpwLpG2xcTvUfJ4Xm0EKazis4pW_M4FLuATqOHVg@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:35689 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933205Ab2HPUAn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Aug 2012 16:00:43 -0400
In-Reply-To: <CACkq2moqr-VpwLpG2xcTvUfJ4Xm0EKazis4pW_M4FLuATqOHVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

Am 16.08.2012 21:38, schrieb Travis Rhoden:
> Hi folks,
>=20
> I've seen a couple threads in the past about /etc/init.d/ceph not
> working right when the output of 'hostname' did not match the 'host'
> entry in ceph.conf.  I'm hoping you can advise me on how to get the
> following setup working.
>=20

[...]

>=20
> For the [osd.x] section I have the same question.  Is "host" mapped t=
o
> an IP address?  I would assume so, and thus I am force to put the -ib
> version of the hostname.  Is there something else I could do in this
> scenario?
>=20


I was also confused alot by this hostname settings - i think it is bad =
designed
- why not configure the daemons as any other linux daemon - just specif=
iy
ip:port to use for mon,osd and mds and done? Is there anything else oth=
er than
the initscript which needs hostnames?


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
