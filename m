From: Loic Dachary <loic@dachary.org>
Subject: Re: udev events on a disk, at boot time
Date: Wed, 22 Jun 2016 14:20:41 +0200
Message-ID: <576A8299.2000404@dachary.org>
References: <57695098.50403@dachary.org>
 <CAPed3OFeAJvLy+7G8YdwJ1pdi=p+tRatpPPQ=DmsvGjr-5QouA@mail.gmail.com>
 <57696DC1.3090803@dachary.org>
 <CAPed3OFyST0oJs0SQaxKXLRSu71YYPUTu+ZpKBmaEX2QaWri8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:40419 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbcFVMax (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 08:30:53 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 1485947EC19
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 14:22:20 +0200 (CEST)
In-Reply-To: <CAPed3OFyST0oJs0SQaxKXLRSu71YYPUTu+ZpKBmaEX2QaWri8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ruben Kerkhof <ruben@rubenkerkhof.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 22/06/2016 13:33, Ruben Kerkhof wrote:
>> I wonder how my CentOS 7.2 setup is different. I'll try to reproduce=
 the problem on CentOS 7.2 as well.
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
> Meanwhile I've tried a few different things. Rolling back Ceph to
> 10.2.1 didn't help. Upgrading the kernel to 4.6 from ELrepo didn't
> help either.
>=20
> One thing that might be different between our setups is that my root
> fs is on LVM. I'll reinstall a server just to see if that matters.
>=20
> Another workaround for this that works for me is running 'udevadm
> trigger -c add -s block' after boot, this mounts the ceph volumes
> successfully.

Thanks for the additional information. It confirms that for some reason=
 I have ADD events in my test setup and you don't. Still digging.

>=20
> Kind regards,
>=20
> Ruben
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
