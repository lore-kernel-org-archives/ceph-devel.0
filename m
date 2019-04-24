From: lin zhou <hnuzhoulin2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: rbd omap disappeared
Date: Wed, 24 Apr 2019 20:42:15 +0800
Message-ID: <CAKO+7k2UyEgd8VDjA-KcK7_Edmk4GBpqyEAm3G8ctHqPXM8Gbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6479710305964019524=="
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============6479710305964019524==
Content-Type: multipart/alternative; boundary="000000000000be73dc05874609f7"

--000000000000be73dc05874609f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

my cluster occur a big error this morning.
many osd suicide because of heartbeat_map timeout.
when I start all osd manually.it looks well.

but when I using rbd info for a rbd from rbd ls, it say not such file or
directory.
And the I use the way in
https://fnordahl.com/2017/04/17/ceph-rbd-volume-header-recovery/ to
recovery omap.

At last,most rbd works well.But still have 5 rbd can not reocvery.

2019-04-24 16:00:40.045342 7fd5fdffb700 -1 librbd::image::OpenRequest:
failed to retreive immutable metadata: (5) Input/output error
2019-04-24 16:00:40.045419 7fd5fd7fa700 -1 librbd::ImageState:
0x5593262fb830 failed to open image: (5) Input/output error
rbd: error opening image volume-bef74858-0fcb-4a0b-b197-9618e6824c46: (5)
Input/output error

I try to locate its omap head object, and stop master osd, delete the pg
data in master osd, then restart master osd. It looks three replication is
the same  when I using attr.

But I can not get the rbd info.Alwayse the vm among this  rbd is still
alive and works well.

ceph -s
    cluster 2bec9425-ea5f-4a48-b56a-fe88e126bced
     health HEALTH_WARN
            noout flag(s) set
     monmap e1: 3 mons at {a=3D
10.191.175.249:6789/0,b=3D10.191.175.250:6789/0,c=3D10.191.175.251:6789/0}
            election epoch 26, quorum 0,1,2 a,b,c
     osdmap e22551: 1080 osds: 1078 up, 1078 in
            flags noout,sortbitwise,require_jewel_osds
      pgmap v29327873: 90112 pgs, 3 pools, 69753 GB data, 30081 kobjects
            214 TB used, 1500 TB / 1715 TB avail
               90111 active+clean
                   1 active+clean+scrubbing+deep
  client io 57082 kB/s rd, 207 MB/s wr, 1091 op/s rd, 7658 op/s wr

the log of osd.219 which is the firstest log heartbeat no reply.

2019-04-24 04:00:54.905504 7f5eb7fab700  1 heartbeat_map is_healthy
'OSD::osd_op_tp thread 0x7f5e97182700' had timed out after 15
...
2019-04-24 04:00:54.905536 7f5eb7fab700  1 heartbeat_map is_healthy
'OSD::osd_op_tp thread 0x7f5e9b18a700' had timed out after 15
2019-04-24 04:00:57.499903 7f5df2997700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.33:6947/3001469 pipe(0x55d93b470800 sd=3D1914 :6855 s=3D2 pgs=3D=
514958
cs=3D17 l=3D0 c=3D0x55d91a3c1200).fault with nothing to send, going to stan=
dby
... repeat large
2019-04-24 04:00:57.651603 7f5e77735700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.36:6845/1062649 pipe(0x55d92d2cb400 sd=3D105 :45295 s=3D2 pgs=3D=
493749
cs=3D11 l=3D0 c=3D0x55d943755200).fault with nothing to send, going to stan=
dby
2019-04-24 04:00:59.905846 7f5eb7fab700  1 heartbeat_map is_healthy
'OSD::osd_op_tp thread 0x7f5e97182700' had timed out after 15
...
2019-04-24 04:01:04.666159 7f5dbb6d7700  0 -- 10.191.175.20:6856/3169631 >>
:/0 pipe(0x55d9234b1400 sd=3D1926 :6856 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d924743600).accept failed to getpeername (107) Transport endpoint i=
s
not connected
2019-04-24 04:01:04.905958 7f5eb7fab700  1 heartbeat_map is_healthy
'OSD::osd_op_tp thread 0x7f5e97182700' had timed out after 15
2019-04-24 04:01:14.550812 7f5db7793700  0 -- 10.191.175.20:6856/3169631 >>
:/0 pipe(0x55d9234b2800 sd=3D1927 :6856 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d924742a00).accept failed to getpeername (107) Transport endpoint i=
s
not connected
...
2019-04-24 04:01:14.691430 7f5db7793700  0 -- 10.191.175.20:6858/3169631 >>
:/0 pipe(0x55d936a78800 sd=3D1383 :6858 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d94ecf5a80).accept failed to getpeername (107) Transport endpoint i=
s
not connected
2019-04-24 04:01:14.692176 7f5e90469700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.31:6835/2092007 pipe(0x55d93c41a800 sd=3D67 :17328 s=3D2 pgs=3D5=
71754
cs=3D83 l=3D0 c=3D0x55d939913180).fault, initiating reconnect
2019-04-24 04:01:14.693742 7f5e4c889700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.31:6835/2092007 pipe(0x55d93c41a800 sd=3D67 :17766 s=3D1 pgs=3D5=
71754
cs=3D84 l=3D0 c=3D0x55d939913180).connect got RESETSESSION
2019-04-24 04:01:14.697098 7f5db256c700  0 -- 10.191.175.20:6908/169631 >>
:/0 pipe(0x55d95606c800 sd=3D352 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d920d79500).accept failed to getpeername (107) Transport endpoint i=
s
not connected
2019-04-24 04:01:14.697516 7f5e08523700  0 -- 10.191.175.20:6908/169631 >>
:/0 pipe(0x55d91b30c000 sd=3D1926 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d9263cb780).accept failed to getpeername (107) Transport endpoint i=
s
not connected
...
2019-04-24 04:01:14.704225 7f5dd7790700  0 -- 10.191.175.20:6908/169631 >>
:/0 pipe(0x55d9531c5400 sd=3D1927 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d9263ca280).accept failed to getpeername (107) Transport endpoint i=
s
not connected
2019-04-24 04:01:14.704511 7f5e78c4a700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.37:6801/2131766 pipe(0x55d939274800 sd=3D507 :10332 s=3D1 pgs=3D=
604906
cs=3D3 l=3D0 c=3D0x55d925714600).connect got RESETSESSION
...
2019-04-24 04:01:14.705970 7f5dc4980700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.38:6833/3181256 pipe(0x55d950fed400 sd=3D455 :58907 s=3D1 pgs=3D=
563194
cs=3D17 l=3D0 c=3D0x55d9320a2480).connect got RESETSESSION
2019-04-24 04:01:14.696315 7f5db548e700  0 -- 10.191.175.20:6908/169631 >>
:/0 pipe(0x55d939e45400 sd=3D1929 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d91b787d80).accept failed to getpeername (107) Transport endpoint i=
s
not connected
2019-04-24 04:01:14.708160 7f5e808c6700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.37:6823/2160572 pipe(0x55d943742800 sd=3D812 :41939 s=3D1 pgs=3D=
566937
cs=3D1 l=3D0 c=3D0x55d930f82900).connect got RESETSESSION
2019-04-24 04:01:14.708417 7f5e9a989700  1 heartbeat_map reset_timeout
'OSD::osd_op_tp thread 0x7f5e9a989700' had timed out after 15
...
2019-04-24 04:01:14.708949 7f5e97983700  1 heartbeat_map reset_timeout
'OSD::osd_op_tp thread 0x7f5e97983700' had timed out after 15
2019-04-24 04:01:14.709602 7f5e007ac700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.28:6821/1091360 pipe(0x55d94e69b400 sd=3D1419 :40317 s=3D1
pgs=3D566133 cs=3D1 l=3D0 c=3D0x55d938741480).connect got RESETSESSION
2019-04-24 04:01:14.710727 7f5e07216700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.44:6838/112579 pipe(0x55d946d74800 sd=3D809 :23481 s=3D1 pgs=3D3=
2 cs=3D1
l=3D0 c=3D0x55d94f963a80).connect got RESETSESSION
2019-04-24 04:01:14.712774 7f5e8716c700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.34:6916/1001159 pipe(0x55d95be21400 sd=3D189 :55315 s=3D1 pgs=3D=
533958
cs=3D1 l=3D0 c=3D0x55d935329e00).connect got RESETSESSION
2019-04-24 04:01:14.713262 7f5e90e73700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.34:6945/1173248 pipe(0x55d9447e8000 sd=3D99 :37118 s=3D1 pgs=3D5=
56344
cs=3D1 l=3D0 c=3D0x55d91ff36700).connect got RESETSESSION
2019-04-24 04:01:14.717779 7f5e87a75700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.26:6930/1101469 pipe(0x55d92c171400 sd=3D183 :23002 s=3D1 pgs=3D=
590456
cs=3D1 l=3D0 c=3D0x55d94e748580).connect got RESETSESSION
2019-04-24 04:01:14.717778 7f5db2f5d700  0 -- 10.191.175.20:6908/169631 >>
:/0 pipe(0x55d948732800 sd=3D1936 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d9276cd680).accept failed to getpeername (107) Transport endpoint i=
s
not connected
2019-04-24 04:01:14.717885 7f5e8a409700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.41:6827/2071106 pipe(0x55d93cc55400 sd=3D165 :48272 s=3D1 pgs=3D=
578891
cs=3D1 l=3D0 c=3D0x55d93d4aca00).connect got RESETSESSION
2019-04-24 04:01:14.717982 7f5e3dfa1700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.54:6851/2123643 pipe(0x55d920934000 sd=3D383 :42585 s=3D1 pgs=3D=
574915
cs=3D1 l=3D0 c=3D0x55d928482d00).connect got RESETSESSION
2019-04-24 04:01:14.718139 7f5e513d4700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.42:6861/3118363 pipe(0x55d93dcb0000 sd=3D808 :45616 s=3D1 pgs=3D=
492641
cs=3D1 l=3D0 c=3D0x55d930cf9800).connect got RESETSESSION
2019-04-24 04:01:14.718191 7f5db4b6b700  0 -- 10.191.175.20:6908/169631 >>
:/0 pipe(0x55d934596000 sd=3D1932 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d92f572000).accept failed to getpeername (107) Transport endpoint i=
s
not connected
2019-04-24 04:01:14.719112 7f5e8dc41700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.30:6815/3154304 pipe(0x55d946d73400 sd=3D545 :54330 s=3D1 pgs=3D=
552367
cs=3D1 l=3D0 c=3D0x55d94f019180).connect got RESETSESSION
2019-04-24 04:01:14.719200 7f5e07715700  0 -- 10.191.175.20:6908/169631 >>
:/0 pipe(0x55d9234b1400 sd=3D1935 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d92345c700).accept failed to getpeername (107) Transport endpoint i=
s
not connected
2019-04-24 04:01:14.719295 7f5ea5ac1700  0 -- 10.191.175.20:6908/169631 >>
:/0 pipe(0x55d9234b2800 sd=3D1934 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0
c=3D0x55d941d0a780).accept failed to getpeername (107) Transport endpoint i=
s
not connected
2019-04-24 04:01:14.719556 7f5e97182700  1 heartbeat_map reset_timeout
'OSD::osd_op_tp thread 0x7f5e97182700' had timed out after 15
=E3=80=82=E3=80=82=E3=80=82=E3=80=82
2019-04-24 04:01:14.731783 7f5e8a70c700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.47:6890/1064637 pipe(0x55d93cc56800 sd=3D164 :56146 s=3D1 pgs=3D=
493037
cs=3D1 l=3D0 c=3D0x55d93d4ad600).connect got RESETSESSION
2019-04-24 04:01:14.731789 7f5e22f8c700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.35:6818/1109909 pipe(0x55d93b319400 sd=3D300 :48698 s=3D1 pgs=3D=
555765
cs=3D1 l=3D0 c=3D0x55d925407500).connect got RESETSESSION
2019-04-24 04:01:14.732623 7f5e2419e700  0 -- 10.191.175.20:6855/3169631 >>
10.191.175.29:6956/2086678 pipe(0x55d94b9cc800 sd=3D1070 :42700 s=3D1
pgs=3D582448 cs=3D1 l=3D0 c=3D0x55d94ef83b00).connect got RESETSESSION
2019-04-24 04:01:14.792353 7f5eb2c35700 -1 osd.219 22611 heartbeat_check:
no reply from 10.191.175.20:6861 osd.218 since back 2019-04-24
04:00:33.420027 front 2019-04-24 04:00:33.420027 (cutoff 2019-04-24
04:00:54.792349)
... large amount of no reply
2019-04-24 04:01:14.810961 7f5eb2c35700 -1 osd.219 22611 heartbeat_check:
no reply from 10.191.175.55:6896 osd.1069 since back 2019-04-24
04:00:33.420027 front 2019-04-24 04:00:33.420027 (cutoff 2019-04-24
04:00:54.792349)
2019-04-24 04:01:14.810972 7f5eb2c35700 -1 osd.219 22611 heartbeat_check:
no reply from 10.191.175.55:6807 osd.1072 since back 2019-04-24
04:00:33.420027 front 2019-04-24 04:00:33.420027 (cutoff 2019-04-24
04:00:54.792349)
2019-04-24 04:01:14.820935 7f5e9a188700  0 -- 10.191.175.20:6908/169631
submit_message osd_op_reply(1103570 rbd_header.b0bc14677ca78c [watch ping
cookie 140029489856640 gen 1] v0'0 uv0 ondisk =3D -107 ((107) Transport
endpoint is not connected)) v7 remote, 10.191.122.251:0/1594377730, failed
lossy con, dropping message 0x55d957747600
2019-04-24 04:01:14.821340 7f5eb2c35700  0 log_channel(cluster) log [WRN] :
69 slow requests, 5 included below; oldest blocked for > 44.042324 secs
2019-04-24 04:01:14.821355 7f5eb2c35700  0 log_channel(cluster) log [WRN] :
slow request 37.989255 seconds old, received at 2019-04-24 04:00:36.821750:
osd_op(client.9569145.0:11357796 7.2339e183 (undecoded)
ack+ondisk+write+known_if_redirected e22611) currently queued_for_pg
...
2019-04-24 04:10:15.049210 7f5eb7fab700  1 heartbeat_map is_healthy
'OSD::osd_tp thread 0x7f5e9c98d700' had timed out after 15
2019-04-24 04:10:15.049213 7f5eb7fab700  1 heartbeat_map is_healthy
'OSD::osd_tp thread 0x7f5e9c98d700' had suicide timed out after 150
2019-04-24 04:10:15.159190 7f5eb7fab700 -1 common/HeartbeatMap.cc: In
function 'bool ceph::HeartbeatMap::_check(const ceph::heartbeat_handle_d*,
const char*, time_t)' thread 7f5eb7fab70
0 time 2019-04-24 04:10:15.049507
common/HeartbeatMap.cc: 86: FAILED assert(0 =3D=3D "hit suicide timeout")

 ceph version 10.2.10 (5dc1e4c05cb68dbf62ae6fce3f0700e4654fdbbe)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x82) [0x55d909a9ae12]
 2: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d const*, char
const*, long)+0x11f) [0x55d9099d2f4f]
 3: (ceph::HeartbeatMap::is_healthy()+0xd6) [0x55d9099d3976]
 4: (ceph::HeartbeatMap::check_touch_file()+0x2a) [0x55d9099d418a]
 5: (CephContextServiceThread::entry()+0x16c) [0x55d909ab4edc]
 6: (()+0x8064) [0x7f5ebc5dc064]
 7: (clone()+0x6d) [0x7f5eba6dd62d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
to interpret this.

--- begin dump of recent events ---
-10000> 2019-04-24 04:07:00.490378 7f5e9c18c700  5 osd.219 pg_epoch: 22818
pg[7.1ee8( v 22611'65709 (19416'62700,22611'65709] local-les=3D22799 n=3D21=
7
ec=3D6370 les/c/f 22799/22800/0 22804/22804/22804) [437,1013] r=3D-1 lpr=3D=
22804
pi=3D22780-22803/1 crt=3D22611'65707 lcod 22611'65708 inactive NOTIFY] ente=
r
Reset
 -9999> 2019-04-24 04:07:00.490427 7f5e9c18c700  5 osd.219 pg_epoch: 22819
pg[7.1ee8( v 22611'65709 (19416'62700,22611'65709] local-les=3D22799 n=3D21=
7
ec=3D6370 les/c/f 22799/22800/0 22818/22818/22818) [] r=3D-1 lpr=3D22818
pi=3D22780-22817/2 crt=3D22611'65707 lcod 22611'65708 inactive NOTIFY] exit
Reset 0.000049 2 0.000045
 -9998> 2019-04-24 04:07:00.490437 7f5e9c18c700  5 osd.219 pg_epoch: 22819
pg[7.1ee8( v 22611'65709 (19416'62700,22611'65709] local-les=3D22799 n=3D21=
7
ec=3D6370 les/c/f 22799/22800/0 22818/22818/22818) [] r=3D-1 lpr=3D22818
pi=3D22780-22817/2 crt=3D22611'65707 lcod 22611'65708 inactive NOTIFY] ente=
r
Started
 -9997> 2019-04-24 04:07:00.490443 7f5e9c18c700  5 osd.219 pg_epoch: 22819
pg[7.1ee8( v 22611'65709 (19416'62700,22611'65709] local-les=3D22799 n=3D21=
7
ec=3D6370 les/c/f 22799/22800/0 22818/22818/22818) [] r=3D-1 lpr=3D22818
pi=3D22780-22817/2 crt=3D22611'65707 lcod 22611'65708 inactive NOTIFY] ente=
r
Start
 -9996> 2019-04-24 04:07:00.490448 7f5e9c18c700  1 osd.219 pg_epoch: 22819
pg[7.1ee8( v 22611'65709 (19416'62700,22611'65709] local-les=3D22799 n=3D21=
7
ec=3D6370 les/c/f 22799/22800/0 22818/22818/22818) [] r=3D-1 lpr=3D22818
pi=3D22780-22817/2 crt=3D22611'65707 lcod 22611'65708 inactive NOTIFY]
state<Start>: transitioning to Stray
 -9995> 2019-04-24 04:07:00.490455 7f5e9c18c700  5 osd.219 pg_epoch: 22819
pg[7.1ee8( v 22611'65709 (19416'62700,22611'65709] local-les=3D22799 n=3D21=
7
ec=3D6370 les/c/f 22799/22800/0 22818/22818/22818) [] r=3D-1 lpr=3D22818
pi=3D22780-22817/2 crt=3D22611'65707 lcod 22611'65708 inactive NOTIFY] exit
Start 0.000012 0 0.000000
 -9994> 2019-04-24 04:07:00.490462 7f5e9c18c700  5 osd.219 pg_epoch: 22819
pg[7.1ee8( v 22611'65709 (19416'62700,22611'65709] local-les=3D22799 n=3D21=
7
ec=3D6370 les/c/f 22799/22800/0 22818/22818/22818) [] r=3D-1 lpr=3D22818
pi=3D22780-22817/2 crt=3D22611'65707 lcod 22611'65708 inactive NOTIFY] ente=
r
Started/Stray

--000000000000be73dc05874609f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">my cluster occur a big e=
rror this morning.<div>many osd suicide because of heartbeat_map timeout.</=
div><div>when I start all osd <a href=3D"http://manually.it">manually.it</a=
> looks well.</div><div><br></div><div>but when I using rbd info for a rbd =
from rbd ls, it say not such file or directory.</div><div>And the I use the=
 way in=C2=A0<a href=3D"https://fnordahl.com/2017/04/17/ceph-rbd-volume-hea=
der-recovery/">https://fnordahl.com/2017/04/17/ceph-rbd-volume-header-recov=
ery/</a>=C2=A0to recovery omap.</div><div><br></div><div>At last,most rbd w=
orks well.But still have 5 rbd can not reocvery.</div><div><br></div><div><=
div>2019-04-24 16:00:40.045342 7fd5fdffb700 -1 librbd::image::OpenRequest: =
failed to retreive immutable metadata: (5) Input/output error</div><div>201=
9-04-24 16:00:40.045419 7fd5fd7fa700 -1 librbd::ImageState: 0x5593262fb830 =
failed to open image: (5) Input/output error</div><div>rbd: error opening i=
mage volume-bef74858-0fcb-4a0b-b197-9618e6824c46: (5) Input/output error</d=
iv></div><div><br></div><div>I try to locate its omap head object, and stop=
 master osd, delete the pg data in master osd, then restart master osd. It =
looks three replication is the same=C2=A0 when I using attr.</div><div><br>=
</div><div>But I can not get the rbd info.Alwayse the vm among this=C2=A0 r=
bd is still alive and works well.</div><div><br></div><div><div>ceph -s</di=
v><div><div>=C2=A0 =C2=A0 cluster 2bec9425-ea5f-4a48-b56a-fe88e126bced</div=
><div>=C2=A0 =C2=A0 =C2=A0health HEALTH_WARN</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 noout flag(s) set</div><div>=C2=A0 =C2=A0 =C2=A0monma=
p e1: 3 mons at {a=3D<a href=3D"http://10.191.175.249:6789/0,b=3D10.191.175=
.250:6789/0,c=3D10.191.175.251:6789/0" target=3D"_blank">10.191.175.249:678=
9/0,b=3D10.191.175.250:6789/0,c=3D10.191.175.251:6789/0</a>}</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 election epoch 26, quorum 0,1,2 a,b,=
c</div><div>=C2=A0 =C2=A0 =C2=A0osdmap e22551: 1080 osds: 1078 up, 1078 in<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags noout,sortbitwise=
,require_jewel_osds</div><div>=C2=A0 =C2=A0 =C2=A0 pgmap v29327873: 90112 p=
gs, 3 pools, 69753 GB data, 30081 kobjects</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 214 TB used, 1500 TB / 1715 TB avail</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A090111 active+clean</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 ac=
tive+clean+scrubbing+deep</div><div>=C2=A0 client io 57082 kB/s rd, 207 MB/=
s wr, 1091 op/s rd, 7658 op/s wr</div></div></div><div><br></div><div>the l=
og of osd.219 which is the firstest log heartbeat no reply.</div><div><br><=
/div><div><div>2019-04-24 04:00:54.905504 7f5eb7fab700=C2=A0 1 heartbeat_ma=
p is_healthy &#39;OSD::osd_op_tp thread 0x7f5e97182700&#39; had timed out a=
fter 15</div><div>...</div><div>2019-04-24 04:00:54.905536 7f5eb7fab700=C2=
=A0 1 heartbeat_map is_healthy &#39;OSD::osd_op_tp thread 0x7f5e9b18a700&#3=
9; had timed out after 15</div><div>2019-04-24 04:00:57.499903 7f5df2997700=
=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855/3169631">10.191.175.20:685=
5/3169631</a> &gt;&gt; <a href=3D"http://10.191.175.33:6947/3001469">10.191=
.175.33:6947/3001469</a> pipe(0x55d93b470800 sd=3D1914 :6855 s=3D2 pgs=3D51=
4958 cs=3D17 l=3D0 c=3D0x55d91a3c1200).fault with nothing to send, going to=
 standby</div><div>... repeat large</div><div>2019-04-24 04:00:57.651603 7f=
5e77735700=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855/3169631">10.191.=
175.20:6855/3169631</a> &gt;&gt; <a href=3D"http://10.191.175.36:6845/10626=
49">10.191.175.36:6845/1062649</a> pipe(0x55d92d2cb400 sd=3D105 :45295 s=3D=
2 pgs=3D493749 cs=3D11 l=3D0 c=3D0x55d943755200).fault with nothing to send=
, going to standby</div><div>2019-04-24 04:00:59.905846 7f5eb7fab700=C2=A0 =
1 heartbeat_map is_healthy &#39;OSD::osd_op_tp thread 0x7f5e97182700&#39; h=
ad timed out after 15</div><div>...</div><div>2019-04-24 04:01:04.666159 7f=
5dbb6d7700=C2=A0 0 -- <a href=3D"http://10.191.175.20:6856/3169631">10.191.=
175.20:6856/3169631</a> &gt;&gt; :/0 pipe(0x55d9234b1400 sd=3D1926 :6856 s=
=3D0 pgs=3D0 cs=3D0 l=3D0 c=3D0x55d924743600).accept failed to getpeername =
(107) Transport endpoint is not connected</div><div>2019-04-24 04:01:04.905=
958 7f5eb7fab700=C2=A0 1 heartbeat_map is_healthy &#39;OSD::osd_op_tp threa=
d 0x7f5e97182700&#39; had timed out after 15</div><div>2019-04-24 04:01:14.=
550812 7f5db7793700=C2=A0 0 -- <a href=3D"http://10.191.175.20:6856/3169631=
">10.191.175.20:6856/3169631</a> &gt;&gt; :/0 pipe(0x55d9234b2800 sd=3D1927=
 :6856 s=3D0 pgs=3D0 cs=3D0 l=3D0 c=3D0x55d924742a00).accept failed to getp=
eername (107) Transport endpoint is not connected</div><div>...</div><div>2=
019-04-24 04:01:14.691430 7f5db7793700=C2=A0 0 -- <a href=3D"http://10.191.=
175.20:6858/3169631">10.191.175.20:6858/3169631</a> &gt;&gt; :/0 pipe(0x55d=
936a78800 sd=3D1383 :6858 s=3D0 pgs=3D0 cs=3D0 l=3D0 c=3D0x55d94ecf5a80).ac=
cept failed to getpeername (107) Transport endpoint is not connected</div><=
div>2019-04-24 04:01:14.692176 7f5e90469700=C2=A0 0 -- <a href=3D"http://10=
.191.175.20:6855/3169631">10.191.175.20:6855/3169631</a> &gt;&gt; <a href=
=3D"http://10.191.175.31:6835/2092007">10.191.175.31:6835/2092007</a> pipe(=
0x55d93c41a800 sd=3D67 :17328 s=3D2 pgs=3D571754 cs=3D83 l=3D0 c=3D0x55d939=
913180).fault, initiating reconnect</div><div>2019-04-24 04:01:14.693742 7f=
5e4c889700=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855/3169631">10.191.=
175.20:6855/3169631</a> &gt;&gt; <a href=3D"http://10.191.175.31:6835/20920=
07">10.191.175.31:6835/2092007</a> pipe(0x55d93c41a800 sd=3D67 :17766 s=3D1=
 pgs=3D571754 cs=3D84 l=3D0 c=3D0x55d939913180).connect got RESETSESSION</d=
iv><div>2019-04-24 04:01:14.697098 7f5db256c700=C2=A0 0 -- <a href=3D"http:=
//10.191.175.20:6908/169631">10.191.175.20:6908/169631</a> &gt;&gt; :/0 pip=
e(0x55d95606c800 sd=3D352 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0 c=3D0x55d920d795=
00).accept failed to getpeername (107) Transport endpoint is not connected<=
/div><div>2019-04-24 04:01:14.697516 7f5e08523700=C2=A0 0 -- <a href=3D"htt=
p://10.191.175.20:6908/169631">10.191.175.20:6908/169631</a> &gt;&gt; :/0 p=
ipe(0x55d91b30c000 sd=3D1926 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0 c=3D0x55d9263=
cb780).accept failed to getpeername (107) Transport endpoint is not connect=
ed</div><div>...</div><div>2019-04-24 04:01:14.704225 7f5dd7790700=C2=A0 0 =
-- <a href=3D"http://10.191.175.20:6908/169631">10.191.175.20:6908/169631</=
a> &gt;&gt; :/0 pipe(0x55d9531c5400 sd=3D1927 :6908 s=3D0 pgs=3D0 cs=3D0 l=
=3D0 c=3D0x55d9263ca280).accept failed to getpeername (107) Transport endpo=
int is not connected</div><div>2019-04-24 04:01:14.704511 7f5e78c4a700=C2=
=A0 0 -- <a href=3D"http://10.191.175.20:6855/3169631">10.191.175.20:6855/3=
169631</a> &gt;&gt; <a href=3D"http://10.191.175.37:6801/2131766">10.191.17=
5.37:6801/2131766</a> pipe(0x55d939274800 sd=3D507 :10332 s=3D1 pgs=3D60490=
6 cs=3D3 l=3D0 c=3D0x55d925714600).connect got RESETSESSION</div><div>...</=
div><div>2019-04-24 04:01:14.705970 7f5dc4980700=C2=A0 0 -- <a href=3D"http=
://10.191.175.20:6855/3169631">10.191.175.20:6855/3169631</a> &gt;&gt; <a h=
ref=3D"http://10.191.175.38:6833/3181256">10.191.175.38:6833/3181256</a> pi=
pe(0x55d950fed400 sd=3D455 :58907 s=3D1 pgs=3D563194 cs=3D17 l=3D0 c=3D0x55=
d9320a2480).connect got RESETSESSION</div><div>2019-04-24 04:01:14.696315 7=
f5db548e700=C2=A0 0 -- <a href=3D"http://10.191.175.20:6908/169631">10.191.=
175.20:6908/169631</a> &gt;&gt; :/0 pipe(0x55d939e45400 sd=3D1929 :6908 s=
=3D0 pgs=3D0 cs=3D0 l=3D0 c=3D0x55d91b787d80).accept failed to getpeername =
(107) Transport endpoint is not connected</div><div>2019-04-24 04:01:14.708=
160 7f5e808c6700=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855/3169631">1=
0.191.175.20:6855/3169631</a> &gt;&gt; <a href=3D"http://10.191.175.37:6823=
/2160572">10.191.175.37:6823/2160572</a> pipe(0x55d943742800 sd=3D812 :4193=
9 s=3D1 pgs=3D566937 cs=3D1 l=3D0 c=3D0x55d930f82900).connect got RESETSESS=
ION</div><div>2019-04-24 04:01:14.708417 7f5e9a989700=C2=A0 1 heartbeat_map=
 reset_timeout &#39;OSD::osd_op_tp thread 0x7f5e9a989700&#39; had timed out=
 after 15</div><div>...</div><div>2019-04-24 04:01:14.708949 7f5e97983700=
=C2=A0 1 heartbeat_map reset_timeout &#39;OSD::osd_op_tp thread 0x7f5e97983=
700&#39; had timed out after 15</div><div>2019-04-24 04:01:14.709602 7f5e00=
7ac700=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855/3169631">10.191.175.=
20:6855/3169631</a> &gt;&gt; <a href=3D"http://10.191.175.28:6821/1091360">=
10.191.175.28:6821/1091360</a> pipe(0x55d94e69b400 sd=3D1419 :40317 s=3D1 p=
gs=3D566133 cs=3D1 l=3D0 c=3D0x55d938741480).connect got RESETSESSION</div>=
<div>2019-04-24 04:01:14.710727 7f5e07216700=C2=A0 0 -- <a href=3D"http://1=
0.191.175.20:6855/3169631">10.191.175.20:6855/3169631</a> &gt;&gt; <a href=
=3D"http://10.191.175.44:6838/112579">10.191.175.44:6838/112579</a> pipe(0x=
55d946d74800 sd=3D809 :23481 s=3D1 pgs=3D32 cs=3D1 l=3D0 c=3D0x55d94f963a80=
).connect got RESETSESSION</div><div>2019-04-24 04:01:14.712774 7f5e8716c70=
0=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855/3169631">10.191.175.20:68=
55/3169631</a> &gt;&gt; <a href=3D"http://10.191.175.34:6916/1001159">10.19=
1.175.34:6916/1001159</a> pipe(0x55d95be21400 sd=3D189 :55315 s=3D1 pgs=3D5=
33958 cs=3D1 l=3D0 c=3D0x55d935329e00).connect got RESETSESSION</div><div>2=
019-04-24 04:01:14.713262 7f5e90e73700=C2=A0 0 -- <a href=3D"http://10.191.=
175.20:6855/3169631">10.191.175.20:6855/3169631</a> &gt;&gt; <a href=3D"htt=
p://10.191.175.34:6945/1173248">10.191.175.34:6945/1173248</a> pipe(0x55d94=
47e8000 sd=3D99 :37118 s=3D1 pgs=3D556344 cs=3D1 l=3D0 c=3D0x55d91ff36700).=
connect got RESETSESSION</div><div>2019-04-24 04:01:14.717779 7f5e87a75700=
=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855/3169631">10.191.175.20:685=
5/3169631</a> &gt;&gt; <a href=3D"http://10.191.175.26:6930/1101469">10.191=
.175.26:6930/1101469</a> pipe(0x55d92c171400 sd=3D183 :23002 s=3D1 pgs=3D59=
0456 cs=3D1 l=3D0 c=3D0x55d94e748580).connect got RESETSESSION</div><div>20=
19-04-24 04:01:14.717778 7f5db2f5d700=C2=A0 0 -- <a href=3D"http://10.191.1=
75.20:6908/169631">10.191.175.20:6908/169631</a> &gt;&gt; :/0 pipe(0x55d948=
732800 sd=3D1936 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0 c=3D0x55d9276cd680).accep=
t failed to getpeername (107) Transport endpoint is not connected</div><div=
>2019-04-24 04:01:14.717885 7f5e8a409700=C2=A0 0 -- <a href=3D"http://10.19=
1.175.20:6855/3169631">10.191.175.20:6855/3169631</a> &gt;&gt; <a href=3D"h=
ttp://10.191.175.41:6827/2071106">10.191.175.41:6827/2071106</a> pipe(0x55d=
93cc55400 sd=3D165 :48272 s=3D1 pgs=3D578891 cs=3D1 l=3D0 c=3D0x55d93d4aca0=
0).connect got RESETSESSION</div><div>2019-04-24 04:01:14.717982 7f5e3dfa17=
00=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855/3169631">10.191.175.20:6=
855/3169631</a> &gt;&gt; <a href=3D"http://10.191.175.54:6851/2123643">10.1=
91.175.54:6851/2123643</a> pipe(0x55d920934000 sd=3D383 :42585 s=3D1 pgs=3D=
574915 cs=3D1 l=3D0 c=3D0x55d928482d00).connect got RESETSESSION</div><div>=
2019-04-24 04:01:14.718139 7f5e513d4700=C2=A0 0 -- <a href=3D"http://10.191=
.175.20:6855/3169631">10.191.175.20:6855/3169631</a> &gt;&gt; <a href=3D"ht=
tp://10.191.175.42:6861/3118363">10.191.175.42:6861/3118363</a> pipe(0x55d9=
3dcb0000 sd=3D808 :45616 s=3D1 pgs=3D492641 cs=3D1 l=3D0 c=3D0x55d930cf9800=
).connect got RESETSESSION</div><div>2019-04-24 04:01:14.718191 7f5db4b6b70=
0=C2=A0 0 -- <a href=3D"http://10.191.175.20:6908/169631">10.191.175.20:690=
8/169631</a> &gt;&gt; :/0 pipe(0x55d934596000 sd=3D1932 :6908 s=3D0 pgs=3D0=
 cs=3D0 l=3D0 c=3D0x55d92f572000).accept failed to getpeername (107) Transp=
ort endpoint is not connected</div><div>2019-04-24 04:01:14.719112 7f5e8dc4=
1700=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855/3169631">10.191.175.20=
:6855/3169631</a> &gt;&gt; <a href=3D"http://10.191.175.30:6815/3154304">10=
.191.175.30:6815/3154304</a> pipe(0x55d946d73400 sd=3D545 :54330 s=3D1 pgs=
=3D552367 cs=3D1 l=3D0 c=3D0x55d94f019180).connect got RESETSESSION</div><d=
iv>2019-04-24 04:01:14.719200 7f5e07715700=C2=A0 0 -- <a href=3D"http://10.=
191.175.20:6908/169631">10.191.175.20:6908/169631</a> &gt;&gt; :/0 pipe(0x5=
5d9234b1400 sd=3D1935 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0 c=3D0x55d92345c700).=
accept failed to getpeername (107) Transport endpoint is not connected</div=
><div>2019-04-24 04:01:14.719295 7f5ea5ac1700=C2=A0 0 -- <a href=3D"http://=
10.191.175.20:6908/169631">10.191.175.20:6908/169631</a> &gt;&gt; :/0 pipe(=
0x55d9234b2800 sd=3D1934 :6908 s=3D0 pgs=3D0 cs=3D0 l=3D0 c=3D0x55d941d0a78=
0).accept failed to getpeername (107) Transport endpoint is not connected</=
div><div>2019-04-24 04:01:14.719556 7f5e97182700=C2=A0 1 heartbeat_map rese=
t_timeout &#39;OSD::osd_op_tp thread 0x7f5e97182700&#39; had timed out afte=
r 15</div><div>=E3=80=82=E3=80=82=E3=80=82=E3=80=82</div><div>2019-04-24 04=
:01:14.731783 7f5e8a70c700=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855/=
3169631">10.191.175.20:6855/3169631</a> &gt;&gt; <a href=3D"http://10.191.1=
75.47:6890/1064637">10.191.175.47:6890/1064637</a> pipe(0x55d93cc56800 sd=
=3D164 :56146 s=3D1 pgs=3D493037 cs=3D1 l=3D0 c=3D0x55d93d4ad600).connect g=
ot RESETSESSION</div><div>2019-04-24 04:01:14.731789 7f5e22f8c700=C2=A0 0 -=
- <a href=3D"http://10.191.175.20:6855/3169631">10.191.175.20:6855/3169631<=
/a> &gt;&gt; <a href=3D"http://10.191.175.35:6818/1109909">10.191.175.35:68=
18/1109909</a> pipe(0x55d93b319400 sd=3D300 :48698 s=3D1 pgs=3D555765 cs=3D=
1 l=3D0 c=3D0x55d925407500).connect got RESETSESSION</div><div>2019-04-24 0=
4:01:14.732623 7f5e2419e700=C2=A0 0 -- <a href=3D"http://10.191.175.20:6855=
/3169631">10.191.175.20:6855/3169631</a> &gt;&gt; <a href=3D"http://10.191.=
175.29:6956/2086678">10.191.175.29:6956/2086678</a> pipe(0x55d94b9cc800 sd=
=3D1070 :42700 s=3D1 pgs=3D582448 cs=3D1 l=3D0 c=3D0x55d94ef83b00).connect =
got RESETSESSION</div><div>2019-04-24 04:01:14.792353 7f5eb2c35700 -1 osd.2=
19 22611 heartbeat_check: no reply from <a href=3D"http://10.191.175.20:686=
1">10.191.175.20:6861</a> osd.218 since back 2019-04-24 04:00:33.420027 fro=
nt 2019-04-24 04:00:33.420027 (cutoff 2019-04-24 04:00:54.792349)</div><div=
>... large amount of no reply</div><div>2019-04-24 04:01:14.810961 7f5eb2c3=
5700 -1 osd.219 22611 heartbeat_check: no reply from <a href=3D"http://10.1=
91.175.55:6896">10.191.175.55:6896</a> osd.1069 since back 2019-04-24 04:00=
:33.420027 front 2019-04-24 04:00:33.420027 (cutoff 2019-04-24 04:00:54.792=
349)</div><div>2019-04-24 04:01:14.810972 7f5eb2c35700 -1 osd.219 22611 hea=
rtbeat_check: no reply from <a href=3D"http://10.191.175.55:6807">10.191.17=
5.55:6807</a> osd.1072 since back 2019-04-24 04:00:33.420027 front 2019-04-=
24 04:00:33.420027 (cutoff 2019-04-24 04:00:54.792349)</div><div>2019-04-24=
 04:01:14.820935 7f5e9a188700=C2=A0 0 -- <a href=3D"http://10.191.175.20:69=
08/169631">10.191.175.20:6908/169631</a> submit_message osd_op_reply(110357=
0 rbd_header.b0bc14677ca78c [watch ping cookie 140029489856640 gen 1] v0&#3=
9;0 uv0 ondisk =3D -107 ((107) Transport endpoint is not connected)) v7 rem=
ote, <a href=3D"http://10.191.122.251:0/1594377730">10.191.122.251:0/159437=
7730</a>, failed lossy con, dropping message 0x55d957747600</div><div>2019-=
04-24 04:01:14.821340 7f5eb2c35700=C2=A0 0 log_channel(cluster) log [WRN] :=
 69 slow requests, 5 included below; oldest blocked for &gt; 44.042324 secs=
</div><div>2019-04-24 04:01:14.821355 7f5eb2c35700=C2=A0 0 log_channel(clus=
ter) log [WRN] : slow request 37.989255 seconds old, received at 2019-04-24=
 04:00:36.821750: osd_op(client.9569145.0:11357796 7.2339e183 (undecoded) a=
ck+ondisk+write+known_if_redirected e22611) currently queued_for_pg</div><d=
iv>...</div><div>2019-04-24 04:10:15.049210 7f5eb7fab700=C2=A0 1 heartbeat_=
map is_healthy &#39;OSD::osd_tp thread 0x7f5e9c98d700&#39; had timed out af=
ter 15</div><div>2019-04-24 04:10:15.049213 7f5eb7fab700=C2=A0 1 heartbeat_=
map is_healthy &#39;OSD::osd_tp thread 0x7f5e9c98d700&#39; had suicide time=
d out after 150</div><div>2019-04-24 04:10:15.159190 7f5eb7fab700 -1 common=
/HeartbeatMap.cc: In function &#39;bool ceph::HeartbeatMap::_check(const ce=
ph::heartbeat_handle_d*, const char*, time_t)&#39; thread 7f5eb7fab70</div>=
<div>0 time 2019-04-24 04:10:15.049507</div><div>common/HeartbeatMap.cc: 86=
: FAILED assert(0 =3D=3D &quot;hit suicide timeout&quot;)</div><div><br></d=
iv><div>=C2=A0ceph version 10.2.10 (5dc1e4c05cb68dbf62ae6fce3f0700e4654fdbb=
e)</div><div>=C2=A01: (ceph::__ceph_assert_fail(char const*, char const*, i=
nt, char const*)+0x82) [0x55d909a9ae12]</div><div>=C2=A02: (ceph::Heartbeat=
Map::_check(ceph::heartbeat_handle_d const*, char const*, long)+0x11f) [0x5=
5d9099d2f4f]</div><div>=C2=A03: (ceph::HeartbeatMap::is_healthy()+0xd6) [0x=
55d9099d3976]</div><div>=C2=A04: (ceph::HeartbeatMap::check_touch_file()+0x=
2a) [0x55d9099d418a]</div><div>=C2=A05: (CephContextServiceThread::entry()+=
0x16c) [0x55d909ab4edc]</div><div>=C2=A06: (()+0x8064) [0x7f5ebc5dc064]</di=
v><div>=C2=A07: (clone()+0x6d) [0x7f5eba6dd62d]</div><div>=C2=A0NOTE: a cop=
y of the executable, or `objdump -rdS &lt;executable&gt;` is needed to inte=
rpret this.</div><div><br></div><div>--- begin dump of recent events ---</d=
iv><div>-10000&gt; 2019-04-24 04:07:00.490378 7f5e9c18c700=C2=A0 5 osd.219 =
pg_epoch: 22818 pg[7.1ee8( v 22611&#39;65709 (19416&#39;62700,22611&#39;657=
09] local-les=3D22799 n=3D217 ec=3D6370 les/c/f 22799/22800/0 22804/22804/2=
2804) [437,1013] r=3D-1 lpr=3D22804 pi=3D22780-22803/1 crt=3D22611&#39;6570=
7 lcod 22611&#39;65708 inactive NOTIFY] enter Reset</div><div>=C2=A0-9999&g=
t; 2019-04-24 04:07:00.490427 7f5e9c18c700=C2=A0 5 osd.219 pg_epoch: 22819 =
pg[7.1ee8( v 22611&#39;65709 (19416&#39;62700,22611&#39;65709] local-les=3D=
22799 n=3D217 ec=3D6370 les/c/f 22799/22800/0 22818/22818/22818) [] r=3D-1 =
lpr=3D22818 pi=3D22780-22817/2 crt=3D22611&#39;65707 lcod 22611&#39;65708 i=
nactive NOTIFY] exit Reset 0.000049 2 0.000045</div><div>=C2=A0-9998&gt; 20=
19-04-24 04:07:00.490437 7f5e9c18c700=C2=A0 5 osd.219 pg_epoch: 22819 pg[7.=
1ee8( v 22611&#39;65709 (19416&#39;62700,22611&#39;65709] local-les=3D22799=
 n=3D217 ec=3D6370 les/c/f 22799/22800/0 22818/22818/22818) [] r=3D-1 lpr=
=3D22818 pi=3D22780-22817/2 crt=3D22611&#39;65707 lcod 22611&#39;65708 inac=
tive NOTIFY] enter Started</div><div>=C2=A0-9997&gt; 2019-04-24 04:07:00.49=
0443 7f5e9c18c700=C2=A0 5 osd.219 pg_epoch: 22819 pg[7.1ee8( v 22611&#39;65=
709 (19416&#39;62700,22611&#39;65709] local-les=3D22799 n=3D217 ec=3D6370 l=
es/c/f 22799/22800/0 22818/22818/22818) [] r=3D-1 lpr=3D22818 pi=3D22780-22=
817/2 crt=3D22611&#39;65707 lcod 22611&#39;65708 inactive NOTIFY] enter Sta=
rt</div><div>=C2=A0-9996&gt; 2019-04-24 04:07:00.490448 7f5e9c18c700=C2=A0 =
1 osd.219 pg_epoch: 22819 pg[7.1ee8( v 22611&#39;65709 (19416&#39;62700,226=
11&#39;65709] local-les=3D22799 n=3D217 ec=3D6370 les/c/f 22799/22800/0 228=
18/22818/22818) [] r=3D-1 lpr=3D22818 pi=3D22780-22817/2 crt=3D22611&#39;65=
707 lcod 22611&#39;65708 inactive NOTIFY] state&lt;Start&gt;: transitioning=
 to Stray</div><div>=C2=A0-9995&gt; 2019-04-24 04:07:00.490455 7f5e9c18c700=
=C2=A0 5 osd.219 pg_epoch: 22819 pg[7.1ee8( v 22611&#39;65709 (19416&#39;62=
700,22611&#39;65709] local-les=3D22799 n=3D217 ec=3D6370 les/c/f 22799/2280=
0/0 22818/22818/22818) [] r=3D-1 lpr=3D22818 pi=3D22780-22817/2 crt=3D22611=
&#39;65707 lcod 22611&#39;65708 inactive NOTIFY] exit Start 0.000012 0 0.00=
0000</div><div>=C2=A0-9994&gt; 2019-04-24 04:07:00.490462 7f5e9c18c700=C2=
=A0 5 osd.219 pg_epoch: 22819 pg[7.1ee8( v 22611&#39;65709 (19416&#39;62700=
,22611&#39;65709] local-les=3D22799 n=3D217 ec=3D6370 les/c/f 22799/22800/0=
 22818/22818/22818) [] r=3D-1 lpr=3D22818 pi=3D22780-22817/2 crt=3D22611&#3=
9;65707 lcod 22611&#39;65708 inactive NOTIFY] enter Started/Stray</div><div=
>=C2=A0</div></div></div></div></div>

--000000000000be73dc05874609f7--

--===============6479710305964019524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6479710305964019524==--
