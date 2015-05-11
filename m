From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu vivid
 : big difference
Date: Mon, 11 May 2015 16:15:00 +0200 (CEST)
Message-ID: <329575275.188003362.1431353700154.JavaMail.zimbra@oxygem.tv>
References: <1658395363.138804047.1431248752885.JavaMail.zimbra@oxygem.tv> <1493232379.166886818.1431323625432.JavaMail.zimbra@oxygem.tv> <5550B289.8010903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:39933 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbbEKOPD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 10:15:03 -0400
In-Reply-To: <5550B289.8010903@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: cbt <cbt@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, Stefan Priebe <s.priebe@profihost.ag>

>>Isn't Wheezy a pretty old kernel too? (like 3.2?

Yes, but for my test, I have used 3.16 kernel from wheezy-backport. (sa=
me than jessie)

So no kernel difference, it must be something in librairies.






----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>, "cbt" <cbt@ceph.com>, "ceph-=
devel" <ceph-devel@vger.kernel.org>
Cc: "Stefan Priebe" <s.priebe@profihost.ag>
Envoy=C3=A9: Lundi 11 Mai 2015 15:45:45
Objet: Re: [Cbt] client fio-rbd benchmark : debian wheezy vs ubuntu viv=
id : big difference

On 05/11/2015 12:53 AM, Alexandre DERUMIER wrote:=20
> Seem that's is ok too on debian jessie (with an extra boost with rbd_=
cache true)=20
>=20
> Maybe is it related to old glibc on debian wheezy ?=20
>=20
>=20
>=20
>=20
>=20
> debian jessie: rbd_cache=3Dfalse : iops=3D202985 : %Cpu(s): 21,9 us, =
9,5 sy, 0,0 ni, 66,1 id, 0,0 wa, 0,0 hi, 2,6 si, 0,0 st=20
> debian jessie: rbd_cache=3Dtrue : iops=3D215290 : %Cpu(s): 27,9 us, 1=
0,8 sy, 0,0 ni, 58,8 id, 0,0 wa, 0,0 hi, 2,6 si, 0,0 st=20
>=20
>=20
> ubuntu vivid : rbd_cache=3Dfalse : iops=3D201089 %Cpu(s): 21,3 us, 12=
,8 sy, 0,0 ni, 61,8 id, 0,0 wa, 0,0 hi, 4,1 si, 0,0 st=20
> ubuntu vivid : rbd_cache=3Dtrue : iops=3D197549 %Cpu(s): 27,2 us, 15,=
3 sy, 0,0 ni, 53,2 id, 0,0 wa, 0,0 hi, 4,2 si, 0,0 st=20
> debian wheezy : rbd_cache=3Dfalse: iops=3D161272 %Cpu(s): 28.4 us, 15=
=2E4 sy, 0.0 ni, 52.8 id, 0.0 wa, 0.0 hi, 3.4 si, 0.0 st=20
> debian wheezy : rbd_cache=3Dtrue : iops=3D135893 %Cpu(s): 30.0 us, 15=
=2E5 sy, 0.0 ni, 51.5 id, 0.0 wa, 0.0 hi, 3.0 si, 0.0 st=20


Isn't Wheezy a pretty old kernel too? (like 3.2?) There's been a ton of=
=20
changes since then. Originally I was thinking this might have been some=
=20
of the new network/inode optimizations in 3.18+ for vivid, but if Jesse=
=20
is better maybe it's some of the other kernel changes (or perhaps it's=20
glibc or something else). FWIW, we've noticed a pretty significant=20
performance improvement going from CentOS 6.5 to RHEL7 on the same=20
hardware. Haven't looked very deeply into it, but there definitely=20
appears to be an advantage to running modern distributions.=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
