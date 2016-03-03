From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [ceph-users] Problem: silently corrupted RadosGW objects caused
 by slow requests
Date: Thu, 3 Mar 2016 23:40:00 +0000
Message-ID: <robbat2-20160303T232148-550781944Z@orbis-terrarum.net>
References: <156923D1D92AF640829D4E847271EDAE522A46F435@MXMBON06.grupa.onet>
 <CAMNMNTxs46Hcaq-ZJZfYfF5m8aL9ETNjtBKr8UrdAxZFM7E=nw@mail.gmail.com>
 <156923D1D92AF640829D4E847271EDAE522A46FD66@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:59094 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbcCCXkB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Mar 2016 18:40:01 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id C4EC2340C9D
	for <ceph-devel@vger.kernel.org>; Thu,  3 Mar 2016 23:40:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <156923D1D92AF640829D4E847271EDAE522A46FD66@MXMBON06.grupa.onet>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ritter =?utf-8?B?U8WCYXdvbWly?= <Slawomir.Ritter@dreamlab.pl>
Cc: "	ceph-users@ceph.com" <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 03, 2016 at 01:55:13PM +0100, Ritter S=C5=82awomir wrote:
> Hi,
>=20
> I think this is really serious problem - again: =20
>=20
> - we silently lost S3/RGW objects in clusters=20
>=20
> Moreover, it our situation looks very similiar to described in
> uncorrected bug #13764 (Hammer) and in corrected #8269 (Dumpling).
=46YI fix in #8269 _is_ present in Hammer:
commit bd8e026f88b rgw: don't allow multiple writers to same multiobjec=
t part

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
