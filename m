From: Ana Aviles <ana@greenhost.nl>
Subject: Misdirected clients due to kernel bug?
Date: Mon, 11 Jul 2016 13:00:14 +0200
Message-ID: <57837C3E.6050505@greenhost.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smarthost1.greenhost.nl ([195.190.28.81]:51662 "EHLO
	smarthost1.greenhost.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbcGKLPY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2016 07:15:24 -0400
Received: from smtp.greenhost.nl ([213.108.104.138])
	by smarthost1.greenhost.nl with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <ana@greenhost.nl>)
	id 1bMYwc-00039B-Rz
	for ceph-devel@vger.kernel.org; Mon, 11 Jul 2016 13:00:11 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello everyone,

Last week, while deploying new disks in our cluster, we bump into what
we believe is a kernel bug. Now everything is working fine, though we
wanted to share our experience and see if other people have experienced
similar behaviour.

Steps we followed were:

1) First we removed DNE osds (that had been previously removed
from the cluster) to reuse their ids.

ceph osd crush remove osd.6
ceph auth del osd.6
ceph osd rm 6

2) Then we deployed new disks with ceph-deploy

ceph-deploy --overwrite-conf osd create ds1-ceph01:sda

We have two different pools on the cluster, hence we used the option

osd crush update on start =3D false

So we could later manually add OSDs to the desired pool with

ceph osd crush add osd.6 0.9 host=3Dds1-ceph01


We added two disks. First one looked fine, however, after adding the
second disk ceph -s started to show odd info such as some PGS on
backfill_toofull. The odd thing was that, the OSD supposed to be full
was 81% full, and the ratios are full_ratio 0.95 nearfull_ratio 0.88.

Also, monitor logs were getting flooded with messages like:

misdirected client.708156.1:1609543462 pg 2.1eff89a7 to osd.83 not
[1,83,93] in e154784/154784

On the clients we got write errors:

[20882274.721623] rbd: rbd28: result -6 xferred 2000
[20882274.773296] rbd: rbd28: write 2000 at aef404000 (4000)
[20882274.773304] rbd: rbd28: result -6 xferred 2000
[20882274.826057] rbd: rbd28: write 2000 at aef404000 (4000)
[20882274.826064] rbd: rbd28: result -6 xferred 2000

On OSDs, most of them were running:
ceph version 0.94.5 (9764da52395923e0b32908d83a9f7304401fee43)
and few of them (including the new ones) with:
ceph version 0.94.6 (e832001feaf8c176593e0325c8298e3f16dfb403)

On the clients, we were running kernel 4.1.1.

Once we rebooted clients with kernel 4.1.13 errors disappeared.

The misdirect messages made us think that there were incorrect/outdated
copies of the cluster map.

Any insights would be very welcome.

Regards,

--=20
Ana Avil=C3=A9s
Greenhost - sustainable hosting & digital security
E: ana@greenhost.nl
T: +31 20 4890444
W: https://greenhost.nl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
