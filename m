From: wangsongbo <songbo1227-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: when an osd is started up, IO will be blocked
Date: Mon, 26 Oct 2015 13:23:41 +0800
Message-ID: <562DB8DD.9050908@gmail.com>
References: <5628F61E.1060708@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0127643111=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5628F61E.1060708-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============0127643111==
Content-Type: multipart/alternative;
 boundary="------------020502090407050101090906"

This is a multi-part message in MIME format.
--------------020502090407050101090906
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi all,

When an osd is started, I will get a lot of slow requests from the=20
corresponding osd log, as follows:

2015-10-26 03:42:51.593961 osd.4 [WRN] slow request 3.967808 seconds=20
old, received at 2015-10-26 03:42:47.625968:=20
osd_repop(client.2682003.0:2686048 43.fcf=20
d1ddfcf/rbd_data.196483222ac2db.0000000000000010/head//43 v 9744'347845)=20
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
f1858540/rbd_data.1fc5ca7429fc17.0000000000000280/head//43 v 9744'63645)=20
currently commit_sent
2015-10-26 03:42:52.594175 osd.4 [WRN] slow request 2.270618 seconds=20
old, received at 2015-10-26 03:42:50.323461:=20
osd_op(client.3684690.0:191911 rbd_data.1fc5ca7429fc17.0000000000000209=20
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
d1ddfcf/rbd_data.196483222ac2db.0000000000000010/head//43 v 9744'347845)=20
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
d1ddfcf/rbd_data.196483222ac2db.0000000000000010/head//43 v 9744'347842)=20
currently commit_sent
2015-10-26 03:42:53.594538 osd.4 [WRN] slow request 16.000954 seconds=20
old, received at 2015-10-26 03:42:37.593515:=20
osd_repop(client.2682003.0:2686042 43.b4b=20
cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v=20
9744'193025) currently commit_sent
2015-10-26 03:42:53.594541 osd.4 [WRN] slow request 29.138828 seconds=20
old, received at 2015-10-26 03:42:24.455641:=20
osd_repop(client.4764855.0:65121 43.dbe=20
169a9dbe/rbd_data.49a7a4633ac0b1.0000000000000021/head//43 v 9744'12509)=20
currently commit_sent
2015-10-26 03:42:53.594543 osd.4 [WRN] slow request 15.998814 seconds=20
old, received at 2015-10-26 03:42:37.595656:=20
osd_repop(client.1800547.0:1205399 43.cc5=20
9285ecc5/rbd_data.1b794560c6e2ea.00000000000000d0/head//43 v 9744'36732)=20
currently commit_sent
2015-10-26 03:42:54.594892 osd.4 [WRN] 39 slow requests, 17 included=20
below; oldest blocked for > 55.693227 secs
2015-10-26 03:42:54.594908 osd.4 [WRN] slow request 4.273600 seconds=20
old, received at 2015-10-26 03:42:50.321151:=20
osd_repop(client.3684690.0:191908 43.540=20
f1858540/rbd_data.1fc5ca7429fc17.0000000000000280/head//43 v 9744'63645)=20
currently commit_sent
2015-10-26 03:42:54.594911 osd.4 [WRN] slow request 4.271290 seconds=20
old, received at 2015-10-26 03:42:50.323461:=20
osd_op(client.3684690.0:191911 rbd_data.1fc5ca7429fc17.0000000000000209=20
[write 2633728~4096] 43.72b9f039 ack+ondisk+write e9744) currently=20
commit_sent



Meanwhile, I run fio process with the rbd ioengine.
The iops of read and write were too small to response any IO from the=20
fio process,
In other words, when an osd is started, the IO of the whole cluster will=20
be blocked.
Is there some parameter to adjust ?
How to explain this  problem?
The results of running fio process were as fllows:

ebs: (g=3D0): rw=3Drandrw, bs=3D8K-8K/8K-8K/8K-8K, ioengine=3Drbd, iodept=
h=3D64
fio-2.2.9-20-g1520
Starting 1 thread
rbd engine: RBD version: 0.1.9
Jobs: 1 (f=3D1): [m(1)] [0.3% done] [0KB/0KB/0KB /s] [0/0/0 iops] [eta=20
05h:10m:14s]
ebs: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D40323: Mon Oct 26 04:02:00 =
2015
   read : io=3D10904KB, bw=3D175183B/s, *iops=3D21*, runt=3D 63737msec
     slat (usec): min=3D0, max=3D61, avg=3D 1.11, stdev=3D 3.16
     clat (msec): min=3D1, max=3D63452, avg=3D1190.04, stdev=3D6046.28
      lat (msec): min=3D1, max=3D63452, avg=3D1190.04, stdev=3D6046.28
     clat percentiles (msec):
      |  1.00th=3D[    3],  5.00th=3D[    4], 10.00th=3D[    5], 20.00th=3D=
[    6],
      | 30.00th=3D[    6], 40.00th=3D[    7], 50.00th=3D[    8], 60.00th=3D=
[    9],
      | 70.00th=3D[   10], 80.00th=3D[   12], 90.00th=3D[   14], 95.00th=3D=
[ 709],
      | 99.00th=3D[16712], 99.50th=3D[16712], 99.90th=3D[16712], 99.95th=3D=
[16712],
      | 99.99th=3D[16712]
     bw (KB  /s): min=3D  129, max=3D 2038, per=3D100.00%, avg=3D774.00,=20
stdev=3D1094.73
   write: io=3D24976KB, bw=3D401264B/s,*iops=3D48,* runt=3D 63737msec
     slat (usec): min=3D0, max=3D40, avg=3D 2.48, stdev=3D 3.30
     clat (msec): min=3D2, max=3D31379, avg=3D786.91, stdev=3D4829.02
      lat (msec): min=3D2, max=3D31379, avg=3D786.92, stdev=3D4829.02
     clat percentiles (msec):
      |  1.00th=3D[    4],  5.00th=3D[    6], 10.00th=3D[    6], 20.00th=3D=
[    8],
      | 30.00th=3D[    9], 40.00th=3D[    9], 50.00th=3D[   11], 60.00th=3D=
[   12],
      | 70.00th=3D[   13], 80.00th=3D[   15], 90.00th=3D[   19], 95.00th=3D=
[   29],
      | 99.00th=3D[16712], 99.50th=3D[16712], 99.90th=3D[16712], 99.95th=3D=
[16712],
      | 99.99th=3D[16712]
     bw (KB  /s): min=3D  317, max=3D 5228, per=3D100.00%, avg=3D1957.33,=
=20
stdev=3D2832.48
     lat (msec) : 2=3D0.07%, 4=3D3.23%, 10=3D52.29%, 20=3D35.76%, 50=3D4.=
41%
     lat (msec) : 750=3D1.36%, 1000=3D0.02%, 2000=3D0.02%, >=3D2000=3D2.8=
3%
   cpu          : usr=3D0.03%, sys=3D0.00%, ctx=3D228, majf=3D0, minf=3D1=
9
   IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.4%, 8=3D3.9%, 16=3D18.9%, 32=3D=
73.1%,=20
 >=3D64=3D3.5%
      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 6=
4=3D0.0%,=20
 >=3D64=3D0.0%
      complete  : 0=3D0.0%, 4=3D97.5%, 8=3D0.0%, 16=3D0.2%, 32=3D0.9%, 64=
=3D1.5%,=20
 >=3D64=3D0.0%
      issued    : total=3Dr=3D1363/w=3D3122/d=3D0, short=3Dr=3D0/w=3D0/d=3D=
0,=20
drop=3Dr=3D0/w=3D0/d=3D0
      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D6=
4

Run status group 0 (all jobs):
    READ: io=3D10904KB, aggrb=3D171KB/s, minb=3D171KB/s, maxb=3D171KB/s,=20
mint=3D63737msec, maxt=3D63737msec
   WRITE: io=3D24976KB, aggrb=3D391KB/s, minb=3D391KB/s, maxb=3D391KB/s,=20
mint=3D63737msec, maxt=3D63737msec

Disk stats (read/write):
     dm-0: ios=3D81/34, merge=3D0/0, ticks=3D472/26, in_queue=3D498, util=
=3D0.30%,=20
aggrios=3D143/102, aggrmerge=3D106/122, aggrticks=3D1209/134,=20
aggrin_queue=3D1343, aggrutil=3D0.60%
   sdd: ios=3D143/102, merge=3D106/122, ticks=3D1209/134, in_queue=3D1343=
,=20
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


--------------020502090407050101090906
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi all,<br>
    <br>
    When an osd is started, I will get a lot of slow requests from the
    corresponding osd log, as follows:<br>
    <br>
    2015-10-26 03:42:51.593961 osd.4 [WRN] slow request 3.967808 seconds
    old, received at 2015-10-26 03:42:47.625968:
    osd_repop(client.2682003.0:2686048 43.fcf
    d1ddfcf/rbd_data.196483222ac2db.0000000000000010/head//43 v
    9744'347845) currently commit_sent<br>
    2015-10-26 03:42:51.593964 osd.4 [WRN] slow request 3.964537 seconds
    old, received at 2015-10-26 03:42:47.629239:
    osd_repop(client.2682003.0:2686049 43.b4b
    cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v
    9744'193029) currently commit_sent<br>
    2015-10-26 03:42:52.594166 osd.4 [WRN] 40 slow requests, 17 included
    below; oldest blocked for &gt; 53.692556 secs<br>
    2015-10-26 03:42:52.594172 osd.4 [WRN] slow request 2.272928 seconds
    old, received at 2015-10-26 03:42:50.321151:
    osd_repop(client.3684690.0:191908 43.540
    f1858540/rbd_data.1fc5ca7429fc17.0000000000000280/head//43 v
    9744'63645) currently commit_sent<br>
    2015-10-26 03:42:52.594175 osd.4 [WRN] slow request 2.270618 seconds
    old, received at 2015-10-26 03:42:50.323461:
    osd_op(client.3684690.0:191911
    rbd_data.1fc5ca7429fc17.0000000000000209 [write 2633728~4096]
    43.72b9f039 ack+ondisk+write e9744) currently commit_sent<br>
    2015-10-26 03:42:52.594264 osd.4 [WRN] slow request 4.968252 seconds
    old, received at 2015-10-26 03:42:47.625828:
    osd_repop(client.2682003.0:2686047 43.b4b
    cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v
    9744'193028) currently commit_sent<br>
    2015-10-26 03:42:52.594266 osd.4 [WRN] slow request 4.968111 seconds
    old, received at 2015-10-26 03:42:47.625968:
    osd_repop(client.2682003.0:2686048 43.fcf
    d1ddfcf/rbd_data.196483222ac2db.0000000000000010/head//43 v
    9744'347845) currently commit_sent<br>
    2015-10-26 03:42:52.594318 osd.4 [WRN] slow request 4.964841 seconds
    old, received at 2015-10-26 03:42:47.629239:
    osd_repop(client.2682003.0:2686049 43.b4b
    cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v
    9744'193029) currently commit_sent<br>
    2015-10-26 03:42:53.594527 osd.4 [WRN] 40 slow requests, 16 included
    below; oldest blocked for &gt; 54.692945 secs<br>
    2015-10-26 03:42:53.594533 osd.4 [WRN] slow request 16.004669
    seconds old, received at 2015-10-26 03:42:37.589800:
    osd_repop(client.2682003.0:2686041 43.b4b
    cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v
    9744'193024) currently commit_sent<br>
    2015-10-26 03:42:53.594536 osd.4 [WRN] slow request 16.003889
    seconds old, received at 2015-10-26 03:42:37.590580:
    osd_repop(client.2682003.0:2686040 43.fcf
    d1ddfcf/rbd_data.196483222ac2db.0000000000000010/head//43 v
    9744'347842) currently commit_sent<br>
    2015-10-26 03:42:53.594538 osd.4 [WRN] slow request 16.000954
    seconds old, received at 2015-10-26 03:42:37.593515:
    osd_repop(client.2682003.0:2686042 43.b4b
    cbcbbb4b/rbd_data.196483222ac2db.000000000000020b/head//43 v
    9744'193025) currently commit_sent<br>
    2015-10-26 03:42:53.594541 osd.4 [WRN] slow request 29.138828
    seconds old, received at 2015-10-26 03:42:24.455641:
    osd_repop(client.4764855.0:65121 43.dbe
    169a9dbe/rbd_data.49a7a4633ac0b1.0000000000000021/head//43 v
    9744'12509) currently commit_sent<br>
    2015-10-26 03:42:53.594543 osd.4 [WRN] slow request 15.998814
    seconds old, received at 2015-10-26 03:42:37.595656:
    osd_repop(client.1800547.0:1205399 43.cc5
    9285ecc5/rbd_data.1b794560c6e2ea.00000000000000d0/head//43 v
    9744'36732) currently commit_sent<br>
    2015-10-26 03:42:54.594892 osd.4 [WRN] 39 slow requests, 17 included
    below; oldest blocked for &gt; 55.693227 secs<br>
    2015-10-26 03:42:54.594908 osd.4 [WRN] slow request 4.273600 seconds
    old, received at 2015-10-26 03:42:50.321151:
    osd_repop(client.3684690.0:191908 43.540
    f1858540/rbd_data.1fc5ca7429fc17.0000000000000280/head//43 v
    9744'63645) currently commit_sent<br>
    2015-10-26 03:42:54.594911 osd.4 [WRN] slow request 4.271290 seconds
    old, received at 2015-10-26 03:42:50.323461:
    osd_op(client.3684690.0:191911
    rbd_data.1fc5ca7429fc17.0000000000000209 [write 2633728~4096]
    43.72b9f039 ack+ondisk+write e9744) currently commit_sent<br>
    <br>
    <br>
    <br>
    Meanwhile, I run fio process with the rbd ioengine. <br>
    The iops of read and write were too small to response any IO from
    the fio process,<br>
    In other words, when an osd is started, the IO of the whole cluster
    will be blocked.<br>
    Is there some parameter to adjust ? <br>
    How to explain this=C2=A0 problem?<br>
    The results of running fio process were as fllows:<br>
    <br>
    ebs: (g=3D0): rw=3Drandrw, bs=3D8K-8K/8K-8K/8K-8K, ioengine=3Drbd,
    iodepth=3D64<br>
    fio-2.2.9-20-g1520<br>
    Starting 1 thread<br>
    rbd engine: RBD version: 0.1.9<br>
    Jobs: 1 (f=3D1): [m(1)] [0.3% done] [0KB/0KB/0KB /s] [0/0/0 iops] [et=
a
    05h:10m:14s]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>
    ebs: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D40323: Mon Oct 26 04:02=
:00
    2015<br>
    =C2=A0 read : io=3D10904KB, bw=3D175183B/s, <b><big>iops=3D21</big></=
b>, runt=3D
    63737msec<br>
    =C2=A0=C2=A0=C2=A0 slat (usec): min=3D0, max=3D61, avg=3D 1.11, stdev=
=3D 3.16<br>
    =C2=A0=C2=A0=C2=A0 clat (msec): min=3D1, max=3D63452, avg=3D1190.04, =
stdev=3D6046.28<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 lat (msec): min=3D1, max=3D63452, avg=3D1190=
.04, stdev=3D6046.28<br>
    =C2=A0=C2=A0=C2=A0 clat percentiles (msec):<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1.00th=3D[=C2=A0=C2=A0=C2=A0 3],=C2=A0=
 5.00th=3D[=C2=A0=C2=A0=C2=A0 4], 10.00th=3D[=C2=A0=C2=A0=C2=A0 5],
    20.00th=3D[=C2=A0=C2=A0=C2=A0 6],<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 | 30.00th=3D[=C2=A0=C2=A0=C2=A0 6], 40.00th=3D=
[=C2=A0=C2=A0=C2=A0 7], 50.00th=3D[=C2=A0=C2=A0=C2=A0 8],
    60.00th=3D[=C2=A0=C2=A0=C2=A0 9],<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 | 70.00th=3D[=C2=A0=C2=A0 10], 80.00th=3D[=C2=
=A0=C2=A0 12], 90.00th=3D[=C2=A0=C2=A0 14], 95.00th=3D[=C2=A0
    709],<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 | 99.00th=3D[16712], 99.50th=3D[16712], 99.9=
0th=3D[16712],
    99.95th=3D[16712],<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 | 99.99th=3D[16712]<br>
    =C2=A0=C2=A0=C2=A0 bw (KB=C2=A0 /s): min=3D=C2=A0 129, max=3D 2038, p=
er=3D100.00%, avg=3D774.00,
    stdev=3D1094.73<br>
    =C2=A0 write: io=3D24976KB, bw=3D401264B/s,<b> <big>iops=3D48</big>,<=
/b> runt=3D
    63737msec<br>
    =C2=A0=C2=A0=C2=A0 slat (usec): min=3D0, max=3D40, avg=3D 2.48, stdev=
=3D 3.30<br>
    =C2=A0=C2=A0=C2=A0 clat (msec): min=3D2, max=3D31379, avg=3D786.91, s=
tdev=3D4829.02<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 lat (msec): min=3D2, max=3D31379, avg=3D786.=
92, stdev=3D4829.02<br>
    =C2=A0=C2=A0=C2=A0 clat percentiles (msec):<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1.00th=3D[=C2=A0=C2=A0=C2=A0 4],=C2=A0=
 5.00th=3D[=C2=A0=C2=A0=C2=A0 6], 10.00th=3D[=C2=A0=C2=A0=C2=A0 6],
    20.00th=3D[=C2=A0=C2=A0=C2=A0 8],<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 | 30.00th=3D[=C2=A0=C2=A0=C2=A0 9], 40.00th=3D=
[=C2=A0=C2=A0=C2=A0 9], 50.00th=3D[=C2=A0=C2=A0 11],
    60.00th=3D[=C2=A0=C2=A0 12],<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 | 70.00th=3D[=C2=A0=C2=A0 13], 80.00th=3D[=C2=
=A0=C2=A0 15], 90.00th=3D[=C2=A0=C2=A0 19],
    95.00th=3D[=C2=A0=C2=A0 29],<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 | 99.00th=3D[16712], 99.50th=3D[16712], 99.9=
0th=3D[16712],
    99.95th=3D[16712],<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 | 99.99th=3D[16712]<br>
    =C2=A0=C2=A0=C2=A0 bw (KB=C2=A0 /s): min=3D=C2=A0 317, max=3D 5228, p=
er=3D100.00%, avg=3D1957.33,
    stdev=3D2832.48<br>
    =C2=A0=C2=A0=C2=A0 lat (msec) : 2=3D0.07%, 4=3D3.23%, 10=3D52.29%, 20=
=3D35.76%, 50=3D4.41%<br>
    =C2=A0=C2=A0=C2=A0 lat (msec) : 750=3D1.36%, 1000=3D0.02%, 2000=3D0.0=
2%, &gt;=3D2000=3D2.83%<br>
    =C2=A0 cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : us=
r=3D0.03%, sys=3D0.00%, ctx=3D228, majf=3D0, minf=3D19<br>
    =C2=A0 IO depths=C2=A0=C2=A0=C2=A0 : 1=3D0.1%, 2=3D0.1%, 4=3D0.4%, 8=3D=
3.9%, 16=3D18.9%, 32=3D73.1%,
    &gt;=3D64=3D3.5%<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 submit=C2=A0=C2=A0=C2=A0 : 0=3D0.0%, 4=3D100=
.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%,
    64=3D0.0%, &gt;=3D64=3D0.0%<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 complete=C2=A0 : 0=3D0.0%, 4=3D97.5%, 8=3D0.=
0%, 16=3D0.2%, 32=3D0.9%, 64=3D1.5%,
    &gt;=3D64=3D0.0%<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 issued=C2=A0=C2=A0=C2=A0 : total=3Dr=3D1363/=
w=3D3122/d=3D0, short=3Dr=3D0/w=3D0/d=3D0,
    drop=3Dr=3D0/w=3D0/d=3D0<br>
    =C2=A0=C2=A0=C2=A0=C2=A0 latency=C2=A0=C2=A0 : target=3D0, window=3D0=
, percentile=3D100.00%, depth=3D64<br>
    <br>
    Run status group 0 (all jobs):<br>
    =C2=A0=C2=A0 READ: io=3D10904KB, aggrb=3D171KB/s, minb=3D171KB/s, max=
b=3D171KB/s,
    mint=3D63737msec, maxt=3D63737msec<br>
    =C2=A0 WRITE: io=3D24976KB, aggrb=3D391KB/s, minb=3D391KB/s, maxb=3D3=
91KB/s,
    mint=3D63737msec, maxt=3D63737msec<br>
    <br>
    Disk stats (read/write):<br>
    =C2=A0=C2=A0=C2=A0 dm-0: ios=3D81/34, merge=3D0/0, ticks=3D472/26, in=
_queue=3D498,
    util=3D0.30%, aggrios=3D143/102, aggrmerge=3D106/122, aggrticks=3D120=
9/134,
    aggrin_queue=3D1343, aggrutil=3D0.60%<br>
    =C2=A0 sdd: ios=3D143/102, merge=3D106/122, ticks=3D1209/134, in_queu=
e=3D1343,
    util=3D0.60%<br>
    <br>
    <br>
    Thanks and Regards,
    <br>
    WangSongbo
    <br>
    <br>
    =C2=A0<br>
    <div class=3D"moz-cite-prefix">On 15/10/22 =E4=B8=8B=E5=8D=8810:43, w=
angsongbo wrote:<br>
    </div>
    <blockquote cite=3D"mid:5628F61E.1060708-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" type=3D"cite">Hi
      all,
      <br>
      <br>
      When an osd is started, relative IO will be blocked.
      <br>
      According to the test result,the larger iops the clients send ,
      the longer it will take to elapse.
      <br>
      Adjustment on all the parameters associate with recovery
      operations was also found useless.
      <br>
      <br>
      How to reduce the impact of this process on the IO ?
      <br>
      <br>
      Thanks and Regards,
      <br>
      WangSongbo
      <br>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------020502090407050101090906--

--===============0127643111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0127643111==--
