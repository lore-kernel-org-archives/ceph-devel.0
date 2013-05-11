From: Yann ROBIN <yann.robin@youscribe.com>
Subject: RE: Seg Fault on rgw 0.61.1 with cluster in 0.61
Date: Sat, 11 May 2013 10:02:44 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C55E232423@DB3PRD0311MB416.eurprd03.prod.outlook.com>
References: <367CC0B0FC02EE47BF7482398BD623C55E230EFF@DB3PRD0311MB416.eurprd03.prod.outlook.com>
 <367CC0B0FC02EE47BF7482398BD623C55E230F45@DB3PRD0311MB416.eurprd03.prod.outlook.com>
 <alpine.DEB.2.00.1305100825050.23708@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:45359
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754113Ab3EKKCz convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 11 May 2013 06:02:55 -0400
In-Reply-To: <alpine.DEB.2.00.1305100825050.23708@cobra.newdream.net>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

We're using ubuntu 12.04.2 with kernel 3.2.0-41-virtual.
I'll try changing removing the dbg package and install your branch Mond=
ay.


-----Message d'origine-----
De=A0: Sage Weil [mailto:sage@inktank.com]=20
Envoy=E9=A0: vendredi 10 mai 2013 17:30
=C0=A0: Yann ROBIN
Cc=A0: ceph-devel@vger.kernel.org
Objet=A0: RE: Seg Fault on rgw 0.61.1 with cluster in 0.61

On Fri, 10 May 2013, Yann ROBIN wrote:
> I've downgraded the rgw to 0.60 and I still had the same issue.

Yeah, the radosgw code is essentially identical between the two version=
s (there is a new config option but it is unused).
=20
> I returned to 0.61.1 and noticed that sometimes (1 on 10) the radosgw=
 start normally.
> I've installed debug package of librados to do some debugging and now=
 it always works...

That is disconcerting.

I've pushed wip-rgw-crash that prints some debug information in ceph::c=
rypto::init... do you mind instaling that (without debug packages
:) and seeing if you can reproduce the problem?  it should print out a =
couple of lines to stdout, but you need to run radosgw with the '-f'=20
option (which prevents fork).  hopefully the problem is reproducible in=
 that case.

What distro are you running?
sage


 >=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org=20
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Yann ROBIN
> Sent: vendredi 10 mai 2013 10:51
> To: ceph-devel@vger.kernel.org
> Subject: Seg Fault on rgw 0.61.1 with cluster in 0.61
>=20
> Hi,
>=20
> I've tried to update the rgw to 0.61.1 and now I have a segfault whil=
e connecting to the 0.61 cluster.
> The rgw with version 0.61 run fine.
>=20
> *** Caught signal (Segmentation fault) **  in thread 7fc1fec79780 =20
> ceph version 0.61.1 (56c4847ba82a92023700e2d4920b59cdaf23428d)
>  1: /usr/bin/radosgw() [0x4f19da]
>  2: (()+0xfcb0) [0x7fc1fcf0dcb0]
>  3: (ceph::crypto::init(CephContext*)+0xf) [0x7fc1fdfeb2ef]
>  4: (common_init_finish(CephContext*)+0x23) [0x7fc1fdfc33f3]
>  5: (librados::RadosClient::connect()+0x1d) [0x7fc1fde1d48d]
>  6: (RGWRados::initialize()+0x53) [0x5b5c03]
>  7: (RGWStoreManager::init_storage_provider(CephContext*, bool)+0x2c9=
)=20
> [0x5b9b39]
>  8: (main()+0x2d7) [0x4b4ed7]
>  9: (__libc_start_main()+0xed) [0x7fc1fb90176d]
>  10: /usr/bin/radosgw() [0x4b6db1]
> 2013-05-10 10:36:39.749439 7fc1fec79780 -1 *** Caught signal=20
> (Segmentation fault) **  in thread 7fc1fec79780
>=20
> --
> Yann ROBIN
> YouScribe
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
