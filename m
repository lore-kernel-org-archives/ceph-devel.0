From: =?UTF-8?B?5byg5bmz?= <alan.zhang@linux.com>
Subject: xfs Write barrier cause bad iops on rbd vm disk
Date: Tue, 12 Apr 2016 16:16:13 +0800
Message-ID: <BLU436-SMTP27CBB6ACFEC7FE950B32E385950@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s1.hotmail.com ([65.55.111.140]:58981 "EHLO
	BLU004-OMC4S1.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932450AbcDLIRr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 04:17:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have get a problem about rbd cache and xfs Write barrier.

Evn
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Ceph 9.2.1
Qemu 2.3
Rbd cache: true
Kvm disk cache mode: write back
Guest os: centos 7.1
Guest os kernel: 4.1.12

Ssd pool: 12 * intel dc s3700 400GB
Sas pool: 70 * 4TB sas




Symptoms
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Fio 4k performance test only ~3.5K iops(ssd pool)
2. When running zookeeper benchmark on a kvm vm, iostat only ~300iops o=
n vm

[root@test-centos7-rbd ~]# iostat -dxm 1
Linux 4.1.12-32.2.3.el7.centosbfd.x86_64 (test-centos7-rbd.novalocal) 	=
04/12/2016 	_x86_64_	(8 CPU)
Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq=
-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.13    3.18    0.97     0.17     0.01    88=
=2E01     0.01    2.38    2.25    2.79   1.05   0.44
vdb               0.00     0.11    0.94  544.03     0.04     1.58     6=
=2E08     0.13    0.24    1.85    0.23   0.23  12.42
vdc               0.00     0.00    0.18    0.00     0.00     0.00    15=
=2E39     0.00    0.12    0.12    0.00   0.11   0.00


Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq=
-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00  248.00     0.00     0.62     5=
=2E10     0.94    3.76    0.00    3.76   3.77  93.60
vdc               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00


Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq=
-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00  261.00     0.00     0.65     5=
=2E10     0.94    3.62    0.00    3.62   3.59  93.70
vdc               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00



3. Zookeeper benchmark CREATE/DELETE ops only ~150 ops/s(It=E2=80=99s v=
ery low)
4. When I run command:  mount -o  "rw,nodev,noatime,nodiratime,nobarrie=
r" /dev/vdb /opt/, the Fio test/zk benchmark test will be perfect good.


[root@test-centos7-rbd ~]# iostat -dxm 1
Linux 4.1.12-32.2.3.el7.centosbfd.x86_64 (test-centos7-rbd.novalocal) 	=
04/12/2016 	_x86_64_	(8 CPU)


Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq=
-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.12    3.03    0.95     0.16     0.01    87=
=2E56     0.01    2.37    2.25    2.76   1.05   0.42
vdb               0.00     0.11    0.89  529.98     0.04     1.53     6=
=2E06     0.17    0.32    1.85    0.32   0.31  16.40
vdc               0.00     0.00    0.17    0.00     0.00     0.00    15=
=2E39     0.00    0.12    0.12    0.00   0.11   0.00


Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq=
-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00  260.00     0.00     0.65     5=
=2E09     0.94    3.60    0.00    3.60   3.59  93.40
vdc               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00


Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq=
-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00  267.00     0.00     0.66     5=
=2E08     0.93    3.47    0.00    3.47   3.47  92.60
vdc               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00


^C
[root@test-centos7-rbd ~]#  mount -o remount,rw,nodev,noatime,nodiratim=
e,barrier /dev/vdb /opt/
[root@test-centos7-rbd ~]# mount -o remount,rw,nodev,noatime,nodiratime=
,nobarrier /dev/vdb /opt/

[root@test-centos7-rbd ~]# iostat -dxm 1
Linux 4.1.12-32.2.3.el7.centosbfd.x86_64 (test-centos7-rbd.novalocal) 	=
04/12/2016 	_x86_64_	(8 CPU)


Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq=
-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.12    3.01    0.94     0.16     0.01    87=
=2E53     0.01    2.37    2.25    2.76   1.05   0.42
vdb               0.00     0.11    0.89  531.90     0.04     1.54     6=
=2E06     0.17    0.33    1.85    0.32   0.32  16.84
vdc               0.00     0.00    0.17    0.00     0.00     0.00    15=
=2E39     0.00    0.12    0.12    0.00   0.11   0.00


Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq=
-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00 2392.00     0.00     6.56     5=
=2E62     0.50    0.21    0.00    0.21   0.21  49.10
vdc               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00


Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq=
-sz avgqu-sz   await r_await w_await  svctm  %util
vda               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00
vdb               0.00     0.00    0.00 2605.00     0.00     7.35     5=
=2E78     0.49    0.19    0.00    0.19   0.18  47.50
vdc               0.00     0.00    0.00    0.00     0.00     0.00     0=
=2E00     0.00    0.00    0.00    0.00   0.00   0.00



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Based on my observations, xfs Write barrier affect the iops performance=
=2E

I know nobarrier is definitely *NOT* recommended on vm=EF=BC=8Cbut if n=
ot, the iops is so bad.=20

So, please give me a hand.

Very appreciated to get your reply!



Alan Zhang

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
