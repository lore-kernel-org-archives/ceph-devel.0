From: "Bernhard Glomm" <bernhard.glomm-uSuf018nij3sq35pWSNszA@public.gmane.org>
Subject: how to remove and re-add broken mon?
Date: Wed, 04 Sep 2013 10:40:04 +0000
Message-ID: <ee15755bb1292a720a84f58fdc80a31f7a75fd64@ecologic.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1793433499=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1793433499==
Content-Type: multipart/alternative; charset=UTF-8;
 boundary="=_68795574ee35b5261228031457b5d15d"

--=_68795574ee35b5261228031457b5d15d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,=0A=0Aafter some days of successful creating and destroying rbd's=
, snapshots,=0Aclones and migrating formats all of a sudden one of the m=
onitors doesn't work anymore.=0AI tried to remove and re-add the monitor=
 from the cluster, but that doesn't seem to work either.=0A=0AHere's the=
 situation:=0AI liked to use ceph-deploy to initiate the cluster.=0ADue=
 to the broken ceph-create-keys in dumpling I turned to the gitbuilder v=
ersion=0Anow running=0A=0Aceph version 0.67.2-23-g24f2669 (24f2669783e2e=
b9d9af5ecbe106efed93366ba63)=0Aon uptodate raring systems=0AAll of a sud=
den the host from which I ran ceph-deploy, and which should be one of th=
e =0A5 monitors (from which 2 are also serving as OSDs) has fallen out o=
f the quorum as you can see here=0A(yes, time is in sync on all nodes):=
=0A=0A------------------=0Aroot@nuke36[/0]:~ # ceph -s=0A2013-09-04 11:0=
9:56.039547 7f7a8820f700=C2=A0 1 -- :/0 messenger.start=0A2013-09-04 11:=
09:56.040646 7f7a8820f700=C2=A0 1 -- :/1016260 --> 192.168.242.92:6789/0=
 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f7a8000e8f0 con 0x7f7a80=
00e4e0=0A2013-09-04 11:09:56.041304 7f7a84a08700=C2=A0 1 -- 192.168.242.=
36:0/1016260 learned my addr 192.168.242.36:0/1016260=0A2013-09-04 11:09=
:56.042843 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=3D=3D mon.=
3 192.168.242.92:6789/0 1 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 776+0+0 (=
2241333437 0 0) 0x7f7a70000c30 con 0x7f7a8000e4e0=0A2013-09-04 11:09:56.=
043038 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=3D=3D mon.3 19=
2.168.242.92:6789/0 2 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=
=3D=3D=3D 33+0+0 (2063715990 0 0) 0x7f7a70001060 con 0x7f7a8000e4e0=0A20=
13-09-04 11:09:56.043324 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/101626=
0 --> 192.168.242.92:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0=
 0x7f7a74001af0 con 0x7f7a8000e4e0=0A2013-09-04 11:09:56.044197 7f7a86a0=
c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=3D=3D mon.3 192.168.242.92:67=
89/0 3 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=3D=3D=3D 206+0+=
0 (3910749728 0 0) 0x7f7a70001060 con 0x7f7a8000e4e0=0A2013-09-04 11:09:=
56.044375 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260 --> 192.168.2=
42.92:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0 0x7f7a740020d0=
 con 0x7f7a8000e4e0=0A2013-09-04 11:09:56.045376 7f7a86a0c700=C2=A0 1 --=
 192.168.242.36:0/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 4 =3D=3D=
=3D=3D auth_reply(proto 2 0 Success) v1 =3D=3D=3D=3D 393+0+0 (3802320753=
 0 0) 0x7f7a700008f0 con 0x7f7a8000e4e0=0A2013-09-04 11:09:56.045457 7f7=
a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260 --> 192.168.242.92:6789/0=
 -- mon_subscribe({monmap=3D0+}) v2 -- ?+0 0x7f7a8000ed80 con 0x7f7a8000=
e4e0=0A2013-09-04 11:09:56.045550 7f7a8820f700=C2=A0 1 -- 192.168.242.36=
:0/1016260 --> 192.168.242.92:6789/0 -- mon_subscribe({monmap=3D2+,osdma=
p=3D0}) v2 -- ?+0 0x7f7a800079f0 con 0x7f7a8000e4e0=0A2013-09-04 11:09:5=
6.045559 7f7a8820f700=C2=A0 1 -- 192.168.242.36:0/1016260 --> 192.168.24=
2.92:6789/0 -- mon_subscribe({monmap=3D2+,osdmap=3D0}) v2 -- ?+0 0x7f7a8=
000fa10 con 0x7f7a8000e4e0=0A2013-09-04 11:09:56.046376 7f7a86a0c700=C2=
=A0 1 -- 192.168.242.36:0/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 5=
 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 776+0+0 (2241333437 0 0) 0x7f7a700=
01290 con 0x7f7a8000e4e0=0A2013-09-04 11:09:56.046417 7f7a86a0c700=C2=A0=
 1 -- 192.168.242.36:0/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 6 =3D=
=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (1524320885 0 0=
) 0x7f7a70001480 con 0x7f7a8000e4e0=0A2013-09-04 11:09:56.046429 7f7a86a=
0c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=3D=3D mon.3 192.168.242.92:6=
789/0 7 =3D=3D=3D=3D osd_map(22..22 src has 1..22) v3 =3D=3D=3D=3D 2355+=
0+0 (11792226 0 0) 0x7f7a70001f70 con 0x7f7a8000e4e0=0A2013-09-04 11:09:=
56.046828 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=3D=3D mon.3=
 192.168.242.92:6789/0 8 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=
=3D=3D 20+0+0 (1524320885 0 0) 0x7f7a700008f0 con 0x7f7a8000e4e0=0A2013-=
09-04 11:09:56.046948 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=
=3D=3D mon.3 192.168.242.92:6789/0 9 =3D=3D=3D=3D osd_map(22..22 src has=
 1..22) v3 =3D=3D=3D=3D 2355+0+0 (11792226 0 0) 0x7f7a700008c0 con 0x7f7=
a8000e4e0=0A2013-09-04 11:09:56.047071 7f7a86a0c700=C2=A0 1 -- 192.168.2=
42.36:0/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 10 =3D=3D=3D=3D mon_=
subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (1524320885 0 0) 0x7f7a70000d=
f0 con 0x7f7a8000e4e0=0A2013-09-04 11:09:56.047547 7f7a8820f700=C2=A0 1=
 -- 192.168.242.36:0/1016260 --> 192.168.242.92:6789/0 -- mon_command({"=
prefix": "get_command_descriptions"} v 0) v1 -- ?+0 0x7f7a8000b0f0 con 0=
x7f7a8000e4e0=0A2013-09-04 11:09:56.050938 7f7a86a0c700=C2=A0 1 -- 192.1=
68.242.36:0/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 11 =3D=3D=3D=3D=
 mon_command_ack([{"prefix": "get_command_descriptions"}]=3D0=C2=A0 v0)=
 v1 =3D=3D=3D=3D 72+0+24040 (1092875540 0 2922658865) 0x7f7a700008c0 con=
 0x7f7a8000e4e0=0A2013-09-04 11:09:56.089981 7f7a8820f700=C2=A0 1 -- 192=
.168.242.36:0/1016260 --> 192.168.242.92:6789/0 -- mon_command({"prefix"=
: "status"} v 0) v1 -- ?+0 0x7f7a8000b0d0 con 0x7f7a8000e4e0=0A2013-09-0=
4 11:09:56.091348 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=3D=
=3D mon.3 192.168.242.92:6789/0 12 =3D=3D=3D=3D mon_command_ack([{"prefi=
x": "status"}]=3D0=C2=A0 v0) v1 =3D=3D=3D=3D 54+0+558 (1155462804 0 1174=
924833) 0x7f7a70000db0 con 0x7f7a8000e4e0=0A=C2=A0 cluster b085fba3-8e17=
-443c-bb61-7758504538f8=0A=C2=A0=C2=A0 health HEALTH_WARN 1 mons down, q=
uorum 0,1,3,4 atom01,atom02,ping,pong=0A=C2=A0=C2=A0 monmap e1: 5 mons a=
t {atom01=3D192.168.242.31:6789/0,atom02=3D192.168.242.32:6789/0,nuke36=
=3D192.168.242.36:6789/0,ping=3D192.168.242.92:6789/0,pong=3D192.168.242=
.93:6789/0}, election epoch 26, quorum 0,1,3,4 atom01,atom02,ping,pong=
=0A=C2=A0=C2=A0 osdmap e22: 2 osds: 2 up, 2 in=0A=C2=A0=C2=A0=C2=A0 pgma=
p v46761: 1192 pgs: 1192 active+clean; 7806 MB data, 20618 MB used, 3702=
 GB / 3722 GB avail; 9756B/s wr, 0op/s=0A=C2=A0=C2=A0 mdsmap e17: 1/1/1=
 up {0=3Dpong=3Dup:active}, 1 up:standby=0A=0A2013-09-04 11:09:56.096071=
 7f7a8820f700=C2=A0 1 -- 192.168.242.36:0/1016260 mark_down 0x7f7a8000e4=
e0 -- 0x7f7a8000e280=0A2013-09-04 11:09:56.096516 7f7a8820f700=C2=A0 1 -=
- 192.168.242.36:0/1016260 mark_down_all=0A2013-09-04 11:09:56.097065 7f=
7a8820f700=C2=A0 1 -- 192.168.242.36:0/1016260 shutdown complete.=0A----=
--------------=0A=0Athis is the ceph.conf that was generated during ceph=
-deploy (well I added the debug lines obviously)=0A=0A------------------=
=0Aroot@nuke36[/0]:~ # cat /etc/ceph/ceph.conf =0A[global]=0Afsid =3D b0=
85fba3-8e17-443c-bb61-7758504538f8=0Amon_initial_members =3D ping, pong,=
 nuke36, atom01, atom02=0Amon_host =3D 192.168.242.92,192.168.242.93,192=
.168.242.36,192.168.242.31,192.168.242.32=0Aauth_supported =3D cephx=0Ao=
sd_journal_size =3D 1024=0Afilestore_xattr_use_omap =3D true=0Adebug ms=
 =3D 1=0Adebug mon =3D 20=0A------------------=0A=0Aafter a reboot of th=
e node I now find=0A=0A------------------=0Aroot@nuke36[/1]:~ # ps ax |=
 egrep ceph=0A=C2=A0 855 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ssl=
=C2=A0=C2=A0=C2=A0 0:00 /usr/bin/ceph-mon --cluster=3Dceph -i nuke36 -f=
=0A=C2=A0 856 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ss=C2=A0=C2=A0=
=C2=A0=C2=A0 0:00 /usr/bin/python /usr/sbin/ceph-create-keys --cluster=
=3Dceph -i nuke36=0A=C2=A01813 pts/1=C2=A0=C2=A0=C2=A0 R+=C2=A0=C2=A0=C2=
=A0=C2=A0 0:00 egrep --color=3Dauto ceph=0A------------------=0A=0Awith=
 ceph-create-keys runing infinetly,=0Awhile the key files but already ex=
ist=0A=0A------------------=0Aroot@nuke36[/1]:~ # ls -lh /etc/ceph/=0Ato=
tal 88K=0A-rw-r--r-- 1 root root=C2=A0 72 Aug 30 15:54 ceph.bootstrap-md=
s.keyring=0A-rw-r--r-- 1 root root=C2=A0 72 Aug 30 15:54 ceph.bootstrap-=
osd.keyring=0A-rw------- 1 root root=C2=A0 64 Aug 30 15:54 ceph.client.a=
dmin.keyring=0A-rw-r--r-- 1 root root 303 Sep=C2=A0 4 10:19 ceph.conf=0A=
-rw-r--r-- 1 root root 59K Sep=C2=A0 3 10:15 ceph.log=0A-rw-r--r-- 1 roo=
t root=C2=A0 73 Aug 30 15:53 ceph.mon.keyring=0A-rw-r--r-- 1 root root=
=C2=A0 92 Aug 30 00:03 rbdmap=0A------------------=0A=0Aand=0A=0A-------=
-----------=0Aroot@nuke36[/1]:~ # tree -pfugiAD /var/lib/ceph/=0A/var/li=
b/ceph=0A[drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=
=C2=A0 Aug 30 15:54]=C2=A0 /var/lib/ceph/bootstrap-mds=0A[-rw------- roo=
t=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=
=A0 /var/lib/ceph/bootstrap-mds/ceph.keyring=0A[drwxr-xr-x root=C2=A0=C2=
=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=A0 /var/li=
b/ceph/bootstrap-osd=0A[-rw------- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=
=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=A0 /var/lib/ceph/bootstrap-osd/ce=
ph.keyring=0A[drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=
=C2=A0=C2=A0 Aug 30=C2=A0 0:00]=C2=A0 /var/lib/ceph/mds=0A[drwxr-xr-x ro=
ot=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=
=A0 /var/lib/ceph/mon=0A[drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=
=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-nuke36=
=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/done=0A[-rw-r--r-- ro=
ot=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=
=A0 /var/lib/ceph/mon/ceph-nuke36/keyring=0A[drwxr-xr-x root=C2=A0=C2=A0=
=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:16]=C2=A0 /var/=
lib/ceph/mon/ceph-nuke36/store.db=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=
=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 3=C2=A0 6:21]=C2=A0 /var/l=
ib/ceph/mon/ceph-nuke36/store.db/007726.sst=0A[-rw-r--r-- root=C2=A0=C2=
=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 3=C2=A0 6:21]=C2=
=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007727.sst=0A[-rw-r--r-- root=
=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 3=C2=A0=
 6:21]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007728.sst=0A[-rw-r-=
-r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0=
 3=C2=A0 6:21]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007729.sst=
=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=
 Sep=C2=A0 3=C2=A0 6:21]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/00=
7730.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.d=
b/007767.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=
=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/stor=
e.db/007768.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=
=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/s=
tore.db/007769.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=
=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ceph-nuke3=
6/store.db/007770.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=
=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ceph-nu=
ke36/store.db/007772.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=
=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ceph=
-nuke36/store.db/007773.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 r=
oot=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/c=
eph-nuke36/store.db/007774.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=
=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/=
mon/ceph-nuke36/store.db/007775.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=
=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:18]=C2=A0 /var/lib/ce=
ph/mon/ceph-nuke36/store.db/007777.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=
=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:19]=C2=A0 /var/lib=
/ceph/mon/ceph-nuke36/store.db/007780.sst=0A[-rw-r--r-- root=C2=A0=C2=A0=
=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:16]=C2=A0 /var/=
lib/ceph/mon/ceph-nuke36/store.db/007783.sst=0A[-rw-r--r-- root=C2=A0=C2=
=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:16]=C2=A0 /v=
ar/lib/ceph/mon/ceph-nuke36/store.db/007784.log=0A[-rw-r--r-- root=C2=A0=
=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:16]=C2=A0=
 /var/lib/ceph/mon/ceph-nuke36/store.db/CURRENT=0A[-rw-r--r-- root=C2=A0=
=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var=
/lib/ceph/mon/ceph-nuke36/store.db/LOCK=0A[-rw-r--r-- root=C2=A0=C2=A0=
=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:16]=C2=A0 /var/=
lib/ceph/mon/ceph-nuke36/store.db/LOG=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=
=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:19]=C2=A0 /var/lib=
/ceph/mon/ceph-nuke36/store.db/LOG.old=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=
=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:16]=C2=A0 /var/lib=
/ceph/mon/ceph-nuke36/store.db/MANIFEST-007782=0A[-rw-r--r-- root=C2=A0=
=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var=
/lib/ceph/mon/ceph-nuke36/upstart=0A[drwxr-xr-x root=C2=A0=C2=A0=C2=A0=
=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30=C2=A0 0:00]=C2=A0 /var/lib/ce=
ph/osd=0A[drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=
=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/tmp=0A------------------=0A=0At=
o compare with atom01 which is still running in the cluster...=0A=0A----=
--------------=0Aroot@atom01[/0]:~ # tree -pfugiAD /var/lib/ceph/=0A/var=
/lib/ceph=0A[drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0 Aug 30 15:54]=C2=A0 /var/lib/ceph/bootstrap-mds=0A[-rw-------=
 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:54]=
=C2=A0 /var/lib/ceph/bootstrap-mds/ceph.keyring=0A[drwxr-xr-x root=C2=A0=
=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=A0 /var=
/lib/ceph/bootstrap-osd=0A[-rw------- root=C2=A0=C2=A0=C2=A0=C2=A0 root=
=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=A0 /var/lib/ceph/bootstrap-osd=
/ceph.keyring=0A[drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=
=A0=C2=A0=C2=A0 Aug 30=C2=A0 0:00]=C2=A0 /var/lib/ceph/mds=0A[drwxr-xr-x=
 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=
=C2=A0 /var/lib/ceph/mon=0A[drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=
=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-atom=
01=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=
=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-atom01/done=0A[-rw-r--r--=
 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=
=C2=A0 /var/lib/ceph/mon/ceph-atom01/keyring=0A[drwxr-xr-x root=C2=A0=C2=
=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=A0 /v=
ar/lib/ceph/mon/ceph-atom01/store.db=0A[-rw-r--r-- root=C2=A0=C2=A0=C2=
=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:25]=C2=A0 /var/lib=
/ceph/mon/ceph-atom01/store.db/006339.log=0A[-rw-r--r-- root=C2=A0=C2=A0=
=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=A0 /var/=
lib/ceph/mon/ceph-atom01/store.db/006342.sst=0A[-rw-r--r-- root=C2=A0=C2=
=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=A0 /v=
ar/lib/ceph/mon/ceph-atom01/store.db/006343.sst=0A[-rw-r--r-- root=C2=A0=
=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=A0=
 /var/lib/ceph/mon/ceph-atom01/store.db/006344.sst=0A[-rw-r--r-- root=C2=
=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=
=A0 /var/lib/ceph/mon/ceph-atom01/store.db/006345.sst=0A[-rw-r--r-- root=
=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=
=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/006346.sst=0A[-rw-r--r-- r=
oot=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:=
18]=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/006347.sst=0A[-rw-r--r-=
- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4=
 11:18]=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/006348.sst=0A[-rw-r=
--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 1=
5:53]=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/CURRENT=0A[-rw-r--r--=
 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=
=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/LOCK=0A[-rw-r--r-- root=C2=
=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=
=A0 /var/lib/ceph/mon/ceph-atom01/store.db/LOG=0A[-rw-r--r-- root=C2=A0=
=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var=
/lib/ceph/mon/ceph-atom01/store.db/LOG.old=0A[-rw-r--r-- root=C2=A0=C2=
=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=A0 /v=
ar/lib/ceph/mon/ceph-atom01/store.db/MANIFEST-000004=0A[-rw-r--r-- root=
=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=
=A0 /var/lib/ceph/mon/ceph-atom01/upstart=0A[drwxr-xr-x root=C2=A0=C2=A0=
=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30=C2=A0 0:00]=C2=A0 /var/=
lib/ceph/osd=0A[drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=
=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/tmp=0A------------------=
=0A=0Athe problem with ceph-create-keys seemed to have been fixed with w=
ip-4924=0Asince in that version "rbd create" wouldn't work I switched to=
=0Adeb http://gitbuilder.ceph.com/ceph-deb-raring-x86_64-basic/ref/dumpl=
ing/=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raring main=0A(runing on an upt=
odate raring)=0AI thought of just removing and than re-adding the failin=
g mon but who do I do that?=0AThe documentation on=0Ahttp://ceph.com/doc=
s/master/rados/operations/add-or-rm-mons/=0Asays:=0A"service ceph -a sto=
p mon.{mon-id}"=0A=0A------------------=0Aroot@nuke36[/1]:~ # service ce=
ph -a stop mon.nuke36=0A/etc/init.d/ceph: mon.nuke36 not found (/etc/cep=
h/ceph.conf defines , /var/lib/ceph defines )=0Aroot@nuke36[/1]:~ # serv=
ice ceph -a stop mon.c=0A/etc/init.d/ceph: mon.c not found (/etc/ceph/ce=
ph.conf defines , /var/lib/ceph defines )=0Aroot@nuke36[/1]:~ # service=
 ceph -a stop mon.2=0A/etc/init.d/ceph: mon.2 not found (/etc/ceph/ceph.=
conf defines , /var/lib/ceph defines )=0Aroot@nuke36[/1]:~ # service cep=
h -a stop mon.ceph-nuke36=0A/etc/init.d/ceph: mon.ceph-nuke36 not found=
 (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )=0A--------------=
----=0A=0Athat doesn't help, manually stopping the daemon doesn't work e=
ither (respawning, okay)=0Abut this combination leaves me quite curious=
=0A=0A------------------=0Aroot@atom01[/0]:~ # ceph health detail=0AHEAL=
TH_WARN 1 mons down, quorum 0,1,3,4 atom01,atom02,ping,pong=0Amon.nuke36=
 (rank 2) addr 192.168.242.36:6789/0 is down (out of quorum)=0Aroot@atom=
01[/0]:~ # service ceph -a stop mon.nuke36=0A/etc/init.d/ceph: mon.nuke3=
6 not found (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )=0A/et=
c/init.d/ceph: mon.2 not found (/etc/ceph/ceph.conf defines , /var/lib/c=
eph defines )=0Aroot@atom01[/0]:~ # service ceph -a stop mon.rank2=0A---=
---------------=0A=0Asomething seems to be out of sync, at least with th=
e documentation?=0Aany hint how to proceed from here?=0A=0ATIA=0A=0ABern=
hard=0A=0A=0A-- =0A=0A=0A  =0A         =0A    =0A        =0A      =0A  =
      =0A          =0A            Bernhard Glomm=0A=0A            IT Adm=
inistration=0A=0A=0A          =0A            =0A                  Phone:=
=0A                =0A                =0A                  +49 (30) 8688=
0 134=0A                =0A              =0A                  Fax:=0A  =
              =0A                =0A                  +49 (30) 86880 100=
=0A                =0A              =0A                  Skype:=0A     =
           =0A                =0A                  bernhard.glomm.ecolog=
ic=0A                =0A              =0A        =0A      =0A    =0A   =
         =0A            =0A            =0A            =0A            =0A=
            =0A            =0A            =0A      =0A    =0A        =0A=
          Ecologic Institut gemeinn=C3=BCtzige GmbH | Pfalzburger Str. 4=
3/44 | 10717 Berlin | Germany=0A=0A          GF: R. Andreas Kraemer | AG=
: Charlottenburg HRB 57947 | USt/VAT-IdNr.: DE811963464=0A=0A          E=
cologic=E2=84=A2 is a Trade Mark (TM) of Ecologic Institut gemeinn=C3=BC=
tzige GmbH=0A        =0A      =0A    =0A         root@nuke=0A=0A

--=_68795574ee35b5261228031457b5d15d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; char=
set=3DUTF-8"><title></title><style type=3D"text/css">.felamimail-body-bl=
ockquote {margin: 5px 10px 0 3px;padding-left: 10px;border-left: 2px sol=
id #000088;} </style></head><body>Hi all,<br><br>after some days of succ=
essful creating and destroying rbd's, snapshots,<br>clones and migrating=
 formats all of a sudden one of the monitors doesn't work anymore.<br>I=
 tried to remove and re-add the monitor from the cluster, but that doesn=
't seem to work either.<br><br>Here's the situation:<br>I liked to use c=
eph-deploy to initiate the cluster.<br>Due to the broken ceph-create-key=
s in dumpling I turned to the gitbuilder version<br>now running<br><br>c=
eph version 0.67.2-23-g24f2669 (24f2669783e2eb9d9af5ecbe106efed93366ba63=
)<br>on uptodate raring systems<br>All of a sudden the host from which I=
 ran ceph-deploy, and which should be one of the <br>5 monitors (from wh=
ich 2 are also serving as OSDs) has fallen out of the quorum as you can=
 see here<br>(yes, time is in sync on all nodes):<br><br>---------------=
---<br>root@nuke36[/0]:~ # ceph -s<br>2013-09-04 11:09:56.039547 7f7a882=
0f700&nbsp; 1 -- :/0 messenger.start<br>2013-09-04 11:09:56.040646 7f7a8=
820f700&nbsp; 1 -- :/1016260 --&gt; 192.168.242.92:6789/0 -- auth(proto=
 0 30 bytes epoch 0) v1 -- ?+0 0x7f7a8000e8f0 con 0x7f7a8000e4e0<br>2013=
-09-04 11:09:56.041304 7f7a84a08700&nbsp; 1 -- 192.168.242.36:0/1016260=
 learned my addr 192.168.242.36:0/1016260<br>2013-09-04 11:09:56.042843=
 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.1=
68.242.92:6789/0 1 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 776+0+0 (2241333=
437 0 0) 0x7f7a70000c30 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.043038=
 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.1=
68.242.92:6789/0 2 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=3D=
=3D=3D 33+0+0 (2063715990 0 0) 0x7f7a70001060 con 0x7f7a8000e4e0<br>2013=
-09-04 11:09:56.043324 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260=
 --&gt; 192.168.242.92:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+=
0 0x7f7a74001af0 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.044197 7f7a86=
a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.=
92:6789/0 3 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=3D=3D=3D 2=
06+0+0 (3910749728 0 0) 0x7f7a70001060 con 0x7f7a8000e4e0<br>2013-09-04=
 11:09:56.044375 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 --&gt;=
 192.168.242.92:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0 0x7f=
7a740020d0 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.045376 7f7a86a0c700=
&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.92:678=
9/0 4 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=3D=3D=3D 393+0+0=
 (3802320753 0 0) 0x7f7a700008f0 con 0x7f7a8000e4e0<br>2013-09-04 11:09:=
56.045457 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 --&gt; 192.16=
8.242.92:6789/0 -- mon_subscribe({monmap=3D0+}) v2 -- ?+0 0x7f7a8000ed80=
 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.045550 7f7a8820f700&nbsp; 1 -=
- 192.168.242.36:0/1016260 --&gt; 192.168.242.92:6789/0 -- mon_subscribe=
({monmap=3D2+,osdmap=3D0}) v2 -- ?+0 0x7f7a800079f0 con 0x7f7a8000e4e0<b=
r>2013-09-04 11:09:56.045559 7f7a8820f700&nbsp; 1 -- 192.168.242.36:0/10=
16260 --&gt; 192.168.242.92:6789/0 -- mon_subscribe({monmap=3D2+,osdmap=
=3D0}) v2 -- ?+0 0x7f7a8000fa10 con 0x7f7a8000e4e0<br>2013-09-04 11:09:5=
6.046376 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon=
.3 192.168.242.92:6789/0 5 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 776+0+0=
 (2241333437 0 0) 0x7f7a70001290 con 0x7f7a8000e4e0<br>2013-09-04 11:09:=
56.046417 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mo=
n.3 192.168.242.92:6789/0 6 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=
=3D=3D=3D 20+0+0 (1524320885 0 0) 0x7f7a70001480 con 0x7f7a8000e4e0<br>2=
013-09-04 11:09:56.046429 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/10162=
60 &lt;=3D=3D mon.3 192.168.242.92:6789/0 7 =3D=3D=3D=3D osd_map(22..22=
 src has 1..22) v3 =3D=3D=3D=3D 2355+0+0 (11792226 0 0) 0x7f7a70001f70 c=
on 0x7f7a8000e4e0<br>2013-09-04 11:09:56.046828 7f7a86a0c700&nbsp; 1 --=
 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.92:6789/0 8 =3D=
=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (1524320885 0 0=
) 0x7f7a700008f0 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.046948 7f7a86=
a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.=
92:6789/0 9 =3D=3D=3D=3D osd_map(22..22 src has 1..22) v3 =3D=3D=3D=3D 2=
355+0+0 (11792226 0 0) 0x7f7a700008c0 con 0x7f7a8000e4e0<br>2013-09-04 1=
1:09:56.047071 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=
=3D mon.3 192.168.242.92:6789/0 10 =3D=3D=3D=3D mon_subscribe_ack(300s)=
 v1 =3D=3D=3D=3D 20+0+0 (1524320885 0 0) 0x7f7a70000df0 con 0x7f7a8000e4=
e0<br>2013-09-04 11:09:56.047547 7f7a8820f700&nbsp; 1 -- 192.168.242.36:=
0/1016260 --&gt; 192.168.242.92:6789/0 -- mon_command({"prefix": "get_co=
mmand_descriptions"} v 0) v1 -- ?+0 0x7f7a8000b0f0 con 0x7f7a8000e4e0<br=
>2013-09-04 11:09:56.050938 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/101=
6260 &lt;=3D=3D mon.3 192.168.242.92:6789/0 11 =3D=3D=3D=3D mon_command_=
ack([{"prefix": "get_command_descriptions"}]=3D0&nbsp; v0) v1 =3D=3D=3D=
=3D 72+0+24040 (1092875540 0 2922658865) 0x7f7a700008c0 con 0x7f7a8000e4=
e0<br>2013-09-04 11:09:56.089981 7f7a8820f700&nbsp; 1 -- 192.168.242.36:=
0/1016260 --&gt; 192.168.242.92:6789/0 -- mon_command({"prefix": "status=
"} v 0) v1 -- ?+0 0x7f7a8000b0d0 con 0x7f7a8000e4e0<br>2013-09-04 11:09:=
56.091348 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mo=
n.3 192.168.242.92:6789/0 12 =3D=3D=3D=3D mon_command_ack([{"prefix": "s=
tatus"}]=3D0&nbsp; v0) v1 =3D=3D=3D=3D 54+0+558 (1155462804 0 1174924833=
) 0x7f7a70000db0 con 0x7f7a8000e4e0<br>&nbsp; cluster b085fba3-8e17-443c=
-bb61-7758504538f8<br>&nbsp;&nbsp; health HEALTH_WARN 1 mons down, quoru=
m 0,1,3,4 atom01,atom02,ping,pong<br>&nbsp;&nbsp; monmap e1: 5 mons at {=
atom01=3D192.168.242.31:6789/0,atom02=3D192.168.242.32:6789/0,nuke36=3D1=
92.168.242.36:6789/0,ping=3D192.168.242.92:6789/0,pong=3D192.168.242.93:=
6789/0}, election epoch 26, quorum 0,1,3,4 atom01,atom02,ping,pong<br>&n=
bsp;&nbsp; osdmap e22: 2 osds: 2 up, 2 in<br>&nbsp;&nbsp;&nbsp; pgmap v4=
6761: 1192 pgs: 1192 active+clean; 7806 MB data, 20618 MB used, 3702 GB=
 / 3722 GB avail; 9756B/s wr, 0op/s<br>&nbsp;&nbsp; mdsmap e17: 1/1/1 up=
 {0=3Dpong=3Dup:active}, 1 up:standby<br><br>2013-09-04 11:09:56.096071=
 7f7a8820f700&nbsp; 1 -- 192.168.242.36:0/1016260 mark_down 0x7f7a8000e4=
e0 -- 0x7f7a8000e280<br>2013-09-04 11:09:56.096516 7f7a8820f700&nbsp; 1=
 -- 192.168.242.36:0/1016260 mark_down_all<br>2013-09-04 11:09:56.097065=
 7f7a8820f700&nbsp; 1 -- 192.168.242.36:0/1016260 shutdown complete.<br>=
------------------<br><br>this is the ceph.conf that was generated durin=
g ceph-deploy (well I added the debug lines obviously)<br><br>----------=
--------<br>root@nuke36[/0]:~ # cat /etc/ceph/ceph.conf <br>[global]<br>=
fsid =3D b085fba3-8e17-443c-bb61-7758504538f8<br>mon_initial_members =3D=
 ping, pong, nuke36, atom01, atom02<br>mon_host =3D 192.168.242.92,192.1=
68.242.93,192.168.242.36,192.168.242.31,192.168.242.32<br>auth_supported=
 =3D cephx<br>osd_journal_size =3D 1024<br>filestore_xattr_use_omap =3D=
 true<br>debug ms =3D 1<br>debug mon =3D 20<br>------------------<br><br=
>after a reboot of the node I now find<br><br>------------------<br>root=
@nuke36[/1]:~ # ps ax | egrep ceph<br>&nbsp; 855 ?&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; Ssl&nbsp;&nbsp;&nbsp; 0:00 /usr/bin/ceph-mon --clus=
ter=3Dceph -i nuke36 -f<br>&nbsp; 856 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; Ss&nbsp;&nbsp;&nbsp;&nbsp; 0:00 /usr/bin/python /usr/sbin/ceph=
-create-keys --cluster=3Dceph -i nuke36<br>&nbsp;1813 pts/1&nbsp;&nbsp;&=
nbsp; R+&nbsp;&nbsp;&nbsp;&nbsp; 0:00 egrep --color=3Dauto ceph<br>-----=
-------------<br><br>with ceph-create-keys runing infinetly,<br>while th=
e key files but already exist<br><br>------------------<br>root@nuke36[/=
1]:~ # ls -lh /etc/ceph/<br>total 88K<br>-rw-r--r-- 1 root root&nbsp; 72=
 Aug 30 15:54 ceph.bootstrap-mds.keyring<br>-rw-r--r-- 1 root root&nbsp;=
 72 Aug 30 15:54 ceph.bootstrap-osd.keyring<br>-rw------- 1 root root&nb=
sp; 64 Aug 30 15:54 ceph.client.admin.keyring<br>-rw-r--r-- 1 root root=
 303 Sep&nbsp; 4 10:19 ceph.conf<br>-rw-r--r-- 1 root root 59K Sep&nbsp;=
 3 10:15 ceph.log<br>-rw-r--r-- 1 root root&nbsp; 73 Aug 30 15:53 ceph.m=
on.keyring<br>-rw-r--r-- 1 root root&nbsp; 92 Aug 30 00:03 rbdmap<br>---=
---------------<br><br>and<br><br>------------------<br>root@nuke36[/1]:=
~ # tree -pfugiAD /var/lib/ceph/<br>/var/lib/ceph<br>[drwxr-xr-x root&nb=
sp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:54]&nbsp; /=
var/lib/ceph/bootstrap-mds<br>[-rw------- root&nbsp;&nbsp;&nbsp;&nbsp; r=
oot&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:54]&nbsp; /var/lib/ceph/bootstrap-=
mds/ceph.keyring<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&=
nbsp;&nbsp;&nbsp; Aug 30 15:54]&nbsp; /var/lib/ceph/bootstrap-osd<br>[-r=
w------- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 3=
0 15:54]&nbsp; /var/lib/ceph/bootstrap-osd/ceph.keyring<br>[drwxr-xr-x r=
oot&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30&nbsp; 0:=
00]&nbsp; /var/lib/ceph/mds<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon<br>[=
drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug=
 30 15:53]&nbsp; /var/lib/ceph/mon/ceph-nuke36<br>[-rw-r--r-- root&nbsp;=
&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var=
/lib/ceph/mon/ceph-nuke36/done<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbs=
p; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon/ce=
ph-nuke36/keyring<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;=
&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon/ceph-nuke3=
6/store.db<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&=
nbsp;&nbsp; Sep&nbsp; 3&nbsp; 6:21]&nbsp; /var/lib/ceph/mon/ceph-nuke36/=
store.db/007726.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbs=
p;&nbsp;&nbsp;&nbsp; Sep&nbsp; 3&nbsp; 6:21]&nbsp; /var/lib/ceph/mon/cep=
h-nuke36/store.db/007727.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 3&nbsp; 6:21]&nbsp; /var/lib/cep=
h/mon/ceph-nuke36/store.db/007728.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nb=
sp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 3&nbsp; 6:21]&nbsp; /va=
r/lib/ceph/mon/ceph-nuke36/store.db/007729.sst<br>[-rw-r--r-- root&nbsp;=
&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 3&nbsp; 6:21]&=
nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007730.sst<br>[-rw-r--r-- r=
oot&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 10:=
14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007767.sst<br>[-rw-r--r=
-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4=
 10:14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007768.sst<br>[-rw-=
r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbs=
p; 4 10:14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007769.sst<br>[=
-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep=
&nbsp; 4 10:14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007770.sst<=
br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;=
 Sep&nbsp; 4 10:14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007772.=
sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&n=
bsp; Sep&nbsp; 4 10:14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007=
773.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbs=
p;&nbsp; Sep&nbsp; 4 10:14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db=
/007774.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;=
&nbsp;&nbsp; Sep&nbsp; 4 10:14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/stor=
e.db/007775.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&n=
bsp;&nbsp;&nbsp; Sep&nbsp; 4 10:18]&nbsp; /var/lib/ceph/mon/ceph-nuke36/=
store.db/007777.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbs=
p;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 10:19]&nbsp; /var/lib/ceph/mon/ceph-nuk=
e36/store.db/007780.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root=
&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon/ceph=
-nuke36/store.db/007783.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon=
/ceph-nuke36/store.db/007784.log<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&n=
bsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph=
/mon/ceph-nuke36/store.db/CURRENT<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&=
nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon=
/ceph-nuke36/store.db/LOCK<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; r=
oot&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon/c=
eph-nuke36/store.db/LOG<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root=
&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 10:19]&nbsp; /var/lib/ceph/mon/ceph=
-nuke36/store.db/LOG.old<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; roo=
t&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon/cep=
h-nuke36/store.db/MANIFEST-007782<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&=
nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon=
/ceph-nuke36/upstart<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nb=
sp;&nbsp;&nbsp;&nbsp; Aug 30&nbsp; 0:00]&nbsp; /var/lib/ceph/osd<br>[drw=
xr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30=
 15:53]&nbsp; /var/lib/ceph/tmp<br>------------------<br><br>to compare=
 with atom01 which is still running in the cluster...<br><br>-----------=
-------<br>root@atom01[/0]:~ # tree -pfugiAD /var/lib/ceph/<br>/var/lib/=
ceph<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&=
nbsp; Aug 30 15:54]&nbsp; /var/lib/ceph/bootstrap-mds<br>[-rw------- roo=
t&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:54]&nbs=
p; /var/lib/ceph/bootstrap-mds/ceph.keyring<br>[drwxr-xr-x root&nbsp;&nb=
sp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:54]&nbsp; /var/li=
b/ceph/bootstrap-osd<br>[-rw------- root&nbsp;&nbsp;&nbsp;&nbsp; root&nb=
sp;&nbsp;&nbsp;&nbsp; Aug 30 15:54]&nbsp; /var/lib/ceph/bootstrap-osd/ce=
ph.keyring<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&=
nbsp;&nbsp; Aug 30&nbsp; 0:00]&nbsp; /var/lib/ceph/mds<br>[drwxr-xr-x ro=
ot&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nb=
sp; /var/lib/ceph/mon<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&n=
bsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon/ceph-atom01=
<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp=
; Aug 30 15:53]&nbsp; /var/lib/ceph/mon/ceph-atom01/done<br>[-rw-r--r--=
 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]=
&nbsp; /var/lib/ceph/mon/ceph-atom01/keyring<br>[drwxr-xr-x root&nbsp;&n=
bsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /=
var/lib/ceph/mon/ceph-atom01/store.db<br>[-rw-r--r-- root&nbsp;&nbsp;&nb=
sp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:25]&nbsp; /var/lib=
/ceph/mon/ceph-atom01/store.db/006339.log<br>[-rw-r--r-- root&nbsp;&nbsp=
;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /var=
/lib/ceph/mon/ceph-atom01/store.db/006342.sst<br>[-rw-r--r-- root&nbsp;&=
nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp;=
 /var/lib/ceph/mon/ceph-atom01/store.db/006343.sst<br>[-rw-r--r-- root&n=
bsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&n=
bsp; /var/lib/ceph/mon/ceph-atom01/store.db/006344.sst<br>[-rw-r--r-- ro=
ot&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:1=
8]&nbsp; /var/lib/ceph/mon/ceph-atom01/store.db/006345.sst<br>[-rw-r--r-=
- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4=
 11:18]&nbsp; /var/lib/ceph/mon/ceph-atom01/store.db/006346.sst<br>[-rw-=
r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbs=
p; 4 11:18]&nbsp; /var/lib/ceph/mon/ceph-atom01/store.db/006347.sst<br>[=
-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep=
&nbsp; 4 11:18]&nbsp; /var/lib/ceph/mon/ceph-atom01/store.db/006348.sst<=
br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;=
 Aug 30 15:53]&nbsp; /var/lib/ceph/mon/ceph-atom01/store.db/CURRENT<br>[=
-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug=
 30 15:53]&nbsp; /var/lib/ceph/mon/ceph-atom01/store.db/LOCK<br>[-rw-r--=
r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp;=
 4 11:18]&nbsp; /var/lib/ceph/mon/ceph-atom01/store.db/LOG<br>[-rw-r--r-=
- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53=
]&nbsp; /var/lib/ceph/mon/ceph-atom01/store.db/LOG.old<br>[-rw-r--r-- ro=
ot&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:1=
8]&nbsp; /var/lib/ceph/mon/ceph-atom01/store.db/MANIFEST-000004<br>[-rw-=
r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30=
 15:53]&nbsp; /var/lib/ceph/mon/ceph-atom01/upstart<br>[drwxr-xr-x root&=
nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30&nbsp; 0:00]&=
nbsp; /var/lib/ceph/osd<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root=
&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/tmp<br>------=
------------<br><br>the problem with ceph-create-keys seemed to have bee=
n fixed with wip-4924<br>since in that version "rbd create" wouldn't wor=
k I switched to<br>deb http://gitbuilder.ceph.com/ceph-deb-raring-x86_64=
-basic/ref/dumpling/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; raring main<br>=
(runing on an uptodate raring)<br>I thought of just removing and than re=
-adding the failing mon but who do I do that?<br>The documentation on<br=
>http://ceph.com/docs/master/rados/operations/add-or-rm-mons/<br>says:<b=
r>"service ceph -a stop mon.{mon-id}"<br><br>------------------<br>root@=
nuke36[/1]:~ # service ceph -a stop mon.nuke36<br>/etc/init.d/ceph: mon.=
nuke36 not found (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )<=
br>root@nuke36[/1]:~ # service ceph -a stop mon.c<br>/etc/init.d/ceph: m=
on.c not found (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )<br=
>root@nuke36[/1]:~ # service ceph -a stop mon.2<br>/etc/init.d/ceph: mon=
.2 not found (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )<br>r=
oot@nuke36[/1]:~ # service ceph -a stop mon.ceph-nuke36<br>/etc/init.d/c=
eph: mon.ceph-nuke36 not found (/etc/ceph/ceph.conf defines , /var/lib/c=
eph defines )<br>------------------<br><br>that doesn't help, manually s=
topping the daemon doesn't work either (respawning, okay)<br>but this co=
mbination leaves me quite curious<br><br>------------------<br>root@atom=
01[/0]:~ # ceph health detail<br>HEALTH_WARN 1 mons down, quorum 0,1,3,4=
 atom01,atom02,ping,pong<br>mon.nuke36 (rank 2) addr 192.168.242.36:6789=
/0 is down (out of quorum)<br>root@atom01[/0]:~ # service ceph -a stop m=
on.nuke36<br>/etc/init.d/ceph: mon.nuke36 not found (/etc/ceph/ceph.conf=
 defines , /var/lib/ceph defines )<br>/etc/init.d/ceph: mon.2 not found=
 (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )<br>root@atom01[/=
0]:~ # service ceph -a stop mon.rank2<br>------------------<br><br>somet=
hing seems to be out of sync, at least with the documentation?<br>any hi=
nt how to proceed from here?<br><br>TIA<br><br>Bernhard<br><br><br><span=
 id=3D"felamimail-body-signature">-- <br><div style=3D"background-color:=
#FFFFFF; color:#000000;">=0A  <table cellpadding=3D"0" cellspacing=3D"5"=
 border=3D"0">=0A    <tbody><tr>=0A      <td colspan=3D"2" style=3D"vert=
ical-align:middle; text-align:center; background-color:#FFFFFF; color:#F=
FFFFF;" align=3D"center" valign=3D"center">=0A         <hr style=3D"heig=
ht:2px; background-color:#6f7072; color:#6f7072; border-width:0;">=0A  =
    </td>=0A    </tr>=0A    <tr>=0A      <td style=3D"text-align:center;=
 background-color:#FFFFFF; color:#182983;" align=3D"center">=0A        <=
img alt=3D"*Ecologic Institute*" src=3D"data:image/png;base64,/9j/4AAQSk=
ZJRgABAQEBKwErAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB%0AAQE=
BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQE=
B%0AAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAARCAB4=
AIEDASIA%0AAhEBAxEB/8QAHwAAAQMFAQEBAAAAAAAAAAAAAAUJCgQGBwgLAwEC/8QAVhAAA=
AUDAQIFCBUJBwUB%0AAAAAAQIDBAUABgcICRESFCExUQoTFTVBcXSRFxgaMzlTVFVYYXKTlJ=
ixs7jR0tbhFkJzeJensrfX%0AIjJSgaHB8DpHSFZjd//EABwBAQABBQEBAAAAAAAAAAAAAAA=
EAgMFBgcIAf/EADgRAAICAgECBAMC%0ADAcAAAAAAAECAwQABREGEhMhMUEHFBUiUQgWFyMy=
VVZhlJbT1CQ0cbHB0fD/2gAMAwEAAhEDEQA/%0AAJ/FeRlDBv3EMPeKI/IHyb6FD8ESB0mKH=
jMAf87/AE7q9aYygM5UDfuRXHvIHH/YK/PG1fU7n4Mp%0A9VKNFMYncbV9Tufgyn1UcbV9Tu=
fgyn1Uo0UxidxtX1O5+DKfVRxtX1O5+DKfVSjRTGJ3G1fU7n4M%0Ap9VHG1fU7n4Mp9VKNFM=
YncbV9Tufgyn1UcbV9Tufgyn1Uo0UxidxtX1O5+DKfVXiaUSIcU1D9bUA%0AQAyahQIcOEAC=
G8ph4QbwEBDeHKAgIAICFK9Ns5o1NxtkZzu+w13yaS8Me3AOkKnBMXslasFLE3hv%0A5N5X5=
Te2BgHu8rGONpOk1ADcYDd4Q3h3/H0AHt1VAICG8K1axjldrdCKKibgqnDAohuOA8/L/i7v%=
0AJv727nrZhkuCyZTAO8DBv9rm5w9ro5uQQ6KYyuooopjKF0bcoiH/AN0A8ahA/wBvFVdSc7=
89b+Et%0AvnApRpjE2ZmYi3YmTn5+Uj4SDhWLqUmJiWeN4+Lio1iidy9kJF+6USasmTNumou=
6dOFU0G6KZ1VT%0AkIUxgUCnIcoGIYDFMUDFMHMYogAgYB5hAQEBAQ5NwgPdrSzaTAA7PLXQ=
BgAQHSHqMAQHmHfiO7ai%0Ao7CrbynssLO0W63ruOraB+x9vYKz/cTwxlbUUHrbSMxrlOSdK=
CK1rqB1ttZ98OFBcW6vwIK4xcQT%0AhhK230Dp/wCHe66o6U3XUukU3ZdDdjhu6qOMtalpyV=
vHa3T4J8eSuQ3i1QviPF9uEu6GJ8Ta29el%0AfrUrJ8NbURaOcnhFkD9gjk5/RD+zk8BuA3A=
PcJwdFeSKpFiFUTORQhyEUIomYDpnIoUDJnTOURKc%0AhyiBinKIgYBAQEQEKty8b3s/HsC8=
um+rngrQtxgAccm7jlGcRGIGMBhImZ29WRRFZQCHBJApjLqi%0AUwJJnEN1c/8ATMtl0UVr9=
jPVbptzLNKW5izNuOb5uBMqp+wkBc0c6lVSoEMosLZgZVNy76ymQ6qw%0ANU1hSSIdU4FTKY=
wZ1fSDGLZuZGTeNY+PZN1Xb1++cItGLJqgQVF3Lt24Omg3boplMdVZZQiaZCiY%0A5igG+mM=
rKK1hhtaek24bvZ2DBahMVS15SMk3ho+32F2xrh6/lXbgjVrHsuAqKLp06cqJt2qSCpzO%0A=
FlCJpcM5ygOcL1v6ycbwLm6L/uu3rMt1oYqbiauWWZQ8cRU5TnTQB0+WRTUXUImoZNukJ11C=
kMJE%0AjAU25jLuorXnG+rPTPl+aG3MZZyxpek/vEE4WFumNXlHBi7+ERoxUVScPFCgAmMm1=
IsoBAMcS8Eo%0AjWwwcvLTGFQr9pXnGWtjal6h7SbvVEm0Y5w2CaQKbil47gXFkifk38m87s=
5ublERqahUATazrKF2%0Ax+qIoGEC8bwMABvHnNpuw2O/vh9fTTGSHtEGQHs7Gxhl1zH4ZER=
ETGEfzS7+73d49Hd376e2t1UV%0AWSBhHfvKTn5+UPw6Omo9GzzUMMVFbxHzpEeURH80g93v=
/L01IPtTte29wn8hqYy76KKKYxOd+et/%0ACW3zgUo0nO/PW/hLb5wKUaYzSraS+h566P1RN=
Rf8pLtrkjkKUUibwAf7Bd+/m/uhz9Af87o7+txt%0AJfQ89dH6omov+Ul21AJ2N+xsyLtH75=
b5EyAjNWDpDsiVSQvC+iJKsZXJcuzEqjjHeM1FUuC4cFAE%0A07vu0oGjrVaLFatzvLhcoMU=
PX34PHUOo6W6J613e7tpT19Pa02kkbgySuaTCOvXi5DT2Zm+xDCnL%0AOx9lDMvP+rali9s9=
dWrRmSWSu4AHoo8U8u7eioo82Y+QH7+BkiXqZHVXrSzZhi78W5itSYvXTXh5%0AFC38QahLl=
fKoTLGVanbkc4TRXfFO5yHDW1HLlfR0ukod3YDQW9oyUg8jV7ai7fyztBswWBeO0Vsb%0AE+=
olhf8AcunDCdlR91SOObChZO4nd53rPMjyqB5aHjHTNc8IIOYJtIPCqAoRhHPocFE05s5k5B=
2L%0AMW4+wnjy0MUYptKFsXHdhQbO3LStO32hGUVDxLIo9aRQSLvOqusqdZ2/euDqvZKQcu5=
GQcOXzpw4%0AUaj1u4M1DYt1T4819aXrLXyhMQNrBYWW8XRoLLzdxWwBnaJHcZGtgNIyibpo=
8SbOCQqb2XjZGJgJ%0AMkW9jm8lwPNnWe+odT9Ubfea7UV9HU2FhpYaFcny8gpsTcExLbtsD=
YtCuscAnkfsVmLSybjrastK%0AjXqz2HtSQoFaVh9x5CJ5dxjj8lTvLN2gckDhVbc1n5U0gX=
ha9l3zo8wNlLDOoPGN32/OWvMWngV7%0AjOJlIZk6A75hMK26CbY7yPUTZykPJnYqyCSjJeM=
I4I0k3IBuDtCso3xqFmdBuk+OmpWx4bU+2ta9%0A8trsgUj3rlnIGh2jK3xRULuBozdBdMi5=
jniR0FJZnbSjhuok0WbrbBtdpnli9VYO2MZ6CtSy99SL%0A6PYTBLytuRhbStXjLlFF++fTS=
EWdd4yjiHUMJ5JG1iKgUDKLICAomvbaP6UcmZjb4iz1p74qpqA0%0A3XIrctqwztZu1SvSBW=
dxsk/t8HLpVu1CUbPohu7hyO3DZu7ReTcWLlstJoOm+rn1APl6+rc8HgcH%0Ay9PMe/l5nJv=
t9/p7ccjy5/8AensffNkbK0LaRMex9ntLX094taPLDkIWbtu5XFpRb69Gk9b7ls+j%0AJ9e9=
HiC9zvZpJ80QeKyDyVWWXXKPXRMkIpU1ledntdeu1SvzDmW3D+UwPpRs+OkUcdA9dNYm6bkf=
%0AsLWfiaRRbLIHM1kZG5BNMLkODh1G2wxhgUIxk3HB2cx3tKMk3POWJjy5dCupm3MkT10Wx=
bN29dtK%0AVTse128rMMoycu1SccQ/ZQISEaOHM8oi6h0ECMmxkFJsEijJDj/UxhfPumbWKG=
vLThjt/mq3L4th%0ACz8+4lt8VTXW8aoNYlgnPQTJui7fSBzoQNvKt3ETHyr6JfRavHYleGk=
ZFwkHPJ59eOB5+5444Pn7%0Ac8f74PoOPTken3D92Vu0b0IYDjtNl55lw5j61MK5WwTCmyBa=
t1YvhY+x1XTG2jpvZOGlm9vIx7SQ%0AFWPSUWhZNdEZaGmG7JZo+KwXlY+S3q0O5jnM+6UMJ=
ZWugQPc1y2gkhcjgC8Er2ft589tqZkSEER4%0ABJKRh3L8hBERKRyUomMICYWxtQGo/Uxr3s=
R3po086Vcx4vjsinZQmUcp5qglrTt61rYByi5nI1u4%0AMmZitx1BEyLsSvlZ59H8bYRNunf=
O03Dd4fAOH4PAOGccYbtxVRzFY+taNt9N8sQE15N23SBSTlly%0AAIlI4lpNV5IrlKPBBVyc=
A5Ar4f0Rz6kkjz9j/wBn/nA9fL044/dz5ceX+nv92Zfrn/7Wn0ZHVF4Z%0AgX6NmG66AFc//=
a0+jI6ovDMC/Rsw3VOVY99s8u1UV+hR/hTqQnana5t7hP5DVHs2eXaqK/Qo/wAK%0AdSE7U7=
XNvcJ/IamMu+iiimMTnfnrfwlt84FKNJzvz1v4S2+cClGmM1a1xP7KitGGrGUyTbcreOPI%0=
A3Tjmh/fdpQUz+Tk1dFns8d3C4uW3om4OLu+wcjMw6byPZy/FnAxzhwm8BI4ogUWdrv2zOC9=
FWzT0%0AP6mcfaRpaKxNnhZSwbBwhad6W7ADjONgYO5JNLjEua3V2Mz14tuLAuoixbu3Tx+d=
88cuFzLqKOt7%0ASL0PXXL+qNqK/lLdtQk9oMYC9T7bHgxhApS5DuQxjGHcUACy8niIiI8gA=
ABvER5g5a7p8LeltP1N%0AT09Tcw2bVW11/Brp6yXrteB60vS24uP+ZrzxRrOZ6VYiyqiwI0=
aFZRFI6NrO7u2Kcth67Ijx6l5l%0AcxRuwdb1aMfadGJXslcFOewkhiO4KQ5z5roxT7CLJX7=
ZLS+51A9Vz4pHk8pFkr9slpfc6mgcXbLf%0ASbpw0lYz1lbVjM+U8exmeGqMhg3TbgVhCHy/=
dMU8Ypy0dL3BI3NFTLOKTUhnDKYl4wkYwJb7GUim%0A0rcKE67ThDrMrsuNGGtDTdlrUBsnM=
xZnua/8BRCtx5S0qah2NvLZKfW8i0dPzSNgy1rQ8Ig+Wds4%0A6RGAj1W04ncEmxcQvZeJlV=
o9g87M/Q/wFSaQt0/ujqotj9Jl6kE/Up6ci2IsCoa77UXfCCLbIqvd%0ACnXpYPhNbVh5a59=
T6o7R/i63jtF44p9tL5sxdgkDeB4fdyY/tiPnxSvJEfHGOyea5sU+wiyX+2W0%0A/wDezt1f=
R6rnxSP/AIRZK/bJaX3OpgTZi7MmztXVg5q1Xanctu8BaI9OTQVsh5Dh2rZzdd3y6Uej%0AL=
Orasc0gzkmDdVmxeRZFpU8PcCz2am4e3IOClpVy5Ix3O07aAtjdtDMsQWGdHeftWmLcmMJpC=
Wkb%0AM1BNrCVTy3jOHXKreSmMJyEtZJOCyDGQJXs+gynW8wyUaMTF7BA3K9fx93a9A/ArUW=
trXm6b31qL%0AQqn13Ya6Xqa9rdPI8K2FgvW4LrKkwgeOWdYllFSOVXuNXXkrTBtep50gdbl=
VGtf5WKZaUU1gBgnd%0AEjRglSwKoSVMhDCIOeBj7Ginqk7DOr7UZZeA5TT/ADGC2N3MrjeK=
5Lv/ADJZ35LQY2/CupdNB8Ve%0ADhEjKyZ2wMWgGkkBFwqTggqbcmbGmoTqpHD+Cs65dwuz0=
rXdkdpivINzWK1v+2MyWeFu3kjbsitH%0Ap3HCdZtqRTCMlCpcZaAnIPC9ZULucK/3qjnWPs=
1MLXPtrZ3ZsvbxyajhiLyXelmIXg2kLWDJh462%0A8XO73ZOFpBW1VLXF4rKoFauTktYiBmB=
jFSbpORBcMT4z2Xt7akdppnPQXgCXct7Ww9mHMluTeTr6%0A6y7LZ2JsW32+tILvus0O0i2s=
nPyHBiY5hExLSOCYn5IvF0I6IbSLuOtr8Lvgquznu2EtV9OnROu6%0Aoajat7eGvWoXbNgx7=
Z9iNgbTTzRx/LNrO1ghRHiDSy9uVfW+ozCkSFGsHZS0hKkddneWOOPmDwvC%0A7Ailu/xuQT=
3EEhV5EijzXNinkHykWSt4cw+TJaXJ3P8A07o5Px5afl2Xe0Xt/ab4Au/PVt4snMRM%0AbSz=
BP4iWtufuaOup49dwNl4/vJSbSkYyMikEWrlG/kGBGZ2xlk1Y1ZcyxiOEyJwnMq4U6n3wncl=
0%0A4Ql87a78sZDs0svbs9mnGbPF5MVqX/DprtHDeBhX1pOXj620ZtAWbxZCQmSlKm4BhcMg=
iCT48hfq%0AUoEQ2eubQbGOZsGtjJQNjK7gVM3DCWnYETKgUAKChk+CJwKHB4QjwQANwBo3x=
L6G+H+u6DudQdMd%0ALb/SW4b+ojr2919ZrpbqX2m/OVYNjbmV1dIwziWGKxCHjLRp4i85PT=
bPazbSOpdvVbMbRWC8db5d%0AjHJEE8pGijUggseO1ijEMASF8pN1c/8A2tPoyOqLwzAv0bM=
N10AK5/8AtafRkdUXhmBfo2Ybry7m%0A7Y99s8u1UV+hR/hTqQnana5t7hP5DVHs2eXaqK/Q=
o/wp1ITtTtc29wn8hqYy76KKKYxOd+et/CW3%0AzgUo0nO/PW/hLb5wKUaYzSzaReh665f1R=
tRX8pbtqEptBDop9T87HVRy1F82TyNcKjhkAgAvECWb%0Ak4yzQBMIFAXKYGR3mEADh8o7qm=
17SP0PTXMPRpF1FD4sSXbXMey7rzzLm3R/pu0V3bB46Z4n0vy7%0Audx7MQEJcDK/JF4/i52=
KWJdsw+uuTg5JuDe4Xp0yRVtQahVk2xjKnImdNX1V+D7pru0pV7VRYzDp%0AOvKm0vF5PDZa=
v4sbijzEOOZJPHuwDsBUhCz8/Z4Oj9V2Y4JXSQnus6qSCLheQZPnq0vDfcOyNjyf%0Afge+P=
f8AVKjCYyRE7OXU7Yqy1xaabu0xp2zZNwxIHXtmEuuQWh7sVSVVT3to55eFqrwBWCRgKo+T%=
0AsKRREoGiQJSB1LtB3JbepnUvqJmHSltYBxXpnuVnlG9pRRRhaTKQdT8FcsYL+RU4LJRaCt=
+17qmn%0ARAOdaNjjncHImm7KY7aOkDa26mNJGLX2n48BiTUXpwfPF35MEakLNVyDY8G8dOT=
PHLq0zoSsPMW6%0Aod2os9SZIyDmCQkHLmQThuOrGXpZ1UbYXUpqUw66032xZWEdLOnWTXI4=
uPEWmWx3Fgw17HIqmuBb%0A4lHkxNS86iosk3F3HtXETDyJGbEsnFvTtSKj2P8AE3q1OjZ/h=
ilHWNqJpLFFOq22ABTRWdpJfeST%0AS/K+O+7jryPXVFnFJ7QW21sAsma79RoHYrujLOJ1WO=
U0RF62o4FiCix39vyxZQ5JXxAnMYj9DjtG%0AO41fUd1NXqqt7ThEO3UvZGrO58m35jyBaHU=
uEuOGmaLayckweRLIplwLb+P3MNdajApDh2NtNwk2%0AKqdMiQtXbCnFuTsl7UDS6+x1DSz5=
lje9Vcg5Cl2KC/Y23rDgYp8ScdTj8hQasW8gLxtCtEnaiQyE%0ApJMo1sVV27QQPZ2zazFtJ=
tNK2Ts96D7SyBeVnQq9u2xm+EgrGdZNsOQM9QkZG2W97Wa1TcvBccXQ%0AlSxc9Epspdkgu7=
aN5Rsm7Eij9+zc1PbUzWjq8xawlsFWXpC0w2HejHK2pKRxVp3fad7VvmOsxq/k%0AY6EvW57=
pM9ua53ExKOEkhgmc4aNVA7iRlmSbFiuuhA3ybXpDUfE+jUm6at6jczbrctsL+8MGx1E+%0A=
409eG5rburSpPLetMIozqESxC9r5ivHM0SlTl2oYL9jSyut2OxWWvXEUVbvhsLXnYxyxzmRB=
En2j%0A8wSjBOx2Xk5g7En/AFXV3/8A73lX6PslWyuysuCJc7Vzbt4hiphnBZkytcGf/IneL=
LFSfKr2zmLK%0ArKZUjQHcdRSGkrvtSVdJI71TNw4wJDJM1DpsPZ/1+y2JtsVn/XbpqJZl2u=
ITPGTHWOHV5x8tNWXc%0AsMeFf4yJPrMIWateWcxs3EJrz0KKUvHrJkeMVHJTgRVufRaU1XZ=
rW1U3TrLta5hxpnW58t3dmkJ/%0AHgvYZlAXfes3Jzs23gWr9/LuiW8spMSEYMPLyEwm7hXC=
sbKKyKKy4qyJfh5tuoNWIpHioRX/AIUd%0AH9PwyT8tJBvNNsDt/Bt1e3v+U8Ra8NkglijTo=
qd6jmhdtBUnLANK0W92FtgvkGrWIRX7o3Pl4nHe%0AU58ue0k8E5ga4bTubH0/MWFfMJJWxe=
tnybu2LptuaQUazENcMMueOlI1+2WAFiumz5usicRAwKiU%0AFCGOQ5TD0AOpQ/Q7sze1rRy=
IA9ID5B2nTkEO4PSA1HTltvzmW8U/yiyhos2f2U8zBFHijZwvDBUm%0ArekgZRmLLszNt4+8=
mUW+nU0xAzd0xSiWDYySBG8YkiiCRpGvUqDpR/s+85PlipEVfa3cnPVSIE62%0AgRR3hXTw4=
ORFPebraJDKCVJPhG4BAKXhDu3jgvjle39z4Y7Ab7RQaaaHbaMK1baw7OC3M0s/zDwd%0AkE=
EsNdCqGI2VSZxIVeJDGWeV0zFVj3UXytl7CtBa5DwNC0ahU7A5LsrOeWDdhKgryGIYcSaq5/=
8A%0AtafRkdUXhmBfo2YbroAVz/8Aa0+jI6ovDMC/Rsw3XhbOnY99s8u1UV+hR/hTqQnana5=
t7hP5DVHs%0A2eXaqK/Qo/wp1ITtTtc29wn8hqYy76KKKYxOd+et/CW3zgUo0nO/PW/hLb5w=
KUaYyy8j48s/LePr%0A4xXkOHLcVhZItK4bFvSAM+kows1at1xLuDn4o0lDPI6XYBIRb501F=
5FyDKQbAr15m7buCJqkaQDq%0AebY+AAAGkLcAAAAHk/aoOYOQP+9dPR0Vm9V1L1Hoo5YtJ1=
Bu9NFYdZJ49Vtb+ujmkVe1XlSpPCsj%0AqpKqzhmC+QIGRp6dO0VazVrWGQEKZ4IpioJ5IUy=
IxUE+ZA4BOMu+Z59j77EP9/2qD+tdHmefY++x%0AD/f9qg/rXT0VFZX8ofX/AO3PWH8zbr+9=
yx9J1X6s1/8ABVv6eN8abdlrom0gSr+W0046yLiA8u7R%0AfzsVa+prVJ+StxvWrRVizd3PZ=
cnmiQtC5XDFosqiwWnoOROxKcwtDIm/tVn/AD1pYw5qYtN7YmYm%0AuR5uzJRoePmrYtnO+d=
sYwlwRyqQJLR1yR+Lck2Y3uOPcEABcsZwkg1cqB15dFRb+3WxFFYafqDfW%0Ar6bW1u9vZ2k=
ZUx7KfZXJr8ZTgIUuSTNYUoAApWQFeBxxwMkLUqpEYErV0gPIMKwxrEQfUGMKEPPv%0AyPPG=
XQ6nn2PgcgaQ/wB/2qD+tdHmefY++xD/AH/aoP6109FRWZ/KH1/+3PWH8zbr+9yP9J1X6s1/=
%0A8FW/p4y75nn2PvsQ/wB/2qD+tdOC6UNG2m7Q/juaxPpdxx5GFgXDekjkOYgPyvvy9eOXh=
LQduW3I%0ATHZXId0XbNN+MQtpW+y7HtZFCLS7H8ZQZJu3b1dzs7RUDZdXdV7mqaW36n6h2t=
NnSRqmy3WyvVWk%0AjJMchr2rMsRdCSUYp3KSSpGXYaFGu/iV6VSCQAgSQ1oYnAPqO9EVuD7=
jng++Fc//AGtPoyOqLwzA%0Av0bMN10AKgCbWdFQ22P1RGAoiXjeBhAdw85dN2Gw3d8fr6K1=
7JePc7PLtVFfoUf4U6kJ2p2ube4T%0A+Q1R8NnmmYIqK3gPnSIcoCH5pA7ve+XoqQfana9t7=
hP5DUxl30UUUxiTKgbrCgkMYpwABKYoiUxT%0AF5SmKYOUBAdwgIbhDdvAd9Nl6rprKbGKkD=
Wlft9W+qCanWzwF1T8SoQdw7hKePkG5iiG7kEohu6Q%0Ap0Jyn1wggPMIbh3c/wDzl/06d1Y=
ByNjltcjZZNREqnXCmDlLvDcID7Q8nLu5x593NTGQzc/5N15N%0AZl6S39V2qiHRBVQCJxOe=
8sxyZQ4XIBSM7sRKHJzAAByc1afL5c2kQKDwdaWsoA3jyBqVzWUA9rkv%0ATl3c3+VS9r00a=
Q826WWPGpGE5jCIikA8ojv6Pb6OisYH0GQJjCPYtH/JD6gDvf5UxkVLyXNpJ7NL%0AWX8ZfN=
f31o8lzaSezS1l/GXzX99alVeUKgvWxL3j8KPKFQXrYl7x+FMZFV8lzaSezS1l/GXzX99a%0=
APJc2kns0tZfxl81/fWpVXlCoL1sS94/CjyhUF62Je8fhTGRVfJc2kns0tZfxl81/fWjyXNp=
J7NLW%0AX8ZfNf31qVV5QqC9bEvePwo8oVBetiXvH4UxkVXyXNpJ7NLWX8ZfNf31o8lzaSez=
S1l/GXzX99al%0AVeUKgvWxL3j8KPKFQXrYl7x+FMZFYTy5tI+GG/WlrL3d3fqVzWbk735aD=
46VbExJl3ImSHGQcp3N%0Ae2Rr5nV40Z29L+uGbvC7JkYuOZQ0b2WuO4XkjMSQx8PHMIpjxx=
6txSNYs2LfrbVsgkSUmXQXAgIC%0AMWl7x+Hc56vy1dFMLFOUliRiReCYOUEQDmEN3cDn+qm=
Mx1ogx+9go2MKugYnAIiAgYoh+aXf3O5u%0AHp7u/dT21upCkyQKIbtxSc/PyB+PT01gDGOK=
Gtroopptyp8ACgG4gBzcn+Hucm/v7+etmGSAIplK%0AAbgKG72ubmD2ujn5ADppjK6iiimMB=
DfyDVMo2IoHKAG5+QQAeX/nRu79FFMZQHiG5xERRIO/u7i7%0A/wDUBry7BtPSCeIn2KKKYw=
7BtPSCeIn2KOwbT0gniJ9iiimMOwbT0gniJ9ijsG09IJ4ifYoopjDs%0AG09IJ4ifYo7BtPS=
CeIn2KKKYw7BtPSCeIn2KOwbT0gniJ9iiimMOwbT0gniJ9iv2WHbF3bkScggP%0AMXud4oc1=
FFMZXpNU0wDcUC94A3j3/F0iHtVVAAAG4KKKYz7RRRTGf//Z" height=3D"120" width=
=3D"129">=0A      </td>=0A      <td style=3D"text-align:left; padding-ri=
ght:10px; white-space:nowrap;" align=3D"left">=0A        <font color=3D"=
black" face=3D"sans-serif">=0A          <small>=0A            <b>Bernhar=
d Glomm</b><br>=0A            IT Administration<br><br>=0A          </sm=
all>=0A          <small><small>=0A            <table cellpadding=3D"0" c=
ellspacing=3D"0" border=3D"0">=0A              <tbody><tr>=0A          =
      <td style=3D"white-space:nowrap;"><small><small>=0A              =
    Phone:=0A                </small></small></td>=0A                <td=
 style=3D"padding-left:5px; white-space:nowrap;"><small><small>=0A     =
             +49 (30) 86880 134=0A                </small></small></td>=
=0A              </tr>=0A              <tr>=0A                <td style=
=3D"white-space:nowrap;"><small><small>=0A                  Fax:=0A    =
            </small></small></td>=0A                <td style=3D"padding=
-left:5px; white-space:nowrap;"><small><small>=0A                  +49 (=
30) 86880 100=0A                </small></small></td>=0A              </=
tr>=0A<!--=0A              <tr>=0A                <td style=3D"white-spa=
ce:nowrap;"><small><small>=0A                  Cell:=0A                <=
/td>=0A                <td style=3D"padding-left:5px; white-space:nowrap=
;"><small><small>=0A                  +49 (170) 3217628=0A             =
   </small></small></td>=0A              </tr>=0A-->=0A              <tr=
>=0A                <td style=3D"white-space:nowrap;"><small><small>=0A=
                  Skype:=0A                </small></small></td>=0A    =
            <td style=3D"padding-left:5px; white-space:nowrap;"><small><=
small>=0A                  bernhard.glomm.ecologic=0A                </s=
mall></small></td>=0A              </tr>=0A            </tbody></table>=
=0A          </small></small>=0A        </font>=0A      </td>=0A    </tr=
>=0A    <tr>=0A      <td colspan=3D"2" style=3D"vertical-align:middle; t=
ext-align:center; background-color:#6f7072; color:#FFFFFF; white-space:n=
owrap;" align=3D"center" valign=3D"center">=0A            <a href=3D"htt=
p://ecologic.eu"><img title=3D"Visit our website" alt=3D"Website:" src=
=3D"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAA=
AAAXNSR0IArs4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAAOwwAADsMBx2+oZAA=
AAAd0SU1FB9wMBAoOC+d8fXIAAAKjSURBVFjD%0A7ZfNS5VBFMaf8WMRejWktIWEiyDQokIT=
JY2E6C+oZWFC/0DtatcuMiGiZR+6itB/oIKghe36kFLK%0AW5lkEYGF5r2m6a9Fj/T6Yqb3v=
laL+2zmnXnPmXnOzJlzzkgFFFDAxiLkowwUSyqXVOqheUnZEMLc%0AhjMHiiLfO4EzwF3gC7=
DIT0wBg8B5YN9KukmT2gxcAKb5hQlgFvgKjLIcV4HqjSLTAIx4oaduh4Aa%0AIA28MOEn/jf=
odhxoTvSYgD3AZyALdAA3vFir/78BxvzdBCxYptl6GWB/IscHbAWGTaAXaLevXIzI%0ApIFX=
kf4lH2sLcNm6o0BNErvU7QnvAN8i/jEAdJrgB/tSK3AUuBmRWwQe+LsnXzL1nqjf/fYVHHfW=
%0Aiy74aKJ4DRwGioDbHqvPh9BZT9LifhXwDrgGVJpgFzBpX+kCjgB1QB/wFqi0bovnOpcrm=
VLfosdA%0ARWSHADpjsmkgHRs7FTMm5bkeASW/W3c1jy+TtFvS/RDClMeK3T5bg01j0WwQQp=
iWNCipQdKmdacO%0AYIukT5JmJL23bIWkavczJrgoabvVxm3kgqSUpBpJHyVN+3+tJCTVhhA=
m17tD+WIhZjQmX5JTDnXU%0AXXZVgUMea1qDD3VY9kBk7IpDRyoXH5qxrxwEymNW71qDTTui=
OkCZpFZJw5Ky6yYUQpiXdEtSox1R%0Akp5LmpDU7mvfBpyQVCWpCjjuuFMnqc0+NRIxolHSQ=
Ajhe76BcSBy7V/Ggt9cJDBmNzQw/iF19AMn%0A7VdLqaMNOAZcjxFLJnUsXf/Irqw1uXZbpg=
XoiezWtqTKj72uDJfKj95Vyo9GH2Gfy49J57jmRKvH%0AWIE29E8KtP+9hI0X+aeBezFyGeB=
hPkV+Es+gVOwZlPkrz6ACCiggR/wAnDhVsuP7eLUAAAAASUVO%0ARK5CYII=3D" height=
=3D"36" width=3D"36"></a>=0A            <a href=3D"http://www.youtube.co=
m/v/hZtiK04A9Yo"><img title=3D"Watch our video" alt=3D"| Video:" src=3D"=
data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAX=
NSR0IArs4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd=
0SU1FB9wMBAoOGGPCPKwAAAB6SURBVFjD%0A7ZU5DsAgDAS9KP//LFS4cJo0iRJycMRIOzVa=
DIyNCCGEkB24W2Bm9igIQIuCwqiNhmEbrfKCtwOG%0AaaSueYYz7455V252v6Gc8yvHlt7Cu=
3Aoxvi587o4VDNI2fYsSEQkpeRzMJYyfpEaAFR17q+DEEKI%0Ad1aawEGkmN8D6QAAAABJRU=
5ErkJggg=3D=3D" height=3D"36" width=3D"36"></a>=0A            <a href=3D=
"http://ecologic.eu/newsletter/subscribe"><img title=3D"Subscribe to our=
 newsletter" alt=3D"| Newsletter:" src=3D"data:image/png;base64,iVBORw0K=
GgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A%0A/=
wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9wMBAoMMRNGxkIAAAChSURBV=
FjD%0A7ZaxDsMgDERxFf7/g/I1DLciFiQGJHdq1SFNUmoSotybkBDG5s4WzhFCyMAAUGsA6N=
qd8m1DVbVn%0AsSKyePfUerCVrUIfo9nkPgnFGOeXkUMIaqL1P8b+7KyUku6Nex/Jcs7vdSn=
FnS5Za9zJcoZYzKyf%0AErIekpcwtalkS9RanfdeKBkTGsbUvT9qu19IRARAj2/xIc1BCCGt=
PAEkwLgtYjzXqwAAAABJRU5E%0ArkJggg=3D=3D" height=3D"36" width=3D"36"></a>=
=0A            <a href=3D"http://www.facebook.com/Ecologic.Institute"><i=
mg title=3D"Visit us on Facebook" alt=3D"| Facebook:" src=3D"data:image/=
png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6=
QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAADigAAA4oBp4z1HwAAAAd0SU1FB9wEFw=
gCHldMsUsAAADmSURBVFjD%0A7Zc9CsJAEIXfhKBYqGCj4B0s9AQewQN4CBuPaWlhrYWIlYK=
R/DybFcIaC7NxF2U+GJLZYvL2zSxJ%0AAEVRlLBIU4VIjgFEzxTAUURS7zsiOSB5IHkrxZXk=
pE692FHMEMC+ok5W1/3I0aBFSQzNNTdB7w4B%0AGJkHi4ktgKVxaBdCEK3WrERk41LQtWXpt=
07tp8M85SuFlc98OpSbOXnnzh3A2aeguGL+yqeqDeAS%0AonVrq01z15quQ92x8m5oQY2jgl=
TQ3wlyfblmABJz3wJQBP2EJdkD0C8tnUQk0T8DRVF+mQc9yneK%0AZNh8QAAAAABJRU5ErkJ=
ggg=3D=3D" height=3D"36" width=3D"36"></a>=0A            <a href=3D"http=
://www.linkedin.com/company/ecologic-institute-berlin-germany"><img titl=
e=3D"Visit us on Linkedin" alt=3D"| Linkedin:" src=3D"data:image/png;bas=
e64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAAAAZi=
S0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAADigAAA4oBp4z1HwAAAAd0SU1FB9wEFwgDLmiOs=
KYAAAEQSURBVFjD%0A7Za9SsRAFEbP7G6ziqyIlYUiNhY+gC+wvoU+g80+g41PY2UhaGclFn=
ZiZWMrrGjw79hMII6FCe5m%0AV5gDYb7ce5P7MckNgUwmk8k0Rx2op+qVujdrMwtq4Xd2ptW=
vU6NmBbByAOzPcoe66l2yQ8vz8B6N%0A1CN19T8Owa56qG5P4+aL/mQr5m6S+FC9TWKP6sGk=
p2ycNNmMuctK7C2un8lasj6pKatLr6LvgVCZ%0ASoCztg0BXIcQOiGEDeA4mipZUwdtGxqWI=
oQwSnJdYKlNQ09A8UtNaNNQqNOw7UdGNjQvhro14r0G%0A36k/FX0AJ0A/nveB56gvgIeoC+=
A9ufYcGEf9Crzk391MJpNpyBfHBeoJLzEVJwAAAABJRU5ErkJg%0Agg=3D=3D" height=3D=
"36" width=3D"36"></a>=0A            <a href=3D"http://twitter.com/Ecolo=
gicBerlin"><img title=3D"Visit us on Twitter" alt=3D"| Twitter:" src=3D"=
data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAX=
NSR0IArs4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAADigAAA4oBp4z1HwAAAAd=
0SU1FB9wEFwgEKbmrs8IAAAEeSURBVFjD%0A7ZaxSsRAFEXv1RUERW0WBLuFBa2t/A/9gG38=
B4v9BTt/wsbCxm7Z2k4LZWtFQcsVFdFjYYQQEyVs%0AMtmVORBeMZO8Oy93Zp4UiUQiMwawC=
GxMi5g2cAc8A1dAp2lBp3zxkcSjqnPMlZy/nkQncbtpQT+K%0A9u8FtSZ8fxM4KVjY0PZh3a=
Y+pxwjoBXyl/1FV9LSNAj69taDpJeQHnqSNEodA2luJR3Yfg0p6NL2%0ADjCfHbD93sQu25o=
keRUeyiZeBXpAZV50yW2/J+k4Y15LupZ0k1ngWFLf9kWd59AC8Ji6XItIj3fr%0APhx3c5L+=
xlmINqRXUI28Ku2H6o1WgAEwThq2vGdY9upwBcKWJa3lfOvN9n1s+iORyKzxCQPwTJ5S%0AB=
f6EAAAAAElFTkSuQmCC" height=3D"36" width=3D"36"></a>=0A            <a hr=
ef=3D"http://www.youtube.com/user/EcologicInstitute"><img title=3D"Visit=
 us on YouTube" alt=3D"| YouTube:" src=3D"data:image/png;base64,iVBORw0K=
GgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A%0A/=
wD/oL2nkwAAAAlwSFlzAAADigAAA4oBp4z1HwAAAAd0SU1FB9wEFwgFIjdiWwsAAAHTSURBV=
FjD%0A7Za7a1RREMZ/c3ddTdIn4APBysLYKmqRwkoE7VIoFj4bC/8AwUKsbCwsrG1sVBAsFJ=
LKFBaCVqYz%0A8YGgVsEku25ifhbOwhoEsyt3NXA/GO55wJzvzplv5kCFChUqbDKoI+rOHI+=
qo/+a0Jg/0VDfqhf/%0AhyhNq9dVc35cHVeH1X3qLnX7IAkdzCjdUc+qa+qiOqG+VG+qV/vx=
XfTJ6TXQBKaAE8AEsAzUgVXg%0Ae9rACK0CAivA7iTX7tqPfqNf/OXt1YFnQAMYSSKNJBqDJ=
BTAcNpTYAb4DLwC9gBngK/9Ou41oYfy%0AR5oZjQJoATVga4470SsiYrkUQmoNeAgcBoYyh/=
7kuwU8iYhTZUj9stpS36jz6gd/xfuUfzc68/Nl%0A5NABYA64AkwCj9bt71+ntE6UBHaUldR=
7gdPAoSR1P2vRN2ABuJuqW8rEvj0Ila1k0ZsHHgDTwEdg%0AG3ABeAzcAm4AL3otkPUSOkuR=
kj+XJAdGyDw8frNey+tsAlvKurLOwWvZOsaBe8A7ILLeHMtieRK4%0Alt/SOvyllPAXda5L2=
otpC+qsupTrz9V2r7KPHklNAUc2UBS7/c9ExNEyW8dYtoyNoB0Rn6qHf4UK%0AFTYTfgDpBC=
lAXl8czQAAAABJRU5ErkJggg=3D=3D" height=3D"36" width=3D"36"></a>=0A     =
       <a href=3D"http://plus.google.com/113756356645020994482"><img tit=
le=3D"Visit us on Google+" alt=3D"| Google+:" src=3D"data:image/png;base=
64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAAAAZiS=
0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAADigAAA4oBp4z1HwAAAAd0SU1FB9wGEwowOnAZEb=
IAAAGZSURBVFjD%0A7Ze9Sx1REMVnnoqiWOhDIliIWPlRRBAtLIRA1D/AwkIkjYW2tvZW1vY=
mEAtBsLSxsQkhASEkFlYK%0AIlqIIIpEz89mxFUerxDfXYQ9ze7OXuaePffM3LtmBQoUKJAv=
/C2SAB1A07PE7gZ4qVQ6SvY1kiYl%0AnQBIugduJN0Ad8C1pP6UZFaDyHyoNAhcRmw76TpLG=
pcEsPFi6foISPr0mtylVxnPfdHdzcwOXsT/%0AmdnfeJxNRsjMRuJarmDwn3Fbl5LQXkw+XU=
G9NsDcfSuZh4ABnrCWiXeFf3aA+qTGBqaAK+Ae+AXs%0ABpnN3Loq0CLpo6QlSUTlDeXe7oH=
PmSX8LqkxTzKjkr5k+g/AKdCarMqAXmArtohldx80sxkz+xb9%0A6cNjJaZQpPtRDKC9wvuF=
jFKzNSUjqQ74EwYerkJ6JUit1lqdRuA4CHVXGVcOFedqTagBOAxC+1XG%0ArUs6S+WhiUzP+=
R0VNgb0AJPAV0nnQGfKUi8DP6JT30q6A/7HoWwxtyMs0Gxm5dhMr9z9ovgrKFCg%0AwHvHAw=
OPpj4eVQaJAAAAAElFTkSuQmCC" height=3D"36" width=3D"36"></a>=0A      </td=
>=0A    </tr>=0A    <tr>=0A      <td colspan=3D"2" style=3D"vertical-ali=
gn:middle; text-align:left; background-color:#FFFFFF; color:#000000; pad=
ding-left:5px; padding-right:5px; white-space:nowrap;" align=3D"left" va=
lign=3D"center">=0A        <small><small>=0A          Ecologic Institut=
 gemeinn=C3=BCtzige GmbH | Pfalzburger Str. 43/44 | 10717 Berlin | Germa=
ny<br>=0A          GF: R. Andreas Kraemer | AG: Charlottenburg HRB 57947=
 | USt/VAT-IdNr.: DE811963464<br>=0A          Ecologic=E2=84=A2 is a Tra=
de Mark (TM) of Ecologic Institut gemeinn=C3=BCtzige GmbH=0A        </sm=
all></small>=0A      </td>=0A    </tr>=0A    <tr>=0A      <td colspan=3D=
"2" style=3D"vertical-align:middle; text-align:center; background-color:=
#FFFFFF; color:#FFFFFF;" align=3D"center" valign=3D"center">=0A        =
 <hr style=3D"height:2px; background-color:#6f7072; color:#6f7072; borde=
r-width:0;">root@nuke<br>=0A      </td>=0A    </tr>=0A  </tbody></table>=
=0A</div></span></body></html>

--=_68795574ee35b5261228031457b5d15d--

--===============1793433499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1793433499==--
