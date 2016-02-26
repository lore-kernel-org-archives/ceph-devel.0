From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Subject: Ceph space amplification ratio with write is more than 2
Date: Fri, 26 Feb 2016 17:46:51 +0000
Message-ID: <99767EA2E27DD44DB4E9F9B9ACA458C0561C4194@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:59367 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324AbcBZRqx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Feb 2016 12:46:53 -0500
Received: from ssiexch-casht2.ssi.samsung.com ([105.128.134.61]) by mx2.ssi.samsung.com with ESMTP id JJIjDyvIENdyVotf for <ceph-devel@vger.kernel.org>; Fri, 26 Feb 2016 09:46:51 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Cepher,
   We recently have tested the Ceph space amplification with filestore =
through  writing data to ramdisk with rados bench. However, we found on=
ly =20
3584 MB was written from rados bench  but totally 8658M(1G of total 9G =
of ramdisk was used for journal) was used in the ramdisk.=20

The totally space amplification is 7658/3584 =3D 2.14. (It is surprisin=
g huge factor)
1. Cluster configuration:
=2E One OSD and one MON  are in the same machine with rados bench. Repl=
ication factor  was set as 1.
=2E ceph version from ceph master 5979c8e34fa2f3d7efa28c29fb90758b3f9f8=
18 (45979c8e34fa2f3d7efa28c29fb90758b3f9f818)
2. Rados command we have been used :
rados bench -p rbd -b 4096 --max-objects 1048576  300 write --no-cleanu=
p
3. ceph cluster configuration:
Please see appendix 1.
4. Results investigation.
Please see appendix 0.
   =20
Could anyone help to explain why  the space amplification with filestor=
e is huge?  Thanks a lot.

Regards,
James

Appendix 0:

ssd@OptiPlex-9020-1:~/src/bluestore$ ceph df
GLOBAL:
=A0=A0=A0 SIZE=A0=A0=A0=A0=A0 AVAIL=A0=A0=A0=A0 RAW USED=A0=A0=A0=A0 %R=
AW USED
=A0=A0=A0 9206M=A0=A0=A0=A0=A0 547M=A0=A0=A0=A0=A0=A0=A0 8658M=A0=A0=A0=
=A0=A0=A0=A0=A0 94.05
POOLS:
=A0=A0 =A0NAME=A0=A0=A0=A0 ID=A0=A0=A0=A0 USED=A0=A0=A0=A0=A0 %USED=A0=A0=
=A0=A0 MAX AVAIL=A0=A0=A0=A0 OBJECTS
=A0=A0=A0 rbd=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0 3584M=A0=A0=A0=A0 38.93=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 547M=A0=A0=A0=A0=A0 917505
ssd@OptiPlex-9020-1:~/src/bluestore$ ceph -s
=A0=A0=A0 cluster a7f64266-0894-4f1e-a635-d0aeaca0e993
=A0=A0=A0=A0 health HEALTH_WARN
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 near full osd(s)
=A0=A0=A0=A0 monmap e1: 1 mons at {localhost=3D127.0.0.1:6789/0}
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 election epoch 3, quorum 0 localhost
=A0=A0=A0=A0 osdmap e7: 1 osds: 1 up, 1 in
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flags sortbitwise
=A0=A0=A0=A0=A0 pgmap v31: 64 pgs, 1 pools, 3584 MB data, 896 kobjects
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8658 MB used, 547 MB / 9206 MB avail
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 64 active+clean
ssd@OptiPlex-9020-1:~/src/bluestore$ df -h
=46ilesystem=A0=A0=A0=A0=A0 Size=A0 Used Avail Use% Mounted on
/dev/sda2=A0=A0=A0=A0=A0=A0 2.7T=A0 1.4T=A0 1.2T=A0 55% /
none=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4.0K=A0=A0=A0=A0 0=A0 4.0K=A0=A0 =
0% /sys/fs/cgroup
udev=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5.9G=A0 4.0K=A0 5.9G=A0=A0 1% /de=
v
tmpfs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.2G=A0 720K=A0 1.2G=A0=A0 1% /run
none=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5.0M=A0=A0=A0=A0 0=A0 5.0M=A0=A0 =
0% /run/lock
none=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5.9G=A0=A0 81M=A0 5.8G=A0=A0 2% /=
run/shm
none=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 100M=A0=A0 20K=A0 100M=A0=A0 1% /=
run/user
/dev/ram1 =A0=A0=A0=A0=A0=A09.0G=A0 8.4G=A0 618M=A0 94% /home/ssd/src/b=
luestore/ceph-deploy/osd/myosddata

Journal size:

-rw-r--r--=A0=A0 1 ssd ssd=A0=A0=A0=A0=A0=A0=A0=A0 37 Feb 25 15:53 ceph=
_fsid
drwxr-xr-x 132 ssd ssd=A0=A0=A0=A0=A0=A0 4096 Feb 25 15:53 current
-rw-r--r--=A0=A0 1 ssd ssd=A0=A0=A0=A0=A0=A0=A0=A0 37 Feb 25 15:53 fsid
-rw-r--r--=A0=A0 1 ssd ssd=A0=A0=A0=A0=A0=A0=A0=A0 21 Feb 25 15:53 magi=
c
-rw-r--r--=A0=A0 1 ssd ssd 1073741824 Feb 25 15:53 myosdjournal
-rw-r--r--=A0=A0 1 ssd ssd=A0=A0=A0=A0=A0=A0=A0=A0=A0 6 Feb 25 15:53 re=
ady
-rw-r--r--=A0=A0 1 ssd ssd=A0=A0=A0=A0=A0=A0=A0=A0=A0 4 Feb 25 15:53 st=
ore_version
-rw-r--r--=A0=A0 1 ssd ssd=A0=A0=A0=A0=A0=A0=A0=A0 53 Feb 25 15:53 supe=
rblock
-rw-r--r--=A0=A0 1 ssd ssd=A0=A0=A0=A0=A0=A0=A0=A0 10 Feb 25 15:53 type
-rw-r--r--=A0=A0 1 ssd ssd=A0=A0=A0=A0=A0=A0=A0=A0=A0 2 Feb 25 15:53 wh=
oami

du -sh
It shows current use 8G.

Appendix 1:
[global]
fsid =3D a7f64266-0894-4f1e-a635-d0aeaca0e993
auth_cluster_required =3D none
auth_service_required =3D none
auth_client_required =3D none
filestore_xattr_use_omap =3D true
filestore_max_sync_interval=3D10
filestore_fd_cache_size =3D 64
filestore_fd_cache_shards =3D 32
filestore_op_threads =3D 6
filestore_queue_max_ops=3D5000
filestore_queue_committing_max_ops=3D5000
journal_max_write_entries=3D1000
journal_queue_max_ops=3D3000
filestore_wbthrottle_enable=3Dfalse
filestore_queue_max_bytes=3D1048576000
filestore_queue_committing_max_bytes=3D1048576000
journal_max_write_bytes=3D1048576000
journal_queue_max_bytes=3D1048576000

osd_journal_size =3D 1024
debug_lockdep =3D 0/0
debug_context =3D 0/0
debug_crush =3D 0/0
debug_buffer =3D 0/0
debug_timer =3D 0/0
debug_filer =3D 0/0
debug_objecter =3D 0/0
debug_rados =3D 0/0
debug_rbd =3D 0/0
debug_journaler =3D 0/0
debug_objectcatcher =3D 0/0
debug_client =3D 0/0
debug_osd =3D 0/0
debug_optracker =3D 0/0
debug_objclass =3D 0/0
debug_filestore =3D 0/0
debug_journal =3D 0/0
debug_ms =3D 0/0
debug_monc =3D 0/0
debug_tp =3D 0/0
debug_auth =3D 0/0
debug_finisher =3D 0/0
debug_heartbeatmap =3D 0/0
debug_perfcounter =3D 0/0
debug_asok =3D 0/0
debug_throttle =3D 0/0
debug_mon =3D 0/0
debug_paxos =3D 0/0
debug_rgw =3D 0/0
debug_newstore =3D 0/0
debug_keyvaluestore =3D 0/0
osd_tracing =3D true
osd_objectstore_tracing =3D true
rados_tracing =3D true
rbd_tracing =3D true
osd_mount_options_xfs =3D rw,noatime,inode64,logbsize=3D256k,delaylog
osd_mkfs_options_xfs =3D -f -i size=3D2048
osd_op_threads =3D 32
objecter_inflight_ops=3D102400
ms_dispatch_throttle_bytes=3D1048576000
objecter_infilght_op_bytes=3D1048576000
osd_mkfs_type =3D xfs
osd_client_message_size_cap =3D 0
osd_client_message_cap =3D 0
osd_enable_op_tracker =3D false
mon_initial_members =3D localhost
mon_host =3D 127.0.0.1
mon data =3D '$CEPH_DEPLOY'/mon/mymondata
mon cluster log file =3D '$CEPH_DEPLOY'/mon/mon.log
keyring=3D'$CEPH_DEPLOY'/ceph.client.admin.keyring
run dir =3D '$CEPH_DEPLOY'/run
[osd.0]
osd data =3D '$CEPH_DEPLOY'/osd/myosddata
osd journal =3D '$CEPH_DEPLOY'/osd/myosddata/myosdjournal
#osd journal =3D '$WORKSPACE'/myosdjournal/myosdjournal
log file =3D '$CEPH_DEPLOY'/osd/osd.log'
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
