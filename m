From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: RBD performance - tuning hints
Date: Wed, 29 Aug 2012 10:50:12 +0200 (CEST)
Message-ID: <5867fa5f-5c24-4279-954a-5a1df06f3394@mailpro>
References: <20120828174842.GA9872@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:39120 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab2H2Iui convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 04:50:38 -0400
In-Reply-To: <20120828174842.GA9872@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dieter Kasper <d.kasper@kabelmail.de>
Cc: ceph-devel@vger.kernel.org

Nice results !
(can you make same benchmark from a qemu-kvm guest with virtio-driver ?=
=20
I have made some bench some month ago with stephan priebe, and we never=
 be able to have more than 20000iops, with a full ssd 3nodes cluster)

>>How can I set the variables when the Journal data have go to the OSD =
? (after X seconds and/or when Y %-full)=20
I think you can try to tune these values

filestore max sync interval =3D 30
filestore min sync interval =3D 29
filestore flusher =3D false
filestore queue max ops =3D 10000



----- Mail original -----=20

De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
=C3=80: ceph-devel@vger.kernel.org=20
Cc: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>=20
Envoy=C3=A9: Mardi 28 Ao=C3=BBt 2012 19:48:42=20
Objet: RBD performance - tuning hints=20

Hi,=20

on my 4-node system (SSD + 10GbE, see bench-config.txt for details)=20
I can observe a pretty nice rados bench performance=20
(see bench-rados.txt for details):=20

Bandwidth (MB/sec): 961.710=20
Max bandwidth (MB/sec): 1040=20
Min bandwidth (MB/sec): 772=20


Also the bandwidth performance generated with=20
fio --filename=3D/dev/rbd1 --direct=3D1 --rw=3D$io --bs=3D$bs --size=3D=
2G --iodepth=3D$threads --ioengine=3Dlibaio --runtime=3D60 --group_repo=
rting --name=3Dfile1 --output=3Dfio_${io}_${bs}_${threads}=20

=2E... is acceptable, e.g.=20
fio_write_4m_16 795 MB/s=20
fio_randwrite_8m_128 717 MB/s=20
fio_randwrite_8m_16 714 MB/s=20
fio_randwrite_2m_32 692 MB/s=20


But, the write IOPS seems to be limited around 19k ...=20
RBD 4M 64k (=3D optimal_io_size)=20
fio_randread_512_128 53286 55925=20
fio_randread_4k_128 51110 44382=20
fio_randread_8k_128 30854 29938=20
fio_randwrite_512_128 18888 2386=20
fio_randwrite_512_64 18844 2582=20
fio_randwrite_8k_64 17350 2445=20
(...)=20
fio_read_4k_128 10073 53151=20
fio_read_4k_64 9500 39757=20
fio_read_4k_32 9220 23650=20
(...)=20
fio_read_4k_16 9122 14322=20
fio_write_4k_128 2190 14306=20
fio_read_8k_32 706 13894=20
fio_write_4k_64 2197 12297=20
fio_write_8k_64 3563 11705=20
fio_write_8k_128 3444 11219=20


Any hints for tuning the IOPS (read and/or write) would be appreciated.=
=20

How can I set the variables when the Journal data have go to the OSD ? =
(after X seconds and/or when Y %-full)=20


Kind Regards,=20
-Dieter=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
