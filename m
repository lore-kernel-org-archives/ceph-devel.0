From: wangsongbo <songbo1227@gmail.com>
Subject: Re: when an osd is started up, IO will be blocked
Date: Mon, 26 Oct 2015 13:27:55 +0800
Message-ID: <562DB9DB.1080200@gmail.com>
References: <5628F61E.1060708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33897 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbbJZF2C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Oct 2015 01:28:02 -0400
Received: by padhk11 with SMTP id hk11so177104791pad.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2015 22:28:01 -0700 (PDT)
In-Reply-To: <5628F61E.1060708@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

Hi all,

When an osd is started, I will get a lot of slow requests from the=20
corresponding osd log, as follows:

2015-10-26 03:42:51.593961 osd.4 [WRN] slow request 3.967808 seconds=20
old, received at 2015-10-26 03:42:47.625968:=20
osd_repop(client.2682003.0:2686048 43.fcf=20
d1ddfcf/rbd_data.196483222ac2db.0000000000000010/head//43 v 9744'347845=
)=20
currently commit_sent
2015-10-26 03:42:51.593964 osd.4 [WRN] slow request 3.964537 seconds=20
old, received at 2015-10-26 03:42:47.629239:=20
osd_repop(client.2682003.0:2686049 43.b4b=20
cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v=20
9744'193029) currently commit_sent
2015-10-26 03:42:52.594166 osd.4 [WRN] 40 slow requests, 17 included=20
below; oldest blocked for > 53.692556 secs
2015-10-26 03:42:52.594172 osd.4 [WRN] slow request 2.272928 seconds=20
old, received at 2015-10-26 03:42:50.321151:=20
osd_repop(client.3684690.0:191908 43.540=20
f1858540/rbd_data.1fc5ca7429fc17.0000000000000280/head//43 v 9744'63645=
)=20
currently commit_sent
2015-10-26 03:42:52.594175 osd.4 [WRN] slow request 2.270618 seconds=20
old, received at 2015-10-26 03:42:50.323461:=20
osd_op(client.3684690.0:191911 rbd_data.1fc5ca7429fc17.0000000000000209=
=20
[write 2633728~4096] 43.72b9f039 ack+ondisk+write e9744) currently=20
commit_sent
2015-10-26 03:42:52.594264 osd.4 [WRN] slow request 4.968252 seconds=20
old, received at 2015-10-26 03:42:47.625828:=20
osd_repop(client.2682003.0:2686047 43.b4b=20
cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v=20
9744'193028) currently commit_sent
2015-10-26 03:42:52.594266 osd.4 [WRN] slow request 4.968111 seconds=20
old, received at 2015-10-26 03:42:47.625968:=20
osd_repop(client.2682003.0:2686048 43.fcf=20
d1ddfcf/rbd_data.196483222ac2db.0000000000000010/head//43 v 9744'347845=
)=20
currently commit_sent
2015-10-26 03:42:52.594318 osd.4 [WRN] slow request 4.964841 seconds=20
old, received at 2015-10-26 03:42:47.629239:=20
osd_repop(client.2682003.0:2686049 43.b4b=20
cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v=20
9744'193029) currently commit_sent
2015-10-26 03:42:53.594527 osd.4 [WRN] 40 slow requests, 16 included=20
below; oldest blocked for > 54.692945 secs
2015-10-26 03:42:53.594533 osd.4 [WRN] slow request 16.004669 seconds=20
old, received at 2015-10-26 03:42:37.589800:=20
osd_repop(client.2682003.0:2686041 43.b4b=20
cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v=20
9744'193024) currently commit_sent
2015-10-26 03:42:53.594536 osd.4 [WRN] slow request 16.003889 seconds=20
old, received at 2015-10-26 03:42:37.590580:=20
osd_repop(client.2682003.0:2686040 43.fcf=20
d1ddfcf/rbd_data.196483222ac2db.0000000000000010/head//43 v 9744'347842=
)=20
currently commit_sent
2015-10-26 03:42:53.594538 osd.4 [WRN] slow request 16.000954 seconds=20
old, received at 2015-10-26 03:42:37.593515:=20
osd_repop(client.2682003.0:2686042 43.b4b=20
cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v=20
9744'193025) currently commit_sent
2015-10-26 03:42:53.594541 osd.4 [WRN] slow request 29.138828 seconds=20
old, received at 2015-10-26 03:42:24.455641:=20
osd_repop(client.4764855.0:65121 43.dbe=20
169a9dbe/rbd_data.49a7a4633ac0b1.0000000000000021/head//43 v 9744'12509=
)=20
currently commit_sent
2015-10-26 03:42:53.594543 osd.4 [WRN] slow request 15.998814 seconds=20
old, received at 2015-10-26 03:42:37.595656:=20
osd_repop(client.1800547.0:1205399 43.cc5=20
9285ecc5/rbd_data.1b794560c6e2ea.00000000000000d0/head//43 v 9744'36732=
)=20
currently commit_sent
2015-10-26 03:42:54.594892 osd.4 [WRN] 39 slow requests, 17 included=20
below; oldest blocked for > 55.693227 secs
2015-10-26 03:42:54.594908 osd.4 [WRN] slow request 4.273600 seconds=20
old, received at 2015-10-26 03:42:50.321151:=20
osd_repop(client.3684690.0:191908 43.540=20
f1858540/rbd_data.1fc5ca7429fc17.0000000000000280/head//43 v 9744'63645=
)=20
currently commit_sent
2015-10-26 03:42:54.594911 osd.4 [WRN] slow request 4.271290 seconds=20
old, received at 2015-10-26 03:42:50.323461:=20
osd_op(client.3684690.0:191911 rbd_data.1fc5ca7429fc17.0000000000000209=
=20
[write 2633728~4096] 43.72b9f039 ack+ondisk+write e9744) currently=20
commit_sent

Meanwhile, I run fio process with the rbd ioengine.
The iops of read and write were too small to response any IO from the=20
fio process,
In other words, when an osd is started, the IO of the whole cluster wil=
l=20
be blocked.
Is there some parameter to adjust ?
How to explain this  problem?
The results of running fio process were as fllows:

ebs: (g=3D0): rw=3Drandrw, bs=3D8K-8K/8K-8K/8K-8K, ioengine=3Drbd, iode=
pth=3D64
fio-2.2.9-20-g1520
Starting 1 thread
rbd engine: RBD version: 0.1.9
Jobs: 1 (f=3D1): [m(1)] [0.3% done] [0KB/0KB/0KB /s] [0/0/0 iops] [eta=20
05h:10m:14s]
ebs: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D40323: Mon Oct 26 04:02:0=
0 2015
   read : io=3D10904KB, bw=3D175183B/s, *iops=3D21*, runt=3D 63737msec
     slat (usec): min=3D0, max=3D61, avg=3D 1.11, stdev=3D 3.16
     clat (msec): min=3D1, max=3D63452, avg=3D1190.04, stdev=3D6046.28
      lat (msec): min=3D1, max=3D63452, avg=3D1190.04, stdev=3D6046.28
     clat percentiles (msec):
      |  1.00th=3D[    3],  5.00th=3D[    4], 10.00th=3D[    5], 20.00t=
h=3D[    6],
      | 30.00th=3D[    6], 40.00th=3D[    7], 50.00th=3D[    8], 60.00t=
h=3D[    9],
      | 70.00th=3D[   10], 80.00th=3D[   12], 90.00th=3D[   14], 95.00t=
h=3D[ 709],
      | 99.00th=3D[16712], 99.50th=3D[16712], 99.90th=3D[16712], 99.95t=
h=3D[16712],
      | 99.99th=3D[16712]
     bw (KB  /s): min=3D  129, max=3D 2038, per=3D100.00%, avg=3D774.00=
,=20
stdev=3D1094.73
   write: io=3D24976KB, bw=3D401264B/s,*iops=3D48,* runt=3D 63737msec
     slat (usec): min=3D0, max=3D40, avg=3D 2.48, stdev=3D 3.30
     clat (msec): min=3D2, max=3D31379, avg=3D786.91, stdev=3D4829.02
      lat (msec): min=3D2, max=3D31379, avg=3D786.92, stdev=3D4829.02
     clat percentiles (msec):
      |  1.00th=3D[    4],  5.00th=3D[    6], 10.00th=3D[    6], 20.00t=
h=3D[    8],
      | 30.00th=3D[    9], 40.00th=3D[    9], 50.00th=3D[   11], 60.00t=
h=3D[   12],
      | 70.00th=3D[   13], 80.00th=3D[   15], 90.00th=3D[   19], 95.00t=
h=3D[   29],
      | 99.00th=3D[16712], 99.50th=3D[16712], 99.90th=3D[16712], 99.95t=
h=3D[16712],
      | 99.99th=3D[16712]
     bw (KB  /s): min=3D  317, max=3D 5228, per=3D100.00%, avg=3D1957.3=
3,=20
stdev=3D2832.48
     lat (msec) : 2=3D0.07%, 4=3D3.23%, 10=3D52.29%, 20=3D35.76%, 50=3D=
4.41%
     lat (msec) : 750=3D1.36%, 1000=3D0.02%, 2000=3D0.02%, >=3D2000=3D2=
=2E83%
   cpu          : usr=3D0.03%, sys=3D0.00%, ctx=3D228, majf=3D0, minf=3D=
19
   IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.4%, 8=3D3.9%, 16=3D18.9%, 3=
2=3D73.1%,=20
 >=3D64=3D3.5%
      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%,=
 64=3D0.0%,=20
 >=3D64=3D0.0%
      complete  : 0=3D0.0%, 4=3D97.5%, 8=3D0.0%, 16=3D0.2%, 32=3D0.9%, =
64=3D1.5%,=20
 >=3D64=3D0.0%
      issued    : total=3Dr=3D1363/w=3D3122/d=3D0, short=3Dr=3D0/w=3D0/=
d=3D0,=20
drop=3Dr=3D0/w=3D0/d=3D0
      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
64

Run status group 0 (all jobs):
    READ: io=3D10904KB, aggrb=3D171KB/s, minb=3D171KB/s, maxb=3D171KB/s=
,=20
mint=3D63737msec, maxt=3D63737msec
   WRITE: io=3D24976KB, aggrb=3D391KB/s, minb=3D391KB/s, maxb=3D391KB/s=
,=20
mint=3D63737msec, maxt=3D63737msec

Disk stats (read/write):
     dm-0: ios=3D81/34, merge=3D0/0, ticks=3D472/26, in_queue=3D498, ut=
il=3D0.30%,=20
aggrios=3D143/102, aggrmerge=3D106/122, aggrticks=3D1209/134,=20
aggrin_queue=3D1343, aggrutil=3D0.60%
   sdd: ios=3D143/102, merge=3D106/122, ticks=3D1209/134, in_queue=3D13=
43,=20
util=3D0.60%


Thanks and Regards,
WangSongbo

On 15/10/22 =E4=B8=8B=E5=8D=8810:43, wangsongbo wrote:
> Hi all,
>
> When an osd is started, relative IO will be blocked.
> According to the test result,the larger iops the clients send , the=20
> longer it will take to elapse.
> Adjustment on all the parameters associate with recovery operations=20
> was also found useless.
>
> How to reduce the impact of this process on the IO ?
>
> Thanks and Regards,
> WangSongbo
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
