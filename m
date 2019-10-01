From: Sasha Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Commit and Apply latency on nautilus
Date: Mon, 30 Sep 2019 19:12:05 -0500
Message-ID: <CALi_L4_dzsu3r4FGpc6K6Ce3iz6JAZmKaVTB8LXrLqVNOH1ong@mail.gmail.com>
References: <qmq36f$5pap$1@blaine.gmane.org>
 <H000007100150ea4.1569860022.sx.f1-outsourcing.eu*@MHS>
 <CALi_L4-fNi=gP9sOCWPNcok9tVG=K-rtER68n1s9bkZzwuGhEw@mail.gmail.com>
 <CAD9yTbEzPJwAqVgn2fWtjZCG8zFnAgjvtMOnO-+FJd4XQx364Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1070667957301137754=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAD9yTbEzPJwAqVgn2fWtjZCG8zFnAgjvtMOnO-+FJd4XQx364Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Paul Emmerich <paul.emmerich-iZXOWb+A65A@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1070667957301137754==
Content-Type: multipart/alternative; boundary="000000000000026f260593ce36cc"

--000000000000026f260593ce36cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

At this point, I ran out of ideas.  I changed nr_requests and readahead
parameters to 128->1024 and 128->4096, tuned nodes to
performance-throughput.  However, I still get high latency during benchmark
testing.  I attempted to disable cache on ssd

for i in {a..f}; do hdparm -W 0 -A 0 /dev/sd$i; done

and I think it make things not better at all.  I have H740 and H730
controllers with drives in HBA mode.

Other them converting them one by one to RAID0 I am not sure what else I
can try.

Any suggestions?


On Mon, Sep 30, 2019 at 2:45 PM Paul Emmerich <paul.emmerich-iZXOWb+A65A@public.gmane.org>
wrote:

> BTW: commit and apply latency are the exact same thing since
> BlueStore, so don't bother looking at both.
>
> In fact you should mostly be looking at the op_*_latency counters
>
>
> Paul
>
> --
> Paul Emmerich
>
> Looking for help with your Ceph cluster? Contact us at https://croit.io
>
> croit GmbH
> Freseniusstr. 31h
> 81247 M=C3=BCnchen
> www.croit.io
> Tel: +49 89 1896585 90
>
> On Mon, Sep 30, 2019 at 8:46 PM Sasha Litvak
> <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > In my case, I am using premade Prometheus sourced dashboards in grafana=
.
> >
> > For individual latency, the query looks like that
> >
> >  irate(ceph_osd_op_r_latency_sum{ceph_daemon=3D~"$osd"}[1m]) / on
> (ceph_daemon) irate(ceph_osd_op_r_latency_count[1m])
> > irate(ceph_osd_op_w_latency_sum{ceph_daemon=3D~"$osd"}[1m]) / on
> (ceph_daemon) irate(ceph_osd_op_w_latency_count[1m])
> >
> > The other ones use
> >
> > ceph_osd_commit_latency_ms
> > ceph_osd_apply_latency_ms
> >
> > and graph the distribution of it over time
> >
> > Also, average OSD op latency
> >
> > avg(rate(ceph_osd_op_r_latency_sum{cluster=3D"$cluster"}[5m]) /
> rate(ceph_osd_op_r_latency_count{cluster=3D"$cluster"}[5m]) >=3D 0)
> > avg(rate(ceph_osd_op_w_latency_sum{cluster=3D"$cluster"}[5m]) /
> rate(ceph_osd_op_w_latency_count{cluster=3D"$cluster"}[5m]) >=3D 0)
> >
> > Average OSD apply + commit latency
> > avg(ceph_osd_apply_latency_ms{cluster=3D"$cluster"})
> > avg(ceph_osd_commit_latency_ms{cluster=3D"$cluster"})
> >
> >
> > On Mon, Sep 30, 2019 at 11:13 AM Marc Roos <M.Roos-yG4tGvGIC004hcxptnrGZodd74u8MsAO@public.gmane.org>
> wrote:
> >>
> >>
> >> What parameters are you exactly using? I want to do a similar test on
> >> luminous, before I upgrade to Nautilus. I have quite a lot (74+)
> >>
> >> type_instance=3DOsd.opBeforeDequeueOpLat
> >> type_instance=3DOsd.opBeforeQueueOpLat
> >> type_instance=3DOsd.opLatency
> >> type_instance=3DOsd.opPrepareLatency
> >> type_instance=3DOsd.opProcessLatency
> >> type_instance=3DOsd.opRLatency
> >> type_instance=3DOsd.opRPrepareLatency
> >> type_instance=3DOsd.opRProcessLatency
> >> type_instance=3DOsd.opRwLatency
> >> type_instance=3DOsd.opRwPrepareLatency
> >> type_instance=3DOsd.opRwProcessLatency
> >> type_instance=3DOsd.opWLatency
> >> type_instance=3DOsd.opWPrepareLatency
> >> type_instance=3DOsd.opWProcessLatency
> >> type_instance=3DOsd.subopLatency
> >> type_instance=3DOsd.subopWLatency
> >> ...
> >> ...
> >>
> >>
> >>
> >>
> >>
> >> -----Original Message-----
> >> From: Alex Litvak [mailto:alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> >> Sent: zondag 29 september 2019 13:06
> >> To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> Subject: [ceph-users] Commit and Apply latency on nautilus
> >>
> >> Hello everyone,
> >>
> >> I am running a number of parallel benchmark tests against the cluster
> >> that should be ready to go to production.
> >> I enabled prometheus to monitor various information and while cluster
> >> stays healthy through the tests with no errors or slow requests,
> >> I noticed an apply / commit latency jumping between 40 - 600 ms on
> >> multiple SSDs.  At the same time op_read and op_write are on average
> >> below 0.25 ms in the worth case scenario.
> >>
> >> I am running nautilus 14.2.2, all bluestore, no separate NVME devices
> >> for WAL/DB, 6 SSDs per node(Dell PowerEdge R440) with all drives Seaga=
te
> >> Nytro 1551, osd spread across 6 nodes, running in
> >> containers.  Each node has plenty of RAM with utilization ~ 25 GB duri=
ng
> >> the benchmark runs.
> >>
> >> Here are benchmarks being run from 6 client systems in parallel,
> >> repeating the test for each block size in <4k,16k,128k,4M>.
> >>
> >> On rbd mapped partition local to each client:
> >>
> >> fio --name=3Drandrw --ioengine=3Dlibaio --iodepth=3D4 --rw=3Drandrw
> >> --bs=3D<4k,16k,128k,4M> --direct=3D1 --size=3D2G --numjobs=3D8 --runti=
me=3D300
> >> --group_reporting --time_based --rwmixread=3D70
> >>
> >> On mounted cephfs volume with each client storing test file(s) in own
> >> sub-directory:
> >>
> >> fio --name=3Drandrw --ioengine=3Dlibaio --iodepth=3D4 --rw=3Drandrw
> >> --bs=3D<4k,16k,128k,4M> --direct=3D1 --size=3D2G --numjobs=3D8 --runti=
me=3D300
> >> --group_reporting --time_based --rwmixread=3D70
> >>
> >> dbench -t 30 30
> >>
> >> Could you please let me know if huge jump in applied and committed
> >> latency is justified in my case and whether I can do anything to impro=
ve
> >> / fix it.  Below is some additional cluster info.
> >>
> >> Thank you,
> >>
> >> root@storage2n2-la:~# podman exec -it ceph-mon-storage2n2-la ceph osd
> df
> >> ID CLASS WEIGHT  REWEIGHT SIZE    RAW USE DATA    OMAP    META     AVA=
IL
> >>   %USE VAR  PGS STATUS
> >>   6   ssd 1.74609  1.00000 1.7 TiB  93 GiB  92 GiB 240 MiB  784 MiB 1.=
7
> >> TiB 5.21 0.90  44     up
> >> 12   ssd 1.74609  1.00000 1.7 TiB  98 GiB  97 GiB 118 MiB  906 MiB 1.7
> >> TiB 5.47 0.95  40     up
> >> 18   ssd 1.74609  1.00000 1.7 TiB 102 GiB 101 GiB 123 MiB  901 MiB 1.6
> >> TiB 5.73 0.99  47     up
> >> 24   ssd 3.49219  1.00000 3.5 TiB 222 GiB 221 GiB 134 MiB  890 MiB 3.3
> >> TiB 6.20 1.07  96     up
> >> 30   ssd 3.49219  1.00000 3.5 TiB 213 GiB 212 GiB 151 MiB  873 MiB 3.3
> >> TiB 5.95 1.03  93     up
> >> 35   ssd 3.49219  1.00000 3.5 TiB 203 GiB 202 GiB 301 MiB  723 MiB 3.3
> >> TiB 5.67 0.98 100     up
> >>   5   ssd 1.74609  1.00000 1.7 TiB 103 GiB 102 GiB 123 MiB  901 MiB 1.=
6
> >> TiB 5.78 1.00  49     up
> >> 11   ssd 1.74609  1.00000 1.7 TiB 109 GiB 108 GiB  63 MiB  961 MiB 1.6
> >> TiB 6.09 1.05  46     up
> >> 17   ssd 1.74609  1.00000 1.7 TiB 104 GiB 103 GiB 205 MiB  819 MiB 1.6
> >> TiB 5.81 1.01  50     up
> >> 23   ssd 3.49219  1.00000 3.5 TiB 210 GiB 209 GiB 168 MiB  856 MiB 3.3
> >> TiB 5.86 1.01  86     up
> >> 29   ssd 3.49219  1.00000 3.5 TiB 204 GiB 203 GiB 272 MiB  752 MiB 3.3
> >> TiB 5.69 0.98  92     up
> >> 34   ssd 3.49219  1.00000 3.5 TiB 198 GiB 197 GiB 295 MiB  729 MiB 3.3
> >> TiB 5.54 0.96  85     up
> >>   4   ssd 1.74609  1.00000 1.7 TiB 119 GiB 118 GiB  16 KiB 1024 MiB 1.=
6
> >> TiB 6.67 1.15  50     up
> >> 10   ssd 1.74609  1.00000 1.7 TiB  95 GiB  94 GiB 183 MiB  841 MiB 1.7
> >> TiB 5.31 0.92  46     up
> >> 16   ssd 1.74609  1.00000 1.7 TiB 102 GiB 101 GiB 122 MiB  902 MiB 1.6
> >> TiB 5.72 0.99  50     up
> >> 22   ssd 3.49219  1.00000 3.5 TiB 218 GiB 217 GiB 109 MiB  915 MiB 3.3
> >> TiB 6.11 1.06  91     up
> >> 28   ssd 3.49219  1.00000 3.5 TiB 198 GiB 197 GiB 343 MiB  681 MiB 3.3
> >> TiB 5.54 0.96  95     up
> >> 33   ssd 3.49219  1.00000 3.5 TiB 198 GiB 196 GiB 297 MiB 1019 MiB 3.3
> >> TiB 5.53 0.96  85     up
> >>   1   ssd 1.74609  1.00000 1.7 TiB 101 GiB 100 GiB 222 MiB  802 MiB 1.=
6
> >> TiB 5.63 0.97  49     up
> >>   7   ssd 1.74609  1.00000 1.7 TiB 102 GiB 101 GiB 153 MiB  871 MiB 1.=
6
> >> TiB 5.69 0.99  46     up
> >> 13   ssd 1.74609  1.00000 1.7 TiB 106 GiB 105 GiB  67 MiB  957 MiB 1.6
> >> TiB 5.96 1.03  42     up
> >> 19   ssd 3.49219  1.00000 3.5 TiB 206 GiB 205 GiB 179 MiB  845 MiB 3.3
> >> TiB 5.77 1.00  83     up
> >> 25   ssd 3.49219  1.00000 3.5 TiB 195 GiB 194 GiB 352 MiB  672 MiB 3.3
> >> TiB 5.45 0.94  97     up
> >> 31   ssd 3.49219  1.00000 3.5 TiB 201 GiB 200 GiB 305 MiB  719 MiB 3.3
> >> TiB 5.62 0.97  90     up
> >>   0   ssd 1.74609  1.00000 1.7 TiB 110 GiB 109 GiB  29 MiB  995 MiB 1.=
6
> >> TiB 6.14 1.06  43     up
> >>   3   ssd 1.74609  1.00000 1.7 TiB 109 GiB 108 GiB  28 MiB  996 MiB 1.=
6
> >> TiB 6.07 1.05  41     up
> >>   9   ssd 1.74609  1.00000 1.7 TiB 103 GiB 102 GiB 149 MiB  875 MiB 1.=
6
> >> TiB 5.76 1.00  52     up
> >> 15   ssd 3.49219  1.00000 3.5 TiB 209 GiB 208 GiB 253 MiB  771 MiB 3.3
> >> TiB 5.83 1.01  98     up
> >> 21   ssd 3.49219  1.00000 3.5 TiB 199 GiB 198 GiB 302 MiB  722 MiB 3.3
> >> TiB 5.56 0.96  90     up
> >> 27   ssd 3.49219  1.00000 3.5 TiB 208 GiB 207 GiB 226 MiB  798 MiB 3.3
> >> TiB 5.81 1.00  95     up
> >>   2   ssd 1.74609  1.00000 1.7 TiB  96 GiB  95 GiB 158 MiB  866 MiB 1.=
7
> >> TiB 5.35 0.93  45     up
> >>   8   ssd 1.74609  1.00000 1.7 TiB 106 GiB 105 GiB 132 MiB  892 MiB 1.=
6
> >> TiB 5.91 1.02  50     up
> >> 14   ssd 1.74609  1.00000 1.7 TiB  96 GiB  95 GiB 180 MiB  844 MiB 1.7
> >> TiB 5.35 0.92  46     up
> >> 20   ssd 3.49219  1.00000 3.5 TiB 221 GiB 220 GiB 156 MiB  868 MiB 3.3
> >> TiB 6.18 1.07 101     up
> >> 26   ssd 3.49219  1.00000 3.5 TiB 206 GiB 205 GiB 332 MiB  692 MiB 3.3
> >> TiB 5.76 1.00  92     up
> >> 32   ssd 3.49219  1.00000 3.5 TiB 221 GiB 220 GiB  88 MiB  936 MiB 3.3
> >> TiB 6.18 1.07  91     up
> >>                      TOTAL  94 TiB 5.5 TiB 5.4 TiB 6.4 GiB   30 GiB  8=
9
> >> TiB 5.78
> >> MIN/MAX VAR: 0.90/1.15  STDDEV: 0.30
> >>
> >>
> >> root@storage2n2-la:~# podman exec -it ceph-mon-storage2n2-la ceph -s
> >>    cluster:
> >>      id:     9b4468b7-5bf2-4964-8aec-4b2f4bee87ad
> >>      health: HEALTH_OK
> >>
> >>    services:
> >>      mon: 3 daemons, quorum storage2n1-la,storage2n2-la,storage2n3-la
> >> (age 9w)
> >>      mgr: storage2n2-la(active, since 9w), standbys: storage2n1-la,
> >> storage2n3-la
> >>      mds: cephfs:1 {0=3Dstorage2n6-la=3Dup:active} 1 up:standby-replay=
 1
> >> up:standby
> >>      osd: 36 osds: 36 up (since 9w), 36 in (since 9w)
> >>
> >>    data:
> >>      pools:   3 pools, 832 pgs
> >>      objects: 4.18M objects, 1.8 TiB
> >>      usage:   5.5 TiB used, 89 TiB / 94 TiB avail
> >>      pgs:     832 active+clean
> >>
> >>    io:
> >>      client:   852 B/s rd, 15 KiB/s wr, 4 op/s rd, 2 op/s wr
> >>
> >>
> >>
> >>
> >>
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>
> >>
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--000000000000026f260593ce36cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">At this point, I ran out of ideas.=C2=A0 I changed nr_requ=
ests and readahead parameters to 128-&gt;1024 and 128-&gt;4096, tuned nodes=
 to performance-throughput.=C2=A0 However, I still get high latency during =
benchmark testing.=C2=A0 I attempted to disable cache on ssd=C2=A0<div><br>=
</div><div>for i in {a..f}; do hdparm -W 0 -A 0 /dev/sd$i; done=C2=A0</div>=
<div><br></div><div>and I think it make things not better at all.=C2=A0 I h=
ave H740 and H730 controllers with drives in HBA mode.=C2=A0=C2=A0<br></div=
><div><br></div><div>Other them converting them one=C2=A0by one to RAID0 I =
am not sure what else I can try.=C2=A0</div><div><br></div><div>Any=C2=A0su=
ggestions?</div><div><br></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Mon, Sep 30, 2019 at 2:45 PM Paul Emmeric=
h &lt;<a href=3D"mailto:paul.emmerich-iZXOWb+A65A@public.gmane.org">paul.emmerich-iZXOWb+A65A@public.gmane.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">BTW: =
commit and apply latency are the exact same thing since<br>
BlueStore, so don&#39;t bother looking at both.<br>
<br>
In fact you should mostly be looking at the op_*_latency counters<br>
<br>
<br>
Paul<br>
<br>
-- <br>
Paul Emmerich<br>
<br>
Looking for help with your Ceph cluster? Contact us at <a href=3D"https://c=
roit.io" rel=3D"noreferrer" target=3D"_blank">https://croit.io</a><br>
<br>
croit GmbH<br>
Freseniusstr. 31h<br>
81247 M=C3=BCnchen<br>
<a href=3D"http://www.croit.io" rel=3D"noreferrer" target=3D"_blank">www.cr=
oit.io</a><br>
Tel: +49 89 1896585 90<br>
<br>
On Mon, Sep 30, 2019 at 8:46 PM Sasha Litvak<br>
&lt;<a href=3D"mailto:alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexa=
nder.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; In my case, I am using premade Prometheus sourced dashboards in grafan=
a.<br>
&gt;<br>
&gt; For individual latency, the query looks like that<br>
&gt;<br>
&gt;=C2=A0 irate(ceph_osd_op_r_latency_sum{ceph_daemon=3D~&quot;$osd&quot;}=
[1m]) / on (ceph_daemon) irate(ceph_osd_op_r_latency_count[1m])<br>
&gt; irate(ceph_osd_op_w_latency_sum{ceph_daemon=3D~&quot;$osd&quot;}[1m]) =
/ on (ceph_daemon) irate(ceph_osd_op_w_latency_count[1m])<br>
&gt;<br>
&gt; The other ones use<br>
&gt;<br>
&gt; ceph_osd_commit_latency_ms<br>
&gt; ceph_osd_apply_latency_ms<br>
&gt;<br>
&gt; and graph the distribution of it over time<br>
&gt;<br>
&gt; Also, average OSD op latency<br>
&gt;<br>
&gt; avg(rate(ceph_osd_op_r_latency_sum{cluster=3D&quot;$cluster&quot;}[5m]=
) / rate(ceph_osd_op_r_latency_count{cluster=3D&quot;$cluster&quot;}[5m]) &=
gt;=3D 0)<br>
&gt; avg(rate(ceph_osd_op_w_latency_sum{cluster=3D&quot;$cluster&quot;}[5m]=
) / rate(ceph_osd_op_w_latency_count{cluster=3D&quot;$cluster&quot;}[5m]) &=
gt;=3D 0)<br>
&gt;<br>
&gt; Average OSD apply + commit latency<br>
&gt; avg(ceph_osd_apply_latency_ms{cluster=3D&quot;$cluster&quot;})<br>
&gt; avg(ceph_osd_commit_latency_ms{cluster=3D&quot;$cluster&quot;})<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Sep 30, 2019 at 11:13 AM Marc Roos &lt;<a href=3D"mailto:M.Roo=
s@f1-outsourcing.eu" target=3D"_blank">M.Roos-yG4tGvGIC004hcxptnrGZodd74u8MsAO@public.gmane.org</a>&gt; wro=
te:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; What parameters are you exactly using? I want to do a similar test=
 on<br>
&gt;&gt; luminous, before I upgrade to Nautilus. I have quite a lot (74+)<b=
r>
&gt;&gt;<br>
&gt;&gt; type_instance=3DOsd.opBeforeDequeueOpLat<br>
&gt;&gt; type_instance=3DOsd.opBeforeQueueOpLat<br>
&gt;&gt; type_instance=3DOsd.opLatency<br>
&gt;&gt; type_instance=3DOsd.opPrepareLatency<br>
&gt;&gt; type_instance=3DOsd.opProcessLatency<br>
&gt;&gt; type_instance=3DOsd.opRLatency<br>
&gt;&gt; type_instance=3DOsd.opRPrepareLatency<br>
&gt;&gt; type_instance=3DOsd.opRProcessLatency<br>
&gt;&gt; type_instance=3DOsd.opRwLatency<br>
&gt;&gt; type_instance=3DOsd.opRwPrepareLatency<br>
&gt;&gt; type_instance=3DOsd.opRwProcessLatency<br>
&gt;&gt; type_instance=3DOsd.opWLatency<br>
&gt;&gt; type_instance=3DOsd.opWPrepareLatency<br>
&gt;&gt; type_instance=3DOsd.opWProcessLatency<br>
&gt;&gt; type_instance=3DOsd.subopLatency<br>
&gt;&gt; type_instance=3DOsd.subopWLatency<br>
&gt;&gt; ...<br>
&gt;&gt; ...<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Alex Litvak [mailto:<a href=3D"mailto:alexander.v.litvak@gma=
il.com" target=3D"_blank">alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
&gt;&gt; Sent: zondag 29 september 2019 13:06<br>
&gt;&gt; To: <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank"=
>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt;&gt; Cc: <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" target=3D"_blank=
">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt;&gt; Subject: [ceph-users] Commit and Apply latency on nautilus<br>
&gt;&gt;<br>
&gt;&gt; Hello everyone,<br>
&gt;&gt;<br>
&gt;&gt; I am running a number of parallel benchmark tests against the clus=
ter<br>
&gt;&gt; that should be ready to go to production.<br>
&gt;&gt; I enabled prometheus to monitor various information and while clus=
ter<br>
&gt;&gt; stays healthy through the tests with no errors or slow requests,<b=
r>
&gt;&gt; I noticed an apply / commit latency jumping between 40 - 600 ms on=
<br>
&gt;&gt; multiple SSDs.=C2=A0 At the same time op_read and op_write are on =
average<br>
&gt;&gt; below 0.25 ms in the worth case scenario.<br>
&gt;&gt;<br>
&gt;&gt; I am running nautilus 14.2.2, all bluestore, no separate NVME devi=
ces<br>
&gt;&gt; for WAL/DB, 6 SSDs per node(Dell PowerEdge R440) with all drives S=
eagate<br>
&gt;&gt; Nytro 1551, osd spread across 6 nodes, running in<br>
&gt;&gt; containers.=C2=A0 Each node has plenty of RAM with utilization ~ 2=
5 GB during<br>
&gt;&gt; the benchmark runs.<br>
&gt;&gt;<br>
&gt;&gt; Here are benchmarks being run from 6 client systems in parallel,<b=
r>
&gt;&gt; repeating the test for each block size in &lt;4k,16k,128k,4M&gt;.<=
br>
&gt;&gt;<br>
&gt;&gt; On rbd mapped partition local to each client:<br>
&gt;&gt;<br>
&gt;&gt; fio --name=3Drandrw --ioengine=3Dlibaio --iodepth=3D4 --rw=3Drandr=
w<br>
&gt;&gt; --bs=3D&lt;4k,16k,128k,4M&gt; --direct=3D1 --size=3D2G --numjobs=
=3D8 --runtime=3D300<br>
&gt;&gt; --group_reporting --time_based --rwmixread=3D70<br>
&gt;&gt;<br>
&gt;&gt; On mounted cephfs volume with each client storing test file(s) in =
own<br>
&gt;&gt; sub-directory:<br>
&gt;&gt;<br>
&gt;&gt; fio --name=3Drandrw --ioengine=3Dlibaio --iodepth=3D4 --rw=3Drandr=
w<br>
&gt;&gt; --bs=3D&lt;4k,16k,128k,4M&gt; --direct=3D1 --size=3D2G --numjobs=
=3D8 --runtime=3D300<br>
&gt;&gt; --group_reporting --time_based --rwmixread=3D70<br>
&gt;&gt;<br>
&gt;&gt; dbench -t 30 30<br>
&gt;&gt;<br>
&gt;&gt; Could you please let me know if huge jump in applied and committed=
<br>
&gt;&gt; latency is justified in my case and whether I can do anything to i=
mprove<br>
&gt;&gt; / fix it.=C2=A0 Below is some additional cluster info.<br>
&gt;&gt;<br>
&gt;&gt; Thank you,<br>
&gt;&gt;<br>
&gt;&gt; root@storage2n2-la:~# podman exec -it ceph-mon-storage2n2-la ceph =
osd df<br>
&gt;&gt; ID CLASS WEIGHT=C2=A0 REWEIGHT SIZE=C2=A0 =C2=A0 RAW USE DATA=C2=
=A0 =C2=A0 OMAP=C2=A0 =C2=A0 META=C2=A0 =C2=A0 =C2=A0AVAIL<br>
&gt;&gt;=C2=A0 =C2=A0%USE VAR=C2=A0 PGS STATUS<br>
&gt;&gt;=C2=A0 =C2=A06=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB=C2=A0 =
93 GiB=C2=A0 92 GiB 240 MiB=C2=A0 784 MiB 1.7<br>
&gt;&gt; TiB 5.21 0.90=C2=A0 44=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 12=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB=C2=A0 98 GiB=C2=
=A0 97 GiB 118 MiB=C2=A0 906 MiB 1.7<br>
&gt;&gt; TiB 5.47 0.95=C2=A0 40=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 18=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 102 GiB 101 GiB 1=
23 MiB=C2=A0 901 MiB 1.6<br>
&gt;&gt; TiB 5.73 0.99=C2=A0 47=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 24=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 222 GiB 221 GiB 1=
34 MiB=C2=A0 890 MiB 3.3<br>
&gt;&gt; TiB 6.20 1.07=C2=A0 96=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 30=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 213 GiB 212 GiB 1=
51 MiB=C2=A0 873 MiB 3.3<br>
&gt;&gt; TiB 5.95 1.03=C2=A0 93=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 35=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 203 GiB 202 GiB 3=
01 MiB=C2=A0 723 MiB 3.3<br>
&gt;&gt; TiB 5.67 0.98 100=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt;=C2=A0 =C2=A05=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 103 Gi=
B 102 GiB 123 MiB=C2=A0 901 MiB 1.6<br>
&gt;&gt; TiB 5.78 1.00=C2=A0 49=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 11=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 109 GiB 108 GiB=
=C2=A0 63 MiB=C2=A0 961 MiB 1.6<br>
&gt;&gt; TiB 6.09 1.05=C2=A0 46=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 17=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 104 GiB 103 GiB 2=
05 MiB=C2=A0 819 MiB 1.6<br>
&gt;&gt; TiB 5.81 1.01=C2=A0 50=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 23=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 210 GiB 209 GiB 1=
68 MiB=C2=A0 856 MiB 3.3<br>
&gt;&gt; TiB 5.86 1.01=C2=A0 86=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 29=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 204 GiB 203 GiB 2=
72 MiB=C2=A0 752 MiB 3.3<br>
&gt;&gt; TiB 5.69 0.98=C2=A0 92=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 34=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 198 GiB 197 GiB 2=
95 MiB=C2=A0 729 MiB 3.3<br>
&gt;&gt; TiB 5.54 0.96=C2=A0 85=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt;=C2=A0 =C2=A04=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 119 Gi=
B 118 GiB=C2=A0 16 KiB 1024 MiB 1.6<br>
&gt;&gt; TiB 6.67 1.15=C2=A0 50=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 10=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB=C2=A0 95 GiB=C2=
=A0 94 GiB 183 MiB=C2=A0 841 MiB 1.7<br>
&gt;&gt; TiB 5.31 0.92=C2=A0 46=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 16=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 102 GiB 101 GiB 1=
22 MiB=C2=A0 902 MiB 1.6<br>
&gt;&gt; TiB 5.72 0.99=C2=A0 50=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 22=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 218 GiB 217 GiB 1=
09 MiB=C2=A0 915 MiB 3.3<br>
&gt;&gt; TiB 6.11 1.06=C2=A0 91=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 28=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 198 GiB 197 GiB 3=
43 MiB=C2=A0 681 MiB 3.3<br>
&gt;&gt; TiB 5.54 0.96=C2=A0 95=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 33=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 198 GiB 196 GiB 2=
97 MiB 1019 MiB 3.3<br>
&gt;&gt; TiB 5.53 0.96=C2=A0 85=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt;=C2=A0 =C2=A01=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 101 Gi=
B 100 GiB 222 MiB=C2=A0 802 MiB 1.6<br>
&gt;&gt; TiB 5.63 0.97=C2=A0 49=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt;=C2=A0 =C2=A07=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 102 Gi=
B 101 GiB 153 MiB=C2=A0 871 MiB 1.6<br>
&gt;&gt; TiB 5.69 0.99=C2=A0 46=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 13=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 106 GiB 105 GiB=
=C2=A0 67 MiB=C2=A0 957 MiB 1.6<br>
&gt;&gt; TiB 5.96 1.03=C2=A0 42=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 19=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 206 GiB 205 GiB 1=
79 MiB=C2=A0 845 MiB 3.3<br>
&gt;&gt; TiB 5.77 1.00=C2=A0 83=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 25=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 195 GiB 194 GiB 3=
52 MiB=C2=A0 672 MiB 3.3<br>
&gt;&gt; TiB 5.45 0.94=C2=A0 97=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 31=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 201 GiB 200 GiB 3=
05 MiB=C2=A0 719 MiB 3.3<br>
&gt;&gt; TiB 5.62 0.97=C2=A0 90=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt;=C2=A0 =C2=A00=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 110 Gi=
B 109 GiB=C2=A0 29 MiB=C2=A0 995 MiB 1.6<br>
&gt;&gt; TiB 6.14 1.06=C2=A0 43=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt;=C2=A0 =C2=A03=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 109 Gi=
B 108 GiB=C2=A0 28 MiB=C2=A0 996 MiB 1.6<br>
&gt;&gt; TiB 6.07 1.05=C2=A0 41=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt;=C2=A0 =C2=A09=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 103 Gi=
B 102 GiB 149 MiB=C2=A0 875 MiB 1.6<br>
&gt;&gt; TiB 5.76 1.00=C2=A0 52=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 15=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 209 GiB 208 GiB 2=
53 MiB=C2=A0 771 MiB 3.3<br>
&gt;&gt; TiB 5.83 1.01=C2=A0 98=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 21=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 199 GiB 198 GiB 3=
02 MiB=C2=A0 722 MiB 3.3<br>
&gt;&gt; TiB 5.56 0.96=C2=A0 90=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 27=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 208 GiB 207 GiB 2=
26 MiB=C2=A0 798 MiB 3.3<br>
&gt;&gt; TiB 5.81 1.00=C2=A0 95=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt;=C2=A0 =C2=A02=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB=C2=A0 =
96 GiB=C2=A0 95 GiB 158 MiB=C2=A0 866 MiB 1.7<br>
&gt;&gt; TiB 5.35 0.93=C2=A0 45=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt;=C2=A0 =C2=A08=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB 106 Gi=
B 105 GiB 132 MiB=C2=A0 892 MiB 1.6<br>
&gt;&gt; TiB 5.91 1.02=C2=A0 50=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 14=C2=A0 =C2=A0ssd 1.74609=C2=A0 1.00000 1.7 TiB=C2=A0 96 GiB=C2=
=A0 95 GiB 180 MiB=C2=A0 844 MiB 1.7<br>
&gt;&gt; TiB 5.35 0.92=C2=A0 46=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 20=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 221 GiB 220 GiB 1=
56 MiB=C2=A0 868 MiB 3.3<br>
&gt;&gt; TiB 6.18 1.07 101=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 26=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 206 GiB 205 GiB 3=
32 MiB=C2=A0 692 MiB 3.3<br>
&gt;&gt; TiB 5.76 1.00=C2=A0 92=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt; 32=C2=A0 =C2=A0ssd 3.49219=C2=A0 1.00000 3.5 TiB 221 GiB 220 GiB=
=C2=A0 88 MiB=C2=A0 936 MiB 3.3<br>
&gt;&gt; TiB 6.18 1.07=C2=A0 91=C2=A0 =C2=A0 =C2=A0up<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 TOTAL=C2=A0 94 TiB 5.5 TiB 5.4 TiB 6.4 GiB=C2=A0 =C2=A030 GiB=C2=
=A0 89<br>
&gt;&gt; TiB 5.78<br>
&gt;&gt; MIN/MAX VAR: 0.90/1.15=C2=A0 STDDEV: 0.30<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; root@storage2n2-la:~# podman exec -it ceph-mon-storage2n2-la ceph =
-s<br>
&gt;&gt;=C2=A0 =C2=A0 cluster:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 id:=C2=A0 =C2=A0 =C2=A09b4468b7-5bf2-4964-8aec=
-4b2f4bee87ad<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 health: HEALTH_OK<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 services:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 mon: 3 daemons, quorum storage2n1-la,storage2n=
2-la,storage2n3-la<br>
&gt;&gt; (age 9w)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 mgr: storage2n2-la(active, since 9w), standbys=
: storage2n1-la,<br>
&gt;&gt; storage2n3-la<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 mds: cephfs:1 {0=3Dstorage2n6-la=3Dup:active} =
1 up:standby-replay 1<br>
&gt;&gt; up:standby<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 osd: 36 osds: 36 up (since 9w), 36 in (since 9=
w)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 data:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 pools:=C2=A0 =C2=A03 pools, 832 pgs<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 objects: 4.18M objects, 1.8 TiB<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 usage:=C2=A0 =C2=A05.5 TiB used, 89 TiB / 94 T=
iB avail<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 pgs:=C2=A0 =C2=A0 =C2=A0832 active+clean<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 io:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 client:=C2=A0 =C2=A0852 B/s rd, 15 KiB/s wr, 4=
 op/s rd, 2 op/s wr<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; ceph-users mailing list<br>
&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">cep=
h-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com"=
 rel=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ce=
ph-users-ceph.com</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com</a><br>
</blockquote></div>

--000000000000026f260593ce36cc--

--===============1070667957301137754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1070667957301137754==--
