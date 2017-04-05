From: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: bluestore - OSD booting issue continuosly
Date: Wed, 5 Apr 2017 15:45:47 +0530
Message-ID: <CALWuvY-f6oHRG16p29TGb_pB8jn7NA-fpPN3E2zq6BEJrxTRmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0145308407=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0145308407==
Content-Type: multipart/alternative; boundary=94eb2c03366c12e048054c68ad46

--94eb2c03366c12e048054c68ad46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

Env:- 11.2.0
         bluestore, EC 4+1 , RHEL7.2

We are facing one OSD's booting again and again which caused the cluster
crazy :( .  As you can see one PG got in inconsistent state while we tried
to repair that partular PG, as its primary OSD's went down. After some time
we found some trace from mon logs that the OSD boot continuously

# ceph pg stat

v1109889: 8192 pgs: 1 *active+clean+inconsistent*, 8191 active+clean; 31041
GB data, 42473 GB used, 1177 TB / 1218 TB avail; 411 kB/s rd, 28102 kB/s
wr, 322 op/s



# ceph health detail | grep 'inconsistent'

HEALTH_ERR 1 pgs inconsistent; 5 scrub errors

pg 1.5c4 is active+clean+inconsistent, acting [258,268,156,14,67]



# ceph pg deep-scrub 1.5c4

instructing pg 1.5c4 on osd.258 to deep-scrub





From ceph-osd.258.log when the problem pops up;

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


2017-04-04 13:08:08.288728 7f6b34fe6700 -1 log_channel(cluster) log [ERR] :
1.5c4s0 scrub stat mismatch, got 1989/1988 objects, 0/0 clones, 1989/1988
dirty, 0/0

omap, 0/0 pinned, 0/0 hit_set_archive, 0/0 whiteouts, 4113960196/4110943924
bytes, 0/0 hit_set_archive bytes.

2017-04-04 13:08:08.288744 7f6b34fe6700 -1 log_channel(cluster) log [ERR] :
1.5c4s0 scrub 1 missing, 0 inconsistent objects



2017-04-04 13:08:08.288747 7f6b34fe6700 -1 log_channel(cluster) log [ERR] :
1.5c4 scrub 5 errors


From mon logs

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



2017-04-05 07:18:17.665821 7f0fb55b5700  0 log_channel(cluster) log [INF] :
pgmap v1134421: 8192 pgs: 1 activating+degraded+inconsistent, 4 activ

ating, 27 active+recovery_wait+degraded, 3 active+recovering+degraded, 8157
active+clean; 31619 GB data, 43163 GB used, 1176 TB / 1218 TB avail;

16429 kB/s rd, 109 MB/s wr, 1208 op/s; 554/87717275 objects degraded
(0.001%)

2017-04-05 07:18:18.643905 7f0fb55b5700  1 mon.cn1@0(leader).osd e4701
e4701: 335 osds: 334 up, 335 in

2017-04-05 07:18:18.656143 7f0fb55b5700  0 mon.cn1@0(leader).osd e4701
crush map has features 288531987042664448, adjusting msgr requires

2017-04-05 07:18:18.676477 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osdmap e4701: 335 osds: 334 up, 335 in

2017-04-05 07:18:18.731719 7f0fb55b5700  0 log_channel(cluster) log [INF] :
pgmap v1134422: 8192 pgs: 1 activating+degraded+inconsistent, 4 activ

ating, 27 active+recovery_wait+degraded, 3 active+recovering+degraded, 8157
active+clean; 31619 GB data, 43163 GB used, 1176 TB / 1218 TB avail;

21108 kB/s rd, 105 MB/s wr, 1165 op/s; 554/87717365 objects degraded
(0.001%)

2017-04-05 07:18:19.963217 7f0fb55b5700  1 mon.cn1@0(leader).osd e4702
e4702: 335 osds: 335 up, 335 in

2017-04-05 07:18:19.975002 7f0fb55b5700  0 mon.cn1@0(leader).osd e4702
crush map has features 288531987042664448, adjusting msgr requires

2017-04-05 07:18:19.978696 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osd.258 10.139.4.84:6815/27074 *boot   --->>>>>>>>>>>>>>>>>>>>>>>>>>*

2017-04-05 07:18:19.983349 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osdmap e4702: 335 osds: 335 up, 335 in

2017-04-05 07:18:20.079996 7f0fb55b5700  0 log_channel(cluster) log [INF] :
pgmap v1134423: 8192 pgs: 1 inconsistent+peering, 15 peering, 23 acti

ve+recovery_wait+degraded, 3 active+recovering+degraded, 8150 active+clean;
31619 GB data, 43163 GB used, 1176 TB / 1218 TB avail; 6888 kB/s rd,

72604 kB/s wr, 654 op/s; 489/87717555 objects degraded (0.001%)

2017-04-05 07:18:20.135081 7f0fb55b5700  0 log_channel(cluster) log [INF] :
pgmap v1134424: 8192 pgs: 19 stale+active+clean, 1 inconsistent+peeri

ng, 15 peering, 23 active+recovery_wait+degraded, 3
active+recovering+degraded, 8131 active+clean; 31619 GB data, 43163 GB
used, 1176 TB / 1218 T

B avail; 3452 kB/s rd, 97092 kB/s wr, 834 op/s; 489/87717565 objects
degraded (0.001%)

2017-04-05 07:18:20.303398 7f0fb55b5700  1 mon.cn1@0(leader).osd e4703
e4703: 335 osds: 335 up, 335 in

Few occurance for boot..

2017-04-05 07:12:40.085065 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osd.258 10.139.4.84:6815/23975 boot
2017-04-05 07:13:37.299990 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osd.258 10.139.4.84:6815/24334 boot
2017-04-05 07:14:35.413633 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osd.258 10.139.4.84:6815/25745 boot
2017-04-05 07:15:30.303761 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osd.258 10.139.4.84:6815/26194 boot
2017-04-05 07:16:25.155067 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osd.258 10.139.4.84:6815/26561 boot
2017-04-05 07:17:22.538683 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osd.258 10.139.4.84:6815/26768 boot
2017-04-05 07:18:19.978696 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osd.258 10.139.4.84:6815/27074 boot
2017-04-05 07:19:14.201683 7f0fb55b5700  0 log_channel(cluster) log [INF] :
osd.258 10.139.4.84:6815/28517 boot


From OSD.258..
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  -5299> 2017-04-05 07:18:20.151610 7f7c9ed5e700  1 osd.258 4702
state: *booting
-> active*

 -5298> 2017-04-05 07:18:20.151622 7f7c9ed5e700  0 osd.258 4702 crush map
has features 288531987042664448, adjusting msgr requires for osds

 -5297> 2017-04-05 07:18:20.151759 7f7c92d46700  5 osd.258 pg_epoch: 4701
pg[1.894s2( v 4699'7995 lc 4260'7863 (2052'4800,4699'7995] local-les=3D4699
n=3D2058 ec=3D1713 les/c/f 4699/4295/0 4698/4698/4088) [288,191,258,27,125]=
 r=3D2
lpr=3D4699 pi=3D1713-4697/359 crt=3D4687'7993 lcod 0'0 inactive NOTIFY NIBB=
LEWISE
m=3D25] exit Started/Stray 2.766060 3 0.000228

 -5296> 2017-04-05 07:18:20.151764 7f7c94549700  5 osd.258 pg_epoch: 4701
pg[1.636s2( v 4683'8066 (2052'4800,4683'8066] local-les=3D4699 n=3D2039 ec=
=3D1713
les/c/f 4699/4699/0 4698/4698/4088) [292,186,258,28,106] r=3D2 lpr=3D4699
pi=3D1713-4697/354 crt=3D4683'8065 lcod 0'0 inactive NOTIFY NIBBLEWISE] exi=
t
Started/Stray 2.765980 3 0.000292

--< After some time >


197 ec=3D1713 les/c/f 4703/4295/0 4702/4702/4702) [258,268,156,14,67] r=3D0
lpr=3D4702 pi=3D4098-4701/372 crt=3D4700'8152 mlcod 0'0 active+recovery_wai=
t+de
graded+inconsistent m=3D37] exit
Started/Primary/Active/WaitRemoteRecoveryReserved 0.368048 4 0.000183
    -1> 2017-04-05 07:18:21.005621 7f7c97d50700  5 osd.258 pg_epoch: 4703
pg[1.5c4s0( v 4700'8152 lc 0'0 (2052'5000,4700'8152] local-les=3D4703 n=3D2
197 ec=3D1713 les/c/f 4703/4295/0 4702/4702/4702) [258,268,156,14,67] r=3D0
lpr=3D4702 pi=3D4098-4701/372 crt=3D4700'8152 mlcod 0'0 active+recovery_wai=
t+de
graded+inconsistent m=3D37] enter Started/Primary/Active/Recovering
     0> 2017-04-05 07:18:21.008127 7f7c8dd3c700 -1
/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x=
86_64/AVAILABLE_DIS
T/centos7/DIST/centos7/MACHINE_SIZE/huge/release/11.2.0/rpm/el7/BUILD/ceph-=
11.2.0/src/osd/PrimaryLogPG.cc:
In function 'uint64_t PrimaryLogPG::re
cover_primary(uint64_t, ThreadPool::TPHandle&)' thread 7f7c8dd3c700 time
2017-04-05 07:18:21.005761
/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x=
86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/11
.2.0/rpm/el7/BUILD/ceph-11.2.0/src/osd/PrimaryLogPG.cc: 10659: FAILED
assert(latest->is_update())

 ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x85) [0x7f7cba410b35]
 2: (PrimaryLogPG::recover_primary(unsigned long,
ThreadPool::TPHandle&)+0x4b5) [0x7f7cb9f32eb5]
 3: (PrimaryLogPG::start_recovery_ops(unsigned long, ThreadPool::TPHandle&,
unsigned long*)+0x50e) [0x7f7cb9f3c4be]
 4: (OSD::do_recovery(PG*, unsigned int, unsigned long,
ThreadPool::TPHandle&)+0x40c) [0x7f7cb9db58cc]
 5: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x771) [0x7f7cb9dbc5c1]
 6: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x947)
[0x7f7cba4167a7]
 7: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f7cba418900]
 8: (()+0x7dc5) [0x7f7cb73a3dc5]
=3D=3D=3D=3D




#ceph pg repair 1.5c4


While we ran the pg repair the primary OSD associated with the above PG got
crashed. Then it tries to boot again.

After pg repair excecution, as it went to  *inconsistent+peering *state.

# ceph pg stat

v1139236: 8192 pgs: 1 *inconsistent+peering*, 5 remapped+peering, 2
stale+active+clean, 16 peering, *8168 active+clean*; 31701 GB data, 43302
GB used, 1176 TB / 1218 TB avail; 44501 kB/s rd, 108 MB/s wr, 1193 op/s=E2=
=80=9D=E2=80=9D=E2=80=9D


Initially deep-scrubbing was disabled in cluster and now we have enabled it=
.

We also ran command 'ceph osd deep-scrub 258' but the osd keeps on booting
and we could not see any scrubbing initialized.


Removing OSD.258 from the cluster and reformat it again and re-inject to
cluster is the only fix for this issue? Is there any way to get rid of this
issue?


Awaiting for comments


Thanks

Jayaram

--94eb2c03366c12e048054c68ad46
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Env:- 11.2.0</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bluestore, EC 4+1 , RHEL7.2</div><div><br></div>=
<div>We are facing one OSD&#39;s booting again and again which caused the c=
luster crazy :( .=C2=A0 As you can see one PG got in inconsistent state whi=
le we tried to repair that partular PG, as its primary OSD&#39;s went down.=
 After some time we found some trace from mon logs that the OSD boot contin=
uously=C2=A0</div><div><br></div><div><p class=3D"MsoNormal"># ceph pg stat=
<span></span></p>

<p class=3D"MsoNormal">v1109889: 8192 pgs: 1 <b>active+clean+inconsistent</=
b>, 8191
active+clean; 31041 GB data, 42473 GB used, 1177 TB / 1218 TB avail; 411 kB=
/s
rd, 28102 kB/s wr, 322 op/s<span></span></p>

<p class=3D"MsoNormal"><span>=C2=A0</span></p>

<p class=3D"MsoNormal"># ceph health detail | grep
&#39;inconsistent&#39;<span></span></p>

<p class=3D"MsoNormal">HEALTH_ERR 1 pgs inconsistent; 5 scrub errors<span><=
/span></p>

<p class=3D"MsoNormal">pg 1.5c4 is active+clean+inconsistent, acting
[258,268,156,14,67]<span></span></p>

<p class=3D"MsoNormal"><span>=C2=A0</span></p>

<p class=3D"MsoNormal"># ceph pg deep-scrub 1.5c4<span></span></p>

<p class=3D"MsoNormal">instructing pg 1.5c4 on osd.258 to deep-scrub<span><=
/span></p>

<p class=3D"MsoNormal"><span>=C2=A0</span></p>

<p class=3D"MsoNormal"><span>=C2=A0</span></p>

<p class=3D"MsoNormal">From ceph-osd.258.log when the problem pops up;<span=
></span></p>

<p class=3D"MsoNormal"><span>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0</s=
pan></p><p class=3D"MsoNormal"><span><br></span></p>

<p class=3D"MsoNormal">2017-04-04 13:08:08.288728 7f6b34fe6700 -1
log_channel(cluster) log [ERR] : 1.5c4s0 scrub stat mismatch, got 1989/1988
objects, 0/0 clones, 1989/1988 dirty, 0/0<span></span></p>

<p class=3D"MsoNormal">omap, 0/0 pinned, 0/0 hit_set_archive, 0/0 whiteouts=
,
4113960196/4110943924 bytes, 0/0 hit_set_archive bytes.<span></span></p>

<p class=3D"MsoNormal">2017-04-04 13:08:08.288744 7f6b34fe6700 -1
log_channel(cluster) log [ERR] : 1.5c4s0 scrub 1 missing, 0 inconsistent
objects<span></span></p>

<p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal"><br></p><p class=3D"M=
soNormal">2017-04-04 13:08:08.288747 7f6b34fe6700 -1 log_channel(cluster)
log [ERR] : 1.5c4 scrub 5 errors<span></span></p>

<p class=3D"MsoNormal"><span><br></span></p><p class=3D"MsoNormal"><span>Fr=
om mon logs</span></p><p class=3D"MsoNormal"><span>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</span></p><p class=3D"MsoNormal"><span><br></span></p><p class=3D=
"MsoNormal"><span><br></span></p><p class=3D"MsoNormal">2017-04-05 07:18:17=
.665821 7f0fb55b5700 =C2=A00 log_channel(cluster) log [INF] : pgmap v113442=
1: 8192 pgs: 1 activating+degraded+inconsistent, 4 activ</p><p class=3D"Mso=
Normal">ating, 27 active+recovery_wait+degraded, 3 active+recovering+degrad=
ed, 8157 active+clean; 31619 GB data, 43163 GB used, 1176 TB / 1218 TB avai=
l;</p><p class=3D"MsoNormal">16429 kB/s rd, 109 MB/s wr, 1208 op/s; 554/877=
17275 objects degraded (0.001%)</p><p class=3D"MsoNormal">2017-04-05 07:18:=
18.643905 7f0fb55b5700 =C2=A01 mon.cn1@0(leader).osd e4701 e4701: 335 osds:=
 334 up, 335 in</p><p class=3D"MsoNormal">2017-04-05 07:18:18.656143 7f0fb5=
5b5700 =C2=A00 mon.cn1@0(leader).osd e4701 crush map has features 288531987=
042664448, adjusting msgr requires</p><p class=3D"MsoNormal">2017-04-05 07:=
18:18.676477 7f0fb55b5700 =C2=A00 log_channel(cluster) log [INF] : osdmap e=
4701: 335 osds: 334 up, 335 in</p><p class=3D"MsoNormal">2017-04-05 07:18:1=
8.731719 7f0fb55b5700 =C2=A00 log_channel(cluster) log [INF] : pgmap v11344=
22: 8192 pgs: 1 activating+degraded+inconsistent, 4 activ</p><p class=3D"Ms=
oNormal">ating, 27 active+recovery_wait+degraded, 3 active+recovering+degra=
ded, 8157 active+clean; 31619 GB data, 43163 GB used, 1176 TB / 1218 TB ava=
il;</p><p class=3D"MsoNormal">21108 kB/s rd, 105 MB/s wr, 1165 op/s; 554/87=
717365 objects degraded (0.001%)</p><p class=3D"MsoNormal">2017-04-05 07:18=
:19.963217 7f0fb55b5700 =C2=A01 mon.cn1@0(leader).osd e4702 e4702: 335 osds=
: 335 up, 335 in</p><p class=3D"MsoNormal">2017-04-05 07:18:19.975002 7f0fb=
55b5700 =C2=A00 mon.cn1@0(leader).osd e4702 crush map has features 28853198=
7042664448, adjusting msgr requires</p><p class=3D"MsoNormal">2017-04-05 07=
:18:19.978696 7f0fb55b5700 =C2=A00 log_channel(cluster) log [INF] : osd.258=
 <a href=3D"http://10.139.4.84:6815/27074">10.139.4.84:6815/27074</a> <b>bo=
ot =C2=A0 ---&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&g=
t;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</b></p><p class=3D"MsoNormal">20=
17-04-05 07:18:19.983349 7f0fb55b5700 =C2=A00 log_channel(cluster) log [INF=
] : osdmap e4702: 335 osds: 335 up, 335 in</p><p class=3D"MsoNormal">2017-0=
4-05 07:18:20.079996 7f0fb55b5700 =C2=A00 log_channel(cluster) log [INF] : =
pgmap v1134423: 8192 pgs: 1 inconsistent+peering, 15 peering, 23 acti</p><p=
 class=3D"MsoNormal">ve+recovery_wait+degraded, 3 active+recovering+degrade=
d, 8150 active+clean; 31619 GB data, 43163 GB used, 1176 TB / 1218 TB avail=
; 6888 kB/s rd,</p><p class=3D"MsoNormal">72604 kB/s wr, 654 op/s; 489/8771=
7555 objects degraded (0.001%)</p><p class=3D"MsoNormal">2017-04-05 07:18:2=
0.135081 7f0fb55b5700 =C2=A00 log_channel(cluster) log [INF] : pgmap v11344=
24: 8192 pgs: 19 stale+active+clean, 1 inconsistent+peeri</p><p class=3D"Ms=
oNormal">ng, 15 peering, 23 active+recovery_wait+degraded, 3 active+recover=
ing+degraded, 8131 active+clean; 31619 GB data, 43163 GB used, 1176 TB / 12=
18 T</p><p class=3D"MsoNormal">B avail; 3452 kB/s rd, 97092 kB/s wr, 834 op=
/s; 489/87717565 objects degraded (0.001%)</p><p class=3D"MsoNormal"></p><p=
 class=3D"MsoNormal">2017-04-05 07:18:20.303398 7f0fb55b5700 =C2=A01 mon.cn=
1@0(leader).osd e4703 e4703: 335 osds: 335 up, 335 in</p><div><br></div><di=
v>Few occurance for boot..</div><div><br></div><div><div>2017-04-05 07:12:4=
0.085065 7f0fb55b5700 =C2=A00 log_channel(cluster) log [INF] : osd.258 <a h=
ref=3D"http://10.139.4.84:6815/23975">10.139.4.84:6815/23975</a> boot</div>=
<div>2017-04-05 07:13:37.299990 7f0fb55b5700 =C2=A00 log_channel(cluster) l=
og [INF] : osd.258 <a href=3D"http://10.139.4.84:6815/24334">10.139.4.84:68=
15/24334</a> boot</div><div>2017-04-05 07:14:35.413633 7f0fb55b5700 =C2=A00=
 log_channel(cluster) log [INF] : osd.258 <a href=3D"http://10.139.4.84:681=
5/25745">10.139.4.84:6815/25745</a> boot</div><div>2017-04-05 07:15:30.3037=
61 7f0fb55b5700 =C2=A00 log_channel(cluster) log [INF] : osd.258 <a href=3D=
"http://10.139.4.84:6815/26194">10.139.4.84:6815/26194</a> boot</div><div>2=
017-04-05 07:16:25.155067 7f0fb55b5700 =C2=A00 log_channel(cluster) log [IN=
F] : osd.258 <a href=3D"http://10.139.4.84:6815/26561">10.139.4.84:6815/265=
61</a> boot</div><div>2017-04-05 07:17:22.538683 7f0fb55b5700 =C2=A00 log_c=
hannel(cluster) log [INF] : osd.258 <a href=3D"http://10.139.4.84:6815/2676=
8">10.139.4.84:6815/26768</a> boot</div><div>2017-04-05 07:18:19.978696 7f0=
fb55b5700 =C2=A00 log_channel(cluster) log [INF] : osd.258 <a href=3D"http:=
//10.139.4.84:6815/27074">10.139.4.84:6815/27074</a> boot</div><div>2017-04=
-05 07:19:14.201683 7f0fb55b5700 =C2=A00 log_channel(cluster) log [INF] : o=
sd.258 <a href=3D"http://10.139.4.84:6815/28517">10.139.4.84:6815/28517</a>=
 boot</div></div><div><br></div><div><br></div><div>From OSD.258..</div><di=
v>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D</div><p class=3D"MsoNormal"><span>=C2=A0</span>=C2=A0-5299&gt; 2017-=
04-05 07:18:20.151610 7f7c9ed5e700 =C2=A01 osd.258 4702 state: <b>booting -=
&gt; active</b></p><p class=3D"MsoNormal">=C2=A0-5298&gt; 2017-04-05 07:18:=
20.151622 7f7c9ed5e700 =C2=A00 osd.258 4702 crush map has features 28853198=
7042664448, adjusting msgr requires for osds</p><p class=3D"MsoNormal">=C2=
=A0-5297&gt; 2017-04-05 07:18:20.151759 7f7c92d46700 =C2=A05 osd.258 pg_epo=
ch: 4701 pg[1.894s2( v 4699&#39;7995 lc 4260&#39;7863 (2052&#39;4800,4699&#=
39;7995] local-les=3D4699 n=3D2058 ec=3D1713 les/c/f 4699/4295/0 4698/4698/=
4088) [288,191,258,27,125] r=3D2 lpr=3D4699 pi=3D1713-4697/359 crt=3D4687&#=
39;7993 lcod 0&#39;0 inactive NOTIFY NIBBLEWISE m=3D25] exit Started/Stray =
2.766060 3 0.000228</p><p class=3D"MsoNormal">=C2=A0-5296&gt; 2017-04-05 07=
:18:20.151764 7f7c94549700 =C2=A05 osd.258 pg_epoch: 4701 pg[1.636s2( v 468=
3&#39;8066 (2052&#39;4800,4683&#39;8066] local-les=3D4699 n=3D2039 ec=3D171=
3 les/c/f 4699/4699/0 4698/4698/4088) [292,186,258,28,106] r=3D2 lpr=3D4699=
 pi=3D1713-4697/354 crt=3D4683&#39;8065 lcod 0&#39;0 inactive NOTIFY NIBBLE=
WISE] exit Started/Stray 2.765980 3 0.000292</p><div><br></div><div>--&lt; =
After some time &gt;=C2=A0</div><div><br></div><div><div><br></div><div>197=
 ec=3D1713 les/c/f 4703/4295/0 4702/4702/4702) [258,268,156,14,67] r=3D0 lp=
r=3D4702 pi=3D4098-4701/372 crt=3D4700&#39;8152 mlcod 0&#39;0 active+recove=
ry_wait+de</div><div>graded+inconsistent m=3D37] exit Started/Primary/Activ=
e/WaitRemoteRecoveryReserved 0.368048 4 0.000183</div><div>=C2=A0 =C2=A0 -1=
&gt; 2017-04-05 07:18:21.005621 7f7c97d50700 =C2=A05 osd.258 pg_epoch: 4703=
 pg[1.5c4s0( v 4700&#39;8152 lc 0&#39;0 (2052&#39;5000,4700&#39;8152] local=
-les=3D4703 n=3D2</div><div>197 ec=3D1713 les/c/f 4703/4295/0 4702/4702/470=
2) [258,268,156,14,67] r=3D0 lpr=3D4702 pi=3D4098-4701/372 crt=3D4700&#39;8=
152 mlcod 0&#39;0 active+recovery_wait+de</div><div>graded+inconsistent m=
=3D37] enter Started/Primary/Active/Recovering</div><div>=C2=A0 =C2=A0 =C2=
=A00&gt; 2017-04-05 07:18:21.008127 7f7c8dd3c700 -1 /home/jenkins-build/bui=
ld/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIS</di=
v><div>T/centos7/DIST/centos7/MACHINE_SIZE/huge/release/11.2.0/rpm/el7/BUIL=
D/ceph-11.2.0/src/osd/PrimaryLogPG.cc: In function &#39;uint64_t PrimaryLog=
PG::re</div><div>cover_primary(uint64_t, ThreadPool::TPHandle&amp;)&#39; th=
read 7f7c8dd3c700 time 2017-04-05 07:18:21.005761</div><div>/home/jenkins-b=
uild/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE=
_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/11</div><div>.2.0/rpm/=
el7/BUILD/ceph-11.2.0/src/osd/PrimaryLogPG.cc: 10659: FAILED assert(latest-=
&gt;is_update())</div><div><br></div><div>=C2=A0ceph version 11.2.0 (f223e2=
7eeb35991352ebc1f67423d4ebc252adb7)</div><div>=C2=A01: (ceph::__ceph_assert=
_fail(char const*, char const*, int, char const*)+0x85) [0x7f7cba410b35]</d=
iv><div>=C2=A02: (PrimaryLogPG::recover_primary(unsigned long, ThreadPool::=
TPHandle&amp;)+0x4b5) [0x7f7cb9f32eb5]</div><div>=C2=A03: (PrimaryLogPG::st=
art_recovery_ops(unsigned long, ThreadPool::TPHandle&amp;, unsigned long*)+=
0x50e) [0x7f7cb9f3c4be]</div><div>=C2=A04: (OSD::do_recovery(PG*, unsigned =
int, unsigned long, ThreadPool::TPHandle&amp;)+0x40c) [0x7f7cb9db58cc]</div=
><div>=C2=A05: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_ha=
ndle_d*)+0x771) [0x7f7cb9dbc5c1]</div><div>=C2=A06: (ShardedThreadPool::sha=
rdedthreadpool_worker(unsigned int)+0x947) [0x7f7cba4167a7]</div><div>=C2=
=A07: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f7cba418900]=
</div><div>=C2=A08: (()+0x7dc5) [0x7f7cb73a3dc5]</div></div><div>=3D=3D=3D=
=3D</div><div><br></div><div><br></div>

<p class=3D"MsoNormal"><span>=C2=A0</span></p>

<p class=3D"MsoNormal">#ceph pg repair 1.5c4 <span></span></p>

<p class=3D"MsoNormal"><span>=C2=A0</span></p>

While we ran the pg repair the primary OSD associated with the above PG got=
 crashed. Then it tries to boot again.</div><div><br></div><div>After pg re=
pair excecution, as it went to =C2=A0<b>inconsistent+peering </b>state. <b>=
=C2=A0</b></div><div><br></div><div><p class=3D"MsoNormal"># ceph pg stat<s=
pan></span></p>

<p class=3D"MsoNormal">v1139236: 8192 pgs: 1 <b>inconsistent+peering</b>, 5
remapped+peering, 2 stale+active+clean, 16 peering, <b>8168 active+clean</b=
>;
31701 GB data, 43302 GB used, 1176 TB / 1218 TB avail; 44501 kB/s rd, 108 M=
B/s
wr, 1193 op/s=E2=80=9D=E2=80=9D=E2=80=9D<br></p><p class=3D"MsoNormal"><spa=
n></span></p><p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Initiall=
y deep-scrubbing was disabled in cluster and now we
have enabled it.<span></span></p><p class=3D"MsoNormal">

</p><p class=3D"MsoNormal">We also ran command &#39;ceph osd deep-scrub 258=
&#39; but the osd
keeps on booting and we could not see any scrubbing initialized.<span></spa=
n></p><p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Removing OSD.25=
8 from the cluster and reformat it again and re-inject to cluster is the on=
ly fix for this issue? Is there any way to get rid of this issue?</p><p cla=
ss=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Awaiting for comments</p><p=
 class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">Thanks</p><p class=3D"M=
soNormal">Jayaram</p><p class=3D"MsoNormal"><br></p></div></div>

--94eb2c03366c12e048054c68ad46--

--===============0145308407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0145308407==--
