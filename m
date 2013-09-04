From: Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: how to remove and re-add broken mon? SOLVED
Date: Wed, 4 Sep 2013 12:05:56 -0400
Message-ID: <CANtztVwrVQapfjAjOx5qnrQ0tfOWBQNScEmOTGQgAGXm9jBPtQ@mail.gmail.com>
References: <ee15755bb1292a720a84f58fdc80a31f7a75fd64@ecologic.eu>
	<086d868ba20ebd557ee3cf166c27295bb1c2c381@ecologic.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0858926144=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <086d868ba20ebd557ee3cf166c27295bb1c2c381-uSuf018nij3sq35pWSNszA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Bernhard Glomm <bernhard.glomm-uSuf018nij3sq35pWSNszA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0858926144==
Content-Type: multipart/alternative; boundary=047d7b472a40102cc504e590fb6c

--047d7b472a40102cc504e590fb6c
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2013 at 11:21 AM, Bernhard Glomm
<bernhard.glomm-uSuf018nij3sq35pWSNszA@public.gmane.org>wrote:

> Removing a monitor, also like described in
> http://ceph.com/docs/master/rados/deployment/ceph-deploy-mon/
> doesn't work
>
> ----------------
> root@nuke36[/1]:/etc/ceph # ceph-deploy mon destroy nuke36
> [ceph_deploy.mon][DEBUG ] Removing mon from nuke36
> [ceph_deploy.mon][ERROR ] ceph-mon deamon did not stop
> [ceph_deploy][ERROR ] GenericError: Failed to destroy 1 monitors
> ----------------
>
> is this, I can't destroy the mon on which I run the destroy command?
> (I could destroy
> but since I just added another two monitors to my cluster,
> the broken first one is alive again...
>

What OS is the nuke36 host?

There are a bunch of commands that `mon destroy` will call on the remote
host, but unfortunately, this is one of the commands I have not fixed yet
to use the new remote logging to tell you.

Can you try to manually run this on nuke36 and see what is going on?

    sudo ceph --cluster=3D{cluster name, defaults to ceph} -n mon. -k {path
to keyring}/keyring mon remove

>
> well that should do as a work around for now
> (since I'm using the dev branch and do only testing stuff)
> still, would be curious if I could have repaired it any other way.
>
> Bernhard
>
> Am 04.09.2013 12:40:04, schrieb Bernhard Glomm:
>
> Hi all,
>
> after some days of successful creating and destroying rbd's, snapshots,
> clones and migrating formats all of a sudden one of the monitors doesn't
> work anymore.
> I tried to remove and re-add the monitor from the cluster, but that
> doesn't seem to work either.
>
> Here's the situation:
> I liked to use ceph-deploy to initiate the cluster.
> Due to the broken ceph-create-keys in dumpling I turned to the gitbuilder
> version
> now running
>
> ceph version 0.67.2-23-g24f2669 (24f2669783e2eb9d9af5ecbe106efed93366ba63=
)
> on uptodate raring systems
> All of a sudden the host from which I ran ceph-deploy, and which should b=
e
> one of the
> 5 monitors (from which 2 are also serving as OSDs) has fallen out of the
> quorum as you can see here
> (yes, time is in sync on all nodes):
>
> ------------------
> root@nuke36[/0]:~ # ceph -s
> 2013-09-04 11:09:56.039547 7f7a8820f700  1 -- :/0 messenger.start
> 2013-09-04 11:09:56.040646 7f7a8820f700  1 -- :/1016260 -->
> 192.168.242.92:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0
> 0x7f7a8000e8f0 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.041304 7f7a84a08700  1 -- 192.168.242.36:0/1016260lea=
rned my addr
> 192.168.242.36:0/1016260
> 2013-09-04 11:09:56.042843 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 1 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 776+0+0 (224=
1333437 0 0)
> 0x7f7a70000c30 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.043038 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 2 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=
=3D=3D=3D 33+0+0
> (2063715990 0 0) 0x7f7a70001060 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.043324 7f7a86a0c700  1 -- 192.168.242.36:0/1016260-->
> 192.168.242.92:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0
> 0x7f7a74001af0 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.044197 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 3 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=
=3D=3D=3D
> 206+0+0 (3910749728 0 0) 0x7f7a70001060 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.044375 7f7a86a0c700  1 -- 192.168.242.36:0/1016260-->
> 192.168.242.92:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0
> 0x7f7a740020d0 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.045376 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 4 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=
=3D=3D=3D
> 393+0+0 (3802320753 0 0) 0x7f7a700008f0 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.045457 7f7a86a0c700  1 -- 192.168.242.36:0/1016260-->
> 192.168.242.92:6789/0 -- mon_subscribe({monmap=3D0+}) v2 -- ?+0
> 0x7f7a8000ed80 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.045550 7f7a8820f700  1 -- 192.168.242.36:0/1016260-->
> 192.168.242.92:6789/0 -- mon_subscribe({monmap=3D2+,osdmap=3D0}) v2 -- ?+=
0
> 0x7f7a800079f0 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.045559 7f7a8820f700  1 -- 192.168.242.36:0/1016260-->
> 192.168.242.92:6789/0 -- mon_subscribe({monmap=3D2+,osdmap=3D0}) v2 -- ?+=
0
> 0x7f7a8000fa10 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.046376 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 5 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 776+0+0 (224=
1333437 0 0)
> 0x7f7a70001290 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.046417 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 6 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=
=3D 20+0+0
> (1524320885 0 0) 0x7f7a70001480 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.046429 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 7 =3D=3D=3D=3D osd_map(22..22 src has 1..22) v3 =3D=
=3D=3D=3D
> 2355+0+0 (11792226 0 0) 0x7f7a70001f70 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.046828 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 8 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=
=3D 20+0+0
> (1524320885 0 0) 0x7f7a700008f0 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.046948 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 9 =3D=3D=3D=3D osd_map(22..22 src has 1..22) v3 =3D=
=3D=3D=3D
> 2355+0+0 (11792226 0 0) 0x7f7a700008c0 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.047071 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 10 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=
=3D=3D 20+0+0
> (1524320885 0 0) 0x7f7a70000df0 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.047547 7f7a8820f700  1 -- 192.168.242.36:0/1016260-->
> 192.168.242.92:6789/0 -- mon_command({"prefix":
> "get_command_descriptions"} v 0) v1 -- ?+0 0x7f7a8000b0f0 con 0x7f7a8000e=
4e0
> 2013-09-04 11:09:56.050938 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 11 =3D=3D=3D=3D mon_command_ack([{"prefix":
> "get_command_descriptions"}]=3D0  v0) v1 =3D=3D=3D=3D 72+0+24040 (1092875=
540 0
> 2922658865) 0x7f7a700008c0 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.089981 7f7a8820f700  1 -- 192.168.242.36:0/1016260-->
> 192.168.242.92:6789/0 -- mon_command({"prefix": "status"} v 0) v1 -- ?+0
> 0x7f7a8000b0d0 con 0x7f7a8000e4e0
> 2013-09-04 11:09:56.091348 7f7a86a0c700  1 -- 192.168.242.36:0/1016260<=
=3D=3D mon.3
> 192.168.242.92:6789/0 12 =3D=3D=3D=3D mon_command_ack([{"prefix": "status=
"}]=3D0
> v0) v1 =3D=3D=3D=3D 54+0+558 (1155462804 0 1174924833) 0x7f7a70000db0 con
> 0x7f7a8000e4e0
>   cluster b085fba3-8e17-443c-bb61-7758504538f8
>    health HEALTH_WARN 1 mons down, quorum 0,1,3,4 atom01,atom02,ping,pong
>    monmap e1: 5 mons at {atom01=3D
> 192.168.242.31:6789/0,atom02=3D192.168.242.32:6789/0,nuke36=3D192.168.242=
.36:6789/0,ping=3D192.168.242.92:6789/0,pong=3D192.168.242.93:6789/0},
> election epoch 26, quorum 0,1,3,4 atom01,atom02,ping,pong
>    osdmap e22: 2 osds: 2 up, 2 in
>     pgmap v46761: 1192 pgs: 1192 active+clean; 7806 MB data, 20618 MB
> used, 3702 GB / 3722 GB avail; 9756B/s wr, 0op/s
>    mdsmap e17: 1/1/1 up {0=3Dpong=3Dup:active}, 1 up:standby
>
> 2013-09-04 11:09:56.096071 7f7a8820f700  1 -- 192.168.242.36:0/1016260mar=
k_down 0x7f7a8000e4e0 -- 0x7f7a8000e280
> 2013-09-04 11:09:56.096516 7f7a8820f700  1 -- 192.168.242.36:0/1016260mar=
k_down_all
> 2013-09-04 11:09:56.097065 7f7a8820f700  1 -- 192.168.242.36:0/1016260shu=
tdown complete.
> ------------------
>
> this is the ceph.conf that was generated during ceph-deploy (well I added
> the debug lines obviously)
>
> ------------------
> root@nuke36[/0]:~ # cat /etc/ceph/ceph.conf
> [global]
> fsid =3D b085fba3-8e17-443c-bb61-7758504538f8
> mon_initial_members =3D ping, pong, nuke36, atom01, atom02
> mon_host =3D
> 192.168.242.92,192.168.242.93,192.168.242.36,192.168.242.31,192.168.242.3=
2
> auth_supported =3D cephx
> osd_journal_size =3D 1024
> filestore_xattr_use_omap =3D true
> debug ms =3D 1
> debug mon =3D 20
> ------------------
>
> after a reboot of the node I now find
>
> ------------------
> root@nuke36[/1]:~ # ps ax | egrep ceph
>   855 ?        Ssl    0:00 /usr/bin/ceph-mon --cluster=3Dceph -i nuke36 -=
f
>   856 ?        Ss     0:00 /usr/bin/python /usr/sbin/ceph-create-keys
> --cluster=3Dceph -i nuke36
>  1813 pts/1    R+     0:00 egrep --color=3Dauto ceph
> ------------------
>
> with ceph-create-keys runing infinetly,
> while the key files but already exist
>
> ------------------
> root@nuke36[/1]:~ # ls -lh /etc/ceph/
> total 88K
> -rw-r--r-- 1 root root  72 Aug 30 15:54 ceph.bootstrap-mds.keyring
> -rw-r--r-- 1 root root  72 Aug 30 15:54 ceph.bootstrap-osd.keyring
> -rw------- 1 root root  64 Aug 30 15:54 ceph.client.admin.keyring
> -rw-r--r-- 1 root root 303 Sep  4 10:19 ceph.conf
> -rw-r--r-- 1 root root 59K Sep  3 10:15 ceph.log
> -rw-r--r-- 1 root root  73 Aug 30 15:53 ceph.mon.keyring
> -rw-r--r-- 1 root root  92 Aug 30 00:03 rbdmap
> ------------------
>
> and
>
> ------------------
> root@nuke36[/1]:~ # tree -pfugiAD /var/lib/ceph/
> /var/lib/ceph
> [drwxr-xr-x root     root     Aug 30 15:54]  /var/lib/ceph/bootstrap-mds
> [-rw------- root     root     Aug 30 15:54]
> /var/lib/ceph/bootstrap-mds/ceph.keyring
> [drwxr-xr-x root     root     Aug 30 15:54]  /var/lib/ceph/bootstrap-osd
> [-rw------- root     root     Aug 30 15:54]
> /var/lib/ceph/bootstrap-osd/ceph.keyring
> [drwxr-xr-x root     root     Aug 30  0:00]  /var/lib/ceph/mds
> [drwxr-xr-x root     root     Aug 30 15:53]  /var/lib/ceph/mon
> [drwxr-xr-x root     root     Aug 30 15:53]  /var/lib/ceph/mon/ceph-nuke3=
6
> [-rw-r--r-- root     root     Aug 30 15:53]
> /var/lib/ceph/mon/ceph-nuke36/done
> [-rw-r--r-- root     root     Aug 30 15:53]
> /var/lib/ceph/mon/ceph-nuke36/keyring
> [drwxr-xr-x root     root     Sep  4 11:16]
> /var/lib/ceph/mon/ceph-nuke36/store.db
> [-rw-r--r-- root     root     Sep  3  6:21]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007726.sst
> [-rw-r--r-- root     root     Sep  3  6:21]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007727.sst
> [-rw-r--r-- root     root     Sep  3  6:21]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007728.sst
> [-rw-r--r-- root     root     Sep  3  6:21]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007729.sst
> [-rw-r--r-- root     root     Sep  3  6:21]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007730.sst
> [-rw-r--r-- root     root     Sep  4 10:14]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007767.sst
> [-rw-r--r-- root     root     Sep  4 10:14]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007768.sst
> [-rw-r--r-- root     root     Sep  4 10:14]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007769.sst
> [-rw-r--r-- root     root     Sep  4 10:14]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007770.sst
> [-rw-r--r-- root     root     Sep  4 10:14]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007772.sst
> [-rw-r--r-- root     root     Sep  4 10:14]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007773.sst
> [-rw-r--r-- root     root     Sep  4 10:14]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007774.sst
> [-rw-r--r-- root     root     Sep  4 10:14]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007775.sst
> [-rw-r--r-- root     root     Sep  4 10:18]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007777.sst
> [-rw-r--r-- root     root     Sep  4 10:19]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007780.sst
> [-rw-r--r-- root     root     Sep  4 11:16]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007783.sst
> [-rw-r--r-- root     root     Sep  4 11:16]
> /var/lib/ceph/mon/ceph-nuke36/store.db/007784.log
> [-rw-r--r-- root     root     Sep  4 11:16]
> /var/lib/ceph/mon/ceph-nuke36/store.db/CURRENT
> [-rw-r--r-- root     root     Aug 30 15:53]
> /var/lib/ceph/mon/ceph-nuke36/store.db/LOCK
> [-rw-r--r-- root     root     Sep  4 11:16]
> /var/lib/ceph/mon/ceph-nuke36/store.db/LOG
> [-rw-r--r-- root     root     Sep  4 10:19]
> /var/lib/ceph/mon/ceph-nuke36/store.db/LOG.old
> [-rw-r--r-- root     root     Sep  4 11:16]
> /var/lib/ceph/mon/ceph-nuke36/store.db/MANIFEST-007782
> [-rw-r--r-- root     root     Aug 30 15:53]
> /var/lib/ceph/mon/ceph-nuke36/upstart
> [drwxr-xr-x root     root     Aug 30  0:00]  /var/lib/ceph/osd
> [drwxr-xr-x root     root     Aug 30 15:53]  /var/lib/ceph/tmp
> ------------------
>
> to compare with atom01 which is still running in the cluster...
>
> ------------------
> root@atom01[/0]:~ # tree -pfugiAD /var/lib/ceph/
> /var/lib/ceph
> [drwxr-xr-x root     root     Aug 30 15:54]  /var/lib/ceph/bootstrap-mds
> [-rw------- root     root     Aug 30 15:54]
> /var/lib/ceph/bootstrap-mds/ceph.keyring
> [drwxr-xr-x root     root     Aug 30 15:54]  /var/lib/ceph/bootstrap-osd
> [-rw------- root     root     Aug 30 15:54]
> /var/lib/ceph/bootstrap-osd/ceph.keyring
> [drwxr-xr-x root     root     Aug 30  0:00]  /var/lib/ceph/mds
> [drwxr-xr-x root     root     Aug 30 15:53]  /var/lib/ceph/mon
> [drwxr-xr-x root     root     Aug 30 15:53]  /var/lib/ceph/mon/ceph-atom0=
1
> [-rw-r--r-- root     root     Aug 30 15:53]
> /var/lib/ceph/mon/ceph-atom01/done
> [-rw-r--r-- root     root     Aug 30 15:53]
> /var/lib/ceph/mon/ceph-atom01/keyring
> [drwxr-xr-x root     root     Sep  4 11:18]
> /var/lib/ceph/mon/ceph-atom01/store.db
> [-rw-r--r-- root     root     Sep  4 11:25]
> /var/lib/ceph/mon/ceph-atom01/store.db/006339.log
> [-rw-r--r-- root     root     Sep  4 11:18]
> /var/lib/ceph/mon/ceph-atom01/store.db/006342.sst
> [-rw-r--r-- root     root     Sep  4 11:18]
> /var/lib/ceph/mon/ceph-atom01/store.db/006343.sst
> [-rw-r--r-- root     root     Sep  4 11:18]
> /var/lib/ceph/mon/ceph-atom01/store.db/006344.sst
> [-rw-r--r-- root     root     Sep  4 11:18]
> /var/lib/ceph/mon/ceph-atom01/store.db/006345.sst
> [-rw-r--r-- root     root     Sep  4 11:18]
> /var/lib/ceph/mon/ceph-atom01/store.db/006346.sst
> [-rw-r--r-- root     root     Sep  4 11:18]
> /var/lib/ceph/mon/ceph-atom01/store.db/006347.sst
> [-rw-r--r-- root     root     Sep  4 11:18]
> /var/lib/ceph/mon/ceph-atom01/store.db/006348.sst
> [-rw-r--r-- root     root     Aug 30 15:53]
> /var/lib/ceph/mon/ceph-atom01/store.db/CURRENT
> [-rw-r--r-- root     root     Aug 30 15:53]
> /var/lib/ceph/mon/ceph-atom01/store.db/LOCK
> [-rw-r--r-- root     root     Sep  4 11:18]
> /var/lib/ceph/mon/ceph-atom01/store.db/LOG
> [-rw-r--r-- root     root     Aug 30 15:53]
> /var/lib/ceph/mon/ceph-atom01/store.db/LOG.old
> [-rw-r--r-- root     root     Sep  4 11:18]
> /var/lib/ceph/mon/ceph-atom01/store.db/MANIFEST-000004
> [-rw-r--r-- root     root     Aug 30 15:53]
> /var/lib/ceph/mon/ceph-atom01/upstart
> [drwxr-xr-x root     root     Aug 30  0:00]  /var/lib/ceph/osd
> [drwxr-xr-x root     root     Aug 30 15:53]  /var/lib/ceph/tmp
> ------------------
>
> the problem with ceph-create-keys seemed to have been fixed with wip-4924
> since in that version "rbd create" wouldn't work I switched to
> deb http://gitbuilder.ceph.com/ceph-deb-raring-x86_64-basic/ref/dumpling/
> raring main
> (runing on an uptodate raring)
> I thought of just removing and than re-adding the failing mon but who do =
I
> do that?
> The documentation on
> http://ceph.com/docs/master/rados/operations/add-or-rm-mons/
> says:
> "service ceph -a stop mon.{mon-id}"
>
> ------------------
> root@nuke36[/1]:~ # service ceph -a stop mon.nuke36
> /etc/init.d/ceph: mon.nuke36 not found (/etc/ceph/ceph.conf defines ,
> /var/lib/ceph defines )
> root@nuke36[/1]:~ # service ceph -a stop mon.c
> /etc/init.d/ceph: mon.c not found (/etc/ceph/ceph.conf defines ,
> /var/lib/ceph defines )
> root@nuke36[/1]:~ # service ceph -a stop mon.2
> /etc/init.d/ceph: mon.2 not found (/etc/ceph/ceph.conf defines ,
> /var/lib/ceph defines )
> root@nuke36[/1]:~ # service ceph -a stop mon.ceph-nuke36
> /etc/init.d/ceph: mon.ceph-nuke36 not found (/etc/ceph/ceph.conf defines =
,
> /var/lib/ceph defines )
> ------------------
>
> that doesn't help, manually stopping the daemon doesn't work either
> (respawning, okay)
> but this combination leaves me quite curious
>
> ------------------
> root@atom01[/0]:~ # ceph health detail
> HEALTH_WARN 1 mons down, quorum 0,1,3,4 atom01,atom02,ping,pong
> mon.nuke36 (rank 2) addr 192.168.242.36:6789/0 is down (out of quorum)
> root@atom01[/0]:~ # service ceph -a stop mon.nuke36
> /etc/init.d/ceph: mon.nuke36 not found (/etc/ceph/ceph.conf defines ,
> /var/lib/ceph defines )
> /etc/init.d/ceph: mon.2 not found (/etc/ceph/ceph.conf defines ,
> /var/lib/ceph defines )
> root@atom01[/0]:~ # service ceph -a stop mon.rank2
> ------------------
>
> something seems to be out of sync, at least with the documentation?
> any hint how to proceed from here?
>
> TIA
>
> Bernhard
>
>
> --
>  ------------------------------
>
>   *Bernhard Glomm*
> IT Administration
>
>  Phone:  +49 (30) 86880 134  Fax:  +49 (30) 86880 100  Skype: bernhard.gl=
omm.ecologic
> <http://ecologic.eu> <http://www.youtube.com/v/hZtiK04A9Yo>
> <http://ecologic.eu/newsletter/subscribe>
> <http://www.facebook.com/Ecologic.Institute>
> <http://www.linkedin.com/company/ecologic-institute-berlin-germany>
> <http://twitter.com/EcologicBerlin>
> <http://www.youtube.com/user/EcologicInstitute>
> <http://plus.google.com/113756356645020994482> Ecologic Institut
> gemeinn=FCtzige GmbH | Pfalzburger Str. 43/44 | 10717 Berlin | Germany
> GF: R. Andreas Kraemer | AG: Charlottenburg HRB 57947 | USt/VAT-IdNr.:
> DE811963464
> Ecologic=99 is a Trade Mark (TM) of Ecologic Institut gemeinn=FCtzige Gmb=
H
> ------------------------------
> root@nuke
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <#140e99031b451ae9_>
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
>
> --
>   ------------------------------
>   [image: *Ecologic Institute*]   *Bernhard Glomm*
> IT Administration
>
>    Phone:  +49 (30) 86880 134   Fax:  +49 (30) 86880 100   Skype: bernhar=
d.glomm.ecologic     [image:
> Website:] <http://ecologic.eu> [image: | Video:]<http://www.youtube.com/v=
/hZtiK04A9Yo> [image:
> | Newsletter:] <http://ecologic.eu/newsletter/subscribe> [image: |
> Facebook:] <http://www.facebook.com/Ecologic.Institute> [image: |
> Linkedin:]<http://www.linkedin.com/company/ecologic-institute-berlin-germ=
any> [image:
> | Twitter:] <http://twitter.com/EcologicBerlin> [image: | YouTube:]<http:=
//www.youtube.com/user/EcologicInstitute> [image:
> | Google+:] <http://plus.google.com/113756356645020994482>   Ecologic
> Institut gemeinn=FCtzige GmbH | Pfalzburger Str. 43/44 | 10717 Berlin |
> Germany
> GF: R. Andreas Kraemer | AG: Charlottenburg HRB 57947 | USt/VAT-IdNr.:
> DE811963464
> Ecologic=99 is a Trade Mark (TM) of Ecologic Institut gemeinn=FCtzige Gmb=
H
> ------------------------------
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>

--047d7b472a40102cc504e590fb6c
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Wed, Sep 4, 2013 at 11:21 AM, Bernhard Glomm <span dir=3D"ltr">&=
lt;<a href=3D"mailto:bernhard.glomm-uSuf018nij3sq35pWSNszA@public.gmane.org" target=3D"_blank">bernhard=
.glomm-uSuf018nij3sq35pWSNszA@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>Removing a monitor, also like described=
 in<br><a href=3D"http://ceph.com/docs/master/rados/deployment/ceph-deploy-=
mon/" target=3D"_blank">http://ceph.com/docs/master/rados/deployment/ceph-d=
eploy-mon/</a><br>
doesn&#39;t work<br><br>----------------<br>root@nuke36[/1]:/etc/ceph # cep=
h-deploy mon destroy nuke36<br>[ceph_deploy.mon][DEBUG ] Removing mon from =
nuke36<br>[ceph_deploy.mon][ERROR ] ceph-mon deamon did not stop<br>[ceph_d=
eploy][ERROR ] GenericError: Failed to destroy 1 monitors<br>
----------------<br><br>is this, I can&#39;t destroy the mon on which I run=
 the destroy command?<br>(I could destroy <br>but since I just added anothe=
r two monitors to my cluster,<br>the broken first one is alive again...<br>
</div></blockquote><div><br></div><div>What OS is the nuke36 host?<br><br><=
/div><div>There are a bunch of commands that `mon destroy` will call on the=
 remote host, but unfortunately, this is one of the commands I have not fix=
ed yet to use the new remote logging to tell you.<br>
<br></div><div>Can you try to manually run this on nuke36 and see what is g=
oing on?<br><br></div><div>=A0 =A0 sudo ceph --cluster=3D{cluster name, def=
aults to ceph} -n mon. -k {path to keyring}/keyring mon remove <br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<div><br>well that should do as a work around for now <br>(since I&#39;m us=
ing the dev branch and do only testing stuff)<br>still, would be curious if=
 I could have repaired it any other way.<br><br>Bernhard<br><br>Am 04.09.20=
13 12:40:04, schrieb Bernhard Glomm:<br>
<blockquote>Hi all,<br><br>after some days of successful creating and destr=
oying rbd&#39;s, snapshots,<br>clones and migrating formats all of a sudden=
 one of the monitors doesn&#39;t work anymore.<br>I tried to remove and re-=
add the monitor from the cluster, but that doesn&#39;t seem to work either.=
<br>
<br>Here&#39;s the situation:<br>I liked to use ceph-deploy to initiate the=
 cluster.<br>Due to the broken ceph-create-keys in dumpling I turned to the=
 gitbuilder version<br>now running<br><br>ceph version 0.67.2-23-g24f2669 (=
24f2669783e2eb9d9af5ecbe106efed93366ba63)<br>
on uptodate raring systems<br>All of a sudden the host from which I ran cep=
h-deploy, and which should be one of the <br>5 monitors (from which 2 are a=
lso serving as OSDs) has fallen out of the quorum as you can see here<br>
(yes, time is in sync on all nodes):<br><br>------------------<br>root@nuke=
36[/0]:~ # ceph -s<br>2013-09-04 11:09:56.039547 7f7a8820f700=A0 1 -- :/0 m=
essenger.start<br>2013-09-04 11:09:56.040646 7f7a8820f700=A0 1 -- :/1016260=
 --&gt; <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.=
242.92:6789/0</a> -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f7a8000e8f=
0 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.041304 7f7a84a08700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> learned my =
addr <a href=3D"http://192.168.242.36:0/1016260" target=3D"_blank">192.168.=
242.36:0/1016260</a><br>
2013-09-04 11:09:56.042843 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 1 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 776+0+0 (2241333437 =
0 0) 0x7f7a70000c30 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.043038 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 2 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=3D=3D=
=3D 33+0+0 (2063715990 0 0) 0x7f7a70001060 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.043324 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> --&gt; <a h=
ref=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.242.92:6789/=
0</a> -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0 0x7f7a74001af0 con 0x7f7a=
8000e4e0<br>
2013-09-04 11:09:56.044197 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 3 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=3D=3D=
=3D 206+0+0 (3910749728 0 0) 0x7f7a70001060 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.044375 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> --&gt; <a h=
ref=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.242.92:6789/=
0</a> -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0 0x7f7a740020d0 con 0x7f7=
a8000e4e0<br>
2013-09-04 11:09:56.045376 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 4 =3D=3D=3D=3D auth_reply(proto 2 0 Success) v1 =3D=3D=3D=
=3D 393+0+0 (3802320753 0 0) 0x7f7a700008f0 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.045457 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> --&gt; <a h=
ref=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.242.92:6789/=
0</a> -- mon_subscribe({monmap=3D0+}) v2 -- ?+0 0x7f7a8000ed80 con 0x7f7a80=
00e4e0<br>
2013-09-04 11:09:56.045550 7f7a8820f700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> --&gt; <a h=
ref=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.242.92:6789/=
0</a> -- mon_subscribe({monmap=3D2+,osdmap=3D0}) v2 -- ?+0 0x7f7a800079f0 c=
on 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.045559 7f7a8820f700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> --&gt; <a h=
ref=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.242.92:6789/=
0</a> -- mon_subscribe({monmap=3D2+,osdmap=3D0}) v2 -- ?+0 0x7f7a8000fa10 c=
on 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.046376 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 5 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 776+0+0 (2241333437 =
0 0) 0x7f7a70001290 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.046417 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 6 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0=
+0 (1524320885 0 0) 0x7f7a70001480 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.046429 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 7 =3D=3D=3D=3D osd_map(22..22 src has 1..22) v3 =3D=3D=3D=
=3D 2355+0+0 (11792226 0 0) 0x7f7a70001f70 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.046828 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 8 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0=
+0 (1524320885 0 0) 0x7f7a700008f0 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.046948 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 9 =3D=3D=3D=3D osd_map(22..22 src has 1..22) v3 =3D=3D=3D=
=3D 2355+0+0 (11792226 0 0) 0x7f7a700008c0 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.047071 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 10 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+=
0+0 (1524320885 0 0) 0x7f7a70000df0 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.047547 7f7a8820f700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> --&gt; <a h=
ref=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.242.92:6789/=
0</a> -- mon_command({&quot;prefix&quot;: &quot;get_command_descriptions&qu=
ot;} v 0) v1 -- ?+0 0x7f7a8000b0f0 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.050938 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 11 =3D=3D=3D=3D mon_command_ack([{&quot;prefix&quot;: &quot=
;get_command_descriptions&quot;}]=3D0=A0 v0) v1 =3D=3D=3D=3D 72+0+24040 (10=
92875540 0 2922658865) 0x7f7a700008c0 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.089981 7f7a8820f700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> --&gt; <a h=
ref=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.242.92:6789/=
0</a> -- mon_command({&quot;prefix&quot;: &quot;status&quot;} v 0) v1 -- ?+=
0 0x7f7a8000b0d0 con 0x7f7a8000e4e0<br>
2013-09-04 11:09:56.091348 7f7a86a0c700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> &lt;=3D=3D =
mon.3 <a href=3D"http://192.168.242.92:6789/0" target=3D"_blank">192.168.24=
2.92:6789/0</a> 12 =3D=3D=3D=3D mon_command_ack([{&quot;prefix&quot;: &quot=
;status&quot;}]=3D0=A0 v0) v1 =3D=3D=3D=3D 54+0+558 (1155462804 0 117492483=
3) 0x7f7a70000db0 con 0x7f7a8000e4e0<br>
=A0 cluster b085fba3-8e17-443c-bb61-7758504538f8<br>=A0=A0 health HEALTH_WA=
RN 1 mons down, quorum 0,1,3,4 atom01,atom02,ping,pong<br>=A0=A0 monmap e1:=
 5 mons at {atom01=3D<a href=3D"http://192.168.242.31:6789/0,atom02=3D192.1=
68.242.32:6789/0,nuke36=3D192.168.242.36:6789/0,ping=3D192.168.242.92:6789/=
0,pong=3D192.168.242.93:6789/0" target=3D"_blank">192.168.242.31:6789/0,ato=
m02=3D192.168.242.32:6789/0,nuke36=3D192.168.242.36:6789/0,ping=3D192.168.2=
42.92:6789/0,pong=3D192.168.242.93:6789/0</a>}, election epoch 26, quorum 0=
,1,3,4 atom01,atom02,ping,pong<br>
=A0=A0 osdmap e22: 2 osds: 2 up, 2 in<br>=A0=A0=A0 pgmap v46761: 1192 pgs: =
1192 active+clean; 7806 MB data, 20618 MB used, 3702 GB / 3722 GB avail; 97=
56B/s wr, 0op/s<br>=A0=A0 mdsmap e17: 1/1/1 up {0=3Dpong=3Dup:active}, 1 up=
:standby<br><br>
2013-09-04 11:09:56.096071 7f7a8820f700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> mark_down 0=
x7f7a8000e4e0 -- 0x7f7a8000e280<br>2013-09-04 11:09:56.096516 7f7a8820f700=
=A0 1 -- <a href=3D"http://192.168.242.36:0/1016260" target=3D"_blank">192.=
168.242.36:0/1016260</a> mark_down_all<br>
2013-09-04 11:09:56.097065 7f7a8820f700=A0 1 -- <a href=3D"http://192.168.2=
42.36:0/1016260" target=3D"_blank">192.168.242.36:0/1016260</a> shutdown co=
mplete.<br>------------------<br><br>this is the ceph.conf that was generat=
ed during ceph-deploy (well I added the debug lines obviously)<br>
<br>------------------<br>root@nuke36[/0]:~ # cat /etc/ceph/ceph.conf <br>[=
global]<br>fsid =3D b085fba3-8e17-443c-bb61-7758504538f8<br>mon_initial_mem=
bers =3D ping, pong, nuke36, atom01, atom02<br>mon_host =3D 192.168.242.92,=
192.168.242.93,192.168.242.36,192.168.242.31,192.168.242.32<br>
auth_supported =3D cephx<br>osd_journal_size =3D 1024<br>filestore_xattr_us=
e_omap =3D true<br>debug ms =3D 1<br>debug mon =3D 20<br>------------------=
<br><br>after a reboot of the node I now find<br><br>------------------<br>=
root@nuke36[/1]:~ # ps ax | egrep ceph<br>
=A0 855 ?=A0=A0=A0=A0=A0=A0=A0 Ssl=A0=A0=A0 0:00 /usr/bin/ceph-mon --cluste=
r=3Dceph -i nuke36 -f<br>=A0 856 ?=A0=A0=A0=A0=A0=A0=A0 Ss=A0=A0=A0=A0 0:00=
 /usr/bin/python /usr/sbin/ceph-create-keys --cluster=3Dceph -i nuke36<br>=
=A01813 pts/1=A0=A0=A0 R+=A0=A0=A0=A0 0:00 egrep --color=3Dauto ceph<br>
------------------<br><br>with ceph-create-keys runing infinetly,<br>while =
the key files but already exist<br><br>------------------<br>root@nuke36[/1=
]:~ # ls -lh /etc/ceph/<br>total 88K<br>-rw-r--r-- 1 root root=A0 72 Aug 30=
 15:54 ceph.bootstrap-mds.keyring<br>
-rw-r--r-- 1 root root=A0 72 Aug 30 15:54 ceph.bootstrap-osd.keyring<br>-rw=
------- 1 root root=A0 64 Aug 30 15:54 ceph.client.admin.keyring<br>-rw-r--=
r-- 1 root root 303 Sep=A0 4 10:19 ceph.conf<br>-rw-r--r-- 1 root root 59K =
Sep=A0 3 10:15 ceph.log<br>
-rw-r--r-- 1 root root=A0 73 Aug 30 15:53 ceph.mon.keyring<br>-rw-r--r-- 1 =
root root=A0 92 Aug 30 00:03 rbdmap<br>------------------<br><br>and<br><br=
>------------------<br>root@nuke36[/1]:~ # tree -pfugiAD /var/lib/ceph/<br>
/var/lib/ceph<br>[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:54=
]=A0 /var/lib/ceph/bootstrap-mds<br>[-rw------- root=A0=A0=A0=A0 root=A0=A0=
=A0=A0 Aug 30 15:54]=A0 /var/lib/ceph/bootstrap-mds/ceph.keyring<br>[drwxr-=
xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:54]=A0 /var/lib/ceph/boots=
trap-osd<br>
[-rw------- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:54]=A0 /var/lib/cep=
h/bootstrap-osd/ceph.keyring<br>[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=
=A0 Aug 30=A0 0:00]=A0 /var/lib/ceph/mds<br>[drwxr-xr-x root=A0=A0=A0=A0 ro=
ot=A0=A0=A0=A0 Aug 30 15:53]=A0 /var/lib/ceph/mon<br>
[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:53]=A0 /var/lib/cep=
h/mon/ceph-nuke36<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 1=
5:53]=A0 /var/lib/ceph/mon/ceph-nuke36/done<br>[-rw-r--r-- root=A0=A0=A0=A0=
 root=A0=A0=A0=A0 Aug 30 15:53]=A0 /var/lib/ceph/mon/ceph-nuke36/keyring<br=
>
[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:16]=A0 /var/lib/c=
eph/mon/ceph-nuke36/store.db<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=
=A0 Sep=A0 3=A0 6:21]=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007726.sst<=
br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 3=A0 6:21]=A0 /var/=
lib/ceph/mon/ceph-nuke36/store.db/007727.sst<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 3=A0 6:21]=A0 /var/lib=
/ceph/mon/ceph-nuke36/store.db/007728.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 r=
oot=A0=A0=A0=A0 Sep=A0 3=A0 6:21]=A0 /var/lib/ceph/mon/ceph-nuke36/store.db=
/007729.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 3=A0 6:=
21]=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007730.sst<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 10:14]=A0 /var/lib/c=
eph/mon/ceph-nuke36/store.db/007767.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 roo=
t=A0=A0=A0=A0 Sep=A0 4 10:14]=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007=
768.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 10:14]=A0=
 /var/lib/ceph/mon/ceph-nuke36/store.db/007769.sst<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 10:14]=A0 /var/lib/c=
eph/mon/ceph-nuke36/store.db/007770.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 roo=
t=A0=A0=A0=A0 Sep=A0 4 10:14]=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007=
772.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 10:14]=A0=
 /var/lib/ceph/mon/ceph-nuke36/store.db/007773.sst<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 10:14]=A0 /var/lib/c=
eph/mon/ceph-nuke36/store.db/007774.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 roo=
t=A0=A0=A0=A0 Sep=A0 4 10:14]=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007=
775.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 10:18]=A0=
 /var/lib/ceph/mon/ceph-nuke36/store.db/007777.sst<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 10:19]=A0 /var/lib/c=
eph/mon/ceph-nuke36/store.db/007780.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 roo=
t=A0=A0=A0=A0 Sep=A0 4 11:16]=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/007=
783.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:16]=A0=
 /var/lib/ceph/mon/ceph-nuke36/store.db/007784.log<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:16]=A0 /var/lib/c=
eph/mon/ceph-nuke36/store.db/CURRENT<br>[-rw-r--r-- root=A0=A0=A0=A0 root=
=A0=A0=A0=A0 Aug 30 15:53]=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/LOCK<b=
r>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:16]=A0 /var/lib=
/ceph/mon/ceph-nuke36/store.db/LOG<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 10:19]=A0 /var/lib/c=
eph/mon/ceph-nuke36/store.db/LOG.old<br>[-rw-r--r-- root=A0=A0=A0=A0 root=
=A0=A0=A0=A0 Sep=A0 4 11:16]=A0 /var/lib/ceph/mon/ceph-nuke36/store.db/MANI=
FEST-007782<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:53]=
=A0 /var/lib/ceph/mon/ceph-nuke36/upstart<br>
[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30=A0 0:00]=A0 /var/lib/c=
eph/osd<br>[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:53]=A0 /=
var/lib/ceph/tmp<br>------------------<br><br>to compare with atom01 which =
is still running in the cluster...<br>
<br>------------------<br>root@atom01[/0]:~ # tree -pfugiAD /var/lib/ceph/<=
br>/var/lib/ceph<br>[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15=
:54]=A0 /var/lib/ceph/bootstrap-mds<br>[-rw------- root=A0=A0=A0=A0 root=A0=
=A0=A0=A0 Aug 30 15:54]=A0 /var/lib/ceph/bootstrap-mds/ceph.keyring<br>
[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:54]=A0 /var/lib/cep=
h/bootstrap-osd<br>[-rw------- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:=
54]=A0 /var/lib/ceph/bootstrap-osd/ceph.keyring<br>[drwxr-xr-x root=A0=A0=
=A0=A0 root=A0=A0=A0=A0 Aug 30=A0 0:00]=A0 /var/lib/ceph/mds<br>
[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:53]=A0 /var/lib/cep=
h/mon<br>[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:53]=A0 /va=
r/lib/ceph/mon/ceph-atom01<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0=
 Aug 30 15:53]=A0 /var/lib/ceph/mon/ceph-atom01/done<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:53]=A0 /var/lib/cep=
h/mon/ceph-atom01/keyring<br>[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 =
Sep=A0 4 11:18]=A0 /var/lib/ceph/mon/ceph-atom01/store.db<br>[-rw-r--r-- ro=
ot=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:25]=A0 /var/lib/ceph/mon/ceph-a=
tom01/store.db/006339.log<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:18]=A0 /var/lib/c=
eph/mon/ceph-atom01/store.db/006342.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 roo=
t=A0=A0=A0=A0 Sep=A0 4 11:18]=A0 /var/lib/ceph/mon/ceph-atom01/store.db/006=
343.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:18]=A0=
 /var/lib/ceph/mon/ceph-atom01/store.db/006344.sst<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:18]=A0 /var/lib/c=
eph/mon/ceph-atom01/store.db/006345.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 roo=
t=A0=A0=A0=A0 Sep=A0 4 11:18]=A0 /var/lib/ceph/mon/ceph-atom01/store.db/006=
346.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:18]=A0=
 /var/lib/ceph/mon/ceph-atom01/store.db/006347.sst<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:18]=A0 /var/lib/c=
eph/mon/ceph-atom01/store.db/006348.sst<br>[-rw-r--r-- root=A0=A0=A0=A0 roo=
t=A0=A0=A0=A0 Aug 30 15:53]=A0 /var/lib/ceph/mon/ceph-atom01/store.db/CURRE=
NT<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:53]=A0 /var/l=
ib/ceph/mon/ceph-atom01/store.db/LOCK<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:18]=A0 /var/lib/c=
eph/mon/ceph-atom01/store.db/LOG<br>[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=
=A0=A0 Aug 30 15:53]=A0 /var/lib/ceph/mon/ceph-atom01/store.db/LOG.old<br>[=
-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Sep=A0 4 11:18]=A0 /var/lib/ce=
ph/mon/ceph-atom01/store.db/MANIFEST-000004<br>
[-rw-r--r-- root=A0=A0=A0=A0 root=A0=A0=A0=A0 Aug 30 15:53]=A0 /var/lib/cep=
h/mon/ceph-atom01/upstart<br>[drwxr-xr-x root=A0=A0=A0=A0 root=A0=A0=A0=A0 =
Aug 30=A0 0:00]=A0 /var/lib/ceph/osd<br>[drwxr-xr-x root=A0=A0=A0=A0 root=
=A0=A0=A0=A0 Aug 30 15:53]=A0 /var/lib/ceph/tmp<br>------------------<br>
<br>the problem with ceph-create-keys seemed to have been fixed with wip-49=
24<br>since in that version &quot;rbd create&quot; wouldn&#39;t work I swit=
ched to<br>deb <a href=3D"http://gitbuilder.ceph.com/ceph-deb-raring-x86_64=
-basic/ref/dumpling/" target=3D"_blank">http://gitbuilder.ceph.com/ceph-deb=
-raring-x86_64-basic/ref/dumpling/</a>=A0=A0=A0=A0=A0=A0 raring main<br>
(runing on an uptodate raring)<br>I thought of just removing and than re-ad=
ding the failing mon but who do I do that?<br>The documentation on<br><a hr=
ef=3D"http://ceph.com/docs/master/rados/operations/add-or-rm-mons/" target=
=3D"_blank">http://ceph.com/docs/master/rados/operations/add-or-rm-mons/</a=
><br>
says:<br>&quot;service ceph -a stop mon.{mon-id}&quot;<br><br>-------------=
-----<br>root@nuke36[/1]:~ # service ceph -a stop mon.nuke36<br>/etc/init.d=
/ceph: mon.nuke36 not found (/etc/ceph/ceph.conf defines , /var/lib/ceph de=
fines )<br>
root@nuke36[/1]:~ # service ceph -a stop mon.c<br>/etc/init.d/ceph: mon.c n=
ot found (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )<br>root@nuk=
e36[/1]:~ # service ceph -a stop mon.2<br>/etc/init.d/ceph: mon.2 not found=
 (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )<br>
root@nuke36[/1]:~ # service ceph -a stop mon.ceph-nuke36<br>/etc/init.d/cep=
h: mon.ceph-nuke36 not found (/etc/ceph/ceph.conf defines , /var/lib/ceph d=
efines )<br>------------------<br><br>that doesn&#39;t help, manually stopp=
ing the daemon doesn&#39;t work either (respawning, okay)<br>
but this combination leaves me quite curious<br><br>------------------<br>r=
oot@atom01[/0]:~ # ceph health detail<br>HEALTH_WARN 1 mons down, quorum 0,=
1,3,4 atom01,atom02,ping,pong<br>mon.nuke36 (rank 2) addr <a href=3D"http:/=
/192.168.242.36:6789/0" target=3D"_blank">192.168.242.36:6789/0</a> is down=
 (out of quorum)<br>
root@atom01[/0]:~ # service ceph -a stop mon.nuke36<br>/etc/init.d/ceph: mo=
n.nuke36 not found (/etc/ceph/ceph.conf defines , /var/lib/ceph defines )<b=
r>/etc/init.d/ceph: mon.2 not found (/etc/ceph/ceph.conf defines , /var/lib=
/ceph defines )<br>
root@atom01[/0]:~ # service ceph -a stop mon.rank2<br>------------------<br=
><br>something seems to be out of sync, at least with the documentation?<br=
>any hint how to proceed from here?<br><br>TIA<br><br>Bernhard<br><br><br>
<span>-- <br></span><div style>
  <table border=3D"0" cellpadding=3D"0" cellspacing=3D"5"><tbody><tr><td co=
lspan=3D"2" style=3D"vertical-align:middle;color:#ffffff;text-align:center"=
 align=3D"center">
         <hr style=3D"min-height:2px;background-color:#6f7072;color:#6f7072=
;border-width:0"></td>
    </tr><tr><td style=3D"color:#182983;text-align:center" align=3D"center"=
>
        <br></td>
      <td style=3D"text-align:left;padding-right:10px;white-space:nowrap" a=
lign=3D"left">
        <font color=3D"#000000" face=3D"sans-serif">
          <small>
            <b>Bernhard Glomm</b><br>
            IT Administration<br><br></small>
          <small><small>
            </small></small></font><small><small></small></small></td></tr>=
</tbody></table><small><small><small><small>
                  Phone:
                </small></small>
                <small><small>
                  <a href=3D"tel:%2B49%20%2830%29%2086880%20134" value=3D"+=
493086880134" target=3D"_blank">+49 (30) 86880 134</a>
                </small></small>
              <small><small>
                  Fax:
                </small></small>
                <small><small>
                  <a href=3D"tel:%2B49%20%2830%29%2086880%20100" value=3D"+=
493086880100" target=3D"_blank">+49 (30) 86880 100</a>
                </small></small>
              <small><small>
                  Skype:
                </small></small>
                <small><small>
                  bernhard.glomm.ecologic
                </small></small>
              </small></small>
       =20
     =20
   =20
            <a href=3D"http://ecologic.eu" target=3D"_blank"></a>
            <a href=3D"http://www.youtube.com/v/hZtiK04A9Yo" target=3D"_bla=
nk"></a>
            <a href=3D"http://ecologic.eu/newsletter/subscribe" target=3D"_=
blank"></a>
            <a href=3D"http://www.facebook.com/Ecologic.Institute" target=
=3D"_blank"></a>
            <a href=3D"http://www.linkedin.com/company/ecologic-institute-b=
erlin-germany" target=3D"_blank"></a>
            <a href=3D"http://twitter.com/EcologicBerlin" target=3D"_blank"=
></a>
            <a href=3D"http://www.youtube.com/user/EcologicInstitute" targe=
t=3D"_blank"></a>
            <a href=3D"http://plus.google.com/113756356645020994482" target=
=3D"_blank"></a>
     =20
   =20
        <small><small>
          Ecologic Institut gemeinn=FCtzige GmbH | Pfalzburger Str. 43/44 |=
 10717 Berlin | Germany<br>
          GF: R. Andreas Kraemer | AG: Charlottenburg HRB 57947 | USt/VAT-I=
dNr.: DE811963464<br>
          Ecologic=99 is a Trade Mark (TM) of Ecologic Institut gemeinn=FCt=
zige GmbH
        </small></small>
     =20
   =20
         <hr style=3D"min-height:2px;background-color:#6f7072;color:#6f7072=
;border-width:0">root@nuke<br>
    </div>_______________________________________________<br>ceph-users mai=
ling list<br><a href=3D"#140e99031b451ae9_">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><b=
r><a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote><br><br><br><span>-- <br><div style>
  <table border=3D"0" cellpadding=3D"0" cellspacing=3D"5">
    <tbody><tr>
      <td colspan=3D"2" style=3D"vertical-align:middle;color:#ffffff;text-a=
lign:center" valign=3D"center" align=3D"center">
         <hr style=3D"min-height:2px;background-color:#6f7072;color:#6f7072=
;border-width:0">
      </td>
    </tr>
    <tr>
      <td style=3D"color:#182983;text-align:center" align=3D"center">
        <img alt=3D"*Ecologic Institute*" height=3D"120" width=3D"129">
      </td>
      <td style=3D"text-align:left;padding-right:10px;white-space:nowrap" a=
lign=3D"left">
        <font color=3D"black" face=3D"sans-serif">
          <small>
            <b>Bernhard Glomm</b><br>
            IT Administration<br><br>
          </small>
          <small><small>
            <table border=3D"0" cellpadding=3D"0" cellspacing=3D"0">
              <tbody><tr>
                <td style=3D"white-space:nowrap"><small><small>
                  Phone:
                </small></small></td>
                <td style=3D"padding-left:5px;white-space:nowrap"><small><s=
mall>
                  <a href=3D"tel:%2B49%20%2830%29%2086880%20134" value=3D"+=
493086880134" target=3D"_blank">+49 (30) 86880 134</a>
                </small></small></td>
              </tr>
              <tr>
                <td style=3D"white-space:nowrap"><small><small>
                  Fax:
                </small></small></td>
                <td style=3D"padding-left:5px;white-space:nowrap"><small><s=
mall>
                  <a href=3D"tel:%2B49%20%2830%29%2086880%20100" value=3D"+=
493086880100" target=3D"_blank">+49 (30) 86880 100</a>
                </small></small></td>
              </tr>

              <tr>
                <td style=3D"white-space:nowrap"><small><small>
                  Skype:
                </small></small></td>
                <td style=3D"padding-left:5px;white-space:nowrap"><small><s=
mall>
                  bernhard.glomm.ecologic
                </small></small></td>
              </tr>
            </tbody></table>
          </small></small>
        </font>
      </td>
    </tr>
    <tr>
      <td colspan=3D"2" style=3D"vertical-align:middle;text-align:center;ba=
ckground-color:#6f7072;color:#ffffff;white-space:nowrap" valign=3D"center" =
align=3D"center">
            <a href=3D"http://ecologic.eu" target=3D"_blank"><img title=3D"=
Visit our website" alt=3D"Website:" height=3D"36" width=3D"36"></a>
            <a href=3D"http://www.youtube.com/v/hZtiK04A9Yo" target=3D"_bla=
nk"><img title=3D"Watch our video" alt=3D"| Video:" height=3D"36" width=3D"=
36"></a>
            <a href=3D"http://ecologic.eu/newsletter/subscribe" target=3D"_=
blank"><img title=3D"Subscribe to our newsletter" alt=3D"| Newsletter:" hei=
ght=3D"36" width=3D"36"></a>
            <a href=3D"http://www.facebook.com/Ecologic.Institute" target=
=3D"_blank"><img title=3D"Visit us on Facebook" alt=3D"| Facebook:" height=
=3D"36" width=3D"36"></a>
            <a href=3D"http://www.linkedin.com/company/ecologic-institute-b=
erlin-germany" target=3D"_blank"><img title=3D"Visit us on Linkedin" alt=3D=
"| Linkedin:" height=3D"36" width=3D"36"></a>
            <a href=3D"http://twitter.com/EcologicBerlin" target=3D"_blank"=
><img title=3D"Visit us on Twitter" alt=3D"| Twitter:" height=3D"36" width=
=3D"36"></a>
            <a href=3D"http://www.youtube.com/user/EcologicInstitute" targe=
t=3D"_blank"><img title=3D"Visit us on YouTube" alt=3D"| YouTube:" height=
=3D"36" width=3D"36"></a>
            <a href=3D"http://plus.google.com/113756356645020994482" target=
=3D"_blank"><img title=3D"Visit us on Google+" alt=3D"| Google+:" height=3D=
"36" width=3D"36"></a>
      </td>
    </tr>
    <tr>
      <td colspan=3D"2" style=3D"padding-right:5px;padding-left:5px;vertica=
l-align:middle;text-align:left;white-space:nowrap" valign=3D"center" align=
=3D"left">
        <small><small>
          Ecologic Institut gemeinn=FCtzige GmbH | Pfalzburger Str. 43/44 |=
 10717 Berlin | Germany<br>
          GF: R. Andreas Kraemer | AG: Charlottenburg HRB 57947 | USt/VAT-I=
dNr.: DE811963464<br>
          Ecologic=99 is a Trade Mark (TM) of Ecologic Institut gemeinn=FCt=
zige GmbH
        </small></small>
      </td>
    </tr>
    <tr>
      <td colspan=3D"2" style=3D"vertical-align:middle;color:#ffffff;text-a=
lign:center" valign=3D"center" align=3D"center">
         <hr style=3D"min-height:2px;background-color:#6f7072;color:#6f7072=
;border-width:0">
      </td>
    </tr>
  </tbody></table>
</div></span></div>
<br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br></blockquote></div><br></div></div>

--047d7b472a40102cc504e590fb6c--

--===============0858926144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0858926144==--
