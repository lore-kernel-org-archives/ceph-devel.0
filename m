From: Milosz Tanski <milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org>
Subject: Re: strange benchmark problem : restarting osd daemon
 improve performance from 100k iops to 300k iops
Date: Wed, 22 Apr 2015 06:54:23 -0400
Message-ID: <CANP1eJGFQH3jqh7b0GP9YYMtWQp3-EiSurRvzKVUU+W7Ty-acg@mail.gmail.com>
References: <1232683114.515741917.1429692005478.JavaMail.zimbra@oxygem.tv>
	<990277439.516588145.1429693262093.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1436492606=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <990277439.516588145.1429693262093.JavaMail.zimbra-M8QNeUgB6UTyG1zEObXtfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1436492606==
Content-Type: multipart/alternative; boundary=001a11c351de6fbd5805144dfcc0

--001a11c351de6fbd5805144dfcc0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 5:01 AM, Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
wrote:

> I wonder if it could be numa related,
>
> I'm using centos 7.1,
> and auto numa balacning is enabled
>
> cat /proc/sys/kernel/numa_balancing   =3D 1
>
> Maybe osd daemon access to buffer on wrong numa node.
>
> I'll try to reproduce the problem
>

Can you force the degenerate case using numactl? To either affirm or deny
your suspicion.


>
>
> ----- Mail original -----
> De: "aderumier" <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org>
> =C3=80: "ceph-devel" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users" <
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
> Envoy=C3=A9: Mercredi 22 Avril 2015 10:40:05
> Objet: [ceph-users] strange benchmark problem : restarting osd daemon
> improve performance from 100k iops to 300k iops
>
> Hi,
>
> I was doing some benchmarks,
> I have found an strange behaviour.
>
> Using fio with rbd engine, I was able to reach around 100k iops.
> (osd datas in linux buffer, iostat show 0% disk access)
>
> then after restarting all osd daemons,
>
> the same fio benchmark show now around 300k iops.
> (osd datas in linux buffer, iostat show 0% disk access)
>
>
> any ideas?
>
>
>
>
> before restarting osd
> ---------------------
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Drbd, iodepth=3D32
> ...
> fio-2.2.7-10-g51e9
> Starting 10 processes
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> ^Cbs: 10 (f=3D10): [r(10)] [2.9% done] [376.1MB/0KB/0KB /s] [96.6K/0/0 io=
ps]
> [eta 14m:45s]
> fio: terminating on signal 2
>
> rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D17075: Wed =
Apr 22
> 10:00:04 2015
> read : io=3D11558MB, bw=3D451487KB/s, iops=3D112871, runt=3D 26215msec
> slat (usec): min=3D5, max=3D3685, avg=3D16.89, stdev=3D17.38
> clat (usec): min=3D5, max=3D62584, avg=3D2695.80, stdev=3D5351.23
> lat (usec): min=3D109, max=3D62598, avg=3D2712.68, stdev=3D5350.42
> clat percentiles (usec):
> | 1.00th=3D[ 155], 5.00th=3D[ 183], 10.00th=3D[ 205], 20.00th=3D[ 247],
> | 30.00th=3D[ 294], 40.00th=3D[ 354], 50.00th=3D[ 446], 60.00th=3D[ 660],
> | 70.00th=3D[ 1176], 80.00th=3D[ 3152], 90.00th=3D[ 9024], 95.00th=3D[146=
56],
> | 99.00th=3D[25984], 99.50th=3D[30336], 99.90th=3D[38656], 99.95th=3D[417=
28],
> | 99.99th=3D[47360]
> bw (KB /s): min=3D23928, max=3D154416, per=3D10.07%, avg=3D45462.82, stde=
v=3D28809.95
> lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=3D0.01%, 250=3D20.79=
%
> lat (usec) : 500=3D32.74%, 750=3D8.99%, 1000=3D5.03%
> lat (msec) : 2=3D8.37%, 4=3D6.21%, 10=3D8.90%, 20=3D6.60%, 50=3D2.37%
> lat (msec) : 100=3D0.01%
> cpu : usr=3D15.90%, sys=3D3.01%, ctx=3D765446, majf=3D0, minf=3D8710
> IO depths : 1=3D0.4%, 2=3D0.9%, 4=3D2.3%, 8=3D7.4%, 16=3D75.5%, 32=3D13.6=
%, >=3D64=3D0.0%
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,=
 >=3D64=3D0.0%
> complete : 0=3D0.0%, 4=3D93.6%, 8=3D2.8%, 16=3D2.4%, 32=3D1.2%, 64=3D0.0%=
, >=3D64=3D0.0%
> issued : total=3Dr=3D2958935/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, drop=
=3Dr=3D0/w=3D0/d=3D0
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
> READ: io=3D11558MB, aggrb=3D451487KB/s, minb=3D451487KB/s, maxb=3D451487K=
B/s,
> mint=3D26215msec, maxt=3D26215msec
>
> Disk stats (read/write):
> sdg: ios=3D0/29, merge=3D0/16, ticks=3D0/3, in_queue=3D3, util=3D0.01%
> [root@ceph1-3 fiorbd]# ./fio fiorbd
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Drbd, iodepth=3D32
>
>
>
>
> AFTER RESTARTING OSDS
> ----------------------
> [root@ceph1-3 fiorbd]# ./fio fiorbd
> rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K,
> ioengine=3Drbd, iodepth=3D32
> ...
> fio-2.2.7-10-g51e9
> Starting 10 processes
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> rbd engine: RBD version: 0.1.9
> ^Cbs: 10 (f=3D10): [r(10)] [0.2% done] [1155MB/0KB/0KB /s] [296K/0/0 iops=
]
> [eta 01h:09m:27s]
> fio: terminating on signal 2
>
> rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D18252: Wed =
Apr 22
> 10:02:28 2015
> read : io=3D7655.7MB, bw=3D1036.8MB/s, iops=3D265218, runt=3D 7389msec
> slat (usec): min=3D5, max=3D3406, avg=3D26.59, stdev=3D40.35
> clat (usec): min=3D8, max=3D684328, avg=3D930.43, stdev=3D6419.12
> lat (usec): min=3D154, max=3D684342, avg=3D957.02, stdev=3D6419.28
> clat percentiles (usec):
> | 1.00th=3D[ 243], 5.00th=3D[ 314], 10.00th=3D[ 366], 20.00th=3D[ 450],
> | 30.00th=3D[ 524], 40.00th=3D[ 604], 50.00th=3D[ 692], 60.00th=3D[ 796],
> | 70.00th=3D[ 924], 80.00th=3D[ 1096], 90.00th=3D[ 1400], 95.00th=3D[ 172=
0],
> | 99.00th=3D[ 2672], 99.50th=3D[ 3248], 99.90th=3D[ 5920], 99.95th=3D[ 97=
92],
> | 99.99th=3D[436224]
> bw (KB /s): min=3D32614, max=3D143160, per=3D10.19%, avg=3D108076.46,
> stdev=3D28263.82
> lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=3D0.01%, 250=3D1.23%
> lat (usec) : 500=3D25.64%, 750=3D29.15%, 1000=3D18.84%
> lat (msec) : 2=3D22.19%, 4=3D2.69%, 10=3D0.21%, 20=3D0.02%, 50=3D0.01%
> lat (msec) : 250=3D0.01%, 500=3D0.02%, 750=3D0.01%
> cpu : usr=3D44.06%, sys=3D11.26%, ctx=3D642620, majf=3D0, minf=3D6832
> IO depths : 1=3D0.1%, 2=3D0.5%, 4=3D2.0%, 8=3D11.5%, 16=3D77.8%, 32=3D8.1=
%, >=3D64=3D0.0%
> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%,=
 >=3D64=3D0.0%
> complete : 0=3D0.0%, 4=3D94.1%, 8=3D1.3%, 16=3D2.3%, 32=3D2.3%, 64=3D0.0%=
, >=3D64=3D0.0%
> issued : total=3Dr=3D1959697/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, drop=
=3Dr=3D0/w=3D0/d=3D0
> latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32
>
> Run status group 0 (all jobs):
> READ: io=3D7655.7MB, aggrb=3D1036.8MB/s, minb=3D1036.8MB/s, maxb=3D1036.8=
MB/s,
> mint=3D7389msec, maxt=3D7389msec
>
> Disk stats (read/write):
> sdg: ios=3D0/21, merge=3D0/10, ticks=3D0/2, in_queue=3D2, util=3D0.03%
>
>
>
>
> CEPH LOG
> --------
>
> before restarting osd
> ----------------------
>
> 2015-04-22 09:53:17.568095 mon.0 10.7.0.152:6789/0 2144 : cluster [INF]
> pgmap v11330: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 298
> MB/s rd, 76465 op/s
> 2015-04-22 09:53:18.574524 mon.0 10.7.0.152:6789/0 2145 : cluster [INF]
> pgmap v11331: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 333
> MB/s rd, 85355 op/s
> 2015-04-22 09:53:19.579351 mon.0 10.7.0.152:6789/0 2146 : cluster [INF]
> pgmap v11332: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 343
> MB/s rd, 87932 op/s
> 2015-04-22 09:53:20.591586 mon.0 10.7.0.152:6789/0 2147 : cluster [INF]
> pgmap v11333: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 328
> MB/s rd, 84151 op/s
> 2015-04-22 09:53:21.600650 mon.0 10.7.0.152:6789/0 2148 : cluster [INF]
> pgmap v11334: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 237
> MB/s rd, 60855 op/s
> 2015-04-22 09:53:22.607966 mon.0 10.7.0.152:6789/0 2149 : cluster [INF]
> pgmap v11335: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 144
> MB/s rd, 36935 op/s
> 2015-04-22 09:53:23.617780 mon.0 10.7.0.152:6789/0 2150 : cluster [INF]
> pgmap v11336: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 321
> MB/s rd, 82334 op/s
> 2015-04-22 09:53:24.622341 mon.0 10.7.0.152:6789/0 2151 : cluster [INF]
> pgmap v11337: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 368
> MB/s rd, 94211 op/s
> 2015-04-22 09:53:25.628432 mon.0 10.7.0.152:6789/0 2152 : cluster [INF]
> pgmap v11338: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 244
> MB/s rd, 62644 op/s
> 2015-04-22 09:53:26.632855 mon.0 10.7.0.152:6789/0 2153 : cluster [INF]
> pgmap v11339: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 175
> MB/s rd, 44997 op/s
> 2015-04-22 09:53:27.636573 mon.0 10.7.0.152:6789/0 2154 : cluster [INF]
> pgmap v11340: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 122
> MB/s rd, 31259 op/s
> 2015-04-22 09:53:28.645784 mon.0 10.7.0.152:6789/0 2155 : cluster [INF]
> pgmap v11341: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 229
> MB/s rd, 58674 op/s
> 2015-04-22 09:53:29.657128 mon.0 10.7.0.152:6789/0 2156 : cluster [INF]
> pgmap v11342: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 271
> MB/s rd, 69501 op/s
> 2015-04-22 09:53:30.662796 mon.0 10.7.0.152:6789/0 2157 : cluster [INF]
> pgmap v11343: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 211
> MB/s rd, 54020 op/s
> 2015-04-22 09:53:31.666421 mon.0 10.7.0.152:6789/0 2158 : cluster [INF]
> pgmap v11344: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 164
> MB/s rd, 42001 op/s
> 2015-04-22 09:53:32.670842 mon.0 10.7.0.152:6789/0 2159 : cluster [INF]
> pgmap v11345: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 134
> MB/s rd, 34380 op/s
> 2015-04-22 09:53:33.681357 mon.0 10.7.0.152:6789/0 2160 : cluster [INF]
> pgmap v11346: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 293
> MB/s rd, 75213 op/s
> 2015-04-22 09:53:34.692177 mon.0 10.7.0.152:6789/0 2161 : cluster [INF]
> pgmap v11347: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 337
> MB/s rd, 86353 op/s
> 2015-04-22 09:53:35.697401 mon.0 10.7.0.152:6789/0 2162 : cluster [INF]
> pgmap v11348: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 229
> MB/s rd, 58839 op/s
> 2015-04-22 09:53:36.699309 mon.0 10.7.0.152:6789/0 2163 : cluster [INF]
> pgmap v11349: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 390 GB data, 391 GB used, 904 GB / 1295 GB avail; 152
> MB/s rd, 39117 op/s
>
>
> restarting osd
> ---------------
>
> 2015-04-22 10:00:09.766906 mon.0 10.7.0.152:6789/0 2255 : cluster [INF]
> osd.0 marked itself down
> 2015-04-22 10:00:09.790212 mon.0 10.7.0.152:6789/0 2256 : cluster [INF]
> osdmap e849: 9 osds: 8 up, 9 in
> 2015-04-22 10:00:09.793050 mon.0 10.7.0.152:6789/0 2257 : cluster [INF]
> pgmap v11439: 964 pgs: 2 active+undersized+degraded, 8
> stale+active+remapped, 106 stale+active+clean, 54 active+remapped, 794
> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail; 516 kB/s
> rd, 130 op/s
> 2015-04-22 10:00:10.795966 mon.0 10.7.0.152:6789/0 2258 : cluster [INF]
> osdmap e850: 9 osds: 8 up, 9 in
> 2015-04-22 10:00:10.796675 mon.0 10.7.0.152:6789/0 2259 : cluster [INF]
> pgmap v11440: 964 pgs: 2 active+undersized+degraded, 8
> stale+active+remapped, 106 stale+active+clean, 54 active+remapped, 794
> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
> 2015-04-22 10:00:11.798257 mon.0 10.7.0.152:6789/0 2260 : cluster [INF]
> pgmap v11441: 964 pgs: 2 active+undersized+degraded, 8
> stale+active+remapped, 106 stale+active+clean, 54 active+remapped, 794
> active+clean; 419 GB data, 420 GB used, 874 GB / 1295 GB avail
> 2015-04-22 10:00:12.339696 mon.0 10.7.0.152:6789/0 2262 : cluster [INF]
> osd.1 marked itself down
> 2015-04-22 10:00:12.800168 mon.0 10.7.0.152:6789/0 2263 : cluster [INF]
> osdmap e851: 9 osds: 7 up, 9 in
> 2015-04-22 10:00:12.806498 mon.0 10.7.0.152:6789/0 2264 : cluster [INF]
> pgmap v11443: 964 pgs: 1 active+undersized+degraded, 13
> stale+active+remapped, 216 stale+active+clean, 49 active+remapped, 684
> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB use=
d,
> 874 GB / 1295 GB avail
> 2015-04-22 10:00:13.804186 mon.0 10.7.0.152:6789/0 2265 : cluster [INF]
> osdmap e852: 9 osds: 7 up, 9 in
> 2015-04-22 10:00:13.805216 mon.0 10.7.0.152:6789/0 2266 : cluster [INF]
> pgmap v11444: 964 pgs: 1 active+undersized+degraded, 13
> stale+active+remapped, 216 stale+active+clean, 49 active+remapped, 684
> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB use=
d,
> 874 GB / 1295 GB avail
> 2015-04-22 10:00:14.781785 mon.0 10.7.0.152:6789/0 2268 : cluster [INF]
> osd.2 marked itself down
> 2015-04-22 10:00:14.810571 mon.0 10.7.0.152:6789/0 2269 : cluster [INF]
> osdmap e853: 9 osds: 6 up, 9 in
> 2015-04-22 10:00:14.813871 mon.0 10.7.0.152:6789/0 2270 : cluster [INF]
> pgmap v11445: 964 pgs: 1 active+undersized+degraded, 22
> stale+active+remapped, 300 stale+active+clean, 40 active+remapped, 600
> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB use=
d,
> 874 GB / 1295 GB avail
> 2015-04-22 10:00:15.810333 mon.0 10.7.0.152:6789/0 2271 : cluster [INF]
> osdmap e854: 9 osds: 6 up, 9 in
> 2015-04-22 10:00:15.811425 mon.0 10.7.0.152:6789/0 2272 : cluster [INF]
> pgmap v11446: 964 pgs: 1 active+undersized+degraded, 22
> stale+active+remapped, 300 stale+active+clean, 40 active+remapped, 600
> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB use=
d,
> 874 GB / 1295 GB avail
> 2015-04-22 10:00:16.395105 mon.0 10.7.0.152:6789/0 2273 : cluster [INF]
> HEALTH_WARN; 2 pgs degraded; 323 pgs stale; 2 pgs stuck degraded; 64 pgs
> stuck unclean; 2 pgs stuck undersized; 2 pgs undersized; 3/9 in osds are
> down; clock skew detected on mon.ceph1-2
> 2015-04-22 10:00:16.814432 mon.0 10.7.0.152:6789/0 2274 : cluster [INF]
> osd.1 10.7.0.152:6800/14848 boot
> 2015-04-22 10:00:16.814938 mon.0 10.7.0.152:6789/0 2275 : cluster [INF]
> osdmap e855: 9 osds: 7 up, 9 in
> 2015-04-22 10:00:16.815942 mon.0 10.7.0.152:6789/0 2276 : cluster [INF]
> pgmap v11447: 964 pgs: 1 active+undersized+degraded, 22
> stale+active+remapped, 300 stale+active+clean, 40 active+remapped, 600
> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB use=
d,
> 874 GB / 1295 GB avail
> 2015-04-22 10:00:17.222281 mon.0 10.7.0.152:6789/0 2278 : cluster [INF]
> osd.3 marked itself down
> 2015-04-22 10:00:17.819371 mon.0 10.7.0.152:6789/0 2279 : cluster [INF]
> osdmap e856: 9 osds: 6 up, 9 in
> 2015-04-22 10:00:17.822041 mon.0 10.7.0.152:6789/0 2280 : cluster [INF]
> pgmap v11448: 964 pgs: 1 active+undersized+degraded, 25
> stale+active+remapped, 394 stale+active+clean, 37 active+remapped, 506
> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB use=
d,
> 874 GB / 1295 GB avail
> 2015-04-22 10:00:18.551068 mon.0 10.7.0.152:6789/0 2282 : cluster [INF]
> osd.6 marked itself down
> 2015-04-22 10:00:18.819387 mon.0 10.7.0.152:6789/0 2283 : cluster [INF]
> osd.2 10.7.0.152:6812/15410 boot
> 2015-04-22 10:00:18.821134 mon.0 10.7.0.152:6789/0 2284 : cluster [INF]
> osdmap e857: 9 osds: 6 up, 9 in
> 2015-04-22 10:00:18.824440 mon.0 10.7.0.152:6789/0 2285 : cluster [INF]
> pgmap v11449: 964 pgs: 1 active+undersized+degraded, 30
> stale+active+remapped, 502 stale+active+clean, 32 active+remapped, 398
> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB use=
d,
> 874 GB / 1295 GB avail
> 2015-04-22 10:00:19.820947 mon.0 10.7.0.152:6789/0 2287 : cluster [INF]
> osdmap e858: 9 osds: 6 up, 9 in
> 2015-04-22 10:00:19.821853 mon.0 10.7.0.152:6789/0 2288 : cluster [INF]
> pgmap v11450: 964 pgs: 1 active+undersized+degraded, 30
> stale+active+remapped, 502 stale+active+clean, 32 active+remapped, 398
> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB use=
d,
> 874 GB / 1295 GB avail
> 2015-04-22 10:00:20.828047 mon.0 10.7.0.152:6789/0 2290 : cluster [INF]
> osd.3 10.7.0.152:6816/15971 boot
> 2015-04-22 10:00:20.828431 mon.0 10.7.0.152:6789/0 2291 : cluster [INF]
> osdmap e859: 9 osds: 7 up, 9 in
> 2015-04-22 10:00:20.829126 mon.0 10.7.0.152:6789/0 2292 : cluster [INF]
> pgmap v11451: 964 pgs: 1 active+undersized+degraded, 30
> stale+active+remapped, 502 stale+active+clean, 32 active+remapped, 398
> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB use=
d,
> 874 GB / 1295 GB avail
> 2015-04-22 10:00:20.991343 mon.0 10.7.0.152:6789/0 2294 : cluster [INF]
> osd.7 marked itself down
> 2015-04-22 10:00:21.830389 mon.0 10.7.0.152:6789/0 2295 : cluster [INF]
> osd.0 10.7.0.152:6804/14481 boot
> 2015-04-22 10:00:21.832518 mon.0 10.7.0.152:6789/0 2296 : cluster [INF]
> osdmap e860: 9 osds: 7 up, 9 in
> 2015-04-22 10:00:21.836129 mon.0 10.7.0.152:6789/0 2297 : cluster [INF]
> pgmap v11452: 964 pgs: 1 active+undersized+degraded, 35
> stale+active+remapped, 608 stale+active+clean, 27 active+remapped, 292
> active+clean, 1 stale+active+undersized+degraded; 419 GB data, 420 GB use=
d,
> 874 GB / 1295 GB avail
> 2015-04-22 10:00:22.830456 mon.0 10.7.0.152:6789/0 2298 : cluster [INF]
> osd.6 10.7.0.153:6808/21955 boot
> 2015-04-22 10:00:22.832171 mon.0 10.7.0.152:6789/0 2299 : cluster [INF]
> osdmap e861: 9 osds: 8 up, 9 in
> 2015-04-22 10:00:22.836272 mon.0 10.7.0.152:6789/0 2300 : cluster [INF]
> pgmap v11453: 964 pgs: 3 active+undersized+degraded, 27
> stale+active+remapped, 498 stale+active+clean, 2 peering, 28
> active+remapped, 402 active+clean, 4 remapped+peering; 419 GB data, 420 G=
B
> used, 874 GB / 1295 GB avail
> 2015-04-22 10:00:23.420309 mon.0 10.7.0.152:6789/0 2302 : cluster [INF]
> osd.8 marked itself down
> 2015-04-22 10:00:23.833708 mon.0 10.7.0.152:6789/0 2303 : cluster [INF]
> osdmap e862: 9 osds: 7 up, 9 in
> 2015-04-22 10:00:23.836459 mon.0 10.7.0.152:6789/0 2304 : cluster [INF]
> pgmap v11454: 964 pgs: 3 active+undersized+degraded, 44
> stale+active+remapped, 587 stale+active+clean, 2 peering, 11
> active+remapped, 313 active+clean, 4 remapped+peering; 419 GB data, 420 G=
B
> used, 874 GB / 1295 GB avail
> 2015-04-22 10:00:24.832905 mon.0 10.7.0.152:6789/0 2305 : cluster [INF]
> osd.7 10.7.0.153:6804/22536 boot
> 2015-04-22 10:00:24.834381 mon.0 10.7.0.152:6789/0 2306 : cluster [INF]
> osdmap e863: 9 osds: 8 up, 9 in
> 2015-04-22 10:00:24.836977 mon.0 10.7.0.152:6789/0 2307 : cluster [INF]
> pgmap v11455: 964 pgs: 3 active+undersized+degraded, 31
> stale+active+remapped, 503 stale+active+clean, 4
> active+undersized+degraded+remapped, 5 peering, 13 active+remapped, 397
> active+clean, 8 remapped+peering; 419 GB data, 420 GB used, 874 GB / 1295
> GB avail
> 2015-04-22 10:00:25.834459 mon.0 10.7.0.152:6789/0 2309 : cluster [INF]
> osdmap e864: 9 osds: 8 up, 9 in
> 2015-04-22 10:00:25.835727 mon.0 10.7.0.152:6789/0 2310 : cluster [INF]
> pgmap v11456: 964 pgs: 3 active+undersized+degraded, 31
> stale+active+remapped, 503 stale+active+clean, 4
> active+undersized+degraded+remapped, 5 peering, 13 active
>
>
> AFTER OSD RESTART
> ------------------
>
>
> 2015-04-22 10:09:27.609052 mon.0 10.7.0.152:6789/0 2339 : cluster [INF]
> pgmap v11478: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 786
> MB/s rd, 196 kop/s
> 2015-04-22 10:09:28.618082 mon.0 10.7.0.152:6789/0 2340 : cluster [INF]
> pgmap v11479: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 1578
> MB/s rd, 394 kop/s
> 2015-04-22 10:09:30.629067 mon.0 10.7.0.152:6789/0 2341 : cluster [INF]
> pgmap v11480: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 932
> MB/s rd, 233 kop/s
> 2015-04-22 10:09:32.645890 mon.0 10.7.0.152:6789/0 2342 : cluster [INF]
> pgmap v11481: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 627
> MB/s rd, 156 kop/s
> 2015-04-22 10:09:33.652634 mon.0 10.7.0.152:6789/0 2343 : cluster [INF]
> pgmap v11482: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 1034
> MB/s rd, 258 kop/s
> 2015-04-22 10:09:35.655657 mon.0 10.7.0.152:6789/0 2344 : cluster [INF]
> pgmap v11483: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 529
> MB/s rd, 132 kop/s
> 2015-04-22 10:09:37.674332 mon.0 10.7.0.152:6789/0 2345 : cluster [INF]
> pgmap v11484: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 770
> MB/s rd, 192 kop/s
> 2015-04-22 10:09:38.679445 mon.0 10.7.0.152:6789/0 2346 : cluster [INF]
> pgmap v11485: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 1358
> MB/s rd, 339 kop/s
> 2015-04-22 10:09:40.690037 mon.0 10.7.0.152:6789/0 2347 : cluster [INF]
> pgmap v11486: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 649
> MB/s rd, 162 kop/s
> 2015-04-22 10:09:42.707164 mon.0 10.7.0.152:6789/0 2348 : cluster [INF]
> pgmap v11487: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 580
> MB/s rd, 145 kop/s
> 2015-04-22 10:09:43.713736 mon.0 10.7.0.152:6789/0 2349 : cluster [INF]
> pgmap v11488: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 962
> MB/s rd, 240 kop/s
> 2015-04-22 10:09:45.718658 mon.0 10.7.0.152:6789/0 2350 : cluster [INF]
> pgmap v11489: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 506
> MB/s rd, 126 kop/s
> 2015-04-22 10:09:47.737358 mon.0 10.7.0.152:6789/0 2351 : cluster [INF]
> pgmap v11490: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 774
> MB/s rd, 193 kop/s
> 2015-04-22 10:09:48.743338 mon.0 10.7.0.152:6789/0 2352 : cluster [INF]
> pgmap v11491: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 1363
> MB/s rd, 340 kop/s
> 2015-04-22 10:09:50.746685 mon.0 10.7.0.152:6789/0 2353 : cluster [INF]
> pgmap v11492: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 662
> MB/s rd, 165 kop/s
> 2015-04-22 10:09:52.762461 mon.0 10.7.0.152:6789/0 2354 : cluster [INF]
> pgmap v11493: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 593
> MB/s rd, 148 kop/s
> 2015-04-22 10:09:53.767729 mon.0 10.7.0.152:6789/0 2355 : cluster [INF]
> pgmap v11494: 964 pgs: 2 active+undersized+degraded, 62 active+remapped,
> 900 active+clean; 419 GB data, 421 GB used, 874 GB / 1295 GB avail; 938
> MB/s rd, 234 kop/s
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org

--001a11c351de6fbd5805144dfcc0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Apr 22, 2015 at 5:01 AM, Alexandre DERUMIER <span dir=3D"ltr">&=
lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org" target=3D"_blank">aderumier@odiso=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,=
204);border-left-style:solid;padding-left:1ex">I wonder if it could be numa=
 related,<br>
<br>
I&#39;m using centos 7.1,<br>
and auto numa balacning is enabled<br>
<br>
cat /proc/sys/kernel/numa_balancing=C2=A0 =C2=A0=3D 1<br>
<br>
Maybe osd daemon access to buffer on wrong numa node.<br>
<br>
I&#39;ll try to reproduce the problem<br></blockquote><div><br></div><div>C=
an you force the degenerate case using=C2=A0numactl? To either affirm or de=
ny your suspicion.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:r=
gb(204,204,204);border-left-style:solid;padding-left:1ex">
<br>
<br>
----- Mail original -----<br>
De: &quot;aderumier&quot; &lt;<a href=3D"mailto:aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org">aderum=
ier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
=C3=80: &quot;ceph-devel&quot; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org=
.org">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;, &quot;ceph-users&quot; &lt;<a hre=
f=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;<br=
>
Envoy=C3=A9: Mercredi 22 Avril 2015 10:40:05<br>
Objet: [ceph-users] strange benchmark problem : restarting osd daemon impro=
ve performance from 100k iops to 300k iops<br>
<div><div class=3D"h5"><br>
Hi,<br>
<br>
I was doing some benchmarks,<br>
I have found an strange behaviour.<br>
<br>
Using fio with rbd engine, I was able to reach around 100k iops.<br>
(osd datas in linux buffer, iostat show 0% disk access)<br>
<br>
then after restarting all osd daemons,<br>
<br>
the same fio benchmark show now around 300k iops.<br>
(osd datas in linux buffer, iostat show 0% disk access)<br>
<br>
<br>
any ideas?<br>
<br>
<br>
<br>
<br>
before restarting osd<br>
---------------------<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Drbd, iodepth=3D32<br>
...<br>
fio-2.2.7-10-g51e9<br>
Starting 10 processes<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
^Cbs: 10 (f=3D10): [r(10)] [2.9% done] [376.1MB/0KB/0KB /s] [96.6K/0/0 iops=
] [eta 14m:45s]<br>
fio: terminating on signal 2<br>
<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D17075: Wed Ap=
r 22 10:00:04 2015<br>
read : io=3D11558MB, bw=3D451487KB/s, iops=3D112871, runt=3D 26215msec<br>
slat (usec): min=3D5, max=3D3685, avg=3D16.89, stdev=3D17.38<br>
clat (usec): min=3D5, max=3D62584, avg=3D2695.80, stdev=3D5351.23<br>
lat (usec): min=3D109, max=3D62598, avg=3D2712.68, stdev=3D5350.42<br>
clat percentiles (usec):<br>
| 1.00th=3D[ 155], 5.00th=3D[ 183], 10.00th=3D[ 205], 20.00th=3D[ 247],<br>
| 30.00th=3D[ 294], 40.00th=3D[ 354], 50.00th=3D[ 446], 60.00th=3D[ 660],<b=
r>
| 70.00th=3D[ 1176], 80.00th=3D[ 3152], 90.00th=3D[ 9024], 95.00th=3D[14656=
],<br>
| 99.00th=3D[25984], 99.50th=3D[30336], 99.90th=3D[38656], 99.95th=3D[41728=
],<br>
| 99.99th=3D[47360]<br>
bw (KB /s): min=3D23928, max=3D154416, per=3D10.07%, avg=3D45462.82, stdev=
=3D28809.95<br>
lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=3D0.01%, 250=3D20.79%<=
br>
lat (usec) : 500=3D32.74%, 750=3D8.99%, 1000=3D5.03%<br>
lat (msec) : 2=3D8.37%, 4=3D6.21%, 10=3D8.90%, 20=3D6.60%, 50=3D2.37%<br>
lat (msec) : 100=3D0.01%<br>
cpu : usr=3D15.90%, sys=3D3.01%, ctx=3D765446, majf=3D0, minf=3D8710<br>
IO depths : 1=3D0.4%, 2=3D0.9%, 4=3D2.3%, 8=3D7.4%, 16=3D75.5%, 32=3D13.6%,=
 &gt;=3D64=3D0.0%<br>
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0%<br>
complete : 0=3D0.0%, 4=3D93.6%, 8=3D2.8%, 16=3D2.4%, 32=3D1.2%, 64=3D0.0%, =
&gt;=3D64=3D0.0%<br>
issued : total=3Dr=3D2958935/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, drop=
=3Dr=3D0/w=3D0/d=3D0<br>
latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
READ: io=3D11558MB, aggrb=3D451487KB/s, minb=3D451487KB/s, maxb=3D451487KB/=
s, mint=3D26215msec, maxt=3D26215msec<br>
<br>
Disk stats (read/write):<br>
sdg: ios=3D0/29, merge=3D0/16, ticks=3D0/3, in_queue=3D3, util=3D0.01%<br>
[root@ceph1-3 fiorbd]# ./fio fiorbd<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Drbd, iodepth=3D32<br>
<br>
<br>
<br>
<br>
AFTER RESTARTING OSDS<br>
----------------------<br>
[root@ceph1-3 fiorbd]# ./fio fiorbd<br>
rbd_iodepth32-test: (g=3D0): rw=3Drandread, bs=3D4K-4K/4K-4K/4K-4K, ioengin=
e=3Drbd, iodepth=3D32<br>
...<br>
fio-2.2.7-10-g51e9<br>
Starting 10 processes<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
rbd engine: RBD version: 0.1.9<br>
^Cbs: 10 (f=3D10): [r(10)] [0.2% done] [1155MB/0KB/0KB /s] [296K/0/0 iops] =
[eta 01h:09m:27s]<br>
fio: terminating on signal 2<br>
<br>
rbd_iodepth32-test: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D18252: Wed Ap=
r 22 10:02:28 2015<br>
read : io=3D7655.7MB, bw=3D1036.8MB/s, iops=3D265218, runt=3D 7389msec<br>
slat (usec): min=3D5, max=3D3406, avg=3D26.59, stdev=3D40.35<br>
clat (usec): min=3D8, max=3D684328, avg=3D930.43, stdev=3D6419.12<br>
lat (usec): min=3D154, max=3D684342, avg=3D957.02, stdev=3D6419.28<br>
clat percentiles (usec):<br>
| 1.00th=3D[ 243], 5.00th=3D[ 314], 10.00th=3D[ 366], 20.00th=3D[ 450],<br>
| 30.00th=3D[ 524], 40.00th=3D[ 604], 50.00th=3D[ 692], 60.00th=3D[ 796],<b=
r>
| 70.00th=3D[ 924], 80.00th=3D[ 1096], 90.00th=3D[ 1400], 95.00th=3D[ 1720]=
,<br>
| 99.00th=3D[ 2672], 99.50th=3D[ 3248], 99.90th=3D[ 5920], 99.95th=3D[ 9792=
],<br>
| 99.99th=3D[436224]<br>
bw (KB /s): min=3D32614, max=3D143160, per=3D10.19%, avg=3D108076.46, stdev=
=3D28263.82<br>
lat (usec) : 10=3D0.01%, 20=3D0.01%, 50=3D0.01%, 100=3D0.01%, 250=3D1.23%<b=
r>
lat (usec) : 500=3D25.64%, 750=3D29.15%, 1000=3D18.84%<br>
lat (msec) : 2=3D22.19%, 4=3D2.69%, 10=3D0.21%, 20=3D0.02%, 50=3D0.01%<br>
lat (msec) : 250=3D0.01%, 500=3D0.02%, 750=3D0.01%<br>
cpu : usr=3D44.06%, sys=3D11.26%, ctx=3D642620, majf=3D0, minf=3D6832<br>
IO depths : 1=3D0.1%, 2=3D0.5%, 4=3D2.0%, 8=3D11.5%, 16=3D77.8%, 32=3D8.1%,=
 &gt;=3D64=3D0.0%<br>
submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=3D0.0%, &=
gt;=3D64=3D0.0%<br>
complete : 0=3D0.0%, 4=3D94.1%, 8=3D1.3%, 16=3D2.3%, 32=3D2.3%, 64=3D0.0%, =
&gt;=3D64=3D0.0%<br>
issued : total=3Dr=3D1959697/w=3D0/d=3D0, short=3Dr=3D0/w=3D0/d=3D0, drop=
=3Dr=3D0/w=3D0/d=3D0<br>
latency : target=3D0, window=3D0, percentile=3D100.00%, depth=3D32<br>
<br>
Run status group 0 (all jobs):<br>
READ: io=3D7655.7MB, aggrb=3D1036.8MB/s, minb=3D1036.8MB/s, maxb=3D1036.8MB=
/s, mint=3D7389msec, maxt=3D7389msec<br>
<br>
Disk stats (read/write):<br>
sdg: ios=3D0/21, merge=3D0/10, ticks=3D0/2, in_queue=3D2, util=3D0.03%<br>
<br>
<br>
<br>
<br>
CEPH LOG<br>
--------<br>
<br>
before restarting osd<br>
----------------------<br>
<br>
2015-04-22 09:53:17.568095 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2144 : cluster [INF] pgmap v11330: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 298 MB/s rd, 76465 op/s<br>
2015-04-22 09:53:18.574524 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2145 : cluster [INF] pgmap v11331: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 333 MB/s rd, 85355 op/s<br>
2015-04-22 09:53:19.579351 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2146 : cluster [INF] pgmap v11332: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 343 MB/s rd, 87932 op/s<br>
2015-04-22 09:53:20.591586 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2147 : cluster [INF] pgmap v11333: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 328 MB/s rd, 84151 op/s<br>
2015-04-22 09:53:21.600650 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2148 : cluster [INF] pgmap v11334: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 237 MB/s rd, 60855 op/s<br>
2015-04-22 09:53:22.607966 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2149 : cluster [INF] pgmap v11335: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 144 MB/s rd, 36935 op/s<br>
2015-04-22 09:53:23.617780 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2150 : cluster [INF] pgmap v11336: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 321 MB/s rd, 82334 op/s<br>
2015-04-22 09:53:24.622341 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2151 : cluster [INF] pgmap v11337: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 368 MB/s rd, 94211 op/s<br>
2015-04-22 09:53:25.628432 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2152 : cluster [INF] pgmap v11338: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 244 MB/s rd, 62644 op/s<br>
2015-04-22 09:53:26.632855 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2153 : cluster [INF] pgmap v11339: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 175 MB/s rd, 44997 op/s<br>
2015-04-22 09:53:27.636573 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2154 : cluster [INF] pgmap v11340: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 122 MB/s rd, 31259 op/s<br>
2015-04-22 09:53:28.645784 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2155 : cluster [INF] pgmap v11341: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 229 MB/s rd, 58674 op/s<br>
2015-04-22 09:53:29.657128 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2156 : cluster [INF] pgmap v11342: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 271 MB/s rd, 69501 op/s<br>
2015-04-22 09:53:30.662796 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2157 : cluster [INF] pgmap v11343: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 211 MB/s rd, 54020 op/s<br>
2015-04-22 09:53:31.666421 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2158 : cluster [INF] pgmap v11344: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 164 MB/s rd, 42001 op/s<br>
2015-04-22 09:53:32.670842 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2159 : cluster [INF] pgmap v11345: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 134 MB/s rd, 34380 op/s<br>
2015-04-22 09:53:33.681357 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2160 : cluster [INF] pgmap v11346: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 293 MB/s rd, 75213 op/s<br>
2015-04-22 09:53:34.692177 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2161 : cluster [INF] pgmap v11347: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 337 MB/s rd, 86353 op/s<br>
2015-04-22 09:53:35.697401 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2162 : cluster [INF] pgmap v11348: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 229 MB/s rd, 58839 op/s<br>
2015-04-22 09:53:36.699309 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2163 : cluster [INF] pgmap v11349: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 390=
 GB data, 391 GB used, 904 GB / 1295 GB avail; 152 MB/s rd, 39117 op/s<br>
<br>
<br>
restarting osd<br>
---------------<br>
<br>
2015-04-22 10:00:09.766906 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2255 : cluster [INF] osd.0 marked itself=
 down<br>
2015-04-22 10:00:09.790212 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2256 : cluster [INF] osdmap e849: 9 osds=
: 8 up, 9 in<br>
2015-04-22 10:00:09.793050 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2257 : cluster [INF] pgmap v11439: 964 p=
gs: 2 active+undersized+degraded, 8 stale+active+remapped, 106 stale+active=
+clean, 54 active+remapped, 794 active+clean; 419 GB data, 420 GB used, 874=
 GB / 1295 GB avail; 516 kB/s rd, 130 op/s<br>
2015-04-22 10:00:10.795966 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2258 : cluster [INF] osdmap e850: 9 osds=
: 8 up, 9 in<br>
2015-04-22 10:00:10.796675 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2259 : cluster [INF] pgmap v11440: 964 p=
gs: 2 active+undersized+degraded, 8 stale+active+remapped, 106 stale+active=
+clean, 54 active+remapped, 794 active+clean; 419 GB data, 420 GB used, 874=
 GB / 1295 GB avail<br>
2015-04-22 10:00:11.798257 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2260 : cluster [INF] pgmap v11441: 964 p=
gs: 2 active+undersized+degraded, 8 stale+active+remapped, 106 stale+active=
+clean, 54 active+remapped, 794 active+clean; 419 GB data, 420 GB used, 874=
 GB / 1295 GB avail<br>
2015-04-22 10:00:12.339696 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2262 : cluster [INF] osd.1 marked itself=
 down<br>
2015-04-22 10:00:12.800168 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2263 : cluster [INF] osdmap e851: 9 osds=
: 7 up, 9 in<br>
2015-04-22 10:00:12.806498 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2264 : cluster [INF] pgmap v11443: 964 p=
gs: 1 active+undersized+degraded, 13 stale+active+remapped, 216 stale+activ=
e+clean, 49 active+remapped, 684 active+clean, 1 stale+active+undersized+de=
graded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:13.804186 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2265 : cluster [INF] osdmap e852: 9 osds=
: 7 up, 9 in<br>
2015-04-22 10:00:13.805216 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2266 : cluster [INF] pgmap v11444: 964 p=
gs: 1 active+undersized+degraded, 13 stale+active+remapped, 216 stale+activ=
e+clean, 49 active+remapped, 684 active+clean, 1 stale+active+undersized+de=
graded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:14.781785 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2268 : cluster [INF] osd.2 marked itself=
 down<br>
2015-04-22 10:00:14.810571 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2269 : cluster [INF] osdmap e853: 9 osds=
: 6 up, 9 in<br>
2015-04-22 10:00:14.813871 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2270 : cluster [INF] pgmap v11445: 964 p=
gs: 1 active+undersized+degraded, 22 stale+active+remapped, 300 stale+activ=
e+clean, 40 active+remapped, 600 active+clean, 1 stale+active+undersized+de=
graded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:15.810333 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2271 : cluster [INF] osdmap e854: 9 osds=
: 6 up, 9 in<br>
2015-04-22 10:00:15.811425 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2272 : cluster [INF] pgmap v11446: 964 p=
gs: 1 active+undersized+degraded, 22 stale+active+remapped, 300 stale+activ=
e+clean, 40 active+remapped, 600 active+clean, 1 stale+active+undersized+de=
graded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:16.395105 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2273 : cluster [INF] HEALTH_WARN; 2 pgs =
degraded; 323 pgs stale; 2 pgs stuck degraded; 64 pgs stuck unclean; 2 pgs =
stuck undersized; 2 pgs undersized; 3/9 in osds are down; clock skew detect=
ed on mon.ceph1-2<br>
2015-04-22 10:00:16.814432 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2274 : cluster [INF] osd.1 <a href=3D"ht=
tp://10.7.0.152:6800/14848" target=3D"_blank">10.7.0.152:6800/14848</a> boo=
t<br>
2015-04-22 10:00:16.814938 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2275 : cluster [INF] osdmap e855: 9 osds=
: 7 up, 9 in<br>
2015-04-22 10:00:16.815942 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2276 : cluster [INF] pgmap v11447: 964 p=
gs: 1 active+undersized+degraded, 22 stale+active+remapped, 300 stale+activ=
e+clean, 40 active+remapped, 600 active+clean, 1 stale+active+undersized+de=
graded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:17.222281 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2278 : cluster [INF] osd.3 marked itself=
 down<br>
2015-04-22 10:00:17.819371 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2279 : cluster [INF] osdmap e856: 9 osds=
: 6 up, 9 in<br>
2015-04-22 10:00:17.822041 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2280 : cluster [INF] pgmap v11448: 964 p=
gs: 1 active+undersized+degraded, 25 stale+active+remapped, 394 stale+activ=
e+clean, 37 active+remapped, 506 active+clean, 1 stale+active+undersized+de=
graded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:18.551068 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2282 : cluster [INF] osd.6 marked itself=
 down<br>
2015-04-22 10:00:18.819387 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2283 : cluster [INF] osd.2 <a href=3D"ht=
tp://10.7.0.152:6812/15410" target=3D"_blank">10.7.0.152:6812/15410</a> boo=
t<br>
2015-04-22 10:00:18.821134 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2284 : cluster [INF] osdmap e857: 9 osds=
: 6 up, 9 in<br>
2015-04-22 10:00:18.824440 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2285 : cluster [INF] pgmap v11449: 964 p=
gs: 1 active+undersized+degraded, 30 stale+active+remapped, 502 stale+activ=
e+clean, 32 active+remapped, 398 active+clean, 1 stale+active+undersized+de=
graded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:19.820947 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2287 : cluster [INF] osdmap e858: 9 osds=
: 6 up, 9 in<br>
2015-04-22 10:00:19.821853 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2288 : cluster [INF] pgmap v11450: 964 p=
gs: 1 active+undersized+degraded, 30 stale+active+remapped, 502 stale+activ=
e+clean, 32 active+remapped, 398 active+clean, 1 stale+active+undersized+de=
graded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:20.828047 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2290 : cluster [INF] osd.3 <a href=3D"ht=
tp://10.7.0.152:6816/15971" target=3D"_blank">10.7.0.152:6816/15971</a> boo=
t<br>
2015-04-22 10:00:20.828431 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2291 : cluster [INF] osdmap e859: 9 osds=
: 7 up, 9 in<br>
2015-04-22 10:00:20.829126 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2292 : cluster [INF] pgmap v11451: 964 p=
gs: 1 active+undersized+degraded, 30 stale+active+remapped, 502 stale+activ=
e+clean, 32 active+remapped, 398 active+clean, 1 stale+active+undersized+de=
graded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:20.991343 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2294 : cluster [INF] osd.7 marked itself=
 down<br>
2015-04-22 10:00:21.830389 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2295 : cluster [INF] osd.0 <a href=3D"ht=
tp://10.7.0.152:6804/14481" target=3D"_blank">10.7.0.152:6804/14481</a> boo=
t<br>
2015-04-22 10:00:21.832518 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2296 : cluster [INF] osdmap e860: 9 osds=
: 7 up, 9 in<br>
2015-04-22 10:00:21.836129 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2297 : cluster [INF] pgmap v11452: 964 p=
gs: 1 active+undersized+degraded, 35 stale+active+remapped, 608 stale+activ=
e+clean, 27 active+remapped, 292 active+clean, 1 stale+active+undersized+de=
graded; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:22.830456 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2298 : cluster [INF] osd.6 <a href=3D"ht=
tp://10.7.0.153:6808/21955" target=3D"_blank">10.7.0.153:6808/21955</a> boo=
t<br>
2015-04-22 10:00:22.832171 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2299 : cluster [INF] osdmap e861: 9 osds=
: 8 up, 9 in<br>
2015-04-22 10:00:22.836272 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2300 : cluster [INF] pgmap v11453: 964 p=
gs: 3 active+undersized+degraded, 27 stale+active+remapped, 498 stale+activ=
e+clean, 2 peering, 28 active+remapped, 402 active+clean, 4 remapped+peerin=
g; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:23.420309 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2302 : cluster [INF] osd.8 marked itself=
 down<br>
2015-04-22 10:00:23.833708 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2303 : cluster [INF] osdmap e862: 9 osds=
: 7 up, 9 in<br>
2015-04-22 10:00:23.836459 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2304 : cluster [INF] pgmap v11454: 964 p=
gs: 3 active+undersized+degraded, 44 stale+active+remapped, 587 stale+activ=
e+clean, 2 peering, 11 active+remapped, 313 active+clean, 4 remapped+peerin=
g; 419 GB data, 420 GB used, 874 GB / 1295 GB avail<br>
2015-04-22 10:00:24.832905 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2305 : cluster [INF] osd.7 <a href=3D"ht=
tp://10.7.0.153:6804/22536" target=3D"_blank">10.7.0.153:6804/22536</a> boo=
t<br>
2015-04-22 10:00:24.834381 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2306 : cluster [INF] osdmap e863: 9 osds=
: 8 up, 9 in<br>
2015-04-22 10:00:24.836977 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2307 : cluster [INF] pgmap v11455: 964 p=
gs: 3 active+undersized+degraded, 31 stale+active+remapped, 503 stale+activ=
e+clean, 4 active+undersized+degraded+remapped, 5 peering, 13 active+remapp=
ed, 397 active+clean, 8 remapped+peering; 419 GB data, 420 GB used, 874 GB =
/ 1295 GB avail<br>
2015-04-22 10:00:25.834459 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2309 : cluster [INF] osdmap e864: 9 osds=
: 8 up, 9 in<br>
2015-04-22 10:00:25.835727 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2310 : cluster [INF] pgmap v11456: 964 p=
gs: 3 active+undersized+degraded, 31 stale+active+remapped, 503 stale+activ=
e+clean, 4 active+undersized+degraded+remapped, 5 peering, 13 active<br>
<br>
<br>
AFTER OSD RESTART<br>
------------------<br>
<br>
<br>
2015-04-22 10:09:27.609052 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2339 : cluster [INF] pgmap v11478: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 786 MB/s rd, 196 kop/s<br>
2015-04-22 10:09:28.618082 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2340 : cluster [INF] pgmap v11479: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 1578 MB/s rd, 394 kop/s<br>
2015-04-22 10:09:30.629067 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2341 : cluster [INF] pgmap v11480: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 932 MB/s rd, 233 kop/s<br>
2015-04-22 10:09:32.645890 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2342 : cluster [INF] pgmap v11481: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 627 MB/s rd, 156 kop/s<br>
2015-04-22 10:09:33.652634 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2343 : cluster [INF] pgmap v11482: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 1034 MB/s rd, 258 kop/s<br>
2015-04-22 10:09:35.655657 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2344 : cluster [INF] pgmap v11483: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 529 MB/s rd, 132 kop/s<br>
2015-04-22 10:09:37.674332 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2345 : cluster [INF] pgmap v11484: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 770 MB/s rd, 192 kop/s<br>
2015-04-22 10:09:38.679445 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2346 : cluster [INF] pgmap v11485: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 1358 MB/s rd, 339 kop/s<br>
2015-04-22 10:09:40.690037 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2347 : cluster [INF] pgmap v11486: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 649 MB/s rd, 162 kop/s<br>
2015-04-22 10:09:42.707164 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2348 : cluster [INF] pgmap v11487: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 580 MB/s rd, 145 kop/s<br>
2015-04-22 10:09:43.713736 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2349 : cluster [INF] pgmap v11488: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 962 MB/s rd, 240 kop/s<br>
2015-04-22 10:09:45.718658 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2350 : cluster [INF] pgmap v11489: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 506 MB/s rd, 126 kop/s<br>
2015-04-22 10:09:47.737358 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2351 : cluster [INF] pgmap v11490: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 774 MB/s rd, 193 kop/s<br>
2015-04-22 10:09:48.743338 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2352 : cluster [INF] pgmap v11491: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 1363 MB/s rd, 340 kop/s<br>
2015-04-22 10:09:50.746685 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2353 : cluster [INF] pgmap v11492: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 662 MB/s rd, 165 kop/s<br>
2015-04-22 10:09:52.762461 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2354 : cluster [INF] pgmap v11493: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 593 MB/s rd, 148 kop/s<br>
2015-04-22 10:09:53.767729 mon.0 <a href=3D"http://10.7.0.152:6789/0" targe=
t=3D"_blank">10.7.0.152:6789/0</a> 2355 : cluster [INF] pgmap v11494: 964 p=
gs: 2 active+undersized+degraded, 62 active+remapped, 900 active+clean; 419=
 GB data, 421 GB used, 874 GB / 1295 GB avail; 938 MB/s rd, 234 kop/s<br>
<br>
</div></div>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<div class=3D""><div class=3D"h5">--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr">Milosz Tanski<br>CTO<br>16 =
East 34th Street, 15th floor<br>New York, NY 10016<br><br>p: 646-253-9055<b=
r>e: <a href=3D"mailto:milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org" target=3D"_blank">milosz-B5zB6C1i6pkAvxtiuMwx3w@public.gmane.org=
</a><br></div></div>
</div></div>

--001a11c351de6fbd5805144dfcc0--

--===============1436492606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1436492606==--
