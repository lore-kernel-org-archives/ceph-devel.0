From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: speed decrease since firefly,giant,hammer the 2nd try
Date: Wed, 11 Feb 2015 07:04:24 +0100 (CET)
Message-ID: <219811534.358960.1423634664783.JavaMail.zimbra@oxygem.tv>
References: <54DA541E.9000608@profihost.ag> <54DA578F.3000900@redhat.com> <54DA5853.3070504@profihost.ag> <54DA5E9F.3060305@redhat.com> <54DA6904.6000305@profihost.ag> <54DA6BB9.7000306@redhat.com> <54DA7404.4060201@profihost.ag> <54DA7A3F.6070009@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:53057 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbbBKGE0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 01:04:26 -0500
In-Reply-To: <764258391.358931.1423634637318.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, ceph-devel <ceph-devel@vger.kernel.org>

>=20
> mhm i installed librbd1-dbg and librados2-dbg - but the output still=20
> looks useless to me. Should i upload it somewhere?=20

>>Meh, if it's all just symbols it's probably not that helpful.=20

Last Time I have done perf, even with all debug packages (ceph debug pa=
ckage, kernel debug, libc6 debug package,..)

I have remaining unresolved symbols

Sage Have run my perf report through c++filt, to have missing symbols.

see here:

http://article.gmane.org/gmane.comp.file-systems.ceph.devel/22089/match=
=3Dclient+cpu+usage+kbrd+vs+librbd+perf+report


----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "Stefan Priebe" <s.priebe@profihost.ag>, "ceph-devel" <ceph-dev=
el@vger.kernel.org>
Envoy=C3=A9: Mardi 10 F=C3=A9vrier 2015 22:38:07
Objet: Re: speed decrease since firefly,giant,hammer the 2nd try

On 02/10/2015 03:11 PM, Stefan Priebe wrote:=20
>=20
> mhm i installed librbd1-dbg and librados2-dbg - but the output still=20
> looks useless to me. Should i upload it somewhere?=20

Meh, if it's all just symbols it's probably not that helpful.=20

I've summarized your results here:=20

1 concurrent 4k write (libaio, direct=3D1, iodepth=3D1)=20

IOPS Latency=20
wb on wb off wb on wb off=20
dumpling 10870 536 ~100us ~2ms=20
firefly 10350 525 ~100us ~2ms=20

So in single op tests dumpling and firefly are far closer. Now let's=20
see each of these cases with iodepth=3D32 (still 1 thread for now).=20

Mark=20

>=20
> Stefan=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
