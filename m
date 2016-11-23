From: Avner Ben Hanoch <avnerb@mellanox.com>
Subject: RE: ceph issue
Date: Wed, 23 Nov 2016 09:30:13 +0000
Message-ID: <DB3PR05MB079316AC35562CC422E44DC0A9B70@DB3PR05MB0793.eurprd05.prod.outlook.com>
References: <FEC85B105C5F644CA51BDB90657EEA9828425083@ddsm-mbx01.digdes.com>
 <alpine.DEB.2.11.1611171448450.15311@piezo.us.to>
 <CACJqLybjnFedWh+TdN4W6u2+VKWBsJAtVi0A8VjbJ2mGX8aZxA@mail.gmail.com>
 <FEC85B105C5F644CA51BDB90657EEA98284250E8@ddsm-mbx01.digdes.com>
 <CACJqLyZRDpinsMZtDbM_zZHfi87FzC1HrCP0KRFEgAxgzGpjYQ@mail.gmail.com>
 <DB3PR05MB0793F7194A5C64F018E61012A9B20@DB3PR05MB0793.eurprd05.prod.outlook.com>,<CACJqLyaCJdK+G6V3_Cm36PRYrwQCoRZ02MyJCnDudSUmC=O4Tg@mail.gmail.com>
 <FEC85B105C5F644CA51BDB90657EEA982DC9E133@DDSM-MBX2.digdes.com>,<DB3PR05MB0793FB50C98346C4983E3ABBA9B40@DB3PR05MB0793.eurprd05.prod.outlook.com>
 <FEC85B105C5F644CA51BDB90657EEA982DC9F1CC@DDSM-MBX2.digdes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-db5eur01on0059.outbound.protection.outlook.com ([104.47.2.59]:31893
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933929AbcKWJaR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 23 Nov 2016 04:30:17 -0500
In-Reply-To: <FEC85B105C5F644CA51BDB90657EEA982DC9F1CC@DDSM-MBX2.digdes.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marov Aleksey <Marov.A@raidix.com>, Haomai Wang <haomai@xsky.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I guess that like the rest of ceph, the new rdma code must also support mul=
tiple applications in parallel.

I am also reproducing your error =3D> 2 instances of fio can't run in paral=
lel with ceph rdma.

* with ceph -s shows HEALTH_WARN (with "9 requests are blocked > 32 sec")

* and with all osds printing messages like " heartbeat_check: no reply from=
 ..."=20

* And with log files contains errors:
  $ grep error ceph-osd.0.log
  2016-11-23 09:20:46.988154 7f9b26260700 -1 Fail to open '/proc/0/cmdline'=
 error =3D (2) No such file or directory
  2016-11-23 09:20:54.090388 7f9b43951700  1 -- 36.0.0.2:6802/10634 >> 36.0=
.0.4:0/19587 conn(0x7f9b256a8000 :6802 s=3DSTATE_OPEN pgs=3D1 cs=3D1 l=3D1)=
.read_bulk reading from fd=3D139 : Unknown error -104
  2016-11-23 09:20:58.411912 7f9b44953700  1 RDMAStack polling work request=
 returned error for buffer(0x7f9b1fee21b0) status(12:RETRY_EXC_ERR
  2016-11-23 09:20:58.411934 7f9b44953700  1 RDMAStack polling work request=
 returned error for buffer(0x7f9b553d20d0) status(12:RETRY_EXC_ERR


Command lines that I used:=20
  ./fio --ioengine=3Drbd --invalidate=3D0 --rw=3Dwrite --bs=3D128K --numjob=
s=3D1 --clientname=3Dadmin --pool=3Drbd --iodepth=3D128 --rbdname=3Dimg2g -=
-name=3D1
  ./fio --ioengine=3Drbd --invalidate=3D0 --rw=3Dwrite --bs=3D128K --numjob=
s=3D1 --clientname=3Dadmin --pool=3Drbd --iodepth=3D128 --rbdname=3Dimg2g2 =
--name=3D1

> -----Original Message-----
> From: Marov Aleksey
> Sent: Tuesday, November 22, 2016 17:59
>=20
> I didn't try this blocksize. But in my case fio crushed if I use more tha=
n one
> job. With one job everything works fine. Is it worth more deep investigat=
ing?
