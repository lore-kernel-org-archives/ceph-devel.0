From: <Kelvin_Huang@wiwynn.com>
Subject: Ceph scalar & replicas performance
Date: Fri, 22 Feb 2013 01:01:00 +0000
Message-ID: <86F425174C7E4F418CCF4E62056152E59383FE@GDC-CLDMBX-P01.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw3.wistron.com ([220.128.89.23]:52000 "EHLO
	TWNHUMSW3.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab3BVBGI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 20:06:08 -0500
Received: from GDC-CLDCAS-P03.whq.wistron (unverified [10.37.38.64]) by TWNHUMSW3.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Taa0d8f0d60c0a816711cfc@TWNHUMSW3.wistron.com> for <ceph-devel@vger.kernel.org>;
 Fri, 22 Feb 2013 09:05:19 +0800
Content-Language: zh-TW
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I have some problem after my scalar performance test !!

Setup:
Linux kernel: 3.2.0
OS: Ubuntu 12.04
Storage server : 11 HDD (each storage server has 11 osd, 7200 rpm, 1T) =
+ 10GbE NIC + RAID card: LSI MegaRAID SAS 9260-4i
         For every HDD: RAID0, Write Policy: Write Back with BBU, Read =
Policy: ReadAhead, IO Policy: Direct Storage server number : 1 to 4

Ceph version : 0.48.2
Replicas : 2

=46IO cmd: =20
[Sequencial Read]
fio --iodepth =3D 32 --numjobs=3D1 --runtime=3D120  --bs =3D 65536 --rw=
 =3D read --ioengine=3Dlibaio --group_reporting --direct=3D1 --eta=3Dal=
ways --ramp_time=3D10 --thinktime=3D10=20

[Sequencial Read]
fio --iodepth =3D 32 --numjobs=3D1 --runtime=3D120  --bs =3D 65536 --rw=
 =3D write --ioengine=3Dlibaio --group_reporting --direct=3D1 --eta=3Da=
lways --ramp_time=3D10 --thinktime=3D10=20

[Random Read]
fio --iodepth =3D 32 --numjobs=3D8 --runtime=3D120  --bs =3D 65536 --rw=
 =3D randread --ioengine=3Dlibaio --group_reporting --direct=3D1 --eta=3D=
always --ramp_time=3D10 --thinktime=3D10=20

[Random Write]
fio --iodepth =3D 32 --numjobs=3D8 --runtime=3D120  --bs =3D 65536 --rw=
 =3D randwrite --ioengine=3Dlibaio --group_reporting --direct=3D1 --eta=
=3Dalways --ramp_time=3D10 --thinktime=3D10

Use ceph client then create 1T RBD image for testing, the client also h=
as 10GbE NIC , Linux kernel 3.2.0 , Ubuntu 12.04

Performance result:=20
                      Bandwidth (MB/sec)=20
=82=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80
=81storage server number=81Sequential Read =81Sequential Write=81Random=
 Read=81Random Write =81=20
=86=80=80=80=80=80=80=80=80=80 =8A=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80
=81          1        =81      259     =81     76       =81    837    =81=
    26       =81
=86=80=80=80=80=80=80=80=80=80 =8A=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80
=81          2        =81      349     =81    121       =81    950    =81=
    45       =81
=86=80=80=80=80=80=80=80=80=80 =8A=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80
=81          3        =81      354     =81    108       =81    490    =81=
    71       =81
=86=80=80=80=80=80=80=80=80=80 =8A=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80
=81          4        =81      338     =81    103       =81    610    =81=
    89       =81
=86=80=80=80=80=80=80=80=80=80 =8A=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80

We expect that bandwidth will increase when storage server increase und=
er all case, but the result is not !!=20
Can you share your idea for read/write bandwidth when storage server in=
creasing ?

In another case, we fixed use 4 storage servers then adjust the number =
of replicas 2 to 4

Performance result:

                        Bandwidth (MB/sec)=20
=82=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80
=81  replicas number    =81Sequential Read =81Sequential Write=81Random=
 Read=81Random Write =81
=86=80=80=80=80=80=80=80=80=80 =8A=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80
=81          2        =81       338    =81      103     =81     614    =
=81      89     =81
=86=80=80=80=80=80=80=80=80=80 =8A=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80
=81          3        =81       337    =81      76      =81     791    =
=81      62     =81
=86=80=80=80=80=80=80=80=80=80 =8A=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80
=81          4        =81       337    =81      60      =81     754    =
=81      43     =81
=86=80=80=80=80=80=80=80=80=80 =8A=80=80=80=80=80=80=80=80=80=80=80=80=80=
=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80=80

The bandwidth of write will decrease when replicas increase that is eas=
y to know, but why read bandwidth did not increase?


Kelvin

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
