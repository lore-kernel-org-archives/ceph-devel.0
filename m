From: Sasha Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Commit and Apply latency on nautilus
Date: Mon, 30 Sep 2019 13:45:16 -0500
Message-ID: <CALi_L4-fNi=gP9sOCWPNcok9tVG=K-rtER68n1s9bkZzwuGhEw@mail.gmail.com>
References: <qmq36f$5pap$1@blaine.gmane.org>
 <H000007100150ea4.1569860022.sx.f1-outsourcing.eu*@MHS>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1468624125048755040=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <H000007100150ea4.1569860022.sx.f1-outsourcing.eu*@MHS>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Marc Roos <M.Roos-yG4tGvGIC004hcxptnrGZodd74u8MsAO@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1468624125048755040==
Content-Type: multipart/alternative; boundary="0000000000002948f30593c9a55a"

--0000000000002948f30593c9a55a
Content-Type: text/plain; charset="UTF-8"

In my case, I am using premade Prometheus sourced dashboards in grafana.

For individual latency, the query looks like that

 irate(ceph_osd_op_r_latency_sum{ceph_daemon=~"$osd"}[1m]) / on
(ceph_daemon) irate(ceph_osd_op_r_latency_count[1m])
irate(ceph_osd_op_w_latency_sum{ceph_daemon=~"$osd"}[1m]) / on
(ceph_daemon) irate(ceph_osd_op_w_latency_count[1m])

The other ones use

ceph_osd_commit_latency_ms
ceph_osd_apply_latency_ms

and graph the distribution of it over time

Also, average OSD op latency

avg(rate(ceph_osd_op_r_latency_sum{cluster="$cluster"}[5m]) /
rate(ceph_osd_op_r_latency_count{cluster="$cluster"}[5m]) >= 0)
avg(rate(ceph_osd_op_w_latency_sum{cluster="$cluster"}[5m]) /
rate(ceph_osd_op_w_latency_count{cluster="$cluster"}[5m]) >= 0)

Average OSD apply + commit latency
avg(ceph_osd_apply_latency_ms{cluster="$cluster"})
avg(ceph_osd_commit_latency_ms{cluster="$cluster"})


On Mon, Sep 30, 2019 at 11:13 AM Marc Roos <M.Roos-yG4tGvGIC004hcxptnrGZodd74u8MsAO@public.gmane.org> wrote:

>
> What parameters are you exactly using? I want to do a similar test on
> luminous, before I upgrade to Nautilus. I have quite a lot (74+)
>
> type_instance=Osd.opBeforeDequeueOpLat
> type_instance=Osd.opBeforeQueueOpLat
> type_instance=Osd.opLatency
> type_instance=Osd.opPrepareLatency
> type_instance=Osd.opProcessLatency
> type_instance=Osd.opRLatency
> type_instance=Osd.opRPrepareLatency
> type_instance=Osd.opRProcessLatency
> type_instance=Osd.opRwLatency
> type_instance=Osd.opRwPrepareLatency
> type_instance=Osd.opRwProcessLatency
> type_instance=Osd.opWLatency
> type_instance=Osd.opWPrepareLatency
> type_instance=Osd.opWProcessLatency
> type_instance=Osd.subopLatency
> type_instance=Osd.subopWLatency
> ...
> ...
>
>
>
>
>
> -----Original Message-----
> From: Alex Litvak [mailto:alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: zondag 29 september 2019 13:06
> To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: [ceph-users] Commit and Apply latency on nautilus
>
> Hello everyone,
>
> I am running a number of parallel benchmark tests against the cluster
> that should be ready to go to production.
> I enabled prometheus to monitor various information and while cluster
> stays healthy through the tests with no errors or slow requests,
> I noticed an apply / commit latency jumping between 40 - 600 ms on
> multiple SSDs.  At the same time op_read and op_write are on average
> below 0.25 ms in the worth case scenario.
>
> I am running nautilus 14.2.2, all bluestore, no separate NVME devices
> for WAL/DB, 6 SSDs per node(Dell PowerEdge R440) with all drives Seagate
> Nytro 1551, osd spread across 6 nodes, running in
> containers.  Each node has plenty of RAM with utilization ~ 25 GB during
> the benchmark runs.
>
> Here are benchmarks being run from 6 client systems in parallel,
> repeating the test for each block size in <4k,16k,128k,4M>.
>
> On rbd mapped partition local to each client:
>
> fio --name=randrw --ioengine=libaio --iodepth=4 --rw=randrw
> --bs=<4k,16k,128k,4M> --direct=1 --size=2G --numjobs=8 --runtime=300
> --group_reporting --time_based --rwmixread=70
>
> On mounted cephfs volume with each client storing test file(s) in own
> sub-directory:
>
> fio --name=randrw --ioengine=libaio --iodepth=4 --rw=randrw
> --bs=<4k,16k,128k,4M> --direct=1 --size=2G --numjobs=8 --runtime=300
> --group_reporting --time_based --rwmixread=70
>
> dbench -t 30 30
>
> Could you please let me know if huge jump in applied and committed
> latency is justified in my case and whether I can do anything to improve
> / fix it.  Below is some additional cluster info.
>
> Thank you,
>
> root@storage2n2-la:~# podman exec -it ceph-mon-storage2n2-la ceph osd df
> ID CLASS WEIGHT  REWEIGHT SIZE    RAW USE DATA    OMAP    META     AVAIL
>   %USE VAR  PGS STATUS
>   6   ssd 1.74609  1.00000 1.7 TiB  93 GiB  92 GiB 240 MiB  784 MiB 1.7
> TiB 5.21 0.90  44     up
> 12   ssd 1.74609  1.00000 1.7 TiB  98 GiB  97 GiB 118 MiB  906 MiB 1.7
> TiB 5.47 0.95  40     up
> 18   ssd 1.74609  1.00000 1.7 TiB 102 GiB 101 GiB 123 MiB  901 MiB 1.6
> TiB 5.73 0.99  47     up
> 24   ssd 3.49219  1.00000 3.5 TiB 222 GiB 221 GiB 134 MiB  890 MiB 3.3
> TiB 6.20 1.07  96     up
> 30   ssd 3.49219  1.00000 3.5 TiB 213 GiB 212 GiB 151 MiB  873 MiB 3.3
> TiB 5.95 1.03  93     up
> 35   ssd 3.49219  1.00000 3.5 TiB 203 GiB 202 GiB 301 MiB  723 MiB 3.3
> TiB 5.67 0.98 100     up
>   5   ssd 1.74609  1.00000 1.7 TiB 103 GiB 102 GiB 123 MiB  901 MiB 1.6
> TiB 5.78 1.00  49     up
> 11   ssd 1.74609  1.00000 1.7 TiB 109 GiB 108 GiB  63 MiB  961 MiB 1.6
> TiB 6.09 1.05  46     up
> 17   ssd 1.74609  1.00000 1.7 TiB 104 GiB 103 GiB 205 MiB  819 MiB 1.6
> TiB 5.81 1.01  50     up
> 23   ssd 3.49219  1.00000 3.5 TiB 210 GiB 209 GiB 168 MiB  856 MiB 3.3
> TiB 5.86 1.01  86     up
> 29   ssd 3.49219  1.00000 3.5 TiB 204 GiB 203 GiB 272 MiB  752 MiB 3.3
> TiB 5.69 0.98  92     up
> 34   ssd 3.49219  1.00000 3.5 TiB 198 GiB 197 GiB 295 MiB  729 MiB 3.3
> TiB 5.54 0.96  85     up
>   4   ssd 1.74609  1.00000 1.7 TiB 119 GiB 118 GiB  16 KiB 1024 MiB 1.6
> TiB 6.67 1.15  50     up
> 10   ssd 1.74609  1.00000 1.7 TiB  95 GiB  94 GiB 183 MiB  841 MiB 1.7
> TiB 5.31 0.92  46     up
> 16   ssd 1.74609  1.00000 1.7 TiB 102 GiB 101 GiB 122 MiB  902 MiB 1.6
> TiB 5.72 0.99  50     up
> 22   ssd 3.49219  1.00000 3.5 TiB 218 GiB 217 GiB 109 MiB  915 MiB 3.3
> TiB 6.11 1.06  91     up
> 28   ssd 3.49219  1.00000 3.5 TiB 198 GiB 197 GiB 343 MiB  681 MiB 3.3
> TiB 5.54 0.96  95     up
> 33   ssd 3.49219  1.00000 3.5 TiB 198 GiB 196 GiB 297 MiB 1019 MiB 3.3
> TiB 5.53 0.96  85     up
>   1   ssd 1.74609  1.00000 1.7 TiB 101 GiB 100 GiB 222 MiB  802 MiB 1.6
> TiB 5.63 0.97  49     up
>   7   ssd 1.74609  1.00000 1.7 TiB 102 GiB 101 GiB 153 MiB  871 MiB 1.6
> TiB 5.69 0.99  46     up
> 13   ssd 1.74609  1.00000 1.7 TiB 106 GiB 105 GiB  67 MiB  957 MiB 1.6
> TiB 5.96 1.03  42     up
> 19   ssd 3.49219  1.00000 3.5 TiB 206 GiB 205 GiB 179 MiB  845 MiB 3.3
> TiB 5.77 1.00  83     up
> 25   ssd 3.49219  1.00000 3.5 TiB 195 GiB 194 GiB 352 MiB  672 MiB 3.3
> TiB 5.45 0.94  97     up
> 31   ssd 3.49219  1.00000 3.5 TiB 201 GiB 200 GiB 305 MiB  719 MiB 3.3
> TiB 5.62 0.97  90     up
>   0   ssd 1.74609  1.00000 1.7 TiB 110 GiB 109 GiB  29 MiB  995 MiB 1.6
> TiB 6.14 1.06  43     up
>   3   ssd 1.74609  1.00000 1.7 TiB 109 GiB 108 GiB  28 MiB  996 MiB 1.6
> TiB 6.07 1.05  41     up
>   9   ssd 1.74609  1.00000 1.7 TiB 103 GiB 102 GiB 149 MiB  875 MiB 1.6
> TiB 5.76 1.00  52     up
> 15   ssd 3.49219  1.00000 3.5 TiB 209 GiB 208 GiB 253 MiB  771 MiB 3.3
> TiB 5.83 1.01  98     up
> 21   ssd 3.49219  1.00000 3.5 TiB 199 GiB 198 GiB 302 MiB  722 MiB 3.3
> TiB 5.56 0.96  90     up
> 27   ssd 3.49219  1.00000 3.5 TiB 208 GiB 207 GiB 226 MiB  798 MiB 3.3
> TiB 5.81 1.00  95     up
>   2   ssd 1.74609  1.00000 1.7 TiB  96 GiB  95 GiB 158 MiB  866 MiB 1.7
> TiB 5.35 0.93  45     up
>   8   ssd 1.74609  1.00000 1.7 TiB 106 GiB 105 GiB 132 MiB  892 MiB 1.6
> TiB 5.91 1.02  50     up
> 14   ssd 1.74609  1.00000 1.7 TiB  96 GiB  95 GiB 180 MiB  844 MiB 1.7
> TiB 5.35 0.92  46     up
> 20   ssd 3.49219  1.00000 3.5 TiB 221 GiB 220 GiB 156 MiB  868 MiB 3.3
> TiB 6.18 1.07 101     up
> 26   ssd 3.49219  1.00000 3.5 TiB 206 GiB 205 GiB 332 MiB  692 MiB 3.3
> TiB 5.76 1.00  92     up
> 32   ssd 3.49219  1.00000 3.5 TiB 221 GiB 220 GiB  88 MiB  936 MiB 3.3
> TiB 6.18 1.07  91     up
>                      TOTAL  94 TiB 5.5 TiB 5.4 TiB 6.4 GiB   30 GiB  89
> TiB 5.78
> MIN/MAX VAR: 0.90/1.15  STDDEV: 0.30
>
>
> root@storage2n2-la:~# podman exec -it ceph-mon-storage2n2-la ceph -s
>    cluster:
>      id:     9b4468b7-5bf2-4964-8aec-4b2f4bee87ad
>      health: HEALTH_OK
>
>    services:
>      mon: 3 daemons, quorum storage2n1-la,storage2n2-la,storage2n3-la
> (age 9w)
>      mgr: storage2n2-la(active, since 9w), standbys: storage2n1-la,
> storage2n3-la
>      mds: cephfs:1 {0=storage2n6-la=up:active} 1 up:standby-replay 1
> up:standby
>      osd: 36 osds: 36 up (since 9w), 36 in (since 9w)
>
>    data:
>      pools:   3 pools, 832 pgs
>      objects: 4.18M objects, 1.8 TiB
>      usage:   5.5 TiB used, 89 TiB / 94 TiB avail
>      pgs:     832 active+clean
>
>    io:
>      client:   852 B/s rd, 15 KiB/s wr, 4 op/s rd, 2 op/s wr
>
>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>

--0000000000002948f30593c9a55a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In my case, I am using premade Prometheus sourced dashboar=
ds in grafana.<div><br></div><div>For individual latency, the query looks l=
ike that</div><div><br></div><div>=C2=A0irate(ceph_osd_op_r_latency_sum{cep=
h_daemon=3D~&quot;$osd&quot;}[1m])=C2=A0/=C2=A0on=C2=A0(ceph_daemon)=C2=A0i=
rate(ceph_osd_op_r_latency_count[1m])</div><div>irate(ceph_osd_op_w_latency=
_sum{ceph_daemon=3D~&quot;$osd&quot;}[1m])=C2=A0/=C2=A0on=C2=A0(ceph_daemon=
)=C2=A0irate(ceph_osd_op_w_latency_count[1m])<br></div><div><br></div><div>=
The other ones use=C2=A0</div><div><br></div><div><span style=3D"white-spac=
e:pre-wrap">ceph_osd_commit_latency_ms</span><br></div><div><span style=3D"=
white-space:pre-wrap">ceph_osd_apply_latency_ms</span><span style=3D"white-=
space:pre-wrap"><br></span></div><div><br></div><div>and graph the distribu=
tion of it over time</div><div><br></div><div>Also, average OSD op latency=
=C2=A0</div><div><br></div><div>avg(rate(ceph_osd_op_r_latency_sum{cluster=
=3D&quot;$cluster&quot;}[5m])=C2=A0/=C2=A0rate(ceph_osd_op_r_latency_count{=
cluster=3D&quot;$cluster&quot;}[5m])=C2=A0&gt;=3D=C2=A00)<br></div><div>avg=
(rate(ceph_osd_op_w_latency_sum{cluster=3D&quot;$cluster&quot;}[5m])=C2=A0/=
=C2=A0rate(ceph_osd_op_w_latency_count{cluster=3D&quot;$cluster&quot;}[5m])=
=C2=A0&gt;=3D=C2=A00)<br></div><div><br></div><div>Average OSD apply=C2=A0+=
 commit latency</div><div>avg(ceph_osd_apply_latency_ms{cluster=3D&quot;$cl=
uster&quot;})<br></div><div>avg(ceph_osd_commit_latency_ms{cluster=3D&quot;=
$cluster&quot;})<div class=3D"gmail-yj6qo gmail-ajU" style=3D"outline:none;=
padding:10px 0px;width:22px;margin:2px 0px 0px"><br class=3D"gmail-Apple-in=
terchange-newline"></div></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Mon, Sep 30, 2019 at 11:13 AM Marc Roos &=
lt;<a href=3D"mailto:M.Roos-yG4tGvGIC004hcxptnrGZodd74u8MsAO@public.gmane.org">M.Roos-yG4tGvGIC004hcxptnrGZodd74u8MsAO@public.gmane.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
What parameters are you exactly using? I want to do a similar test on <br>
luminous, before I upgrade to Nautilus. I have quite a lot (74+)<br>
<br>
type_instance=3DOsd.opBeforeDequeueOpLat<br>
type_instance=3DOsd.opBeforeQueueOpLat<br>
type_instance=3DOsd.opLatency<br>
type_instance=3DOsd.opPrepareLatency<br>
type_instance=3DOsd.opProcessLatency<br>
type_instance=3DOsd.opRLatency<br>
type_instance=3DOsd.opRPrepareLatency<br>
type_instance=3DOsd.opRProcessLatency<br>
type_instance=3DOsd.opRwLatency<br>
type_instance=3DOsd.opRwPrepareLatency<br>
type_instance=3DOsd.opRwProcessLatency<br>
type_instance=3DOsd.opWLatency<br>
type_instance=3DOsd.opWPrepareLatency<br>
type_instance=3DOsd.opWProcessLatency<br>
type_instance=3DOsd.subopLatency<br>
type_instance=3DOsd.subopWLatency<br>
...<br>
...<br>
<br>
<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: Alex Litvak [mailto:<a href=3D"mailto:alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" t=
arget=3D"_blank">alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>] <br>
Sent: zondag 29 september 2019 13:06<br>
To: <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-use=
rs-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
Cc: <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" target=3D"_blank">ceph-de=
vel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
Subject: [ceph-users] Commit and Apply latency on nautilus<br>
<br>
Hello everyone,<br>
<br>
I am running a number of parallel benchmark tests against the cluster <br>
that should be ready to go to production.<br>
I enabled prometheus to monitor various information and while cluster <br>
stays healthy through the tests with no errors or slow requests,<br>
I noticed an apply / commit latency jumping between 40 - 600 ms on <br>
multiple SSDs.=C2=A0 At the same time op_read and op_write are on average <=
br>
below 0.25 ms in the worth case scenario.<br>
<br>
I am running nautilus 14.2.2, all bluestore, no separate NVME devices <br>
for WAL/DB, 6 SSDs per node(Dell PowerEdge R440) with all drives Seagate <b=
r>
Nytro 1551, osd spread across 6 nodes, running in <br>
containers.=C2=A0 Each node has plenty of RAM with utilization ~ 25 GB duri=
ng <br>
the benchmark runs.<br>
<br>
Here are benchmarks being run from 6 client systems in parallel, <br>
repeating the test for each block size in &lt;4k,16k,128k,4M&gt;.<br>
<br>
On rbd mapped partition local to each client:<br>
<br>
fio --name=3Drandrw --ioengine=3Dlibaio --iodepth=3D4 --rw=3Drandrw <br>
--bs=3D&lt;4k,16k,128k,4M&gt; --direct=3D1 --size=3D2G --numjobs=3D8 --runt=
ime=3D300 <br>
--group_reporting --time_based --rwmixread=3D70<br>
<br>
On mounted cephfs volume with each client storing test file(s) in own <br>
sub-directory:<br>
<br>
fio --name=3Drandrw --ioengine=3Dlibaio --iodepth=3D4 --rw=3Drandrw <br>
--bs=3D&lt;4k,16k,128k,4M&gt; --direct=3D1 --size=3D2G --numjobs=3D8 --runt=
ime=3D300 <br>
--group_reporting --time_based --rwmixread=3D70<br>
<br>
dbench -t 30 30<br>
<br>
Could you please let me know if huge jump in applied and committed <br>
latency is justified in my case and whether I can do anything to improve <b=
r>
/ fix it.=C2=A0 Below is some additional cluster info.<br>
<br>
Thank you,<br>
<br>
root@storage2n2-la:~# podman exec -it ceph-mon-storage2n2-la ceph osd df<br=
>
ID CLASS WEIGHT=C2=A0 REWEIGHT SIZE=C2=A0 =C2=A0 RAW USE DATA=C2=A0 =C2=A0 =
OMAP=C2=A0 =C2=A0 META=C2=A0 =C2=A0 =C2=A0AVAIL <br>
=C2=A0 %USE VAR=C2=A0 PGS STATUS<br>
=C2=A0 6=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB=C2=A0 93 GiB=C2=A0 9=
2 GiB 240 MiB=C2=A0 784 MiB 1.7 <br>
TiB 5.21 0.90=C2=A0 44=C2=A0 =C2=A0 =C2=A0up<br>
12=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB=C2=A0 98 GiB=C2=A0 97 GiB =
118 MiB=C2=A0 906 MiB 1.7 <br>
TiB 5.47 0.95=C2=A0 40=C2=A0 =C2=A0 =C2=A0up<br>
18=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 102 GiB 101 GiB 123 MiB=C2=
=A0 901 MiB 1.6 <br>
TiB 5.73 0.99=C2=A0 47=C2=A0 =C2=A0 =C2=A0up<br>
24=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 222 GiB 221 GiB 134 MiB=C2=
=A0 890 MiB 3.3 <br>
TiB 6.20 1.07=C2=A0 96=C2=A0 =C2=A0 =C2=A0up<br>
30=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 213 GiB 212 GiB 151 MiB=C2=
=A0 873 MiB 3.3 <br>
TiB 5.95 1.03=C2=A0 93=C2=A0 =C2=A0 =C2=A0up<br>
35=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 203 GiB 202 GiB 301 MiB=C2=
=A0 723 MiB 3.3 <br>
TiB 5.67 0.98 100=C2=A0 =C2=A0 =C2=A0up<br>
=C2=A0 5=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 103 GiB 102 GiB 123 =
MiB=C2=A0 901 MiB 1.6 <br>
TiB 5.78 1.00=C2=A0 49=C2=A0 =C2=A0 =C2=A0up<br>
11=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 109 GiB 108 GiB=C2=A0 63 M=
iB=C2=A0 961 MiB 1.6 <br>
TiB 6.09 1.05=C2=A0 46=C2=A0 =C2=A0 =C2=A0up<br>
17=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 104 GiB 103 GiB 205 MiB=C2=
=A0 819 MiB 1.6 <br>
TiB 5.81 1.01=C2=A0 50=C2=A0 =C2=A0 =C2=A0up<br>
23=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 210 GiB 209 GiB 168 MiB=C2=
=A0 856 MiB 3.3 <br>
TiB 5.86 1.01=C2=A0 86=C2=A0 =C2=A0 =C2=A0up<br>
29=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 204 GiB 203 GiB 272 MiB=C2=
=A0 752 MiB 3.3 <br>
TiB 5.69 0.98=C2=A0 92=C2=A0 =C2=A0 =C2=A0up<br>
34=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 198 GiB 197 GiB 295 MiB=C2=
=A0 729 MiB 3.3 <br>
TiB 5.54 0.96=C2=A0 85=C2=A0 =C2=A0 =C2=A0up<br>
=C2=A0 4=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 119 GiB 118 GiB=C2=
=A0 16 KiB 1024 MiB 1.6 <br>
TiB 6.67 1.15=C2=A0 50=C2=A0 =C2=A0 =C2=A0up<br>
10=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB=C2=A0 95 GiB=C2=A0 94 GiB =
183 MiB=C2=A0 841 MiB 1.7 <br>
TiB 5.31 0.92=C2=A0 46=C2=A0 =C2=A0 =C2=A0up<br>
16=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 102 GiB 101 GiB 122 MiB=C2=
=A0 902 MiB 1.6 <br>
TiB 5.72 0.99=C2=A0 50=C2=A0 =C2=A0 =C2=A0up<br>
22=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 218 GiB 217 GiB 109 MiB=C2=
=A0 915 MiB 3.3 <br>
TiB 6.11 1.06=C2=A0 91=C2=A0 =C2=A0 =C2=A0up<br>
28=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 198 GiB 197 GiB 343 MiB=C2=
=A0 681 MiB 3.3 <br>
TiB 5.54 0.96=C2=A0 95=C2=A0 =C2=A0 =C2=A0up<br>
33=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 198 GiB 196 GiB 297 MiB 10=
19 MiB 3.3 <br>
TiB 5.53 0.96=C2=A0 85=C2=A0 =C2=A0 =C2=A0up<br>
=C2=A0 1=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 101 GiB 100 GiB 222 =
MiB=C2=A0 802 MiB 1.6 <br>
TiB 5.63 0.97=C2=A0 49=C2=A0 =C2=A0 =C2=A0up<br>
=C2=A0 7=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 102 GiB 101 GiB 153 =
MiB=C2=A0 871 MiB 1.6 <br>
TiB 5.69 0.99=C2=A0 46=C2=A0 =C2=A0 =C2=A0up<br>
13=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 106 GiB 105 GiB=C2=A0 67 M=
iB=C2=A0 957 MiB 1.6 <br>
TiB 5.96 1.03=C2=A0 42=C2=A0 =C2=A0 =C2=A0up<br>
19=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 206 GiB 205 GiB 179 MiB=C2=
=A0 845 MiB 3.3 <br>
TiB 5.77 1.00=C2=A0 83=C2=A0 =C2=A0 =C2=A0up<br>
25=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 195 GiB 194 GiB 352 MiB=C2=
=A0 672 MiB 3.3 <br>
TiB 5.45 0.94=C2=A0 97=C2=A0 =C2=A0 =C2=A0up<br>
31=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 201 GiB 200 GiB 305 MiB=C2=
=A0 719 MiB 3.3 <br>
TiB 5.62 0.97=C2=A0 90=C2=A0 =C2=A0 =C2=A0up<br>
=C2=A0 0=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 110 GiB 109 GiB=C2=
=A0 29 MiB=C2=A0 995 MiB 1.6 <br>
TiB 6.14 1.06=C2=A0 43=C2=A0 =C2=A0 =C2=A0up<br>
=C2=A0 3=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 109 GiB 108 GiB=C2=
=A0 28 MiB=C2=A0 996 MiB 1.6 <br>
TiB 6.07 1.05=C2=A0 41=C2=A0 =C2=A0 =C2=A0up<br>
=C2=A0 9=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 103 GiB 102 GiB 149 =
MiB=C2=A0 875 MiB 1.6 <br>
TiB 5.76 1.00=C2=A0 52=C2=A0 =C2=A0 =C2=A0up<br>
15=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 209 GiB 208 GiB 253 MiB=C2=
=A0 771 MiB 3.3 <br>
TiB 5.83 1.01=C2=A0 98=C2=A0 =C2=A0 =C2=A0up<br>
21=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 199 GiB 198 GiB 302 MiB=C2=
=A0 722 MiB 3.3 <br>
TiB 5.56 0.96=C2=A0 90=C2=A0 =C2=A0 =C2=A0up<br>
27=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 208 GiB 207 GiB 226 MiB=C2=
=A0 798 MiB 3.3 <br>
TiB 5.81 1.00=C2=A0 95=C2=A0 =C2=A0 =C2=A0up<br>
=C2=A0 2=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB=C2=A0 96 GiB=C2=A0 9=
5 GiB 158 MiB=C2=A0 866 MiB 1.7 <br>
TiB 5.35 0.93=C2=A0 45=C2=A0 =C2=A0 =C2=A0up<br>
=C2=A0 8=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 106 GiB 105 GiB 132 =
MiB=C2=A0 892 MiB 1.6 <br>
TiB 5.91 1.02=C2=A0 50=C2=A0 =C2=A0 =C2=A0up<br>
14=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB=C2=A0 96 GiB=C2=A0 95 GiB =
180 MiB=C2=A0 844 MiB 1.7 <br>
TiB 5.35 0.92=C2=A0 46=C2=A0 =C2=A0 =C2=A0up<br>
20=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 221 GiB 220 GiB 156 MiB=C2=
=A0 868 MiB 3.3 <br>
TiB 6.18 1.07 101=C2=A0 =C2=A0 =C2=A0up<br>
26=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 206 GiB 205 GiB 332 MiB=C2=
=A0 692 MiB 3.3 <br>
TiB 5.76 1.00=C2=A0 92=C2=A0 =C2=A0 =C2=A0up<br>
32=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 221 GiB 220 GiB=C2=A0 88 M=
iB=C2=A0 936 MiB 3.3 <br>
TiB 6.18 1.07=C2=A0 91=C2=A0 =C2=A0 =C2=A0up<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0TOTAL=C2=A0 94 TiB 5.5 TiB 5.4 TiB 6.4 GiB=C2=A0 =C2=A030 GiB=C2=A0 89 <=
br>
TiB 5.78<br>
MIN/MAX VAR: 0.90/1.15=C2=A0 STDDEV: 0.30<br>
<br>
<br>
root@storage2n2-la:~# podman exec -it ceph-mon-storage2n2-la ceph -s<br>
=C2=A0 =C2=A0cluster:<br>
=C2=A0 =C2=A0 =C2=A0id:=C2=A0 =C2=A0 =C2=A09b4468b7-5bf2-4964-8aec-4b2f4bee=
87ad<br>
=C2=A0 =C2=A0 =C2=A0health: HEALTH_OK<br>
<br>
=C2=A0 =C2=A0services:<br>
=C2=A0 =C2=A0 =C2=A0mon: 3 daemons, quorum storage2n1-la,storage2n2-la,stor=
age2n3-la <br>
(age 9w)<br>
=C2=A0 =C2=A0 =C2=A0mgr: storage2n2-la(active, since 9w), standbys: storage=
2n1-la, <br>
storage2n3-la<br>
=C2=A0 =C2=A0 =C2=A0mds: cephfs:1 {0=3Dstorage2n6-la=3Dup:active} 1 up:stan=
dby-replay 1 <br>
up:standby<br>
=C2=A0 =C2=A0 =C2=A0osd: 36 osds: 36 up (since 9w), 36 in (since 9w)<br>
<br>
=C2=A0 =C2=A0data:<br>
=C2=A0 =C2=A0 =C2=A0pools:=C2=A0 =C2=A03 pools, 832 pgs<br>
=C2=A0 =C2=A0 =C2=A0objects: 4.18M objects, 1.8 TiB<br>
=C2=A0 =C2=A0 =C2=A0usage:=C2=A0 =C2=A05.5 TiB used, 89 TiB / 94 TiB avail<=
br>
=C2=A0 =C2=A0 =C2=A0pgs:=C2=A0 =C2=A0 =C2=A0832 active+clean<br>
<br>
=C2=A0 =C2=A0io:<br>
=C2=A0 =C2=A0 =C2=A0client:=C2=A0 =C2=A0852 B/s rd, 15 KiB/s wr, 4 op/s rd,=
 2 op/s wr<br>
<br>
<br>
<br>
<br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
<br>
<br>
</blockquote></div>

--0000000000002948f30593c9a55a--

--===============1468624125048755040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1468624125048755040==--
