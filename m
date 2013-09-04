From: "Bernhard Glomm" <bernhard.glomm-uSuf018nij3sq35pWSNszA@public.gmane.org>
Subject: Re: how to remove and re-add broken mon?   SOLVED
Date: Wed, 04 Sep 2013 15:21:06 +0000
Message-ID: <086d868ba20ebd557ee3cf166c27295bb1c2c381@ecologic.eu>
References: <ee15755bb1292a720a84f58fdc80a31f7a75fd64@ecologic.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0331687445=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <ee15755bb1292a720a84f58fdc80a31f7a75fd64-uSuf018nij3sq35pWSNszA@public.gmane.org>
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

--===============0331687445==
Content-Type: multipart/alternative; charset=UTF-8;
 boundary="=_fe7fbba5d5dc5fa6b5bdf92beab7a5d1"

--=_fe7fbba5d5dc5fa6b5bdf92beab7a5d1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Removing a monitor, also like described in=0Ahttp://ceph.com/docs/master=
/rados/deployment/ceph-deploy-mon/=0Adoesn't work=0A=0A----------------=
=0Aroot@nuke36[/1]:/etc/ceph # ceph-deploy mon destroy nuke36=0A[ceph_de=
ploy.mon][DEBUG ] Removing mon from nuke36=0A[ceph_deploy.mon][ERROR ] c=
eph-mon deamon did not stop=0A[ceph_deploy][ERROR ] GenericError: Failed=
 to destroy 1 monitors=0A----------------=0A=0Ais this, I can't destroy=
 the mon on which I run the destroy command?=0A(I could destroy =0Abut s=
ince I just added another two monitors to my cluster,=0Athe broken first=
 one is alive again...=0A=0Awell that should do as a work around for now=
 =0A(since I'm using the dev branch and do only testing stuff)=0Astill,=
 would be curious if I could have repaired it any other way.=0A=0ABernha=
rd=0A=0AAm 04.09.2013 12:40:04, schrieb Bernhard Glomm:=0A> Hi all,=0A>=
 =0A> after some days of successful creating and destroying rbd's, snaps=
hots,=0A> clones and migrating formats all of a sudden one of the monito=
rs doesn't work anymore.=0A> I tried to remove and re-add the monitor fr=
om the cluster, but that doesn't seem to work either.=0A> =0A> Here's th=
e situation:=0A> I liked to use ceph-deploy to initiate the cluster.=0A>=
 Due to the broken ceph-create-keys in dumpling I turned to the gitbuild=
er version=0A> now running=0A> =0A> ceph version 0.67.2-23-g24f2669 (24f=
2669783e2eb9d9af5ecbe106efed93366ba63)=0A> on uptodate raring systems=0A=
> All of a sudden the host from which I ran ceph-deploy, and which shoul=
d be one of the =0A> 5 monitors (from which 2 are also serving as OSDs)=
 has fallen out of the quorum as you can see here=0A> (yes, time is in s=
ync on all nodes):=0A> =0A> ------------------=0A> root@nuke36[/0]:~ # c=
eph -s=0A> 2013-09-04 11:09:56.039547 7f7a8820f700=C2=A0 1 -- :/0 messen=
ger.start=0A> 2013-09-04 11:09:56.040646 7f7a8820f700=C2=A0 1 -- :/10162=
60 --> 192.168.242.92:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0=
 0x7f7a8000e8f0 con 0x7f7a8000e4e0=0A> 2013-09-04 11:09:56.041304 7f7a84=
a08700=C2=A0 1 -- 192.168.242.36:0/1016260 learned my addr 192.168.242.3=
6:0/1016260=0A> 2013-09-04 11:09:56.042843 7f7a86a0c700=C2=A0 1 -- 192.1=
68.242.36:0/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 1 =3D=3D=3D=3D m=
on_map v1 =3D=3D=3D=3D 776+0+0 (2241333437 0 0) 0x7f7a70000c30 con 0x7f7=
a8000e4e0=0A> 2013-09-04 11:09:56.043038 7f7a86a0c700=C2=A0 1 -- 192.168=
.242.36:0/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 2 =3D=3D=3D=3D aut=
h_reply(proto 2 0 Success) v1 =3D=3D=3D=3D 33+0+0 (2063715990 0 0) 0x7f7=
a70001060 con 0x7f7a8000e4e0=0A> 2013-09-04 11:09:56.043324 7f7a86a0c700=
=C2=A0 1 -- 192.168.242.36:0/1016260 --> 192.168.242.92:6789/0 -- auth(p=
roto 2 32 bytes epoch 0) v1 -- ?+0 0x7f7a74001af0 con 0x7f7a8000e4e0=0A>=
 2013-09-04 11:09:56.044197 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/101=
6260 <=3D=3D mon.3 192.168.242.92:6789/0 3 =3D=3D=3D=3D auth_reply(proto=
 2 0 Success) v1 =3D=3D=3D=3D 206+0+0 (3910749728 0 0) 0x7f7a70001060 co=
n 0x7f7a8000e4e0=0A> 2013-09-04 11:09:56.044375 7f7a86a0c700=C2=A0 1 --=
 192.168.242.36:0/1016260 --> 192.168.242.92:6789/0 -- auth(proto 2 165=
 bytes epoch 0) v1 -- ?+0 0x7f7a740020d0 con 0x7f7a8000e4e0=0A> 2013-09-=
04 11:09:56.045376 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=3D=
=3D mon.3 192.168.242.92:6789/0 4 =3D=3D=3D=3D auth_reply(proto 2 0 Succ=
ess) v1 =3D=3D=3D=3D 393+0+0 (3802320753 0 0) 0x7f7a700008f0 con 0x7f7a8=
000e4e0=0A> 2013-09-04 11:09:56.045457 7f7a86a0c700=C2=A0 1 -- 192.168.2=
42.36:0/1016260 --> 192.168.242.92:6789/0 -- mon_subscribe({monmap=3D0+}=
) v2 -- ?+0 0x7f7a8000ed80 con 0x7f7a8000e4e0=0A> 2013-09-04 11:09:56.04=
5550 7f7a8820f700=C2=A0 1 -- 192.168.242.36:0/1016260 --> 192.168.242.92=
:6789/0 -- mon_subscribe({monmap=3D2+,osdmap=3D0}) v2 -- ?+0 0x7f7a80007=
9f0 con 0x7f7a8000e4e0=0A> 2013-09-04 11:09:56.045559 7f7a8820f700=C2=A0=
 1 -- 192.168.242.36:0/1016260 --> 192.168.242.92:6789/0 -- mon_subscrib=
e({monmap=3D2+,osdmap=3D0}) v2 -- ?+0 0x7f7a8000fa10 con 0x7f7a8000e4e0=
=0A> 2013-09-04 11:09:56.046376 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0=
/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 5 =3D=3D=3D=3D mon_map v1=
 =3D=3D=3D=3D 776+0+0 (2241333437 0 0) 0x7f7a70001290 con 0x7f7a8000e4e0=
=0A> 2013-09-04 11:09:56.046417 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0=
/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 6 =3D=3D=3D=3D mon_subscrib=
e_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (1524320885 0 0) 0x7f7a70001480 con 0=
x7f7a8000e4e0=0A> 2013-09-04 11:09:56.046429 7f7a86a0c700=C2=A0 1 -- 192=
.168.242.36:0/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 7 =3D=3D=3D=3D=
 osd_map(22..22 src has 1..22) v3 =3D=3D=3D=3D 2355+0+0 (11792226 0 0) 0=
x7f7a70001f70 con 0x7f7a8000e4e0=0A> 2013-09-04 11:09:56.046828 7f7a86a0=
c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=3D=3D mon.3 192.168.242.92:67=
89/0 8 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (1524=
320885 0 0) 0x7f7a700008f0 con 0x7f7a8000e4e0=0A> 2013-09-04 11:09:56.04=
6948 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=3D=3D mon.3 192.=
168.242.92:6789/0 9 =3D=3D=3D=3D osd_map(22..22 src has 1..22) v3 =3D=3D=
=3D=3D 2355+0+0 (11792226 0 0) 0x7f7a700008c0 con 0x7f7a8000e4e0=0A> 201=
3-09-04 11:09:56.047071 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260=
 <=3D=3D mon.3 192.168.242.92:6789/0 10 =3D=3D=3D=3D mon_subscribe_ack(3=
00s) v1 =3D=3D=3D=3D 20+0+0 (1524320885 0 0) 0x7f7a70000df0 con 0x7f7a80=
00e4e0=0A> 2013-09-04 11:09:56.047547 7f7a8820f700=C2=A0 1 -- 192.168.24=
2.36:0/1016260 --> 192.168.242.92:6789/0 -- mon_command({"prefix": "get_=
command_descriptions"} v 0) v1 -- ?+0 0x7f7a8000b0f0 con 0x7f7a8000e4e0=
=0A> 2013-09-04 11:09:56.050938 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0=
/1016260 <=3D=3D mon.3 192.168.242.92:6789/0 11 =3D=3D=3D=3D mon_command=
_ack([{"prefix": "get_command_descriptions"}]=3D0=C2=A0 v0) v1 =3D=3D=3D=
=3D 72+0+24040 (1092875540 0 2922658865) 0x7f7a700008c0 con 0x7f7a8000e4=
e0=0A> 2013-09-04 11:09:56.089981 7f7a8820f700=C2=A0 1 -- 192.168.242.36=
:0/1016260 --> 192.168.242.92:6789/0 -- mon_command({"prefix": "status"}=
 v 0) v1 -- ?+0 0x7f7a8000b0d0 con 0x7f7a8000e4e0=0A> 2013-09-04 11:09:5=
6.091348 7f7a86a0c700=C2=A0 1 -- 192.168.242.36:0/1016260 <=3D=3D mon.3=
 192.168.242.92:6789/0 12 =3D=3D=3D=3D mon_command_ack([{"prefix": "stat=
us"}]=3D0=C2=A0 v0) v1 =3D=3D=3D=3D 54+0+558 (1155462804 0 1174924833) 0=
x7f7a70000db0 con 0x7f7a8000e4e0=0A> =C2=A0 cluster b085fba3-8e17-443c-b=
b61-7758504538f8=0A> =C2=A0=C2=A0 health HEALTH_WARN 1 mons down, quorum=
 0,1,3,4 atom01,atom02,ping,pong=0A> =C2=A0=C2=A0 monmap e1: 5 mons at {=
atom01=3D192.168.242.31:6789/0,atom02=3D192.168.242.32:6789/0,nuke36=3D1=
92.168.242.36:6789/0,ping=3D192.168.242.92:6789/0,pong=3D192.168.242.93:=
6789/0}, election epoch 26, quorum 0,1,3,4 atom01,atom02,ping,pong=0A>=
 =C2=A0=C2=A0 osdmap e22: 2 osds: 2 up, 2 in=0A> =C2=A0=C2=A0=C2=A0 pgma=
p v46761: 1192 pgs: 1192 active+clean; 7806 MB data, 20618 MB used, 3702=
 GB / 3722 GB avail; 9756B/s wr, 0op/s=0A> =C2=A0=C2=A0 mdsmap e17: 1/1/=
1 up {0=3Dpong=3Dup:active}, 1 up:standby=0A> =0A> 2013-09-04 11:09:56.0=
96071 7f7a8820f700=C2=A0 1 -- 192.168.242.36:0/1016260 mark_down 0x7f7a8=
000e4e0 -- 0x7f7a8000e280=0A> 2013-09-04 11:09:56.096516 7f7a8820f700=C2=
=A0 1 -- 192.168.242.36:0/1016260 mark_down_all=0A> 2013-09-04 11:09:56.=
097065 7f7a8820f700=C2=A0 1 -- 192.168.242.36:0/1016260 shutdown complet=
e.=0A> ------------------=0A> =0A> this is the ceph.conf that was genera=
ted during ceph-deploy (well I added the debug lines obviously)=0A> =0A>=
 ------------------=0A> root@nuke36[/0]:~ # cat /etc/ceph/ceph.conf =0A>=
 [global]=0A> fsid =3D b085fba3-8e17-443c-bb61-7758504538f8=0A> mon_init=
ial_members =3D ping, pong, nuke36, atom01, atom02=0A> mon_host =3D 192.=
168.242.92,192.168.242.93,192.168.242.36,192.168.242.31,192.168.242.32=
=0A> auth_supported =3D cephx=0A> osd_journal_size =3D 1024=0A> filestor=
e_xattr_use_omap =3D true=0A> debug ms =3D 1=0A> debug mon =3D 20=0A> --=
----------------=0A> =0A> after a reboot of the node I now find=0A> =0A>=
 ------------------=0A> root@nuke36[/1]:~ # ps ax | egrep ceph=0A> =C2=
=A0 855 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ssl=C2=A0=C2=A0=C2=
=A0 0:00 /usr/bin/ceph-mon --cluster=3Dceph -i nuke36 -f=0A> =C2=A0 856=
 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ss=C2=A0=C2=A0=C2=A0=C2=A0=
 0:00 /usr/bin/python /usr/sbin/ceph-create-keys --cluster=3Dceph -i nuk=
e36=0A> =C2=A01813 pts/1=C2=A0=C2=A0=C2=A0 R+=C2=A0=C2=A0=C2=A0=C2=A0 0:=
00 egrep --color=3Dauto ceph=0A> ------------------=0A> =0A> with ceph-c=
reate-keys runing infinetly,=0A> while the key files but already exist=
=0A> =0A> ------------------=0A> root@nuke36[/1]:~ # ls -lh /etc/ceph/=
=0A> total 88K=0A> -rw-r--r-- 1 root root=C2=A0 72 Aug 30 15:54 ceph.boo=
tstrap-mds.keyring=0A> -rw-r--r-- 1 root root=C2=A0 72 Aug 30 15:54 ceph=
.bootstrap-osd.keyring=0A> -rw------- 1 root root=C2=A0 64 Aug 30 15:54=
 ceph.client.admin.keyring=0A> -rw-r--r-- 1 root root 303 Sep=C2=A0 4 10=
:19 ceph.conf=0A> -rw-r--r-- 1 root root 59K Sep=C2=A0 3 10:15 ceph.log=
=0A> -rw-r--r-- 1 root root=C2=A0 73 Aug 30 15:53 ceph.mon.keyring=0A> -=
rw-r--r-- 1 root root=C2=A0 92 Aug 30 00:03 rbdmap=0A> -----------------=
-=0A> =0A> and=0A> =0A> ------------------=0A> root@nuke36[/1]:~ # tree=
 -pfugiAD /var/lib/ceph/=0A> /var/lib/ceph=0A> [drwxr-xr-x root=C2=A0=C2=
=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=A0 /var/li=
b/ceph/bootstrap-mds=0A> [-rw------- root=C2=A0=C2=A0=C2=A0=C2=A0 root=
=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=A0 /var/lib/ceph/bootstrap-mds=
/ceph.keyring=0A> [drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=
=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=A0 /var/lib/ceph/bootstrap-osd=0A> [-rw=
------- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30=
 15:54]=C2=A0 /var/lib/ceph/bootstrap-osd/ceph.keyring=0A> [drwxr-xr-x r=
oot=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30=C2=A0 0:=
00]=C2=A0 /var/lib/ceph/mds=0A> [drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0=
 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon=0A>=
 [drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 A=
ug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-nuke36=0A> [-rw-r--r-- root=C2=
=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /=
var/lib/ceph/mon/ceph-nuke36/done=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=
=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mo=
n/ceph-nuke36/keyring=0A> [drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=
=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:16]=C2=A0 /var/lib/ceph/mon/ceph=
-nuke36/store.db=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=
=C2=A0=C2=A0=C2=A0 Sep=C2=A0 3=C2=A0 6:21]=C2=A0 /var/lib/ceph/mon/ceph-=
nuke36/store.db/007726.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0=
 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 3=C2=A0 6:21]=C2=A0 /var/lib/cep=
h/mon/ceph-nuke36/store.db/007727.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=
=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 3=C2=A0 6:21]=C2=A0=
 /var/lib/ceph/mon/ceph-nuke36/store.db/007728.sst=0A> [-rw-r--r-- root=
=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 3=C2=A0=
 6:21]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007729.sst=0A> [-rw-=
r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=
=A0 3=C2=A0 6:21]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007730.ss=
t=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=
=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/0077=
67.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.d=
b/007768.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=
=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/s=
tore.db/007769.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=
=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ceph-nu=
ke36/store.db/007770.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 ro=
ot=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/mon/ce=
ph-nuke36/store.db/007772.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=
=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib/ceph/=
mon/ceph-nuke36/store.db/007773.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=
=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /var/lib=
/ceph/mon/ceph-nuke36/store.db/007774.sst=0A> [-rw-r--r-- root=C2=A0=C2=
=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:14]=C2=A0 /v=
ar/lib/ceph/mon/ceph-nuke36/store.db/007775.sst=0A> [-rw-r--r-- root=C2=
=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:18]=C2=
=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007777.sst=0A> [-rw-r--r-- ro=
ot=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 10:1=
9]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007780.sst=0A> [-rw-r--r=
-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4=
 11:16]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007783.sst=0A> [-rw=
-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=
=A0 4 11:16]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007784.log=0A>=
 [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 S=
ep=C2=A0 4 11:16]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/CURRENT=
=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=
=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/LOCK=0A>=
 [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 S=
ep=C2=A0 4 11:16]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/LOG=0A> [=
-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=
=C2=A0 4 10:19]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/LOG.old=0A>=
 [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 S=
ep=C2=A0 4 11:16]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/MANIFEST-=
007782=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-nuke36/upstart=0A>=
 [drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 A=
ug 30=C2=A0 0:00]=C2=A0 /var/lib/ceph/osd=0A> [drwxr-xr-x root=C2=A0=C2=
=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/li=
b/ceph/tmp=0A> ------------------=0A> =0A> to compare with atom01 which=
 is still running in the cluster...=0A> =0A> ------------------=0A> root=
@atom01[/0]:~ # tree -pfugiAD /var/lib/ceph/=0A> /var/lib/ceph=0A> [drwx=
r-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30=
 15:54]=C2=A0 /var/lib/ceph/bootstrap-mds=0A> [-rw------- root=C2=A0=C2=
=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=A0 /var/li=
b/ceph/bootstrap-mds/ceph.keyring=0A> [drwxr-xr-x root=C2=A0=C2=A0=C2=A0=
=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=A0 /var/lib/ceph/bo=
otstrap-osd=0A> [-rw------- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=
=A0=C2=A0=C2=A0 Aug 30 15:54]=C2=A0 /var/lib/ceph/bootstrap-osd/ceph.key=
ring=0A> [drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=
=C2=A0 Aug 30=C2=A0 0:00]=C2=A0 /var/lib/ceph/mds=0A> [drwxr-xr-x root=
=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=
=A0 /var/lib/ceph/mon=0A> [drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=
=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-atom=
01=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=
=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-atom01/done=0A> [-rw-r=
--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 1=
5:53]=C2=A0 /var/lib/ceph/mon/ceph-atom01/keyring=0A> [drwxr-xr-x root=
=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=
=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db=0A> [-rw-r--r-- root=C2=A0=
=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:25]=C2=A0=
 /var/lib/ceph/mon/ceph-atom01/store.db/006339.log=0A> [-rw-r--r-- root=
=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=
=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/006342.sst=0A> [-rw-r--r--=
 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=A0 4 1=
1:18]=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/006343.sst=0A> [-rw-r=
--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Sep=C2=
=A0 4 11:18]=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/006344.sst=0A>=
 [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 S=
ep=C2=A0 4 11:18]=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/006345.ss=
t=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=
=A0 Sep=C2=A0 4 11:18]=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/0063=
46.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.d=
b/006347.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=
=A0=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=A0 /var/lib/ceph/mon/ceph-atom01/s=
tore.db/006348.sst=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=
=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-atom01/=
store.db/CURRENT=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=
=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-atom01/sto=
re.db/LOCK=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=
=C2=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=A0 /var/lib/ceph/mon/ceph-atom01/stor=
e.db/LOG=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=
=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.db/=
LOG.old=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0 Sep=C2=A0 4 11:18]=C2=A0 /var/lib/ceph/mon/ceph-atom01/store.d=
b/MANIFEST-000004=0A> [-rw-r--r-- root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=
=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=A0 /var/lib/ceph/mon/ceph-atom01/=
upstart=0A> [drwxr-xr-x root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0 Aug 30=C2=A0 0:00]=C2=A0 /var/lib/ceph/osd=0A> [drwxr-xr-x roo=
t=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0 Aug 30 15:53]=C2=
=A0 /var/lib/ceph/tmp=0A> ------------------=0A> =0A> the problem with c=
eph-create-keys seemed to have been fixed with wip-4924=0A> since in tha=
t version "rbd create" wouldn't work I switched to=0A> deb http://gitbui=
lder.ceph.com/ceph-deb-raring-x86_64-basic/ref/dumpling/=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 raring main=0A> (runing on an uptodate raring)=0A>=
 I thought of just removing and than re-adding the failing mon but who d=
o I do that?=0A> The documentation on=0A> http://ceph.com/docs/master/ra=
dos/operations/add-or-rm-mons/=0A> says:=0A> "service ceph -a stop mon.{=
mon-id}"=0A> =0A> ------------------=0A> root@nuke36[/1]:~ # service cep=
h -a stop mon.nuke36=0A> /etc/init.d/ceph: mon.nuke36 not found (/etc/ce=
ph/ceph.conf defines , /var/lib/ceph defines )=0A> root@nuke36[/1]:~ # s=
ervice ceph -a stop mon.c=0A> /etc/init.d/ceph: mon.c not found (/etc/ce=
ph/ceph.conf defines , /var/lib/ceph defines )=0A> root@nuke36[/1]:~ # s=
ervice ceph -a stop mon.2=0A> /etc/init.d/ceph: mon.2 not found (/etc/ce=
ph/ceph.conf defines , /var/lib/ceph defines )=0A> root@nuke36[/1]:~ # s=
ervice ceph -a stop mon.ceph-nuke36=0A> /etc/init.d/ceph: mon.ceph-nuke3=
6 not found (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )=0A> -=
-----------------=0A> =0A> that doesn't help, manually stopping the daem=
on doesn't work either (respawning, okay)=0A> but this combination leave=
s me quite curious=0A> =0A> ------------------=0A> root@atom01[/0]:~ # c=
eph health detail=0A> HEALTH_WARN 1 mons down, quorum 0,1,3,4 atom01,ato=
m02,ping,pong=0A> mon.nuke36 (rank 2) addr 192.168.242.36:6789/0 is down=
 (out of quorum)=0A> root@atom01[/0]:~ # service ceph -a stop mon.nuke36=
=0A> /etc/init.d/ceph: mon.nuke36 not found (/etc/ceph/ceph.conf defines=
 , /var/lib/ceph defines )=0A> /etc/init.d/ceph: mon.2 not found (/etc/c=
eph/ceph.conf defines , /var/lib/ceph defines )=0A> root@atom01[/0]:~ #=
 service ceph -a stop mon.rank2=0A> ------------------=0A> =0A> somethin=
g seems to be out of sync, at least with the documentation?=0A> any hint=
 how to proceed from here?=0A> =0A> TIA=0A> =0A> Bernhard=0A> =0A> =0A>=
 -- =0A> =0A  > =0A         > =0A    > =0A        =0A> =0A      > =0A  =
      > =0A          > =0A            > Bernhard Glomm=0A> =0A         =
   IT Administration=0A> =0A> =0A          > =0A            > =0A      =
            Phone:=0A                > =0A                > =0A        =
          +49 (30) 86880 134=0A                > =0A              > =0A=
                  Fax:=0A                > =0A                > =0A    =
              +49 (30) 86880 100=0A                > =0A              >=
 =0A                  Skype:=0A                > =0A                >=
 =0A                  bernhard.glomm.ecologic=0A                > =0A  =
            > =0A        =0A      =0A    =0A            > =0A          =
  > =0A            > =0A            > =0A            > =0A            >=
 =0A            > =0A            > =0A      =0A    =0A        > =0A    =
      Ecologic Institut gemeinn=C3=BCtzige GmbH | Pfalzburger Str. 43/44=
 | 10717 Berlin | Germany=0A> =0A          GF: R. Andreas Kraemer | AG:=
 Charlottenburg HRB 57947 | USt/VAT-IdNr.: DE811963464=0A> =0A         =
 Ecologic=E2=84=A2 is a Trade Mark (TM) of Ecologic Institut gemeinn=C3=
=BCtzige GmbH=0A        > =0A      =0A    =0A         > root@nuke=0A> __=
_____________________________________________=0A> ceph-users mailing lis=
t=0A> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=0A> http://lists.ceph.com/listinfo.cgi/c=
eph-users-ceph.com=0A=0A=0A=0A=0A-- =0A=0A=0A  =0A         =0A    =0A  =
      =0A      =0A        =0A          =0A            Bernhard Glomm=0A=
=0A            IT Administration=0A=0A=0A          =0A            =0A  =
                Phone:=0A                =0A                =0A        =
          +49 (30) 86880 134=0A                =0A              =0A    =
              Fax:=0A                =0A                =0A            =
      +49 (30) 86880 100=0A                =0A              =0A        =
          Skype:=0A                =0A                =0A              =
    bernhard.glomm.ecologic=0A                =0A              =0A     =
   =0A      =0A    =0A            =0A            =0A            =0A    =
        =0A            =0A            =0A            =0A            =0A=
      =0A    =0A        =0A          Ecologic Institut gemeinn=C3=BCtzig=
e GmbH | Pfalzburger Str. 43/44 | 10717 Berlin | Germany=0A=0A         =
 GF: R. Andreas Kraemer | AG: Charlottenburg HRB 57947 | USt/VAT-IdNr.:=
 DE811963464=0A=0A          Ecologic=E2=84=A2 is a Trade Mark (TM) of Ec=
ologic Institut gemeinn=C3=BCtzige GmbH=0A        =0A      =0A    =0A  =
       =0A

--=_fe7fbba5d5dc5fa6b5bdf92beab7a5d1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; char=
set=3DUTF-8"><title></title><style type=3D"text/css">.felamimail-body-bl=
ockquote {margin: 5px 10px 0 3px;padding-left: 10px;border-left: 2px sol=
id #000088;} </style></head><body>Removing a monitor, also like describe=
d in<br>http://ceph.com/docs/master/rados/deployment/ceph-deploy-mon/<br=
>doesn't work<br><br>----------------<br>root@nuke36[/1]:/etc/ceph # cep=
h-deploy mon destroy nuke36<br>[ceph_deploy.mon][DEBUG ] Removing mon fr=
om nuke36<br>[ceph_deploy.mon][ERROR ] ceph-mon deamon did not stop<br>[=
ceph_deploy][ERROR ] GenericError: Failed to destroy 1 monitors<br>-----=
-----------<br><br>is this, I can't destroy the mon on which I run the d=
estroy command?<br>(I could destroy <br>but since I just added another t=
wo monitors to my cluster,<br>the broken first one is alive again...<br>=
<br>well that should do as a work around for now <br>(since I'm using th=
e dev branch and do only testing stuff)<br>still, would be curious if I=
 could have repaired it any other way.<br><br>Bernhard<br><br>Am 04.09.2=
013 12:40:04, schrieb Bernhard Glomm:<br><blockquote class=3D"felamimail=
-body-blockquote">Hi all,<br><br>after some days of successful creating=
 and destroying rbd's, snapshots,<br>clones and migrating formats all of=
 a sudden one of the monitors doesn't work anymore.<br>I tried to remove=
 and re-add the monitor from the cluster, but that doesn't seem to work=
 either.<br><br>Here's the situation:<br>I liked to use ceph-deploy to i=
nitiate the cluster.<br>Due to the broken ceph-create-keys in dumpling I=
 turned to the gitbuilder version<br>now running<br><br>ceph version 0.6=
7.2-23-g24f2669 (24f2669783e2eb9d9af5ecbe106efed93366ba63)<br>on uptodat=
e raring systems<br>All of a sudden the host from which I ran ceph-deplo=
y, and which should be one of the <br>5 monitors (from which 2 are also=
 serving as OSDs) has fallen out of the quorum as you can see here<br>(y=
es, time is in sync on all nodes):<br><br>------------------<br>root@nuk=
e36[/0]:~ # ceph -s<br>2013-09-04 11:09:56.039547 7f7a8820f700&nbsp; 1 -=
- :/0 messenger.start<br>2013-09-04 11:09:56.040646 7f7a8820f700&nbsp; 1=
 -- :/1016260 --&gt; 192.168.242.92:6789/0 -- auth(proto 0 30 bytes epoc=
h 0) v1 -- ?+0 0x7f7a8000e8f0 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.=
041304 7f7a84a08700&nbsp; 1 -- 192.168.242.36:0/1016260 learned my addr=
 192.168.242.36:0/1016260<br>2013-09-04 11:09:56.042843 7f7a86a0c700&nbs=
p; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.92:6789/0=
 1 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 776+0+0 (2241333437 0 0) 0x7f7a7=
0000c30 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.043038 7f7a86a0c700&nb=
sp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.92:6789/0=
 2 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=3D=3D=3D 33+0+0 (20=
63715990 0 0) 0x7f7a70001060 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.0=
43324 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 --&gt; 192.168.24=
2.92:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0 0x7f7a74001af0 c=
on 0x7f7a8000e4e0<br>2013-09-04 11:09:56.044197 7f7a86a0c700&nbsp; 1 --=
 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.92:6789/0 3 =3D=
=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=3D=3D=3D 206+0+0 (3910749=
728 0 0) 0x7f7a70001060 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.044375=
 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 --&gt; 192.168.242.92:=
6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0 0x7f7a740020d0 con 0=
x7f7a8000e4e0<br>2013-09-04 11:09:56.045376 7f7a86a0c700&nbsp; 1 -- 192.=
168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.92:6789/0 4 =3D=3D=3D=
=3D auth_reply(proto 2 0 Success) v1 =3D=3D=3D=3D 393+0+0 (3802320753 0=
 0) 0x7f7a700008f0 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.045457 7f7a=
86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 --&gt; 192.168.242.92:6789/=
0 -- mon_subscribe({monmap=3D0+}) v2 -- ?+0 0x7f7a8000ed80 con 0x7f7a800=
0e4e0<br>2013-09-04 11:09:56.045550 7f7a8820f700&nbsp; 1 -- 192.168.242.=
36:0/1016260 --&gt; 192.168.242.92:6789/0 -- mon_subscribe({monmap=3D2+,=
osdmap=3D0}) v2 -- ?+0 0x7f7a800079f0 con 0x7f7a8000e4e0<br>2013-09-04 1=
1:09:56.045559 7f7a8820f700&nbsp; 1 -- 192.168.242.36:0/1016260 --&gt; 1=
92.168.242.92:6789/0 -- mon_subscribe({monmap=3D2+,osdmap=3D0}) v2 -- ?+=
0 0x7f7a8000fa10 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.046376 7f7a86=
a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.=
92:6789/0 5 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 776+0+0 (2241333437 0 0=
) 0x7f7a70001290 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.046417 7f7a86=
a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.=
92:6789/0 6 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0=
 (1524320885 0 0) 0x7f7a70001480 con 0x7f7a8000e4e0<br>2013-09-04 11:09:=
56.046429 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mo=
n.3 192.168.242.92:6789/0 7 =3D=3D=3D=3D osd_map(22..22 src has 1..22) v=
3 =3D=3D=3D=3D 2355+0+0 (11792226 0 0) 0x7f7a70001f70 con 0x7f7a8000e4e0=
<br>2013-09-04 11:09:56.046828 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/=
1016260 &lt;=3D=3D mon.3 192.168.242.92:6789/0 8 =3D=3D=3D=3D mon_subscr=
ibe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (1524320885 0 0) 0x7f7a700008f0 con=
 0x7f7a8000e4e0<br>2013-09-04 11:09:56.046948 7f7a86a0c700&nbsp; 1 -- 19=
2.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.92:6789/0 9 =3D=3D=
=3D=3D osd_map(22..22 src has 1..22) v3 =3D=3D=3D=3D 2355+0+0 (11792226=
 0 0) 0x7f7a700008c0 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.047071 7f=
7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.=
242.92:6789/0 10 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20=
+0+0 (1524320885 0 0) 0x7f7a70000df0 con 0x7f7a8000e4e0<br>2013-09-04 11=
:09:56.047547 7f7a8820f700&nbsp; 1 -- 192.168.242.36:0/1016260 --&gt; 19=
2.168.242.92:6789/0 -- mon_command({"prefix": "get_command_descriptions"=
} v 0) v1 -- ?+0 0x7f7a8000b0f0 con 0x7f7a8000e4e0<br>2013-09-04 11:09:5=
6.050938 7f7a86a0c700&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon=
.3 192.168.242.92:6789/0 11 =3D=3D=3D=3D mon_command_ack([{"prefix": "ge=
t_command_descriptions"}]=3D0&nbsp; v0) v1 =3D=3D=3D=3D 72+0+24040 (1092=
875540 0 2922658865) 0x7f7a700008c0 con 0x7f7a8000e4e0<br>2013-09-04 11:=
09:56.089981 7f7a8820f700&nbsp; 1 -- 192.168.242.36:0/1016260 --&gt; 192=
.168.242.92:6789/0 -- mon_command({"prefix": "status"} v 0) v1 -- ?+0 0x=
7f7a8000b0d0 con 0x7f7a8000e4e0<br>2013-09-04 11:09:56.091348 7f7a86a0c7=
00&nbsp; 1 -- 192.168.242.36:0/1016260 &lt;=3D=3D mon.3 192.168.242.92:6=
789/0 12 =3D=3D=3D=3D mon_command_ack([{"prefix": "status"}]=3D0&nbsp; v=
0) v1 =3D=3D=3D=3D 54+0+558 (1155462804 0 1174924833) 0x7f7a70000db0 con=
 0x7f7a8000e4e0<br>&nbsp; cluster b085fba3-8e17-443c-bb61-7758504538f8<b=
r>&nbsp;&nbsp; health HEALTH_WARN 1 mons down, quorum 0,1,3,4 atom01,ato=
m02,ping,pong<br>&nbsp;&nbsp; monmap e1: 5 mons at {atom01=3D192.168.242=
.31:6789/0,atom02=3D192.168.242.32:6789/0,nuke36=3D192.168.242.36:6789/0=
,ping=3D192.168.242.92:6789/0,pong=3D192.168.242.93:6789/0}, election ep=
och 26, quorum 0,1,3,4 atom01,atom02,ping,pong<br>&nbsp;&nbsp; osdmap e2=
2: 2 osds: 2 up, 2 in<br>&nbsp;&nbsp;&nbsp; pgmap v46761: 1192 pgs: 1192=
 active+clean; 7806 MB data, 20618 MB used, 3702 GB / 3722 GB avail; 975=
6B/s wr, 0op/s<br>&nbsp;&nbsp; mdsmap e17: 1/1/1 up {0=3Dpong=3Dup:activ=
e}, 1 up:standby<br><br>2013-09-04 11:09:56.096071 7f7a8820f700&nbsp; 1=
 -- 192.168.242.36:0/1016260 mark_down 0x7f7a8000e4e0 -- 0x7f7a8000e280<=
br>2013-09-04 11:09:56.096516 7f7a8820f700&nbsp; 1 -- 192.168.242.36:0/1=
016260 mark_down_all<br>2013-09-04 11:09:56.097065 7f7a8820f700&nbsp; 1=
 -- 192.168.242.36:0/1016260 shutdown complete.<br>------------------<br=
><br>this is the ceph.conf that was generated during ceph-deploy (well I=
 added the debug lines obviously)<br><br>------------------<br>root@nuke=
36[/0]:~ # cat /etc/ceph/ceph.conf <br>[global]<br>fsid =3D b085fba3-8e1=
7-443c-bb61-7758504538f8<br>mon_initial_members =3D ping, pong, nuke36,=
 atom01, atom02<br>mon_host =3D 192.168.242.92,192.168.242.93,192.168.24=
2.36,192.168.242.31,192.168.242.32<br>auth_supported =3D cephx<br>osd_jo=
urnal_size =3D 1024<br>filestore_xattr_use_omap =3D true<br>debug ms =3D=
 1<br>debug mon =3D 20<br>------------------<br><br>after a reboot of th=
e node I now find<br><br>------------------<br>root@nuke36[/1]:~ # ps ax=
 | egrep ceph<br>&nbsp; 855 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Ssl&nbsp;&nbsp;&nbsp; 0:00 /usr/bin/ceph-mon --cluster=3Dceph -i nuke36=
 -f<br>&nbsp; 856 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ss&nbsp;&n=
bsp;&nbsp;&nbsp; 0:00 /usr/bin/python /usr/sbin/ceph-create-keys --clust=
er=3Dceph -i nuke36<br>&nbsp;1813 pts/1&nbsp;&nbsp;&nbsp; R+&nbsp;&nbsp;=
&nbsp;&nbsp; 0:00 egrep --color=3Dauto ceph<br>------------------<br><br=
>with ceph-create-keys runing infinetly,<br>while the key files but alre=
ady exist<br><br>------------------<br>root@nuke36[/1]:~ # ls -lh /etc/c=
eph/<br>total 88K<br>-rw-r--r-- 1 root root&nbsp; 72 Aug 30 15:54 ceph.b=
ootstrap-mds.keyring<br>-rw-r--r-- 1 root root&nbsp; 72 Aug 30 15:54 cep=
h.bootstrap-osd.keyring<br>-rw------- 1 root root&nbsp; 64 Aug 30 15:54=
 ceph.client.admin.keyring<br>-rw-r--r-- 1 root root 303 Sep&nbsp; 4 10:=
19 ceph.conf<br>-rw-r--r-- 1 root root 59K Sep&nbsp; 3 10:15 ceph.log<br=
>-rw-r--r-- 1 root root&nbsp; 73 Aug 30 15:53 ceph.mon.keyring<br>-rw-r-=
-r-- 1 root root&nbsp; 92 Aug 30 00:03 rbdmap<br>------------------<br><=
br>and<br><br>------------------<br>root@nuke36[/1]:~ # tree -pfugiAD /v=
ar/lib/ceph/<br>/var/lib/ceph<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp=
; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:54]&nbsp; /var/lib/ceph/bootstr=
ap-mds<br>[-rw------- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp=
;&nbsp; Aug 30 15:54]&nbsp; /var/lib/ceph/bootstrap-mds/ceph.keyring<br>=
[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Au=
g 30 15:54]&nbsp; /var/lib/ceph/bootstrap-osd<br>[-rw------- root&nbsp;&=
nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:54]&nbsp; /var/=
lib/ceph/bootstrap-osd/ceph.keyring<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp=
;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30&nbsp; 0:00]&nbsp; /var/lib/c=
eph/mds<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbs=
p;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon<br>[drwxr-xr-x root&nbsp;=
&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var=
/lib/ceph/mon/ceph-nuke36<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; ro=
ot&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon/ceph-nu=
ke36/done<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&n=
bsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon/ceph-nuke36/keyring<br>=
[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Se=
p&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db<br>[-rw-r-=
-r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp;=
 3&nbsp; 6:21]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007726.sst<b=
r>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;=
 Sep&nbsp; 3&nbsp; 6:21]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/00=
7727.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nb=
sp;&nbsp; Sep&nbsp; 3&nbsp; 6:21]&nbsp; /var/lib/ceph/mon/ceph-nuke36/st=
ore.db/007728.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;=
&nbsp;&nbsp;&nbsp; Sep&nbsp; 3&nbsp; 6:21]&nbsp; /var/lib/ceph/mon/ceph-=
nuke36/store.db/007729.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; r=
oot&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 3&nbsp; 6:21]&nbsp; /var/lib/ceph/=
mon/ceph-nuke36/store.db/007730.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp=
;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 10:14]&nbsp; /var/lib/c=
eph/mon/ceph-nuke36/store.db/007767.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&=
nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 10:14]&nbsp; /var/l=
ib/ceph/mon/ceph-nuke36/store.db/007768.sst<br>[-rw-r--r-- root&nbsp;&nb=
sp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 10:14]&nbsp; /v=
ar/lib/ceph/mon/ceph-nuke36/store.db/007769.sst<br>[-rw-r--r-- root&nbsp=
;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 10:14]&nbsp=
; /var/lib/ceph/mon/ceph-nuke36/store.db/007770.sst<br>[-rw-r--r-- root&=
nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 10:14]&=
nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007772.sst<br>[-rw-r--r-- r=
oot&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 10:=
14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007773.sst<br>[-rw-r--r=
-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4=
 10:14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007774.sst<br>[-rw-=
r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbs=
p; 4 10:14]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007775.sst<br>[=
-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep=
&nbsp; 4 10:18]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007777.sst<=
br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;=
 Sep&nbsp; 4 10:19]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007780.=
sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&n=
bsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/007=
783.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbs=
p;&nbsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db=
/007784.log<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;=
&nbsp;&nbsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon/ceph-nuke36/stor=
e.db/CURRENT<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp=
;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db=
/LOCK<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;=
&nbsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/L=
OG<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nb=
sp; Sep&nbsp; 4 10:19]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/LOG.=
old<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&n=
bsp; Sep&nbsp; 4 11:16]&nbsp; /var/lib/ceph/mon/ceph-nuke36/store.db/MAN=
IFEST-007782<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp=
;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon/ceph-nuke36/upstart<=
br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;=
 Aug 30&nbsp; 0:00]&nbsp; /var/lib/ceph/osd<br>[drwxr-xr-x root&nbsp;&nb=
sp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/li=
b/ceph/tmp<br>------------------<br><br>to compare with atom01 which is=
 still running in the cluster...<br><br>------------------<br>root@atom0=
1[/0]:~ # tree -pfugiAD /var/lib/ceph/<br>/var/lib/ceph<br>[drwxr-xr-x r=
oot&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:54]&n=
bsp; /var/lib/ceph/bootstrap-mds<br>[-rw------- root&nbsp;&nbsp;&nbsp;&n=
bsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:54]&nbsp; /var/lib/ceph/boot=
strap-mds/ceph.keyring<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&=
nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:54]&nbsp; /var/lib/ceph/bootstrap-osd<=
br>[-rw------- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;=
 Aug 30 15:54]&nbsp; /var/lib/ceph/bootstrap-osd/ceph.keyring<br>[drwxr-=
xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30&nb=
sp; 0:00]&nbsp; /var/lib/ceph/mds<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&=
nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mon=
<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp=
; Aug 30 15:53]&nbsp; /var/lib/ceph/mon/ceph-atom01<br>[-rw-r--r-- root&=
nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp;=
 /var/lib/ceph/mon/ceph-atom01/done<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp=
;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/m=
on/ceph-atom01/keyring<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&=
nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /var/lib/ceph/mon/ceph-=
atom01/store.db<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&n=
bsp;&nbsp;&nbsp; Sep&nbsp; 4 11:25]&nbsp; /var/lib/ceph/mon/ceph-atom01/=
store.db/006339.log<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root&nbs=
p;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /var/lib/ceph/mon/ceph-ato=
m01/store.db/006342.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp; root=
&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /var/lib/ceph/mon/ceph=
-atom01/store.db/006343.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbsp;=
 root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /var/lib/ceph/mon=
/ceph-atom01/store.db/006344.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&n=
bsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /var/lib/ceph=
/mon/ceph-atom01/store.db/006345.sst<br>[-rw-r--r-- root&nbsp;&nbsp;&nbs=
p;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /var/lib/=
ceph/mon/ceph-atom01/store.db/006346.sst<br>[-rw-r--r-- root&nbsp;&nbsp;=
&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /var/=
lib/ceph/mon/ceph-atom01/store.db/006347.sst<br>[-rw-r--r-- root&nbsp;&n=
bsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /=
var/lib/ceph/mon/ceph-atom01/store.db/006348.sst<br>[-rw-r--r-- root&nbs=
p;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /v=
ar/lib/ceph/mon/ceph-atom01/store.db/CURRENT<br>[-rw-r--r-- root&nbsp;&n=
bsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/l=
ib/ceph/mon/ceph-atom01/store.db/LOCK<br>[-rw-r--r-- root&nbsp;&nbsp;&nb=
sp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /var/lib=
/ceph/mon/ceph-atom01/store.db/LOG<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;=
&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ceph/mo=
n/ceph-atom01/store.db/LOG.old<br>[-rw-r--r-- root&nbsp;&nbsp;&nbsp;&nbs=
p; root&nbsp;&nbsp;&nbsp;&nbsp; Sep&nbsp; 4 11:18]&nbsp; /var/lib/ceph/m=
on/ceph-atom01/store.db/MANIFEST-000004<br>[-rw-r--r-- root&nbsp;&nbsp;&=
nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp; Aug 30 15:53]&nbsp; /var/lib/ce=
ph/mon/ceph-atom01/upstart<br>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; r=
oot&nbsp;&nbsp;&nbsp;&nbsp; Aug 30&nbsp; 0:00]&nbsp; /var/lib/ceph/osd<b=
r>[drwxr-xr-x root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;=
 Aug 30 15:53]&nbsp; /var/lib/ceph/tmp<br>------------------<br><br>the=
 problem with ceph-create-keys seemed to have been fixed with wip-4924<b=
r>since in that version "rbd create" wouldn't work I switched to<br>deb=
 http://gitbuilder.ceph.com/ceph-deb-raring-x86_64-basic/ref/dumpling/&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; raring main<br>(runing on an uptodate=
 raring)<br>I thought of just removing and than re-adding the failing mo=
n but who do I do that?<br>The documentation on<br>http://ceph.com/docs/=
master/rados/operations/add-or-rm-mons/<br>says:<br>"service ceph -a sto=
p mon.{mon-id}"<br><br>------------------<br>root@nuke36[/1]:~ # service=
 ceph -a stop mon.nuke36<br>/etc/init.d/ceph: mon.nuke36 not found (/etc=
/ceph/ceph.conf defines , /var/lib/ceph defines )<br>root@nuke36[/1]:~ #=
 service ceph -a stop mon.c<br>/etc/init.d/ceph: mon.c not found (/etc/c=
eph/ceph.conf defines , /var/lib/ceph defines )<br>root@nuke36[/1]:~ # s=
ervice ceph -a stop mon.2<br>/etc/init.d/ceph: mon.2 not found (/etc/cep=
h/ceph.conf defines , /var/lib/ceph defines )<br>root@nuke36[/1]:~ # ser=
vice ceph -a stop mon.ceph-nuke36<br>/etc/init.d/ceph: mon.ceph-nuke36 n=
ot found (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )<br>-----=
-------------<br><br>that doesn't help, manually stopping the daemon doe=
sn't work either (respawning, okay)<br>but this combination leaves me qu=
ite curious<br><br>------------------<br>root@atom01[/0]:~ # ceph health=
 detail<br>HEALTH_WARN 1 mons down, quorum 0,1,3,4 atom01,atom02,ping,po=
ng<br>mon.nuke36 (rank 2) addr 192.168.242.36:6789/0 is down (out of quo=
rum)<br>root@atom01[/0]:~ # service ceph -a stop mon.nuke36<br>/etc/init=
.d/ceph: mon.nuke36 not found (/etc/ceph/ceph.conf defines , /var/lib/ce=
ph defines )<br>/etc/init.d/ceph: mon.2 not found (/etc/ceph/ceph.conf d=
efines , /var/lib/ceph defines )<br>root@atom01[/0]:~ # service ceph -a=
 stop mon.rank2<br>------------------<br><br>something seems to be out o=
f sync, at least with the documentation?<br>any hint how to proceed from=
 here?<br><br>TIA<br><br>Bernhard<br><br><br><span>-- <br></span><div st=
yle=3D"background-color:#FFFFFF;color:#000000;">=0A  <table cellpadding=
=3D"0" cellspacing=3D"5" border=3D"0"><tbody><tr><td colspan=3D"2" style=
=3D"vertical-align:middle;text-align:center;background-color:#FFFFFF;col=
or:#FFFFFF;" align=3D"center">=0A         <hr style=3D"height:2px;backgr=
ound-color:#6f7072;color:#6f7072;border-width:0;"></td>=0A    </tr><tr><=
td style=3D"text-align:center;background-color:#FFFFFF;color:#182983;" a=
lign=3D"center">=0A        <br></td>=0A      <td style=3D"text-align:lef=
t;padding-right:10px;white-space:nowrap;" align=3D"left">=0A        <fon=
t color=3D"#000000" face=3D"sans-serif">=0A          <small>=0A        =
    <b>Bernhard Glomm</b><br>=0A            IT Administration<br><br></s=
mall>=0A          <small><small>=0A            </small></small></font><s=
mall><small></small></small></td></tr></tbody></table><small><small><sma=
ll><small>=0A                  Phone:=0A                </small></small>=
=0A                <small><small>=0A                  +49 (30) 86880 134=
=0A                </small></small>=0A              <small><small>=0A  =
                Fax:=0A                </small></small>=0A             =
   <small><small>=0A                  +49 (30) 86880 100=0A            =
    </small></small>=0A              <small><small>=0A                 =
 Skype:=0A                </small></small>=0A                <small><sma=
ll>=0A                  bernhard.glomm.ecologic=0A                </smal=
l></small>=0A              </small></small>=0A        =0A      =0A   =
 =0A            <a href=3D"http://ecologic.eu" target=3D"_blank"></a>=0A=
            <a href=3D"http://www.youtube.com/v/hZtiK04A9Yo" target=3D"_=
blank"></a>=0A            <a href=3D"http://ecologic.eu/newsletter/subsc=
ribe" target=3D"_blank"></a>=0A            <a href=3D"http://www.faceboo=
k.com/Ecologic.Institute" target=3D"_blank"></a>=0A            <a href=
=3D"http://www.linkedin.com/company/ecologic-institute-berlin-germany" t=
arget=3D"_blank"></a>=0A            <a href=3D"http://twitter.com/Ecolog=
icBerlin" target=3D"_blank"></a>=0A            <a href=3D"http://www.you=
tube.com/user/EcologicInstitute" target=3D"_blank"></a>=0A            <a=
 href=3D"http://plus.google.com/113756356645020994482" target=3D"_blank"=
></a>=0A      =0A    =0A        <small><small>=0A          Ecologic Inst=
itut gemeinn=C3=BCtzige GmbH | Pfalzburger Str. 43/44 | 10717 Berlin | G=
ermany<br>=0A          GF: R. Andreas Kraemer | AG: Charlottenburg HRB 5=
7947 | USt/VAT-IdNr.: DE811963464<br>=0A          Ecologic=E2=84=A2 is a=
 Trade Mark (TM) of Ecologic Institut gemeinn=C3=BCtzige GmbH=0A       =
 </small></small>=0A      =0A    =0A         <hr style=3D"height:2px;bac=
kground-color:#6f7072;color:#6f7072;border-width:0;">root@nuke<br>=0A  =
  </div><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3DUTF-8"><title></title><style type=3D"text/css">.felamimail-body-block=
quote {margin: 5px 10px 0 3px;padding-left: 10px;border-left: 2px solid=
 #000088;} </style>_______________________________________________<br>ce=
ph-users mailing list<br><a href=3D"#" id=3D"123:ceph-users-idqoXFIVOFKIjjVqG0RrOw@public.gmane.org=
om" class=3D"tinebase-email-link">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br><a hr=
ef=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=3D"=
_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br></=
blockquote><br><br><br><span id=3D"felamimail-body-signature">-- <br><di=
v style=3D"background-color:#FFFFFF; color:#000000;">=0A  <table cellpad=
ding=3D"0" cellspacing=3D"5" border=3D"0">=0A    <tbody><tr>=0A      <td=
 colspan=3D"2" style=3D"vertical-align:middle; text-align:center; backgr=
ound-color:#FFFFFF; color:#FFFFFF;" align=3D"center" valign=3D"center">=
=0A         <hr style=3D"height:2px; background-color:#6f7072; color:#6f=
7072; border-width:0;">=0A      </td>=0A    </tr>=0A    <tr>=0A      <td=
 style=3D"text-align:center; background-color:#FFFFFF; color:#182983;" a=
lign=3D"center">=0A        <img alt=3D"*Ecologic Institute*" src=3D"data=
:image/png;base64,/9j/4AAQSkZJRgABAQEBKwErAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQ=
EBAQEBAQEBAQEBAQEBAQEB%0AAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wB=
DAQEBAQEBAQEBAQEBAQEBAQEBAQEB%0AAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB=
AQEBAQEBAQEBAQEBAQH/wAARCAB4AIEDASIA%0AAhEBAxEB/8QAHwAAAQMFAQEBAAAAAAAAA=
AAAAAUJCgQGBwgLAwEC/8QAVhAAAAUDAQIFCBUJBwUB%0AAAAAAQIDBAUABgcICRESFCExUQ=
oTFTVBcXSRFxgaMzlTVFVYYXKTlJixs7jR0tbhFkJzeJensrfX%0AIjJSgaHB8DpHSFZjd//=
EABwBAQABBQEBAAAAAAAAAAAAAAAEAgMFBgcIAf/EADgRAAICAgECBAMC%0ADAcAAAAAAAEC=
AwQABREGEhMhMUEHFBUiUQgWFyMyVVZhlJbT1CQ0cbHB0fD/2gAMAwEAAhEDEQA/%0AAJ/Fe=
RlDBv3EMPeKI/IHyb6FD8ESB0mKHjMAf87/AE7q9aYygM5UDfuRXHvIHH/YK/PG1fU7n4Mp%=
0A9VKNFMYncbV9Tufgyn1UcbV9Tufgyn1Uo0UxidxtX1O5+DKfVRxtX1O5+DKfVSjRTGJ3G1=
fU7n4M%0Ap9VHG1fU7n4Mp9VKNFMYncbV9Tufgyn1UcbV9Tufgyn1Uo0UxidxtX1O5+DKfVX=
iaUSIcU1D9bUA%0AQAyahQIcOEACG8ph4QbwEBDeHKAgIAICFK9Ns5o1NxtkZzu+w13yaS8M=
e3AOkKnBMXslasFLE3hv%0A5N5X5Te2BgHu8rGONpOk1ADcYDd4Q3h3/H0AHt1VAICG8K1ax=
jldrdCKKibgqnDAohuOA8/L/i7v%0AJv727nrZhkuCyZTAO8DBv9rm5w9ro5uQQ6KYyuooop=
jKF0bcoiH/AN0A8ahA/wBvFVdSc789b+Et%0AvnApRpjE2ZmYi3YmTn5+Uj4SDhWLqUmJiWe=
N4+Lio1iidy9kJF+6USasmTNumou6dOFU0G6KZ1VT%0AkIUxgUCnIcoGIYDFMUDFMHMYogAg=
YB5hAQEBAQ5NwgPdrSzaTAA7PLXQBgAQHSHqMAQHmHfiO7ai%0Ao7CrbynssLO0W63ruOraB=
+x9vYKz/cTwxlbUUHrbSMxrlOSdKCK1rqB1ttZ98OFBcW6vwIK4xcQT%0AhhK230Dp/wCHe6=
6o6U3XUukU3ZdDdjhu6qOMtalpyVvHa3T4J8eSuQ3i1QviPF9uEu6GJ8Ta29el%0AfrUrJ8N=
bURaOcnhFkD9gjk5/RD+zk8BuA3APcJwdFeSKpFiFUTORQhyEUIomYDpnIoUDJnTOURKc%0A=
hyiBinKIgYBAQEQEKty8b3s/HsC8um+rngrQtxgAccm7jlGcRGIGMBhImZ29WRRFZQCHBJAp=
jLqi%0AUwJJnEN1c/8ATMtl0UVr9jPVbptzLNKW5izNuOb5uBMqp+wkBc0c6lVSoEMosLZgZ=
VNy76ymQ6qw%0ANU1hSSIdU4FTKYwZ1fSDGLZuZGTeNY+PZN1Xb1++cItGLJqgQVF3Lt24Om=
g3boplMdVZZQiaZCiY%0A5igG+mMrKK1hhtaek24bvZ2DBahMVS15SMk3ho+32F2xrh6/lXb=
gjVrHsuAqKLp06cqJt2qSCpzO%0AFlCJpcM5ygOcL1v6ycbwLm6L/uu3rMt1oYqbiauWWZQ8=
cRU5TnTQB0+WRTUXUImoZNukJ11CkMJE%0AjAU25jLuorXnG+rPTPl+aG3MZZyxpek/vEE4W=
FumNXlHBi7+ERoxUVScPFCgAmMm1IsoBAMcS8Eo%0AjWwwcvLTGFQr9pXnGWtjal6h7SbvVE=
m0Y5w2CaQKbil47gXFkifk38m87s5ublERqahUATazrKF2%0Ax+qIoGEC8bwMABvHnNpuw2O=
/vh9fTTGSHtEGQHs7Gxhl1zH4ZERETGEfzS7+73d49Hd376e2t1UV%0AWSBhHfvKTn5+UPw6=
Omo9GzzUMMVFbxHzpEeURH80g93v/L01IPtTte29wn8hqYy76KKKYxOd+et/%0ACW3zgUo0n=
O/PW/hLb5wKUaYzSraS+h566P1RNRf8pLtrkjkKUUibwAf7Bd+/m/uhz9Af87o7+txt%0AJf=
Q89dH6omov+Ul21AJ2N+xsyLtH75b5EyAjNWDpDsiVSQvC+iJKsZXJcuzEqjjHeM1FUuC4cF=
AE%0A07vu0oGjrVaLFatzvLhcoMUPX34PHUOo6W6J613e7tpT19Pa02kkbgySuaTCOvXi5DT=
2Zm+xDCnL%0AOx9lDMvP+rali9s9dWrRmSWSu4AHoo8U8u7eioo82Y+QH7+BkiXqZHVXrSzZ=
hi78W5itSYvXTXh5%0AFC38QahLlfKoTLGVanbkc4TRXfFO5yHDW1HLlfR0ukod3YDQW9oyU=
g8jV7ai7fyztBswWBeO0Vsb%0AE+olhf8AcunDCdlR91SOObChZO4nd53rPMjyqB5aHjHTNc=
8IIOYJtIPCqAoRhHPocFE05s5k5B2L%0AMW4+wnjy0MUYptKFsXHdhQbO3LStO32hGUVDxLI=
o9aRQSLvOqusqdZ2/euDqvZKQcu5GQcOXzpw4%0AUaj1u4M1DYt1T4819aXrLXyhMQNrBYWW=
8XRoLLzdxWwBnaJHcZGtgNIyibpo8SbOCQqb2XjZGJgJ%0AMkW9jm8lwPNnWe+odT9Ubfea7=
UV9HU2FhpYaFcny8gpsTcExLbtsDYtCuscAnkfsVmLSybjrastK%0AjXqz2HtSQoFaVh9x5C=
J5dxjj8lTvLN2gckDhVbc1n5U0gXha9l3zo8wNlLDOoPGN32/OWvMWngV7%0AjOJlIZk6A75=
hMK26CbY7yPUTZykPJnYqyCSjJeMI4I0k3IBuDtCso3xqFmdBuk+OmpWx4bU+2ta9%0A8trs=
gUj3rlnIGh2jK3xRULuBozdBdMi5jniR0FJZnbSjhuok0WbrbBtdpnli9VYO2MZ6CtSy99SL=
%0A6PYTBLytuRhbStXjLlFF++fTSEWdd4yjiHUMJ5JG1iKgUDKLICAomvbaP6UcmZjb4iz1p=
74qpqA0%0A3XIrctqwztZu1SvSBWdxsk/t8HLpVu1CUbPohu7hyO3DZu7ReTcWLlstJoOm+r=
n1APl6+rc8HgcH%0Ay9PMe/l5nJvt9/p7ccjy5/8AensffNkbK0LaRMex9ntLX094taPLDkI=
Wbtu5XFpRb69Gk9b7ls+j%0AJ9e9HiC9zvZpJ80QeKyDyVWWXXKPXRMkIpU1ledntdeu1Svz=
DmW3D+UwPpRs+OkUcdA9dNYm6bkf%0AsLWfiaRRbLIHM1kZG5BNMLkODh1G2wxhgUIxk3HB2=
cx3tKMk3POWJjy5dCupm3MkT10WxbN29dtK%0AVTse128rMMoycu1SccQ/ZQISEaOHM8oi6h=
0ECMmxkFJsEijJDj/UxhfPumbWKGvLThjt/mq3L4th%0ACz8+4lt8VTXW8aoNYlgnPQTJui7=
fSBzoQNvKt3ETHyr6JfRavHYleGkZFwkHPJ59eOB5+5444Pn7%0Ac8f74PoOPTken3D92Vu0=
b0IYDjtNl55lw5j61MK5WwTCmyBat1YvhY+x1XTG2jpvZOGlm9vIx7SQ%0AFWPSUWhZNdEZa=
GmG7JZo+KwXlY+S3q0O5jnM+6UMJZWugQPc1y2gkhcjgC8Er2ft589tqZkSEER4%0ABJKRh3=
L8hBERKRyUomMICYWxtQGo/Uxr3sR3po086Vcx4vjsinZQmUcp5qglrTt61rYByi5nI1u4%0=
AMmZitx1BEyLsSvlZ59H8bYRNunfO03Dd4fAOH4PAOGccYbtxVRzFY+taNt9N8sQE15N23SB=
STlly%0AAIlI4lpNV5IrlKPBBVycA5Ar4f0Rz6kkjz9j/wBn/nA9fL044/dz5ceX+nv92Zfr=
n/7Wn0ZHVF4Z%0AgX6NmG66AFc//a0+jI6ovDMC/Rsw3VOVY99s8u1UV+hR/hTqQnana5t7h=
P5DVHs2eXaqK/Qo/wAK%0AdSE7U7XNvcJ/IamMu+iiimMTnfnrfwlt84FKNJzvz1v4S2+cCl=
GmM1a1xP7KitGGrGUyTbcreOPI%0A3Tjmh/fdpQUz+Tk1dFns8d3C4uW3om4OLu+wcjMw6by=
PZy/FnAxzhwm8BI4ogUWdrv2zOC9FWzT0%0AP6mcfaRpaKxNnhZSwbBwhad6W7ADjONgYO5J=
NLjEua3V2Mz14tuLAuoixbu3Tx+d88cuFzLqKOt7%0ASL0PXXL+qNqK/lLdtQk9oMYC9T7bH=
gxhApS5DuQxjGHcUACy8niIiI8gAABvER5g5a7p8LeltP1N%0AT09Tcw2bVW11/Brp6yXrte=
B60vS24uP+ZrzxRrOZ6VYiyqiwI0aFZRFI6NrO7u2Kcth67Ijx6l5l%0AcxRuwdb1aMfadGJ=
XslcFOewkhiO4KQ5z5roxT7CLJX7ZLS+51A9Vz4pHk8pFkr9slpfc6mgcXbLf%0ASbpw0lYz=
1lbVjM+U8exmeGqMhg3TbgVhCHy/dMU8Ypy0dL3BI3NFTLOKTUhnDKYl4wkYwJb7GUim%0A0=
rcKE67ThDrMrsuNGGtDTdlrUBsnMxZnua/8BRCtx5S0qah2NvLZKfW8i0dPzSNgy1rQ8Ig+W=
ds4%0A6RGAj1W04ncEmxcQvZeJlVo9g87M/Q/wFSaQt0/ujqotj9Jl6kE/Up6ci2IsCoa77U=
XfCCLbIqvd%0ACnXpYPhNbVh5a59T6o7R/i63jtF44p9tL5sxdgkDeB4fdyY/tiPnxSvJEfH=
GOyea5sU+wiyX+2W0%0A/wDezt1fR6rnxSP/AIRZK/bJaX3OpgTZi7MmztXVg5q1Xanctu8B=
aI9OTQVsh5Dh2rZzdd3y6Uej%0ALOrasc0gzkmDdVmxeRZFpU8PcCz2am4e3IOClpVy5Ix3O=
07aAtjdtDMsQWGdHeftWmLcmMJpCWkb%0AM1BNrCVTy3jOHXKreSmMJyEtZJOCyDGQJXs+gy=
nW8wyUaMTF7BA3K9fx93a9A/ArUWtrXm6b31qL%0AQqn13Ya6Xqa9rdPI8K2FgvW4LrKkwge=
OWdYllFSOVXuNXXkrTBtep50gdblVGtf5WKZaUU1gBgnd%0AEjRglSwKoSVMhDCIOeBj7Gin=
qk7DOr7UZZeA5TT/ADGC2N3MrjeK5Lv/ADJZ35LQY2/CupdNB8Ve%0ADhEjKyZ2wMWgGkkBF=
wqTggqbcmbGmoTqpHD+Cs65dwuz0rXdkdpivINzWK1v+2MyWeFu3kjbsitH%0Ap3HCdZtqRT=
CMlCpcZaAnIPC9ZULucK/3qjnWPs1MLXPtrZ3ZsvbxyajhiLyXelmIXg2kLWDJh462%0A8XO=
73ZOFpBW1VLXF4rKoFauTktYiBmBjFSbpORBcMT4z2Xt7akdppnPQXgCXct7Ww9mHMluTeTr=
6%0A6y7LZ2JsW32+tILvus0O0i2snPyHBiY5hExLSOCYn5IvF0I6IbSLuOtr8Lvgquznu2Et=
V9OnROu6%0Aoajat7eGvWoXbNgx7Z9iNgbTTzRx/LNrO1ghRHiDSy9uVfW+ozCkSFGsHZS0h=
KkddneWOOPmDwvC%0A7Ailu/xuQT3EEhV5EijzXNinkHykWSt4cw+TJaXJ3P8A07o5Px5afl=
2Xe0Xt/ab4Au/PVt4snMRM%0AbSzBP4iWtufuaOup49dwNl4/vJSbSkYyMikEWrlG/kGBGZ2=
xlk1Y1ZcyxiOEyJwnMq4U6n3wncl0%0A4Ql87a78sZDs0svbs9mnGbPF5MVqX/DprtHDeBhX=
1pOXj620ZtAWbxZCQmSlKm4BhcMgiCT48hfq%0AUoEQ2eubQbGOZsGtjJQNjK7gVM3DCWnYE=
TKgUAKChk+CJwKHB4QjwQANwBo3xL6G+H+u6DudQdMd%0ALb/SW4b+ojr2919ZrpbqX2m/OV=
YNjbmV1dIwziWGKxCHjLRp4i85PTbPazbSOpdvVbMbRWC8db5d%0AjHJEE8pGijUggseO1ij=
EMASF8pN1c/8A2tPoyOqLwzAv0bMN10AK5/8AtafRkdUXhmBfo2Ybry7m%0A7Y99s8u1UV+h=
R/hTqQnana5t7hP5DVHs2eXaqK/Qo/wp1ITtTtc29wn8hqYy76KKKYxOd+et/CW3%0AzgUo0=
nO/PW/hLb5wKUaYzSzaReh665f1RtRX8pbtqEptBDop9T87HVRy1F82TyNcKjhkAgAvECWb%=
0Ak4yzQBMIFAXKYGR3mEADh8o7qm17SP0PTXMPRpF1FD4sSXbXMey7rzzLm3R/pu0V3bB46Z=
4n0vy7%0Audx7MQEJcDK/JF4/i52KWJdsw+uuTg5JuDe4Xp0yRVtQahVk2xjKnImdNX1V+D7=
pru0pV7VRYzDp%0AOvKm0vF5PDZav4sbijzEOOZJPHuwDsBUhCz8/Z4Oj9V2Y4JXSQnus6qS=
CLheQZPnq0vDfcOyNjyf%0Afge+Pf8AVKjCYyRE7OXU7Yqy1xaabu0xp2zZNwxIHXtmEuuQW=
h7sVSVVT3to55eFqrwBWCRgKo+T%0AsKRREoGiQJSB1LtB3JbepnUvqJmHSltYBxXpnuVnlG=
9pRRRhaTKQdT8FcsYL+RU4LJRaCt+17qmn%0ARAOdaNjjncHImm7KY7aOkDa26mNJGLX2n48=
BiTUXpwfPF35MEakLNVyDY8G8dOTPHLq0zoSsPMW6%0Aod2os9SZIyDmCQkHLmQThuOrGXpZ=
1UbYXUpqUw66032xZWEdLOnWTXI4uPEWmWx3Fgw17HIqmuBb%0A4lHkxNS86iosk3F3HtXET=
DyJGbEsnFvTtSKj2P8AE3q1OjZ/hilHWNqJpLFFOq22ABTRWdpJfeST%0AS/K+O+7jryPXVF=
nFJ7QW21sAsma79RoHYrujLOJ1WOU0RF62o4FiCix39vyxZQ5JXxAnMYj9DjtG%0AO41fUd1=
NXqqt7ThEO3UvZGrO58m35jyBaHUuEuOGmaLayckweRLIplwLb+P3MNdajApDh2NtNwk2%0A=
KqdMiQtXbCnFuTsl7UDS6+x1DSz5lje9Vcg5Cl2KC/Y23rDgYp8ScdTj8hQasW8gLxtCtEna=
iQyE%0ApJMo1sVV27QQPZ2zazFtJtNK2Ts96D7SyBeVnQq9u2xm+EgrGdZNsOQM9QkZG2W97=
Wa1TcvBccXQ%0AlSxc9Epspdkgu7aN5Rsm7Eij9+zc1PbUzWjq8xawlsFWXpC0w2HejHK2pK=
RxVp3fad7VvmOsxq/k%0AY6EvW57pM9ua53ExKOEkhgmc4aNVA7iRlmSbFiuuhA3ybXpDUfE=
+jUm6at6jczbrctsL+8MGx1E+%0A409eG5rburSpPLetMIozqESxC9r5ivHM0SlTl2oYL9jS=
yut2OxWWvXEUVbvhsLXnYxyxzmRBEn2j%0A8wSjBOx2Xk5g7En/AFXV3/8A73lX6PslWyuys=
uCJc7Vzbt4hiphnBZkytcGf/IneLLFSfKr2zmLK%0ArKZUjQHcdRSGkrvtSVdJI71TNw4wJD=
JM1DpsPZ/1+y2JtsVn/XbpqJZl2uITPGTHWOHV5x8tNWXc%0AsMeFf4yJPrMIWateWcxs3EJ=
rz0KKUvHrJkeMVHJTgRVufRaU1XZrW1U3TrLta5hxpnW58t3dmkJ/%0AHgvYZlAXfes3Jzs2=
3gWr9/LuiW8spMSEYMPLyEwm7hXCsbKKyKKy4qyJfh5tuoNWIpHioRX/AIUd%0AH9PwyT8tJ=
BvNNsDt/Bt1e3v+U8Ra8NkglijToqd6jmhdtBUnLANK0W92FtgvkGrWIRX7o3Pl4nHe%0AU5=
8ue0k8E5ga4bTubH0/MWFfMJJWxetnybu2LptuaQUazENcMMueOlI1+2WAFiumz5usicRAwK=
iU%0AFCGOQ5TD0AOpQ/Q7sze1rRyIA9ID5B2nTkEO4PSA1HTltvzmW8U/yiyhos2f2U8zBFH=
ijZwvDBUm%0ArekgZRmLLszNt4+8mUW+nU0xAzd0xSiWDYySBG8YkiiCRpGvUqDpR/s+85Pl=
ipEVfa3cnPVSIE62%0AgRR3hXTw4ORFPebraJDKCVJPhG4BAKXhDu3jgvjle39z4Y7Ab7RQa=
aaHbaMK1baw7OC3M0s/zDwd%0AkEEsNdCqGI2VSZxIVeJDGWeV0zFVj3UXytl7CtBa5DwNC0=
ahU7A5LsrOeWDdhKgryGIYcSaq5/8A%0AtafRkdUXhmBfo2YbroAVz/8Aa0+jI6ovDMC/Rsw=
3XhbOnY99s8u1UV+hR/hTqQnana5t7hP5DVHs%0A2eXaqK/Qo/wp1ITtTtc29wn8hqYy76KK=
KYxOd+et/CW3zgUo0nO/PW/hLb5wKUaYyy8j48s/LePr%0A4xXkOHLcVhZItK4bFvSAM+kow=
s1at1xLuDn4o0lDPI6XYBIRb501F5FyDKQbAr15m7buCJqkaQDq%0AebY+AAAGkLcAAAAHk/=
aoOYOQP+9dPR0Vm9V1L1Hoo5YtJ1Bu9NFYdZJ49Vtb+ujmkVe1XlSpPCsj%0AqpKqzhmC+QI=
GRp6dO0VazVrWGQEKZ4IpioJ5IUyIxUE+ZA4BOMu+Z59j77EP9/2qD+tdHmefY++x%0AD/f9=
qg/rXT0VFZX8ofX/AO3PWH8zbr+9yx9J1X6s1/8ABVv6eN8abdlrom0gSr+W0046yLiA8u7R=
%0AfzsVa+prVJ+StxvWrRVizd3PZcnmiQtC5XDFosqiwWnoOROxKcwtDIm/tVn/AD1pYw5qY=
tN7YmYm%0AuR5uzJRoePmrYtnO+dsYwlwRyqQJLR1yR+Lck2Y3uOPcEABcsZwkg1cqB15dFR=
b+3WxFFYafqDfW%0Ar6bW1u9vZ2kZUx7KfZXJr8ZTgIUuSTNYUoAApWQFeBxxwMkLUqpEYEr=
V0gPIMKwxrEQfUGMKEPPv%0AyPPGXQ6nn2PgcgaQ/wB/2qD+tdHmefY++xD/AH/aoP6109FR=
WZ/KH1/+3PWH8zbr+9yP9J1X6s1/%0A8FW/p4y75nn2PvsQ/wB/2qD+tdOC6UNG2m7Q/juax=
Ppdxx5GFgXDekjkOYgPyvvy9eOXhLQduW3I%0ATHZXId0XbNN+MQtpW+y7HtZFCLS7H8ZQZJ=
u3b1dzs7RUDZdXdV7mqaW36n6h2tNnSRqmy3WyvVWk%0AjJMchr2rMsRdCSUYp3KSSpGXYaF=
Gu/iV6VSCQAgSQ1oYnAPqO9EVuD7jng++Fc//AGtPoyOqLwzA%0Av0bMN10AKgCbWdFQ22P1=
RGAoiXjeBhAdw85dN2Gw3d8fr6K17JePc7PLtVFfoUf4U6kJ2p2ube4T%0A+Q1R8NnmmYIqK=
3gPnSIcoCH5pA7ve+XoqQfana9t7hP5DUxl30UUUxiTKgbrCgkMYpwABKYoiUxT%0AF5SmKY=
OUBAdwgIbhDdvAd9Nl6rprKbGKkDWlft9W+qCanWzwF1T8SoQdw7hKePkG5iiG7kEohu6Q%0=
Ap0Jyn1wggPMIbh3c/wDzl/06d1YByNjltcjZZNREqnXCmDlLvDcID7Q8nLu5x593NTGQzc/=
5N15N%0AZl6S39V2qiHRBVQCJxOe8sxyZQ4XIBSM7sRKHJzAAByc1afL5c2kQKDwdaWsoA3j=
yBqVzWUA9rkv%0ATl3c3+VS9r00aQ826WWPGpGE5jCIikA8ojv6Pb6OisYH0GQJjCPYtH/JD=
6gDvf5UxkVLyXNpJ7NL%0AWX8ZfNf31o8lzaSezS1l/GXzX99alVeUKgvWxL3j8KPKFQXrYl=
7x+FMZFV8lzaSezS1l/GXzX99a%0APJc2kns0tZfxl81/fWpVXlCoL1sS94/CjyhUF62Je8f=
hTGRVfJc2kns0tZfxl81/fWjyXNpJ7NLW%0AX8ZfNf31qVV5QqC9bEvePwo8oVBetiXvH4Ux=
kVXyXNpJ7NLWX8ZfNf31o8lzaSezS1l/GXzX99al%0AVeUKgvWxL3j8KPKFQXrYl7x+FMZFY=
Ty5tI+GG/WlrL3d3fqVzWbk735aD46VbExJl3ImSHGQcp3N%0Ae2Rr5nV40Z29L+uGbvC7Jk=
YuOZQ0b2WuO4XkjMSQx8PHMIpjxx6txSNYs2LfrbVsgkSUmXQXAgIC%0AMWl7x+Hc56vy1dF=
MLFOUliRiReCYOUEQDmEN3cDn+qmMx1ogx+9go2MKugYnAIiAgYoh+aXf3O5u%0AHp7u/dT2=
1upCkyQKIbtxSc/PyB+PT01gDGOKGtroopptyp8ACgG4gBzcn+Hucm/v7+etmGSAIplK%0AA=
bgKG72ubmD2ujn5ADppjK6iiimMBDfyDVMo2IoHKAG5+QQAeX/nRu79FFMZQHiG5xERRIO/u=
7i7%0A/wDUBry7BtPSCeIn2KKKYw7BtPSCeIn2KOwbT0gniJ9iiimMOwbT0gniJ9ijsG09IJ=
4ifYoopjDs%0AG09IJ4ifYo7BtPSCeIn2KKKYw7BtPSCeIn2KOwbT0gniJ9iiimMOwbT0gni=
J9iv2WHbF3bkScggP%0AMXud4oc1FFMZXpNU0wDcUC94A3j3/F0iHtVVAAAG4KKKYz7RRRTG=
f//Z" height=3D"120" width=3D"129">=0A      </td>=0A      <td style=3D"t=
ext-align:left; padding-right:10px; white-space:nowrap;" align=3D"left">=
=0A        <font color=3D"black" face=3D"sans-serif">=0A          <small=
>=0A            <b>Bernhard Glomm</b><br>=0A            IT Administratio=
n<br><br>=0A          </small>=0A          <small><small>=0A           =
 <table cellpadding=3D"0" cellspacing=3D"0" border=3D"0">=0A           =
   <tbody><tr>=0A                <td style=3D"white-space:nowrap;"><smal=
l><small>=0A                  Phone:=0A                </small></small><=
/td>=0A                <td style=3D"padding-left:5px; white-space:nowrap=
;"><small><small>=0A                  +49 (30) 86880 134=0A            =
    </small></small></td>=0A              </tr>=0A              <tr>=0A=
                <td style=3D"white-space:nowrap;"><small><small>=0A    =
              Fax:=0A                </small></small></td>=0A          =
      <td style=3D"padding-left:5px; white-space:nowrap;"><small><small>=
=0A                  +49 (30) 86880 100=0A                </small></smal=
l></td>=0A              </tr>=0A<!--=0A              <tr>=0A           =
     <td style=3D"white-space:nowrap;"><small><small>=0A               =
   Cell:=0A                </td>=0A                <td style=3D"padding-=
left:5px; white-space:nowrap;"><small><small>=0A                  +49 (1=
70) 3217628=0A                </small></small></td>=0A              </tr=
>=0A-->=0A              <tr>=0A                <td style=3D"white-space:=
nowrap;"><small><small>=0A                  Skype:=0A                </s=
mall></small></td>=0A                <td style=3D"padding-left:5px; whit=
e-space:nowrap;"><small><small>=0A                  bernhard.glomm.ecolo=
gic=0A                </small></small></td>=0A              </tr>=0A   =
         </tbody></table>=0A          </small></small>=0A        </font>=
=0A      </td>=0A    </tr>=0A    <tr>=0A      <td colspan=3D"2" style=3D=
"vertical-align:middle; text-align:center; background-color:#6f7072; col=
or:#FFFFFF; white-space:nowrap;" align=3D"center" valign=3D"center">=0A=
            <a href=3D"http://ecologic.eu"><img title=3D"Visit our websi=
te" alt=3D"Website:" src=3D"data:image/png;base64,iVBORw0KGgoAAAANSUhEUg=
AAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAl=
wSFlzAAAOwwAADsMBx2+oZAAAAAd0SU1FB9wMBAoOC+d8fXIAAAKjSURBVFjD%0A7ZfNS5VB=
FMaf8WMRejWktIWEiyDQokITJY2E6C+oZWFC/0DtatcuMiGiZR+6itB/oIKghe36kFLK%0AW=
5lkEYGF5r2m6a9Fj/T6Yqb3vlaL+2zmnXnPmXnOzJlzzkgFFFDAxiLkowwUSyqXVOqheUnZE=
MLc%0AhjMHiiLfO4EzwF3gC7DIT0wBg8B5YN9KukmT2gxcAKb5hQlgFvgKjLIcV4HqjSLTAI=
x4oaduh4Aa%0AIA28MOEn/jfodhxoTvSYgD3AZyALdAA3vFir/78BxvzdBCxYptl6GWB/Isc=
HbAWGTaAXaLevXIzI%0ApIFXkf4lH2sLcNm6o0BNErvU7QnvAN8i/jEAdJrgB/tSK3AUuBmR=
WwQe+LsnXzL1nqjf/fYVHHfW%0Aiy74aKJ4DRwGioDbHqvPh9BZT9LifhXwDrgGVJpgFzBpX=
+kCjgB1QB/wFqi0bovnOpcrmVLfosdA%0ARWSHADpjsmkgHRs7FTMm5bkeASW/W3c1jy+TtF=
vS/RDClMeK3T5bg01j0WwQQpiWNCipQdKmdacO%0AYIukT5JmJL23bIWkavczJrgoabvVxm3=
kgqSUpBpJHyVN+3+tJCTVhhAm17tD+WIhZjQmX5JTDnXU%0AXXZVgUMea1qDD3VY9kBk7IpD=
RyoXH5qxrxwEymNW71qDTTuiOkCZpFZJw5Ky6yYUQpiXdEtSox1R%0Akp5LmpDU7mvfBpyQV=
CWpCjjuuFMnqc0+NRIxolHSQAjhe76BcSBy7V/Ggt9cJDBmNzQw/iF19AMn%0A7VdLqaMNOA=
ZcjxFLJnUsXf/Irqw1uXZbpgXoiezWtqTKj72uDJfKj95Vyo9GH2Gfy49J57jmRKvH%0AWIE=
29E8KtP+9hI0X+aeBezFyGeBhPkV+Es+gVOwZlPkrz6ACCiggR/wAnDhVsuP7eLUAAAAASUV=
O%0ARK5CYII=3D" height=3D"36" width=3D"36"></a>=0A            <a href=3D=
"http://www.youtube.com/v/hZtiK04A9Yo"><img title=3D"Watch our video" al=
t=3D"| Video:" src=3D"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQA=
AAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzA=
AALEwAACxMBAJqcGAAAAAd0SU1FB9wMBAoOGGPCPKwAAAB6SURBVFjD%0A7ZU5DsAgDAS9KP=
//LFS4cJo0iRJycMRIOzVaDIyNCCGEkB24W2Bm9igIQIuCwqiNhmEbrfKCtwOG%0AaaSueYY=
z7455V252v6Gc8yvHlt7Cu3Aoxvi587o4VDNI2fYsSEQkpeRzMJYyfpEaAFR17q+DEEKI%0A=
d1aawEGkmN8D6QAAAABJRU5ErkJggg=3D=3D" height=3D"36" width=3D"36"></a>=0A=
            <a href=3D"http://ecologic.eu/newsletter/subscribe"><img tit=
le=3D"Subscribe to our newsletter" alt=3D"| Newsletter:" src=3D"data:ima=
ge/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IArs=
4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9w=
MBAoMMRNGxkIAAAChSURBVFjD%0A7ZaxDsMgDERxFf7/g/I1DLciFiQGJHdq1SFNUmoSotyb=
kBDG5s4WzhFCyMAAUGsA6Nqd8m1DVbVn%0AsSKyePfUerCVrUIfo9nkPgnFGOeXkUMIaqL1P=
8b+7KyUku6Nex/Jcs7vdSnFnS5Za9zJcoZYzKyf%0AErIekpcwtalkS9RanfdeKBkTGsbUvT=
9qu19IRARAj2/xIc1BCCGtPAEkwLgtYjzXqwAAAABJRU5E%0ArkJggg=3D=3D" height=3D=
"36" width=3D"36"></a>=0A            <a href=3D"http://www.facebook.com/=
Ecologic.Institute"><img title=3D"Visit us on Facebook" alt=3D"| Faceboo=
k:" src=3D"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAAD=
hAJiYAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAADigAAA4oB=
p4z1HwAAAAd0SU1FB9wEFwgCHldMsUsAAADmSURBVFjD%0A7Zc9CsJAEIXfhKBYqGCj4B0s9=
AQewQN4CBuPaWlhrYWIlYKR/DybFcIaC7NxF2U+GJLZYvL2zSxJ%0AAEVRlLBIU4VIjgFEzx=
TAUURS7zsiOSB5IHkrxZXkpE692FHMEMC+ok5W1/3I0aBFSQzNNTdB7w4B%0AGJkHi4ktgKV=
xaBdCEK3WrERk41LQtWXpt07tp8M85SuFlc98OpSbOXnnzh3A2aeguGL+yqeqDeAS%0AonVr=
q01z15quQ92x8m5oQY2jglTQ3wlyfblmABJz3wJQBP2EJdkD0C8tnUQk0T8DRVF+mQc9yneK=
%0AZNh8QAAAAABJRU5ErkJggg=3D=3D" height=3D"36" width=3D"36"></a>=0A    =
        <a href=3D"http://www.linkedin.com/company/ecologic-institute-be=
rlin-germany"><img title=3D"Visit us on Linkedin" alt=3D"| Linkedin:" sr=
c=3D"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYA=
AAAAXNSR0IArs4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAADigAAA4oBp4z1Hw=
AAAAd0SU1FB9wEFwgDLmiOsKYAAAEQSURBVFjD%0A7Za9SsRAFEbP7G6ziqyIlYUiNhY+gC+=
wvoU+g80+g41PY2UhaGclFnZiZWMrrGjw79hMII6FCe5m%0AV5gDYb7ce5P7MckNgUwmk8k0=
Rx2op+qVujdrMwtq4Xd2ptWvU6NmBbByAOzPcoe66l2yQ8vz8B6N%0A1CN19T8Owa56qG5P4=
+aL/mQr5m6S+FC9TWKP6sGkp2ycNNmMuctK7C2un8lasj6pKatLr6LvgVCZ%0ASoCztg0BXI=
cQOiGEDeA4mipZUwdtGxqWIoQwSnJdYKlNQ09A8UtNaNNQqNOw7UdGNjQvhro14r0G%0A36k=
/FX0AJ0A/nveB56gvgIeoC+A9ufYcGEf9Crzk391MJpNpyBfHBeoJLzEVJwAAAABJRU5ErkJ=
g%0Agg=3D=3D" height=3D"36" width=3D"36"></a>=0A            <a href=3D"h=
ttp://twitter.com/EcologicBerlin"><img title=3D"Visit us on Twitter" alt=
=3D"| Twitter:" src=3D"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQ=
AAAAkCAYAAADhAJiYAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlz=
AAADigAAA4oBp4z1HwAAAAd0SU1FB9wEFwgEKbmrs8IAAAEeSURBVFjD%0A7ZaxSsRAFEXv1=
RUERW0WBLuFBa2t/A/9gG38B4v9BTt/wsbCxm7Z2k4LZWtFQcsVFdFjYYQQEyVs%0AMtmVOR=
BeMZO8Oy93Zp4UiUQiMwawCGxMi5g2cAc8A1dAp2lBp3zxkcSjqnPMlZy/nkQncbtpQT+K%0=
A9u8FtSZ8fxM4KVjY0PZh3aY+pxwjoBXyl/1FV9LSNAj69taDpJeQHnqSNEodA2luJR3Yfg0=
p6NL2%0ADjCfHbD93sQu25okeRUeyiZeBXpAZV50yW2/J+k4Y15LupZ0k1ngWFLf9kWd59AC=
8Ji6XItIj3fr%0APhx3c5L+xlmINqRXUI28Ku2H6o1WgAEwThq2vGdY9upwBcKWJa3lfOvN9=
n1s+iORyKzxCQPwTJ5S%0ABf6EAAAAAElFTkSuQmCC" height=3D"36" width=3D"36"><=
/a>=0A            <a href=3D"http://www.youtube.com/user/EcologicInstitu=
te"><img title=3D"Visit us on YouTube" alt=3D"| YouTube:" src=3D"data:im=
age/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAAAXNSR0IAr=
s4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAADigAAA4oBp4z1HwAAAAd0SU1FB9=
wEFwgFIjdiWwsAAAHTSURBVFjD%0A7Za7a1RREMZ/c3ddTdIn4APBysLYKmqRwkoE7VIoFj4=
bC/8AwUKsbCwsrG1sVBAsFJLKFBaCVqYz%0A8YGgVsEku25ifhbOwhoEsyt3NXA/GO55wJzv=
zplv5kCFChUqbDKoI+rOHI+qo/+a0Jg/0VDfqhf/%0AhyhNq9dVc35cHVeH1X3qLnX7IAkdz=
CjdUc+qa+qiOqG+VG+qV/vxXfTJ6TXQBKaAE8AEsAzUgVXg%0Ae9rACK0CAivA7iTX7tqPfq=
Nf/OXt1YFnQAMYSSKNJBqDJBTAcNpTYAb4DLwC9gBngK/9Ou41oYfy%0AR5oZjQJoATVga44=
70SsiYrkUQmoNeAgcBoYyh/7kuwU8iYhTZUj9stpS36jz6gd/xfuUfzc68/Nl%0A5NABYA64=
AkwCj9bt71+ntE6UBHaUldR7gdPAoSR1P2vRN2ABuJuqW8rEvj0Ila1k0ZsHHgDTwEdg%0AG=
3ABeAzcAm4AL3otkPUSOkuRkj+XJAdGyDw8frNey+tsAlvKurLOwWvZOsaBe8A7ILLeHMtie=
RK4%0Alt/SOvyllPAXda5L2otpC+qsupTrz9V2r7KPHklNAUc2UBS7/c9ExNEyW8dYtoyNoB=
0Rn6qHf4UK%0AFTYTfgDpBClAXl8czQAAAABJRU5ErkJggg=3D=3D" height=3D"36" wid=
th=3D"36"></a>=0A            <a href=3D"http://plus.google.com/113756356=
645020994482"><img title=3D"Visit us on Google+" alt=3D"| Google+:" src=
=3D"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAA=
AAAXNSR0IArs4c6QAAAAZiS0dEAP8A%0A/wD/oL2nkwAAAAlwSFlzAAADigAAA4oBp4z1HwA=
AAAd0SU1FB9wGEwowOnAZEbIAAAGZSURBVFjD%0A7Ze9Sx1REMVnnoqiWOhDIliIWPlRRBAt=
LIRA1D/AwkIkjYW2tvZW1vYmEAtBsLSxsQkhASEkFlYK%0AIlqIIIpEz89mxFUerxDfXYQ9z=
e7OXuaePffM3LtmBQoUKJAv/C2SAB1A07PE7gZ4qVQ6SvY1kiYl%0AnQBIugduJN0Ad8C1pP=
6UZFaDyHyoNAhcRmw76TpLGpcEsPFi6foISPr0mtylVxnPfdHdzcwOXsT/%0AmdnfeJxNRsj=
MRuJarmDwn3Fbl5LQXkw+XUG9NsDcfSuZh4ABnrCWiXeFf3aA+qTGBqaAK+Ae+AXs%0ABpnN=
3Loq0CLpo6QlSUTlDeXe7oHPmSX8LqkxTzKjkr5k+g/AKdCarMqAXmArtohldx80sxkz+xb9=
%0A6cNjJaZQpPtRDKC9wvuFjFKzNSUjqQ74EwYerkJ6JUit1lqdRuA4CHVXGVcOFedqTagBO=
AxC+1XG%0ArUs6S+WhiUzP+R0VNgb0AJPAV0nnQGfKUi8DP6JT30q6A/7HoWwxtyMs0Gxm5d=
hMr9z9ovgrKFCg%0AwHvHAwOPpj4eVQaJAAAAAElFTkSuQmCC" height=3D"36" width=
=3D"36"></a>=0A      </td>=0A    </tr>=0A    <tr>=0A      <td colspan=3D=
"2" style=3D"vertical-align:middle; text-align:left; background-color:#F=
FFFFF; color:#000000; padding-left:5px; padding-right:5px; white-space:n=
owrap;" align=3D"left" valign=3D"center">=0A        <small><small>=0A  =
        Ecologic Institut gemeinn=C3=BCtzige GmbH | Pfalzburger Str. 43/=
44 | 10717 Berlin | Germany<br>=0A          GF: R. Andreas Kraemer | AG:=
 Charlottenburg HRB 57947 | USt/VAT-IdNr.: DE811963464<br>=0A          E=
cologic=E2=84=A2 is a Trade Mark (TM) of Ecologic Institut gemeinn=C3=BC=
tzige GmbH=0A        </small></small>=0A      </td>=0A    </tr>=0A    <t=
r>=0A      <td colspan=3D"2" style=3D"vertical-align:middle; text-align:=
center; background-color:#FFFFFF; color:#FFFFFF;" align=3D"center" valig=
n=3D"center">=0A         <hr style=3D"height:2px; background-color:#6f70=
72; color:#6f7072; border-width:0;">=0A      </td>=0A    </tr>=0A  </tbo=
dy></table>=0A</div></span></body></html>

--=_fe7fbba5d5dc5fa6b5bdf92beab7a5d1--

--===============0331687445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0331687445==--
