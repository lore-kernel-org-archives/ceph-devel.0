From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: async messenger small benchmark result
Date: Wed, 29 Apr 2015 08:10:26 +0200 (CEST)
Message-ID: <559625968.775037886.1430287826461.JavaMail.zimbra@oxygem.tv>
References: <1034248732.735373173.1430210204922.JavaMail.zimbra@oxygem.tv> <553F8FC3.5050502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:58236 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbbD2GK3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Apr 2015 02:10:29 -0400
In-Reply-To: <553F8FC3.5050502@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>>Thanks!  So far we've gotten a report that asyncmesseneger was a litt=
le=20
>>slower than simple messenger, but not this bad!  I imagine Greg will=20
>>have lots of questions. :)

Note that this is with hammer, so maybe some improvements are already d=
one is master ?


----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>, "ceph-devel" <ceph-devel@vge=
r.kernel.org>
Envoy=C3=A9: Mardi 28 Avril 2015 15:48:51
Objet: Re: async messenger small benchmark result

Hi Alex,=20

Thanks! So far we've gotten a report that asyncmesseneger was a little=20
slower than simple messenger, but not this bad! I imagine Greg will=20
have lots of questions. :)=20

Mark=20

On 04/28/2015 03:36 AM, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> here a small bench 4k randread of simple messenger vs async messenger=
=20
>=20
> This is with 2 osd, and 15 fio jobs on a single rbd volume=20
>=20
> simple messager : 345kiops=20
> async messenger : 139kiops=20
>=20
> Regards,=20
>=20
> Alexandre=20
>=20
>=20
>=20
>=20
> simple messenger=20
> ---------------=20
>=20
> ^Cbs: 15 (f=3D15): [r(15)] [0.0% done] [1346MB/0KB/0KB /s] [345K/0/0 =
iops] [eta 59d:13h:32m:43s]=20
> fio: terminating on signal 2=20
>=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D15): err=3D 0: pid=3D44713: =
Tue Apr 28 10:26:21 2015=20
> read : io=3D15794MB, bw=3D1321.4MB/s, iops=3D338255, runt=3D 11953mse=
c=20
> slat (usec): min=3D5, max=3D17316, avg=3D33.81, stdev=3D63.77=20
> clat (usec): min=3D4, max=3D60848, avg=3D1011.22, stdev=3D1026.16=20
> lat (usec): min=3D110, max=3D60857, avg=3D1045.03, stdev=3D1031.56=20
> clat percentiles (usec):=20
> | 1.00th=3D[ 219], 5.00th=3D[ 298], 10.00th=3D[ 362], 20.00th=3D[ 466=
],=20
> | 30.00th=3D[ 572], 40.00th=3D[ 676], 50.00th=3D[ 796], 60.00th=3D[ 9=
40],=20
> | 70.00th=3D[ 1112], 80.00th=3D[ 1336], 90.00th=3D[ 1784], 95.00th=3D=
[ 2288],=20
> | 99.00th=3D[ 4128], 99.50th=3D[ 5536], 99.90th=3D[13376], 99.95th=3D=
[17536],=20
> | 99.99th=3D[28544]=20
> bw (KB /s): min=3D31386, max=3D122224, per=3D6.67%, avg=3D90244.35, s=
tdev=3D17571.24=20
> lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=3D0.01%, 250=3D2=
=2E21%=20
> lat (usec) : 500=3D21.02%, 750=3D22.82%, 1000=3D17.99%=20
> lat (msec) : 2=3D28.62%, 4=3D6.26%, 10=3D0.88%, 20=3D0.15%, 50=3D0.03=
%=20
> lat (msec) : 100=3D0.01%=20
> cpu : usr=3D36.30%, sys=3D10.85%, ctx=3D2323657, majf=3D0, minf=3D573=
6=20
> IO depths : 1=3D0.2%, 2=3D0.8%, 4=3D3.4%, 8=3D16.3%, 16=3D72.0%, 32=3D=
7.3%, >=3D64=3D0.0%=20
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0=
=2E0%, >=3D64=3D0.0%=20
> complete : 0=3D0.0%, 4=3D94.8%, 8=3D1.0%, 16=3D1.5%, 32=3D2.6%, 64=3D=
0.0%, >=3D64=3D0.0%=20
> issued : total=3Dr=3D4043164/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, =
drop=3Dr=3D0/w=3D0/d=3D0=20
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D15794MB, aggrb=3D1321.4MB/s, minb=3D1321.4MB/s, maxb=3D132=
1.4MB/s, mint=3D11953msec, maxt=3D11953msec=20
>=20
>=20
> async messenger (ms_async_op_threads=3D10)=20
> -----------------------------------------=20
> ^Cbs: 15 (f=3D15): [r(15)] [0.0% done] [544.6MB/0KB/0KB /s] [139K/0/0=
 iops] [eta 301d:09h:10m:03s]=20
> fio: terminating on signal 2=20
>=20
> rbd_iodepth32-test: (groupid=3D0, jobs=3D15): err=3D 0: pid=3D42935: =
Tue Apr 28 10:24:29 2015=20
> read : io=3D6389.8MB, bw=3D547856KB/s, iops=3D136963, runt=3D 11943ms=
ec=20
> slat (usec): min=3D7, max=3D23454, avg=3D39.33, stdev=3D226.05=20
> clat (usec): min=3D58, max=3D107304, avg=3D3002.03, stdev=3D6270.44=20
> lat (usec): min=3D91, max=3D107327, avg=3D3041.36, stdev=3D6279.32=20
> clat percentiles (usec):=20
> | 1.00th=3D[ 129], 5.00th=3D[ 177], 10.00th=3D[ 229], 20.00th=3D[ 334=
],=20
> | 30.00th=3D[ 446], 40.00th=3D[ 564], 50.00th=3D[ 692], 60.00th=3D[ 8=
36],=20
> | 70.00th=3D[ 1032], 80.00th=3D[ 1576], 90.00th=3D[10816], 95.00th=3D=
[17792],=20
> | 99.00th=3D[29824], 99.50th=3D[34048], 99.90th=3D[42240], 99.95th=3D=
[45824],=20
> | 99.99th=3D[50432]=20
> bw (KB /s): min=3D13359, max=3D128824, per=3D6.67%, avg=3D36544.92, s=
tdev=3D37000.58=20
> lat (usec) : 100=3D0.04%, 250=3D12.05%, 500=3D22.51%, 750=3D19.70%, 1=
000=3D14.66%=20
> lat (msec) : 2=3D12.32%, 4=3D2.66%, 10=3D5.34%, 20=3D6.81%, 50=3D3.91=
%=20
> lat (msec) : 100=3D0.01%, 250=3D0.01%=20
> cpu : usr=3D19.03%, sys=3D6.33%, ctx=3D370760, majf=3D0, minf=3D11335=
=20
> IO depths : 1=3D0.4%, 2=3D0.9%, 4=3D5.3%, 8=3D20.2%, 16=3D66.0%, 32=3D=
7.3%, >=3D64=3D0.0%=20
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0=
=2E0%, >=3D64=3D0.0%=20
> complete : 0=3D0.0%, 4=3D95.5%, 8=3D0.9%, 16=3D0.9%, 32=3D2.8%, 64=3D=
0.0%, >=3D64=3D0.0%=20
> issued : total=3Dr=3D1635761/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, =
drop=3Dr=3D0/w=3D0/d=3D0=20
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32=20
>=20
> Run status group 0 (all jobs):=20
> READ: io=3D6389.8MB, aggrb=3D547855KB/s, minb=3D547855KB/s, maxb=3D54=
7855KB/s, mint=3D11943msec, maxt=3D11943msec=20
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
