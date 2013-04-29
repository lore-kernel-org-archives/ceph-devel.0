From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: fecpp C++ forward error correction library
Date: Mon, 29 Apr 2013 15:06:09 +0100
Message-ID: <DCA8968A-375A-4E51-84D3-425E22E81375@tchpc.tcd.ie>
References: <sfid-H20130422-141929-+033.82-1@marduk.tchpc.tcd.ie> <517538D7.6050706@dachary.org>  (sfid-H20130422-141929-+033.82-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:45458 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab3D2ONf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 10:13:35 -0400
In-Reply-To: <517538D7.6050706@dachary.org>  (sfid-H20130422-141929-+033.82-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Christopher LILJENSTOLPE <cdl@asgaard.org>, Ceph Development <ceph-devel@vger.kernel.org>, Jack Lloyd <lloyd@randombit.net>


On 22 Apr 2013, at 14:19, Loic Dachary wrote:

> Hi Christopher,
>=20
> Jack Lloyd is the author of fecpp ( http://www.randombit.net/code/fec=
pp/ ) and he tells me someone sent him a new SIMD approach a few weeks =
ago. I'm not sure what SIMD means yet, but I'll figure it out ;-). I te=
nd to favor fecpp because it is more self contained and may be easier t=
o embed than https://pypi.python.org/pypi/zfec
>=20
> Cheers
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20


Having played with zfec (more the underlying fec.[c,h] file) it's well =
written and self-contained as I remember it; but you will need to write=
 a bunch of wrapper functions to chunk up data and pad out blocks and o=
f course turn it into a library before you can use the underlying zfec =
implementation for ceph. If my memory is right, zfec's c code requires =
a C90 or C99 compiler to build it, I'm not sure if you care about that.

Regards,
Jimmy Tang

--
Senior Software Engineer, Digital Repository of Ireland (DRI)
High Performance & Research Computing, IS Services
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/ | jtang@tchpc.tcd.ie
Tel: +353-1-896-3847

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
