From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: Integration work
Date: Tue, 28 Aug 2012 22:05:42 +0200
Message-ID: <20120828200542.GB17695@oder.kd-bie.de>
References: <503D0A00.2080905@inktank.com>
 <20120828185116.GC9872@oder.mch.fsc.net>
 <503D147E.9020003@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:60815 "EHLO
	smtpa2.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab2H1UGu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 16:06:50 -0400
Content-Disposition: inline
In-Reply-To: <503D147E.9020003@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Smart Weblications GmbH - Florian Wiessner <f.wiessner@smart-weblications.de>
Cc: Ross Turk <ross@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 28, 2012 at 08:57:02PM +0200, Smart Weblications GmbH - Flo=
rian Wiessner wrote:
> Am 28.08.2012 20:51, schrieb Dieter Kasper:
>=20
> > Performance enhancements - especially to reduce the latency of a si=
ngle IO / increase IOPS -
> > and a stronger engagement on the CephFS client would be very much a=
ppreciated.
> > A stable and fast CephFS client would allow an efficient integratio=
n with
> > - (clustered) NFS (v3 and v4)
> > - (clustered) Samba v4
>=20
> Have you tried ocfs2 ontop of rbd in the meanwhile until cephFS gets =
ready?
No, I haven't, but I know its limitations.

OCFS2 (like GFS/GFS2 from sistina/RH) is build on the cluster-FS design
of the 90s.
I'm looking for Cluster-FS which is based on=20
+ a system which is inherently dynamic
+ failures in a cluster are the norm, rather than an exception
+ that characters of workloads are constantly shifting over time
+ a system which is inevitably built incrementally
+ a system which is self-managing
=3D Ceph (RBD + CephFS)


Cheers,
Dieter Kasper

>=20
>=20
> --=20
>=20
> Mit freundlichen Gr=FC=DFen,
>=20
> Florian Wiessner
>=20
> Smart Weblications GmbH
> Martinsberger Str. 1
> D-95119 Naila
>=20
> fon.: +49 9282 9638 200
> fax.: +49 9282 9638 205
> 24/7: +49 900 144 000 00 - 0,99 EUR/Min*
> http://www.smart-weblications.de
>=20
> --
> Sitz der Gesellschaft: Naila
> Gesch=E4ftsf=FChrer: Florian Wiessner
> HRB-Nr.: HRB 3840 Amtsgericht Hof
> *aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Principal Consultant, Data Center Storage Architecture and Technology
=46TS CTO
=46UJITSU TECHNOLOGY SOLUTIONS GMBH
Mies-van-der-Rohe-Stra=DFe 8 / 4F
80807 M=FCnchen
Germany

Telephone:      +49 89 62060     1898
Telefax:	+49 89 62060 329 1898
Mobile: 	+49 170 8563173
Email:  	dieter.kasper@ts.fujitsu.com
Internet:       http://ts.fujitsu.com
Company Details: http://ts.fujitsu.com/imprint.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
