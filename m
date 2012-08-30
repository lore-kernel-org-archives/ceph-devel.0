From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: RBD performance - tuning hints
Date: Thu, 30 Aug 2012 17:33:42 +0200
Message-ID: <20120830153342.GC32184@oder.kd-bie.de>
References: <20120830145634.GA32184@oder.kd-bie.de>
 <0a67f8ca-86ac-4257-bd8c-c4f0e1518283@mailpro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:54626 "EHLO
	smtpa2.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab2H3Peq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 11:34:46 -0400
Content-Disposition: inline
In-Reply-To: <0a67f8ca-86ac-4257-bd8c-c4f0e1518283@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtpa.mediabeam.com id q7UFYf36017168

On Thu, Aug 30, 2012 at 05:28:02PM +0200, Alexandre DERUMIER wrote:
> Thanks for the report !
>=20
> vs your first benchmark, it's with RBD 4M or 64K ?
with 4MB (see attached config info)

Cheers,
-Dieter

>=20
> (how much ssd by node?)
8x SSD, 200GB each

>=20
>=20
>=20
> ----- Mail original -----
>=20
> De: "Dieter Kasper" <d.kasper@kabelmail.de>
> =C0: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: ceph-devel@vger.kernel.org
> Envoy=E9: Jeudi 30 Ao=FBt 2012 16:56:34
> Objet: Re: RBD performance - tuning hints
>=20
> Hi Alexandre,
>=20
> with the 4 filestore parameter below some fio values could be increased=
:
> filestore max sync interval =3D 30
> filestore min sync interval =3D 29
> filestore flusher =3D false
> filestore queue max ops =3D 10000
>=20
> ###### IOPS
> fio_read_4k_64: 9373
> fio_read_4k_128: 9939
> fio_randwrite_8k_16: 12376
> fio_randwrite_4k_16: 13315
> fio_randwrite_512_32: 13660
> fio_randwrite_8k_32: 17318
> fio_randwrite_4k_32: 18057
> fio_randwrite_8k_64: 19693
> fio_randwrite_512_64: 20015 <<<
> fio_randwrite_4k_64: 20024 <<<
> fio_randwrite_8k_128: 20547 <<<
> fio_randwrite_4k_128: 20839 <<<
> fio_randwrite_512_128: 21417 <<<
> fio_randread_8k_128: 48872
> fio_randread_4k_128: 50002
> fio_randread_512_128: 51202
>=20
> ###### MB/s
> fio_randread_2m_32: 628
> fio_read_4m_64: 630
> fio_randread_8m_32: 633
> fio_read_2m_32: 637
> fio_read_4m_16: 640
> fio_randread_4m_16: 652
> fio_write_2m_32: 660
> fio_randread_4m_32: 677
> fio_read_4m_32: 678
> (...)
> fio_write_4m_64: 771
> fio_randwrite_2m_64: 789
> fio_write_8m_128: 796
> fio_write_4m_32: 802
> fio_randwrite_4m_128: 807 <<<
> fio_randwrite_2m_32: 811 <<<
> fio_write_2m_128: 833 <<<
> fio_write_8m_64: 901 <<<
>=20
> Best Regards,
> -Dieter
>=20
>=20
> On Wed, Aug 29, 2012 at 10:50:12AM +0200, Alexandre DERUMIER wrote:
> > Nice results !
> > (can you make same benchmark from a qemu-kvm guest with virtio-driver=
 ?
> > I have made some bench some month ago with stephan priebe, and we nev=
er be able to have more than 20000iops, with a full ssd 3nodes cluster)
> >
> > >>How can I set the variables when the Journal data have go to the OS=
D ? (after X seconds and/or when Y %-full)
> > I think you can try to tune these values
> >
> > filestore max sync interval =3D 30
> > filestore min sync interval =3D 29
> > filestore flusher =3D false
> > filestore queue max ops =3D 10000
> >
> >
> >
> > ----- Mail original -----
> >
> > De: "Dieter Kasper" <d.kasper@kabelmail.de>
> > =C0: ceph-devel@vger.kernel.org
> > Cc: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>
> > Envoy=E9: Mardi 28 Ao=FBt 2012 19:48:42
> > Objet: RBD performance - tuning hints
> >
> > Hi,
> >
> > on my 4-node system (SSD + 10GbE, see bench-config.txt for details)
> > I can observe a pretty nice rados bench performance
> > (see bench-rados.txt for details):
> >
> > Bandwidth (MB/sec): 961.710
> > Max bandwidth (MB/sec): 1040
> > Min bandwidth (MB/sec): 772
> >
> >
> > Also the bandwidth performance generated with
> > fio --filename=3D/dev/rbd1 --direct=3D1 --rw=3D$io --bs=3D$bs --size=3D=
2G --iodepth=3D$threads --ioengine=3Dlibaio --runtime=3D60 --group_report=
ing --name=3Dfile1 --output=3Dfio_${io}_${bs}_${threads}
> >
> > .... is acceptable, e.g.
> > fio_write_4m_16 795 MB/s
> > fio_randwrite_8m_128 717 MB/s
> > fio_randwrite_8m_16 714 MB/s
> > fio_randwrite_2m_32 692 MB/s
> >
> >
> > But, the write IOPS seems to be limited around 19k ...
> > RBD 4M 64k (=3D optimal_io_size)
> > fio_randread_512_128 53286 55925
> > fio_randread_4k_128 51110 44382
> > fio_randread_8k_128 30854 29938
> > fio_randwrite_512_128 18888 2386
> > fio_randwrite_512_64 18844 2582
> > fio_randwrite_8k_64 17350 2445
> > (...)
> > fio_read_4k_128 10073 53151
> > fio_read_4k_64 9500 39757
> > fio_read_4k_32 9220 23650
> > (...)
> > fio_read_4k_16 9122 14322
> > fio_write_4k_128 2190 14306
> > fio_read_8k_32 706 13894
> > fio_write_4k_64 2197 12297
> > fio_write_8k_64 3563 11705
> > fio_write_8k_128 3444 11219
> >
> >
> > Any hints for tuning the IOPS (read and/or write) would be appreciate=
d.
> >
> > How can I set the variables when the Journal data have go to the OSD =
? (after X seconds and/or when Y %-full)
> >
> >
> > Kind Regards,
> > -Dieter
> >
> >
> >
> > --
> >
> > --
> >
> >
> >
> >
> >
> > Alexandre D e rumier
> >
> > Ing=E9nieur Syst=E8mes et R=E9seaux
> >
> >
> > Fixe : 03 20 68 88 85
> >
> > Fax : 03 20 68 90 88
> >
> >
> > 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix
> > 12 rue Marivaux 75002 Paris
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
>=20
> --
>=20
> --
>=20
>=20
>=20
>=20
>=20
> Alexandre D e rumier
>=20
> Ing=E9nieur Syst=E8mes et R=E9seaux
>=20
>=20
> Fixe : 03 20 68 88 85
>=20
> Fax : 03 20 68 90 88
>=20
>=20
> 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix
> 12 rue Marivaux 75002 Paris
>=20

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hwconf.txt"

--- RX37-3c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-3 3.0.41-5.1-default #1 SMP Wed Aug 22 00:54:03 UTC 2012 (9c63123) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       32856332 kB
Disk /dev/ram0: 2048 MB, 2048000000 bytes
Disk /dev/ram1: 2048 MB, 2048000000 bytes
Disk /dev/ram2: 2048 MB, 2048000000 bytes
Disk /dev/ram3: 2048 MB, 2048000000 bytes
Disk /dev/ram4: 2048 MB, 2048000000 bytes
Disk /dev/ram5: 2048 MB, 2048000000 bytes
Disk /dev/ram6: 2048 MB, 2048000000 bytes
Disk /dev/ram7: 2048 MB, 2048000000 bytes
[10:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdm 
[10:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdn 
[10:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdo 
[10:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdp 
[11:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdq 
[11:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdr 
[11:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sds 
[11:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdt 
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     38 C
  Blocks sent to initiator = 257379169992704
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     40 C
  Blocks sent to initiator = 238453816033280
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     43 C
  Blocks sent to initiator = 297650494636032
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     34 C
  Blocks sent to initiator = 254438979665920
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     35 C
  Blocks sent to initiator = 238876987752448
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     37 C
  Blocks sent to initiator = 259011676995584
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     41 C
  Blocks sent to initiator = 359638046343168
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     31 C
  Blocks sent to initiator = 247008082264064
optimal_io_size: scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
/dev/sdm on /data/osd.30 type xfs (rw,noatime)
/dev/sdn on /data/osd.31 type xfs (rw,noatime)
/dev/sdo on /data/osd.32 type xfs (rw,noatime)
/dev/sdp on /data/osd.33 type xfs (rw,noatime)
/dev/sdq on /data/osd.34 type xfs (rw,noatime)
/dev/sdr on /data/osd.35 type xfs (rw,noatime)
/dev/sds on /data/osd.36 type xfs (rw,noatime)
/dev/sdt on /data/osd.37 type xfs (rw,noatime)
--- RX37-4c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-4 3.0.36-10-default #1 SMP Mon Jul 9 14:42:03 UTC 2012 (595894d) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       32856432 kB
Disk /dev/ram0: 2048 MB, 2048000000 bytes
Disk /dev/ram1: 2048 MB, 2048000000 bytes
Disk /dev/ram2: 2048 MB, 2048000000 bytes
Disk /dev/ram3: 2048 MB, 2048000000 bytes
Disk /dev/ram4: 2048 MB, 2048000000 bytes
Disk /dev/ram5: 2048 MB, 2048000000 bytes
Disk /dev/ram6: 2048 MB, 2048000000 bytes
Disk /dev/ram7: 2048 MB, 2048000000 bytes
[10:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdd 
[10:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sde 
[10:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdf 
[10:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdg 
[11:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdh 
[11:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdi 
[11:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdj 
[11:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdk 
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     34 C
  Blocks sent to initiator = 389173798240256
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     30 C
  Blocks sent to initiator = 286249688498176
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     35 C
  Blocks sent to initiator = 220455000604672
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     38 C
  Blocks sent to initiator = 223169319272448
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     31 C
  Blocks sent to initiator = 232096593346560
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     36 C
  Blocks sent to initiator = 264802534424576
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     27 C
  Blocks sent to initiator = 288896512425984
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     32 C
  Blocks sent to initiator = 282331621359616
optimal_io_size: scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
/dev/sdd on /data/osd.40 type xfs (rw,noatime)
/dev/sde on /data/osd.41 type xfs (rw,noatime)
/dev/sdf on /data/osd.42 type xfs (rw,noatime)
/dev/sdg on /data/osd.43 type xfs (rw,noatime)
/dev/sdh on /data/osd.44 type xfs (rw,noatime)
/dev/sdi on /data/osd.45 type xfs (rw,noatime)
/dev/sdj on /data/osd.46 type xfs (rw,noatime)
/dev/sdk on /data/osd.47 type xfs (rw,noatime)
--- RX37-5c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-5 3.0.36-10-default #1 SMP Mon Jul 9 14:42:03 UTC 2012 (595894d) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       74226012 kB
Disk /dev/ram0: 2048 MB, 2048000000 bytes
Disk /dev/ram1: 2048 MB, 2048000000 bytes
Disk /dev/ram2: 2048 MB, 2048000000 bytes
Disk /dev/ram3: 2048 MB, 2048000000 bytes
Disk /dev/ram4: 2048 MB, 2048000000 bytes
Disk /dev/ram5: 2048 MB, 2048000000 bytes
Disk /dev/ram6: 2048 MB, 2048000000 bytes
Disk /dev/ram7: 2048 MB, 2048000000 bytes
[10:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdo 
[10:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdp 
[10:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdq 
[10:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdr 
[11:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sds 
[11:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdt 
[11:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdu 
[11:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdv 
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     36 C
  Blocks sent to initiator = 247461838848000
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     38 C
  Blocks sent to initiator = 231320898764800
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     41 C
  Blocks sent to initiator = 290086906232832
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     32 C
  Blocks sent to initiator = 287719053852672
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     33 C
  Blocks sent to initiator = 243922265702400
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     35 C
  Blocks sent to initiator = 272285122428928
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     40 C
  Blocks sent to initiator = 279561266790400
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     29 C
  Blocks sent to initiator = 247978778427392
optimal_io_size: scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
/dev/sdo on /data/osd.50 type xfs (rw,noatime)
/dev/sdp on /data/osd.51 type xfs (rw,noatime)
/dev/sdq on /data/osd.52 type xfs (rw,noatime)
/dev/sdr on /data/osd.53 type xfs (rw,noatime)
/dev/sds on /data/osd.54 type xfs (rw,noatime)
/dev/sdt on /data/osd.55 type xfs (rw,noatime)
/dev/sdu on /data/osd.56 type xfs (rw,noatime)
/dev/sdv on /data/osd.57 type xfs (rw,noatime)
--- RX37-6c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-6 3.0.36-10-default #1 SMP Mon Jul 9 14:42:03 UTC 2012 (595894d) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       32856344 kB
Disk /dev/ram0: 2048 MB, 2048000000 bytes
Disk /dev/ram1: 2048 MB, 2048000000 bytes
Disk /dev/ram2: 2048 MB, 2048000000 bytes
Disk /dev/ram3: 2048 MB, 2048000000 bytes
Disk /dev/ram4: 2048 MB, 2048000000 bytes
Disk /dev/ram5: 2048 MB, 2048000000 bytes
Disk /dev/ram6: 2048 MB, 2048000000 bytes
Disk /dev/ram7: 2048 MB, 2048000000 bytes
[10:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdn 
[10:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdo 
[10:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdp 
[10:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdq 
[11:0:0:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdr 
[11:0:1:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sds 
[11:0:2:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdt 
[11:0:3:0]   disk    INTEL(R)  SSD 910 200GB   a411  /dev/sdu 
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     41 C
  Blocks sent to initiator = 259148495192064
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     36 C
  Blocks sent to initiator = 250183472381952
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     43 C
  Blocks sent to initiator = 232864704626688
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     46 C
  Blocks sent to initiator = 313614921629696
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     37 C
  Blocks sent to initiator = 269851218149376
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     34 C
  Blocks sent to initiator = 278551060283392
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     43 C
  Blocks sent to initiator = 267839076302848
Device: INTEL(R)  SSD 910 200GB   Version: a411
Current Drive Temperature:     39 C
  Blocks sent to initiator = 233988811653120
optimal_io_size: scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
/dev/sdn on /data/osd.60 type xfs (rw,noatime)
/dev/sdo on /data/osd.61 type xfs (rw,noatime)
/dev/sdp on /data/osd.62 type xfs (rw,noatime)
/dev/sdq on /data/osd.63 type xfs (rw,noatime)
/dev/sdr on /data/osd.64 type xfs (rw,noatime)
/dev/sds on /data/osd.65 type xfs (rw,noatime)
/dev/sdt on /data/osd.66 type xfs (rw,noatime)
/dev/sdu on /data/osd.67 type xfs (rw,noatime)
--- RX37-7c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-7 3.0.36-10-default #1 SMP Mon Jul 9 14:42:03 UTC 2012 (595894d) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 1.20 GHz (asserted by call to hardware).
MemTotal:       32856344 kB
optimal_io_size: 4194304
4194304
4194304
scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
noop deadline [cfq] 
--- RX37-8c --------------------------------------------------------------------
ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux RX37-8 3.0.36-16-default #1 SMP Wed Jul 18 00:18:54 UTC 2012 (544e41f) x86_64 x86_64 x86_64 GNU/Linux

model name	: Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
Logial CPUs: 12
  current CPU frequency is 2.30 GHz (asserted by call to hardware).
MemTotal:       65952088 kB
optimal_io_size: scheduler:       [noop] deadline cfq 
[noop] deadline cfq 
[noop] deadline cfq 
--------------------------------------------------------------------------------

dumped osdmap epoch 19
epoch 19
fsid 31dc8e8c-45cb-4b94-b581-a9258964f1a6
created 2012-08-29 22:08:58.870313
modifed 2012-08-29 22:09:50.084564
flags 

pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 4352 pgp_num 4352 last_change 1 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num 4352 pgp_num 4352 last_change 1 owner 0
pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 4352 pgp_num 4352 last_change 1 owner 0
pool 3 'pbench' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 768 pgp_num 768 last_change 18 owner 0

max_osd 68
osd.30 up   in  weight 1 up_from 3 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.52:6800/24876 192.168.114.52:6800/24876 192.168.114.52:6801/24876 exists,up 0a9a6db3-1c0d-4d66-ac99-bd900076c42c
osd.31 up   in  weight 1 up_from 3 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.52:6801/25090 192.168.114.52:6802/25090 192.168.114.52:6803/25090 exists,up 0adab61b-c1c3-479f-b58e-42bec92bd5b0
osd.32 up   in  weight 1 up_from 3 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.52:6802/25276 192.168.114.52:6804/25276 192.168.114.52:6805/25276 exists,up 331bf096-d785-4ae8-b790-d746a0abb694
osd.33 up   in  weight 1 up_from 4 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.52:6803/25464 192.168.114.52:6806/25464 192.168.114.52:6807/25464 exists,up a1f9ea5b-e0db-474c-b7bc-6cb3d3a213a4
osd.34 up   in  weight 1 up_from 4 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.52:6804/25650 192.168.114.52:6808/25650 192.168.114.52:6809/25650 exists,up dcbe68e7-fef3-430d-a857-560db28de27f
osd.35 up   in  weight 1 up_from 2 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.52:6805/25838 192.168.114.52:6810/25838 192.168.114.52:6811/25838 exists,up ab1589d0-e725-4484-8f5d-f65bc5c64643
osd.36 up   in  weight 1 up_from 3 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.52:6806/26026 192.168.114.52:6812/26026 192.168.114.52:6813/26026 exists,up 2eea079f-bcfe-48a4-abb5-a15c7daf80ba
osd.37 up   in  weight 1 up_from 4 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.52:6807/26218 192.168.114.52:6814/26218 192.168.114.52:6815/26218 exists,up 9822d872-79a6-4cd3-898f-2e905fbce44a
osd.40 up   in  weight 1 up_from 4 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.53:6800/18525 192.168.114.53:6800/18525 192.168.114.53:6801/18525 exists,up 0f0c61ea-4d78-429c-9928-b3422ad2dec7
osd.41 up   in  weight 1 up_from 5 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.53:6801/18750 192.168.114.53:6802/18750 192.168.114.53:6803/18750 exists,up 3935c6a7-61ff-4c97-88b9-472051ba8b6c
osd.42 up   in  weight 1 up_from 4 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.53:6802/18946 192.168.114.53:6804/18946 192.168.114.53:6805/18946 exists,up 3efc6383-5097-4e95-9af2-e0e7bc9ddc10
osd.43 up   in  weight 1 up_from 4 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.53:6803/19154 192.168.114.53:6806/19154 192.168.114.53:6807/19154 exists,up cdb8cf82-077b-40c2-adbc-fae29ba41645
osd.44 up   in  weight 1 up_from 4 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.53:6804/19350 192.168.114.53:6808/19350 192.168.114.53:6809/19350 exists,up 5ab69e45-a73a-4cd4-9837-2d54fb4ea4ec
osd.45 up   in  weight 1 up_from 4 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.53:6805/19546 192.168.114.53:6810/19546 192.168.114.53:6811/19546 exists,up ec3d2118-6f46-4ef8-a431-553710f33a18
osd.46 up   in  weight 1 up_from 5 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.53:6806/19766 192.168.114.53:6812/19766 192.168.114.53:6813/19766 exists,up dcd94df3-b679-46a6-b670-5269a29913c1
osd.47 up   in  weight 1 up_from 5 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.53:6807/19968 192.168.114.53:6814/19968 192.168.114.53:6815/19968 exists,up 41019d97-c4f3-4c8d-9189-bae642c31678
osd.50 up   in  weight 1 up_from 5 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.54:6800/3848 192.168.114.54:6800/3848 192.168.114.54:6801/3848 exists,up 0b9ebe8e-9cb8-440d-948e-d4c8aa16b407
osd.51 up   in  weight 1 up_from 5 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.54:6801/4061 192.168.114.54:6802/4061 192.168.114.54:6803/4061 exists,up 3c2e8031-d01d-4bf9-965e-1b77563d5f8f
osd.52 up   in  weight 1 up_from 5 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.54:6802/4248 192.168.114.54:6804/4248 192.168.114.54:6805/4248 exists,up 4d641c3c-0a7a-4b20-b047-9042b61685bb
osd.53 up   in  weight 1 up_from 5 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.54:6803/4446 192.168.114.54:6806/4446 192.168.114.54:6807/4446 exists,up e335a6e9-9c32-48c6-8f15-11aa84a6287d
osd.54 up   in  weight 1 up_from 5 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.54:6804/4632 192.168.114.54:6808/4632 192.168.114.54:6809/4632 exists,up 16f3955c-9eee-442b-86d8-cbbc5938efbf
osd.55 up   in  weight 1 up_from 6 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.54:6805/4836 192.168.114.54:6810/4836 192.168.114.54:6811/4836 exists,up 83e59145-9ff8-4c0b-b066-2b2e4e9c9953
osd.56 up   in  weight 1 up_from 6 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.54:6806/5029 192.168.114.54:6812/5029 192.168.114.54:6813/5029 exists,up dfdeb186-5c96-4466-b4d3-5f32fa712792
osd.57 up   in  weight 1 up_from 7 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.54:6807/5351 192.168.114.54:6814/5351 192.168.114.54:6815/5351 exists,up adf7a484-b0f1-4bf7-a8e7-2c1e64dfb77f
osd.60 up   in  weight 1 up_from 7 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.55:6800/31038 192.168.114.55:6800/31038 192.168.114.55:6801/31038 exists,up e9b949c8-1b47-4749-9408-1e9f7b89b0e6
osd.61 up   in  weight 1 up_from 8 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.55:6801/31257 192.168.114.55:6802/31257 192.168.114.55:6803/31257 exists,up 19fcad53-d951-4645-a6d5-7dad1deba6fb
osd.62 up   in  weight 1 up_from 8 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.55:6802/31449 192.168.114.55:6804/31449 192.168.114.55:6805/31449 exists,up 7e98db0e-2ae2-473d-9b03-798ec472b29b
osd.63 up   in  weight 1 up_from 9 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.55:6803/31641 192.168.114.55:6806/31641 192.168.114.55:6807/31641 exists,up 9abc714c-06e4-40ba-8afe-8465209e0272
osd.64 up   in  weight 1 up_from 9 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.55:6804/31937 192.168.114.55:6808/31937 192.168.114.55:6809/31937 exists,up 6a20e4b1-d1e9-4f69-b903-b403136ddb1d
osd.65 up   in  weight 1 up_from 10 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.55:6805/32175 192.168.114.55:6810/32175 192.168.114.55:6811/32175 exists,up e95ad5b2-6866-4161-8060-781a31d7ece2
osd.66 up   in  weight 1 up_from 10 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.55:6806/32487 192.168.114.55:6812/32487 192.168.114.55:6813/32487 exists,up f3126979-ecd6-45de-b0bf-54cb2b0af042
osd.67 up   in  weight 1 up_from 11 up_thru 18 down_at 0 last_clean_interval [0,0) 192.168.113.55:6807/32679 192.168.114.55:6814/32679 192.168.114.55:6815/32679 exists,up 37d3f121-b6f4-4c6f-ac9b-30533e8fa60a



ceph.conf
---content---
# global
[global]
	# enable secure authentication
	auth supported = none

        # allow ourselves to open a lot of files
        #max open files = 1100000
        max open files = 131072

        # set log file
        log file = /ceph/log/$name.log
        # log_to_syslog = true        # uncomment this line to log to syslog

        # set up pid files
        pid file = /var/run/ceph/$name.pid

        # If you want to run a IPv6 cluster, set this to true. Dual-stack isn't possible
        #ms bind ipv6 = true
	public network = 192.168.113.0/24
	cluster network = 192.168.114.0/24

# monitors
#  You need at least one.  You need at least three if you want to
#  tolerate any node failures.  Always create an odd number.
[mon]
        mon data = /ceph/$name

        # If you are using for example the RADOS Gateway and want to have your newly created
        # pools a higher replication level, you can set a default
        #osd pool default size = 3

        # You can also specify a CRUSH rule for new pools
        # Wiki: http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH
        #osd pool default crush rule = 0

        # Timing is critical for monitors, but if you want to allow the clocks to drift a
        # bit more, you can specify the max drift.
        #mon clock drift allowed = 1

        # Tell the monitor to backoff from this warning for 30 seconds
        #mon clock drift warn backoff = 30

	# logging, for debugging monitor crashes, in order of
	# their likelihood of being helpful :)
	#debug ms = 1
	#debug mon = 20
	#debug paxos = 20
	#debug auth = 20
	debug optracker = 0

[mon.0]
	host = RX37-3c
	mon addr = 192.168.113.52:6789
[mon.1]
	host = RX37-7c
	mon addr = 192.168.113.56:6789
[mon.2]
	host = RX37-8c
	mon addr = 192.168.113.57:6789
	
# mds
#  You need at least one.  Define two to get a standby.
[mds]
#        mds data = /ceph/$name
	# where the mds keeps it's secret encryption keys
	#keyring = /data/keyring.$name

	# mds logging to debug issues.
	#debug ms = 1
	#debug mds = 20
	debug optracker = 0

[mds.0]
        host = RX37-8c

# osd
#  You need at least one.  Two if you want data to be replicated.
#  Define as many as you like.
[osd]
	# This is where the btrfs volume will be mounted.
	osd data = /data/$name

#        journal dio = true
#        osd op threads = 24
#        osd disk threads = 24
#        filestore op threads = 6
#        filestore queue max ops = 24
	filestore max sync interval = 30
	filestore min sync interval = 29
	filestore flusher = false
	filestore queue max ops = 10000

	# Ideally, make this a separate disk or partition.  A few
 	# hundred MB should be enough; more if you have fast or many
 	# disks.  You can use a file under the osd data dir if need be
 	# (e.g. /data/$name/journal), but it will be slower than a
 	# separate disk or partition.

        # This is an example of a file-based journal.
	# osd journal = /ceph/$name/journal
	# osd journal size = 2048 
	# journal size, in megabytes

        # If you want to run the journal on a tmpfs, disable DirectIO
        #journal dio = false

        # You can change the number of recovery operations to speed up recovery
        # or slow it down if your machines can't handle it
        # osd recovery max active = 3

	# osd logging to debug osd issues, in order of likelihood of being
	# helpful
	#debug ms = 1
	#debug osd = 20
	#debug filestore = 20
	#debug journal = 20
	debug optracker = 0
	fstype = xfs

[osd.30]
	host = RX37-3c
	devs = /dev/sdm
	osd journal = /dev/ram0
[osd.31]
	host = RX37-3c
	devs = /dev/sdn
	osd journal = /dev/ram1
[osd.32]
	host = RX37-3c
	devs = /dev/sdo
	osd journal = /dev/ram2
[osd.33]
	host = RX37-3c
	devs = /dev/sdp
	osd journal = /dev/ram3
[osd.34]
	host = RX37-3c
	devs = /dev/sdq
	osd journal = /dev/ram4
[osd.35]
	host = RX37-3c
	devs = /dev/sdr
	osd journal = /dev/ram5
[osd.36]
	host = RX37-3c
	devs = /dev/sds
	osd journal = /dev/ram6
[osd.37]
	host = RX37-3c
	devs = /dev/sdt
	osd journal = /dev/ram7
[osd.40]
	host = RX37-4c
	devs = /dev/sdd
	osd journal = /dev/ram0
[osd.41]
	host = RX37-4c
	devs = /dev/sde
	osd journal = /dev/ram1
[osd.42]
	host = RX37-4c
	devs = /dev/sdf
	osd journal = /dev/ram2
[osd.43]
	host = RX37-4c
	devs = /dev/sdg
	osd journal = /dev/ram3
[osd.44]
	host = RX37-4c
	devs = /dev/sdh
	osd journal = /dev/ram4
[osd.45]
	host = RX37-4c
	devs = /dev/sdi
	osd journal = /dev/ram5
[osd.46]
	host = RX37-4c
	devs = /dev/sdj
	osd journal = /dev/ram6
[osd.47]
	host = RX37-4c
	devs = /dev/sdk
	osd journal = /dev/ram7
[osd.50]
	host = RX37-5c
	devs = /dev/sdo
	osd journal = /dev/ram0
[osd.51]
	host = RX37-5c
	devs = /dev/sdp
	osd journal = /dev/ram1
[osd.52]
	host = RX37-5c
	devs = /dev/sdq
	osd journal = /dev/ram2
[osd.53]
	host = RX37-5c
	devs = /dev/sdr
	osd journal = /dev/ram3
[osd.54]
	host = RX37-5c
	devs = /dev/sds
	osd journal = /dev/ram4
[osd.55]
	host = RX37-5c
	devs = /dev/sdt
	osd journal = /dev/ram5
[osd.56]
	host = RX37-5c
	devs = /dev/sdu
	osd journal = /dev/ram6
[osd.57]
	host = RX37-5c
	devs = /dev/sdv
	osd journal = /dev/ram7
[osd.60]
	host = RX37-6c
	devs = /dev/sdn
	osd journal = /dev/ram0
[osd.61]
	host = RX37-6c
	devs = /dev/sdo
	osd journal = /dev/ram1
[osd.62]
	host = RX37-6c
	devs = /dev/sdp
	osd journal = /dev/ram2
[osd.63]
	host = RX37-6c
	devs = /dev/sdq
	osd journal = /dev/ram3
[osd.64]
	host = RX37-6c
	devs = /dev/sdr
	osd journal = /dev/ram4
[osd.65]
	host = RX37-6c
	devs = /dev/sds
	osd journal = /dev/ram5
[osd.66]
	host = RX37-6c
	devs = /dev/sdt
	osd journal = /dev/ram6
[osd.67]
	host = RX37-6c
	devs = /dev/sdu
	osd journal = /dev/ram7
	devs = /dev/sdc

[client.01]
	client hostname = RX37-7c


--k+w/mQv8wyuph6w0--

